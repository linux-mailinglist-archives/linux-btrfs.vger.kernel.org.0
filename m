Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D6834D8C3
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Mar 2021 22:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhC2UCt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Mar 2021 16:02:49 -0400
Received: from ns.bouton.name ([109.74.195.142]:51232 "EHLO mail.bouton.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230298AbhC2UCm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Mar 2021 16:02:42 -0400
X-Greylist: delayed 534 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Mar 2021 16:02:41 EDT
Received: from [192.168.0.39] (82-65-239-81.subs.proxad.net [82.65.239.81])
        by mail.bouton.name (Postfix) with ESMTP id E5858B84C;
        Mon, 29 Mar 2021 21:53:46 +0200 (CEST)
Subject: Re: btrfs-send format that contains binary diffs
To:     Claudius Heine <ch@denx.de>,
        Andrei Borzenkov <arvidjaar@gmail.com>,
        linux-btrfs@vger.kernel.org
Cc:     Henning Schild <henning.schild@siemens.com>
References: <f3306b7c-a97a-21f2-0f66-dc94dc2c0272@denx.de>
 <db6fae67-6348-1de3-c953-a4c75c459b65@gmail.com>
 <5ba46b04-f3ba-03ef-6ad5-38fd44f8c67e@denx.de>
From:   Lionel Bouton <lionel-subscription@bouton.name>
Message-ID: <04d8b3c2-a5a7-abc2-b157-b6a39f6d435c@bouton.name>
Date:   Mon, 29 Mar 2021 21:53:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <5ba46b04-f3ba-03ef-6ad5-38fd44f8c67e@denx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Claudius,

Le 29/03/2021 à 21:14, Claudius Heine a écrit :
> [...]
> Are you sure?
>
> I did a test with a 32MiB random file. I created one snapshot, then
> changed (not deleted or added) one byte in that file and then created
> a snapshot again. `btrfs send` created a >32MiB `btrfs-stream` file.
> If it would be only block based, then I would have expected that it
> would just contain the changed block, not the whole file.

I suspect there is another possible explanations : the tool you used to
change one byte actually rewrote the whole file.

You can test this by appending data to your file (for example with "cat
otherfile >> originalfile" or "dd if=/dev/urandom of=originalfile bs=1M
count=4 conv=notrunc oflag=append") and checking the size of `btrfs
send`'s output.

When I append data with dd as described above to a 32M file originally
created with "dd if=/dev/urandom of=originalfile bs=1M count=32" I get a
file with 1 extent only in each snapshot both marked shared and a little
other 4M in `btrfs send`'s output.
filefrag -v should tell you if the extents in your file are shared.

Note that if you use compression and your files compress well they will
use small extents (128kB from memory), this can be bad when you try to
avoid fragmentation but could help COW find more data to share if I
understand how COW works in respect to extents correctly.

Finally, using "dd if=/dev/urandom of=originalfile bs=1M count=1
conv=notrunc seek=12M" to write in the middle of my now 36M file results
in a little over 1M with `btrfs send` using -p <previous snapshot>
And filefrag -v shows 3 extents for this file. 2 of them share the same
logical offsets than the file in the previous snapshot, the last use a
new range, confirming the allocation of a new extent and reuse of the
previous ones.
This seems to confirm my hypothesis that the tool you used did rewrite
the whole file.

Another possibility would be that COW is disabled, either by a mount
option or a file attribute (see lsattr's output for your file).

Best regards,

Lionel

