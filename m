Return-Path: <linux-btrfs+bounces-18679-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFC2C32B97
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 20:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E87FC4EE2BE
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 19:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDF433F389;
	Tue,  4 Nov 2025 19:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="jl2qi6oN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BC42ED84C;
	Tue,  4 Nov 2025 19:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762282850; cv=none; b=GgU0BSs8FMbFfn6/k9bS3HqP7gC8bCa6lT2h6dXLtGb14kSWYcxlRQnV2wClZxTwDO0o753C+QigAHcQtZdzddcg6VpEbEkB5yCdq4kyc+gnSqN6+W620+GDduTKQHk1giGrfjLUJN2qSeboYDvCoP/3qTHt6HkYQvD3KEZ68yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762282850; c=relaxed/simple;
	bh=rZcGwmQLcueA+pKrWGVQC0oWEavs3MSHLzu7gfG36V4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uvTAPLnfTbfD0Sg+Bku7/Rg0pAX5uwPBJFUVcNQG7PvtnT3vvUq5HuAWrPF1DlCMDr3IN3hOfF/wxpZmVpRBQwJrRy2++jSaNCh+eNvCr52HI67SdyhVTbRwlW7vJ4hlMXr2JCElc6lSfcrCb2PQijzW1IchwYSheuBiiltALbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=jl2qi6oN; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4d1Hpj6RDkzly6Vc;
	Tue,  4 Nov 2025 19:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1762282843; x=1764874844; bh=EJw2W4R20I0tbP9KTHA+4Oke
	v2/0KvJztiMzbhvTnNI=; b=jl2qi6oNwA87r19QHd4bFtJjfr4Oj17sQMNvOQf/
	RhOyR0SYK/HZoqEHVr9wvC/wNUZ3OYoCrVChC4LCEm/umbw4ZKaTl9H/tD5hri+E
	RlAdb2J8XEwP1U0KfDJoEcaVcD/A+sz2aqCeTn9JTtAjcg/8g+4jF8RRypVPznDX
	jl4/eWdb4dezQf8mmXcSrYLMApLTdv3zGENS3zLDzjqhZJ3cKV52htqveEmWNzO9
	v91zGwYfZ8mghDT7lwawv60A62wi4zFveUDXWitoN2PpznE5/ZRkMXWZJMTfjdTm
	dCSfhuXAjpLY1bM8A4OlD3rq+gzjuRimgNpHBF6bsgJ4Qg==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ktQnhIQwp04c; Tue,  4 Nov 2025 19:00:43 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4d1HpQ08l3zm0XTn;
	Tue,  4 Nov 2025 19:00:28 +0000 (UTC)
Message-ID: <0cb7eefb-4501-47e8-805f-6e8737ca6bb5@acm.org>
Date: Tue, 4 Nov 2025 11:00:27 -0800
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
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251104013147.913802-12-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/3/25 5:31 PM, Damien Le Moal wrote:
> - * @BLKREPORTZONE: Get zone information. Takes a zone report as argument.
> - *                 The zone report will start from the zone containing the
> - *                 sector specified in the report request structure.
> + * @BLKREPORTZONE: Get zone information from a zoned device. Takes a zone report
> + *		   as argument. The zone report will start from the zone
> + *		   containing the sector specified in struct blk_zone_report.
> + *		   The flags field of struct blk_zone_report is used as an
> + *		   output only and ignored as an input.
> + *		   DEPRECATED, use BLKREPORTZONEV2 instead.
> + * @BLKREPORTZONEV2: Same as @BLKREPORTZONE but uses the flags field of
> + *		     struct blk_zone_report as an input, allowing to get a zone
> + *		     report using cached zone information if BLK_ZONE_REP_CACHED
> + *		     is set.

Was it promised to add information in the above comment about the 
differences in accuracy between the two ioctls? See also
https://lore.kernel.org/linux-block/97535dde-5902-4f2f-951c-3470d26158da@kernel.org/

Thanks,

Bart.

