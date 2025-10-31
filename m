Return-Path: <linux-btrfs+bounces-18485-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1C0C26F57
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 21:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F1251A2518A
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 20:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D809C329E4E;
	Fri, 31 Oct 2025 20:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="KjMlI0TV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40E32FFFAC;
	Fri, 31 Oct 2025 20:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761944129; cv=none; b=C70zcOdAahjaNPzKUzCf0muBVckZSVH2HXWN5lK58tc7X6e0UDmR2AStxui1vWNmVB8HwtUmhuSBGO9W0C4FwWLVA/Lk6F06KZTrJaG5oQyxnQAod606fWC8Bi4n0VgJFZzDBDrTtUOSgYFf1BRg/yZoZPg4A/VlUjGu5u/NH6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761944129; c=relaxed/simple;
	bh=RXJelptsntvFFlhc8jcKDb1xEUWF4wc2LihHJXooal0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ncH0nTS7dSJ74hu4h5B276uZqDGRqCIiSF3hw9CrGSlcIX9FLl9Y0ETRhDtcob1l4lbKID8KQWG8M7rCvswM/UPK3OCM3FREXZpHhLP/NBiZSA/cRJ+HkFfuDK6FscRoSfzu04zsOClzYQWQ5onExu86QvNVyY/HhQn5hRKbvyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=KjMlI0TV; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4cytXt5lb3zlvylD;
	Fri, 31 Oct 2025 20:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1761944124; x=1764536125; bh=RXJelptsntvFFlhc8jcKDb1x
	EUWF4wc2LihHJXooal0=; b=KjMlI0TV+UmybbZqq0hABBz7D7B+mZtbJsaEP7c6
	+AKYo7kLpb1AWqWaIM9FiTQCar0Re5+4/1yDtUk5/1cv35nSGQndExdDPayKfOha
	LYfkDOdU8FzjQ5VHhyFV1IdzcyT88OZxV23DP8DKkkVeYrnzDjm+Gw1fXrT3+r+q
	u5ouP8wG3EHIOImTndJWsh3jkXrBeYaSn+lSOB/iM7bIX3UQmWL7EeRRMjHvKdc/
	jTVq3BaddT+WuwgKYpXDRSFQbrjiNDul0GezqLwvY4TNc8zNCAxA2RLKQZkQah28
	RP+SkqEUpxbFw818CcmYsRNv14+r62Zv5TeC3XwBpKyd0w==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id YW4wV6VTFvhK; Fri, 31 Oct 2025 20:55:24 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4cytXd6ygFzlrwfr;
	Fri, 31 Oct 2025 20:55:12 +0000 (UTC)
Message-ID: <fe191362-1fa2-44dd-a3a6-bf5a29e50027@acm.org>
Date: Fri, 31 Oct 2025 13:55:11 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] block: reorganize struct blk_zone_wplug
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
 <20251031061307.185513-6-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251031061307.185513-6-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/25 11:12 PM, Damien Le Moal wrote:
> Reorganize the fields of struct blk_zone_wplug to remove a hole after
> the wp_offset field and avoid having the bio_work structure split
> between 2 cache lines.
Reviewed-by: Bart Van Assche <bvanassche@acm.org>

