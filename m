Return-Path: <linux-btrfs+bounces-14472-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FEEACE8C4
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 05:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC2DB1893377
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 03:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6C21F7060;
	Thu,  5 Jun 2025 03:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=edcint.co.nz header.i=@edcint.co.nz header.b="6/qr8wWG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from h1.out1.mxs.au (h1.out1.mxs.au [110.232.143.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBB61F30B2
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Jun 2025 03:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=110.232.143.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749095562; cv=none; b=DiNlCddHCsUb/9Pr8ci+RM/atTuga0dROlIrN1fovKgcsX0SZp52DrMQM1kyNDTPpFPf9UVnqH02Kq/LUmk+LDPW798Yl+6Io6uMzeXdzqb5SaVYTjiO7Yl6eymgHx4w94XtaNtSazZJbWdTmn0uzkcN8vJpbiOeGC04lSP5DuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749095562; c=relaxed/simple;
	bh=G72DxP2kmkh4jBt00oq6o2sAW5+3uc5f+1iFKAjfvIo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ThmAH7NV+sDALvukOx4uDJaQODf2fWtSHdzLtsbWK/iLxQdv7KefUpklZhSNbcEpu5PecOKxSljssQAIB7BBJT5YEQcSsWXs+e/j1MyRObmgKHJuIXm6beaQMPL/UjULTlMcYKjHRI8d9Bl7uyS0oEFHOALHOeRpThkt54TnW44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edcint.co.nz; spf=fail smtp.mailfrom=edcint.co.nz; dkim=pass (2048-bit key) header.d=edcint.co.nz header.i=@edcint.co.nz header.b=6/qr8wWG; arc=none smtp.client-ip=110.232.143.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edcint.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=edcint.co.nz
Received: from s02bd.syd2.hostingplatform.net.au (s02bd.syd2.hostingplatform.net.au [103.27.32.42])
	by out1.mxs.au (Halon) with ESMTPS (TLSv1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	id 694178ee-41c0-11f0-ad0b-00163c39b365
	for <linux-btrfs@vger.kernel.org>;
	Thu, 05 Jun 2025 13:51:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=edcint.co.nz; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=U0bazPuEbr1lxpcYtBCjjpECHmAtCNri1M2P995zERU=; b=6/qr8wWGYBPiX2OucJjh5wpb6g
	h1G9v74CVpeS8aFgyZF74/io+Cx1XZIjUEyvn2fbc56esMrTsZVd3pu0Erb6eLFspK9Co5kZsmc2I
	9anrTuKCydtyKNNQDHkYS3oehpXn/cd7xT9CvotBLQdJDHXd99DgEgUBPWaI3iy0mcYODJ8YXWGOQ
	dk7v1GrfAc4uGUNnqF7VxdEHu8gzYfbVkzllkpBYsjabrvb5gQmbO9fz2J0Ns8meUmmY5FyHrSwj0
	bu1zssryf99DDuqBcNCIWWKyGEWd5Vjr3VVNTxwXAiBvbOfyP9dntP6Wl2Vg4Y5rYEE2EUWwqF69h
	HRMw32qQ==;
Received: from [159.196.20.165] (port=57861 helo=[192.168.2.80])
	by s02bd.syd2.hostingplatform.net.au with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <btrfs@edcint.co.nz>)
	id 1uN1eV-00000002t7A-47gK;
	Thu, 05 Jun 2025 13:52:28 +1000
Message-ID: <bdfe67ea-8668-4768-8102-42d78e9537f9@edcint.co.nz>
Date: Thu, 5 Jun 2025 13:52:27 +1000
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Portable HDD Keeps Going Read Only
From: Matthew Jurgens <btrfs@edcint.co.nz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Daniel Vacek <neelx@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <83a43be7-7058-4099-80d9-07749cf77a8d@edcint.co.nz>
 <CAPjX3FcqJ-cNMjVia_gYmBZwDhQVxPEOhYYQUzL31m7momByEQ@mail.gmail.com>
 <5de3840d-70c5-48cb-a7c0-7db17e789e95@edcint.co.nz>
 <ffbd0c96-313d-4524-9b6e-b24437fc0347@gmx.com>
 <b2dbfdb5-4cce-459c-8d30-01ac6124d9ad@edcint.co.nz>
Content-Language: en-US
In-Reply-To: <b2dbfdb5-4cce-459c-8d30-01ac6124d9ad@edcint.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s02bd.syd2.hostingplatform.net.au
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - edcint.co.nz
X-Get-Message-Sender-Via: s02bd.syd2.hostingplatform.net.au: authenticated_id: default@edcint.co.nz
X-Authenticated-Sender: s02bd.syd2.hostingplatform.net.au: default@edcint.co.nz
X-Source: 
X-Source-Args: 
X-Source-Dir: 

> 2 more rounds of mem test passed
>
> Output of "btrfs check --mode=lowmem" below
>
> Let me know if this is worth pursuing (for the sake or btrfs) or if I 
> should be recreate it
>
And another 2 mem tests passed as well.

If there is nothing here that might help the btrfs team then I will 
rebuild the drive.

Please let me know if you want any more info before I rebuild the drive.

Thanks


