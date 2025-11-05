Return-Path: <linux-btrfs+bounces-18709-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AADC341FC
	for <lists+linux-btrfs@lfdr.de>; Wed, 05 Nov 2025 08:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E83A04F2EA8
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Nov 2025 07:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4E32D0C8B;
	Wed,  5 Nov 2025 07:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bamh70B1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="824OQiKv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bamh70B1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="824OQiKv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3063D2D0635
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Nov 2025 07:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762326135; cv=none; b=tSe58Y1A/sGM4fA7hLfnuhvDE5HjKFHQNdfXgj3Ka2OEietzShXuYhO9BtIYCJsamdKLfDQeKA7uLzjA39RInIKk109fBMDjb+Ana2nOSlg5QyZxhQogEAdBaUmgJDv+LO+zFJ9ui+HB+kNqNehAgnyVR/WCk2GJgb7LfegcIds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762326135; c=relaxed/simple;
	bh=gIbZAVyb3XvaNqywmxw8bSlwhzPTd2U80vLEEe9WntM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ugjzG2Asm7rFxa4WXtKHLv/8ZZg7bzsUCXMmfjaLdnlspWFpeHLVA76QznMegzKRE47uEaUAxfNvbZ8K95Hekhxj9lU5HpfFLydrUQEVh3K4wOdyqiiu7acyqTFJ+jAFuvx3wfWwHijATAhpFg+YGVXM89CEF74VdmSmNZxnjDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bamh70B1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=824OQiKv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bamh70B1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=824OQiKv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 13B7F2118E;
	Wed,  5 Nov 2025 07:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762326130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HiWTKq6RFEsgq4tdBiXrdi6UiJ/nLkzXTBqjXsIruM0=;
	b=bamh70B1hocnN40iCBeYeIBTceV1d9Zm1rbXv4xuvaTBVzsdEAhq4ltYE7RaNBvAwM/fuh
	XyllWQMANOViiywAfJoxaycYqphihAlEhzkrbtawyT6GuL/Eo94dSpX941ZBEf5avmGfhb
	IInP8tgBAax5LnAfHKtbguwpljEt7eA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762326130;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HiWTKq6RFEsgq4tdBiXrdi6UiJ/nLkzXTBqjXsIruM0=;
	b=824OQiKvKNmQ5aey60IjcInoMm2F1zM+hwgVZc13D2zIR2xaMjz2NLuYOqB4IEIt7vV7Ja
	I04Bwr0romzXawDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762326130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HiWTKq6RFEsgq4tdBiXrdi6UiJ/nLkzXTBqjXsIruM0=;
	b=bamh70B1hocnN40iCBeYeIBTceV1d9Zm1rbXv4xuvaTBVzsdEAhq4ltYE7RaNBvAwM/fuh
	XyllWQMANOViiywAfJoxaycYqphihAlEhzkrbtawyT6GuL/Eo94dSpX941ZBEf5avmGfhb
	IInP8tgBAax5LnAfHKtbguwpljEt7eA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762326130;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HiWTKq6RFEsgq4tdBiXrdi6UiJ/nLkzXTBqjXsIruM0=;
	b=824OQiKvKNmQ5aey60IjcInoMm2F1zM+hwgVZc13D2zIR2xaMjz2NLuYOqB4IEIt7vV7Ja
	I04Bwr0romzXawDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E819132DD;
	Wed,  5 Nov 2025 07:02:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id v1XlHHH2CmmGDAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 05 Nov 2025 07:02:09 +0000
Message-ID: <57f304f4-ddfe-4d31-91c0-c4fcc5c6c737@suse.de>
Date: Wed, 5 Nov 2025 08:02:09 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/15] block: reorganize struct blk_zone_wplug
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
 <20251104013147.913802-6-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251104013147.913802-6-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 11/4/25 02:31, Damien Le Moal wrote:
> Reorganize the fields of struct blk_zone_wplug to remove a hole after
> the wp_offset field and avoid having the bio_work structure split
> between 2 cache lines.
> 
> No functional changes.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   block/blk-zoned.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

