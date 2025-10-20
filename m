Return-Path: <linux-btrfs+bounces-18082-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADDFBF3C74
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 23:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E320E35147E
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 21:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814B42EE263;
	Mon, 20 Oct 2025 21:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="bCqF63Fc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C852ED86F
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 21:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760996593; cv=none; b=e6NiPwsna3En5gjwinLDYbPG/Gxu9sGIPocXfBaiueF80uE6cqk97eMZwvc5jVEvzYZqeydzMpMQ7GIb5WZfF8uYFfoB50gHtjqGCKDaZERRDFV43te+GqXjbxPPXQ4wbPTOZkX2mV8Ca+aDhD7kjb1moAIxuMrE/hcMqJMoEmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760996593; c=relaxed/simple;
	bh=y2m25W7zkJm4lmZAqrSB8Op5PkRsIhwCbtsRZflqNDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEYyQMc9I/IoXz8zUutCJxWoUzrPPb0xt6OLduf/ebJ/HvqxuBt1FoBvLm95NRPOCtx9cJQykjA2IlQ4xXmkgrJxppEW8qqNMx9cOmBk2pkbypxgUChFclQX4PZIxBxbLhL55754+5hmDArCR6MEgO8LAHldG+9MAbwoFaDL6mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=bCqF63Fc; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-79ef9d1805fso4490075b3a.1
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 14:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1760996591; x=1761601391; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LQOa5MIIi+7CgnSuXmOmCMZIcE9hFQ3mA2YcxpQezgc=;
        b=bCqF63FcLxJQ/OV38f81uNkBz/+g2HrlN3yo0wwWS9kJuir8mmOD4kIagjZ9kC3449
         lEgtmftxq15FfqD7HBdxO2dJzWigu4f5x7QSw+xuPgWiTLJVpyx20FwK4AUQt2x0ulXU
         R79bA3G8B6ISlCjzBgu1bneuaC92KgNjHNU1bKFuvXuTTvQqmfOoM1JVW/2Qp6UdyBjH
         r6avvWdgNIzFtBf6lADLi2oMXwNuPGkDzdK/ySlVTekXFyiPBqcvUj3AMsiZfhs7AWaR
         QMQbVlSHOqRaaR1XuZ99ZkIuSPvoK//NTXi2C0t2MhPLBszHgkHSls2L1VH1PCZrvY7p
         XlPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760996591; x=1761601391;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LQOa5MIIi+7CgnSuXmOmCMZIcE9hFQ3mA2YcxpQezgc=;
        b=WWDuVEVZhJ5ocXTu3CUGeIEW3/eWSg6D3VUwvVbjylL1msLA4mb4gJMxN9HHk3zwpM
         Bm+4zFeUWYFCurNpyVK9kZdMIYt+Tv+BDePM3yVuY62DWPrwZAJ6c66tXffK6guZ3PcW
         zkCObABY6kxgCpzjFtF+fK8U7l9hF7dMcQmtFONUUhLJOqLXxpT5qeIr2cheFUbjMxij
         M+/NAapQXiAnkFd8yWT7DXke4n13GYZk0XdZXODjXyCbWBsoVh2iBnhXOiORrm/xAXnn
         /FVEKwwK9uRpPAxBpXEv0ECeJ6/rAPLAFPUgPcGxcWF37jjGAeOCiUT6mmTvrEO6mVMy
         AOtg==
X-Forwarded-Encrypted: i=1; AJvYcCVlTva499HVJRFJrIBHepqfgoqq9oCYCuEDNYqSL1UoRDaWqL1t4boBXCdhf8K4i7NQW6wIhmhTeMRnKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRKVm4RlME4MVXaFZdTJoChgXmDfN3GpaBV/cAX4OWgqDDrED9
	/OWUZo4yDAwFl2z7rQz5rLccjYzblEeK4XLsZix2ghmmCiZh37pmaVdpOnFwM1VQqZA=
