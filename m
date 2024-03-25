Return-Path: <linux-btrfs+bounces-3575-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0F488B5F6
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 01:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC303B2F1F6
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 23:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3123083CA2;
	Mon, 25 Mar 2024 23:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="MpZrteLu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from dog.birch.relay.mailchannels.net (dog.birch.relay.mailchannels.net [23.83.209.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DA6839F3;
	Mon, 25 Mar 2024 23:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711409669; cv=pass; b=Ckd0FcdliCLUV3DBrJYfBq1pgDYlDB/+hXI1e1lWT/ViAVa3bSUwv0MCGELeR8sOqtEberN03OxVyKPCQgdw317ayGqOBPrz2wE9Fg2c4XNhDtUwqh87HPDoyyeNadWo/O4tUF6WbBPhBCWb/AwuLPiSu3NpM4+E1x+XkC/B634=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711409669; c=relaxed/simple;
	bh=m6BHKIP3yYP787KLlyFOCPfeLvpau/SvrjamEsRSPUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZ4Eo9VutTtTV++RTYSWZX6iuCY+5CY8UnVcGjEWwDLTm4cshMOPS0UDf3Fw7YO1G1pFG+jJHAjHOkWcLPpQcN6CaJN1FzfgHVs4QbgSVSAbhOssbJ+SHVfmfJU0eZJQ0gfosiS1VmF4lw8cVzuutVFfjO2vsuqbbWPKE3V0WGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=MpZrteLu; arc=pass smtp.client-ip=23.83.209.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 00BD8760736;
	Mon, 25 Mar 2024 23:18:45 +0000 (UTC)
Received: from pdx1-sub0-mail-a262.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 832777634A4;
	Mon, 25 Mar 2024 23:18:44 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1711408724; a=rsa-sha256;
	cv=none;
	b=3TblpKDXYcSsH2bd25EwE7W/Pb1tz4gOkokQ+Upu4UPb+5w4sD2U2Y7Xw5AJPkiOdVfkeq
	KujJkLw/L0MxwaYq/6Ue3ym8q1iAmxDxvwcUsaoxz9I0Ffs7P7EJchmq5DhCg+YBCbbXKn
	pi75+K2cmfjIJ/o+9/3G0C/LfFpJkO/o4dTp86Z8N6sxehmc+kKz/S2mdVc/hHKOsR4Zaz
	4C0U5Al4FZmcRREDqQwrNBLDtaSQB4c9SluUPenVl3PBY9gOuRol4h9OmD0cll810LbpON
	JJoEtm+n7ZeGS+icILl7hg0cXgYELrtql+qca4Z1dc7zyLme71HZeYWLBWQX9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1711408724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=mOpHsUr6UMnS6F96f4dLU9nCWrgJQEXGPDVf+Wu7ZVQ=;
	b=pPYo3ELc4yQQ3L/4rX0pvmnlR0Jr/GiIrLmFXnpHO/08W3pkbv8ZB0hsti/him58afnCWr
	J9iFoPR+WTN+/Dh5O51e8jWoLN5qXzIBXdEINder/TN/hwOmyLN/lKo2sxpttEnwfxXgJ8
	cGLPWv+nK9RcJwG/igBdy7kxLNJSP0qfm5a+d2ezlXDUbps6P4Cr43FM38zQXPuTxGf1l9
	GNWMLlLCXZn8SXRJA9v6Dvo92pliYmvwg0vnC3gynWhJQQNF7XDk64sl/+Dok3+50GoKf4
	hgZQU13+Q1btnT7DYxedPvAYbgkav4NwiK8xKPJZKivcPVGFkUO0SQWA1ipeJQ==
ARC-Authentication-Results: i=1;
	rspamd-dbbfdf895-bhcml;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Unite-Little: 0793e8701ae01480_1711408724856_2243145530
X-MC-Loop-Signature: 1711408724856:3485760441
X-MC-Ingress-Time: 1711408724856
Received: from pdx1-sub0-mail-a262.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.168.172 (trex/6.9.2);
	Mon, 25 Mar 2024 23:18:44 +0000
Received: from offworld (unknown [108.175.208.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a262.dreamhost.com (Postfix) with ESMTPSA id 4V3TQC4BNDz49;
	Mon, 25 Mar 2024 16:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1711408724;
	bh=mOpHsUr6UMnS6F96f4dLU9nCWrgJQEXGPDVf+Wu7ZVQ=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=MpZrteLuHk5jWJwGpKf6qFPxDFRod16bd249eNC4FoInmo/TaBXTyAsSu997WvMwm
	 A7kz/Zc10F7Joml37w/jC7hiTmwUg1qqrmdi7opOVUqq+SzhRZQluX11hXCIycPOhG
	 oZpFKWzt0Ctavr7KnqzESfkrLIG2+t+v8vBv9NiNxhJU4JDdGe7lqcIhg5G+IHwn2T
	 nj2N/8TxNcy0tfwBykhAbs2ZOJs1CJ1n/bc7tIVvDnvaf72SV08n0VgxSL+fcFw/YL
	 r8jsOyppmG/KiijPZlDtJhWt41Dzf+/LbPJJYBfcFkGe6YNpdpsViFmL9WjX09vhEZ
	 H/YJJbtFGuTXg==
Date: Mon, 25 Mar 2024 16:18:38 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: ira.weiny@intel.com
Cc: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Navneet Singh <navneet.singh@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/26] cxl/core: Separate region mode from decoder mode
Message-ID: <yd6mynddwk755ypomyspzxfsqwm7j5g47yfmbw2yfwoadpnnqy@7g3ktxrwkeau>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-2-b7b00d623625@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240324-dcd-type2-upstream-v1-2-b7b00d623625@intel.com>
User-Agent: NeoMutt/20231221

On Sun, 24 Mar 2024, ira.weiny@intel.com wrote:

>From: Navneet Singh <navneet.singh@intel.com>
>
>Until now region modes and decoder modes were equivalent in that they
>were either PMEM or RAM.  With the upcoming addition of Dynamic Capacity
>regions (which will represent an array of device regions [better named
>partitions] the index of which could be different on different
>interleaved devices), the mode of an endpoint decoder and a region will
>no longer be equivalent.
>
>Define a new region mode enumeration and adjust the code for it.

Could this could also be picked up regardless of dcd?

Thanks,
Davidlohr

