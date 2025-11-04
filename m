Return-Path: <linux-btrfs+bounces-18605-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED97C2EAF4
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 02:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AB4B3B53C1
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 01:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C66217F24;
	Tue,  4 Nov 2025 01:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="HMzBYxa3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1CA15539A;
	Tue,  4 Nov 2025 01:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762218118; cv=none; b=a9/o7Gzdge3YBUsUYB8HDJPvowqX2yv/vlEsFkHYsTLOn/O9nIQxbLx6NPer5CqJxKOB+Xxg+Sunysg7KpQaOCQhU1iUJpTYa0sEm8z1DvLqRachwbu0RltJNUQW9F66tre30JIRpyyIkL97C2m+2cBk0qVLeEe5HSdiJcDnEnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762218118; c=relaxed/simple;
	bh=4uVN2m2Fn19Sh1MsTnyiUqWKIDdvRLIGGU21jVU8o9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=p8Y8NBoQMTdJGebV2TANSHAjcV3NaU3cS23Pm1s0g3wQArg6wR6xt2zRINsMqWoS7hD8EN67F5E05pJ77pvUMT5Wg5qwezp/Z5RRtQ50Lv00e9TIvrrk8mJ7HijQjgKMNvVLnBICbPexNL7sGr/JJljbwLMHRNBlDjqbBmAtUHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=HMzBYxa3; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4d0qsv6HQMzmGHJp;
	Tue,  4 Nov 2025 01:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1762218113; x=1764810114; bh=4uVN2m2Fn19Sh1MsTnyiUqWK
	IDdvRLIGGU21jVU8o9o=; b=HMzBYxa34839lAyty5SHRbqUdyMIghBmpSKVLfM/
	I4wQqOIVRHnpeleTXG1JgkCOxFSIo8nIIZEW0hdEfxSxb+uHvlOOC9XSK7laTfCU
	aJ/nLII/IXn0QTJONfXOSCBMS+LxaW+V3UE4FtvqPuTgYSiMUGLbVTDcAQcrbnIO
	KJa+h1k/6M7lBGlhccXt8+3AAoySkoSzq5mhOFSqTGIv0mpIhA5MvTX5Dqg/ZopS
	Gw5MFLa5QjH1rM31nYz/XbaqaPkem4hCsEF0aD1JIT/XTYf2xTtPVuh/Ju7POLoC
	9BnTbiDle6s878qpxR44hnb6UWHD8QZALmWCNDnrjSdGLA==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id XBhzvaiVaNxT; Tue,  4 Nov 2025 01:01:53 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4d0qsQ17HHzlyNp4;
	Tue,  4 Nov 2025 01:01:26 +0000 (UTC)
Message-ID: <a6d95da9-afdc-4885-bcc7-246d6d133ba7@acm.org>
Date: Mon, 3 Nov 2025 17:01:25 -0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/15] block: introduce BLKREPORTZONESV2 ioctl
To: Damien Le Moal <dlemoal@kernel.org>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Jens Axboe
 <axboe@kernel.dk>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <keith.busch@wdc.com>, hch <hch@lst.de>,
 "dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 Carlos Maiolino <cem@kernel.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 David Sterba <dsterba@suse.com>
References: <20251103133123.645038-1-dlemoal@kernel.org>
 <20251103133123.645038-12-dlemoal@kernel.org>
 <982ed7d8-e818-4d9c-a734-64ab8b21a7e3@wdc.com>
 <0154c2a8-a3ed-45d3-8f8a-1581106212fb@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <0154c2a8-a3ed-45d3-8f8a-1581106212fb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/3/25 4:15 PM, Damien Le Moal wrote:
> The old one is needed to allow getting the precise imp open, exp open, closed
> conditions, if the user cares about these. E.g. Zonefs does because of the
> (optional) explicit zone open done on file open.

How about adding the above information in include/uapi/linux/blkzoned.h?

Thanks,

Bart.

