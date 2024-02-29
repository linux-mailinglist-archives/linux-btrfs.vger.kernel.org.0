Return-Path: <linux-btrfs+bounces-2900-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 178CC86BF5C
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 04:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B11C11F246CB
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 03:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEB936B1D;
	Thu, 29 Feb 2024 03:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=merlins.org header.i=@merlins.org header.b="CdM926yp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6502032C
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 03:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.81.13.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709176560; cv=none; b=BRbR5TVVWYlcGHDEqI418MQl7KKM4gfCpHIaAfG1YUc1A9c6+8LgqOTKUxwB/OExl+dReOOEaFXjRcwXkSU7IwZmWz0c97u0gyoie7uj3lRO+wf/6RflygPe1pY5KYOUADYUIQsGypR+5TsKXI2ynNLJXrVZ8mEOppngxmVF7+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709176560; c=relaxed/simple;
	bh=SzxKIYm27BGE/ltKxaZFAIlpiKsegENsFSFd7Tew0Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVkhGaQu4Fuv+vY/uysFPN135sYVJ0StnIm+12oN4k719XBFL2njsb46e6KUAiXTqd7mOFtUy+AjZRRud3c7wWTQ+TAGb+/z3ntPj+lEX9lW5i3iqRYt9Dxxw9psJJqTMvHTw0CW9yuhAmDdOUX+Cv2ZnC3WeZRm0FmGnBgGdPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merlins.org; spf=pass smtp.mailfrom=merlins.org; dkim=fail (0-bit key) header.d=merlins.org header.i=@merlins.org header.b=CdM926yp reason="key not found in DNS"; arc=none smtp.client-ip=209.81.13.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merlins.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=merlins.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=merlins.org
	; s=key; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=xDCOWMd5uF+yph06PYVr/iKgdJrdqmjjAMSY6jBpnwo=; b=CdM926yp7PLfKXrhfwlAbCJiAf
	rJLtFj5eTYSb3/s9vOQSu8tDn3tyIaxVjAqEqyuIRTpJrt3hJJVNr3X2lLmIP0pri65kGTAFDDzRm
	ljhy3H4kjcUL16TgSVhRJqq7LYFRxqZa3QmvHAPT475WEcLOV1bF0fMxS1BfmDFvtYzoovflgGOP7
	jEBxICd9LBwj8eQYL0cuyEUj8ZnCvDuRLaPVtJ3laIcFs5vVBrtokMSW34UcboDTugxs453mjfQvt
	LPwH2P7NZr6qJC2wS9znzZvChmcScWuBheYZg8Yeej+5QmyVYEQYBG76/hKgBUI/Qy2sSlh6edbhg
	9AcWiE3A==;
Received: from [205.220.129.25] (port=13030 helo=merlin.svh.merlins.org)
	by mail1.merlins.org with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
	id 1rfWtp-00082R-Gm by authid <merlins.org> with srv_auth_plain; Wed, 28 Feb 2024 19:15:57 -0800
Received: from merlin by merlin.svh.merlins.org with local (Exim 4.96)
	(envelope-from <marc@merlins.org>)
	id 1rfWth-0069ge-2h;
	Wed, 28 Feb 2024 19:15:49 -0800
Date: Wed, 28 Feb 2024 19:15:49 -0800
From: Marc MERLIN <marc@merlins.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: 6.4 and 6.9 btrfs blocked and btrfs_work_helper workqueue
 lockup, is it an IO bug/hang though?
Message-ID: <Zd_25ZJIY4aWZErO@merlins.org>
References: <ZdL0BJjuyhtS8vn1@merlins.org>
 <Zd5s1k8bFguE2NVl@merlins.org>
 <2020a7b4-b052-4144-8386-b05102a5465d@gmx.com>
 <671192d3-1331-480b-b00a-af3eaf794089@gmx.com>
 <Zd_gvRXHIjtvN06N@merlins.org>
 <34db6285-deb1-4b4a-b4d9-106646c0f894@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34db6285-deb1-4b4a-b4d9-106646c0f894@gmx.com>
X-Sysadmin: BOFH
X-URL: http://marc.merlins.org/
X-SA-Exim-Connect-IP: 205.220.129.25
X-SA-Exim-Mail-From: marc@merlins.org

On Thu, Feb 29, 2024 at 12:31:19PM +1030, Qu Wenruo wrote:
> Not an expert on the block drivers, but a lot of btrfs works relies on
> the endio function (either a successful end, or an error) to unlock
> various structures.
> 
> If the driver didn't properly end the bio when something went wrong, it
> would definitely cause a hang.
 
makes sense.
 
> Another question is, are both kernels running on the same machine?

yes
 
> In that case, is the same aacraid driver used on v6.9? As the newer
> kernel shows hangs on mdraid too, which is now shown in the older kernel.

right, I noticed that difference, I'll see if I can dig that out.

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08

