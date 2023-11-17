Return-Path: <linux-btrfs+bounces-166-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CFC7EF0C2
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Nov 2023 11:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 442971C209E7
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Nov 2023 10:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7FE19BAA;
	Fri, 17 Nov 2023 10:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eSgNhlgA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433CBB9
	for <linux-btrfs@vger.kernel.org>; Fri, 17 Nov 2023 02:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700217703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S0DHWe0PlgOeEwze+kKHsskavc+r58IDDlhHIcWPq4Q=;
	b=eSgNhlgAhlHKUuP3rcMTMT5fRAIhw0eypjwfQzdpiHOdl93ux+YfH+zg8TkNA7j5uulkV/
	aXoijHAT7BabTac1Bq6J9b/bGIy5HvhbXyCGocr6kib4HKtEFzLCW9OPoGoGEdZgiJQ6FA
	ZJMvvBdUSC5PV8hx2Q1VcOV1Nj9MN2I=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-Q3nLgR3pOBupU08NYzrPmw-1; Fri, 17 Nov 2023 05:41:40 -0500
X-MC-Unique: Q3nLgR3pOBupU08NYzrPmw-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-28043db47ebso1976846a91.1
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Nov 2023 02:41:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700217700; x=1700822500;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S0DHWe0PlgOeEwze+kKHsskavc+r58IDDlhHIcWPq4Q=;
        b=b/wUz5F0UZ7O8cgbWGgrCjiEIj3JwKn4baXK3WBKXgKMkN78XGya3Vri0georTTn+X
         CWB3S23QaxE+hdzNS7GV9LCroNbii36oWn7x/h1SNl4zess14C4JUJl6H1XrkFvcme+q
         PpCzPImuCNp4IhPkurktppymKZEscrWui0aSuRw+txXzfU6a80Stmwaq1tBxTzPdhc4F
         FNeECxa2mhTeAkyB5d11I4hZrVog/Y6T08X6rLbBDYjeQijKfqS5IFdQxm9AiFHePM8f
         JYuMTQTwhahy26cEqv4pC1w5+F34lTsW9JKPxXNqZfDE2kgszuLWOKBUfD/3lz28flvF
         9VSg==
X-Gm-Message-State: AOJu0Yzd0XsrOuWguw9DBTVKTjEGYejc1nUAk7xlhYODkNulNNo9j6IN
	+rEI0WlVJqIGUgGjj+A8Vsh+ENadfev0hzlhwvB5z1NJn7GwAhGTDCqkpsxl4mCa+8hRs/NeBFN
	lph7yiwt84wZnpKZXmzQEKK/sZaVbdsydGGu67/Q=
X-Received: by 2002:a17:90b:1d0c:b0:280:3911:adfe with SMTP id on12-20020a17090b1d0c00b002803911adfemr15715909pjb.39.1700217699937;
        Fri, 17 Nov 2023 02:41:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6J68BIrvn5CZSlpJZSopT7qMWbenDuyCol5ESBNwFJLL9bN6k6d3CO98T35n7sS2GFVV3Soh28IxqitTAMiw=
X-Received: by 2002:a17:90b:1d0c:b0:280:3911:adfe with SMTP id
 on12-20020a17090b1d0c00b002803911adfemr15715896pjb.39.1700217699557; Fri, 17
 Nov 2023 02:41:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116160235.2708131-1-neal@gompa.dev> <20231116160235.2708131-2-neal@gompa.dev>
In-Reply-To: <20231116160235.2708131-2-neal@gompa.dev>
From: Eric Curtin <ecurtin@redhat.com>
Date: Fri, 17 Nov 2023 10:41:02 +0000
Message-ID: <CAOgh=FxPJay6dw0-O8Kk85oO2tAze7kSo_jWuF5gmA1MAh1Row@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] btrfs-progs: mkfs: Enforce 4k sectorsize by default
To: Neal Gompa <neal@gompa.dev>
Cc: Linux BTRFS Development <linux-btrfs@vger.kernel.org>, Anand Jain <anand.jain@oracle.com>, 
	Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.cz>, 
	Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Davide Cavalca <davide@cavalca.name>, Jens Axboe <axboe@fb.com>, Asahi Lina <lina@asahilina.net>, 
	Asahi Linux <asahi@lists.linux.dev>, Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Nov 2023 at 16:10, Neal Gompa <neal@gompa.dev> wrote:
