Return-Path: <linux-btrfs+bounces-14793-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B25FAE0BBB
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jun 2025 19:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0262F4A235F
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jun 2025 17:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3B528C87D;
	Thu, 19 Jun 2025 17:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="aLglzQ+y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (unknown [62.3.69.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC262367B1;
	Thu, 19 Jun 2025 17:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.3.69.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750352778; cv=none; b=qlgrX0KyP9ZbKVNBRErt+kidMlOoYCFygR/WcMmQx2CH9v/Eat4BUCw5lZhS0m6dTipDsnRhacXInlVK+9++5b9JJM6/t8QOvu4Mib0RZt3J8zD9FBNjXaX8k7ArXe3Eh6MRoR7kfi095ABq1o+7zw2PR5lsVPkLDnT9wRXNlCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750352778; c=relaxed/simple;
	bh=ByMVe8IbdMaFOUossUjxMjeIcyVLSrx4rAhlwxACzAs=;
	h=Message-ID:Date:Mime-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ffpo4WHNDIODNK6Zbcmc5CWsQJ7r4TSAEkjxeitkHVz2B3OlxRVLc/M9zfoF2J4hX7GiVLrNXy3o7xNXnGAONYh5ds6wAeIz14YFs0juniCdruZEx5cGNoMfwTgD//T5bAI8Bt07BpZcBEXtZW8AGh2pV8y2PT9BVAEUG1FoGBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=aLglzQ+y; arc=none smtp.client-ip=62.3.69.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from [IPV6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2] (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "hellas", Issuer "burntcomma.com" (verified OK))
	by mail.burntcomma.com (Postfix) with ESMTPS id 8654C2896B7;
	Thu, 19 Jun 2025 18:06:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1750352772;
	bh=XEHNEzk9V6MYTH1qzKl38JyGH0PE4klJDHTC7EE6U8g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=aLglzQ+yruUfBzpJGuilvw+ClmbljmsHUSaRpAhdO88LpgOwGN63s4a4tER0vloFr
	 Lzgj3sbEft4G7UuDnwjR2Az6KoVtt56PTPho2Jvf1FMHVjVSMAdhDpntM7ycIe4bkX
	 vrhr1AmCaElZXu6uf1+p/5OLWhwkTFfosB+H6xng=
Message-ID: <b8945d37-3eb9-4ad6-b3eb-2725dbb008ad@harmstone.com>
Date: Thu, 19 Jun 2025 18:06:12 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v2] btrfs: replace deprecated strcpy with strscpy
To: Brahmajit Das <listout@listout.xyz>, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, kees@kernel.org,
 ailiop@suse.com
References: <20250619140623.3139-1-listout@listout.xyz>
 <20250619153904.25889-1-listout@listout.xyz>
Content-Language: en-US
From: Mark Harmstone <mark@harmstone.com>
Autocrypt: addr=mark@harmstone.com; keydata=
 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
In-Reply-To: <20250619153904.25889-1-listout@listout.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/06/2025 4.39 pm, Brahmajit Das wrote:
> strcpy is deprecated due to lack of bounds checking. This patch replaces
> strcpy with strscpy, the recommended alternative for null terminated
> strings, to follow best practices.
> 
> There are instances where strscpy cannot be used such as where both the
> source and destination are character pointers. In that instance we can
> use sysfs_emit or a memcpy.
> 
> Update in v2: using sysfs_emit instead of scnprintf
> 
> No functional changes intended.
> 
> Link: https://github.com/KSPP/linux/issues/88
> 
> Suggested-by: Anthony Iliopoulos <ailiop@suse.com>
> Signed-off-by: Brahmajit Das <listout@listout.xyz>
> ---
>   fs/btrfs/ioctl.c   | 2 +-
>   fs/btrfs/send.c    | 2 +-
>   fs/btrfs/volumes.c | 2 +-
>   fs/btrfs/xattr.c   | 4 ++--
>   4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 913acef3f0a9..203f309f00b1 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -4200,7 +4200,7 @@ static int btrfs_ioctl_set_fslabel(struct file *file, void __user *arg)
>   	}
>   
>   	spin_lock(&fs_info->super_lock);
> -	strcpy(super_block->label, label);
> +	strscpy(super_block->label, label);
>   	spin_unlock(&fs_info->super_lock);
>   	ret = btrfs_commit_transaction(trans);

Surely this doesn't compile... strscpy takes three parameters.

> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 2891ec4056c6..66ee9e1b1e96 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -758,7 +758,7 @@ static int send_header(struct send_ctx *sctx)
>   {
>   	struct btrfs_stream_header hdr;
>   
> -	strcpy(hdr.magic, BTRFS_SEND_STREAM_MAGIC);
> +	strscpy(hdr.magic, BTRFS_SEND_STREAM_MAGIC);
>   	hdr.version = cpu_to_le32(sctx->proto);
>   	return write_buf(sctx->send_filp, &hdr, sizeof(hdr),
>   					&sctx->send_off);
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 89835071cfea..ec5304f19ac2 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -215,7 +215,7 @@ void btrfs_describe_block_groups(u64 bg_flags, char *buf, u32 size_buf)
>   	u32 size_bp = size_buf;
>   
>   	if (!flags) {
> -		strcpy(bp, "NONE");
> +		memcpy(bp, "NONE", 4);
>   		return;
>   	}

Same issue here as with the other patch.

>   
> diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
> index 3e0edbcf73e1..9f652932895c 100644
> --- a/fs/btrfs/xattr.c
> +++ b/fs/btrfs/xattr.c
> @@ -12,6 +12,7 @@
>   #include <linux/posix_acl_xattr.h>
>   #include <linux/iversion.h>
>   #include <linux/sched/mm.h>
> +#include <linux/string.h>
>   #include "ctree.h"
>   #include "fs.h"
>   #include "messages.h"
> @@ -516,8 +517,7 @@ static int btrfs_initxattrs(struct inode *inode,
>   			ret = -ENOMEM;
>   			break;
>   		}
> -		strcpy(name, XATTR_SECURITY_PREFIX);
> -		strcpy(name + XATTR_SECURITY_PREFIX_LEN, xattr->name);
> +		sysfs_emit(name, "%s%s", XATTR_SECURITY_PREFIX, xattr->name);
>   
>   		if (strcmp(name, XATTR_NAME_CAPS) == 0)
>   			clear_bit(BTRFS_INODE_NO_CAP_XATTR, &BTRFS_I(inode)->runtime_flags);


