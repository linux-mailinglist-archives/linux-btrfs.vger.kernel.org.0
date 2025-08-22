Return-Path: <linux-btrfs+bounces-16312-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24120B32566
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Aug 2025 01:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E8D3A205AF
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 23:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C952D3A9E;
	Fri, 22 Aug 2025 23:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="PZ3ZQ+dJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068332356B9
	for <linux-btrfs@vger.kernel.org>; Fri, 22 Aug 2025 23:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755905073; cv=none; b=RWtfg//0o+3JZg1kaJu8gaG4mt3UQXO5M0ihRgAYH62oH2687bOpXENmiSyAEEUa6xU1ARjk1c5N8F/QVsypC1NQsSIE0xi14GbgQOF0CRhAWT19q0/FofXjNzKxhKyZiQ7sz25xjql5OOQl9YN05BIn8S5xiSBLXRQs6vCFHkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755905073; c=relaxed/simple;
	bh=o+wqd4S7sCt3G8iTcnIOEVH5qiciN0TQLUtJAlie5Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKGuaYTQLJa4+uqoaSrhu3kC9ajNrK+qQ3xbGO2W1RFea7K6Nt/VSQnYG/5e9nLGu0YXjtkBAhUbIUn78YYtfbXrUIw/ucY3p5P3Y5IumQeWv1RrX9kEI1ClIty7FTp40SXjFveZW86xUctz6RC8YR18bPz4ViuKie//fuwHduA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=PZ3ZQ+dJ; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b474e8d6d01so1739881a12.0
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Aug 2025 16:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1755905070; x=1756509870; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xBF2Dus+5HPOsTPotuhwmxk+F3+D3fmIWqml9zpAu4M=;
        b=PZ3ZQ+dJf3nh0E3tcCy2WVJmEoh3f4MAswhQ7x+HvMOHvgPgA4XumAeutsvfHgsq8J
         huBNNGtxSxRYLulM4G+KrwE4Ah/e1YHbRzYLTL6DGk5rdwZSh2yLs51EfADHOrl07CHG
         rx+TK6+BRoinR+ITd0+oh5yiiVvK2BqhAFDzDSVVNUPRe0yjsGBvxaeHE/VISQao6nc6
         icuOCS2lCY0TDQFKRMyoBFKAV0R/F2c6+9Jp8UQI1ZVMRqSCl3qq0jFh2L5z9iiiRUxb
         JXh2pm6WKj8g+EcP+mUMKEy4wtE5clAtRsW1tJaUqXXvkVNXlciMi6nhi2sfbdpuxYGa
         xAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755905070; x=1756509870;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xBF2Dus+5HPOsTPotuhwmxk+F3+D3fmIWqml9zpAu4M=;
        b=fuqBGqpko/vjKZ3xoARkmGvxLi+oZchDHdvAWQtrtnQr+ya9jAiAV2iVjHasD3hfQG
         SgBPKrQuBwYh/GodbHJlMBXj/JZv74f5Zb0AOZkCajexowSFcfU8Ci3T29PdGuCJJvKO
         FrK0DX2unWAugQ5wVW72b5Nqlwj7XlofSXqEsOKK+blLAgYuDfEodUx3cFEhskoNu33h
         Ns6sV8KMmNbjYckQigYpCcGsBQ8DPew06x1XTGHacsP3PuljXtqwOouiDoWCX9jza9Pt
         LhtlXsdMfwLCB6xebwybLObSVnC1mZyItOLiGVCOvcVV++vZmbvaxeinPy7EtC372V6a
         iM2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUXCIGhSX5rEtmIh/ZFbyCkd8dnoxo2deWUBOXdpYhb2Gmd5UnD8U0NJHUcClkcFSsn1D73TzIasACrtg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgE/Oiy2Sn/nyeWk52iLkhRwxVOGuIaKjDYChIKaabW74Lfi+X
	Fc59rwsFnkluDK67jr1NVRGXD4KyFcqvNn3GWC9Fuj6g6YIMoovQETNOqYmuqqSXc9U=
X-Gm-Gg: ASbGncu/Kfsuf7sB5d55+KOPS8yOMrf4NiovQK2fDBsIOnGX42s2Jz7BRnm7uq7mgr3
	nnzytyyjaI5445NILkuEprxICu+jhj9SeleTiIqCLkZEPEMh7g8x3eLr/hgtJzI0aHP45babNf6
	ZIHJZ4RuiLhjYnYLHEK+NxOelR4AK7ve3AStB9OJ0QtUPeVBG/nzH41BNm0L5jrtNbAxXJ2g0cK
	43q3kuWNrC9gBAhUaxSJVhHUUyV4m7iBPr1KWS1WTn4MKsHEFF/gQiC2H8NJ6VdZ+7cPBbALYQP
	YvJmP3jLz1yPodhW7PDe0Ny/QsxEkTGs1iSYFNdHV//saoVh9EOpj0TkbULs3wt888Q8kpPddp7
	G4C65X3XyKzG6tgTe4M0ytI3aQqfKWm+uR2c=
X-Google-Smtp-Source: AGHT+IGOPdGEXmRR2mAwVGtXapn/63V76VVuymCG897t1s7z5MRz3prdotm3xnlBD3jmGIw26n4uNw==
X-Received: by 2002:a17:90b:3b92:b0:325:3937:ef95 with SMTP id 98e67ed59e1d1-3253937f223mr3286045a91.15.1755905070027;
        Fri, 22 Aug 2025 16:24:30 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3254aa4fc57sm851669a91.19.2025.08.22.16.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 16:24:29 -0700 (PDT)
Date: Fri, 22 Aug 2025 16:24:27 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Sun YangKai <sunk67188@gmail.com>, clm@fb.com, dsterba@suse.com,
	josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, neelx@suse.com
