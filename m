Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68367407D18
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Sep 2021 13:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbhILL6b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Sep 2021 07:58:31 -0400
Received: from mail.linuxsystems.it ([79.7.78.67]:56643 "EHLO
        mail.linuxsystems.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbhILL63 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Sep 2021 07:58:29 -0400
Received: by mail.linuxsystems.it (Postfix, from userid 33)
        id E6B57210244; Sun, 12 Sep 2021 13:41:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxsystems.it;
        s=linuxsystems.it; t=1631446888;
        bh=QXGj6a8bIk500SLI77MVaZh12Zjqet7/Q5ttQotFKrg=;
        h=To:Subject:Date:From:Cc:In-Reply-To:References:From;
        b=V0AzTkCrGgg8uy1w/JTeF8xSttUkQO8WFFGQzu+hm5it17zn++JO8vBdXCjDiN1/c
         i6ucYICEtyO/00nmxgqRfAwOez/LGLF6OoC3gH7vyrGd2KY27j5GCyOR9JSrouNgtv
         VxMaYifvb26w7WP/cPZ8AU6geJp6P/vlx5A9iNJM=
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Unmountable / uncheckable Fedora 34 btrfs: failed to read block  groups: -5 open_ctree failed
X-PHP-Originating-Script: 0:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 12 Sep 2021 07:41:28 -0400
From:   =?UTF-8?Q?Niccol=C3=B2_Belli?= <darkbasic@linuxsystems.it>
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <22ac9237-68dd-5bc3-71e1-6a4a32427852@gmx.com>
References: <0303d1f618b815714fe62a6eb90f55ca@linuxsystems.it>
 <22ac9237-68dd-5bc3-71e1-6a4a32427852@gmx.com>
Message-ID: <7163096f475d3c31d7513c22277ad00f@linuxsystems.it>
X-Sender: darkbasic@linuxsystems.it
User-Agent: Roundcube Webmail/1.1.5
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Il 2021-09-12 07:14 Qu Wenruo ha scritto:
> No, it's already in the upstream, in v5.11.
> 
> Just a different name, "rescue=ibadroots" or "rescue=ignorebadroots".
> And it get enhanced to handle the exact case you're hitting, in v5.14.
> 
> 
> So please try first using "rescue=ibadroots" (need to be mounted with
> RO), then check your fs.

$ sudo mount -o ro,rescue=ibadroots /dev/nvme0n1p6 /mnt/
mount: /mnt: wrong fs type, bad option, bad superblock on 
/dev/nvme0n1p6, missing codepage or helper program, or other error.

$ btrfs --version
btrfs-progs v5.14

$ uname -a
Linux localhost-live 5.14.0-60.fc35.x86_64 #1 SMP Mon Aug 30 16:45:32 
UTC 2021 x86_64 x86_64 x86_64 GNU/Linux

[10496.832659] BTRFS info (device nvme0n1p6): ignoring bad roots
[10496.832663] BTRFS info (device nvme0n1p6): disk space caching is 
enabled
[10496.832664] BTRFS info (device nvme0n1p6): has skinny extents
[10496.845607] BTRFS warning (device nvme0n1p6): checksum verify failed 
on 21348679680 wanted 0xd05bf9be found 0x2874489b level 1
[10496.845616] BTRFS error (device nvme0n1p6): failed to read block 
groups: -5
[10496.846085] BTRFS error (device nvme0n1p6): open_ctree failed

Before doing so I restored a previous dd copy of the partition since you 
said that chunk-recover could have been somewhat dangerous.
