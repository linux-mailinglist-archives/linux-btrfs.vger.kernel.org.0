Return-Path: <linux-btrfs+bounces-5943-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BC8915691
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 20:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAADCB222C8
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 18:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477D719FA9E;
	Mon, 24 Jun 2024 18:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="uXp+aivd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KkbMxium"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057651B950
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2024 18:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719254396; cv=none; b=gF7mi6OSgaBl3AnHHYj3xVKE+kMyv3A7YCiJPv1RBDGt3ccjFgCdT6FaKsa+lRtxDhuEDbK0j7HCT1fxO5Kpvl9YEevibkdGXK3C8gvhWwRxJiTiotP68SAEGO2p6JpVJhJyEpw3s4B+wP3ukuSP/z17O4Ne5ChPSxxjQW8iYFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719254396; c=relaxed/simple;
	bh=2k5W8a0bGdjTY9zNO3mpxwZDZfglYlQa2j9SO8O7kxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQV+pSKQoMAGlD7Si/oX3tcht/M8V8pT0rMuosl5uqlN4lr9tzah7pSNGwV7uxTy2kuDboDNYC/ZaqvzeYPmTHwphv+KSHsYwnIeQk5U4nAxDg+9rVrCqiU+Fp2Ca7c1jpKnAs/KzBYFmEulEgG9CJTPzfUUSBhAyyBPSXFiuZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=uXp+aivd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KkbMxium; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 072CF11401C5;
	Mon, 24 Jun 2024 14:39:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 24 Jun 2024 14:39:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1719254393; x=1719340793; bh=DMXYBMvMUO
	EXwOh/I73UN+GXiaPOxGAKnpmMejfBNRs=; b=uXp+aivd2/Wss3wsLjoBxx3a5X
	nRHHSYMRe2jt596qBVvguvqmyAu0y7VoWmtyI9iFUvBQ/8+DcqHY4/MxA/dsllf3
	EQpTmQIv5R4Id+ZWgAaFA/664A/4xLzEHSTPplSp8XE8C5GsKsx7tmzJ8F50I5EG
	eOy9w0eyBkd6oLGGVHCYgqmzPL5IjqGmHFdWeSWMwTN0Ja6OO3wTacxaZQEfkgP+
	8dKLrsOY9V/ApslX9/w+vRViQO5H6/NYUTRayvjvsBUxeALtat15hJZWWA1+2c3S
	f9ZJWKzETRmkr4Ys1ZFMTBTBAqHeQ57ehBlWrusq1X1mV6mLjplT8y9WWCTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719254393; x=1719340793; bh=DMXYBMvMUOEXwOh/I73UN+GXiaPO
	xGAKnpmMejfBNRs=; b=KkbMxiumGJvx1itkTHIqLenFtKfh3Y7mP+/kw8E4sPbN
	g0GrLw0ZVbvf6ne/yDcKvULcVD8W6O9R1sXdpO+PLmD4ZlBwGVsvn8Fy5G+TPC6j
	2niQalxIC5+fvrY53p3w1WNXqfEzrlUTkGl2S6y49osenELAkCQdo/bIsqfq61aY
	XaKPaOw7LkpevOeA+cCyBiYVCbmHX/sHTpCWdZbULQ6CxFCZ2/BO4dC8Nz37a7J8
	ZpzFZN9IXsvLK4udFx2viQeP/D5Z7HmmmycKqBd4wZoxIuY82/WpJpj93+RyItDz
	mz1DNY/ta5DRnZe5Z9z08szwhtAvzmk1aMXp8luRbg==
X-ME-Sender: <xms:eL15ZuY2cZM_uvuiUMBTgn7-NdDWqfC-xvgOp1Eb3EndYEKiBUp-zA>
    <xme:eL15ZhYghdZ9ipPpLP2cnt1BJisOz0d0KcMKu7tvRsV5-9JJLx9x9iVMfud2jlgC-
    DxSIGAFl-j20uaurl0>
X-ME-Received: <xmr:eL15Zo_FKpFMe2Orv2axsiBcyTj6mFRMWbVXPeyFiK88jnLuIlRSLVJydQxrCQBtqWUjmS5eWpYEmJtiHngHJWe6Qu4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeeguddgudeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:eL15ZgoEbKM3VHk3x1HGCQCuMB6qNUkYYKWNpHX2M_EqLXuiuMhCIA>
    <xmx:eL15Zpp4GkIRj6FfBCnowmUb0ILe3z12-ckMg23pgxnIDzOPx9AeIQ>
    <xmx:eL15ZuRRfiiHnDkvl_KQaCWYQDdZ3b__bGg-WkMCDCO2jPEvwoC6uA>
    <xmx:eL15ZppHKWRiiv8ZS_e-IkbBG4T2bAVcFuOmDKMoux5hH9CbosiDag>
    <xmx:eL15ZgWQwQTb5fwiQWYAqdOIm8iQ-xLdxgmMLJIf2ly4HzrQzjxa6a8i>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Jun 2024 14:39:52 -0400 (EDT)
Date: Mon, 24 Jun 2024 11:39:24 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	syzbot+a0d1f7e26910be4dc171@syzkaller.appspotmail.com
Subject: Re: [PATCH] btrfs: always do the basic checks for
 btrfs_qgroup_inherit structure
