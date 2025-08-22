Return-Path: <linux-btrfs+bounces-16305-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AC0B3225E
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 20:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DB2E623A31
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 18:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762A82BF3E2;
	Fri, 22 Aug 2025 18:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="bJT6xkOJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0471277017
	for <linux-btrfs@vger.kernel.org>; Fri, 22 Aug 2025 18:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755888173; cv=none; b=Iy5dSFPv0VeLwehNSunQZZd/dQYp1sbX4xwA5CvEBvs7zv07vTLIxhVhpBKYdwvPIfQrkf1x3z0jlaoLF2DUWLFJ//WEYho/IidexCmJAuZV8l9U1Q7ma3uc213baM+ITwVhOYdzQ/nDYLV/MBEnCCOdlrsNdkoK1cWQnhSqd3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755888173; c=relaxed/simple;
	bh=HMDU6qnc6XToakMxvLwKRSmVgASNQEzig+IwPzLgNjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=As9OP8eRlK40OUmFITJgaXzUJ8LVcpR7UUCySls1fkY7ZR2sNkt+lHjalsDQHosb574ZdQPqWLo1vQKaKSg3Nl8h4/QfS/ju1+sTaHYpkFVNyF8ZWX28Op1oDqJudrL8x4b4JgF3yXOMhg2NsUhY8XJFk7beG9a5AUnjK2yuQUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=bJT6xkOJ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24646202152so9386155ad.0
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Aug 2025 11:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1755888170; x=1756492970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VRqezcJ9J5RPvnfO+uIE5EjJo7z/UAP8PQZlBAlk17k=;
        b=bJT6xkOJEjXFEdRV+M8HSmrKE/fXB2oHLgCgcd4NEc4LqV2+bYbPZ+8qERBydfXFuS
         foV8Ij3jM6CmFkm6HRVy3ZKMVehL3ifxH0flXVkeYrZ6De27I2iA61NoKwY7XIl1UhyV
         7knwdJnBheOxgSf8Lkw4R8jj31Gei94XUkwzAWHA/Uj6eNmaCRtLHR4bjkQZIPH5sl4O
         /c31c4HBTD/W9u7PoLRZmqPYVa4KZRadw2tN9hNVoy3pe/TU9ashTdyCWo9StNckOZ6x
         IlLwzAWyzdehA+GnvF8K9kuTW+stLhghVy/HV+GuYmDatgDzUUkRog3Mpody1YdJER+D
         wCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755888170; x=1756492970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRqezcJ9J5RPvnfO+uIE5EjJo7z/UAP8PQZlBAlk17k=;
        b=SfYYVmTgk813LciALl4oUcrNJZpxd/kRzfr4J9T8W0Ojb6p3GyCUQgjUBjn8eNbRJ+
         Pd4m3p5i34JByjZNuCHlohwol04P5fTPQIojDL/HVSyjDZ841/GluzIl0vK3+gDNcqoA
         YQKsuua3YeqrGzXa37hwuOM7/R87PCjTuNeT7eHVrVWEe79Bh4+NuSyUomZWoMD5RD92
         SNFxq+G6vjFp59WZ2yg1WFfdxskFlZ7MeCVCGl0q9f8WgmZj+cVY9+1nNHK4BQAtG6A1
         H7rDqW5/84WOV8dzhqSCy5HpaSmm5Deb95O/TfZENLQGicrYz9VjCzH06yt0ks8f/hMZ
         geGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBfWK8lmCEIdfPw8LtzFB1q95o3+ep2KDcaSZpyHYRysxHubmWQzwU2U14LEv8a7tlN16F4LhFgTpO1g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu7EWt2zXt2BIkxvUAbhw/nQZCmLfec6OEnLXwdKQMtr5xheA7
	ajwnfg9Oad+tuL2jYzpB4paAtgNzoMj9SLpHPRivIbIqR8zzsZ6fvDWWY4FZ5XiaXTA=