Subject: Re: [PATCH] btrfs: Accept and ignore compression level for lzo
Message-ID: <aKj8K8IWkXr_SOk_@mozart.vkv.me>
References: <2022221.PYKUYFuaPT@saltykitkat>
 <810d2b19-47ed-4902-bd8d-eb69bacbf0c6@gmx.com>
 <aKiSpTytAOXgHan5@mozart.vkv.me>
 <e9a4f485-3907-4f1e-8a74-2ffde87f3044@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e9a4f485-3907-4f1e-8a74-2ffde87f3044@gmx.com>

On Saturday 08/23 at 07:14 +0930, Qu Wenruo wrote:
> 在 2025/8/23 01:24, Calvin Owens 写道:
> > On Friday 08/22 at 19:53 +0930, Qu Wenruo wrote:
> > > 在 2025/8/22 19:50, Sun YangKai 写道:
> > > > > The compression level is meaningless for lzo, but before commit
> > > > > 3f093ccb95f30 ("btrfs: harden parsing of compression mount options"),
> > > > > it was silently ignored if passed.
> > > > > 
> > > > > After that commit, passing a level with lzo fails to mount:
> > > > >       BTRFS error: unrecognized compression value lzo:1
> > > > > 
> > > > > Restore the old behavior, in case any users were relying on it.
> > > > > 
> > > > > Fixes: 3f093ccb95f30 ("btrfs: harden parsing of compression mount options")
> > > > > Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> > > > > ---
> > > > > 
> > > > >    fs/btrfs/super.c | 2 +-
> > > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> > > > > index a262b494a89f..7ee35038c7fb 100644
> > > > > --- a/fs/btrfs/super.c
> > > > > +++ b/fs/btrfs/super.c
> > > > > @@ -299,7 +299,7 @@ static int btrfs_parse_compress(struct btrfs_fs_context
> > > > > *ctx,>
> > > > >    		btrfs_set_opt(ctx->mount_opt, COMPRESS);
> > > > >    		btrfs_clear_opt(ctx->mount_opt, NODATACOW);
> > > > >    		btrfs_clear_opt(ctx->mount_opt, NODATASUM);
> > > > > 
> > > > > -	} else if (btrfs_match_compress_type(string, "lzo", false)) {
> > > > > +	} else if (btrfs_match_compress_type(string, "lzo", true)) {
> > > > > 
> > > > >    		ctx->compress_type = BTRFS_COMPRESS_LZO;
> > > > >    		ctx->compress_level = 0;
> > > > >    		btrfs_set_opt(ctx->mount_opt, COMPRESS);
> > > > > 
> > > > > --
> > > > > 2.47.2
> > > > 
> > > > A possible improvement would be to emit a warning in
> > > > btrfs_match_compress_type() when @may_have_level is false but a
> > > > level is still provided. And the warning message can be something like
> > > > "Providing a compression level for {compression_type} is not supported, the
> > > > level is ignored."
> > > > 
> > > > This way:
> > > > 1. users receive a clearer hint about what happened,
> > > 
> > > I'm fine with the extra warning, but I do not believe those kind of users
> > > who provides incorrect mount option will really read the dmesg.
> > > 
> > > > 2. existing setups relying on this behavior continue to work,
> > > 
> > > Or let them fix the damn incorrect mount option.
> > 
> > You're acting like I'm asking for "compress=lzo:iamafancyboy" to keep
> > working here. I think what I proposed is a lot more reasonable than
> > that, I'm *really* surprised you feel so strongly about this.
> 
> Because there are too many things in btrfs that are being abused when it was
> never supposed to work.
> 
> You are not aware about how damaging those damn legacies are.
> 
> Thus I strongly opposite anything that is only to keep things working when
> it is not supposed to be in the first place.
> 
> I'm already so tired of fixing things we should have not implemented a
> decade ago, and those things are still popping here and there.
> 
> If you feel offended, then I'm sorry but I just don't want bad examples
> anymore, even it means regression.

I'm not offended Qu. I empathize with your point of view, I apologize if
I came across as dismissive earlier.

I think trivial regression fixes like this can actually save you pain in
the long term, when they're caught as quickly as this one was. I think
this will prevent a steady trickle of user complaints over the next five
years from happening.

I can't speak for anybody else, but I'm *always* willing to do extra
work to deal with breaking changes if the end result is that things are
better or simpler. This just seems to me like a case where nothing
tangible is gained by breaking compatibility, and nothing is lost by
keeping it.

I'm absolutely not arguing that the mount options should be backwards
compatible with any possible abuse, this is a specific exception. Would
clarifying that in the commit message help? I understand if you're
concerned about the "precedent".

> > In my case it was actually little ARM boards with an /etc/fstab
> > generated by templating code that didn't understand lzo is special.
> > 
> > I'm not debating that it's incorrect (I've already fixed it). But given
> > that passing the level has worked forever, I'm sure this thing sitting
> > on my desk right now is not the only thing in the world that assumed it
> > would keep working...
> > 
> > > I'm fine with warning, but the mount should still fail.
> > > Or those people will never learn to read the doc.
> > 
> > The warning is pointless IMHO, it's already obvious why it failed. My
> > only goal was to avoid breaking existing systems in the real world when
> > they upgrade the kernel.
> > 
> > If you'd take a patch that makes it work with a WARN(), I'll happily
> > send you that. But I'm not going to add the WARN() and keep it failing:
> > if that's all you'll accept, let's just drop it.
> > 
> > Thanks,
> > Calvin
> > 
> > > > 3. the @may_have_level semantics remain consistent.
> > > > 
> > > > 
> > 
> 

