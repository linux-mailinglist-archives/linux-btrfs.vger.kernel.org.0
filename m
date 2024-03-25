Return-Path: <linux-btrfs+bounces-3569-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8801388B681
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 02:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4D21B3AD02
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 22:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7146C80033;
	Mon, 25 Mar 2024 22:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="XI5ZRsC1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from silver.cherry.relay.mailchannels.net (silver.cherry.relay.mailchannels.net [23.83.223.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDC6763EE;
	Mon, 25 Mar 2024 22:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711405918; cv=pass; b=pbP//WzOn/B48LWJ6VST3zCyiY375/FN0jSyEoqdBnfKJGHnPDT1nHaOaz+er6wtHwtYGZWUPh3Zhuqpzl66eJzp606bwbjQoxdnOv4T8SQ/Ha/wL8L/ehabA86KMKCNnRyrP/QEk7NVny93PLTNNui9uZ7YhuLqIeXq7mvUyV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711405918; c=relaxed/simple;
	bh=2klrCOGU3u+3RDtQus/+ny8XUXjCLoWlje16CaT227M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avjQnRh238F7ngFnCyDaGw/WDSPCZxTuQvjkGRrw9++cjEnWJ15lw4RampBWCm+pQwdUnmjXqhz92Dbwp4in2etotCtXL+gVpzOiv44QSHyWGkG1Mga6zNcaHDmNMc/JSf+4RIWqrIK6NediDGkJZPclnpQKJ08qgdyYvhHrXso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=XI5ZRsC1; arc=pass smtp.client-ip=23.83.223.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id E75C76C3523;
	Mon, 25 Mar 2024 22:26:26 +0000 (UTC)
Received: from pdx1-sub0-mail-a262.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 3C2C16C38BD;
	Mon, 25 Mar 2024 22:26:26 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1711405586; a=rsa-sha256;
	cv=none;
	b=YQA9zDOSngd6sHY5S60GgMJ7Ym131iPm4G1ZymSNXBY0JJhQ6n35cKp8hCRza4XYkRhbsJ
	eVOTjYoR+TYMMoIaY9SXQ4cAS1x6df+BTpIslcVc1xU2yYKoDcOwh7mcgGWUavb4VW2/zC
	gTDFlWNbt6GJCwkSyl20RGICexQQ4qAgn47Rj9anezIIEcRIv/U+eVasabpW5GWnWiYY19
	7D70NPhDgiiOC277ztnx81lkgnWUYDVBlSaVKoOGtS8W9LwNE484/w7FFdsrH4ZRvBzCRn
	Hpt4vwjdEY0ZrAOwpKdR1QPADM5qHyNUHoAoBMKZPC0TAGQfSTnGA0U1JgX79g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1711405586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=5syhqyGKayQD79m3bj55ZP0GtVHOmxoOvlT2cxDiOlA=;
	b=2UmD3JWvU4wahOIOdhkx0DmXt8FK+NO/h7XMMb+R2z+PXNtk4/7Zx4SAfmrxv/3PKzBRQO
	8ql9HEg0aJr5vQN6N71jxCYkIo01z1IpFyD3X+ATG3cUGxCdxUOPzVPSID64YVfLt7nezn
	E+86ErgPFuCNbjPc6DXCPR05syWVOKxsoBGVAdKtLs1nrD5zWpBb0lKs5jIQ2AJcZ8fYge
	HK/ZAHAEs/xnyhZt1GxZ8lkhn+e+Zwq8RZWdowK86lgD94NaJ0So43WtHYw2PhBQIrWThH
	ToOK8OChrEygKyscGDw7WB8NdwCUoVTV20JlMGaCaDYDUhPP3MEwen36Qbge7w==
ARC-Authentication-Results: i=1;
	rspamd-6c65898bb7-xrm8z;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Eight-Vacuous: 26d43d7f28717ef5_1711405586586_1544570442
X-MC-Loop-Signature: 1711405586585:3795176681
X-MC-Ingress-Time: 1711405586585
Received: from pdx1-sub0-mail-a262.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.203.156 (trex/6.9.2);
	Mon, 25 Mar 2024 22:26:26 +0000
Received: from offworld (unknown [108.175.208.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a262.dreamhost.com (Postfix) with ESMTPSA id 4V3SFs15d6zN1;
	Mon, 25 Mar 2024 15:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1711405586;
	bh=5syhqyGKayQD79m3bj55ZP0GtVHOmxoOvlT2cxDiOlA=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=XI5ZRsC1S8FPlpQm7y4WKFVbzXHiVRN17R7zjz9dewK2tJ26c8Yosq+jRGgMIm/lk
	 9IMZRIomOK2OPFiYdfkmb8sgL9uDRScWcvxvs5C1AbcJ2P1zt2AaVW6TirhgFtAbwI
	 NnxGmqWISIZuZDM3lRZHcRoSdedW1vemdaGtG5B8W+KQUNAiTrC7ObgDiPKo4G0QiU
	 vNctyiCS4vd7E9vmc2xEdtueyOtqgUcuIlLt0h5Z5+b1aTafzhjwMwP3JkKk6FkBs8
	 q9X85d+1VgEHggYk7EIZ0Ah5oN1LtbtYCKgV85yfqlAz/WLBhj2Z8Rz7aa3xw5epNQ
	 APJNIwMquGQWQ==
Date: Mon, 25 Mar 2024 15:26:21 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Navneet Singh <navneet.singh@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/26] cxl/pci: Delay event buffer allocation
Message-ID: <7zwoy5okwoow3tnjjs5tfpsabbbflbagqjm7z2la7ekguxlhvk@gxm5vmaiqovp>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-11-b7b00d623625@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240324-dcd-type2-upstream-v1-11-b7b00d623625@intel.com>
User-Agent: NeoMutt/20231221

On Sun, 24 Mar 2024, Ira Weiny wrote:

>The event buffer does not need to be allocated if something has failed
>in setting up event irq's.
>
>In prep for adjusting event configuration for DCD events move the buffer
>allocation to the end of the event configuration.

The above could be removed and just picked up independet of dcd.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

>
>Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>---
> drivers/cxl/pci.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>index cedd9b05f129..ccaf4ad26a4f 100644
>--- a/drivers/cxl/pci.c
>+++ b/drivers/cxl/pci.c
>@@ -756,10 +756,6 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
>		return 0;
>	}
>
>-	rc = cxl_mem_alloc_event_buf(mds);
>-	if (rc)
>-		return rc;
>-
>	rc = cxl_event_get_int_policy(mds, &policy);
>	if (rc)
>		return rc;
>@@ -777,6 +773,10 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
>	if (rc)
>		return rc;
>
>+	rc = cxl_mem_alloc_event_buf(mds);
>+	if (rc)
>+		return rc;
>+
>	rc = cxl_event_irqsetup(mds, &policy);
>	if (rc)
>		return rc;
>
>--
>2.44.0
>

