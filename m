Return-Path: <linux-btrfs+bounces-2093-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A550D848E02
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Feb 2024 14:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50115B21FD5
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Feb 2024 13:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0E1224ED;
	Sun,  4 Feb 2024 13:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L277D5EG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2F1224D6
	for <linux-btrfs@vger.kernel.org>; Sun,  4 Feb 2024 13:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707052532; cv=none; b=kOsYeNREa6bpksrZhYp5tBkJozlwc9qMlk8f5Ft85c//muJe/BcQWplwhckN1oCjv0P2Vm2s0uzy0q1LZmQwp1BdOBEEYjk6ZQAhBcs75XesgUgXTOqlsy0HvO1GLWS+LyFkiNY3/kGyLECBoYD67aahhiEe3UFdEG4uedcUWz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707052532; c=relaxed/simple;
	bh=CoHXpdBjd4fWUj/c5qQ8LMn61AkWL0vC3uZ+k84u5aE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7TdmrXDOCh8k1cwGuL8dIAx8EmN64p+y6B0MqNsrbjymmAoTxWfSOMollKPkJ/UynQUZa8snRZzk6EefAQk5bO9VtBsJxCoBn3SkUqE2WJBDkqu4my91UrRHX89fZhAJjZ1BtqvWI6MN3Y7hfKwVfVg489M8Gh6Yszl04bPU+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L277D5EG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707052529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lxyP1JsFMLPRUoWk0k5pEtCyUPIcZiMCq+pimvMnsVg=;
	b=L277D5EGQCA0zLZeWcuSy9/NLTJ5KC99q+sMTt6rJxrC+cEM3c+d/OwGMdRtZZaNDIO6+7
	7gznAw0oUucz0phTOaraZA9w9dGWfm9arRK0cml6ejZiURy37yiFg/QxjZhilZQYEEGxwj
	jp2ivmOjxdBF3H/4MusSaUg3xjoEpjo=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-1S_eWhn7NDmfG-PxjfrMGQ-1; Sun, 04 Feb 2024 08:15:26 -0500
X-MC-Unique: 1S_eWhn7NDmfG-PxjfrMGQ-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5ce63e72bc3so3602403a12.0
        for <linux-btrfs@vger.kernel.org>; Sun, 04 Feb 2024 05:15:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707052525; x=1707657325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxyP1JsFMLPRUoWk0k5pEtCyUPIcZiMCq+pimvMnsVg=;
        b=goIlB5CojEewsYHK6QDCD/izC/iCVBQWM0X4mhE7/YwmO7/eW/r7re8WDjKLFpjgFt
         Rw7iFDa1jxsRxHDIRLqqfhj3JZKBZkWRRrq2kZ+HQ+WcTMlQPXm+wquDmDAp5g5niRId
         k1b/1uTMbHLmRdKbpVMOnDgqhxTvVjx5rv28GXwbJtVeJapSTl2jYm+Hdm8ezMMMkchP
         Xh7V1Cvg4oVNDmRgwwfK0ed4viaEdYbYEGtLH27nnQ1zxQziR4DP3t/jSpJKaZxHCxAI
         Rv3ZgyR/57qLPaJLJ1eSXEOoovqa7WPABon6uHeo4DVQJ+SaF1I63OMlKQcqBn/ElO9T
         6Gaw==
X-Gm-Message-State: AOJu0YwhTbUr3KuTp3DoAHTVrVZ6QR8nNEPE1td8f1Z56y4txgQ7pniZ
	xjNrSAAVcrzb2BXZz8Kf1WO3ZV6iymxq+SYUUotCeGS+B2z9yy3VMSExKH1NdqMRW5LgI1eTr/f
	ow5UVY9bcgnW0eU1xnsLuGbmYJKAqdRwicUtFFyxGh4BDu9sQVKkw0XvZbLgF
X-Received: by 2002:a05:6a20:4393:b0:19c:ae4c:1757 with SMTP id i19-20020a056a20439300b0019cae4c1757mr7058219pzl.52.1707052525002;
        Sun, 04 Feb 2024 05:15:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHillRBxEnghE7mYJ3gj+fGKT62tHMay+Pp6uivYAIanVjZ99nOfjKV532TLL1l/4QP9oz/oA==
