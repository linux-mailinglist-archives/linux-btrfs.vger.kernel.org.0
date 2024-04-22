Return-Path: <linux-btrfs+bounces-4469-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D31D8AC44C
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Apr 2024 08:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53DEF282F49
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Apr 2024 06:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C061481CD;
	Mon, 22 Apr 2024 06:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nakato.io header.i=@nakato.io header.b="KNh58GPP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NEyDMk7h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A2E481DD
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Apr 2024 06:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713767865; cv=none; b=pRq9/A8BoeTS6g627QUnoDMFuZZ5B9wPYHiQhmNG9mM588rGqo3TlV/lrGlC7cS2gOb2z5aSy+goBEFVa5wljX3hhM89o+e6sy5aZ8DM5IrnEDeM2BdD/Ywws8yX0fGQC2hlVxSp9i41vxvR8DKw1mNwk/iuu+AMXUTVuIOqEL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713767865; c=relaxed/simple;
	bh=xCMw2b/qsnzgtW52rvusqhrjRJCshGM7Lo9E5rMk3IQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZIxXEzKTeVUnxkYnhxYEmkOwPn5p8mv+O95XMu0WVcOI/PCf2wEzoTdndJcKgRfBkEAt8wgp9itlMLAtBe/GfbkwXsQIlRbsW0fbhAePQEgZwxoNxRJaaw25PiMwcIqdSIzsfenurXeeQsFsgX93v4A77KAQPYJLgIFI5oqOVuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nakato.io; spf=pass smtp.mailfrom=nakato.io; dkim=pass (2048-bit key) header.d=nakato.io header.i=@nakato.io header.b=KNh58GPP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NEyDMk7h; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nakato.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nakato.io
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 615BC1380147;
	Mon, 22 Apr 2024 02:37:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 22 Apr 2024 02:37:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nakato.io; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1713767862; x=1713854262; bh=pw
	OWE9gReTnppCZLPM3jYDGSvTZsxc0MEp1vcFyaBqI=; b=KNh58GPP4CoB2xAV0T
	k7aTTlD4m4/59a/YkDWu3UcFUgTA4B7msaFnU2ef8Dn18IyNgHpONOycUt2PQsbU
	nZ5eDw+1fBcYe6JGn2YsPA3fw4ua82FUnUap8WVaObV59L6mf60LY2zpUoGLpHG4
	Ejuf7OI5mnxbH6F5piaUI+KkbAXQkpwjKMAWAn6gLiC4HnrrLkdzgEST+ztorbE5
	u5kViMQuLow7OwarsQwlPo4csrUWK0y+un0O32fYgF6QSKQIO8Du3WB2Puy3JSlU
	ZyqowFwIwymDwAz+F1hpjU9yu4ZMvofZemV+WeWsJPCobDSYqnImRyfFbmaMgm4n
	K1Kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1713767862; x=1713854262; bh=pwOWE9gReTnpp
	CZLPM3jYDGSvTZsxc0MEp1vcFyaBqI=; b=NEyDMk7h04A/4Qfkbb7GEKq1c4qjt
	NeKjla5ZqSHcKp4gRA7LXS478P431njibOeET9zC3A3Ofv+SCv3gbsHeezr4jHi4
	moPZohr6ad4R524hnBTyPYdAiijy1LU4j+N2Ec1UhAK1DYIE2eCFmKs97CCxUz6p
	U/0C+yD1XS2K8ThyX/LC56RXUNiWWW+31kXGtp4J3S9FCBN2hZoNI4I290zPLXbt
	1zUhwZhdJthkn6HgEHntoGiU6FJI1WRwHqMg1OTT2siFO2Yo1R9sY4kPRMsRd3js
	ovY32kKTrIdjEXqsQr/jAeWRl6aJYC3UGHygf8+h8Rn+ptmPy+oRl7pQg==
X-ME-Sender: <xms:tgUmZq8HjJH6xh3MexJiitYySlckx2ujcU-Kqwg8-JOA-CGMH78lrQ>
    <xme:tgUmZqub0OZ5r4Z17OmmSLHy_nj2rTYt6ZG_4g84-o9ELoeHFbjYX9KFta-zZ2Zs-
    9VJxiCHR1kHA3NM1A>
