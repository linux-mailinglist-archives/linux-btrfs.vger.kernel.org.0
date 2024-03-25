Return-Path: <linux-btrfs+bounces-3563-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DF888B2AB
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 22:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 050F41C3DAA3
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 21:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E116E5FD;
	Mon, 25 Mar 2024 21:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="ia2QKCUy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from buffalo.tulip.relay.mailchannels.net (buffalo.tulip.relay.mailchannels.net [23.83.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D384D6D1A3;
	Mon, 25 Mar 2024 21:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711401875; cv=pass; b=GSWmonmnzt3FokXic2cxKiiMAhYJJdywzFCknwfAwEfRqvz4u76ar2lZq7J0jMU4Pi45C9QMwgqYE+bLcn/vF20sA2AEw8TvOj8dRVzLj0AHOZ8S8fSyQb2VdF6AaDX1k1eim6YavYL/L2GyYebOLR+iU6mf8f++32I0BySqTn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711401875; c=relaxed/simple;
	bh=JeBsDrN62CKUSBOGNqc7TSV8A+qBlQZ+s78J63U4gLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Km4QxU3NgHC6BG2sxuyqpvaFKIYMwdmsU6P9FHqAKi6GBlAeVQ0VEHDfSEtLN/WHVe/OH+IADStHc2wjl/iHN+SS6EKJohMyGS73y8nK4jyTCIlOVRwBBwjIdabHjPcUQZwWQA/lmTHy/az9vo78RkfhmaSQXf24ClCPNWsgC8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=ia2QKCUy; arc=pass smtp.client-ip=23.83.218.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id E419D800FBE;
	Mon, 25 Mar 2024 21:24:26 +0000 (UTC)
Received: from pdx1-sub0-mail-a262.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id E8DF280268D;
	Mon, 25 Mar 2024 21:24:24 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1711401865; a=rsa-sha256;
	cv=none;
	b=VUXitPAVPwtqJnasaA5vGyNoeWV4O25jbJQaUvNLPv1R08Tuu28gFH2nF37rRk2M7n5Csg
	UMmLNEAGK5uhF2TrWPdCQPVBKk4il/RPPtarwraRCe5Jol4gUHQIcIIEPNL94V4Naar9cX
	O1jVxnB879Al51gehcVGhaAmnv9hV83zznwct3GO0phsc2QruhwVPCKVarv61reQVgidxc
	WuG9XK4/GK8xHcmi8P2CQ5jsE0hOeE/fp20hrZk3cfwHN85JDwPvX6Ez3ihGP442qyfP4V
	90Oo981x5pCnI1L0/Yz492zaHoIAO6nM9i/77AKAZj4hnJ1tusYn7jmWopPIjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1711401865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Azsg/ExjGsW9FoIaXnxPIL5SAT0HzHQSiEtzLfgyGAA=;
	b=E3lu7AHr2WkJBfkiIfVKFGpoC4geR9uOYtHPCScae7vDyyFLiXxMXeXvNU8mC/QWjY/32v
	airRfKeaGj/R99JNeC1r1iWxqu7Th/dFllaPSSvkWUiSETM+U2lUt3LGjWHSgZUY0rACGL
	VhkO05S5fq0C7tVThEb42l+MUiwTsIJ50JI10n2cnTzLFlCAl79bo6msRfVOxamddX2YK4
	5tdXctl5KvpRHCQLfIOkepusH05hZYuBLSu6oJyMAmfhuZgi3q85vrdagijHIYK+0eJcJA
	9cIu3FCUFxWRGrzYwPz1r9vgsXZdOors4ydzX4J1XfdxLbE2lSs0rfjhZx8ehw==
ARC-Authentication-Results: i=1;
	rspamd-dbbfdf895-qt6zv;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Macabre-Snatch: 1af589df679ec0de_1711401865615_1758965339
X-MC-Loop-Signature: 1711401865615:3062706891
X-MC-Ingress-Time: 1711401865615
Received: from pdx1-sub0-mail-a262.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.118.210.220 (trex/6.9.2);
	Mon, 25 Mar 2024 21:24:25 +0000
Received: from offworld (unknown [108.175.208.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a262.dreamhost.com (Postfix) with ESMTPSA id 4V3QtH5dzszN1;
	Mon, 25 Mar 2024 14:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1711401864;
	bh=Azsg/ExjGsW9FoIaXnxPIL5SAT0HzHQSiEtzLfgyGAA=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=ia2QKCUyrLVZfdYFgrebj3qzsYPUYdOo7kyirjZEc9hsYwz0M+QMHq7OHgQuyyo5m
	 FDcNQz4x1+0wLrd6hTyM7tkQzeJnldfMiJnXgwb926BZEoG9u62pkBxJkzvu6Yx+vh
	 DpLzMKawuSf8UDrg30ugSkuJnbwQM4/tPYhWt60JsJLabyqCepQVxfMyYOgRIZF4zZ
	 65fvhix8Knqxdwm5tLlNFCjBJC/86Q59MURiGa6J2Qq1Wc+VlESja6UcUJkZPXxEyx
	 bP0tSdq5IAfwbqMWoUbXd2rS0qva2N8jT9HnU+YtxwMpHLS1OlNOgium6+2mCW22qP
	 KvaDmnvjsPJWA==
Date: Mon, 25 Mar 2024 14:24:20 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Navneet Singh <navneet.singh@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 15/26] range: Add range_overlaps()
Message-ID: <pce236tc76vsafgm4bjwy7vcvmqsonun2mnmotxccetfelj3p5@dyhmt45lnnh3>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-15-b7b00d623625@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240324-dcd-type2-upstream-v1-15-b7b00d623625@intel.com>
User-Agent: NeoMutt/20231221

On Sun, 24 Mar 2024, Ira Weiny wrote:

>Code to support CXL Dynamic Capacity devices will have extent ranges
>which need to be compared for intersection not a subset as is being
>checked in range_contains().
>
>range_overlaps() is defined in btrfs with a different meaning from what
>is required in the standard range code.  Dan Williams pointed this out
>in [1].  Adjust the btrfs call according to his suggestion there.
>
>Then add a generic range_overlaps().

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>


