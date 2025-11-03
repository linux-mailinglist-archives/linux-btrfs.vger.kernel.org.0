Return-Path: <linux-btrfs+bounces-18532-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70015C2A2D1
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 07:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78679188EA51
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 06:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B28296BAA;
	Mon,  3 Nov 2025 06:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZBX8osr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F2628DEE9;
	Mon,  3 Nov 2025 06:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762151118; cv=none; b=WXAGLj6IBoPZiD8kLrDuV1b8qImx1HzfQ0d8SI31FR6oNf5HIdlM1xTQlIDXd5iMzsI0RFdKL1j0G/uWBoHBOP3ZnKutYFi2abN/7IGVXvgzoYcqd0Srs96Jg010eKCQHxd5O32xzvGsSkE5xeSfsaOrth0V/k6TLn0fR2gBdy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762151118; c=relaxed/simple;
	bh=8RRYCj8CkNNVJtCtEV8tgKWWs6L1hqdJYHMXRsKV0HE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FdST+VzykVidOS5BnvDe42Vz7U6EZi3IRmuPIqr7lxFYfu9Ii2/svHF3uH1VSwblltKLAPHrIwhc2+trCEFZwrihn+o3vhomwb8Q+9AZWaucTXss+tV+kny8G3rqCe6z7M2zs5rzgZ3w1FdumsBQKNBnUX8FyPHXK9sAVWsqy7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZBX8osr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1936C4CEE7;
	Mon,  3 Nov 2025 06:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762151118;
	bh=8RRYCj8CkNNVJtCtEV8tgKWWs6L1hqdJYHMXRsKV0HE=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=DZBX8osrTJxAdKvH+wcT21X1A5eMxob7PQblVQFuuJnZ4Q3S6WX1qXKmx0AaZYZvh
	 JOwIIu8TR4npxQdqUWfRSYGmHTkDOkZa6wCtyQ8EwNbpy+QgGHLJiTsN1Os8GKg8OA
	 +X0RS081onCc4np1J7Aku2I1rn+GAcpKm4Reito5X6tuWj8l+1/SKCnfayxnx/P0+H
	 UdAtdvB9/D7YdecaNcmuXbOuPGIiKQklT0c39ncHFKhbk/lNhU2y61RcsNKf6sU25k
	 HNfYL3y2egZrUdCw3rsikpcqESgZcc3VjW/T4EcidU34xgLHIvlp+YH51TTwYA5dso
	 FJvILdZJBWGWg==
Message-ID: <22af84c8-c670-4022-9b71-4451889e9986@kernel.org>
Date: Mon, 3 Nov 2025 15:25:14 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] block: handle zone management operations
 completions
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
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
 <1aebb8a7-ac7d-4e53-bbf3-034f520d58fc@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <1aebb8a7-ac7d-4e53-bbf3-034f520d58fc@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/1/25 03:01, Bart Van Assche wrote:
> On 10/30/25 11:12 PM, Damien Le Moal wrote:
>> +void blk_zone_mgmt_bio_endio(struct bio *bio)
>> +{
>> +	/* If the BIO failed, we have nothing to do. */
>> +	if (bio->bi_status != BLK_STS_OK)
>> +		return;
>> +
>> +	switch (bio_op(bio)) {
>> +	case REQ_OP_ZONE_RESET:
>> +		blk_zone_reset_bio_endio(bio);
>> +		return;
>> +	case REQ_OP_ZONE_RESET_ALL:
>> +		blk_zone_reset_all_bio_endio(bio);
>> +		return;
>> +	case REQ_OP_ZONE_FINISH:
>> +		blk_zone_finish_bio_endio(bio);
>> +		return;
>> +	default:
>> +		return;
>> +	}
>>   }
> 
> "default: return;" is superfluous and can be left out.

No, it is needed. Otherwise, with GCC 15.2.1, I get:

block/blk-zoned.c: In function ‘blk_zone_mgmt_bio_endio’:
block/blk-zoned.c:778:9: error: enumeration value ‘REQ_OP_READ’ not handled in
switch [-Werror=switch]
  778 |         switch (bio_op(bio)) {
      |         ^~~~~~
block/blk-zoned.c:778:9: error: enumeration value ‘REQ_OP_WRITE’ not handled in
switch [-Werror=switch]
block/blk-zoned.c:778:9: error: enumeration value ‘REQ_OP_FLUSH’ not handled in
switch [-Werror=switch]
block/blk-zoned.c:778:9: error: enumeration value ‘REQ_OP_DISCARD’ not handled
in switch [-Werror=switch]
block/blk-zoned.c:778:9: error: enumeration value ‘REQ_OP_SECURE_ERASE’ not
handled in switch [-Werror=switch]
block/blk-zoned.c:778:9: error: enumeration value ‘REQ_OP_ZONE_APPEND’ not
handled in switch [-Werror=switch]
block/blk-zoned.c:778:9: error: enumeration value ‘REQ_OP_WRITE_ZEROES’ not
handled in switch [-Werror=switch]
block/blk-zoned.c:778:9: error: enumeration value ‘REQ_OP_ZONE_OPEN’ not handled
in switch [-Werror=switch]
block/blk-zoned.c:778:9: error: enumeration value ‘REQ_OP_ZONE_CLOSE’ not
handled in switch [-Werror=switch]
block/blk-zoned.c:778:9: error: enumeration value ‘REQ_OP_DRV_IN’ not handled in
switch [-Werror=switch]
block/blk-zoned.c:778:9: error: enumeration value ‘REQ_OP_DRV_OUT’ not handled
in switch [-Werror=switch]
block/blk-zoned.c:778:9: error: enumeration value ‘REQ_OP_LAST’ not handled in
switch [-Werror=switch]


-- 
Damien Le Moal
Western Digital Research