X-ME-Received: <xmr:tgUmZgBCsnWTHrwLVdblZSqzmUKuGcMQZUKkFuaYjnMK-QoxItt052W8S3vMVnwUQ44aEV8sEvgf1EndoPtn4zGW-78_nlJPLMyvq2Qom-0NtDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekkedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkggfgtgesthfure
    dttddtjeenucfhrhhomhepufgrtghhihcumfhinhhguceonhgrkhgrthhosehnrghkrght
    ohdrihhoqeenucggtffrrghtthgvrhhnpeektedtgfeuvdelleejueduvedvkeejffetvd
    ejtdetledvhffghefhgfetkeetgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehnrghkrghtohesnhgrkhgrthhordhioh
X-ME-Proxy: <xmx:tgUmZieGFWG8EP02nLFMf4mGS7PnV2LjgEYrD5tUDrCMRLLjyTOb5w>
    <xmx:tgUmZvPs6GZi20Of-Xz8wZ0Hhnx09JtfWcJOIh3dTdTaMw7lMRwNkA>
    <xmx:tgUmZsnR-cBUzYe9inYWm_k1auHPt6hFv695Aloe8z-fGVUgecUstQ>
    <xmx:tgUmZht6wsJNEvNXaqqxInEHFOX0rEe8VzYH1WozC6AXJ4LPs5zmOA>
    <xmx:tgUmZkoRwaTNUeV2SmZ6iClXLL2I8KAPcXTz_wHInUxydxXxSVJyAo6t>
Feedback-ID: ic8e14276:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Apr 2024 02:37:40 -0400 (EDT)
From: Sachi King <nakato@nakato.io>
To: u-boot@lists.denx.de
Cc: kabel@kernel.org, wqu@suse.com, linux-btrfs@vger.kernel.org
Subject: BTRFS use-after-free bug at free_extent_buffer_internal
Date: Mon, 22 Apr 2024 16:37:36 +1000
Message-ID: <3281192.oiGErgHkdL@youmu>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi,

I've hit a bug with u-boot on my BTRFS filesystem, and I'm fairly certain
it's a bug and not a corruption issue.

A bit of history on the filesystem.  It is a fairly new filesystem as it was
being used to give me access to test a wayland application on a
Raspberry Pi.  The filesystem was about 3 days old when I hit the bug, and
I'm fairly certain it never had an unclean shutdown.  I have checked the
filesystem with "btrfs check" which has found no errors.  The filesystem
mounts on Linux and is functional.

> # btrfs check --check-data-csum /dev/sda2                
> Opening filesystem to check...
> Checking filesystem on /dev/sda2
> UUID: 18db6211-ac36-42c1-a22f-5e15e1486e0d
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space tree
> [4/7] checking fs roots
> [5/7] checking csums against data
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 5070573568 bytes used, no error found
> total csum bytes: 4451620
> total tree bytes: 370458624
> total fs tree bytes: 353124352
> total extent tree bytes: 10010624
> btree space waste bytes: 62303284
> file data blocks allocated: 6786519040
>  referenced 6328619008


I've made an image of the filesystem so I could reproduce the bug in an
environment that doesn't require the physical SBC, and have reproduced
the issue using the head of the master branch with "qemu-x86_64_defconfig".

My testing qemu was produced with the following:
> # make qemu-x86_64_defconfig
> # cat << EOF >> .config
> CONFIG_AUTOBOOT=y
> CONFIG_BOOTDELAY=1
> CONFIG_USE_BOOTCOMMAND=y
> CONFIG_BOOTSTD_DEFAULTS=y
> CONFIG_BOOTSTD_FULL=y
> CONFIG_CMD_BOOTFLOW_FULL=y
> CONFIG_BOOTCOMMAND="bootflow scan -lb"
> CONFIG_ENV_IS_NOWHERE=y
> CONFIG_LZ4=y
> CONFIG_BZIP2=y
> CONFIG_ZSTD=y
> CONFIG_FS_BTRFS=y
> CONFIG_CMD_BTRFS=y
> CONFIG_GZIP=y
> CONFIG_DEVICE_TREE_INCLUDES="bootstd.dtsi"
> EOF
> # make -j24

bootstd.dtsi is placed at "arch/x86/dts/bootstd.dtsi" and contains:
> / {
>         bootstd {
>                 compatible = "u-boot,boot-std";
>                 filename-prefixes = "/@boot/", "/boot/", "/";
>                 bootdev-order = "scsi";
>                 extlinux {
>                         compatible = "u-boot,extlinux";
>                 };
>         };
> };


