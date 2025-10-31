Return-Path: <linux-btrfs+bounces-18470-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E399AC26812
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 18:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F06723AC769
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 17:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96F8350286;
	Fri, 31 Oct 2025 17:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="rT28JTWZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295BC2D9EEA;
	Fri, 31 Oct 2025 17:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761933371; cv=none; b=Cd7p5OHeiKzxAstJB3tfVyY0gJkz2NRRCE/Z1MjvhMrg0fFpK3CRtOXJUuI/u2PliS4q/fEN/F6xifPxfAINdaKMjI4hYlHMC1OvDOEDp1n068GsHajifEivKSNqDzS8ND9V74kPU+ApDrXbhnI3cf1lt4dUFYU7UMbP7HzPHKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761933371; c=relaxed/simple;
	bh=H2gJ+R3dxcg9oaIm0n3G+xeqBE2dv2VwFRsTo9tGfA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=R8TBShBqrMJJepwewuHrJdUKld4/j24Q642nrRI1wWfN4j2xVSDT/szTLlu/Gk8wswUMoHExPfDux3uXjjotrXg9Re1EuNhggWRHccZeFDoIhuIpBBwr8qg9lVoljg5hqlf0EZNN7nxEUf7ivnUvLrC2JEuqcYXNLZuzU0UyqsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=rT28JTWZ; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4cypYz73RCzm0pK5;
	Fri, 31 Oct 2025 17:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1761933365; x=1764525366; bh=H2gJ+R3dxcg9oaIm0n3G+xeq
	BE2dv2VwFRsTo9tGfA0=; b=rT28JTWZ99TOZeuVLHnbuiww9kMqasyX8PYMeefR
	E7vPo6R6ZeeCK8Hh09MEp3ihMVqImaZndPHWHNjBXjNngQGj9NtRCNCqsnkpFMV1
	44b/RaTaB+4ASNlTp4uk3aMu2Bg+1DaAtkJ0aRIircAlyJg3JN/+AY0x2Fe9k05w
	PFTir7Cf5L0v2ZMEtVG951wdbJAtWuxhxVSiGYNROtEnb8pkNpjs2xTYi8gaT0ed
	HCvdoynO8W0ZnaacVvmv1FRJTH/Pqdr2j1QdPvwDP7DalxFIabiX0ZAaUaqlxNxs
	Tndh5RtstAX7aOxdVPNIZXmE8ZSXCQcwGWic2k/4IU11Gg==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id PfNpY8yMIsmy; Fri, 31 Oct 2025 17:56:05 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4cypYj0bQZzm0ytR;
	Fri, 31 Oct 2025 17:55:51 +0000 (UTC)
Message-ID: <a25bfd8a-42d0-4f5e-8478-892d8c9c0127@acm.org>
Date: Fri, 31 Oct 2025 10:55:50 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] block: cleanup blkdev_report_zones()
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org,
 David Sterba <dsterba@suse.com>
References: <20251031061307.185513-1-dlemoal@kernel.org>
 <20251031061307.185513-3-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251031061307.185513-3-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/25 11:12 PM, Damien Le Moal wrote:
> The variable capacity is used only in one place and so can be removed
> and get_capacity(disk) used directly instead.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

