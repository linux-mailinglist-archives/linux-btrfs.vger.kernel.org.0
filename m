Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93AFA31C7BD
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Feb 2021 10:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbhBPJFP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Feb 2021 04:05:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:47314 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229635AbhBPJDy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Feb 2021 04:03:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613466178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=8IcGJNiNFjP+yvPNcsy2HJCB4ED4OC7TLLGaQ9fM/kM=;
        b=D+uzMqbmqx88l53VKpHdoD6AM05wgUfep1PZ/5B9pKBY16Exbygu/YPHja6eTXqzoq4Djb
        5eV6jlLsTlrZd2uDn+734rJQysefllVw9xrIK3CcT7xYtWyqUYwvA1+YpAdBGz4YWEVi5p
        c/u1bOldqmnpIGvFVeXLROYLrGw7/Xg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D4DA7AD29;
        Tue, 16 Feb 2021 09:02:58 +0000 (UTC)
Subject: Re: performance recommendations
To:     "Pal, Laszlo" <vlad@vlad.hu>
Cc:     linux-btrfs@vger.kernel.org
References: <CAFTxqD_-OiGjA3EEycKwKGteYPmA6OjPhMxce8f1w8Ly=wd2pg@mail.gmail.com>
 <e70bbe98-f6dc-9eaa-8506-cd356a1c2ed8@suse.com>
 <CAFTxqD9E2egJ22MorzXPAHaNDKg5QoEBK=Cd4ChOdT6Odiy6Rg@mail.gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b311ab52-86f7-1e7d-c0b6-15b2d050e62c@suse.com>
Date:   Tue, 16 Feb 2021 11:02:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFTxqD9E2egJ22MorzXPAHaNDKg5QoEBK=Cd4ChOdT6Odiy6Rg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 16.02.21 г. 10:54 ч., Pal, Laszlo wrote:
> Thank you all for the quick response. The server is running, but as I
> said the i/o perf. is not as good as it should be. I'm also thinking
> the fragmentation is the issue but I also would like to optimise my
> config and if possible keep this server running with acceptable
> performance, so let me answer the questions below
> 
> So, as far as I see the action plan is the following
> - enable v2 space_cache. is this safe/stable enough?
> - run defrag on old data, I suppose it will run weeks, but I'm ok with
> it if the server can run smoothly during this process
> - compress=zstd is the recommended mount option? is this performing
> better than the default?
> - I'm also thinking to -after defrag- compress my logs with
> traditional gzip compression and turn off on-the-fly compress (is this
> a huge performance gain?)
> 
> Any other suggestions?
> 
> Thank you
> Laszlo
> ---
> 
> uname -a
> 3.10.0-1160.6.1.el7.x86_64 #1 SMP Tue Nov 17 13:59:11 UTC 2020 x86_64
> x86_64 x86_64 GNU/Linux

Ok, first of all this is a vendor kernel, most likely CentOS or
something like that. I have no idea what is the state of btrfs in this
kernel as such any statements that regarding stability of particular
feature are essentially invalid as I can only base my answers on
upstream kernels or on SUSE-derived kernels.

Given this my suggestion is for you to try and upgrade to a recent
upstream kernel. The latest is best, if you prefer stability you can try
some of the older (4.4/4.14/4.19/5.4) kernels. But you can expect btrfs
to have best performance with the latest stable which is 5.10.x at the
moment.



Bear in mind that btrfs is in active development so between 3.10 and the
current upstream - 5.10 there has been _a lot_ of changes whiich result
in better performance as well as fixed bugs.

> 
>   btrfs --version
>   btrfs-progs v4.9.1
> 

<snip>

> how much memory
> 48 GB RAM
> 
> type and model of hard disk
> virtualized Fujitsu RAID on esxi
> 
> is it raid
> yes, the underlying virtualization provides redundancy, no sw RAID
> 
> Kernel version
> 3.10.0-1160.6.1.el7.x86_64
> 
> your btrfs mount options probably in /etc/fstab
> UUID=7017204b-1582-4b4e-ad04-9e55212c7d46 /
> btrfs   defaults,noatime,autodefrag,subvol=root     0 0
> UUID=7017204b-1582-4b4e-ad04-9e55212c7d46 /var
> btrfs   defaults,subvol=var,noatime,autodefrag      0 0
> 
> size of log files
> 4,5TB on /var
> 
> have you snapshots
> no
> 
> have you tries tools like dedup remover
> not yet
> 
> things you do
> 
> 1. Kernel update LTS kernel has been updated to 5.10 (maybe you have
> to install it manually, because centos will be dropped -> reboot
> maybe you have to remove your mount point in fstab and boot into
> system and mount it later manually.
> Is this absolutely necessary?
> 
> 2. set mount options in fstab
>     defaults,autodefrag,space_cache=v2,compress=zstd (autodefrag only on HDD)
>     defaults,ssd,space_cache=v2,compress=zstd (for ssd)
> 
>   autodefrag is already enabled. v2 space_cache is safe enough?
> 
> 3. sudo btrfs scrub start /dev/sda (use your device)
>     watch sudo btrfs scrub status /dev/sda (watch and wait until finished)
> 
> 4. sudo btrfs device stats /dev/sda (your disk)
> 
> 5.install smartmontools
>    run sudo smartctl -x /dev/sda (use your disk)
>    check
> I think this is not applicable because this is a virtual disk,

<snip>
