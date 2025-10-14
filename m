Return-Path: <linux-btrfs+bounces-17790-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA138BDBA4B
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 00:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB78F19A2B7B
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Oct 2025 22:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB2230E0E1;
	Tue, 14 Oct 2025 22:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="AfMX25/0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEB230DD3B
	for <linux-btrfs@vger.kernel.org>; Tue, 14 Oct 2025 22:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760480690; cv=none; b=X+hO9HfGEpnF3urEQoTP9/IrKwhKnQrLhHu1DdZ4b5whhwx9/CbzijC0hFvM/V+hdpT3uOq/1n2rni9j4oEGGAuvFmhpQr/65QjZCyXDkhajgm46XnpotKMt2tM6gh6vOQM61TzpHPFHQIxwk7HhX/5C4u/OEPNyyvqRElq6nj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760480690; c=relaxed/simple;
	bh=pKj7nF9FZa4CVDaaC2vI4eiSd7iIaOqkYyjB/cLYWWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQB3mL8GcJNkIto3EM7tACLuXs9KJsMCMej50lLkkZ88SQkw/WHnWUUzHhR/+5iLnmI3ZXFbqoa7wT50dPEymKRg+BBPHeqFoaO5JxqlzrLMX+kJZwUmil2MTaQo4nj0qFKmifCIPj1gcRrFbafr+Ew7RlkBOKqR0AMHOem58Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=AfMX25/0; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-273a0aeed57so4939275ad.1
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Oct 2025 15:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1760480686; x=1761085486; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VU+E0coYgVNDVEMZPHxDysYf7EYOnkoJs7l4tPFgGSs=;
        b=AfMX25/0TQzmfcK/hscJ/q3U1LCZyIWKBrZlsvKyPAR8npiNzUhA7zKLKIpddTmQSv
         cppG1JWC8OFzVe3Io5LtQmNqohuwswlqTo7m/Zea0F39qHlI+yiFHn3tY3RCEHJoi73x
         jeFSNIJsxuGX5bo+T5a+5Ek00nt3obBxS9MPQZlzvNJkDrMtKwtqnIaWuSyRImJn+48+
         2KBopwAIZnehbvBHu8dDgovTpqKFMDAn5cRl8y+5yboBfI7cOPLF5oJYtxM4iIGdf1Zx
         afn47a2S3QStZ+wPAeWvTNTKWMZQVIaT9zy2jH185heb7Fsiiz0dNu/yrA/UKPwnAInh
         sfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760480686; x=1761085486;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VU+E0coYgVNDVEMZPHxDysYf7EYOnkoJs7l4tPFgGSs=;
        b=QVhZTqgESMDUPdPyk5wCOAn5hOlHXk+BY9evyRpBHh7UHFQgZSzmZOPkeBoQhUYJhJ
         IW+8C+PfEqd+n267CponjwvOVTYugR8SrvOrEaItazfyoQyS/fghTYV9pz9MxdAz/OYm
         g3duq+2BBvFQTvLW7K2eMK7Izxzi4pptmDRtH9XcQbJtLhG9DQhk/sRPrwyrbPGWYP6T
         VYaWgeiuTClWd0rzg11ydml2b5/cR6sKuC6UhXnQRJFEBCFcmxRF6jnzx516wjZMwu91
         LpX5SHP8M/MePGgAkWZbv/D852xfEms0VSBnJyp9+nc5Bo+fSIXsUkkP0Ha4GJqb0cUl
         wL9g==
X-Forwarded-Encrypted: i=1; AJvYcCXOPW1LhX78bioVKQVMeA0of02YLSsjB/lUBivEDdjmxDkFv7QWkVzC0tzskY2WQ3RwHe2zWKTAOg+gDA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd8+gXIvszN56sGAEOmKyBAVvDtSb8S8da8nhM0+QzOo16LUDB
	lPuVtVHJ6/uw4/1zwgULkgeSKo4mopayDrgivdkWPl5gWdvFDveY8djchyp+AaTe1kc=
