Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2CF55AC68E
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Sep 2022 23:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiIDU7l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 4 Sep 2022 16:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiIDU7j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 4 Sep 2022 16:59:39 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D7DDF2D
        for <linux-btrfs@vger.kernel.org>; Sun,  4 Sep 2022 13:59:38 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id BB84B5C00B1
        for <linux-btrfs@vger.kernel.org>; Sun,  4 Sep 2022 16:59:35 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Sun, 04 Sep 2022 16:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1662325175; x=
        1662411575; bh=hPvHIpfniG3Wfd7pDAjFnYf9QI6fhfAX23GSa/s5shI=; b=g
        jg5g7yYMkdm3i4QZymeR44gNqMClaMYx2xbKaEe6puJBtYUQvrThaz1IALwe+tcx
        Qt/dcA8creVNtDdn0r8mC9ehxDfpahvVzKq+S6gfAvVqNbU9Eb3FSwsfMiAu7B7b
        km48KD0ERiuXkIle7NR6/lOq18ch+jNDIUYfXrwzpfg/PXi3ls2phiV8i8lLYDYO
        iBOZGsERgmUfHHWJiBeSFFPIi15DYkPmS+tiuuHw0RXhNn8mV5VXsvZhGY3g9l/r
        7cB7+ay2ahnPPjV+fq3FmxPQBq2EfJ7/WqpudxliJDNCuEJPSHZsplW9LS0w5uWd
        UjJne0bNmBqkTvplIxinQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1662325175; x=1662411575; bh=hPvHIpfniG3Wfd7pDAjFnYf9QI6f
        hfAX23GSa/s5shI=; b=TvKVzzu64b7wtpRsZJe8HhqIfoPEdboIJnN7vcBVyy4e
        iK6E2oltaBVgWkwILTqNZueKM2i+VgQzvKwzTnqqMx1y28tSCg1Z1vvTQe/c34m2
        Adsf7LiitFKOQhF7M5sJLbVtP8XkJ4E9pgnoTYv4BMEDfYM9o0kZ+XJtjkT1LuMj
        9FMm189dBEDFGIlwhgKoWGIEnBMJVaYfslZV02Z0xzCLkDowWse7TLbdE+ALV1mN
        xlE2NboJEdzDJ5iAkjYsB22oEAIL41cwCar0AwPh0Q09iloZpB/iAL7Xn7eB3SvM
        15cL2Xv8t02GDtCGW6O71dTvdCxwpOXdu+h8u1YhAg==
X-ME-Sender: <xms:txEVY_MzdLrsugM2gWU6AuOjGwpIwREbtuFPHkA-Jf5KQyzigqfuSw>
    <xme:txEVY5-MILCNa8ffXeaSzx70WXq_k0U6d4XDl-lL7fc3MOL2z2EXAVEPtpmC60wUf
    hV0eYBwB7jzul0TH6I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdelgedgudehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfvehh
    rhhishcuofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeduheeiveeutefghfekteekleevffeuledtjedvjeev
    vedvgefgfefhgedvudegueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhm
X-ME-Proxy: <xmx:txEVY-QRJ7jIXHo1E-x_W1Cz-4mAoL1t96XauE81PH27tRksowbMbg>
    <xmx:txEVYzviyP25H_7QJgaQKwfsEnSPxgpqq-WRJiuAUdIvM1XETczJRA>
    <xmx:txEVY3cZcX7tV4AgEyb3ds26xArHwqNiWZ8B1jTCLI-llkbA_TKEFw>
    <xmx:txEVYxoKrjBOqYlNGKgm1G2QIoDrMVSn5LKnjAAZtVg1ns5eQHCTSA>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7AE611700082; Sun,  4 Sep 2022 16:59:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <5929d570-f387-4fa3-a246-bb7dabefdfb3@www.fastmail.com>
In-Reply-To: <YxTZ0VCbkFkuoHzd@straasha.imrryr.org>
References: <YxTZ0VCbkFkuoHzd@straasha.imrryr.org>
Date:   Sun, 04 Sep 2022 16:59:12 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: Re: Fedora 36, grub2, UEFI: booting after adding 2nd disk to root?
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On Sun, Sep 4, 2022, at 1:01 PM, Viktor Dukhovni wrote:
> Context:
>
>      Distro: Fedora 36
>      Arch: x86_64
>      Boot: grub2 + UEFI, GPT 
>      Kernel: Linux 5.19.6-200.fc36.x86_64
>      Btrfs: btrfs-progs-5.18-1.fc36.x86_64
>
>      Installed on: nvme0n1 (~2TB SSD)
>      - GPT first 2048 sectors of disk
>      - p1: /boot/efi, vfat 511MB
>      - p2: 128GB btrfs /
>      - p3: initially free space (ultimately for Postgres)
>
> The system has a second identically partitioned disk: nvme1n1
>
> After installation I naively added nvme1n1p2 to the root btrfs hoping to
> extend the root fsit over both disks (not RAID1, just concat or stripe).
>
>     # btrfs device nvme1n1p2 /


