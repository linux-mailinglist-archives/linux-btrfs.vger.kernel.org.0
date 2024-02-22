Return-Path: <linux-btrfs+bounces-2648-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 492D385FCFA
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Feb 2024 16:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0044B28D0FE
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Feb 2024 15:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AD61509A6;
	Thu, 22 Feb 2024 15:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="RIEywIvv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233D414E2E8
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Feb 2024 15:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616886; cv=none; b=NkN3UZfcw8owcwN2np6dibsFpOpc+8bexEcI9XZcwnZ0fMZS+B+wPhob2zaMwNWWzquwNdLEpwg3z8BINt2Jw4RMvJ8nyFB6XKwAVoazJf3ef6PpPZiA1NbNw7PLYuTPoKOrm4U8eIaZoSLqAmxKEzvya7n8mdKIv3AY5jasqq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616886; c=relaxed/simple;
	bh=/URg4PQnQQuQavo2tWzU6iVHhXxnRjfAkpj2MvvU244=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIvISMy3yojNr8HlmF1rwCtVcNnwIkSTtf5m0/XLdiRsf44UoT2oPOf5FFekSqggvvJ+qycLhW/jLDbheT2ulk7fUvSJEaNXfVq61Gvp2X8bm6TS1A3aNfYEW/qYrWQ3mIHhnWa6YkKPG7EDqYLAhlb1rMEfMBthLJIOhj47khU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=RIEywIvv; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc238cb1b17so2137784276.0
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Feb 2024 07:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1708616884; x=1709221684; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QIa8oVIZuT7lP1k8X8l2WJQdq609coU/Nz2aGnBWwe4=;
        b=RIEywIvvscu1E8xViuV4ZuAJOikoT2p1+xmOQaCMPZpoQ5BUx/TnMjs2uOiFXVRR5t
         Phh57Z4wdTLREqHqs61NjoO3Iknt5R4e49VX887QUDXR/WQfNIjffCEOLEp+hzX2JfSQ
         7mYiEamFKSWVW4qKy756x+ZdsL850EDSFBQ6aT2vDN0O6LWiu1D1IsEHpKgwq/EUuk+w
         fy1d5afa6gPYlpjt/rxtXtUmLRtfYb4zRb0KJR/wAf/ZwfTJ3VurlPCdyt1ySZZwf7Ey
         MW3R+XNomF88wZDCrC9WcSAzOoWZSHsPQfwAC2w8ZgWdrfCdK4VZeLpiBusKI1ZhDuIb
         BdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708616884; x=1709221684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIa8oVIZuT7lP1k8X8l2WJQdq609coU/Nz2aGnBWwe4=;
        b=E06+f/V9hQx/RfIwaCIZLqPAUbejHqlBiNJKzSJvleRRMRlOC+Q1mRqvzjz93oW+3Q
         zfMLPhP7kFe8IMxqNPNwMqPsA6LoRFBaPMNE1Lt7yIBk3RQ/sFubnTFuzEHM0FEMtMTs
         j8KdiXhdalzjW2Y8mzfNDUU2fYTBCnDe4wTPZ3PT41ntAxSSy1mGwA9Fkdj8BCcmUN4s
         A5TmlECXPtgZ2gmdWgWAf+8g1md1L5tL04OIlXJkCgF54MvtvSZuIZFWPbcUqMO0gICU
         Gsfjak8nwuuo2JorjqiFcKUJ8qwBw23G+khUGVWObXxjuBdkUC8iwjE7577HiQ2G+m3T
         g2HA==
X-Forwarded-Encrypted: i=1; AJvYcCULNgu+1CcyHFrv8gy4XbCGcTLwE1mjCY6D7UzD3lIZsnByzlozeBcW4LCPACPmJm1UEOHUtDAzSKG9+ephq0FZ3P7RiUl/fjPWAnU=
X-Gm-Message-State: AOJu0YxKaqlZ6rm+RhXDVWuBvsyMNSh2qWh5aRZDq5KKhNcdnbpPIF0y
	ktjc4e63l70YEV1AjLuRzEXr3+RDagtMov6me+qofkzQJYQFClEA1dP+dFYlQIE=
