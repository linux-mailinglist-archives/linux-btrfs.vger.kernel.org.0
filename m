Return-Path: <linux-btrfs+bounces-16086-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3FDB28751
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Aug 2025 22:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9663D7B172D
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Aug 2025 20:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B6A2BE7DC;
	Fri, 15 Aug 2025 20:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="r6WfZZuE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y/m/t2Tu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CAD1F37D3
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Aug 2025 20:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755290677; cv=none; b=JSK/OqmYmbKkyEylh2Ibn313KPdpD0o35ZKEaLIhxuW4df1fBTq3VEhbNEURPaQ+QLecJVI4EsgjfzmVKcddxlCpc1KlewnMm9nIRsh9OZFNBQQwoqHNRA0ENgkS/SvVzlNkm8FY0q2sBhkObTC/WtsZH/YTySl/J6V6h9MIzG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755290677; c=relaxed/simple;
	bh=kpdanpa2zzuI8N4I1HgIp0jjaES8/U0io2eA9byFQkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpaQ9rVNaka/52qOMOVNvAgp7qR8AyUb0rCfTmj8pVL1VQkX0tQUGFU09TDoCOsFbkk+/cs5go8+g6GUjDI/NfTUtCpQQhzic4VtTAutPYupCvopl1aJyELYrQruAZgxOHaTilkMpgXDL1P8li0d8D6ezft8LqaibTGkTO9IJaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=r6WfZZuE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y/m/t2Tu; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D1B981400051;
	Fri, 15 Aug 2025 16:44:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 15 Aug 2025 16:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1755290673; x=1755377073; bh=0Colc1Xu9Q
	TRW/2dlnUMVoEjMzhWQCBgZ6963TADrOI=; b=r6WfZZuEWJrhrVi2pslds8p0HM
	z/Y4+zWM6P61edWO02dQV+MlfmEY/gUpNritjf5tDV7o1PxOsNJMEYUEntSFT0JI
	C4VLiqmJ2Nj7vw0E1+L6Minz6HDfHTPAefTIt3YqT97NjXqDRrFDB+218t4W/Op9
	pSKLtn4ELDK2sCyr2izyqyK2sjoaCzNIXgNhoojDey+uoHYyTSZkEbjVTlvM/KYZ
	eBA3IbnmnW/S2HVB0j5SDZUVekaze1RJxzyMoyE/RUoCmF7OzHrsSbI8wCcyjSVn
	8ZkmgGijjXS/OqaOpfbgvitLJGnFEr7irEkB0pwH0jezDCPpIM2FGzNuAXnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755290673; x=1755377073; bh=0Colc1Xu9QTRW/2dlnUMVoEjMzhWQCBgZ69
	63TADrOI=; b=Y/m/t2Tub9dhsjyOnlGuigfZXUdSH3MQ4Z3iWDO2FCHAoylbORp
	+6KRTLGlcs02373Ssd5KaBjLyB9SMVZ3rltGoa3w8UnQz3xZeD9Q1ADy0KSeVZJR
	Xsl0nQdK/zVbkwEGlqI2L+IzNMYjKU9zqeqIIk15mX5VdvaNl13o810M+y7ITKKV
	DnV+1bfndsT+k8DfXtlULrG1S0BaIGphV6ZCW7nJRi72kMlrkQo/KOAdHNQnLj9l
	GiW7stwmtJ4jwx2vU+lhR1rcP4oAudGo5FOhkeBs49Ve6fluSJSxoLfH8N3nLTcG
	fSb8kp1uuGii+/UAww4ZIBCao2w/K7vDcNQ==
X-ME-Sender: <xms:MZyfaImFBSeyDjUoPgn119OsQO_D1EY4WiptHHZv14pXdl7VYAdBRQ>
    <xme:MZyfaIDn56_ILcVL_p5Yjtetokf2Vjxg_t6Z_4O7ic19_Xp6XYyrFwHqjL9S-Svcd
    6c4FxYykbQLo5ItpE4>
X-ME-Received: <xmr:MZyfaIfalNEW994JxvaZ78W4pfWTI3Vuta7w15sG5l2I6Vi4tmSCvxMQ9wOwOpGwLdCuKfe5VVMXBFu9XryNcoDFFD4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeegleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepfihquhesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:MZyfaDLT8GiHuOK51pRrTuPUt0VyzuwjWgsz_xh0ortDIEN4uKNKIQ>
    <xmx:MZyfaLfD-LeafoznNbd1v0GbqYIh7jmu2tCdMkmOM7NPGPOdAdNWdA>
    <xmx:MZyfaK1xCs9lr4QKx7qtfcLB_Dp5jCuanFI4sQzHnds1m7fmondWGw>
    <xmx:MZyfaEjM4QzM6XlsimCI6G3Mu7HXX4Bf49KCueTEEcKrrIPi_84P_Q>
    <xmx:MZyfaO3C0Ffk9_-ynCEhHnHHbNLvCXgMnV9HLuRwmNQoWXrttOZlEhHd>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Aug 2025 16:44:33 -0400 (EDT)
Date: Fri, 15 Aug 2025 13:45:14 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: prevent device path updating during mount
Message-ID: <20250815204441.GA2973697@zen.localdomain>
References: <46498bbf2891a2c9539b33d17155ad9cd5f9401a.1754897590.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46498bbf2891a2c9539b33d17155ad9cd5f9401a.1754897590.git.wqu@suse.com>

