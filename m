Return-Path: <linux-btrfs+bounces-15209-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E068DAF6147
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jul 2025 20:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A00B44A347F
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jul 2025 18:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67302E49B4;
	Wed,  2 Jul 2025 18:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gpy5Ywhr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23E12E4990;
	Wed,  2 Jul 2025 18:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751480840; cv=none; b=DmG2u16XVxxZqZ/lWOzWTsGbgKd+sLCRqaDhhihb0qplnzsN5MA5yN90Yfc+Y2jiiwqZO+Sf2Pi88VuJh1uP0DCRYYfIrTGF6E0KyWX/w1jCPOjot78l2EFFrT5oj4KSf8AkK5/utiPb8SFiKeOw9A8+5fuOW2QFxfwqQwaN7EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751480840; c=relaxed/simple;
	bh=dug9JKJ8jzli2X+iTVUSEQZLGmtcSJ2d7RbXeaPWkg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QiNGB0NsocB2RM7l/ZavRy0TIfi6QO3fkB5UDuPqazduOjZTxl4IaDIlPFWsyLXqxk4WfMupZDEP3SkV0kJsRdhhE6h3GhwcquZ+dD6fSwo+qJwAah14G70vfBKCPQAqV+gUPFl/ZMS36vVhmE7kPGbnOIS5R39u38RNwnIV3tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gpy5Ywhr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1614DC4CEE7;
	Wed,  2 Jul 2025 18:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751480837;
	bh=dug9JKJ8jzli2X+iTVUSEQZLGmtcSJ2d7RbXeaPWkg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gpy5YwhrnEizCphyRJl6J/BpYhjJnExkX+BBSfsX6vQnvNvN2rUpTEy9BI/XhlSCV
	 M0COOxy3U5gNmMVRriVwMb8SoJj+o7rePGXPJk2kLWaXmLjrHP4ImQtq/bbfz/I6w7
	 eQXST7zk9N2eOs6ODlFriRFF8pMqpR5Xg2YR7XVwl4aye4Dn+RCmSse8Rq9ie4QhhC
	 u0KGIakUGby59qDY8npfx/Hfl6944hsOlSNboxK/1xhV90RJA7hg2K53sfySzOMU2o
	 5JF/fTHq2YpARdiHLHYBYpzChSxq1cKBFt3FlPPZya7tJabFFX47xQRX1m5WH9jZF/
	 B4FRENjpISMig==
Date: Wed, 2 Jul 2025 11:27:12 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Brahmajit Das <listout@listout.xyz>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
	dsterba@suse.com, kees@kernel.org, ailiop@suse.com,
	mark@harmstone.com, David Sterba <dsterba@suse.cz>,
	Brahmajit Das <bdas@suse.de>
Subject: Re: [PATCH v4] btrfs: replace deprecated strcpy with strscpy
Message-ID: <20250702182712.GA3453770@ax162>
References: <20250620164957.14922-1-listout@listout.xyz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620164957.14922-1-listout@listout.xyz>

Hi Brahmajit,

On Fri, Jun 20, 2025 at 10:19:57PM +0530, Brahmajit Das wrote:
> strcpy is deprecated due to lack of bounds checking. This patch replaces
> strcpy with strscpy, the recommended alternative for null terminated
> strings, to follow best practices.
> 
> There are instances where strscpy cannot be used such as where both the
> source and destination are character pointers. In that instance we can
> use sysfs_emit.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Suggested-by: Anthony Iliopoulos <ailiop@suse.com>
> Suggested-by: David Sterba <dsterba@suse.cz>
> Signed-off-by: Brahmajit Das <bdas@suse.de>
...
> diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
> index 3e0edbcf73e1..49fd8a49584a 100644
> --- a/fs/btrfs/xattr.c
> +++ b/fs/btrfs/xattr.c
> @@ -516,8 +516,7 @@ static int btrfs_initxattrs(struct inode *inode,
>  			ret = -ENOMEM;
>  			break;
>  		}
> -		strcpy(name, XATTR_SECURITY_PREFIX);
> -		strcpy(name + XATTR_SECURITY_PREFIX_LEN, xattr->name);
> +		sysfs_emit(name, "%s%s", XATTR_SECURITY_PREFIX, xattr->name);
>  
>  		if (strcmp(name, XATTR_NAME_CAPS) == 0)
>  			clear_bit(BTRFS_INODE_NO_CAP_XATTR, &BTRFS_I(inode)->runtime_flags);

This change is now in -next as commit d282edfe8850 ("btrfs: replace
strcpy() with strscpy()"), where this hunk appears to causes a slew of
warnings on my arm64 systems along the lines of:

  ------------[ cut here ]------------
  invalid sysfs_emit: buf:00000000581f52ce
  WARNING: fs/sysfs/file.c:767 at sysfs_emit+0x60/0xe0, CPU#5: systemd/1
  Modules linked in:
  CPU: 5 UID: 0 PID: 1 Comm: systemd Tainted: G        W           6.16.0-rc4-next-20250702 #1 PREEMPT(voluntary)
  Tainted: [W]=WARN
  Hardware name: QEMU KVM Virtual Machine, BIOS edk2-20241117-5.fc42 11/17/2024
  pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : sysfs_emit+0x60/0xe0
  lr : sysfs_emit+0x60/0xe0
  sp : ffff80008005b840
  x29: ffff80008005b890 x28: ffff0000c0793f18 x27: ffffac7b3da61468
  x26: 0000000000400100 x25: ffffac7b3f173a88 x24: ffffac7b3f2a6480
  x23: ffff0000c0793f18 x22: ffff0000c6d4da38 x21: ffff0000c156b500
  x20: ffff0000c0e2e640 x19: ffff0000c156b500 x18: 00000000ffffffff
  x17: 65766c6f7365722d x16: 646d65747379732d x15: 0000000000000010
  x14: 0000000000000000 x13: 0000000000000008 x12: 0000000000000020
  x11: 0000000000000001 x10: 0000000000000001 x9 : ffffac7b3d2b97cc
  x8 : ffffac7b40c1aa40 x7 : ffff80008005b4a0 x6 : ffffac7b40beaa00
  x5 : ffff0003fd79c488 x4 : ffff5388bd8bc000 x3 : ffff0000c0960000
  x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000c0960000
  Call trace:
   sysfs_emit+0x60/0xe0 (P)
   btrfs_initxattrs+0x8c/0x148
   security_inode_init_security+0x110/0x1d8
   btrfs_xattr_security_init+0x30/0x58
   btrfs_create_new_inode+0x3cc/0xc60
   btrfs_create_common+0xdc/0x148
   btrfs_mkdir+0x7c/0xc0
   vfs_mkdir+0x1a0/0x290
   do_mkdirat+0x150/0x190
   __arm64_sys_mkdirat+0x54/0xb0
   invoke_syscall.constprop.0+0x64/0xe8
   el0_svc_common.constprop.0+0x40/0xe8
   do_el0_svc+0x24/0x38
   el0_svc+0x3c/0x170
   el0t_64_sync_handler+0x10c/0x138
   el0t_64_sync+0x1b0/0x1b8
  ---[ end trace 0000000000000000 ]---

It looks like the offset_in_page(buf) part of the WARN() in
sysfs_emit() gets triggered with this, presumably because kmalloc()
returns something that is not page aligned like sysfs_emit() requires?

Cheers,
Nathan

