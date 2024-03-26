Return-Path: <linux-btrfs+bounces-3620-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B61B88CC07
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 19:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E1191C657BE
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 18:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BED112AAC0;
	Tue, 26 Mar 2024 18:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdvVyUnw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3E0126F1E;
	Tue, 26 Mar 2024 18:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711477844; cv=none; b=YeWKXdoVCMc8l07WBO2mV03AK0M0SETDNoYEkUAtEBU5imquXnnlBkEuhuAXF/DeFejx8rGrotJ1iMLMM7q6atuHc47bTtgN0YMryDXWV4SQAPBqRuZfojon3YWQd2vCSvueo5I4yCnFVIsDeNtvJneH7SSsiKaE2DUQTXaWBlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711477844; c=relaxed/simple;
	bh=sAyOUEKczk4vCaBI7fCgM6yZpeBEglMUpPYimbD3Wuk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KbCqMNDzkTV3vlv/bpARPKNj/RfxUO+XmQR/dgmVFbjT4yvI4ZYNeUuILT4y2F/yFNJzwdSB/KUV/tnatDUtpYkNQb24rn9P6dfVX5YsmyXgwOkp5Fd8tIbXpRDzuAM85ffy6Ezu0OjIzfHIqrn+Wl2MuSsY+Odi72X5W4y7wxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdvVyUnw; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e0411c0a52so43850265ad.0;
        Tue, 26 Mar 2024 11:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711477842; x=1712082642; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iUdKOd7rx0WMRV6Jyf1lEVlg1MEyH9tPtK2n/H0R3Jk=;
        b=kdvVyUnwuw/NoXtocv9KZPkO6Q0B00DUWa3qUrgcUIB+nZxDOiGb76T5hk3T/0Fxs1
         meuoUDt6m1Tj1UYAAzyfzNvWkb6KJU/lqgMpfq/HEke3RIPM2gEtfeoTXdV4QME4ZASL
         UyFrB6v7Ft5rapQ7Tz6au2wI43/Y+NaTdeBMN8gZjiKe4pLI32ijmsDj6qC7BisvS3+Y
         yvmAkdVTeSmM6gglnd8rvVhzdvL6quf2RKTty2clFP/yfVT08ziQcCGqHU4pk+JQ6vDt
         LpdJ2jKqI07wmijtDwBEATzhx7ux/YKm72qGCxMuBpaotz5qy/8SaWMhFDWTpAx0s6Vq
         jz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711477842; x=1712082642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUdKOd7rx0WMRV6Jyf1lEVlg1MEyH9tPtK2n/H0R3Jk=;
        b=RsYjdf+kWbt+yMrqQyTDwBp/u+Mbyw5gJPxIN6+3JVwMseo/WO9GydJnhLsFiOVdcj
         xK1L/kKoklMp8hMty9f/wkfhYFO5Ej9GINSyRTZfWq/RUi+Q9dHzWiOI41RM8WH6J7v8
         VLGxf6rXI+G+AZKCtSzFXANjzo74ejw2uV1WvshIuQcaWsKPEgkgQCWdDpnli8bRXnhf
         jchcp+CCwWBODsn7ccDMkrBYfT+hUPcaXJe08CaZlpbzogJ3NMFroBcsHdCY2z+U0ETQ
         rssSyb9WTSxUV56MQKpeHeBB51+n9eyeZUMT7mEK2tzMTRLonypzdjuUcKo9Lm9vY+hO
         MXOw==
X-Forwarded-Encrypted: i=1; AJvYcCW/EIxbmPZg9RY8R5tB1JFn7XQlcgR4HCPdBTXq8O3xsnxTjD+nIp4JEs8CTz04lxFEmRjrP/BM9j9yocNNn4CQhJ+1ZNWM++6/6mnh6DuGS1GlC4t2ML1HFJw7nlVrrJXpci3L7LU81ytxcBFewNKblE7/o1tfYdeV9A7R7M1taz+/PUw=
X-Gm-Message-State: AOJu0Yza8mOB9A8V4627snxwLKjRalbdEm/owkMgSKlooYnWoO0uUAUH
	Nd8/REnGVoYHrhvC221Z5JuhiiKNu5rqwum3OgAZXkNZI+5oLjh7
X-Google-Smtp-Source: AGHT+IHh6JX3lwXrIJoiJWTgBiw0gt3RVc2+M2dHJ2GjDbmxIo2EmZBN6zLFVtqAVrcjEF8ZgUfndA==
X-Received: by 2002:a17:902:da8c:b0:1e0:b60e:1a1f with SMTP id j12-20020a170902da8c00b001e0b60e1a1fmr7673040plx.8.1711477841957;
        Tue, 26 Mar 2024 11:30:41 -0700 (PDT)
Received: from debian ([2601:641:300:14de:69a2:b1ff:1efd:f4a9])
        by smtp.gmail.com with ESMTPSA id x3-20020a170902ec8300b001e035cecd27sm7185044plg.129.2024.03.26.11.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 11:30:41 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Tue, 26 Mar 2024 11:30:38 -0700
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: ira.weiny@intel.com, Dave Jiang <dave.jiang@intel.com>,
	Fan Ni <fan.ni@samsung.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Navneet Singh <navneet.singh@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/26] cxl/mem: Expose device dynamic capacity
 capabilities
Message-ID: <ZgMUTq6HasHOiR15@debian>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-8-b7b00d623625@intel.com>
 <w4jkueqpvh7hzbywk42m7gxclg56nbgzhaqcgeb3q2b6dt3w6n@5vwicganqpsu>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w4jkueqpvh7hzbywk42m7gxclg56nbgzhaqcgeb3q2b6dt3w6n@5vwicganqpsu>

On Mon, Mar 25, 2024 at 04:40:16PM -0700, Davidlohr Bueso wrote:
> On Sun, 24 Mar 2024, ira.weiny@intel.com wrote:
> 
> > +What:		/sys/bus/cxl/devices/memX/dc/region_count
> > +Date:		June, 2024
> > +KernelVersion:	v6.10
> > +Contact:	linux-cxl@vger.kernel.org
> > +Description:
> > +		(RO) Number of Dynamic Capacity (DC) regions supported on the
> > +		device.  May be 0 if the device does not support Dynamic
> > +		Capacity.
> 
> If dcd is not supported then we should not have the dc/ directory
> altogether.
> 
> Thanks,
> Davidlohr 

I also think so. However, I also noticed one thing (not DCD related).
Even for a PMEM device, for example, we have a ram directory under the
device directory.

===================
root@DT:~# cxl list
[
  {
    "memdev":"mem0",
    "pmem_size":536870912,
    "serial":0,
    "host":"0000:0d:00.0"
  }
]
root@DT:~# ls /sys/bus/cxl/devices/mem0/
dc  dev  driver  firmware  firmware_version  label_storage_size  numa_node  payload_max  pmem  pmem0  ram  security  serial  subsystem	trigger_poison_list  uevent
root@DT:~#
===================

Fan


