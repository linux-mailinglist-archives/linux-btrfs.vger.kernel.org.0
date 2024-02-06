Return-Path: <linux-btrfs+bounces-2157-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF76684B673
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 14:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64CA3B2521D
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 13:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B161131721;
	Tue,  6 Feb 2024 13:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E3Z5I9o8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F07D130ADC
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Feb 2024 13:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707226364; cv=none; b=ANizfGxip6L9KG4Q4TeSyBg0U2eHVmvYzQ8T1WHJgZTIVjf+SG6BDyhp6kpXdRf9V/eu2NYmTGbWdLI57tG7n6tL+aYQsZ50XYErc1GvLRyWbu0Sn2N8pmUI9s2bl2nJaas89rEIrvfcnNtJ/8jjRvNkMMuPt21QyNZoBhR00MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707226364; c=relaxed/simple;
	bh=SwHkAnz8ehUJIMgNPrGGQyE1nHrQwB1Z05/0ybQ3ypA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jziR5ihRkxgqVpOGpA5NZ7IKy0uq7vYYSBcqWaeyZmT+MEsJhXzqJPBrm5h8FGqaJNYwLDkEwYwtjhGgPd24CUfwWwMTrlP3D1b8hatskCFl4Zv7+xUH0mtnSwbuwyzYf0JjIiAVd4jMY69Fdrx0H2vhprPZ1Xkn647f6r8BBIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E3Z5I9o8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707226362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R6UzoqHKwSqz0Lycr7ptpsW/SoDnodm/EqacVsGC3Y4=;
	b=E3Z5I9o8/n3cRBKuXA1bON0rqcZBM9Lr80RGdSgzJa3Sd0jtmzNyhMorlsIfrVAOQnVgqR
	sbDcJKmkNh4y7vtmE+17Jkmq6FOFzGmIBNdlfRm0+jQ+KNUfRXevzjbN9juBmcb5M4jg81
	dDabb9ZNKQEIQGocIcgWIyfEAcsRL64=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-LoqwvLVYNAa8ZuJYdvC8ZA-1; Tue, 06 Feb 2024 08:32:40 -0500
X-MC-Unique: LoqwvLVYNAa8ZuJYdvC8ZA-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1d954057311so51418755ad.2
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Feb 2024 05:32:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707226359; x=1707831159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6UzoqHKwSqz0Lycr7ptpsW/SoDnodm/EqacVsGC3Y4=;
        b=h3AOKpR3eGiHJL+rdnuf1QIm9/LNFNTIYSkTArUFwb1yyQ6thyoTZBJk4fb8WLNsR4
         lCuMDMTllvgGYJxVZxATMcBubCADON1suinTzLuffP7rXLO1q4MRtFwKF5MrT/GuL/8B
         NJAfsCnT8IF52B5ZS209gxtEElYu1pdDZCtTzKX5kjOaRFTYR/bPJbr/AhIQkTHMI5hT
         3lNWqs5TjAqhf4lDkG8QRXQF7bT2BZJq7v0O8jCzJoKP5mT12oXV3pNS5emkTHHw0DGG
         lediOcvVA8tesnI4rMioEMcn/AZKaJYOQAIEmIyxXxTGTtaIuPwOI5/vZrAzvjK+glu8
         64jg==
X-Gm-Message-State: AOJu0Yy1X3jnnNUAvnfhWwPMWHTJImv1ODgqPbnS72YnwQ6yEP/Es78P
	n3nth+WH3wxnB0TufX+BKFd39OcjZPADfjoBKFkMg3dvBd+qPseBcZJZREvkhJ84oJ9/fVAk85Q
	I+x37YwVig1S6Mtv1Na6yQXisK8KIYjWJUIphUNdkisB3miujAl+b8dpHrdMs1upYmQKR
X-Received: by 2002:a17:90a:5646:b0:296:6e5b:1b52 with SMTP id d6-20020a17090a564600b002966e5b1b52mr2325462pji.3.1707226359364;
        Tue, 06 Feb 2024 05:32:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUy0/f/IrvgR01tLKEEX6eKI11M0kepWKOi9wjcVK5/V/Gz+Q7h92y1Y7FD0YhCUqFeQcGdg==