The VM was run with
> qemu-system-x86_64 -bios u-boot.rom -nographic -M q35 -action reboot=shutdown -drive file=/mnt/dbg/u-boot-debug.img

The error message I recive on boot is
> BUG at fs/btrfs/extent-io.c:629/free_extent_buffer_internal()!
> BUG!
> resetting ...


I added a print statement to free_extent_buffer_internal that prints the
start address of the extent_buffer as I'm not sure what to be looking for
here.  This print statement is before the decrement.
> printf("free_extent_buffer_internal: eb->start[%llx] eb->refs[%i]\n", eb->start, eb->refs);

The last message before the crash reported eb->start to be "0", with 0 refs.
> free_extent_buffer_internal: eb->start[0] eb->refs[0]

The extent at 0 struck me as odd, so I tried commenting out the freeing, by
removing the call to free_extent_buffer_final, and this resulted in bootflow
succeeding and showing me the boot menu, which suprised me.
I expected to see the bug reproduce itself, with refs being zero, but eb->start
pointing somewhere valid, but I instead got a valid address with refs at 2.

I'm assuming that the order free_extent_buffer_internal is called is
deterministic, so by counting the print outputs the line that prior held
the extent_buffer with a 0 start was replaced with:
> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]

Interestingly, as can be seen in the full logs with my included print
messages, 249c000 is being used just before this, with a ref count of
2.  249c000 does appear to reach a point where it should have been freed
in the past, before it gets used again as seen in both logs.

The failing boot log:
> U-Boot SPL 2024.04-00949-g1dd659fd62-dirty (Apr 22 2024 - 11:32:37 +1000)
> Trying to boot from SPI
> Jumping to 64-bit U-Boot: Note many features are missing
> 
> 
> U-Boot 2024.04-00949-g1dd659fd62-dirty (Apr 22 2024 - 11:32:37 +1000)
> 
> CPU:   QEMU Virtual CPU version 2.5+
> DRAM:  128 MiB
> Core:  13 devices, 13 uclasses, devicetree: separate
> Loading Environment from nowhere... OK
> Model: QEMU x86 (I440FX)
> Net:   e1000: 00:00:00:00:00:00
>        
> Error: e1000#0 No valid MAC address found.
>       eth_initialize() No ethernet found.
> 
> 
> Hit any key to stop autoboot:  0 
> Scanning for bootflows in all bootdevs
> Seq  Method       State   Uclass    Part  Name                      Filename
> ---  -----------  ------  --------  ----  ------------------------  ----------------
> scanning bus for devices...
> Target spinup took 0 ms.
> SATA link 1 timeout.
> Target spinup took 0 ms.
> SATA link 3 timeout.
> SATA link 4 timeout.
> SATA link 5 timeout.
> AHCI 0001.0000 32 slots 6 ports 1.5 Gbps 0x3f impl SATA mode
> flags: 64bit ncq only 
> free_extent_buffer_internal: eb->start[10000] eb->refs[1]
> free_extent_buffer_internal: eb->start[1548000] eb->refs[1]
> free_extent_buffer_internal: eb->start[150c000] eb->refs[1]
> free_extent_buffer_internal: eb->start[154c000] eb->refs[1]
> free_extent_buffer_internal: eb->start[1544000] eb->refs[2]
> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
> free_extent_buffer_internal: eb->start[2490000] eb->refs[1]
> free_extent_buffer_internal: eb->start[6de0000] eb->refs[1]
> free_extent_buffer_internal: eb->start[28f4000] eb->refs[1]
> free_extent_buffer_internal: eb->start[1544000] eb->refs[1]
>   Device 0: (0:0) Vendor: ATA Prod.: QEMU HARDDISK Rev: 2.5+
>             Type: Hard Disk
>             Capacity: 58680.0 MB = 57.3 GB (120176640 x 512)
> timeout exit!
> Scanning bootdev 'ahci_scsi.id0lun0.bootdev':
> free_extent_buffer_internal: eb->start[10000] eb->refs[1]
> free_extent_buffer_internal: eb->start[1548000] eb->refs[1]
> free_extent_buffer_internal: eb->start[150c000] eb->refs[1]
> free_extent_buffer_internal: eb->start[154c000] eb->refs[1]
> free_extent_buffer_internal: eb->start[1544000] eb->refs[2]
> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
> free_extent_buffer_internal: eb->start[2490000] eb->refs[2]
> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
> free_extent_buffer_internal: eb->start[24a0000] eb->refs[1]
> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
> free_extent_buffer_internal: eb->start[24a0000] eb->refs[1]
> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
> free_extent_buffer_internal: eb->start[24a4000] eb->refs[1]
> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
> free_extent_buffer_internal: eb->start[2490000] eb->refs[1]
> free_extent_buffer_internal: eb->start[249c000] eb->refs[1]
> free_extent_buffer_internal: eb->start[6de0000] eb->refs[1]
> free_extent_buffer_internal: eb->start[28f4000] eb->refs[1]
> free_extent_buffer_internal: eb->start[1544000] eb->refs[1]
> free_extent_buffer_internal: eb->start[10000] eb->refs[1]
> free_extent_buffer_internal: eb->start[1548000] eb->refs[1]
> free_extent_buffer_internal: eb->start[150c000] eb->refs[1]
> free_extent_buffer_internal: eb->start[154c000] eb->refs[1]
> free_extent_buffer_internal: eb->start[1544000] eb->refs[2]
> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
> free_extent_buffer_internal: eb->start[2490000] eb->refs[2]
> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
> free_extent_buffer_internal: eb->start[24a0000] eb->refs[1]
> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
> free_extent_buffer_internal: eb->start[24a0000] eb->refs[1]
> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
> free_extent_buffer_internal: eb->start[2490000] eb->refs[2]
> free_extent_buffer_internal: eb->start[24a0000] eb->refs[1]
> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
> free_extent_buffer_internal: eb->start[24a0000] eb->refs[1]
> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
> free_extent_buffer_internal: eb->start[24a4000] eb->refs[1]
> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
> free_extent_buffer_internal: eb->start[24a4000] eb->refs[1]
> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
> free_extent_buffer_internal: eb->start[24a4000] eb->refs[1]
> free_extent_buffer_internal: eb->start[0] eb->refs[0]
> BUG at fs/btrfs/extent-io.c:626/free_extent_buffer_internal()!
> BUG!
> resetting ...

