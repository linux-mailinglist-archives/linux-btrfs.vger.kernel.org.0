Return-Path: <linux-btrfs+bounces-2161-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 610E084B9EF
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 16:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4A17B2DE5F
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 15:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44305133404;
	Tue,  6 Feb 2024 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X90fY9g4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8E31E521
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Feb 2024 15:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707233544; cv=none; b=uiZ82Gv0olWIaPl2Eg9XlxOmATOzxIK6P1Y/FxGpFG5Msu3SZEcvyjOeB6TQu9RX3jBOCn7UmoXNoS1+OcnBWhoyyhuFUIrkgy304GXL9BtriZWUASV+P6K0okz20MjstlUnWZBE8AAe8qbEy8BzAbDZye2ctfia5W7s1009dQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707233544; c=relaxed/simple;
	bh=htugNKRtAjDwWUOcNqrI1Z/+Fg56uIKOC2oofj1LI8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=maHLsKXmvGcFr116T94jkK11HOROFnZUP4+MshSyiSRdyKKp1rLjiwqYUfGJdgFC/EKEfKS2ZFO2NHYt/H5nzxQ5vHwf8y5kAu1HrOM2y7+fMeSDigJUlfiNR2tb57OeAmgyj+8R/6F10n5n+gXQhKfmPK9haPXM1ZCoBHLvYcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X90fY9g4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707233541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TwNbIvQp9WKki6i/Bhj1rpyc5/m7hrq9Fqpz1dobI6s=;
	b=X90fY9g4u6H+ACXFwHoqaOZgnCBz/2k8+/MTIMfotzN6tKDtHDlMLlStwx3xxPyHJ8W9tq
	+Wmx1SpXLbqvLJkWSl1fRSIGiWExuetfTpqtObnC5E3izqbETV7WXoucUwCCNp0rn+oYQj
	kaumBWLct2W2RNTL4gOZWmVC2B0IdoQ=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-jDXgJ7oCMEWYLrioGvWkUA-1; Tue, 06 Feb 2024 10:32:19 -0500
X-MC-Unique: jDXgJ7oCMEWYLrioGvWkUA-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-363b6ee24d3so29647175ab.2
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Feb 2024 07:32:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707233538; x=1707838338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwNbIvQp9WKki6i/Bhj1rpyc5/m7hrq9Fqpz1dobI6s=;
        b=RQnzER0JK07KUDutlRQEGgcyAV44h5eAOWcIBxo9HTescmRYtNZCtqXWApG2xZ/Mxr
         cLtTU4hrnd5P47K4Qg8ZbdRnPW846F5zRhubtgt528PYwwwrsJKNvI56Rg6jPpj05c5g
         AEudyCna7Jp/o6u1BlreSMWzJQXfaZ5K9vTM3znug1b71slMx4nCxyHY1fE1TgA9SxY9
         USssZP7MR/mYubLgYmDryOjvp7yY334PwbopIHp0JCwYddqA83crTXNFBTIhnEDcnpax
         kRhXusGatchA+vMDEorHBFDoMBZZJlYqFkXnfrQ3LMWGHt24XqEa/yVRUB/nMyvDm8lk
         JM8A==
X-Gm-Message-State: AOJu0YxRP+cpD+OsH8faKzRxRl0j65iidXECQedOyTwggH55W1mEZDq5
	pNgSsGGUHZ9F+shgmgsBPcaWMllBCkMPxiCFILd+HbBBVF/mr9rdj4/B1WFPO47TEPS+1sSiSLB
	T6ZUV5vUvwOtfgNI7LyoLmcjfDTkLfZ9NZvQfVLqvSlitMLcukFdAKggXvzka
X-Received: by 2002:a92:cf0f:0:b0:363:bf96:560 with SMTP id c15-20020a92cf0f000000b00363bf960560mr3195992ilo.15.1707233538739;
        Tue, 06 Feb 2024 07:32:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFk3nAsAhunUYLoB5bLEdrBenTx/Cn1YVJ9bMn8wV9vdazRRbMwlmytflY1NKryKxbAOhn7uw==
X-Received: by 2002:a92:cf0f:0:b0:363:bf96:560 with SMTP id c15-20020a92cf0f000000b00363bf960560mr3195980ilo.15.1707233538481;
        Tue, 06 Feb 2024 07:32:18 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVRxCocyMNjTKcRwK8mYBcPOVJm3H8A0Q7kLXU/aBSXy9xjOY1SgjyCptTtZZJgsRo+8aC3hBI7ZvW/Rcmi2dkqkY7OzGPl+SOvbQ1oTAqCYraYEdy40NATNBn0eb1Amn7oEEm8
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id e3-20020a63db03000000b005d66caee3d0sm2249168pgg.22.2024.02.06.07.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 07:32:18 -0800 (PST)
Date: Tue, 6 Feb 2024 23:32:14 +0800
From: Zorro Lang <zlang@redhat.com>
To: David Sterba <dsterba@suse.cz>
Cc: Yang Xu <xuyang2018.jy@fujitsu.com>, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] t_snapshot_deleted_subvolume: add check for
 BTRFS_IOC_SNAP_DESTROY_V2
