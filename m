Return-Path: <linux-btrfs+bounces-19429-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B16C94EC1
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 Nov 2025 12:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD4794E1997
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 Nov 2025 11:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06472275AE3;
	Sun, 30 Nov 2025 11:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="MIzX7451"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F07A4A23
	for <linux-btrfs@vger.kernel.org>; Sun, 30 Nov 2025 11:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764500828; cv=none; b=qPo+BUea3/8EodKIS5F9BtdR2venuDey0ZslBRIq1tUbSrLFp9oC3howCICHx8DntiggSOw4PMtYe4KgN48UMKTJg1t5F+QOgb48kW07wfAFYRDzGsUgx3g5ejRz6I238JYn+Iw7S4i8aEQhfjz7k7OaeB7YwOmzrDPNzfouSRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764500828; c=relaxed/simple;
	bh=wVJhshGJhosYAevYuSkyg9FyRtNH5d+2EIZK6dT4mYg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PwFAI0TJYS1G4UpWMPx8INUIgL1keO8eOClj8tRDzVB+2apJrHafmXY8J7bZYfS/BnnPEchLejDu3dx3ID7LxhllAgzwyx+HGQC1J41Nva5XR3o8Ixc1lyMwD42h2ewlVmA8UtcnRFuPSYuYdL4TAZSCa6Wdq1sTS1AsTWmYq8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=MIzX7451; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight@runbox.com>)
	id 1vPfGX-004WY5-1X
	for linux-btrfs@vger.kernel.org; Sun, 30 Nov 2025 12:06:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date;
	bh=ii4oyl8shPqpfDnYT2P52+ucK3vxrL9jPR8JiIUcYSM=; b=MIzX7451amvQAlZE/6+DPg0OdM
	bpzy4V5hCPAmsFZi/Es/62E8ahS/GGfgGSaM5gC4wn+Q13Ypq0krAk5fCbqlXCa904rNiK+CSZ/B7
	mgACSshtEOXeVf3XUA0xLKNoL/+DzQZIsf9aABAdBpHy01lD2SC8Vgyt5tpHg7/jTK1D/BB9gtbBi
	Z8hjTwjxbwhvQqzUrM+XzZHuUQfWim4TGQt6QEJiLWRoFbnLgI69Tn0s8+4ux9cPVcgIfc4lOZmGB
	heEi7mdeai1UPSw/1s/gB/pExvhjc63EiRn8+hJVcbkUIPh6854NviUwn+7oHhf+alIWHZF/VBUHb
	b7T5NAzg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight@runbox.com>)
	id 1vPfGW-0003SH-Go; Sun, 30 Nov 2025 12:06:52 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vPfGO-006ZoJ-Uy; Sun, 30 Nov 2025 12:06:45 +0100
Date: Sun, 30 Nov 2025 11:06:40 +0000
From: david laight <david.laight@runbox.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: Replace memcpy + NUL termination in
 _btrfs_printk
Message-ID: <20251130110640.21eadec5@pumpkin>
In-Reply-To: <20251130005518.82065-1-thorsten.blum@linux.dev>
References: <20251130005518.82065-1-thorsten.blum@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 30 Nov 2025 01:55:17 +0100
Thorsten Blum <thorsten.blum@linux.dev> wrote:

> Use strscpy() to copy the NUL-terminated source string 'fmt' to the
> destination buffer 'lvl' instead of using memcpy() followed by a manual
> NUL termination.  No functional changes.

Why?
The code has just got the length of part of the format string, it wants
a copy of it with a '\0' terminator.
So memcpy() is correct and strscpy() just expensive.
The code is actually strange (and strangely written), but 'size' is always 2.

One might question why btrfs has to invent its own 'printk' scheme...

But PRINTK_MAX_SINGLE_HEADER_LEN is only used here - so take out the 'MAX_'
and use it inside printk_skip_level'.
Then here use the constant PRINTK_SINGLE_HEADER_LEN instead of 'size'.
Since lvl[] is initialised it will all be zero, so after the
mempy(lvl, fmt, 2) (which will be inlined) there is no need to the
lvl[2] = 0 at all.

	David

> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  fs/btrfs/messages.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/messages.c b/fs/btrfs/messages.c
> index a0cf8effe008..083e228e6d6c 100644
> --- a/fs/btrfs/messages.c
> +++ b/fs/btrfs/messages.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
> +#include <linux/string.h>
>  #include "fs.h"
>  #include "messages.h"
>  #include "discard.h"
> @@ -229,8 +230,7 @@ void __cold _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt,
>  		size_t size = printk_skip_level(fmt) - fmt;
>  
>  		if (kern_level >= '0' && kern_level <= '7') {
> -			memcpy(lvl, fmt,  size);
> -			lvl[size] = '\0';
> +			strscpy(lvl, fmt, size + 1);
>  			type = logtypes[kern_level - '0'];
>  			ratelimit = &printk_limits[kern_level - '0'];
>  		}


