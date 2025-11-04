Return-Path: <linux-btrfs+bounces-18683-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF8CC32F17
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 21:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 292AA421C19
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 20:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025292F0C74;
	Tue,  4 Nov 2025 20:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="njyrOopW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E163D2ECD3A;
	Tue,  4 Nov 2025 20:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762288634; cv=none; b=F2MWyFDtTq2a/JUtck45Nx+zUU9FDpqth/L3q1+L6EVQkjpY8f1iE7fkY9Zjuc/qTKgFLLrrRMdlvXTEf5jOy4+mwe4dbIN/7xyGzD9AICL45SRJtT3R42QCyOhh5gzuGEzcR61p0LsfnBHOKjh27x8lp+bmv/v5140HwNQo0E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762288634; c=relaxed/simple;
	bh=Hd5WRC5q73BCc88/cX72o+WZOdt8iG1dF8beT1jc//4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NP6DjK2U3LW/goXtxDxn680g1Sbl4BSGNjc/GeCKJgyeMWm277y/QAfLnzvliOmziqeKljY7W8aemmMjodrTpW3ERLV6m9R0CiGMDz30m2Oqe1OJftg91r//O0GOXYCZWleXOeUEQO1pQ6GjmYp+8IOVkzknAXje6gNCj2Og/t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=njyrOopW; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4d1Kxr66nZznDrCk;
	Tue,  4 Nov 2025 20:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1762288622; x=1764880623; bh=Hd5WRC5q73BCc88/cX72o+WZ
	Odt8iG1dF8beT1jc//4=; b=njyrOopWTof8U96TrrWMp1a4Efg7XVUfLDtQYyzb
	aTMFdUJX01Eu6nU3f0ycgIQ5A43cI+9q+eSogfozr65UTP/B8IKkmDal9zYZTdTC
	xn5n1dVPMj/UYaFV9EZISUSEPAfoTT+J3gsGtepGxTdc4WtilYiIYItT4hOLRxX8
	fnvPSrkzoSDif2AUDTiKSs6bSzBN7uXecCLnD2g8pYeQcj5dI+dAT1gW/c4+0MaE
	DZKyAR+CreJGcVkEpKm3pa/Y2LHj3iVAtAXgTnfyF3hmbFZ/1h4jLlPD2glv3Eye
	oOFphoXnwW8KN42ignT3IE+q+Xa9zzo+tkZ8D3rkbzrpIQ==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 9hBJWyN-oUgM; Tue,  4 Nov 2025 20:37:02 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4d1KxY3VgNznDrCX;
	Tue,  4 Nov 2025 20:36:47 +0000 (UTC)
Message-ID: <46fb6d7e-e3c9-48fb-ab2e-f432df9f9c05@acm.org>
Date: Tue, 4 Nov 2025 12:36:46 -0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/15] block: introduce BLKREPORTZONESV2 ioctl
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org,
 David Sterba <dsterba@suse.com>
References: <20251104013147.913802-1-dlemoal@kernel.org>
 <20251104013147.913802-12-dlemoal@kernel.org>
 <0cb7eefb-4501-47e8-805f-6e8737ca6bb5@acm.org>
 <da7e8c3e-49fe-49bd-9642-3b0ae67a3503@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <da7e8c3e-49fe-49bd-9642-3b0ae67a3503@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/25 12:13 PM, Damien Le Moal wrote:
> As I said, I did. See the comments with the BLK_ZONE_COND_ACTIVE condition.
> If you think that is not enough, I can cross reference tht in the comment for
> BLKREPORTZONEV2.
The current documentation requires puzzling some pieces of information
together but this is probably sufficient.

Thanks,

Bart.

