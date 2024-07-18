Return-Path: <linux-btrfs+bounces-6536-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE51934999
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jul 2024 10:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4811D2849C0
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jul 2024 08:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B437243ABD;
	Thu, 18 Jul 2024 08:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O7ILlGi8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66E41BDD0
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2024 08:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721290233; cv=none; b=gsPsRM1nemXS6qv4TqRylip5KiJbIEq7KJvo8AcUDhxx5L7rFc3V1iwz4nlPObMQZdW0qwSnHa7MVNG2gN9aZzbPGrMWCOS/kAqctJ1+LTZ4qpVnWoNuGFaBBjUfhdr1jQkyUU0WZMmehNz7Y/R6J3LH3VXl12pfiSE+Q0BHQW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721290233; c=relaxed/simple;
	bh=W8W8eSSicchF0HTNnpjwRvYnekiZ4wDdutg80Ex7/RE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHj/u/7WCnACj7i9Bae2W+4MS2CvidB0eHihmpOIbKqKw/Lf7K4338/oMkLTmIHVrU4GUiHUzBaCE651ACAaWiLvGJSlehXiJiygIA2eezN+YDD5Q4eYvuvy0WJM6xHNQuhREtDDRgJQJFsQC+o4HvNPpi86bHfS0Yqbsfp6bkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O7ILlGi8; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a77c0b42a8fso275189766b.1
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2024 01:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721290230; x=1721895030; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=76dnrtuWhzYwHnyFzkGb7MBr43hvYawhckJH3fPSFL0=;
        b=O7ILlGi8XTYKMUcrT+DPycKOxqfG+czhf2gH4qjWUPpBzvUF54PxjQ5KGw9oendWdP
         /Ifd5sHiF+C2qBxOqz+JRxAKm/fNhCi2rqtasI4bVTxdasvc0NgJkInPst8/jdS0jLe3
         gX+v/fAIGwo2wZyB/bxTLY9AwOto108ZTskiausYjKuqwXo9R3oaWiPgk2RvKU1KkAZW
         hs5mBQ/LJtVdJZnLlcRmEVNi0EeM0nMx6qB7ZBGY0lT9SL/qph3WvYGhZsJ5vgZFHZ0W
         8D218mV5d62JrIUZj8SF4Yx8ZGMFD0+g+4QMWW35dTBDv57l2i6JiAMFfTAU+qzuocC5
         Ibmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721290230; x=1721895030;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=76dnrtuWhzYwHnyFzkGb7MBr43hvYawhckJH3fPSFL0=;
        b=ZmAOjHWi4XHtnyAnrZ1MgrEZAd+NOTk5EVlYjat4uKBMQd8cIAjZhnEufzjeKH8VYt
         ycsyRaghOns9yDjiUsBbLn18rydq3nqwBPZsr7v6MX8BKJ80HOQuv0ASPfxlV3uumzPy
         tOw8GZbdpf088DQuYDRvaASCSYM3sldWkM4U0UkXC2AeQCYAXsyL73F/ANxPtehcVyN6
         u9mF5gEzKtMkKiUjS6gTSuXi6cC2m/bfwUxuji872UwUYplNg45hkfPDbpV99hYaZ7NV
         D5qZp9O5PDqGthINCqXIPuWuSM6a9s6vAzQabmFjrQdrn8snJhjTx2CvBPS25UudNHWG
         x+og==
X-Forwarded-Encrypted: i=1; AJvYcCUu6w1PsLKA7FpI4Jl1wGQj1MrGKXvnWVwRwkt8dN/csQ6dSrVaIb54E+Ref3y5/9CS6DJHMqvtwJwnX2gdDOLhOpDZs4E3twFYmFE=
X-Gm-Message-State: AOJu0YzASuVTc4x+KpdsFBkPCua3oDQ6EvBsNFLZ89jnWHqud4fM+odF
	/Fd8gj4BMGprkciuxR/LycXDyib2M1U8gEd9fON67on9Qk6KW1yhs92TA+gbU1o=
X-Google-Smtp-Source: AGHT+IHDGcsXV9BowhgEkzRV8IViMd8b0kzojmy2zxD9zUc2ioY5avjUdu6Qi9xyrE13MyeYrVTjHw==
X-Received: by 2002:a17:907:3f1a:b0:a77:f5fc:cb61 with SMTP id a640c23a62f3a-a7a0eb8cb2emr283950266b.0.1721290222664;
        Thu, 18 Jul 2024 01:10:22 -0700 (PDT)
Received: from localhost (109-81-94-157.rct.o2.cz. [109.81.94.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5b7eeasm528664666b.71.2024.07.18.01.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 01:10:21 -0700 (PDT)
Date: Thu, 18 Jul 2024 10:10:21 +0200
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
Message-ID: <ZpjN7YgIDmjO88gm@tiehlicka>
References: <cover.1720572937.git.wqu@suse.com>
 <8faa191c-a216-4da0-a92c-2456521dcf08@kernel.org>
 <Zpft2A_gzfAYBFfZ@tiehlicka>
 <9c0d7ce7-b17d-4d41-b98a-c50fd0c2c562@gmx.com>
 <9572fc2b-12b0-41a3-82dc-bb273bfdd51d@kernel.org>
 <ZpjDeSrZ40El5ALW@tiehlicka>
 <304fdaa9-81d8-40ae-adde-d1e91b47b4c0@suse.com>
 <ZpjNuWpzH9NC5ni6@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZpjNuWpzH9NC5ni6@tiehlicka>

On Thu 18-07-24 10:09:31, Michal Hocko wrote:
> On Thu 18-07-24 17:27:05, Qu Wenruo wrote:
> > 
> > 
> > 在 2024/7/18 16:55, Michal Hocko 写道:
> > > On Thu 18-07-24 09:17:42, Vlastimil Babka (SUSE) wrote:
> > > > On 7/18/24 12:38 AM, Qu Wenruo wrote:
> > > [...]
> > > > > Does the folio order has anything related to the problem or just a
> > > > > higher order makes it more possible?
> > > > 
> > > > I didn't spot anything in the memcg charge path that would depend on the
> > > > order directly, hm. Also what kernel version was showing these soft lockups?
> > > 
> > > Correct. Order just defines the number of charges to be reclaimed.
> > > Unlike the page allocator path we do not have any specific requirements
> > > on the memory to be released.
> > 
> > So I guess the higher folio order just brings more pressure to trigger the
> > problem?
> 
> It increases the reclaim target (in number of pages to reclaim). That
> might contribute but we are cond_resched-ing in shrink_node_memcgs and
> also down the path in shrink_lruvec etc. So higher target shouldn't
> cause soft lockups unless we have a bug there - e.g. not triggering any
> of those paths with empty LRUs and looping somewhere. Not sure about
> MGLRU state of things TBH.
>  
> > > > > And finally, even without the hang problem, does it make any sense to
> > > > > skip all the possible memcg charge completely, either to reduce latency
> > > > > or just to reduce GFP_NOFAIL usage, for those user inaccessible inodes?
> > > 
> > > Let me just add to the pile of questions. Who does own this memory?
> > 
> > A special inode inside btrfs, we call it btree_inode, which is not
> > accessible out of the btrfs module, and its lifespan is the same as the
> > mounted btrfs filesystem.
> 
> But the memory charge is attributed to the caller unless you tell
> otherwise. So if this is really an internal use and you use a shared
> infrastructure which expects the current task to be owner of the charged
> memory then you need to wrap the initialization into set_active_memcg
> scope.

hit send too quickly, meant to finish with
... and use root cgroup.
-- 
Michal Hocko
SUSE Labs