X-Gm-Gg: ASbGncuacw7+Jp+TFeoLvtwZssTP4sVN65UFhKate7m0TvIBtYh5EqATAWp4HHqBZLF
	YmKQbId3DaLXJO/b8Ydbgv6csiBWgCbNDul0TWxeo5C1pdhY8somzZmyJZeiMQkVtxWSIy/ATMO
	XkJFTf8Hm4XztTiyQki1YEwNMk2qGXOoMM/9bXH7qrjHsaK5oYv8ET/DK9wn10qpPh9zWjLC0wm
	SKGWx+pCvrSp8k8zEoaXz2qPUGzc4lCbcZ/e13zcZ8ZzrXVRxHg7PO/7ljqD079nsK40TpFOUOM
	g8Q75i3zVvpLqxubtwALB/0RJIF918U6VCkuA1HRQH9VSsUrTVTgNtfV22Z41/zmsJeHgGM7zbp
	l49kZhBYrcFJrOgrKGfoGKJCy
X-Google-Smtp-Source: AGHT+IHXhgusmCBljx9j0ynCx//dG3+DQIdpERkIhWbIeVVT8KWK7G8ICDAak5hLnXpQf+JKlRArKA==
X-Received: by 2002:a17:902:dad1:b0:242:befb:b04e with SMTP id d9443c01a7336-2462ee9cbfcmr55698485ad.25.1755888170055;
        Fri, 22 Aug 2025 11:42:50 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324f3908fe3sm2553320a91.1.2025.08.22.11.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 11:42:49 -0700 (PDT)
Date: Fri, 22 Aug 2025 11:42:47 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Sun YangKai <sunk67188@gmail.com>
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	neelx@suse.com, quwenruo.btrfs@gmx.com
Subject: Re: [PATCH] btrfs: Accept and ignore compression level for lzo
Message-ID: <aKi6J2IkGOytAggj@mozart.vkv.me>
References: <a5e0515b8c558f03ba2a9613c736d65f2b36b5fe.1755848139.git.calvin@wbinvd.org>
 <2022221.PYKUYFuaPT@saltykitkat>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2022221.PYKUYFuaPT@saltykitkat>

On Friday 08/22 at 18:20 +0800, Sun YangKai wrote:
> > The compression level is meaningless for lzo, but before commit
> > 3f093ccb95f30 ("btrfs: harden parsing of compression mount options"),
> > it was silently ignored if passed.
> > 
> > After that commit, passing a level with lzo fails to mount:
> >     BTRFS error: unrecognized compression value lzo:1
> > 
> > Restore the old behavior, in case any users were relying on it.
> > 
> > Fixes: 3f093ccb95f30 ("btrfs: harden parsing of compression mount options")
> > Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> > ---
> > 
> >  fs/btrfs/super.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> > index a262b494a89f..7ee35038c7fb 100644
> > --- a/fs/btrfs/super.c
> > +++ b/fs/btrfs/super.c
> > @@ -299,7 +299,7 @@ static int btrfs_parse_compress(struct btrfs_fs_context
> > *ctx,> 
> >  		btrfs_set_opt(ctx->mount_opt, COMPRESS);
> >  		btrfs_clear_opt(ctx->mount_opt, NODATACOW);
> >  		btrfs_clear_opt(ctx->mount_opt, NODATASUM);
> > 
> > -	} else if (btrfs_match_compress_type(string, "lzo", false)) {
> > +	} else if (btrfs_match_compress_type(string, "lzo", true)) {
> > 
> >  		ctx->compress_type = BTRFS_COMPRESS_LZO;
> >  		ctx->compress_level = 0;
> >  		btrfs_set_opt(ctx->mount_opt, COMPRESS);
> > 
> > --
> > 2.47.2
> 
> A possible improvement would be to emit a warning in
> btrfs_match_compress_type() when @may_have_level is false but a
> level is still provided. And the warning message can be something like 
> "Providing a compression level for {compression_type} is not supported, the 
> level is ignored."
> 
> This way:
> 1. users receive a clearer hint about what happened,
> 2. existing setups relying on this behavior continue to work,
> 3. the @may_have_level semantics remain consistent.

Thanks Sun, sorry for not acknowledging your suggestion in my last
response. Repeating what I said there: if it helps get this in, I'm
happy to do it, but it sounds like Qu is pretty fundamentally opposed
to keeping the old behavior.

> 

