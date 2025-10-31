Return-Path: <linux-btrfs+bounces-18493-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 52249C2715F
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 22:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 505844E5CFC
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 21:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC0032A3D4;
	Fri, 31 Oct 2025 21:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="OpmO3xIc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A1427FB3C;
	Fri, 31 Oct 2025 21:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761947739; cv=none; b=bRAOMWgJ2AC7fHtyb0TNLHubUa6B0iWYrlJ6MADX6adhovl6/I5cBm06KKIMhYu3Q2xgH+YfU2HcZYC0JwKpXPBqHjKQl6qsBoTKSsAQ4rXYKVx0Sy8sRltXmgIC6fFw5YYLdrpvNOt/onr8U0idXsI+jRW8zLA0diG792IS0D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761947739; c=relaxed/simple;
	bh=ejTnG+XD06HRWSx/Nh4/cSNkzZ+idaKjT0gGtVZ3zHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=U9b7emeQiQYfuu2dD+jHCsc4hpdw8jXilLtY8qf26J83btXtk4eq13AyI3vKhg+wx4vxu0L9OpCwCYsF8ZrZnjtjer72/WAXwinHTLBvMmTd8AQlJmEadpZJ13GUwZ42mP5RHOsm5J3AVReq1LxyYOwzuAARS8QdV1Uh4vxTW/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=OpmO3xIc; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4cyvtJ6kM4zm0jvK;
	Fri, 31 Oct 2025 21:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1761947734; x=1764539735; bh=cMr12pMLjE66ZLJgfh9u6SnW
	e7M5oEz8wUdwX9iE4Ic=; b=OpmO3xIcXuZXUen+RPg8c8kumkTVrBZ3LPnA8Qvy
	mYEZ3Wu7qgNYPNitoaUA8BKnHDO2shinTSHDeOfg7ftya7SNfranagToCSF7lN0E
	KVU28LDu7UTvnD3qnf8rrzK4OzCy/CBAKOgyykQXhnS8Y0ngjU64St86qFBAMAZQ
	o8Es0EYtpN4ckwkVwRKU/xYQrejzL8vDzdSxQ75utlmUpgAMK93VKIYjmWNmq3Vf
	Ca3sY2WILYoYpzobqnLcguya7EgV/LmgqsRcmMX01bkdtzQLzehZwHXUvsZOi/fF
	QK9E5rGuKsip6GcfbFGHINBcBIlgeJhbz/HH2wIBHdYtQA==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id tmX2EuuEY4-X; Fri, 31 Oct 2025 21:55:34 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4cyvt42Yn3zm0pL4;
	Fri, 31 Oct 2025 21:55:23 +0000 (UTC)
Message-ID: <22912f8a-01af-415c-a4f0-9db87eac32d2@acm.org>
Date: Fri, 31 Oct 2025 14:55:22 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] block: add zone write plug condition to debugfs
 zone_wplugs
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
 <20251031061307.185513-12-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251031061307.185513-12-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/25 11:13 PM, Damien Le Moal wrote:
> -	seq_printf(m, "%u 0x%x %u %u %u\n", zwp_zone_no, zwp_flags, zwp_ref,
> -		   zwp_wp_offset, zwp_bio_list_size);
> +	seq_printf(m, "%u 0x%x %u 0x%x %u %u\n",
> +		   zwp_zone_no, zwp_flags, zwp_ref,
> +		   zwp_cond, zwp_wp_offset, zwp_bio_list_size);

The debugfs output is incomprehensible for anyone who has not memorized
the source code of queue_zone_wplug_show(). Please expand the debugfs
output such that it becomes easier to comprehend. See e.g. the
queue_zone_wplug_show() changes in
https://lore.kernel.org/linux-block/20251014215428.3686084-15-bvanassche@acm.org/.

Thanks,

Bart.

