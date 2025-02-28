Return-Path: <linux-btrfs+bounces-11937-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87530A49A42
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 14:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 611AB18902DF
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 13:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58D326B2D7;
	Fri, 28 Feb 2025 13:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=merlins.org header.i=@merlins.org header.b="pW/bqJFd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B65256C8A
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Feb 2025 13:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.81.13.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740748209; cv=none; b=HZHU3pur1vDqBFM7+7FhWlzU3Ma5KRKoh3RT3QThYSNyYv8RN4oEnUVJblolKGc6a9l855k4+g18TB0lHgkG4BCXujvkTIv/mVJlSrD25/gQ1Vinv2kEs3/pFABTIy3YcdQieLcOgHWrrY3N/9QLHpvAJHMMyI1cSQrS3T+0sfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740748209; c=relaxed/simple;
	bh=Et/oTVgJWo4awpLq35NrlYecWjF5EECglAm6GPckmKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nw+txFYh5/ET6e0KrT6I2ji84699hSLCmKkTUVJkXy67O+FkrbbOwEWTbn+hC5bvLsAUIxPT3KjzA0Zuux8y3IkUevOSO3pKSNGSQPDEI4o8+rGuuIVg5MMAEE5MkWxTVF8bEFixAcxx2K/iq7SY9xAl43pkO8ID+Guo2tW1U1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merlins.org; spf=pass smtp.mailfrom=merlins.org; dkim=fail (0-bit key) header.d=merlins.org header.i=@merlins.org header.b=pW/bqJFd reason="key not found in DNS"; arc=none smtp.client-ip=209.81.13.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merlins.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=merlins.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=merlins.org
	; s=key; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=dAuMoMHeYiwf58fGAShoSCFQffGF8ZFdTj0ldghk5EI=; b=pW/bqJFdCTSgmufenuzF/Tcf54
	D62Pjl59AliUJWKjSnnLj/HNW5V9YlygMtYF+cLpjxu1LyMR4T1lpP1ppSWOKnm+odl/04SSyUS6Y
	jgxBGJsaDR8f+gv2MsG8T5EQs1b7bDVIeOKgI2u9d1eApznb91YfeTySv1Sf91NwGrwfAPpAvZRDc
	OoV0dC4mTpnDymvYZZ3nUr3S/H3udS6sr0euVJjcIyDLO5fs03O2EncdeyPuNOcWjSUHpa9Ho9k8c
	bovBTRgpRxhn9+ESb+DlY3RFWIeJB2vw/dZpDEdZ4U4J52778bk+wzp/eaTk6X/B8qC91hHsGxtTf
	dE/fqNrw==;
Received: from c-24-4-65-180.hsd1.ca.comcast.net ([24.4.65.180]:52746 helo=sauron.svh.merlins.org)
	by mail1.merlins.org with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
	id 1tnylb-0005VD-69 by authid <merlins.org> with srv_auth_plain; Fri, 28 Feb 2025 05:10:01 -0800
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.96)
	(envelope-from <marc@merlins.org>)
	id 1to07t-000GPE-1o;
	Fri, 28 Feb 2025 05:10:01 -0800
Date: Fri, 28 Feb 2025 05:10:01 -0800
From: Marc MERLIN <marc@merlins.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs <linux-btrfs@vger.kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Chris Murphy <lists@colorremedies.com>,
	Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
	Roman Mamedov <rm@romanrm.net>, Su Yue <suy.fnst@cn.fujitsu.com>
Subject: Re: BTRFS error (device dm-4): failed to run delayed ref for logical
 350223581184 num_bytes 16384 type 176 action 1 ref_mod 1: -117 (kernel
 6.11.2)
Message-ID: <Z8G1qchALDSy7uTG@merlins.org>
References: <Z6TsUwR7tyKJrZ7w@merlins.org>
 <Z71yICVikAzKxisq@merlins.org>
 <018d16aa-24b2-43ae-826c-7f717e0d05ee@gmx.com>
 <Z71_TednCt9KzR45@merlins.org>
 <d973b4b7-0d98-4310-bb7e-50f87c374762@suse.com>
 <Z72LAZDq8IegQoua@merlins.org>
 <d7f97a38-43eb-48ea-9a21-b6a90e8c613f@gmx.com>
 <20250227141116.GZ11500@merlins.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227141116.GZ11500@merlins.org>
X-Sysadmin: BOFH
X-URL: http://marc.merlins.org/
X-SA-Exim-Connect-IP: 24.4.65.180
X-SA-Exim-Mail-From: marc@merlins.org

Since I was told it was a known and fixed bug (my apologies for not
knowing that), I upgraded from 6.11.2 to 6.13.5 and the bug seems fixed
now.

Thanks for all those who helped.

Marc
-- 
Marc
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08

