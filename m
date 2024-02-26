Return-Path: <linux-btrfs+bounces-2822-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB79867F8D
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 19:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE6D32955F1
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 18:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137D112EBEA;
	Mon, 26 Feb 2024 18:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yb/9X/mH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5130C12EBC4
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Feb 2024 18:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708970853; cv=none; b=TW/D5LlWuoC51UUq4YOazLH7RSyrBpyt3NNHq1lJ3GUgdN81j2JWjSulzpT68/7dEg/Uwi11zg5wRhUP62HhFiI/o8XPvyX7biKP8/POy5f+sBo4yqwC61hM6HhIYAK8QH3T3+d4JqcuxTgGaAIa1WkOt7mfPXfuGHsiMIrBpKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708970853; c=relaxed/simple;
	bh=k+9pdQXQLhu1gADE7VNhX5nIsCjdAoNtvJT8Q7dGESo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQX+Ts6FI7gk6tbHKKZm3sBT5OspbpI5Zv5yHoPYYnj4XmPtYYAwJJAfv06EocHfzOyidvQnuSbaSoECGAoM6AYny2TmkMtCB5XF0IYJ657JAPT/MRkvFd3kqu3n0mklKbHqRDU+GEu857akbun17bEZgNmR0ksn2utl4WDa0o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yb/9X/mH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708970850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BHWEeo6gkPchWCXcP+12DKyqGyi2WU8dn8uAcENCj1A=;
	b=Yb/9X/mHSy8xbumn/b0rRsfLEKfwi2m0ceEFzOeFfufphMN3gkG/PFhsvL90OWOJI2dHm5
	qBMl84G4M/2B2StGAoolr73AZdECttiZymZkwUPYBozITElsLRMPJ5mniitZV8r4JWk9cR
	eqVXgDNoiL8rdBo4AaM7kLNPvKsZBhc=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-2btk5oODPB2PO0kZA_nT1A-1; Mon, 26 Feb 2024 13:07:28 -0500
X-MC-Unique: 2btk5oODPB2PO0kZA_nT1A-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1dbcbffd853so24453515ad.3
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Feb 2024 10:07:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708970848; x=1709575648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHWEeo6gkPchWCXcP+12DKyqGyi2WU8dn8uAcENCj1A=;
        b=upU5OjBz/VlqHNLzISXIXxAwAeN9IJ0FC2mM5x8bd4aaj5czRK5znSJmvEwjQhvXU5
         qRPpn4LJZB9FP2h0EUBihcZqMflVK3mnIfRMo8GtSEyDWuff2XYJsXbHF6CEXb9wQsFl
         6LMpKwPRxdwbBC0gPz1uKXeuAk49Kb/vqZeIcKfcqqGtBwTAvMKWofu9OBaKNa3RvV7s
         LCXbnWvEVnIuYMlAgcSPZ75SYwRyA+502FlOdXaqukXvf7GeuvMxnq4u8Y1kWLr+GhNy
         P9eDChiwbq5OM5bkJwP3g/mUCVlkZNitTyRe0CsXjkfuGraEGOxkXx4AYz+u8NI36dqH
         LJRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEZK7/QA/HJD63Wnn3jp/Q1hgjiGPjrtDzWE8f9PPaZStehUt8vnBIuEV7InrrWpmGbTQi6xLVhA2Cl9pfa2lO4MJOwiI1Z4ZW0XI=
X-Gm-Message-State: AOJu0Yzs0IW473RWPJc236gR13Y5XQNLGtTnDZ26CoZao9Hx1MLnaJ+6
	bL93cqIgiI36LK2vfI24HQ4Wxwf6E3vC1J9VM2ASG3Sew5PnuxJpMTAnnkZmUWTaSXCdwh8XCBJ
	2iJyEGae9P1gmXWKRz6YTUZkt427Y18kZsbpQ1MsBcPeE9j0FqJBcSmNJ+V0m
X-Received: by 2002:a17:902:654a:b0:1dc:afd1:9c37 with SMTP id d10-20020a170902654a00b001dcafd19c37mr1169931pln.24.1708970847748;
        Mon, 26 Feb 2024 10:07:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKy1YCX6iEOgyTMy5XQhCVEkUXOlx7hnxY9IpY+j5ouxh7OMq1KLporovDtdlY1lLmPogqAg==
X-Received: by 2002:a17:902:654a:b0:1dc:afd1:9c37 with SMTP id d10-20020a170902654a00b001dcafd19c37mr1169914pln.24.1708970847220;
        Mon, 26 Feb 2024 10:07:27 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x2-20020a170902820200b001da34166cd2sm4226795pln.180.2024.02.26.10.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 10:07:26 -0800 (PST)
Date: Tue, 27 Feb 2024 02:07:23 +0800
From: Zorro Lang <zlang@redhat.com>
To: David Sterba <dsterba@suse.cz>
Cc: David Sterba <dsterba@suse.com>, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] generic/733: disable for btrfs
Message-ID: <20240226180723.v4vwjts4dxndifaq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240222095048.14211-1-dsterba@suse.com>
 <20240225154123.pswx5nznphszonns@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240226113340.GA17966@suse.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226113340.GA17966@suse.cz>

On Mon, Feb 26, 2024 at 12:33:40PM +0100, David Sterba wrote:
> On Sun, Feb 25, 2024 at 11:41:23PM +0800, Zorro Lang wrote:
> > On Thu, Feb 22, 2024 at 10:50:48AM +0100, David Sterba wrote:
> > > This tests if a clone source can be read but in btrfs there's an
> > > exclusive lock and the test always fails. The functionality might be
> > > implemented in btrfs in the future but for now disable the test.
> > > 
> > > CC: Josef Bacik <josef@toxicpanda.com>
> > > Signed-off-by: David Sterba <dsterba@suse.com>
> > > ---
> > >  tests/generic/733 | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/tests/generic/733 b/tests/generic/733
> > > index d88d92a4705add..b26fa47dad776f 100755
> > > --- a/tests/generic/733
> > > +++ b/tests/generic/733
> > > @@ -18,7 +18,7 @@ _begin_fstest auto clone punch
> > >  . ./common/reflink
> > >  
> > >  # real QA test starts here
> > > -_supported_fs generic
> > > +_supported_fs generic ^btrfs
> > 
> > If only need a blacklist, you can write "^btrfs" directly, e.g.
> > 
> >   _supported_fs ^btrfs
> > 
> > then others (except btrfs) are in whitelist, don't need the "generic".
> 
> Ok thanks, do I need to resend or would you update the commit?

I can help to change that, it's simple enough.

Thanks,
Zorro

> 


