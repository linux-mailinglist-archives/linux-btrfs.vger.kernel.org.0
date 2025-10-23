Return-Path: <linux-btrfs+bounces-18230-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 700DCC03D53
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 01:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44AA31A67AF2
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 23:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F692D94AD;
	Thu, 23 Oct 2025 23:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azDWi5dA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2867A2D8DCF
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 23:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761262062; cv=none; b=cryXPK7Rcng54PGdkBmwQpWCbYS3IPu8E98yzFcrq+LK8OQLKmHcCtkSAePPA2Ma9B+wUSEBpbydG93pAIqfzkbdwPH5dXUNDJKY9EbI+ZUQeyTD4lmeUJSJKo5+K2Wlp/S7/27vqjNXQ7YMcAu9huZ7YpUZ4hFVTQFcrqFDLwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761262062; c=relaxed/simple;
	bh=oLWB1JjIUniwvSP94WAi+kNR8LYJj6M2eqjRoyXYKDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UTVgEAUXICvcvt+nC3MSpX3UYPsJXKLp8Yiz5v+vJqk+eOdfgw3I7+ddtb5L1KuzZsJ/h/yRCKv0+fnEwQCPcdObYE3NVwMD6C5OW8z/97FyLJTDVJo+oRxSes2Acj/7pGRGP/9eoT27MORkLPkYS/XKjCFWaF5/hYM9/jHECC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azDWi5dA; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-784826b75a4so17120857b3.0
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761262060; x=1761866860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YREhDn4ZuHDUKK5dCqhE4p9/lHYpXCfBXAOyZczE1hk=;
        b=azDWi5dAdU/ROwcs0gq6773duif3O4pe0UEQiVeRUGt57+Uzzxhxjx0Kk8gIXkrPjG
         Iq3QvMU3v909Pgj4geAgsueluHtGSkcwRAXdJluskSuXlkpUEkto/N7q5l21NnayYouT
         Jd/ytf6vHqD91JLOdi3UmBeDRdnZQMl/oiaPlDJ3K9QT9VUjWSxPfUZGkYmS+u7k0Hez
         jIqXBNl//kFkQzxu8OTzyi5PWBCniyd/vJGnHW4HkpBzax0rOFpI8oYJ4BV+pAwQruch
         JGcZb847qmmkNTJ7kR9gpSBjHN11XfWVARlLsmSR0hOIfWlT0w4u3qgQMll8HOuKd/zH
         BHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761262060; x=1761866860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YREhDn4ZuHDUKK5dCqhE4p9/lHYpXCfBXAOyZczE1hk=;
        b=ogoZPO61C5+iWN+Lnvh0KIfnQCzsHQ3Hn6/zMwvDQNMW9yxQVy+O3mnONdNNxx5MYW
         P0a4JDg78QjBJMouptNfVUntmNZCZ8LfNhpDxGUaMLFVHut+ywEGYRGJVV/Hxz2FG8Se
         meWrrJk9omXRKmIGu+K4BN2DPIrDMrobevfaTaslwemHIBi+v8umlk074tUt9NTPUGhf
         +tiXTkolG0fU+JH5ppxMJP17Gq9E0ShlUzqmEsihUqo+E4Oqc6NFEoM8PhJPqHS2JpCC
         6kHgIXh7coCPDMOGDyMKHYDDmfZ5ggg+TSHI1zRNgrHVOD3lOY7h9J2C0OugVywi3MPk
         J+wQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5ut8wPhWaUfNmSo//ZU7AZ2Kt9K+Vt6lX69I63WYSFmChjdTWxeN22b5UA7v0Rkaqf0EYUCY3EdchzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVWYM7sW10+YyfeD/PvgEZ4ziJXaDy4KnKOSCpAPiTJvDHGmpQ
	8/0wBPFZ4U2HbYHRpufW3K351xQYvGIUz7bHMj7torCp7VATqz9F+B0R
X-Gm-Gg: ASbGncugZiu7XcH5fZfl00dSn3GJfOPCWUGVvKdiY7Mn4J9jBa/9URSalm32ta9oAYw
	dQz+2JrEBNk5l5M9pAE8crxqKuAJ9sC6rigm2lL2LOe+yQts9+LZpNYHRGL8J9Gxq3mdk1+tjpo
	pxKOwemEHIkTRQga8CVlwt/gIhQKmXelypsQ5nA/G7hZSUu04Okft9OcFZeLNgrbJ3P+x1eYKWw
	tyTrT6vbtB7ptdVI5KN4Ds8NZUq/aIDbEsEuFAZBgjwD9B10VG4dZ+RU+fx0Mj+Bwe3I0z0Sayc
	T6rQZTL2FVCjqnAis7dXQsPmfsWcCUSg23faSAALB7mO++HAs0JRZ0Ndvq8i587XGw29mB2I5Kq
	5D2pVzRwjur8U8TtyPB5CBCfMxy8lAZh+31FZqAsqPFRrx4ePVR7t+/3XQOyjcqdqyqFs35UclY
	JVaMVDBe0lqMKU8SWlIOMP/B0X3Rid
