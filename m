Return-Path: <linux-btrfs+bounces-7862-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8214196E33A
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Sep 2024 21:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B73228B35E
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Sep 2024 19:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E20B18FC83;
	Thu,  5 Sep 2024 19:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEPogOrr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B0442C0B;
	Thu,  5 Sep 2024 19:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725564639; cv=none; b=L0vYvkF8zW21hbvjAmxw9tPgdH4o6czYmf0imVn3/dHir/qcSiYRRyOAw2CLeGhQ/FFxEsRRNx31EMtTFtLJwYyAGERSdQ//TA6aUG3y02R/0FzlDP/WNgjp+VY0FSp9I/W2GKw/zzKi54dQMqFSSl0nzbmSuWJG9e5tjlaYjlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725564639; c=relaxed/simple;
	bh=edz1Y8cPH7nK/wkJBWl60AZ/9Ibna25B5YaZsnfzETQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDaRZt9A6igEOQjD6Zc1ei7IwpSpUZp51o4AIu/SdKiBDI9w6kxcXpiQjHmWFqFb1asezRmW5N4WhDjTdfzwwYEF7dj6lSnGwO7jslSPFGaBwMCWKBE4D5xnOaWOjQcUJfANqExJCJhqum+4WVdyU7VjVXrhE/uUL8bYQPSDk2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEPogOrr; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-205722ba00cso11659955ad.0;
        Thu, 05 Sep 2024 12:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725564637; x=1726169437; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MbrEFO3D2q7bIKaAwLKYWbNKa6L/7Ep2zWdh3jV7Rr4=;
        b=nEPogOrrrL877llBwbpI1R4EA8/g5PL3ghN5BnLBPNx8QlGyVM/f8f4FFbtoBmqddh
         VffcwxjPMvRqJ5/lpcyGd0SSq/6jLExBp0/DvSCe3M09a5Hrm+SqdU0lI8G4zHb6u6xR
         E6R0b+094PMbAUAuUn3+EK52Q3b4qUuPeeN8zeusylWFgEm8lmjmSrgq6frbRwLHaraw
         BwTI+pecEwOIxKVfzzSIMQLQ/UyReV08nGJ7gCpretBLlEGXQH6x7/NiU2//KtOlRjbk
         y8q9/PDmAugAqyfrxuJ4Sc6Sgf4VXPIitFPkbSYbCzpVVyfQib1xQGfnpZf/mqDtg0GN
         OwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725564637; x=1726169437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbrEFO3D2q7bIKaAwLKYWbNKa6L/7Ep2zWdh3jV7Rr4=;
        b=QcvRxw1sMd9WBu44/KifVGQi61mZJ7yHe1xP3ROyY2UU5FluVdzZzXX+Sy6WGGxzAg
         RWTUDHyB9Vq9JzWXKFoxmXlpvd9dIvZXKdeu4xmaIKYLazN6g9DKsSOUQsTRmEezxZqv
         7Wq2FTa0HOWR+Tb1aXCTq3MCOon+bYbqcXw6mODH4gDHiO7UPEVLr4y2zk0Evyn3GoXp
         nXgz2v4U02CTBHsVTWVUi5n6KQ9SyRMPC51EGnZ9zFHnzG/PW2VsTwNC9WvwA49gFDqp
         fPqDAeOkZbk9OSpROwrUKG9iynMkBuaC5uGfoHHslCTU9EjU8KDs7+5lxmTfNp21UR9w
         zT8g==
X-Forwarded-Encrypted: i=1; AJvYcCUwHlpW8vKCM5aM6yuTcoW90s12E8adX8AquRDySobcQX3vzc+lQVwZnKErfF76R1i/QGjIxLkMrWPA@vger.kernel.org, AJvYcCV2/5TZrQclhdLqwyhG1EVuxIbIjVvuF8Xipioj/97I3usZPLGwH2TvI0mR08nU1PmxqL83o3EQnmzM@vger.kernel.org, AJvYcCVVPYBCq4mEAuGcGfzOjgP8jvIx4mp5SESQEpjrigZRZQw+TNHArvrYgn28uYj2m90/q5ka5hUugtFn5VHt@vger.kernel.org, AJvYcCWVNwR0CTnUzzno7Y7+RO5AciUZnvq+wWxGS+808EreyXypkPeGJKOkca+yftstKHU7BQYbooQlODGnIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrS7YXAlS+pX28WQAch/+GrIwDfG2MltZKEcBKbpwA/gw041Dm
	ZSqWoep66PPfzXQ0eFaWCvFj1lxx+oNzysNxEzOGuhYFYWS0GcOu
X-Google-Smtp-Source: AGHT+IEXZGO8hCMMHsv0PnNONyTrag4Qx3WBh3WvRsXRhE+inBwlwGH8ekc0KBbwTXHDLfyibHm8iQ==
X-Received: by 2002:a17:902:cec9:b0:206:8c37:bcd0 with SMTP id d9443c01a7336-206f052e090mr1367825ad.27.1725564636900;
        Thu, 05 Sep 2024 12:30:36 -0700 (PDT)