X-Gm-Gg: ASbGnctHJYUoNd20QSZRh0OgrR1EMVfLA40urD1ktif6frMBFEndJ2N86XQzI/QzDwb
	x2o7r390HxAEi8ZlWdpSefOrMerOHzYlw1twd6EZpVVO5DvYBQJ6WaSXvLPsQ1x7vVGuzZKEy2N
	TEi1o01qCQlY8Tu6h/RIR7K8AMqrx7WXweGWZIaJZkREiR/Re2i6/lzbbbKFmWNozeZVWPVPXkL
	xdQYL6CglMBF5HmH+OR9hIMTj5yXtNEpKGL1eKgwQw76fFJpftBobt4bOMGYhZQkAAy/Kplr8si
	fsOiI/FuBq84bB6k9VFt2ZR4HVyM4BO4N+5dHIAb3Q9nqTQh+f/xMtqwGm7Zv1nuJRqZKTYP15W
	QVcQ2E5YxzgVys6UA8dbCAYzhQzDaWVDLKS6/0ukRrQMTTjPxN13qlAN39Krdpdzt7r/v4tW96S
	thtrd8ZNauFCvS4iFlc3zEEyRD3FKd8IjzXI5jZWYfRrKS8zpyjYs=
X-Google-Smtp-Source: AGHT+IE1HUX+wcNiDJeJ7OTlztv/NSJpMhRfSbA7KZpViYePBOTXDJQlldupatbqjRCb7qVsG4PmXw==
X-Received: by 2002:a05:6a00:230a:b0:781:16de:cc1a with SMTP id d2e1a72fcca58-7a220d37785mr19816985b3a.32.1760996591191;
        Mon, 20 Oct 2025 14:43:11 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff184basm9336482b3a.15.2025.10.20.14.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 14:43:10 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1vAxel-0000000HUpj-3jCY;
	Tue, 21 Oct 2025 08:43:07 +1100
Date: Tue, 21 Oct 2025 08:43:07 +1100
From: Dave Chinner <david@fromorbit.com>
To: Anand Jain <anajain.sg@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kernel-dev@igalia.com, Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>
Subject: Re: [RFC PATCH 1/1] ovl: Use fsid as unique identifier for trusted
 origin
Message-ID: <aPas60j7AoyLLQK0@dread.disaster.area>
References: <20251014015707.129013-1-andrealmeid@igalia.com>
 <20251014015707.129013-2-andrealmeid@igalia.com>
 <aO3T8BGM6djYFyrz@infradead.org>
 <5137ce36-c3b4-4a0a-83af-e00892feaf43@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5137ce36-c3b4-4a0a-83af-e00892feaf43@gmail.com>

On Wed, Oct 15, 2025 at 07:46:34AM +0800, Anand Jain wrote:
> On 14-Oct-25 12:39 PM, Christoph Hellwig wrote:
> > On Mon, Oct 13, 2025 at 10:57:07PM -0300, André Almeida wrote:
> > > Some filesystem have non-persistent UUIDs, that can change
> > > between mounting, even if the filesystem is not modified. To
> > > prevent false-positives when mounting overlayfs with index
> > > enabled, use the fsid reported from statfs that is persistent
> > > across mounts.
> > 
> > Please fix btrfs to not change uuids, as that completely defeats
> > the point of uuids.
> 
> We needed cloned device mount support for an A/B testing use case,
> but changing the on-disk UUID defeats the purpose.
> 
> Right now, ext4 and Btrfs can mount identical devices, but XFS
> can't.

Absolutely not true.

XFS has been able to mount filesystems with duplicate UUIDs on Linux
for almost 25 years. The "-o nouuid" mount option (introduced in
2001) to bypass the duplicate uuid checks done at mount time.

XFS tracks all mounted filesystem UUIDs largely to prevent multiple
mounts of the same filesystem due to multipath storage presenting it
via multiple different block devices.

The nouuid mount option was added back when enterprise storage
arrays started supporting hardware level thinp and LUN
clone/snapshot functionality. Adding "-o nouuid" allowed cloned LUNs
to be mounted for for backup/recovery purposes whilst the main
filesystem was still mounted and in active use.

> How about extending this to the common
> VFS layer and adding a parameter to tell apart a cloned
> device from the same device accessed through multiple
> paths?

Perhaps we should lift the XFS UUID tracking code to the VFS
and intercept "-o nouuid" at the VFS to allow duplicates only when
that mount option is set?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

