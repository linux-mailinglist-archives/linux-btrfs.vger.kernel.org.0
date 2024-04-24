Return-Path: <linux-btrfs+bounces-4520-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 517E18B0C6C
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 16:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05EAD288A61
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 14:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE25C15E5D1;
	Wed, 24 Apr 2024 14:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VpbTXBvM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAEA15D5C0
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Apr 2024 14:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713968648; cv=none; b=H9SbcOFgLfrFfkwSs+rtBIOk64ZXQUqBD7dPrSQ2NhpqpFxFbMGCkJYD6F+y6YLE38E4olqBzhG89slcpJ+HfSnnW+yfSmUYUPGp/LMderokniI9yqILoYIwrsM658ZEuE1Kia8OkezAU9ZakhFhMJbNHxngP0qOtoXsQNGqddg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713968648; c=relaxed/simple;
	bh=0llEGKkwxSECjp38KpeBbaalQ6Ta/RRX1nxrXLOLFxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUeiT+vjpTd25ktjW9OdQ+4q+jNee61t31kewj6wBKf/+Hl7E/EULobAz9p+RXXuzdj54v7K/L0/Lk93z01gwOZpkmIGtH2aBwbmi2qD8xFf+5zXB+oZo1iutNEcW92L8BSfEcKzgsz8CWUl6zlJtJ9IsBDxjWg+zM2/R5IIhfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VpbTXBvM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713968645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CijgBuqpinbwWpr6/n739zJMWlXp4vcjh+ibzWbPTCM=;
	b=VpbTXBvMFnY6jDJExaCqvLrzk1t0T4xb357dRWYxTzxHqBre0VhqEY1OuRvS/Rza5rFuNX
	j2uR5C2vT6C7ystwZMIf2BwMpxa7LojTfzuQaRGsgRyWIXcClLfvyeFqYAceHUV2/3bn+/
	M0ZTf70RA7tV2hsb6Y0exbQMFjSzrBY=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-3C1DAYdLOrm_tn7RmKRfMQ-1; Wed, 24 Apr 2024 10:24:03 -0400
X-MC-Unique: 3C1DAYdLOrm_tn7RmKRfMQ-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1e8d6480f77so61514605ad.3
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Apr 2024 07:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713968642; x=1714573442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CijgBuqpinbwWpr6/n739zJMWlXp4vcjh+ibzWbPTCM=;
        b=Q3vTWBKr8K0aLAWQ6uOUENBM2iJDi9WKTlING6/WSqpXQqBUmN3GCeNBAIy9jNbniB
         kiK4CHz8ggFcZU62GjcUVy/kYNKXZGViOS1Gb2MDqXXwPYG6UhsKzg6llRJUaXieGGxv
         6STLQEavHqZz0e8dAvV1jSn9EkAMM56iDwClaZTCO5z4VGhzVBKr+xPTzVm7VtW0OJDj
         4EtGa27FXpgW5D1hK/cF0Vq78Ot3xCReaY25a9rxvXJzdZeJeogSk6uVj3a2RULkYTUV
         xz9mkglTKmnROboGnTXlxUPrC+8jSd4jW5m0dRY1MHbgONpmy5QqQDc6kImhNhyZOTLc
         q1+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWLPz0hRJ1u0+e2iJMCp0vs4UX56DKxkF4g0t5IALRQfNmuTsRYc1G9tknD5veYmsJVKnF57FXyGIHwDfLDdzbMzOd7QZe5LcGf/BU=
X-Gm-Message-State: AOJu0Yx+bXAKyUGZHBFkrGLWwfm1nIW3JnqKFYzFelo8fE8o+nCXzKMQ
	Wwamy7S6ee200mH1L+ASfJCoh1GCYKj/wirOsiU7/R43w2cGpjMSO7KOqPT6bWmxCE0T7BD5oHQ
	xLi8iD2YUH45R8x57Km+19vSoiKzmerUMvWXQ3e7Vz/tsBD5CJaAO2Wa8HuZ3