Message-ID: <20240206153214.kskmv2ug7b7rmtdq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240201042348.147733-1-xuyang2018.jy@fujitsu.com>
 <20240205154907.GH355@twin.jikos.cz>
 <20240206101005.u2mrxlg4pg3cdoxq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240206120201.GL355@twin.jikos.cz>
 <20240206133235.rizvxggjnsv2ppcf@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240206134713.GO355@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206134713.GO355@twin.jikos.cz>

On Tue, Feb 06, 2024 at 02:47:13PM +0100, David Sterba wrote:
> On Tue, Feb 06, 2024 at 09:32:35PM +0800, Zorro Lang wrote:
> > On Tue, Feb 06, 2024 at 01:02:01PM +0100, David Sterba wrote:
> > > On Tue, Feb 06, 2024 at 06:10:05PM +0800, Zorro Lang wrote:
> > > > On Mon, Feb 05, 2024 at 04:49:07PM +0100, David Sterba wrote:
> > > > > On Wed, Jan 31, 2024 at 11:23:48PM -0500, Yang Xu wrote:
> > > > > > @@ -20,11 +20,6 @@
> > > > > >  #define BTRFS_IOCTL_MAGIC 0x94
> > > > > >  #endif
> > > > > >  
> > > > > > -#ifndef BTRFS_IOC_SNAP_DESTROY_V2
> > > > > > -#define BTRFS_IOC_SNAP_DESTROY_V2 \
> > > > > > -	_IOW(BTRFS_IOCTL_MAGIC, 63, struct btrfs_ioctl_vol_args_v2)
> > > > > > -#endif
> > > > > > -
> > > > > >  #ifndef BTRFS_IOC_SNAP_CREATE_V2
> > > > > >  #define BTRFS_IOC_SNAP_CREATE_V2 \
> > > > > >  	_IOW(BTRFS_IOCTL_MAGIC, 23, struct btrfs_ioctl_vol_args_v2)
> > > > > > @@ -58,6 +53,11 @@ struct btrfs_ioctl_vol_args_v2 {
> > > > > >  };
> > > > > >  #endif
> > > > > >  
> > > > > > +#if !HAVE_DECL_BTRFS_IOC_SNAP_DESTROY_V2
> > > > > 
> > > > > This is right for AC_CHECK_DECLS. Other macros like AC_CHECK_HEADERS do
> > > > > not define the HAVE_... in case it's not found so the #if !HAVE_...
> > > > > would be wrong. Slightly confusing.
> > > > 
> > > > Won't AC_CHECK_HEADERS define the HAVE_... ? But how do we get the ...
> > > > 
> > > >   /* Define to 1 if you have the <linux/falloc.h> header file. */
> > > >   #define HAVE_LINUX_FALLOC_H 1
> > > > 
> > > > in include/config.h file?
> > > 
> > > Yes the HAVE_ macros are defined, just that it actually also defines
> > > 
> > > #define HAVE_LINUX_FALLOC_H 0
> > 
> > Oh I didn't find that in my local fstests code (has been built), I got
> > something likes this in include/config.h (for defined or un-defined):
> > 
> >   /* Define to 1 if you have the <cifs/ioctl.h> header file. */
> >   /* #undef HAVE_CIFS_IOCTL_H */
> > 
> >   /* Define to 1 if you have the declaration of `BTRFS_IOC_SNAP_DESTROY_V2', and
> >      to 0 if you don't. */
> >   #define HAVE_DECL_BTRFS_IOC_SNAP_DESTROY_V2 1
> > 
> > > 
> > > if not found, unlike other macros result in
> > > 
> > > /* #undef HAVE_SOME_FUNCTION */
> > > 
> > > What you did will work, the inconsistency is in the autoconf macros.
> > 
> > But I'm not familar with these AC_CHECK things:) Maybe its behavior isn't
> > sure, AC_CHECK_DECLS is sure to define HAVE_.... to 1, AC_CHECK_HEADERS is
> > sure to have a definition but not sure what's defined. Do you mean that?
> > 
> > BTW, I think you're not nacking this patch, right? :)
> 
> No I'm not, sorry if this was confusing, it was a comment about the
> autoconf macros and how are the defines supposed to be checked. We once
> had a bug where
> 
> #ifdef MACRO
> 
> vs
> 
> #if MACRO
> 
> was not doing the same thing because of the sometimes/always defined
> semantics.

Sure, thanks for this clarification, and the double checking from you :)

> 


