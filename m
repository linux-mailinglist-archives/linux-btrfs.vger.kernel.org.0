Return-Path: <linux-btrfs+bounces-6535-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86432934997
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jul 2024 10:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7784F1C22ACE
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jul 2024 08:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9564079B9D;
	Thu, 18 Jul 2024 08:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TzWi95UD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE44443ABD
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2024 08:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721290174; cv=none; b=Fiy+TGHIvJOICyriosXWxMrAy/K8VVy93jwpAB6+U9XWr4x0weZU8v8YDLgAvKpPHKHzcJ3+afBiNk4vzQjwAyb9AcWNcf7QDIjXDj8MLa9U6TVmB+uW7IQeQhUX1dXouzcmqxEojI523Yw76e8B3OkMUYnrX+jZhknanNUjpxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721290174; c=relaxed/simple;
	bh=TDYm5PZVfZHPLUELKTZw/I1/ewmmqaWyG3B3esIwX0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEiAZ5XTQdF8T9gqCjr9H6oc3tcvpfpICKEOerHBA/JPAMsURkxfeeT1zWdYVtjNlBsq8OOVOPxWUiCYhZrz4OQz3td4y0VKLh9W9156xTL0g5aXo9JtFlRsZ6/O3K8sAqD6vjRE2M4XG5AkmWyLNdisyZsJFoHsVncxJLEXowU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TzWi95UD; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52ea1a69624so38913e87.1
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2024 01:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721290171; x=1721894971; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tXMh51KVDkJmQr+NxLPzI9t9Kwi4FwG+tK/QlWBahKs=;
        b=TzWi95UDhOtfJrxTJ5O+Dqqgm7t96Pc5jM2LjfuDMEw5ZIp8ZH7WwMEf53WZX+v4jw
         18dE6qLgUDCwxrpLVrXFT5w6EZoWaAZSQIbz8SIUKLom0chLcEZ1q5xfV4auELrX/OlS
         gtWyu9mYI2+S4y0mGlPfCjScFxZlkq8rCzN/GH4pMR9RVEHvcijtDpfU8SAmAlumSNxv
         pjQANwSnQk9d8Yje15uzxtkzfISwceeIBI/mmrwUIFhgfXbTcsoYCnAkGioFvRcgxXvF
         q7SfeVyH7ZQaYzE50UxQDYBxOkWlWTC0kCpgFDhucYnBObJKUcYKGFThSZTGXeKZyp56
         Ml2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721290171; x=1721894971;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tXMh51KVDkJmQr+NxLPzI9t9Kwi4FwG+tK/QlWBahKs=;
        b=I2znLDpWUyBi0XxIK0fj0ymP+4ZVZjAyL2IbvUkzCNnNVukz5Mo8Tc/WfGizw3TGx8
         mWhaxF4DInrR77eoUnAO8bKIB0k2wQyNV0t3GMUZ0nEzE82xXrJzEecPYQCCQZPQwGlw
         TOA8S3Ja4VQnRHn+n+g2ogtjgy/VjRFcVW1HOkJZSBeuauPotBGDFk8Sqz2NF0OcLWbd
         EfGfnJ5Ln6kVf0ArkoM+EvE+ZdRtvgVigq1DaR82nzE9KF6iztaGdG2uRMDZmput60fC
         UsAY/jKnN/s5w3D5KkT+0lRiHYaDW7atydSO+1Ron4f2nltiwwahWxJ8SWXy/b01Po2O
         OBmA==
X-Forwarded-Encrypted: i=1; AJvYcCVEkX7guxxPkk9I2TuEvQT/UC4T0DE3vQ5r9FgE08xD8b05/OHjmvY+s+CwH2wTPPECJAj7/9gbYs3S5wx0nf3H4oiLO3J6U6I1R0E=
X-Gm-Message-State: AOJu0YyazDL5Or8Nwl6Dv3c1OK4UnGKVPI8UIXXxInT7gMBaf+MyK/UD
	DViFC0vB+4hKbDmTZ1Mc5VnuAW/PgH0uoTyVn+JUqkesjuHkcV0h3YNFNnnY60U=
X-Google-Smtp-Source: AGHT+IGegX6hhcdBy2hHYfDBsDRJkiHBdAAF1OXnxmmpbPiUGv7h+8z8jYIwpVOTdMuMRgTCMfHFxQ==
X-Received: by 2002:a05:6512:3c93:b0:52e:7f6b:5786 with SMTP id 2adb3069b0e04-52ee543f25emr2769637e87.61.1721290170831;
        Thu, 18 Jul 2024 01:09:30 -0700 (PDT)
Received: from localhost (109-81-94-157.rct.o2.cz. [109.81.94.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7ff9fbsm531461866b.154.2024.07.18.01.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 01:09:30 -0700 (PDT)
Date: Thu, 18 Jul 2024 10:09:29 +0200
From: Michal Hocko <mhocko@suse.com>
To: Qu Wenruo <wqu@suse.com>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Cgroups <cgroups@vger.kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 0/2] mm: skip memcg for certain address space
Message-ID: <ZpjNuWpzH9NC5ni6@tiehlicka>
References: <cover.1720572937.git.wqu@suse.com>
 <8faa191c-a216-4da0-a92c-2456521dcf08@kernel.org>
 <Zpft2A_gzfAYBFfZ@tiehlicka>
 <9c0d7ce7-b17d-4d41-b98a-c50fd0c2c562@gmx.com>
 <9572fc2b-12b0-41a3-82dc-bb273bfdd51d@kernel.org>
 <ZpjDeSrZ40El5ALW@tiehlicka>
 <304fdaa9-81d8-40ae-adde-d1e91b47b4c0@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <304fdaa9-81d8-40ae-adde-d1e91b47b4c0@suse.com>

On Thu 18-07-24 17:27:05, Qu Wenruo wrote:
> 
> 
> 在 2024/7/18 16:55, Michal Hocko 写道:
> > On Thu 18-07-24 09:17:42, Vlastimil Babka (SUSE) wrote:
> > > On 7/18/24 12:38 AM, Qu Wenruo wrote:
> > [...]
> > > > Does the folio order has anything related to the problem or just a
> > > > higher order makes it more possible?
> > > 
> > > I didn't spot anything in the memcg charge path that would depend on the
> > > order directly, hm. Also what kernel version was showing these soft lockups?
> > 
> > Correct. Order just defines the number of charges to be reclaimed.
> > Unlike the page allocator path we do not have any specific requirements
> > on the memory to be released.
> 
> So I guess the higher folio order just brings more pressure to trigger the
> problem?

It increases the reclaim target (in number of pages to reclaim). That
might contribute but we are cond_resched-ing in shrink_node_memcgs and
also down the path in shrink_lruvec etc. So higher target shouldn't
cause soft lockups unless we have a bug there - e.g. not triggering any
of those paths with empty LRUs and looping somewhere. Not sure about
MGLRU state of things TBH.
 
> > > > And finally, even without the hang problem, does it make any sense to
> > > > skip all the possible memcg charge completely, either to reduce latency
> > > > or just to reduce GFP_NOFAIL usage, for those user inaccessible inodes?
> > 
> > Let me just add to the pile of questions. Who does own this memory?
> 
> A special inode inside btrfs, we call it btree_inode, which is not
> accessible out of the btrfs module, and its lifespan is the same as the
> mounted btrfs filesystem.

But the memory charge is attributed to the caller unless you tell
otherwise. So if this is really an internal use and you use a shared
infrastructure which expects the current task to be owner of the charged
memory then you need to wrap the initialization into set_active_memcg
scope.

-- 
Michal Hocko
SUSE Labs

