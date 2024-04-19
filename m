Return-Path: <linux-btrfs+bounces-4455-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E39688AB54B
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 20:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1D4B281FE4
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 18:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713511311AD;
	Fri, 19 Apr 2024 18:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="SOMnHftH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C85422071
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 18:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713552855; cv=none; b=aCXQFFOcbxAnbE8USMYSO4CmoTodk4f43USjUcH7Au6TTK50oYwfq3chNGqPbRW+8hnsBoN4TEKuPR/wSk9RTqpfKTRpue42rCnXLz/Q9xnKSVA+uQPdy/LZ/0Kt6mkCOvTS5PPphF5LUBceuNO7PeziQenFuR9kwm7ER0K0jb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713552855; c=relaxed/simple;
	bh=Rk6puKjiTDkKAjCvDHQxUFjNBRCnDAdMrud6VyhcWZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLW9mODGewdcDwzWFEPaTW95fO38vHR/OVpbTksaNhzVz/TTzS5nqCW8CzWNss6DHhl6Ni+CLkIzyzrDi9MgFYlWpKMt09F5K9xZ8sQ8ctl7FhL/X7UIv7yksqDuDULUzaGz8tH85nsiEwE2HFqXDioMXuzCeRdx9TtghLdPMNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=SOMnHftH; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-437202687bfso14645431cf.2
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 11:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713552853; x=1714157653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TruwZnWZri7iH+nXQ3qA54Ge5XfX6vswZ56ilhC1jao=;
        b=SOMnHftHkZIjm+DvDbL1yhNU+SZn7XUnCBluXlGHY0zBoanaO8gbuvG8gku4yq0iNr
         7WT9LaOfkXfH1gJJXkOw8OxuO5D+XK798zeXHsVjpzz1poM/Y26DW1qgbYpQZGCSvn1N
         FBACDZn4UDqPQFZrtVMLWKnbCmLBSRuDRWOQHcVNoe4+iLausiWEeBRRTNIVCzN6HiIK
         HOy7dt3Nt2IwPviU1UYZIkBFc4A0/7GkaxjEr/7MXprWIfw/DzO1PGLUmz7rGK6L/tSQ
         s4p2z5eNjBTjrv6I+4jUMLttGMelDH+hKu7fMDlHNvXYRuDiypHzYW4ortwaENtYCRhv
         SgfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713552853; x=1714157653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TruwZnWZri7iH+nXQ3qA54Ge5XfX6vswZ56ilhC1jao=;
        b=VOBueaDoHWkZmvuycaGKRHmrkhRxwM7Av47lkGeIPmGGvQD22otPAAYY5jKU4zLB4r
         kP1+3/bxEkXuHOX+jkvBZ2n5ZCpoutzVkL0397LNqHZdPXf5PXdBiIcmbMZH5fjoZkHa
         COu4pdGHHTIDJrC5Tr7hJWqy7bpGsVPHCo6H1ucjTZj0YhnjXuQiLpXtQ7BPC/+TTZdY
         ALQthXR4Zkbccr9+KF9pWNpv3J4Tz+Bm6JGcVQuXnvz20pT+VCBAk3QtXINSi9AxHSeZ
         oUOmjtyft010meRdTtZPvZvWujXeYSUohAMKBPJ9hViY5KMrnc+Sv3MYKGCLEcUeIXht
         fZEw==
X-Forwarded-Encrypted: i=1; AJvYcCV0xLWMCzDXivdYPJQd/GTenvgRn2I4rCoJNw66bFFARWcl0fXgNtlsHZJyFZZ5eq07Tt7WdUza9BeDiWQ6rdt43aRmT1P9hyVEArY=
X-Gm-Message-State: AOJu0YwLXTsXQlX+f3jL9Het3Nni0OVq1qjDlV4XCfPDWFPxDB9sGA5/
	0igohVyfK1lBtVAfaM6TjLDGxv9cbZRnkbwiRIA5GIv2GPlei2wzSEUu7MRP+cQAarqpwiIYbbe
	I
X-Google-Smtp-Source: AGHT+IEjevCFy8Hr2VU3/1skcuqbvmfNMigqg4bLh0KuG90yPTNOFNAIFXppazGiVum3G1Nvt+BOEQ==
X-Received: by 2002:a05:622a:1982:b0:437:b8e9:d200 with SMTP id u2-20020a05622a198200b00437b8e9d200mr2939271qtc.16.1713552853243;
        Fri, 19 Apr 2024 11:54:13 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id k8-20020ac86048000000b00434efa0feaasm1811800qtm.1.2024.04.19.11.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 11:54:12 -0700 (PDT)
Date: Fri, 19 Apr 2024 14:54:12 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH 00/17] btrfs: restrain lock extent usage during writeback
Message-ID: <20240419185412.GB2725564@perftesting>
References: <cover.1713363472.git.josef@toxicpanda.com>
 <ZiC1hbcG4rFFz1BM@infradead.org>
 <qjy6xzmwpggluuwbgu4aljweoiwnrowvgklw6trn6tvwyk4wqi@akofzgx2tnms>
 <ZiEyfvCOrlsIgtiR@infradead.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiEyfvCOrlsIgtiR@infradead.org>

On Thu, Apr 18, 2024 at 07:47:26AM -0700, Christoph Hellwig wrote:
> On Thu, Apr 18, 2024 at 08:45:35AM -0500, Goldwyn Rodrigues wrote:
> > The only reason I have encountered for taking extent locks during reads
> > is for checksums. read()s collects checksums before submitting the bio
> > where as writeback() adds the checksums during bio completion.
> > 
> > So, there is a small window where a read() performed immediately after
> > writeback+truncate pages would give an EIO because the checksum is
> > not in the checksum tree and does not match the calculated checksum.
> > 
> > If we can delay retrieving the checksum or wait for ordered extents to
> > complete before performing the read, I think avoiding extent locks
> > during read is possible.
> 
> And the fix for that is to only clear the writeback bit once the
> ordered extent processing has finished, which is the other bit
> making btrfs I/O so different from the core kernels expectations.
> It is highly coupled with the extent lock semantics as far as I
> can tell.
> 

They aren't coupled, but they are related.  My follow-up work is to make this
change and see what breaks, and then tackle the read side.  This should pave the
way for a straightforward iomap conversion.  Thanks,

Josef

