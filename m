Return-Path: <linux-btrfs+bounces-15286-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 304D4AFB20B
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jul 2025 13:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF2CB3BB95B
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jul 2025 11:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8A1296158;
	Mon,  7 Jul 2025 11:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b="p3NejVlw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.ptr1337.dev (mail.ptr1337.dev [202.61.224.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A20291C0D
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Jul 2025 11:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.224.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751886730; cv=none; b=rUZzk/Ytbk31H+d/OWTKlaUdhp/5yz3PEZMTSted4I9+Th47/qC0p5Z2wzjIgwFUx/rsXIVKHRNbxFX38Cosc1hqiu1OHEiX007s2YFctzqWfOjL3NVP7aRgjhzaJTiaqiX93trt/0QCzoHXJSwv6l+l7GHUKcRNxuX5KFh+F5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751886730; c=relaxed/simple;
	bh=AbP/hOehi67fR9135Rh8yvWSriUlopRfcsdfL/StuXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gn8oJkLOMC6AcOXr7YnDt96TCIWnJOQzPfThs+Qs8GF0fY07FbbTAwvXA/yRpF6qa+NwVDzicQBGyM3ndFKHqFnJbeXVINSxoHNus1zKsmeWzJ/Kpu8292Ihx1ltBsmpbZb3AmdJaa5L/6JhCBVwI1AJnv2AwmS+5LwbijsWpQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org; spf=pass smtp.mailfrom=cachyos.org; dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b=p3NejVlw; arc=none smtp.client-ip=202.61.224.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cachyos.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1CBA728399D;
	Mon,  7 Jul 2025 13:12:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cachyos.org; s=dkim;
	t=1751886726; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=VOPSD8aKiDMH5DoQ1Cx7B2rEhQ13/6fVEdUP84qlC9U=;
	b=p3NejVlwWjRC2WsMszGlxQ6tyHFS6yrlgHMdnskOIxksp+Pt/33DV8TnibrynKjTNSX8OK
	1TPfUjZXdYCP2+vfgnnba5kChoeWPbt62vtNNWJLyhxXIDcB3wjTpviJR3Jbb1fn1UTKs7
	jNGSZazigdyGX1sZrCDGlcXTOXjAv5ML0+KOXRCJV7zLZRFlL1+qgMbKcr484oTtpuHVES
	zdlcOUa9hDZYmD64QAi8ZS5MXepmkUyjrcBUNcA/WGiIzv1y252/S2pQq4fEqp8vzPqvYa
	CprgS75TJDtid+h3NACWupnMEpX8MVI5+w3Bbop/vnX2Xm9zkcv/KwXgiIY2Ww==
Message-ID: <f6d53293-3d55-4ccd-a213-c877dc22935a@cachyos.org>
Date: Mon, 7 Jul 2025 13:12:05 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Increased reports since 6.15.3 of corruption within the log tree
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
 dave@jikos.cz, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: dnaim@cachyos.org
References: <fce139db-4458-4788-bb97-c29acf6cb1df@cachyos.org>
 <a6f03aff-c9fc-4e7f-b1fb-42d6a4cd770a@gmx.com>
Content-Language: en-US
From: Peter Jung <ptr1337@cachyos.org>
Organization: CachyOS
In-Reply-To: <a6f03aff-c9fc-4e7f-b1fb-42d6a4cd770a@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 7/7/25 13:00, Qu Wenruo wrote:
> Unfortunately none of those comment is helpful.
> 
> They do not provide the dmesg of the mount failure, and that's the most 
> important info.
> 
> If you got any new reports, please ask for the dmesg of inside the 
> emergency shell.
> 
> Thanks,
> Qu

Thanks for your answer - but how it would work saving the logs in the 
emergency shell, specially if the root partitions can not be mounted?

Best,

Peter

