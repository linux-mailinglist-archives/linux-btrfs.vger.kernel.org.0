Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CE9517FC4
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 May 2022 10:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbiECIfp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 May 2022 04:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbiECIfn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 May 2022 04:35:43 -0400
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092243334C
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 01:32:08 -0700 (PDT)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1nlnx0-0006rD-JC
        for linux-btrfs@vger.kernel.org; Tue, 03 May 2022 09:32:06 +0100
Date:   Tue, 3 May 2022 09:32:06 +0100
From:   Hugo Mills <hugo@carfax.org.uk>
To:     linux-btrfs@vger.kernel.org
Subject: Re: cannot mount btrfs root partition
Message-ID: <20220503083206.GI15632@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        linux-btrfs@vger.kernel.org
References: <20220503102001.271842da4933a043ba106d92@lucassen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503102001.271842da4933a043ba106d92@lucassen.org>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 03, 2022 at 10:20:01AM +0200, richard lucassen wrote:
> Hello list,
> 
> New to btrfs, I try to load a btrfs / filesystem WITHOUT initrd but it
> ends up in a kernel panic. I run lilo, boot from /dev/md0.
> md1: swap,
> md2: / filesystem
> sda6/sdb6: btrfs raid1

   Generally speaking, if you have a multi-device FS as your /, you
*really* should have an initramfs. In order to mount the FS, the
kernel needs to know which devices contain which parts of which
filesystem. The tool for doing this, "btrfs dev scan", runs in
userspace, so you have to have a userspace available before you can
mount /. This is what an initramfs is.

   In theory, it's possible to use a mount option to specify the
devices explicitly, but in practice, that's heavily dependent on the
device enumeration order, and can change at any time (between one
kernel version and another; or even simply between one boot and
another). I would strongly recommend against using it, for that
reason.

   Hugo.

> When booting the system on the old md2 root fs, the btrfs raid1 mounts
> in /mnt/data/ without problems. Everyting seems to be ok:
> 
> # btrfs filesystem show
> Label: 'data'  uuid: 3173a224-830f-41d7-8870-3db0e8c986c9
>         Total devices 2 FS bytes used 1020.38MiB
>         devid    1 size 187.32GiB used 2.01GiB path /dev/sda6
>         devid    2 size 187.32GiB used 2.01GiB path /dev/sdb6
> 
> It works like a charm. But when I tell lilo to use
> either /dev/sda6, /dev/sdb6 or the UUID, it ends up in a kernel panic.
> 
> Here's some config:
> 
> Vanilla kernel 5.10.113
> 
> $ grep BTRFS .config
> CONFIG_BTRFS_FS=y
> CONFIG_BTRFS_FS_POSIX_ACL=y
> # CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
> # CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
> # CONFIG_BTRFS_DEBUG is not set
> # CONFIG_BTRFS_ASSERT is not set
> # CONFIG_BTRFS_FS_REF_VERIFY is not set
> 
> lilo stanza:
> 
> image=/boot/vmlinuz-5.10.113-apu1
>         label=btrfs
>         read-only
>         root=/dev/sdb6
>         append="console=ttyS0,115200n8"
> 
> BTRFS: device label data devid 1 transid 19 /dev/root scanned \
>   by swapper/0 (1)
> BTRFS info (device sda6): flagging fs with big metadata feature
> BTRFS info (device sda6): disk space caching is enabled
> BTRFS info (device sda6): has skinny extents
> BTRFS error (device sdb6): devid 1 uuid \
>  d201a08f-84ab-42e1-a411-83caadd1df2d is missing
> BTRFS error (device sdb6): failed to read the system array: -2 
> BTRFS error (device sdb6): open_ctree failed
> 
> # blkid /dev/sda6
> /dev/sda6: LABEL="data" UUID="3173a224-830f-41d7-8870-3db0e8c986c9"
> UUID_SUB="d201a08f-84ab-42e1-a411-83caadd1df2d" BLOCK_SIZE="4096"
> TYPE="btrfs" PARTUUID="e0829fd9-06"
> 
> # blkid /dev/sdb6
> /dev/sdb6: LABEL="data" UUID="3173a224-830f-41d7-8870-3db0e8c986c9"
> UUID_SUB="e660257e-740b-4d92-8996-97ba86cbb812" BLOCK_SIZE="4096"
> TYPE="btrfs" PARTUUID="748c2646-06"
> 
> Finally, I see this:
> 
> No filesystem could mount root,
> tried:
> ext3
> ext4
> ext2
> vfat
> msdos
> btrfs
> 
> So, btrfs is a built-in fs, the boot process tries the btrfs fs, but is
> not able to read it.
> 
> As said before, I'm new to btrfs and I'm a bit puzzeled now. I'd rather
> do not use an initrd. It smells a bit like what's happening in the 7
> year old bug: https://bugs.archlinux.org/task/42884
> 
> I also tried to boot from a single btrfs partition (no raid1 config) on
> a separate disk, but no way.
> 
> Can anyone shine a light on this?
> 
> R.
> 

-- 
Hugo Mills             | emacs: Emacs Makes A Computer Slow.
hugo@... carfax.org.uk |
http://carfax.org.uk/  |
PGP: E2AB1DE4          |