Message-ID: <20240624183924.GB1405187@zen.localdomain>
References: <47d3dd33f637b70f230fa31f98dbf9ff066b58bb.1719207446.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47d3dd33f637b70f230fa31f98dbf9ff066b58bb.1719207446.git.wqu@suse.com>

On Mon, Jun 24, 2024 at 03:10:53PM +0930, Qu Wenruo wrote:
> [BUG]
> Syzbot reports the following regression detected by KASAN:
> 
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in btrfs_qgroup_inherit+0x42e/0x2e20 fs/btrfs/qgroup.c:3277
> Read of size 8 at addr ffff88814628ca50 by task syz-executor318/5171
> 
> CPU: 0 PID: 5171 Comm: syz-executor318 Not tainted 6.10.0-rc2-syzkaller-00010-g2ab795141095 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0x169/0x550 mm/kasan/report.c:488
>  kasan_report+0x143/0x180 mm/kasan/report.c:601
>  btrfs_qgroup_inherit+0x42e/0x2e20 fs/btrfs/qgroup.c:3277
>  create_pending_snapshot+0x1359/0x29b0 fs/btrfs/transaction.c:1854
>  create_pending_snapshots+0x195/0x1d0 fs/btrfs/transaction.c:1922
>  btrfs_commit_transaction+0xf20/0x3740 fs/btrfs/transaction.c:2382
>  create_snapshot+0x6a1/0x9e0 fs/btrfs/ioctl.c:875
>  btrfs_mksubvol+0x58f/0x710 fs/btrfs/ioctl.c:1029
>  btrfs_mksnapshot+0xb5/0xf0 fs/btrfs/ioctl.c:1075
>  __btrfs_ioctl_snap_create+0x387/0x4b0 fs/btrfs/ioctl.c:1340
>  btrfs_ioctl_snap_create_v2+0x1f2/0x3a0 fs/btrfs/ioctl.c:1422
>  btrfs_ioctl+0x99e/0xc60
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:907 [inline]
>  __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fcbf1992509
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fcbf1928218 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007fcbf1a1f618 RCX: 00007fcbf1992509
> RDX: 0000000020000280 RSI: 0000000050009417 RDI: 0000000000000003
> RBP: 00007fcbf1a1f610 R08: 00007ffea1298e97 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007fcbf19eb660
> R13: 00000000200002b8 R14: 00007fcbf19e60c0 R15: 0030656c69662f2e
>  </TASK>
> 
> And it also pinned it down to this commit:
> 
> commit b5357cb268c41b4e2b7383d2759fc562f5b58c33
> Author: Qu Wenruo <wqu@suse.com>
> Date:   Sat Apr 20 07:50:27 2024 +0000
> 
>     btrfs: qgroup: do not check qgroup inherit if qgroup is disabled
> 
> [CAUSE]
> That offending commit skips the whole qgroup inherit check if qgroup is
> not enabled.
> 
> But that also skips the very basic checks like
> num_ref_copies/num_excl_copies and the structure size checks.
> 
> Meaning if a qgroup enable/disable race is happening at the background,
> and we pass a btrfs_qgroup_inherit structure when the qgroup is
> disabled, the check would be completely skipped.
> 
> Then at the time of transaction commitment, qgroup is re-enabled and
> btrfs_qgroup_inherit() is going to use the incorrect structure and
> causing the above KASAN error.
> 
> [FIX]
> Make btrfs_qgroup_check_inherit() only skip the source qgroup checks.
> So that even if invalid btrfs_qgroup_inherit structure is passed in, we
> can still reject invalid ones no matter if qgroup is enabled or not.
> 
> Furthermore we do already have an extra safenet inside
> btrfs_qgroup_inherit(), which would just ignore invalid qgroup sources,
> so even if we only skip the qgroup source check we're still safe.
> 
> Reported-by: syzbot+a0d1f7e26910be4dc171@syzkaller.appspotmail.com
> Fixes: b5357cb268c4 ("btrfs: qgroup: do not check qgroup inherit if qgroup is disabled")

LGTM, thanks!
Reviewed-by: Boris Burkov <boris@bur.io>

> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/qgroup.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 3edbe5bb19c6..45f4facc6f96 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -3166,8 +3166,6 @@ int btrfs_qgroup_check_inherit(struct btrfs_fs_info *fs_info,
>  			       struct btrfs_qgroup_inherit *inherit,
>  			       size_t size)
>  {
> -	if (!btrfs_qgroup_enabled(fs_info))
> -		return 0;
>  	if (inherit->flags & ~BTRFS_QGROUP_INHERIT_FLAGS_SUPP)
>  		return -EOPNOTSUPP;
>  	if (size < sizeof(*inherit) || size > PAGE_SIZE)
> @@ -3188,6 +3186,14 @@ int btrfs_qgroup_check_inherit(struct btrfs_fs_info *fs_info,
>  	if (size != struct_size(inherit, qgroups, inherit->num_qgroups))
>  		return -EINVAL;
>  
> +	/*
> +	 * Skip the inherit source qgroups check if qgroup is not enabled.
> +	 * Qgroup can still be later enabled causing problems, but in that case
> +	 * btrfs_qgroup_inherit() would just ignore those invalid ones.
> +	 */
> +	if (!btrfs_qgroup_enabled(fs_info))
> +		return 0;
> +
>  	/*
>  	 * Now check all the remaining qgroups, they should all:
>  	 *
> -- 
> 2.45.2
> 

