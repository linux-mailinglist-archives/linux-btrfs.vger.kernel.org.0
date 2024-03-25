Return-Path: <linux-btrfs+bounces-3577-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBFB88B5EB
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 01:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BF781C36D8D
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 00:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F984A32;
	Tue, 26 Mar 2024 00:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="li/3jXj1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from shrimp.cherry.relay.mailchannels.net (shrimp.cherry.relay.mailchannels.net [23.83.223.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437631FC4;
	Tue, 26 Mar 2024 00:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711412290; cv=pass; b=uGePIk2s0fpTMDwP6or0q4FmNCgUWG5qYyfqU/kjwKZkUFdn1n95f1A50W3K46g8Q0DAp3fVpLVllmaQlF/QX5znG5gNjpZ1HjyRXp/HOIlvqutE4ECCa8/v7zBkdfoscNJZSMIEE/oD94clO+5NkI73CImlru+TBFxPlrTGchk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711412290; c=relaxed/simple;
	bh=hqJfcae45ymnqggi0UY6wccelEk8EXZOUkquTZ5mqes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBMlIJkVqHro+yZIc/Ksm+NEbxpCQiLvAyeWJVNwm3MOEzPd7jJigNjNTe6aJicHS4RNT37+c53OXAbUdVKk1hSFiYYaEPgqqTM1la5ZUGBco+5a4zblEIKsAe/vjQIlb7lEVje2aYFNBsIBr8o/PevnJbfbNB36HHBCBlERy2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=li/3jXj1; arc=pass smtp.client-ip=23.83.223.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id AC7D2C127A;
	Mon, 25 Mar 2024 23:40:22 +0000 (UTC)
Received: from pdx1-sub0-mail-a262.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 2C587C0F14;
	Mon, 25 Mar 2024 23:40:21 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1711410021; a=rsa-sha256;
	cv=none;
	b=TPAkg+JBPtNKJO+AZpRrAHDnQeqLoCC4UuOCAf5YbXfLLouFuSuj3uPGqVZpTWUYY+MJq4
	uEWUg/+wdqQON/YaabXFRP4g1/0VV7fA5lsCVbZyHcn3gO06D3awRZayXuv9SLorYLo57h
	BzSEQlLPNO+6uuVoAom+vf202EOcIFKWNaBCHQuglBd1Vcik6iRjq0EE75//PfLdbArceq
	oZnnRnxICoR5b4MQJ3LZOyz1RzB3bqsafFpyx9o4x0/1zWkXexgOBN72n254mrygkZyv1q
	n/i+YpjZj5ASyPUW5DysbpWGnVWOn+YQer97S9JnSSrX32Xp7AemE+UMx5Gd8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1711410021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=mMYNUS1nAHaY9MIkgohtMIfZr6emhTBLCF17GGgwhJQ=;
	b=mfazkx71M75YovF7PL6l86risNFql1AWRLUZDVeL4bAiU8CuI+16QXhRu201hRW03d0+kH
	CxNuPV5lXuC5XogYqGcAuFZo4O8BIeDo8pcGjyvqT1YXHMWhkyv7ZcjOWs4212LpMNZhsI
	Ct9SMVV87DLe670BDrfED7zu42pcPn4y57eXe6qnyNSvNfXX6ErhP83T71eNuZ/P3upNY2
	9BMxnyS7wPGSK67NGKgABMmqZ3+UDAAu+JbE0u729LSZVG9PlqUQiZBi4D13y0vv1k2Vnk
	J1y7IA+E+x9zmmJ0nBZJ7UKrNK8ucxPbLyFuocCtzd1CVuM7tCGWMHbzE+C6HA==
ARC-Authentication-Results: i=1;
	rspamd-dbbfdf895-ck4qv;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Print-Supply: 3f65cbf05927a7a8_1711410022531_4039963789
X-MC-Loop-Signature: 1711410022531:1342609886
X-MC-Ingress-Time: 1711410022530
Received: from pdx1-sub0-mail-a262.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.123.121.28 (trex/6.9.2);
	Mon, 25 Mar 2024 23:40:22 +0000
Received: from offworld (unknown [108.175.208.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a262.dreamhost.com (Postfix) with ESMTPSA id 4V3Tv72yW2zLZ;
	Mon, 25 Mar 2024 16:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1711410021;
	bh=mMYNUS1nAHaY9MIkgohtMIfZr6emhTBLCF17GGgwhJQ=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=li/3jXj1UMi2ph5i3up8ip4QNsfwIf8k+GvR9U9ZcF7ySRPqgRUJqiY5DJG9kGpj5
	 7SaeLCvC8bPiW7y/+A6h78a+T7MMHF78wXbXz38PlsMbmDmLQ9RkyscSVi8gMtc9vl
	 nb9JXZKRWE6tyGcNdCxPpyu/EfsB3yzVieynB3+E7AJPneABy14Uqels1toJ0sqa/d
	 AW7n8hWxMwWIvCfSZnL8MocL8hFq3tP/w0+3qp0IB3/M1Zyz9m4l6FA2PB3ySobc9C
	 ThzuzgpHaFBFPy9v5MyuI0TJ6KmdAGGwVQ235N5IIWZJjp7BBGGJQXuupAxT+9Z9yX
	 yThYeUuk9kQrg==
Date: Mon, 25 Mar 2024 16:40:16 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: ira.weiny@intel.com
Cc: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Navneet Singh <navneet.singh@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/26] cxl/mem: Expose device dynamic capacity
 capabilities
Message-ID: <w4jkueqpvh7hzbywk42m7gxclg56nbgzhaqcgeb3q2b6dt3w6n@5vwicganqpsu>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-8-b7b00d623625@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240324-dcd-type2-upstream-v1-8-b7b00d623625@intel.com>
User-Agent: NeoMutt/20231221

On Sun, 24 Mar 2024, ira.weiny@intel.com wrote:

>+What:		/sys/bus/cxl/devices/memX/dc/region_count
>+Date:		June, 2024
>+KernelVersion:	v6.10
>+Contact:	linux-cxl@vger.kernel.org
>+Description:
>+		(RO) Number of Dynamic Capacity (DC) regions supported on the
>+		device.  May be 0 if the device does not support Dynamic
>+		Capacity.

If dcd is not supported then we should not have the dc/ directory
altogether.

Thanks,
Davidlohr

