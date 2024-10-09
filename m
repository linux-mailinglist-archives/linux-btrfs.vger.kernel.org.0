Return-Path: <linux-btrfs+bounces-8744-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E8F99732B
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 19:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 247DC1C22632
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 17:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D2A1E0E16;
	Wed,  9 Oct 2024 17:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5WLis4o"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C7E1A2630;
	Wed,  9 Oct 2024 17:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495296; cv=none; b=aiL7Yg7t6fIyx7g2Ee4xefKW9Z34PjOcLAh3Ackvo9VcmvgFWHkHVYlqk/+1Xsy//ILNSiGMja6j4eQLIht7nMceRhxfpYxbozZAV/QwIqMvbnQ81h1HJIUcxqHGoDZ4Cdzr+QExtdHuVa4EoP30s5CIeuOp1ONRhJQxMOkgihw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495296; c=relaxed/simple;
	bh=oeLkdWrCv5LkmpnXbhNmxwvlNNYmSlIvBrYlfACHjGY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a585qglNemJF5UcQJresl1PHI706lPwt8Or/vPa0jTXS+lDz1wItaUjm7nwcT8F3Yg35tGc+cHFSL2EoBYu0dEE6kYlSa+cbhwcgQnZQUnKKrtlyUbWehe0kRUyymeObBte+gK0+qerb/en3t7dzXyODYdfKZWGM0e2hM4OOjUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5WLis4o; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e2772f7df9so784167b3.2;
        Wed, 09 Oct 2024 10:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728495293; x=1729100093; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2woNv3OfgPw1OV3xE2cmaefjQ/xqlt3SqQjOoMCmrEc=;
        b=b5WLis4oBC/lurcyHcsx4fxgD3EvEU7mzTnAcRu5E4ymuNI0iH3l5fbiMt4wVREpSG
         hM7hUbBSIGoYXncIY85gmOTEuzTz3t2XzopbgII9YYeSNsFJwN8Btz584iJ3StzZDcRH
         +0GPwUj+3tMplIBpO6Y87He6lZABsSDKI4CDOJToVUUP+grY9evfdx5QUl/AWt8Y2ZGh
         EWsuTdWeNCHhO3L4t9PPgrii/b6Y3wKkAGf7A19J5wry+pefs5O22ebVA3F1DIAWRtBX
         FhHAGbWNrOmEnAaFlO6ajqwcqKt5nohjLw0ZL3PlYM0qXCDWNHMo06dz/TLyUEOjuKg0
         b2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728495293; x=1729100093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2woNv3OfgPw1OV3xE2cmaefjQ/xqlt3SqQjOoMCmrEc=;
        b=oHcC9FbCch1NEMTx++UhpxwMI1b+3ZG1rb/HFh+tMWdnZCtb25sdSQc6RIh7ZG1P/v
         rqpTCs74+FtvEi8ge2xIFUudm5ZY/wiEbVUpv6BsGn6HoqabHzlIwkm+ysjA/A2ReP3F
         PsjRRlV38Ikv0Nd4W0wXfSjNb3Qs6fgBculpz0nMmyC7lc99OfZfGc2BSWMN6SI3zYGx
         5VeUVTvV05G/v4iIYKTptgvVM4ITQbyUcSbgYTJgvfKhoSXWX7Hk8PflPd3Sk/yogvnA
         xe2smVamddzNs/xizXUZxl+E1eY5AcsOkKjNbP0P4RNgkgac3V04fQ/xF7N11hCnOIfL
         OrcA==
X-Forwarded-Encrypted: i=1; AJvYcCUE9t6CWpQKVnw4rGtT4rm5ZqNYjcC8nxOq+iURE+Zn5OgY6WCjqW2sT1p4bw8Y4dBSjYNZmOQsBJL83aml@vger.kernel.org, AJvYcCVJgtImijma1yuGCNcthYIfo5dZ3dj8auN4iz1rJ+B8uFa7KXoa28cYl36XcGDzW0BreRQNMbTSdHYd@vger.kernel.org, AJvYcCVdc8BbNS7gFeW/MddKzlypGOOx7fTD+EyVQfa0XtdZ69K0tjM3dAcTBFyHNxcgRk750m+KiCAKCo1n4A==@vger.kernel.org, AJvYcCWnjyxkCI24+EI2U2nrfv2qUYN1YH9sSGx1gvB7J/9eYj2kW7srBxD9d1A2IkResCyVp2gvZP1GCiuJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yykgdjbu48tnvB2z/9XAhCHGcwyP/4zAnreOb6S9N+hyciDdGwf
	Y0rEjN0V4bOopBBFJ80on1ovjT5vWjjn/mkZtZhdp04s+iBzkmGm
X-Google-Smtp-Source: AGHT+IEq3MufEOXftigWGdRndlAx7RSkyaK4tsjkc/CE/MlAYMgrL2JdUZFXoPxMKIZAE4l7TzPynA==
X-Received: by 2002:a05:690c:660b:b0:6e2:b263:1045 with SMTP id 00721157ae682-6e322132ef2mr37828337b3.6.1728495293438;
        Wed, 09 Oct 2024 10:34:53 -0700 (PDT)
Received: from fan ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2d9388279sm19362137b3.65.2024.10.09.10.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 10:34:53 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Wed, 9 Oct 2024 10:34:50 -0700
To: Ira Weiny <ira.weiny@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Navneet Singh <navneet.singh@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-doc@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v4 03/28] cxl/cdat: Use %pra for dpa range outputs
Message-ID: <Zwa-urzkRBCtV9S2@fan>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-3-c261ee6eeded@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007-dcd-type2-upstream-v4-3-c261ee6eeded@intel.com>

On Mon, Oct 07, 2024 at 06:16:09PM -0500, Ira Weiny wrote:
> Now that there is a printk specifier for struct range use it in
> debug output of CDAT data.
> 
> To: Petr Mladek <pmladek@suse.com>
> To: Steven Rostedt <rostedt@goodmis.org>
> To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> To: Sergey Senozhatsky <senozhatsky@chromium.org>
> To: Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION)
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org (open list)
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  drivers/cxl/core/cdat.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index ef1621d40f05..438869df241a 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -247,8 +247,8 @@ static void update_perf_entry(struct device *dev, struct dsmas_entry *dent,
>  	dpa_perf->dpa_range = dent->dpa_range;
>  	dpa_perf->qos_class = dent->qos_class;
>  	dev_dbg(dev,
> -		"DSMAS: dpa: %#llx qos: %d read_bw: %d write_bw %d read_lat: %d write_lat: %d\n",
> -		dent->dpa_range.start, dpa_perf->qos_class,
> +		"DSMAS: dpa: %pra qos: %d read_bw: %d write_bw %d read_lat: %d write_lat: %d\n",
> +		&dent->dpa_range, dpa_perf->qos_class,
>  		dent->coord[ACCESS_COORDINATE_CPU].read_bandwidth,
>  		dent->coord[ACCESS_COORDINATE_CPU].write_bandwidth,
>  		dent->coord[ACCESS_COORDINATE_CPU].read_latency,
> @@ -279,8 +279,8 @@ static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
>  			 range_contains(&pmem_range, &dent->dpa_range))
>  			update_perf_entry(dev, dent, &mds->pmem_perf);
>  		else
> -			dev_dbg(dev, "no partition for dsmas dpa: %#llx\n",
> -				dent->dpa_range.start);
> +			dev_dbg(dev, "no partition for dsmas dpa: %pra\n",
> +				&dent->dpa_range);
>  	}
>  }
>  
> 
> -- 
> 2.46.0
> 

-- 
Fan Ni

