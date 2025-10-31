Return-Path: <linux-btrfs+bounces-18471-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B8CC26842
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 19:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A7C63BDB92
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 18:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DE0350D41;
	Fri, 31 Oct 2025 18:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ZpkeXcrD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B28E350A18;
	Fri, 31 Oct 2025 18:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761933701; cv=none; b=Y+TTlDFf8EbUblpjOm4Ue+F1qHYrZ3yRKO6b8pTHOzdhmtWqlrLhu8aF/fpZ1ZvATOh4WNdSmVjX0xHok0AISutN3iv85KHqBqrUhkUrU82xytCOk5xCrHBGOSVNak1KYjCtL68WR5DL9nm+y6GPoqp9obdNL2doXns7sFh3WM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761933701; c=relaxed/simple;
	bh=aAZA/H+5qMIBobA687uAhayRarX7PdSqbG8w4MkhEHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=N3Vu/Z+oHvsIebD4TJvLaytJ/gxAtlBfF/3Z5xCa5VKsX0EagNmzObw/DdcD5Wq+0Tl8FeNYR/1DYlKxewfs8Dc0+PL4G1WsvbyC5OoeibuJet1VhfuUDe9FgmNw3XObQ0OP1t/FjBXDlwc7GauWWieyhWWCRfRwDB6kj4+GeNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ZpkeXcrD; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4cyphM1QDqzm0jvf;
	Fri, 31 Oct 2025 18:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1761933696; x=1764525697; bh=ZmrQaMmDI5wcpJi1s03VwcCd
	yCNYupSnLPNCN3FbIsk=; b=ZpkeXcrDhmruIHjt5YlLICRvVsSzhvWioovxYNsN
	MWURrST80Y+7j2o80I6hpScVrP5jfkp4j6Dafb7SUYnSikS0bOVYE3bugmaSnoAj
	Xbkhjf9GVDMTCZI1TVAdaCX5zPAwMCRRDHHTpbl5YfZfLW3lYL7LueM3+6p88jOf
	2WkEqaQaagZdba8uI8ptEKmyIuImsFLD7I0GKMUmsqm8dkSVKUQPVmJ9klFMOFBo
	dx2qiYqEn99ky8+CFL3a7b2g2OfEZM6l28PdEYkxy4vHIIHQ8Fc4yKoekLmvpOjA
	qQBKOOkRkaiiEid3Wr2AlxCPdrvYY2c6ob6qJcl0q4C7EQ==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id nP_AMHoCVvSg; Fri, 31 Oct 2025 18:01:36 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4cypgz4d4qzm0pKK;
	Fri, 31 Oct 2025 18:01:18 +0000 (UTC)
Message-ID: <1aebb8a7-ac7d-4e53-bbf3-034f520d58fc@acm.org>
Date: Fri, 31 Oct 2025 11:01:17 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] block: handle zone management operations
 completions
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
 <20251031061307.185513-4-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251031061307.185513-4-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/25 11:12 PM, Damien Le Moal wrote:
> +void blk_zone_mgmt_bio_endio(struct bio *bio)
> +{
> +	/* If the BIO failed, we have nothing to do. */
> +	if (bio->bi_status != BLK_STS_OK)
> +		return;
> +
> +	switch (bio_op(bio)) {
> +	case REQ_OP_ZONE_RESET:
> +		blk_zone_reset_bio_endio(bio);
> +		return;
> +	case REQ_OP_ZONE_RESET_ALL:
> +		blk_zone_reset_all_bio_endio(bio);
> +		return;
> +	case REQ_OP_ZONE_FINISH:
> +		blk_zone_finish_bio_endio(bio);
> +		return;
> +	default:
> +		return;
> +	}
>   }

"default: return;" is superfluous and can be left out.

> +	/*
> +	 * Zone mamnagement BIOs may impact zone write plugs (e.g. a zone reset

mamnagement -> management

Otherwise this patch looks good to me.

Thanks,

Bart.

