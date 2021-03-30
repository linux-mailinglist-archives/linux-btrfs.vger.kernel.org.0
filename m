Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A1134E289
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Mar 2021 09:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhC3Hsb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Mar 2021 03:48:31 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:52019 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbhC3HsN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Mar 2021 03:48:13 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4F8hQ4067gz1qsk3;
        Tue, 30 Mar 2021 09:48:11 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4F8hQ3119Hz1r1Mv;
        Tue, 30 Mar 2021 09:48:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id aNUKWl9I7bH5; Tue, 30 Mar 2021 09:48:09 +0200 (CEST)
X-Auth-Info: y/ecgtJIqKRiA95jDY43XDk4om5HPTxKgBpP6XjRfCA=
Received: from [10.88.0.186] (dslb-084-056-254-233.084.056.pools.vodafone-ip.de [84.56.254.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 30 Mar 2021 09:48:09 +0200 (CEST)
Subject: Re: btrfs-send format that contains binary diffs
To:     Lionel Bouton <lionel-subscription@bouton.name>,
        Andrei Borzenkov <arvidjaar@gmail.com>,
        linux-btrfs@vger.kernel.org
Cc:     Henning Schild <henning.schild@siemens.com>
References: <f3306b7c-a97a-21f2-0f66-dc94dc2c0272@denx.de>
 <db6fae67-6348-1de3-c953-a4c75c459b65@gmail.com>
 <5ba46b04-f3ba-03ef-6ad5-38fd44f8c67e@denx.de>
 <04d8b3c2-a5a7-abc2-b157-b6a39f6d435c@bouton.name>
From:   Claudius Heine <ch@denx.de>
Organization: Denx Software Engineering
Message-ID: <04a3a921-783c-9227-79a4-7855d46eb31c@denx.de>
Date:   Tue, 30 Mar 2021 09:48:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <04d8b3c2-a5a7-abc2-b157-b6a39f6d435c@bouton.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Lionel,

On 2021-03-29 21:53, Lionel Bouton wrote:
> Hi Claudius,
> 
> Le 29/03/2021 à 21:14, Claudius Heine a écrit :
>> [...]
>> Are you sure?
>>
>> I did a test with a 32MiB random file. I created one snapshot, then
>> changed (not deleted or added) one byte in that file and then created
>> a snapshot again. `btrfs send` created a >32MiB `btrfs-stream` file.
>> If it would be only block based, then I would have expected that it
>> would just contain the changed block, not the whole file.
> 
> I suspect there is another possible explanations : the tool you used to
> change one byte actually rewrote the whole file.
> 
> You can test this by appending data to your file (for example with "cat
> otherfile >> originalfile" or "dd if=/dev/urandom of=originalfile bs=1M
> count=4 conv=notrunc oflag=append") and checking the size of `btrfs
> send`'s output.
> 
> When I append data with dd as described above to a 32M file originally
> created with "dd if=/dev/urandom of=originalfile bs=1M count=32" I get a
> file with 1 extent only in each snapshot both marked shared and a little
> other 4M in `btrfs send`'s output.
> filefrag -v should tell you if the extents in your file are shared.
> 
> Note that if you use compression and your files compress well they will
> use small extents (128kB from memory), this can be bad when you try to
> avoid fragmentation but could help COW find more data to share if I
> understand how COW works in respect to extents correctly.
> 
> Finally, using "dd if=/dev/urandom of=originalfile bs=1M count=1
> conv=notrunc seek=12M" to write in the middle of my now 36M file results
> in a little over 1M with `btrfs send` using -p <previous snapshot>
> And filefrag -v shows 3 extents for this file. 2 of them share the same
> logical offsets than the file in the previous snapshot, the last use a
> new range, confirming the allocation of a new extent and reuse of the
> previous ones.
> This seems to confirm my hypothesis that the tool you used did rewrite
> the whole file.

Yes, I think you are right here. I will have to experiment with this a 
bit further. Thanks!

regards,
Claudius