The succeeding log with the removed freeing:
> U-Boot SPL 2024.04-00949-g1dd659fd62-dirty (Apr 22 2024 - 11:38:25 +1000)
> Trying to boot from SPI
> Jumping to 64-bit U-Boot: Note many features are missing
> 
> 
> U-Boot 2024.04-00949-g1dd659fd62-dirty (Apr 22 2024 - 11:38:25 +1000)
> 
> CPU:   QEMU Virtual CPU version 2.5+
> DRAM:  128 MiB
> Core:  13 devices, 13 uclasses, devicetree: separate
> Loading Environment from nowhere... OK
> Model: QEMU x86 (I440FX)
> Net:   e1000: 00:00:00:00:00:00
>        
> Error: e1000#0 No valid MAC address found.
>       eth_initialize() No ethernet found.
> 
> 
> Hit any key to stop autoboot:  0 
> Scanning for bootflows in all bootdevs
> Seq  Method       State   Uclass    Part  Name                      Filename
> ---  -----------  ------  --------  ----  ------------------------  ----------------
> scanning bus for devices...
> Target spinup took 0 ms.
> SATA link 1 timeout.
> Target spinup took 0 ms.
> SATA link 3 timeout.
> SATA link 4 timeout.
> SATA link 5 timeout.
> AHCI 0001.0000 32 slots 6 ports 1.5 Gbps 0x3f impl SATA mode
> flags: 64bit ncq only 
> free_extent_buffer_internal: eb->start[10000] eb->refs[1]
> free_extent_buffer_internal: eb->start[1548000] eb->refs[1]
> free_extent_buffer_internal: eb->start[150c000] eb->refs[1]
> free_extent_buffer_internal: eb->start[154c000] eb->refs[1]
> free_extent_buffer_internal: eb->start[1544000] eb->refs[2]
> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
> free_extent_buffer_internal: eb->start[2490000] eb->refs[1]
> free_extent_buffer_internal: eb->start[6de0000] eb->refs[1]
> free_extent_buffer_internal: eb->start[28f4000] eb->refs[1]
> free_extent_buffer_internal: eb->start[1544000] eb->refs[1]
>   Device 0: (0:0) Vendor: ATA Prod.: QEMU HARDDISK Rev: 2.5+
>             Type: Hard Disk
>             Capacity: 58680.0 MB = 57.3 GB (120176640 x 512)
> timeout exit!
> Scanning bootdev 'ahci_scsi.id0lun0.bootdev':
> free_extent_buffer_internal: eb->start[10000] eb->refs[1]
> free_extent_buffer_internal: eb->start[1548000] eb->refs[1]
> free_extent_buffer_internal: eb->start[150c000] eb->refs[1]
> free_extent_buffer_internal: eb->start[154c000] eb->refs[1]
> free_extent_buffer_internal: eb->start[1544000] eb->refs[2]
> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
> free_extent_buffer_internal: eb->start[2490000] eb->refs[2]
> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
> free_extent_buffer_internal: eb->start[24a0000] eb->refs[1]
> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
> free_extent_buffer_internal: eb->start[24a0000] eb->refs[1]
> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
> free_extent_buffer_internal: eb->start[24a4000] eb->refs[1]
> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
> free_extent_buffer_internal: eb->start[2490000] eb->refs[1]
> free_extent_buffer_internal: eb->start[249c000] eb->refs[1]
> free_extent_buffer_internal: eb->start[6de0000] eb->refs[1]
> free_extent_buffer_internal: eb->start[28f4000] eb->refs[1]
> free_extent_buffer_internal: eb->start[1544000] eb->refs[1]
> free_extent_buffer_internal: eb->start[10000] eb->refs[1]
> free_extent_buffer_internal: eb->start[1548000] eb->refs[1]
> free_extent_buffer_internal: eb->start[150c000] eb->refs[1]
> free_extent_buffer_internal: eb->start[154c000] eb->refs[1]
> free_extent_buffer_internal: eb->start[1544000] eb->refs[2]
> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
> free_extent_buffer_internal: eb->start[2490000] eb->refs[2]
> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
> free_extent_buffer_internal: eb->start[24a0000] eb->refs[1]
> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
> free_extent_buffer_internal: eb->start[24a0000] eb->refs[1]
> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
> free_extent_buffer_internal: eb->start[2490000] eb->refs[2]
> free_extent_buffer_internal: eb->start[24a0000] eb->refs[1]
> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
> free_extent_buffer_internal: eb->start[24a0000] eb->refs[1]
> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
> free_extent_buffer_internal: eb->start[24a4000] eb->refs[1]
> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
> free_extent_buffer_internal: eb->start[24a4000] eb->refs[1]
> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
> free_extent_buffer_internal: eb->start[24a4000] eb->refs[1]
> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
> free_extent_buffer_internal: eb->start[2490000] eb->refs[1]
> free_extent_buffer_internal: eb->start[6de0000] eb->refs[1]
> free_extent_buffer_internal: eb->start[28f4000] eb->refs[1]
> free_extent_buffer_internal: eb->start[1544000] eb->refs[1]
>   0  extlinux     ready   scsi         2  ahci_scsi.id0lun0.bootdev /@boot/extlinux/extlinux.conf
> ** Booting bootflow 'ahci_scsi.id0lun0.bootdev.part_2' with extlinux
> ------------------------------------------------------------
> 1:      NixOS - Default
> 2:      NixOS - Configuration 5 (2024-03-04 11:00 - 24.05.20240205.faf912b)
> 3:      NixOS - Configuration 4 (2024-03-02 15:05 - 24.05.20240205.faf912b)
> 4:      NixOS - Configuration 3 (2024-03-02 14:26 - 24.05.20240205.faf912b)
> 5:      NixOS - Configuration 2 (2024-03-02 14:06 - 24.05.20240205.faf912b)
> 6:      NixOS - Configuration 1 (1970-01-01 10:00 - 24.05.20240205.faf912b)
> Enter choice: 1:        NixOS - Default
> Retrieving file: /@boot/extlinux/../nixos/gq8jsgxnhq2wvsjrni3cjw1wb5540wjw-linux-6.1.63-stable_20231123-Image
> free_extent_buffer_internal: eb->start[10000] eb->refs[1]


I'm not sure where to go from here with the bug, so I'm hoping for some
help in tracking it down so it can be fixed.

Thanks,
Sachi



