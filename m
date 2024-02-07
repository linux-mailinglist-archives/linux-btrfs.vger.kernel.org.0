Return-Path: <linux-btrfs+bounces-2219-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0532F84D47D
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 22:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34B981C2169A
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 21:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B70E134738;
	Wed,  7 Feb 2024 21:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=merlins.org header.i=@merlins.org header.b="bdsPqvzu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCE0154BEA
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Feb 2024 21:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.81.13.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341104; cv=none; b=B4FwYq1ZZSIqwHRpDqvUhOL7ilyGZM1imDns7V8dbumRHU3XGuV4o9a1c1/j1IESQtea+vcR426fX+SyXNJ8gDBfEYFxmb+kv81bALM/KMKq/2u8PU+cBwM/BKDFyzawudV9/du146XmZirKENFiwfGc+fTuJhDHdhdm4UStzYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341104; c=relaxed/simple;
	bh=4ql4H2Nx1st4WJdShd+l1wS5Xh/s+pXrsoD3ENRXddg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ikX7mZQIg2A8+EPISKWz98U0sD7E0I1LVy/x6oQjR5YAmZcbVF8qayLMIFhP9EdjsoRytwKJ7N3K43pVrrdIkXwzKJ8hfY9HX3weNgAnUMiXBBbuulpbFNga33bQmb6I2EnqsW2lpNy+li1oKTsitqZwpvIMRRu3yPunsAR5foA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merlins.org; spf=pass smtp.mailfrom=merlins.org; dkim=fail (0-bit key) header.d=merlins.org header.i=@merlins.org header.b=bdsPqvzu reason="key not found in DNS"; arc=none smtp.client-ip=209.81.13.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merlins.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=merlins.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=merlins.org
	; s=key; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=g2sIoHJLHpR3soQbmaGBejsfWLOIGKmCHAKlx45LgYA=; b=bdsPqvzubC74e/cfhI/WScXwT6
	m01Rd721bf9rNirbKA7RYmkWloPadbJmHhpKJHrWyHjXzzQbZi0eDn+U0YDz3DELNC6X9MOza60Jz
	kv+gOfhknFPY9miBpqtMcoGe16iELOhQJFwbcNSoGD0jpRFr3cSHDPdzjEuf2HUnm4ILws5jIpUSY
	IW2hF41P7bdHOepcM/clpBeBgivDhYx84o+m5FzACA8isX7/NdtyQmEp4pNZop8526oboYQvRFnSr
	74peIhylJyd2Tz8eZkkuyevjsqEGQopxEkQKXIY3NRft2ZtlVPw41+Cx8NjdJBps9ZCve74jd46sn
	d6qDC5TA==;
Received: from c-76-132-34-178.hsd1.ca.comcast.net ([76.132.34.178]:47486 helo=sauron.svh.merlins.org)
	by mail1.merlins.org with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
	id 1rXpPd-0007k3-5a by authid <merlins.org> with srv_auth_plain; Wed, 07 Feb 2024 13:24:57 -0800
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.96)
	(envelope-from <marc@merlins.org>)
	id 1rXpPj-001yzu-0M;
	Wed, 07 Feb 2024 13:25:03 -0800
Date: Wed, 7 Feb 2024 13:25:03 -0800
From: Marc MERLIN <marc@merlins.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: How to delete/rewrite a corrupted file in a read only snapshot?
Message-ID: <ZcP1L5SUXNrB_sp_@merlins.org>
References: <ZcKEoftmxxp3SOiB@merlins.org>
 <07bc2e91-0106-48ab-b07d-f54b75e9a991@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07bc2e91-0106-48ab-b07d-f54b75e9a991@gmx.com>
X-Sysadmin: BOFH
X-URL: http://marc.merlins.org/
X-SA-Exim-Connect-IP: 76.132.34.178
X-SA-Exim-Mail-From: marc@merlins.org

On Wed, Feb 07, 2024 at 03:37:04PM +1030, Qu Wenruo wrote:
> > can I either
> > 1) force delete it with some admin tool
> 
> That would break any later incremental receive.
> 
> > 2) even better force/overwrite it with the correct file from source?
> 
> That's possible manually.

If I change the snapshot to readwrite, and cat the good file into the
corrupted one 
cat good > /path/to/bad
will that work, or will that allocate new COW blocks and do weird things
that would break later brfs send/receive?

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08

