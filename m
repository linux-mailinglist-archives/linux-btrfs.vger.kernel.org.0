Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14015AC58E
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Sep 2022 19:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbiIDRCr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 4 Sep 2022 13:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234351AbiIDRCq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 4 Sep 2022 13:02:46 -0400
X-Greylist: delayed 99 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 04 Sep 2022 10:02:46 PDT
Received: from straasha.imrryr.org (straasha.imrryr.org [100.2.39.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136352A40F
        for <linux-btrfs@vger.kernel.org>; Sun,  4 Sep 2022 10:02:45 -0700 (PDT)
Received: by straasha.imrryr.org (Postfix, from userid 1001)
        id 42149106604; Sun,  4 Sep 2022 13:01:05 -0400 (EDT)
Date:   Sun, 4 Sep 2022 13:01:05 -0400
From:   Viktor Dukhovni <btrfs@dukhovni.org>
To:     Linux btrfs <linux-btrfs@vger.kernel.org>
Subject: Fedora 36, grub2, UEFI: booting after adding 2nd disk to root?
Message-ID: <YxTZ0VCbkFkuoHzd@straasha.imrryr.org>
Reply-To: linux-btrfs@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Context:

     Distro: Fedora 36
     Arch: x86_64
     Boot: grub2 + UEFI, GPT 
     Kernel: Linux 5.19.6-200.fc36.x86_64
     Btrfs: btrfs-progs-5.18-1.fc36.x86_64

     Installed on: nvme0n1 (~2TB SSD)
     - GPT first 2048 sectors of disk
     - p1: /boot/efi, vfat 511MB
     - p2: 128GB btrfs /
     - p3: initially free space (ultimately for Postgres)

The system has a second identically partitioned disk: nvme1n1

After installation I naively added nvme1n1p2 to the root btrfs hoping to
extend the root fsit over both disks (not RAID1, just concat or stripe).

    # btrfs device nvme1n1p2 /

expecting this to be handled trasparently.  After a bit more
housekeeping I attempted to reboot the system, and it failed to boot.

I don't have console access (system racked and installed for me by
someone else, will have to wait for hands-on help), but I guessed (it
seems correctly) that splitting the [rb]oot btrfs FS across multiple
devices is not handled automatically at boot time by grub2.

The system is freshly built, and it is perhaps simplest to just
reinstall, but is there a not too painful way to recover it?

More importantly, I am having trouble finding a canonical description of
what steps are needed to correctly configure a multi-device btrfs boot
filesystem.

* Is it possible/best to create such a multi-device btrfs rootfs at Fedora 36
  install time?  Will the installer manage to set up grub2 correctly in
  that case?

* If not, what is the correct way to keep the system bootable after
  adding another device to the root btrfs?

* A secondary question: To split off /home, /var/log and /var/spool into
  separate subvoluments, should these be nested or top-level?  The
  initial state created by the installer was:

      # btrfs subvolume list /
      ID 256 gen 362 top level 5 path root
      ID 257 gen 68 top level 256 path var/lib/portables

      # btrfs subvolume get-default /
      ID 5 (FS_TREE)

      # grep btrfs /etc/fstab
      UUID=... / btrfs   subvol=root,compress=zstd:1 0 0

  Naive attempts to create the subvolumes makes them nested,
  perhaps because I don't have an empty unmounted top-level volume?

* And finally, the free space is intended for a Postgres database
  using most of the space on the two disks.  Would a suitably tuned
  subvolme be a good choice, or would ext4 or xfs be more prudent
  (and performant?).

  It is perhaps simplest to make "p2" span also the free space that
  is currently reserved under p3, and tell btrfs to stripe the disks?

  Alternatively, I could build a separate btrfs over the two "p3"
  partitions.

My Unix experience spans some decades starting with SunOS 3.x, and I
have been using ZFS on FreeBSD for 5+ years, but I am a "btrfs" noob, so
your answers do not need to be "dumbed down", but can't assume knowledge
of "btrfs", and particularly its integration with "grub2", beyond a few
days of reading manpages.

-- 
    Viktor.