X-Received: by 2002:a05:6a20:4393:b0:19c:ae4c:1757 with SMTP id i19-20020a056a20439300b0019cae4c1757mr7058206pzl.52.1707052524630;
        Sun, 04 Feb 2024 05:15:24 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUk+312/AzI5SqOv46D9p4PGcpkytsM/MnH0ROcIvvo3xqVt4JnkVnyn77PFcPTuDmAvAxjb+70HgDwzbIf+94eI4f02KNTql3NxK0=
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id g8-20020a056a0023c800b006ddb0b0ff0dsm4776259pfc.34.2024.02.04.05.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 05:15:24 -0800 (PST)
Date: Sun, 4 Feb 2024 21:15:21 +0800
From: Zorro Lang <zlang@redhat.com>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] t_snapshot_deleted_subvolume: add check for
 BTRFS_IOC_SNAP_DESTROY_V2
Message-ID: <20240204131521.wnueevl6y4snk5lx@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240201042348.147733-1-xuyang2018.jy@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201042348.147733-1-xuyang2018.jy@fujitsu.com>

On Wed, Jan 31, 2024 at 11:23:48PM -0500, Yang Xu wrote:
> On some platform, struct btrfs_ioctl_vol_args_v2 is defined, but the
> macros BTRFS_IOC_SNAP_DESTROY_V2 is not defined. This will cause
> compile error. Add check for BTRFS_IOC_SNAP_DESTROY_V2 to solve this
> problem.
> 
> BTRFS_IOC_SNAP_CREATE_V2 and BTRFS_IOC_SUBVOL_CREATE_V2 were
> introduced together with struct btrfs_ioctl_vol_args_v2 by the
> commit 55e301fd57a6 ("Btrfs: move fs/btrfs/ioctl.h to
> include/uapi/linux/btrfs.h"). So there is no need to check them.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---

This patch is good to me, and test passed on rhel-8.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  configure.ac                       |  1 +
>  src/t_snapshot_deleted_subvolume.c | 10 +++++-----
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index b22fc52b..b14b1ab8 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -109,6 +109,7 @@ AC_CHECK_MEMBERS([struct btrfs_ioctl_vol_args_v2.subvolid], [], [], [[
>  #include <stddef.h>
>  #include <linux/btrfs.h>
>  ]])
> +AC_CHECK_DECLS([BTRFS_IOC_SNAP_DESTROY_V2],,,[#include <linux/btrfs.h>])
>  
>  AC_CONFIG_HEADERS([include/config.h])
>  AC_CONFIG_FILES([include/builddefs])
> diff --git a/src/t_snapshot_deleted_subvolume.c b/src/t_snapshot_deleted_subvolume.c
> index c3adb1c4..402c0515 100644
> --- a/src/t_snapshot_deleted_subvolume.c
> +++ b/src/t_snapshot_deleted_subvolume.c
> @@ -20,11 +20,6 @@
>  #define BTRFS_IOCTL_MAGIC 0x94
>  #endif
>  
> -#ifndef BTRFS_IOC_SNAP_DESTROY_V2
> -#define BTRFS_IOC_SNAP_DESTROY_V2 \
> -	_IOW(BTRFS_IOCTL_MAGIC, 63, struct btrfs_ioctl_vol_args_v2)
> -#endif
> -
>  #ifndef BTRFS_IOC_SNAP_CREATE_V2
>  #define BTRFS_IOC_SNAP_CREATE_V2 \
>  	_IOW(BTRFS_IOCTL_MAGIC, 23, struct btrfs_ioctl_vol_args_v2)
> @@ -58,6 +53,11 @@ struct btrfs_ioctl_vol_args_v2 {
>  };
>  #endif
>  
> +#if !HAVE_DECL_BTRFS_IOC_SNAP_DESTROY_V2
> +#define BTRFS_IOC_SNAP_DESTROY_V2 \
> +	_IOW(BTRFS_IOCTL_MAGIC, 63, struct btrfs_ioctl_vol_args_v2)
> +#endif
> +
>  int main(int argc, char **argv)
>  {
>  	if (argc != 2) {
> -- 
> 2.39.3
> 
> 


