Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 408EC1B5D01
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Apr 2020 15:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgDWN5p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Apr 2020 09:57:45 -0400
Received: from zaphod.cobb.me.uk ([213.138.97.131]:49406 "EHLO
        zaphod.cobb.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbgDWN5o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Apr 2020 09:57:44 -0400
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 5A23B9C3CB; Thu, 23 Apr 2020 14:57:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1587650258;
        bh=8Ntzt/t4sO91fe6qTSIkwOuBb94Sa0XQNYESL37bOoY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ElQYzUmqs8R2sIUmisb80qlW8dD1WeHK2e9zY8roJ9WIrC3WEKTWP2nBpWt8TH58a
         9GQyRizng9BLMcdsBxvAOBqSWW6Ui9RC9DAles9fb74wRmkidy13DJ5Ftw78JY5bgS
         BTwwIsIyf2MNH5jsJguBQuCDb/KCNdKWyprTmUY8TyJbcaPSltDR5leLP0vkQLmpAY
         ybH58WzqVJRX1FUyUsl/H7+Rb4TcHH0MTVVyXLk7Mor+Z5rJiuJ3YxfrcVrVc0B1z9
         KBzIcRHVs6yztGl6IEQ3sGh7AilzoPSzdclaLLu1iv6GWPbrl8s2HA3cM+dWBe2oN/
         HBYZHebvFXMGw==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-0.8 required=12.0 tests=ALL_TRUSTED,DKIM_INVALID,
        DKIM_SIGNED,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id ED9259BBB7;
        Thu, 23 Apr 2020 14:57:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1587650255;
        bh=8Ntzt/t4sO91fe6qTSIkwOuBb94Sa0XQNYESL37bOoY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RZrl2+pQrJd+Uc/Melevy03onmkcEJf+4KHiGoJUugrdFkvAQ/6dLvsPwts75vNWw
         2jXFV0SOY6skzHlEKZ0qqqLO8jEl4VyJGNwZNiiJrdzJhcQHJUyiJ1mZV30SsZUjaD
         mkzCTFzXM+mR23ybewKeEEwaYqC5SkTLrt3G0d/BHWPAE4KRIG4P8rps29iRhvTlBC
         4eyyf2lNE3Vpoj+2UBd40tGBV4GRy+1VZks/+o3kolysLckztP74b8mv7SYugxEQ4k
         oRCK42C9AzNFnilm5MowIf9GjqbCfbfCuv/o+XgTJY2YDmr3ljhhYeMt91lz4nnJY0
         Vz0MBEvIYEQTw==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id A646AF3979;
        Thu, 23 Apr 2020 14:57:34 +0100 (BST)
Subject: Re: Recommended Partitioning & Subvolume Layout | Newbie Question
To:     Stefanie Leisestreichler 
        <stefanie.leisestreichler@peter-speer.de>,
        Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <03fdc397-4fca-335f-03d8-f93a96d92105@peter-speer.de>
 <CAJCQCtTnA6Dro2XwEm0S7ohUnf_CMGb7giHsBfh4_KtWE4vR6g@mail.gmail.com>
 <7019baf9-5064-4d16-a09a-5dc5672672de@peter-speer.de>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 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 myxb
Message-ID: <af3bc48a-4752-345e-e245-828c27b1d5fe@cobb.uk.net>
Date:   Thu, 23 Apr 2020 14:57:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <7019baf9-5064-4d16-a09a-5dc5672672de@peter-speer.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 23/04/2020 10:39, Stefanie Leisestreichler wrote:
> On 22.04.20 23:03, Chris Murphy wrote:
>> What's the gotcha? Well, my /var has been rolled back, and also the
>> systemd journal. OK so I could make /var/lib/libvirt and /var/log
>> subvolumes so they don't get snapshot and rolled back. What I tend to
>> do is put those in the top level of the file system, and have fstab
>> entries to mount them to the proper location during startup, that way
>> I don't have to worry about manually fixing things on a rollback.
> 
> Thanks for your time and answer.
> 
> I tend to lean on the fedora layout as far as my limited knowledge
> allows to calculate the impacts so far :-(
> 
> I do not understand what is meant by the statement:> What I tend to do
> is put those in the top level of the file system
> 
> I guess the storage for the snapshots is meant. So if I understand right
> you have a directory /snapshots in the dir tree where they will be
> stored. I know about the fact that a nested subvolume (subvolume in
> another subvolume) will not get snapshotted. But it is not clear to me
> if you are using this fact in your layout (make i.e. /var/log a separate
> subvolume) or not. Also it is not clear to me, why you put the snapshots
> in the top level of your filesystem.

I can't speak for Chris, who is much more experienced than I am. But
what I do (for all my btrfs filesystems, not just the root disk) is that
in the top level directory of the filesystem I only put subvolumes. No
files or ordinary directories. Those subvolumes are then mounted into
the correct places in the filesystem. The top level is mounted somewhere
else for maintenance activities.

So, for example, take my root disk. I create the filesystem, mount it
somewhere temporarily (let's say it is on /mnt/rootdisk) and create
subvoumes for /mnt/rootdisk/rootfs and /mnt/rootdisk/varfs. I also set
rootfs to be the default subvolume that is mounted if no subvolume is
specified.

I can then mount the filesystem somewhere else (say /mnt/newroot) by
mounting the rootfs subvolume, creating var as a directory and mounting
the varfs subvolume into that. That can then be installed in the normal way.

In the fstab on the new filesystem, I have entries like (leaving out
unimportant stuff):

LABEL=root / btrfs defaults,noatime,nodiratime
LABEL=root /var btrfs defaults,noatime,nodiratime,subvol=/varfs
LABEL=root /mnt/rootdisk btrfs defaults,noatime,nodiratime,subvolid=5

So, the result is that the root and /var appear set up as normal but the
actual filesystem toplevel directory is mounted at /mnt/rootdisk. This
is really useful if you want to be able to (temporarily or permanently)
replace one of those subvolumes with a different snapshot.

I do the same for data disks (so the top level is mounted at
/mnt/datadisk, the homefs subvolume is mounted at /home, the fred
subvolume is mounted at /home/fred, etc).

