Return-Path: <linux-btrfs+bounces-3566-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 836F588B67E
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 02:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27346B636F4
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 21:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5475B6F085;
	Mon, 25 Mar 2024 21:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="kti1ijWf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from toucan.tulip.relay.mailchannels.net (toucan.tulip.relay.mailchannels.net [23.83.218.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B896E611;
	Mon, 25 Mar 2024 21:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.254
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711402727; cv=pass; b=k5AxNpI3hhY+B7aQNT5Y2HLzFRFMlL2l5JKOlgAz/rzFzGX0ATJFjnPFZ71Is5LPotz+e646MfE6s37tPusmL7tAtdXyq2HxJqMPTAFZr4GYWi1+yV/XjKG8sn6SLN7yo1epM8l5eDD88v2FO6Qtk/TT5unfNCYJKIalL0yYhzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711402727; c=relaxed/simple;
	bh=BfrzovaPTYaILJssWn7Nx3MRnvGgWgiVAjq8TUTlxVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpRGK1FjSlI/vN9B1m6k3VKZxYAarSiKIx9CmlgO3BalGohvzjmwUuf7/aTb+tHHNgN4xSmgOm8LD4uWp7xKBc18sTwhnNPE11EOPF5WXYTSR11z7PPiT4r/zEQCQ/ek1bscI+OY87zgqVdkklD+CnG8Ufyglran7aU6Aj1Y+1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=kti1ijWf; arc=pass smtp.client-ip=23.83.218.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 0B75A8028C2;
	Mon, 25 Mar 2024 21:38:38 +0000 (UTC)
Received: from pdx1-sub0-mail-a262.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 53B7F802C11;
	Mon, 25 Mar 2024 21:38:36 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1711402716; a=rsa-sha256;
	cv=none;
	b=i5bITHOKqnVTANPsw49tZ57giJYI+BYyApaK4/xvMagW2Juff9HvvLpVEyTRClHeCbBaiS
	LSL4Fuuhj4YAMnc2owh5c4tZN9SnZXtAPBkjZnG/dyEfUOHBmWqUQ4EgoIx4dl/AwxH9z7
	XiREcygxgTGpMXwYtvM8rKABo5jO66JljT1OIL0aWoJNBCj+E6CcoyDoVtMW4vr4ngZqOX
	uOb0TGk+702D3YfiXuPbUoJY6S5sTISB1W41CCFxx2ZiBuQ5QTywbospLigSNNMBZ5HFkb
	wxzjVjrfLXvqE/pEqieCtKdvv1P7UmmdwZT9v1xCVtMPRi7XySNouDfNyHtlAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1711402716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=tGiXBBfXzTceW9Ljl6Rv6G/RrkyUx/LLQsKTU8/y7os=;
	b=SgrGv7iShKvm6soic3/LQ3WvJcGjBi0d6MBegsNxx7hY9FUJwkZac99rnxITeH9yZQ/8xg
	wTSAvQeVQr6AWC9pmGeAukrZWzMDhHtvyc68k9KdVzY1+fhkqIWYbZlW/Iu7rj4H2FxcSM
	cPR2N6Y8t8FDqpO00mZyALrLMwMYPZu2HFFvdbrNcyrY7HGbD6av6LhGwefOwYVvwoQfPV
	xyXrfT381mifkAU6ANOiuNg0z3ogtc5HGQXqRqoqEdDkgbkp0va245NUvx/6nH+Y33a2QM
	ohxgCPeLP4j9Bu26kDQdUGI8G5QruoUBVc5SCMPcVVR9pithv30YvlM7rZVpFQ==
ARC-Authentication-Results: i=1;
	rspamd-dbbfdf895-ljm6h;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Lyrical-Lettuce: 72d0b04e04bf5627_1711402717849_4055661056
X-MC-Loop-Signature: 1711402717848:1809582852
X-MC-Ingress-Time: 1711402717848
Received: from pdx1-sub0-mail-a262.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.123.121.28 (trex/6.9.2);
	Mon, 25 Mar 2024 21:38:37 +0000
