Return-Path: <linux-btrfs+bounces-969-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC369814112
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Dec 2023 05:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BD93B21A0A
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Dec 2023 04:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CFE63B3;
	Fri, 15 Dec 2023 04:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RHzg8gZI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32658610D
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Dec 2023 04:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702616363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AzYme2818bmqCqLCCWWTHl63ngKdsCYvGkGhDR+59hU=;
	b=RHzg8gZIMOfzpvqV61wHXHljbr//Yyymi+hcg8tRCmiF9SiSz+dRAmFmmDre2QCbLevPss
	ooMigMWJTk1Cou42lWqP4UYoYmNX96Ve3I360RX7QzBz14hfW56A0AIF3xTj7Ux9zBqRj6
	DbMqLCiLH6mILuDzHEvfRHS8f1A7bCQ=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-9iKthcBoMEqS8wYUad65_A-1; Thu, 14 Dec 2023 23:59:21 -0500
X-MC-Unique: 9iKthcBoMEqS8wYUad65_A-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5c1af03481bso212077a12.1
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Dec 2023 20:59:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702616360; x=1703221160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzYme2818bmqCqLCCWWTHl63ngKdsCYvGkGhDR+59hU=;
        b=EElN8Na93JljdWI+d1Pien6RWVfUOl3iTVv6lTBcXnzPrEfP2wPWTrnpxdmB6PjGbn
         vdejjoloO0HQQuzUmVNYg0wMEBS5TWRJFF99/borQZB+7g+JEOOqw7GQVT0AUuWLpV4I
         E5Flc9bwBtZcG/tCKcpynQ309nttUILbKIme3KTvrM0U744sbCpg8pj1urgj8fHWHkBJ
         3YvRgNSwlB7oAyC8qiaTuvyAFy3QjzKKez96U8z+7eiPYjSbjyHKAbSU+2GF29+rFLMd
         S/Lzqz2emcCXuR4nGgnlSbJg2LxZl7t/liWB9oBxJFzxMCf/+wYaDL17JYFSK9Ya1nbo
         Jw5g==
X-Gm-Message-State: AOJu0YwGojSaeM+H2hTQpsgK7tfc0RyUcajZuHU9GXphCy0lNMLdqDOQ
	CTCbaQfpq12RYQvrbYtQYxnWqUUwFBPuQqGQZMZYWDymMjAGoUewQxSpjMNpY71WVPRyMOBCfks
	yp2YtQ75KLeL/ZVzn0fu2M9Y=
X-Received: by 2002:a17:902:6e02:b0:1d3:2e0d:cd98 with SMTP id u2-20020a1709026e0200b001d32e0dcd98mr4281251plk.105.1702616360025;
        Thu, 14 Dec 2023 20:59:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnoz2UEdlxaBQKCM2RChpGukhSgPgtyB6qTVOlALgIThX4mIW3jmmDxgffckfL7+pFxoPumg==
X-Received: by 2002:a17:902:6e02:b0:1d3:2e0d:cd98 with SMTP id u2-20020a1709026e0200b001d32e0dcd98mr4281250plk.105.1702616359650;
        Thu, 14 Dec 2023 20:59:19 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f54200b001cfc67d46efsm13151258plf.191.2023.12.14.20.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 20:59:19 -0800 (PST)
Date: Fri, 15 Dec 2023 12:59:16 +0800
From: Zorro Lang <zlang@redhat.com>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fstests: filter.btrfs: update
 _filter_transaction_commit()
Message-ID: <20231215045916.3pobm5dlu5snqjps@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20231215030951.449252-1-naohiro.aota@wdc.com>
 <20231215152318.78149dec@echidna>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215152318.78149dec@echidna>

On Fri, Dec 15, 2023 at 03:23:18PM +1100, David Disseldorp wrote:
> On Fri, 15 Dec 2023 12:09:51 +0900, Naohiro Aota wrote:
> ...
> > diff --git a/common/filter.btrfs b/common/filter.btrfs
> > index 02c6b92dfa94..cea9911448eb 100644
> > --- a/common/filter.btrfs
> > +++ b/common/filter.btrfs
> > @@ -70,6 +70,7 @@ _filter_btrfs_device_stats()
> >  
> >  _filter_transaction_commit() {
> >  	sed -e "/Transaction commit: none (default)/d" | \
> > +	sed -e "s/Delete subvolume [0-9]\+/Delete subvolume/g" | \
> >  	sed -e "s/Delete subvolume (.*commit):/Delete subvolume/g"
> >  }
> >  
> 
> 
> Looks fine
> Reviewed-by: David Disseldorp <ddiss@suse.de>
> 
> Nit: the pipe chain can be removed. It might also be a little simpler
> if each version had an independent filter, e.g.
>   sed -e "/Transaction commit: none (default)/d" \
>       -e "s/Delete subvolume [0-9]\+ (.*commit)/Delete subvolume/g" \
>       -e "s/Delete subvolume (.*commit):/Delete subvolume/g"

Yup, we use `sed` as this generally. Although I can help to change that,
but appreciate that if you can do it and make sure it still works.

Thanks,
Zorro

> 