Received: from leg ([2601:646:8f03:9fee:1d73:7db5:2b4a:dfdd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae952bd4sm31818995ad.113.2024.09.05.12.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 12:30:35 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 5 Sep 2024 12:30:20 -0700
To: ira.weiny@intel.com
Cc: Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Navneet Singh <navneet.singh@intel.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	nvdimm@lists.linux.dev
Subject: Re: [PATCH v3 18/25] cxl/extent: Process DCD events and realize
 region extents
Message-ID: <ZtoGzNhrCOPvrnGV@leg>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
 <20240816-dcd-type2-upstream-v3-18-7c9b96cba6d7@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816-dcd-type2-upstream-v3-18-7c9b96cba6d7@intel.com>

On Fri, Aug 16, 2024 at 09:44:26AM -0500, ira.weiny@intel.com wrote:
> From: Navneet Singh <navneet.singh@intel.com>
> 
> A dynamic capacity device (DCD) sends events to signal the host for
> changes in the availability of Dynamic Capacity (DC) memory.  These
> events contain extents describing a DPA range and meta data for memory
> to be added or removed.  Events may be sent from the device at any time.
> 
> Three types of events can be signaled, Add, Release, and Force Release.
> 
> On add, the host may accept or reject the memory being offered.  If no
> region exists, or the extent is invalid, the extent should be rejected.
> Add extent events may be grouped by a 'more' bit which indicates those
> extents should be processed as a group.
> 
> On remove, the host can delay the response until the host is safely not
> using the memory.  If no region exists the release can be sent
> immediately.  The host may also release extents (or partial extents) at
> any time.  Thus the 'more' bit grouping of release events is of less
> value and can be ignored in favor of sending multiple release capacity
> responses for groups of release events.
> 
> Force removal is intended as a mechanism between the FM and the device
> and intended only when the host is unresponsive, out of sync, or
> otherwise broken.  Purposely ignore force removal events.
> 
> Regions are made up of one or more devices which may be surfacing memory
> to the host.  Once all devices in a region have surfaced an extent the
> region can expose a corresponding extent for the user to consume.
> Without interleaving a device extent forms a 1:1 relationship with the
> region extent.  Immediately surface a region extent upon getting a
> device extent.
> 
> Per the specification the device is allowed to offer or remove extents
> at any time.  However, anticipated use cases can expect extents to be
> offered, accepted, and removed in well defined chunks.
> 
> Simplify extent tracking with the following restrictions.
> 
> 	1) Flag for removal any extent which overlaps a requested
> 	   release range.
> 	2) Refuse the offer of extents which overlap already accepted
> 	   memory ranges.
> 	3) Accept again a range which has already been accepted by the
> 	   host.  (It is likely the device has an error because it
> 	   should already know that this range was accepted.  But from
> 	   the host point of view it is safe to acknowledge that
> 	   acceptance again.)
> 
> Management of the region extent devices must be synchronized with
> potential uses of the memory within the DAX layer.  Create region extent
> devices as children of the cxl_dax_region device such that the DAX
> region driver can co-drive them and synchronize with the DAX layer.
> Synchronization and management is handled in a subsequent patch.
> 
> Process DCD events and create region devices.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
One more minor inline.
> +static int cxl_validate_extent(struct cxl_memdev_state *mds,
> +			       struct cxl_extent *extent)
> +{
> +	u64 start = le64_to_cpu(extent->start_dpa);
> +	u64 length = le64_to_cpu(extent->length);
> +	struct device *dev = mds->cxlds.dev;
> +
> +	struct range ext_range = (struct range){
> +		.start = start,
> +		.end = start + length - 1,
> +	};
> +
> +	if (le16_to_cpu(extent->shared_extn_seq) != 0) {
> +		dev_err_ratelimited(dev,
> +				    "DC extent DPA %par (%*phC) can not be shared\n",
> +				    &ext_range.start, CXL_EXTENT_TAG_LEN,
> +				    extent->tag);
> +		return -ENXIO;
> +	}
> +
> +	/* Extents must not cross DC region boundary's */
> +	for (int i = 0; i < mds->nr_dc_region; i++) {
> +		struct cxl_dc_region_info *dcr = &mds->dc_region[i];
> +		struct range region_range = (struct range) {
> +			.start = dcr->base,
> +			.end = dcr->base + dcr->decode_len - 1,
> +		};
> +
> +		if (range_contains(&region_range, &ext_range)) {
> +			dev_dbg(dev, "DC extent DPA %par (DCR:%d:%#llx)(%*phC)\n",
> +				&ext_range, i, start - dcr->base,
> +				CXL_EXTENT_TAG_LEN, extent->tag);
> +			return 0;
> +		}
> +	}

For extent validation, we may need to ensure its size is not 0 based on the spec.
Noted that during testing, do not see issue for the case as 0-sized
extents will be rejected when trying to add even though it passes the
validation.

Fan
 

