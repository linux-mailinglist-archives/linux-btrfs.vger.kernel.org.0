Return-Path: <linux-btrfs+bounces-18527-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7D0C2A1C9
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 06:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1657C3A1549
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 05:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC3F28E571;
	Mon,  3 Nov 2025 05:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D82YnSuw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AAE285CAE;
	Mon,  3 Nov 2025 05:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762149405; cv=none; b=aLDLEs+/Vol+Vf1jbcg511vTjChTE1DiYZkUQ03KNWDmTtSHLr5tV2rCsV8NTtV+QXfarVhhYY0I3331PlTVRlMtICquFALdhQwS+fPI+rpsC3M5fjZgp4HzGerzGC1I6fZBhBjaATmBstbYdDxkrC7r0gafl+lbjxblkRwRUw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762149405; c=relaxed/simple;
	bh=OWgpJBUmjAQFzDZtAAZZ0Sd8ZrZM9CKgu0LIbDLG9AQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Gn0EInOwAlx/NT4q2lqWtmDjcnaVgyJGvFR+jAPBBIKu9/oJ22xxZszz72nEmyzr0M3VhZTFCVtFZAY0ZhfuL4qJPyrpvviRNDiCd97U+ndGG5HMQ43dFcWLSh3pU0Oses8/eaNaNBQ5NDprtzB/OYUb+GWxWZIpgK1cYSEZW9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D82YnSuw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0AD1C4CEE7;
	Mon,  3 Nov 2025 05:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762149404;
	bh=OWgpJBUmjAQFzDZtAAZZ0Sd8ZrZM9CKgu0LIbDLG9AQ=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=D82YnSuwC/ok3efYFZswWAbAIk62KqKZBrdnK2YlhwHYjpCyNRaYsKXo+2md8Cw0w
	 Pqbq+WYXlB+suTSba/fkMOOM6O9xMqp0aT3/gqBuhNah6epzLNwDsAAC9m91RXgWuQ
	 UH5RgkrryElVV3sf+QgJZxe2F45SMgELKj2Us1QZsSDDbIwFJcZC2MA5cJs1EAxQgh
	 sHUzLLt5elTQocPSwmlRmWSkOEhDPumL1HuMw+cUCEF9YBIwvgaZVVV8wcYI+YrZil
	 YYLCM+7YjzFM+UeqoApPC/Ic9EP6sHVkc6Y/IN23JFPBuJly1CYk1BLS5BB0BvfAOk
	 EddU/Jom8+9sA==
Message-ID: <949eeeb5-3a16-4033-b71d-56c058ad4838@kernel.org>
Date: Mon, 3 Nov 2025 14:56:40 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] block: introduce disk_report_zone()
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
 <20251031061307.185513-5-dlemoal@kernel.org>
 <c2734f13-aad7-43a0-a164-b8504ffc1cb4@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <c2734f13-aad7-43a0-a164-b8504ffc1cb4@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/1/25 05:54, Bart Van Assche wrote:
> On 10/30/25 11:12 PM, Damien Le Moal wrote:
>> -struct disk_report_zones_cb_args {
>> -	struct gendisk	*disk;
>> -	report_zones_cb	user_cb;
>> -	void		*user_data;
>> +/*
>> + * Zone report arguments for block device drivers report_zones operation.
>> + * @cb: report_zones_cb callback for each reported zone.
>> + * @data: Private data passed to report_zones_cb.
>> + */
>> +struct blk_report_zones_args {
>> +	report_zones_cb cb;
>> +	void		*data;
>>   };
> 
> The suffix "_args" seems confusing to me because this data structure
> includes a callback pointer. Please consider changing "_args" into "_cb"
> to make it clear that the data structure includes a callback pointer.
> Another data structure that follows this convention is struct
> blk_plug_cb:
> 
>    struct blk_plug_cb;
>    typedef void (*blk_plug_cb_fn)(struct blk_plug_cb *, bool);
>    struct blk_plug_cb {
> 	struct list_head list;
> 	blk_plug_cb_fn callback;
> 	void *data;
>    };
> 
> Since struct blk_report_zones_args is passed as an argument to
> disk_report_zone(), how about renaming this data structure into
> struct disk_report_zone_cb?'

See patch 8. That structure grows beyond just the callback. So I prefer to keep
the name as it is more generic.


-- 
Damien Le Moal
Western Digital Research

