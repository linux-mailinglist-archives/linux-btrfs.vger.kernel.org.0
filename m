Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12EEA88C8D
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Aug 2019 19:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbfHJRxt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 10 Aug 2019 13:53:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:43772 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726055AbfHJRxs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 10 Aug 2019 13:53:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 450BFAB92;
        Sat, 10 Aug 2019 17:53:47 +0000 (UTC)
Subject: Re: Mount failure with 5.2.7 but mounts with 5.1.4
To:     Peter Chant <pete@petezilla.co.uk>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <13654030-d9c5-ad3f-283e-16e6ef6c7bcf@petezilla.co.uk>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <99aea610-72f0-a213-a5b4-d30d799cc390@suse.com>
Date:   Sat, 10 Aug 2019 20:53:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <13654030-d9c5-ad3f-283e-16e6ef6c7bcf@petezilla.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10.08.19 г. 18:54 ч., Peter Chant wrote:
> I attempted update an i5 machine today with kernel 5.2.7.  Unfortunately
> I could not mount the file system.  However, reverting the kernel back
> to 5.1.4 allowed it to mount with no issue.
> 
> This issue is not critical to me, machine boots with older kernel, I
> have a backup and the machine is only lightly used anyway.  However, I
> wonder whether this info is useful to anyone?
> 
> I have a spare ext4 root partition on the hard drive of the affected
> machine, so I booted to that, with 5.2.7, and got the following behaviour.
> 
> dmesg:
> 
> [   55.139154] BTRFS: device fsid 5128caf4-b518-4b65-ae46-b5505281e500
> devid 1 transid 66785 /dev/sda4
> [   55.139623] BTRFS info (device sda4): disk space caching is enabled
> [   55.813959] BTRFS critical (device sda4): corrupt leaf: root=5
> block=38884884480 slot=1 ino=45745394, invalid inode generation: has
> 18446744073709551492 expect [0, 66786]

It seems you have triggered one of the enhanced checks. Looks like the
generation (i.e transaction id) of inode 45745394 seems to be larger
than the inode of the super block. This doesn't make sense. Looking at
the number of this inode it seems to have overflown.


A possible work around will be to copy the file that this inode
describes and delete the original(corrupted one) then your fs should be
mountable on the newer kernel.

> [   55.817296] BTRFS error (device sda4): block=38884884480 read time
> tree block corruption detected
> [   55.817342] BTRFS warning (device sda4): failed to read fs tree: -5
> [   55.834802] BTRFS error (device sda4): open_ctree failed
> 
> /var/log/messages:
> Aug 10 11:59:05 retreat dbus[903]: [system] Activating service
> name='org.freedesktop.PolicyKit1' (using servicehelper)
> Aug 10 11:59:05 retreat polkitd[975]: started daemon version 0.105 using
> authority implementation `local' version `0.105'
> Aug 10 11:59:05 retreat dbus[903]: [system] Successfully activated
> service 'org.freedesktop.PolicyKit1'
> Aug 10 11:59:31 retreat kernel: [   55.139154] BTRFS: device fsid
> 5128caf4-b518-4b65-ae46-b5505281e500 devid 1 transid 66785 /dev/sda4
> Aug 10 11:59:31 retreat kernel: [   55.139623] BTRFS info (device sda4):
> disk space caching is enabled
> 
> uname -a:
> Linux retreat 5.2.7 #1 SMP Wed Aug 7 23:53:42 BST 2019 x86_64 Intel(R)
> Core(TM) i5-4430 CPU @ 3.00GHz GenuineIntel GNU/Linux
> 
> Rebooting with 5.1.4 showed no problems.
> 
> 
> A very similar kernel, with AMD rather than Intel processor options, is
> running on the Ryzen machine I am typing this on.  I did have my hdd
> file system seem to hang, but not sure if that is related.
> 
> I have not tried the intel kernel on my laptop, but the laptop is a lot
> older, as it is a core2duo.
> 
> Seems a bit odd to me that 5.2.7 should show such an issue but 5.1.4 be
> OK with it.
> 
> Pete
> 
> 