X-Google-Smtp-Source: AGHT+IHeRNYTHAQHlTw6FyZDjFXRERNo4oRgHEr44ZmqBtCgNvJrfmcbtG60abBs4SP3t2oerm+vSw==
X-Received: by 2002:a25:8b85:0:b0:dcd:2f2d:7a05 with SMTP id j5-20020a258b85000000b00dcd2f2d7a05mr2616558ybl.35.1708616884094;
        Thu, 22 Feb 2024 07:48:04 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id w131-20020a253089000000b00dc25d5f4c75sm2942698ybw.10.2024.02.22.07.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 07:48:03 -0800 (PST)
Date: Thu, 22 Feb 2024 10:48:02 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	lsf-pc@lists.linux-foundation.org
Subject: Re: [LSF TOPIC] statx extensions for subvol/snapshot filesystems &
 more
Message-ID: <20240222154802.GA1219527@perftesting>
References: <2uvhm6gweyl7iyyp2xpfryvcu2g3padagaeqcbiavjyiis6prl@yjm725bizncq>
 <CAJfpeguBzbhdcknLG4CjFr12_PdGo460FSRONzsYBKmT9uaSMA@mail.gmail.com>
 <20240221210811.GA1161565@perftesting>
 <CAJfpegucM5R_pi_EeDkg9yPNTj_esWYrFd6vG178_asram0=Ew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegucM5R_pi_EeDkg9yPNTj_esWYrFd6vG178_asram0=Ew@mail.gmail.com>

On Thu, Feb 22, 2024 at 10:14:20AM +0100, Miklos Szeredi wrote:
> On Wed, 21 Feb 2024 at 22:08, Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > On Wed, Feb 21, 2024 at 04:06:34PM +0100, Miklos Szeredi wrote:
> > > On Wed, 21 Feb 2024 at 01:51, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> > > >
> > > > Recently we had a pretty long discussion on statx extensions, which
> > > > eventually got a bit offtopic but nevertheless hashed out all the major
> > > > issues.
> > > >
> > > > To summarize:
> > > >  - guaranteeing inode number uniqueness is becoming increasingly
> > > >    infeasible, we need a bit to tell userspace "inode number is not
> > > >    unique, use filehandle instead"
> > >
> > > This is a tough one.   POSIX says "The st_ino and st_dev fields taken
> > > together uniquely identify the file within the system."
> > >
> >
> > Which is what btrfs has done forever, and we've gotten yelled at forever for
> > doing it.  We have a compromise and a way forward, but it's not a widely held
> > view that changing st_dev to give uniqueness is an acceptable solution.  It may
> > have been for overlayfs because you guys are already doing something special,
> > but it's not an option that is afforded the rest of us.
> 
> Overlayfs tries hard not to use st_dev to give uniqueness and instead
> partitions the 64bit st_ino space within the same st_dev.  There are
> various fallback cases, some involve switching st_dev and some using
> non-persistent st_ino.
> 
> What overlayfs does may or may not be applicable to btrfs/bcachefs,
> but that's not my point.  My point is that adding a flag to statx does
> not solve anything.   You can't just say that from now on btrfs
> doesn't have use unique st_ino/st_dev because we've just indicated
> that in statx and everything is fine.   That will trigger the
> no-regressions rule and then it's game over.  At least I would expect
> that to happen.

Right, nobody is arguing that.  Our plan is to

1) Introduce some sort of statx mechanism to expose this information.
2) Introduce an incompat fs feature flag to give unique inode numbers for people
   that want them, and there stop doing the st_dev thing we currently do.
3) Continue doing the st_dev thing we currently do for the non-feature flag
   case.
4) Wait 50 years and then maybe stop doing the st_dev thing once people have
   adopted whatever statx flag has been introduced.  God willing I will have
   been hit by a bus well before then.

Nobody is arguing about reverting existing behavior, we're stuck with it.

We're trying to define how we'd like it to look going forward, and start working
towards that.  Thanks,

Josef