Received: from offworld (unknown [108.175.208.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a262.dreamhost.com (Postfix) with ESMTPSA id 4V3RBg3ghDzNp;
	Mon, 25 Mar 2024 14:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1711402716;
	bh=tGiXBBfXzTceW9Ljl6Rv6G/RrkyUx/LLQsKTU8/y7os=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=kti1ijWf5x4DWhuiZZ4asypF67MJzo8S+vRjxKsozYDMz44zIgKp5f8uQOcOsMUxy
	 4Fzx6rcVkI7aQOB9H/sBcAmCq0Z1OPOKPc7DSbbSh2Etjq+FeEQfcTaOyLjJo9MgLd
	 l9mhf31ezB5NWye/vpHgN2ueYtNnd5yZHbomrrqDzSZWRiRjadsqWoRSysxVFIVbxy
	 7JuytwMVxMnEGn96MKOwwije30H4ddsii+ig0KJ0wMq4qEQnFtfOcNm8pS2dK1WIw2
	 mwPxUNgktHsXkYPWoE95iSEvL995qNBLYgrF5UscBmqR7bPqgh7a0XBuIJgthWRM7Z
	 h2dukTrWj4L2A==
Date: Mon, 25 Mar 2024 14:38:32 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Navneet Singh <navneet.singh@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/26] cxl/core: Simplify cxl_dpa_set_mode()
Message-ID: <zmcr2lththfsr2zvmgksmmbaupfss2lmgjkyegpvqokynnaknq@ssp2xxvyl222>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-5-b7b00d623625@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240324-dcd-type2-upstream-v1-5-b7b00d623625@intel.com>
User-Agent: NeoMutt/20231221

On Sun, 24 Mar 2024, Ira Weiny wrote:

>cxl_dpa_set_mode() checks the mode for validity two times, once outside
>of the DPA RW semaphore and again within.  The function is not in a
>critical path.  Prior to Dynamic Capacity the extra check was not much
>of an issue.  The addition of DC modes increases the complexity of
>the check.

I agree (also to pick this up regardless of dcd work).

>
>Simplify the mode check before adding the more complex DC modes.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

>Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>
>---
>Changes for v1:
>[iweiny: new patch]
>[Jonathan: based on getting rid of the loop in cxl_dpa_set_mode]
>[Jonathan: standardize on resource_size() == 0]
>---
> drivers/cxl/core/hdm.c | 45 ++++++++++++++++++---------------------------
> 1 file changed, 18 insertions(+), 27 deletions(-)
>
>diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>index 7d97790b893d..66b8419fd0c3 100644
>--- a/drivers/cxl/core/hdm.c
>+++ b/drivers/cxl/core/hdm.c
>@@ -411,44 +411,35 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
>	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>	struct device *dev = &cxled->cxld.dev;
>-	int rc;
>
>+	guard(rwsem_write)(&cxl_dpa_rwsem);
>+	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE)
>+		return -EBUSY;
>+
>+	/*
>+	 * Check that the mode is supported by the current partition
>+	 * configuration
>+	 */
>	switch (mode) {
>	case CXL_DECODER_RAM:
>+		if (!resource_size(&cxlds->ram_res)) {
>+			dev_dbg(dev, "no available ram capacity\n");
>+			return -ENXIO;
>+		}
>+		break;
>	case CXL_DECODER_PMEM:
>+		if (!resource_size(&cxlds->pmem_res)) {
>+			dev_dbg(dev, "no available pmem capacity\n");
>+			return -ENXIO;
>+		}
>		break;
>	default:
>		dev_dbg(dev, "unsupported mode: %d\n", mode);
>		return -EINVAL;
>	}
>
>-	down_write(&cxl_dpa_rwsem);
>-	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
>-		rc = -EBUSY;
>-		goto out;
>-	}
>-
>-	/*
>-	 * Only allow modes that are supported by the current partition
>-	 * configuration
>-	 */
>-	if (mode == CXL_DECODER_PMEM && !resource_size(&cxlds->pmem_res)) {
>-		dev_dbg(dev, "no available pmem capacity\n");
>-		rc = -ENXIO;
>-		goto out;
>-	}
>-	if (mode == CXL_DECODER_RAM && !resource_size(&cxlds->ram_res)) {
>-		dev_dbg(dev, "no available ram capacity\n");
>-		rc = -ENXIO;
>-		goto out;
>-	}
>-
>	cxled->mode = mode;
>-	rc = 0;
>-out:
>-	up_write(&cxl_dpa_rwsem);
>-
>-	return rc;
>+	return 0;
> }
>
> int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>
>--
>2.44.0
>