# btrfs device add /dev/nvme1n1p2 /

?


>
> expecting this to be handled trasparently.  After a bit more
> housekeeping I attempted to reboot the system, and it failed to boot.

What does happen? What's the last moment of normal boot and the first unexpected messages of the failure?

i.e. do you see a GRUB menu? What happens if you edit the boot entry, remove "rhgb quiet" and add "rd.shell" then booth (F12 or Control-X)?

If that fails, try the same steps with the GRUB entry that has the word "rescue" in the name, i.e. remove rhgb quiet and add rd.shell.


> I don't have console access (system racked and installed for me by
> someone else, will have to wait for hands-on help), but I guessed (it
> seems correctly) that splitting the [rb]oot btrfs FS across multiple
> devices is not handled automatically at boot time by grub2.

GRUB can read btrfs multiple device pools fine. I'm a little suspicious that maybe the NVMe drives use different drivers (?) and one of the kernel drivers isn't in the (older) initramfs, therefore it doesn't show up at the same time as the original NVMe drive. Since this 2nd drive is now required to mount the file system, udev is waiting indefinitely for the drive to appear. That module might be in the "rescue" boot entry, which is not really a special kernel but it's a "no host-only" initramfs created by dracut -N, so it might have the kernel module.

If it boots, then all you need to do is recreate the initramfs for all the kernel entries. e.g.

dracut -f /boot/initramfs-5.19.4-200.fc36.x86_64.img 5.19.4-200.fc36.x86_64

For each kernel version you have installed.


> More importantly, I am having trouble finding a canonical description of
> what steps are needed to correctly configure a multi-device btrfs boot
> filesystem.
>
> * Is it possible/best to create such a multi-device btrfs rootfs at Fedora 36
>   install time?  Will the installer manage to set up grub2 correctly in
>   that case?

You can do it at installation time if you choose both drives for installation. Using the default "automatic" partitioning option, the installer will do a default mkfs.btrfs on the two NVMe partitions, resulting in single profile data, and raid1 profile for metadata. You'd need to use Custom partitioning to choose raid1 for data, but it sounds like you don't want that anyway so you can just do an automatic installation with both drives selected.

The GRUB configuration should be the same as with a single drive, all GRUB does is look for an fs UUID. And both drives have the same fs UUID. The GRUB btrfs module knows how to find additional devices for the same file system.


> * If not, what is the correct way to keep the system bootable after
>   adding another device to the root btrfs?

It's a guess that this is related to initramfs. I'm not sure what else it could be.


>
> * A secondary question: To split off /home, /var/log and /var/spool into
>   separate subvoluments, should these be nested or top-level?  

Anaconda creates subvolumes in the top-level of the file system anytime you create explicit mount-points in the Custom or Advanced-Custom partitioning UI. And they follow a simple / becomes _ naming system so it'll be var_log and var_spool for the subvolume names.


>The
>   initial state created by the installer was:
>
>       # btrfs subvolume list /
>       ID 256 gen 362 top level 5 path root
>       ID 257 gen 68 top level 256 path var/lib/portables

/var/lib/portables and /var/lib/machines are created by systemd, not the installer


>   Naive attempts to create the subvolumes makes them nested,
>   perhaps because I don't have an empty unmounted top-level volume?

To do this manually, you need to mount the btrfs file system, e.g. at /mnt, without any mount options. It'll have its top-level mounted, and you'll see the subvolumes in /mnt, looking like they're directories.

Not that all Btrfs mounts are effectively bind mounts. You can mount a Btrfs file system multiple times *with the same kernel* (just to disambiguate from the rare and fatal case of mounting a Btrfs file system with a host and guest VM kernel).


> * And finally, the free space is intended for a Postgres database
>   using most of the space on the two disks.  Would a suitably tuned
>   subvolme be a good choice, or would ext4 or xfs be more prudent
>   (and performant?).

It really depends on the workload of the database. How big is it, how busy is it, is it compressible? Etc. You might find the performance is OK if you enable WAL, and the workload isn't significant. Also, this is on NVMe drives, which tend to have such low latency that you may not notice any sub-optimal performance issues. Also, other databases work OK or even quite well on Btrfs, e.g. sqlite is pretty OK, and RocksDB is great. Postgresql just has a write pattern that I guess isn't great on Btrfs. The only way to know is to bench mark your workload with various configurations and see what works best or at least what works well enough you don't notice a problem.


>
>   It is perhaps simplest to make "p2" span also the free space that
>   is currently reserved under p3, and tell btrfs to stripe the disks?

Btrfs will let you do that but there's no performance advantage of striping across partitions on the same physical drive.


-- 
Chris Murphy