X-Google-Smtp-Source: AGHT+IHlRFBz3K9vr/Ux0KYota5J91YdojxHcdEKJeKAesFmyAR+elhDANVl/nxLZfl3W/M8BWjrDQ==
X-Received: by 2002:a05:690e:1186:b0:63e:2d1a:b41b with SMTP id 956f58d0204a3-63e2d1ab4a3mr15792758d50.30.1761262059931;
        Thu, 23 Oct 2025 16:27:39 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:42::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63f37a06e5esm1061849d50.16.2025.10.23.16.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 16:27:39 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: Boris Burkov <boris@bur.io>
Cc: Chris Murphy <lists@colorremedies.com>,
	kernel-team@fb.com,
	Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: make periodic dynamic reclaim the default for data
Date: Thu, 23 Oct 2025 16:27:35 -0700
Message-ID: <20251023232737.3346933-1-loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251022010215.GA167205@zen.localdomain>
References: 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 21 Oct 2025 18:02:15 -0700 Boris Burkov <boris@bur.io> wrote:

> On Tue, Oct 21, 2025 at 08:37:18PM -0400, Chris Murphy wrote:
> > Thanks for the response.
> > 
> > On Tue, Oct 21, 2025, at 6:39 PM, Leo Martins wrote:
> > 
> > >
> > > Wanted to provide some data from the Meta rollout to give more context on the
> > > decision to enable dynamic+periodic reclaim by default for data. All the before
> > > numbers are with bg_reclaim_threshold set to 30.
> > >
> > > Enabling dynamic+periodic reclaim for data block groups dramatically decreases
> > > number of reclaims per host, going from 150/day to just 5/day (p99), and from
> > > 6/day to 0/day (p50). The trade-offs are increases in fragmentation, and a
> > > slight uptick in enospcs.
> > >
> > > I currently don't have direct fragmentation metrics, though that is a
> > > work in progress, but I'm tracking FP as a proxy for fragmentation.
> > >
> > > FP = (allocated - used) / allocated
> > > So if there are 100G allocated for data and 80G are used, FP = (100 - 
> > > 80) / 100 = 20%.
> > >
> > > FP has increased from 30% to 45% (p99), and from 5% to 7% (p50).
> > > Enospc rates have gone from around 0.5/day to 1/day per 100k hosts.
> 
> Leo, correct me if I'm wrong, but we have yet to investigate a system
> where unallocated steadily marched down to 0 since the introduction of
> dynamic reclaim and then it ENOSPC'd, right? If there is a strong,
> undeniable increase in ENOSPCs we should absolutely look for such
> systems in those regions to motivate further improvements with
> full/filling filesystems.

After digging some more the only examples I found of btrfs enospcing
from lack of unallocated are true enospcs where either data or metadata
were entirely full.

> 
> There is also the confounding variable of the bug fixed here:
> https://lore.kernel.org/linux-btrfs/22e8b64df3d4984000713433a89cfc14309b75fc.1759430967.git.boris@bur.io/
> that has been plaguing our fleet causing ENOSPC issues.

Yes, a deeper look revealed that the increase in ENOSPCs is
due to this bug and not dynamic+periodic reclaim. In fact,
the hosts with dynamic+periodic reclaim enabled see a relatively
smaller rate of enospc (about 2x less) than the rest of the fleet.

> 
> > > This is a doubling in rate, but still a very small absolute number
> > > of enospcs. The unallocated space on disk decreases by ~15G (p99)
> > > and ~5G (p50) after rollout.
> > 
> > I'm curious how it compares with default btrfsmaintenance btrfs-balance.timer/service  - I'm guessing this is a bit harder to test at Meta in production due to the strictly time based trigger. And customization ends up being a choice between even higher reclaim or higher enospc.
> > 
> 
> Yeah, we don't have that data unfortunately.
> 
> > > That being said I don't think bg_reclaim_threshold is enabled by default,
> > > and I am comfortable saying dynamic+periodic reclaim is better than no
> > > automatic reclaim!
> > 
> > So there are still corner cases occurring even with dynamic periodic reclaim. What do those look like? Is the file system unable to write metadata for arbitrary deletes to back the file system out? Or is it stuck in some cases?
> > 
> 
> I would imagine the cases that are tough for dynamic reclaim are:
> 1. genuinely quite full fs
> 2. rapidly needs a big hunk of metadata between entering the dynamic
>    reclaim zone but before the cleaner thread / reclaim worker can run.

Concerning point 1 it seems like dynamic+periodic reclaim actually does a pretty good
job here. I haven't seen any signs of thrashing with low unallocated space.

> 
> > ext4 users are used to 5% of space being held in reserve for root user processes. I'm not sure if xfs has such a concept. Btrfs global reserve is different in that even root can't use it, it's really reserved for the kernel. But sometimes it's still possible to exhaust this metadata space, and be unable to delete files or balance even 1 data bg to back the file system out of the situation. The wedged in file system that keeps going read-only and appears stuck is a big concern since users have no idea what to do. And internet searches tend to produce results that are less help than no help.
> > 
> > -- 
> > Chris Murphy
> 
> Anyway, I think Leo's forthcoming detailed per-BG fragmentation data
> should be the most telling. System level fragmentation percentage
> isn't the most useful IMO.
> 
> Thanks,
> Boris

Since the uptick in enospcs is not actually linked to dynamic+periodic
reclaim I now feel confident saying that dynamic+periodic reclaim
should be enabled by default for data.

Thanks,
Leo Martins.