On Mon, Aug 11, 2025 at 05:03:15PM +0930, Qu Wenruo wrote:
> [REGRESSION]
> After commit bddf57a70781 ("btrfs: delay btrfs_open_devices() until
> super block is created"), test case btrfs/315 can fail like this
> randomly:
> 
> btrfs/315 1s ... - output mismatch (see /home/adam/xfstests/results//btrfs/315.out.bad)
>     --- tests/btrfs/315.out	2025-08-11 16:40:36.496000000 +0930
>     +++ /home/adam/xfstests/results//btrfs/315.out.bad	2025-08-11 16:41:04.304000000 +0930
>     @@ -1,7 +1,7 @@
>      QA output created by 315
>      ---- seed_device_must_fail ----
>      mount: SCRATCH_MNT: WARNING: source write-protected, mounted read-only.
>     -mount: File exists
>     +mount: /mnt/test/315/tempfsid_mnt: WARNING: source write-protected, mounted read-only
>      ---- device_add_must_fail ----
>      wrote 9000/9000 bytes at offset 0
>     ...
>     (Run 'diff -u /home/adam/xfstests/tests/btrfs/315.out /home/adam/xfstests/results//btrfs/315.out.bad'  to see the entire diff)
> Ran: btrfs/315
> Failures: btrfs/315
> Failed 1 of 1 tests
> 
> [CAUSE]
> The failure is that the second seed device (with a duplicated fsid and
> dev uuid) is mounted successfully, which is unexpected.
> 
> In my environment, the following 2 devices involved in the
> "seed_device_must_fail" run are:
> 
>  lrwxrwxrwx 1 root root 7 Aug 11 09:03 /dev/test/scratch1 -> ../dm-2
>  lrwxrwxrwx 1 root root 7 Aug 11 09:03 /dev/test/scratch2 -> ../dm-4
> 
> Note the kernel dmesg of that run, when mounting the first seed device
> (scratch1), the real device got mounted is the second seed device
> (scratch2):
> 
>  BTRFS: device fsid 7c8a5017-0c44-456f-8acf-57663f954e53 devid 1 transid 9 /dev/mapper/test-scratch1 (253:2) scanned by mount (3343974)
>  BTRFS info (device dm-4): first mount of filesystem 7c8a5017-0c44-456f-8acf-57663f954e53
>  BTRFS info (device dm-4): using crc32c (crc32c-generic) checksum algorithm
>  BTRFS info (device dm-4): using free-space-tre
> 
> Note that "(device dm-4)" line, this means /dev/test/scratch2 is
> mounted when running "mount /dev/test/scratch1 /mnt/scratch".
> 
> Then when trying to mount /dev/test/scratch2, since the same device is
> already mounted, it returns the same super block and do not fail.
> 
> The root cause is, when setting seed device flags for both devices,
> a btrfs device scan is triggered, that scan is delayed and can happen at
> any time.
> 
> So there is a race window between scanning the second device and
> mounting the first device, where the device path can be replaced
> halfway:
> 
>      Mount scratch1                |          Scanning scratch2
> -----------------------------------+-------------------------------------
> btrfs_get_tree_super()             |
> |- btrfs_scan_one_device()         |
> |  We're mounting "scratch1"       |
> |                                  |
> |- btrfs_fs_devices_inc_holding()  |
> |- mutex_unlock(&uuid_mutex);      |
> |                                  | btrfs_scan_one_device()
> |                                  | |- device_list_add()
> |                                  |    |- rcu_assign_pointer()
> |                                  |       This changes the device->name
> |                                  |       to "scratch2"
> |- sget_fc()                       |
> |  This creates a new super block  |
> |- mutex_lock(&uuid_mutex)         |
> |- btrfs_fs_devices_dec_holding()  |
> |- btrfs_open_devices()            |
>    |- btrfs_open_one_device()      |
>       "scratch2" is opened as that |
>       is recorded in device->name   |
> 
> Commit bddf57a70781 ("btrfs: delay btrfs_open_devices() until super
> block is created") introduced fs_devices holding mechanism to allow
> devices to be opened after super block is created.
> 
> But that holding period doesn't keep device->name untouched, allowing
> a duplicated device to replace the path, thus mounting the incorrect
> device.
> 
> [FIX]
> Also check fs_devices->holding value before replacing the device->name.
> If fs_devices->holding is not zero, meaning someone is trying to mount
> the fs, then do not allow device->name to be updated.
> 
> Although this situation is rare, require certain race window and
> two devices with duplicated fsid/dev uuid (which is already very cursed),
> still output a warning message so that end users can be informed about
> such cursed situation.

Thanks for working on this, the last time I worked in this code it made
my head hurt, so I appreciate this is annoying to fix.

With that said, I have one concern: do you know if there are existing
tests exercising the legit name change behaviors outlined in the big
comment starting with "When FS is already mounted"? I have a feeling
that this check will prevent those as well, but I am not sufficiently
familiar with the new holding delayed open logic to be sure.

Thanks,
Boris

> 
> Fixes: bddf57a70781 ("btrfs: delay btrfs_open_devices() until super block is created")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/volumes.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index fa7a929a0461..4fdd84e0bff9 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -934,6 +934,20 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>  				  path, found_transid, device->generation);
>  			return ERR_PTR(-EEXIST);
>  		}
> +		if (fs_devices->holding) {
> +			/*
> +			 * The fs_devices are already hold by an ongoing mount.
> +			 *
> +			 * We can not update the device path, or a duplicated
> +			 * fsid/dev-uuid can replace the original path, causing
> +			 * another device to be mounted.
> +			 */
> +			btrfs_warn(NULL,
> +				   "device %s is trying to update path for a device being mounted",
> +				   path);
> +			mutex_unlock(&fs_devices->device_list_mutex);
> +			return ERR_PTR(-EEXIST);
> +		}
>  
>  		/*
>  		 * We are going to replace the device path for a given devid,
> -- 
> 2.50.1
> 