X-Gm-Gg: ASbGnctE3j660jrhM1p1HR1OhD1fiEweamCkyNQfUvzpWL1k5X8S/kGQgYhHE4XQQ9Y
	D9UIjs5wQhNauIrDRR2y5tg8jZlkOxh2IbRprc/kwK0rOrcmsfMzxXvCA9e8byQdegNu2Jbvmdb
	AmIVMiON+TXbb8uizhUqUElrxqTVqwI+HmAfZKJPZXH8iGjHkv1OuOEENp2ksmXsqgGJmm1BNrO
	8uVfP4ZfSyvA16czwETUs74oeahMlO4R8PkjwA94+FrMJDEENuA2t8nCbJKEMYBFQHN7v9eqQi3
	5+Pjwmq8GundQdBpWQhUofnLcZIHduDhZZhqDfVGDXBT9BFVkb1Gy6a0nOrgSjdo3oan6M9353F
	7zYmQWdzw7pCr4eBZlfhvXtS4NETjO9iECaAM3BNNR70dN7Hfm0WkoArS90Y0cLSjfrEhjQ5uaD
	bKtiYrcGGFv66wPZcWXGDifImDW2o=
X-Google-Smtp-Source: AGHT+IEuiPLT+J2EGWyWH8Vlz1fhWHzXLhUTSRvMJ8Bb23RFgsXxsIuVuGY50FOYvF4QcobNAuFtTQ==
X-Received: by 2002:a17:903:2acb:b0:265:e815:fcdf with SMTP id d9443c01a7336-28ec9c9741bmr395484345ad.17.1760480685978;
        Tue, 14 Oct 2025 15:24:45 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b69c24043desm955564a12.3.2025.10.14.15.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 15:24:45 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1v8nRi-0000000Etua-2BV8;
	Wed, 15 Oct 2025 09:24:42 +1100
Date: Wed, 15 Oct 2025 09:24:42 +1100
From: Dave Chinner <david@fromorbit.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jan Kara <jack@suse.cz>, brauner@kernel.org, viro@zeniv.linux.org.uk,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com, kernel-team@fb.com, amir73il@gmail.com,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v7 03/14] fs: provide accessors for ->i_state
Message-ID: <aO7NqqB41VYCw4Bh@dread.disaster.area>
References: <20251009075929.1203950-1-mjguzik@gmail.com>
 <20251009075929.1203950-4-mjguzik@gmail.com>
 <h2etb4acmmlmcvvfyh2zbwgy7bd4xeuqqyciqjw6k5zd3thmzq@vwhxpsoauli7>
 <CAGudoHFJxFOj=cbxcjmMtkzXCagg4vgfmexTG1e_Fo1M=QXt-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHFJxFOj=cbxcjmMtkzXCagg4vgfmexTG1e_Fo1M=QXt-g@mail.gmail.com>

On Fri, Oct 10, 2025 at 05:51:06PM +0200, Mateusz Guzik wrote:
> On Fri, Oct 10, 2025 at 4:44 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 09-10-25 09:59:17, Mateusz Guzik wrote:
> > > +static inline void inode_state_set_raw(struct inode *inode,
> > > +                                    enum inode_state_flags_enum flags)
> > > +{
> > > +     WRITE_ONCE(inode->i_state, inode->i_state | flags);
> > > +}
> >
> > I think this shouldn't really exist as it is dangerous to use and if we
> > deal with XFS, nobody will actually need this function.
> >
> 
> That's not strictly true, unless you mean code outside of fs/inode.c
> 
> First, something is still needed to clear out the state in
> inode_init_always_gfp().
> 
> Afterwards there are few spots which further modify it without the
> spinlock held (for example see insert_inode_locked4()).
> 
> My take on the situation is that the current I_NEW et al handling is
> crap and the inode hash api is also crap.

The inode hash implementation is crap, too. The historically poor
scalability characteristics of the VFS inode cache is the primary
reason we've never considered ever trying to port XFS to use it,
even if we ignore all the inode lifecycle issues that would have to
be solved first...

> For starters freshly allocated inodes should not be starting with 0,
> but with I_NEW.

Not all inodes are cached filesystem inodes. e.g. anonymous inodes
are initialised to inode->i_state = I_DIRTY.  pipe inodes also start
at I_DIRTY. socket inodes don't touch i_state at init, so they
essentially init i_state = 0....

IOWs, the initial inode state depends on what the inode is being
used for, and I_NEW is only relevant to inodes that are cached and
can be found before the filesystem has fully initialised the VFS
inode.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

