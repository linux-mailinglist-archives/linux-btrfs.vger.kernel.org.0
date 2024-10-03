Return-Path: <linux-btrfs+bounces-8485-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1445C98EB7D
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 10:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C90FA283920
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 08:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D3613A87E;
	Thu,  3 Oct 2024 08:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SRlcLGdQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9087684FAD
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Oct 2024 08:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727943745; cv=none; b=ls9NOdGyJiKbeLTCzXmfaulMwK1NAcAQmkq7ROj/HmtB/h6nYHKnGiE7V8FEs2iwdkvrgsmLfEwPnbTjJcktOwU+IySOOzyg1i1O+lnECu9fLX+IR+jgdB7WN4RCfED1iHlulYrrSM7ZC5SI4tTWTiitsapG6W1w5CrYgRrSpDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727943745; c=relaxed/simple;
	bh=7RaI3Z2NMLjbRLFKmOfkKWN5rk80BvCfCf2jc3OH6N8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8aRNEkU56gRhpgWkAmQQeqCQbr1YUwxE4xgCZD5/sWmnUh0tujed9vsY6FrCeYXbdkH9i/oCrbcVOmSBITrNHwnxJRgqtSWl4pskYAGsBnod+O0+fuGb2nZPrzLxdIydSU6/twLDCzSZX/xmML0PphzCmhEkE18j43PIXqiL2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SRlcLGdQ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a90188ae58eso80562166b.1
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Oct 2024 01:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727943742; x=1728548542; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7D08CirM7xuRp06J+f5mwNiOHAYV3NjLlNX5JV7kTAs=;
        b=SRlcLGdQaqdxAgPzUeCl5tj+B3fGid9n32TdxBhrM/NXQqUnqVO9F14/6PGVPiNpzA
         tq6jXVj94iJZ1miJ0NyKRGCVCprCymY+zZfsEtQh7fbj9megStSeewDQ1TcrImZ+BH6X
         g8ls1uIn5+8OfuH99fhdmy01J6j0w0vxYh/O4gL+Fsau7yE5BkT+5OQTB1vK9e2Mjg4v
         /z4RvuHBJnpc312fbFxV7Uxh7YAxlL2yQxXYzuylLzsIjQFJsBM/1jt7WkcvqJSyrbgd
         g6GzAmssdLzzjSRWnmnBJLBh8zEkn+GupnCQvdi+ZdPu+QUFUcQvAZ6QX4+bUk67RJ5q
         lC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727943742; x=1728548542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7D08CirM7xuRp06J+f5mwNiOHAYV3NjLlNX5JV7kTAs=;
        b=lAP7dNDhNFZxJzJ4vA4A2YTMQY6E9P4669Jev0JTd69+f8SNR1n6EEMOBclgwoK79P
         3L5Yc8kcYdLRmDMR+N8UaR+bh9SaR0bgYDOzsnfyrZGeBqcbw9o/zg32P5bHAFu/+2Kp
         2WgO5964QW8zl6r2J2fBV8HsO1pJk6C012gqJRb9x/yDKVphe3idKSTxvPAJ8SJmbOV8
         pPiW3CaZXpjCnJWSESHT96VSA7k4hWzNyj7Po2RISkfFSlPqDHXlXhOq1HIUTCZm3GSJ
         Fe+iCXlhi1UmIwzgx7ZmjrHWakMOZxoEpQpITKPmokzt7sQe43ioZFG2CeioY2UNtNJC
         yKZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnaXULThwKypFLHp84oZQhSU10tU0hAn+a2uxDlKthZX9cN8+JHYIlJ+2TN7P8GOZq5bsErTVPuit51w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyeWgW56wsD5E5rAdCv8caf9F5wNnM9D02lfAFLh6QapARNeq8B
	vD4iE7cyXxiBfPMRLkRP1xqrdzOKmX/J3Ah02plwiPYP0kyTjeR4p4Co/HXV1fDnHfIvEolsxMH
	n
X-Google-Smtp-Source: AGHT+IGvbWw2hnN5NuJ3uDlUc9HhXu3sxWuJuPLHyeX6nGIqm/rg554fSuCmfpmRt5IdhcnSwSKgtg==
X-Received: by 2002:a17:907:31c2:b0:a8d:2ec3:94f4 with SMTP id a640c23a62f3a-a98f8387140mr421655966b.54.1727943741884;
        Thu, 03 Oct 2024 01:22:21 -0700 (PDT)
Received: from localhost (109-81-85-183.rct.o2.cz. [109.81.85.183])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9910286b9dsm50995966b.42.2024.10.03.01.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 01:22:21 -0700 (PDT)
Date: Thu, 3 Oct 2024 10:22:20 +0200
From: Michal Hocko <mhocko@suse.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org, hannes@cmpxchg.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Subject: Re: [PATCH] btrfs: root memcgroup for metadata filemap_add_folio()
Message-ID: <Zv5UPLRBDAA17AA4@tiehlicka>
References: <b5fef5372ae454a7b6da4f2f75c427aeab6a07d6.1727498749.git.wqu@suse.com>
 <Zvu-n6NFL8wo4cOA@infradead.org>
 <5d3f4dca-f7f3-4228-8645-ad92c7a1e5ac@gmx.com>
 <Zvz5KfmB8J90TLmO@infradead.org>
 <b43527db-e763-4e95-8b0c-591afc0e059c@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b43527db-e763-4e95-8b0c-591afc0e059c@gmx.com>

On Thu 03-10-24 17:41:23, Qu Wenruo wrote:
[...]
> Just a little curious, would it be better to introduce a flag for
> address_space to indicate whether the folio needs to be charged or not?

I would say that an explicit interface seems better because it is easier
to find (grep) and reason about. If you make this address space property
then it is really hard to find all the callers.

-- 
Michal Hocko
SUSE Labs