>
> We have had working subpage support in Btrfs for many cycles now.
> Generally, we do not want people creating filesystems by default
> with non-4k sectorsizes since it creates portability problems.
>
> Signed-off-by: Neal Gompa <neal@gompa.dev>
>
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Makes sense to me!

Reviewed-by: Eric Curtin <ecurtin@redhat.com>

Is mise le meas/Regards,

Eric Curtin

> ---
>  Documentation/Subpage.rst    | 17 +++++++++--------
>  Documentation/mkfs.btrfs.rst | 13 +++++++++----
>  mkfs/main.c                  |  2 +-
>  3 files changed, 19 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/Subpage.rst b/Documentation/Subpage.rst
> index c762b6a3..1655ae7e 100644
> --- a/Documentation/Subpage.rst
> +++ b/Documentation/Subpage.rst
> @@ -9,18 +9,19 @@ to the exactly same size of the block and page. On x86_64 this is typically
>  pages, like 64KiB on 64bit ARM or PowerPC. This means filesystems created
>  with 64KiB sector size cannot be mounted on a system with 4KiB page size.
>
> -While with subpage support systems with 64KiB page size can create
> -and mount filesystems with 4KiB sectorsize.  This still needs to use option "-s
> -4k" option for :command:`mkfs.btrfs`.
> +Since v6.7, filesystems are created with a 4KiB sectorsize by default,
> +though it remains possible to create filesystems with other page sizes
> +(such as 64KiB with the "-s 64k" option for :command:`mkfs.btrfs`). This
> +ensures that new filesystems are compatible across other architecture
> +variants using larger page sizes.
>
>  Requirements, limitations
>  -------------------------
>
> -The initial subpage support has been added in v5.15, although it's still
> -considered as experimental, most features are already working without problems.
> -On a 64KiB page system filesystem with 4KiB sectorsize can be mounted and used
> -as usual as long as the initial mount succeeds. There are cases a mount will be
> -rejected when verifying compatible features.
> +The initial subpage support has been added in v5.15. Most features are
> +already working without problems. On a 64KiB page system, a filesystem with
> +4KiB sectorsize can be mounted and used as long as the initial mount succeeds.
> +Subpage support is used by default for systems with a non-4KiB page size since v6.7.
>
>  Please refer to status page of :ref:`status-subpage-block-size` for
>  compatibility.
> diff --git a/Documentation/mkfs.btrfs.rst b/Documentation/mkfs.btrfs.rst
> index 7e23b9f6..be4f49cb 100644
> --- a/Documentation/mkfs.btrfs.rst
> +++ b/Documentation/mkfs.btrfs.rst
> @@ -122,10 +122,15 @@ OPTIONS
>  -s|--sectorsize <size>
>          Specify the sectorsize, the minimum data block allocation unit.
>
> -        The default value is the page size and is autodetected. If the sectorsize
> -        differs from the page size, the created filesystem may not be mountable by the
> -        running kernel. Therefore it is not recommended to use this option unless you
> -        are going to mount it on a system with the appropriate page size.
> +        By default, the value is 4KiB, but it can be manually set to match the
> +        system page size. However, if the sector size is different from the page
> +        size, the resulting filesystem may not be mountable by the current
> +        kernel, apart from the default 4KiB. Hence, using this option is not
> +        advised unless you intend to mount it on a system with the suitable
> +        page size.
> +
> +        .. note::
> +                Versions prior to 6.7 set the sectorsize matching to the page size.
>
>  -L|--label <string>
>          Specify a label for the filesystem. The *string* should be less than 256
> diff --git a/mkfs/main.c b/mkfs/main.c
> index d984c995..0570c8f8 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -1384,7 +1384,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>         }
>
>         if (!sectorsize)
> -               sectorsize = (u32)sysconf(_SC_PAGESIZE);
> +               sectorsize = (u32)SZ_4K;
>         if (btrfs_check_sectorsize(sectorsize))
>                 goto error;
>
> --
> 2.41.0
>
>