X-Received: by 2002:a17:902:e74a:b0:1e4:b051:f870 with SMTP id p10-20020a170902e74a00b001e4b051f870mr3037060plf.24.1713968642268;
        Wed, 24 Apr 2024 07:24:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF55NYo7g3f1cSl6tm2v+1PKGR4pJQi+Qh1RbC8U0nDypc/bN+5yDX6o3jpF5duewXP+66xZw==
X-Received: by 2002:a17:902:e74a:b0:1e4:b051:f870 with SMTP id p10-20020a170902e74a00b001e4b051f870mr3037024plf.24.1713968641665;
        Wed, 24 Apr 2024 07:24:01 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id f15-20020a170902ce8f00b001dd0d0d26a4sm11945427plg.147.2024.04.24.07.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 07:24:01 -0700 (PDT)
Date: Wed, 24 Apr 2024 22:23:57 +0800
From: Zorro Lang <zlang@redhat.com>
To: David Sterba <dsterba@suse.cz>
Cc: Anand Jain <anand.jain@oracle.com>, zlang@kernel.org,
	fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [GIT PULL] fstests: btrfs changes staged-20240418
Message-ID: <20240424142357.gprsxpkufxbhxt4x@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240423220656.4994-1-anand.jain@oracle.com>
 <20240424091243.72n37q2xlwf5hxky@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240424121436.GK3492@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424121436.GK3492@twin.jikos.cz>

On Wed, Apr 24, 2024 at 02:14:36PM +0200, David Sterba wrote:
> On Wed, Apr 24, 2024 at 05:12:43PM +0800, Zorro Lang wrote:
> > On Wed, Apr 24, 2024 at 06:06:43AM +0800, Anand Jain wrote:
> > > (I just realized that the previous attempt to send this PR failed. Resending it now.)
> > > 
> > > Zorro,
> > > 
> > > Several of the btrfs test cases were failing due to a change in the golden
> > > output. The commits here fix them. These patches are on top of the last PR
> > > branch staged-20240414.
> > 
> > Hi Anand,
> > 
> > I found lots of patches in this branch doesn't have RVB. That's not safe, if
> > we always do things like that. We need one single peer review at least, that
> > requirement is low enough I think.
> > 
> > Better to ping btrfs-list or fstests-list or particular reviewers to get
> > review, if some patches missed RVB.
> 
> Anand is maintainer within fstests and I guess he reviews the patches
> when putting them to the branch for merge. Filipe is mentioned as
> reviewer but please don't expect him to reivew each and every patch.

Hi David,

Sure, mostly I trust the pull request from Anand. But this time those patches are
from himself, can we say "I've reviewed the patches from myself"? Is that an
acceptable work process? In other words, should maintainers have the privilege
to merge his own patches without any other review? I'm a bit confused, if that's
acceptable by all of you, especially we just through the "xz backdoor".

> 
> I have a feeling that you're following process of merging patches that
> is maybe modeled after linux kernel, with the multiple branches and
> even merge window (mentioned in previsous PR), but this is IMO
> inadequate for a testsuite where we need quick fixups to test cases to
> be released in a much shorter turnaround.

I try to learn it, but won't follow it totally. Due to fstests is not linux
project, it's small and fast, we can accept quick fixes, but not without
control.

I'm not removing all the patches from his PR. I've merged those patches
which got reviewed. For those un-reviewed patches, I'll try to deal with
them in these 2 days, and try to help to catch the next release.

> 
> I was expecting that if there was a dedicated maintainer for a
> filesystem then things would go smoothly and we could skip formalities
> because the maintainer is expected to do reviews that count too.

Anand is already particular for btrfs part of fstests. But this time the
patches are from him. Anyway, I'll help to review his patches, and merge
them if no more other opinions from btrfs-list.

Thanks,
Zorro

> 