X-Received: by 2002:a17:90a:5646:b0:296:6e5b:1b52 with SMTP id d6-20020a17090a564600b002966e5b1b52mr2325446pji.3.1707226359028;
        Tue, 06 Feb 2024 05:32:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXG3EbpjmLsi5HrZ8WAU0uIXPJBvwgUCwCLDdXY0YmLk8HLIp5xvZ+0YGVhfgpG5XufDxKQfv7qOowxPW+/km73beKGcibv1wo9l6clBj0tDuNgLcmSoDClONpmyjbe/FRSi40i
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id v13-20020a17090abb8d00b002966248d75bsm1563924pjr.49.2024.02.06.05.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 05:32:38 -0800 (PST)
Date: Tue, 6 Feb 2024 21:32:35 +0800
From: Zorro Lang <zlang@redhat.com>
To: David Sterba <dsterba@suse.cz>
Cc: Yang Xu <xuyang2018.jy@fujitsu.com>, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] t_snapshot_deleted_subvolume: add check for
 BTRFS_IOC_SNAP_DESTROY_V2
Message-ID: <20240206133235.rizvxggjnsv2ppcf@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240201042348.147733-1-xuyang2018.jy@fujitsu.com>
 <20240205154907.GH355@twin.jikos.cz>
 <20240206101005.u2mrxlg4pg3cdoxq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240206120201.GL355@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206120201.GL355@twin.jikos.cz>

On Tue, Feb 06, 2024 at 01:02:01PM +0100, David Sterba wrote:
> On Tue, Feb 06, 2024 at 06:10:05PM +0800, Zorro Lang wrote:
> > On Mon, Feb 05, 2024 at 04:49:07PM +0100, David Sterba wrote:
> > > On Wed, Jan 31, 2024 at 11:23:48PM -0500, Yang Xu wrote:
> > > > @@ -20,11 +20,6 @@
> > > >  #define BTRFS_IOCTL_MAGIC 0x94
> > > >  #endif
> > > >  
> > > > -#ifndef BTRFS_IOC_SNAP_DESTROY_V2
> > > > -#define BTRFS_IOC_SNAP_DESTROY_V2 \
> > > > -	_IOW(BTRFS_IOCTL_MAGIC, 63, struct btrfs_ioctl_vol_args_v2)
> > > > -#endif
> > > > -
> > > >  #ifndef BTRFS_IOC_SNAP_CREATE_V2
> > > >  #define BTRFS_IOC_SNAP_CREATE_V2 \
> > > >  	_IOW(BTRFS_IOCTL_MAGIC, 23, struct btrfs_ioctl_vol_args_v2)
> > > > @@ -58,6 +53,11 @@ struct btrfs_ioctl_vol_args_v2 {
> > > >  };
> > > >  #endif
> > > >  
> > > > +#if !HAVE_DECL_BTRFS_IOC_SNAP_DESTROY_V2
> > > 
> > > This is right for AC_CHECK_DECLS. Other macros like AC_CHECK_HEADERS do
> > > not define the HAVE_... in case it's not found so the #if !HAVE_...
> > > would be wrong. Slightly confusing.
> > 
> > Won't AC_CHECK_HEADERS define the HAVE_... ? But how do we get the ...
> > 
> >   /* Define to 1 if you have the <linux/falloc.h> header file. */
> >   #define HAVE_LINUX_FALLOC_H 1
> > 
> > in include/config.h file?
> 
> Yes the HAVE_ macros are defined, just that it actually also defines
> 
> #define HAVE_LINUX_FALLOC_H 0

Oh I didn't find that in my local fstests code (has been built), I got
something likes this in include/config.h (for defined or un-defined):

  /* Define to 1 if you have the <cifs/ioctl.h> header file. */
  /* #undef HAVE_CIFS_IOCTL_H */

  /* Define to 1 if you have the declaration of `BTRFS_IOC_SNAP_DESTROY_V2', and
     to 0 if you don't. */
  #define HAVE_DECL_BTRFS_IOC_SNAP_DESTROY_V2 1

> 
> if not found, unlike other macros result in
> 
> /* #undef HAVE_SOME_FUNCTION */
> 
> What you did will work, the inconsistency is in the autoconf macros.

But I'm not familar with these AC_CHECK things:) Maybe its behavior isn't
sure, AC_CHECK_DECLS is sure to define HAVE_.... to 1, AC_CHECK_HEADERS is
sure to have a definition but not sure what's defined. Do you mean that?

BTW, I think you're not nacking this patch, right? :)

Thanks,
Zorro

> 


