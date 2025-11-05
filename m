Return-Path: <linux-btrfs+bounces-18717-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F88C342F8
	for <lists+linux-btrfs@lfdr.de>; Wed, 05 Nov 2025 08:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 693DA3BD3F3
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Nov 2025 07:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012D02D239B;
	Wed,  5 Nov 2025 07:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pqmBHcb7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ukSI2R6t";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pqmBHcb7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ukSI2R6t"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C821A2D0617
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Nov 2025 07:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762326747; cv=none; b=S3a281NgWG7FQTwejC9wN1VrvqcDrARqz9uz7pgxWvc9ylKv9JxEuwRHRBoXJ3ahgJ291gjpi47hi+U0h5nXl/t5ETFmJHLbxpsdINFPFEx3rAjSy5XcEXGIPh7QVLDzqadOX2FQdNdvyGg1nCj48F2ze9tnCk0URUC26o50HBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762326747; c=relaxed/simple;
	bh=t2+qEdbH1b/W25dYoSfIwem1GL0EyhnP8+DTCTokXis=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MfGhSkIIp0YcpAMZl4TjRR/D6JCg2czo3a0+1WPFGPXdwVNf1WaD3b+dz0TftktRBiFyW5mfQxQi3ICL3OcY/CFWFcR3mVORUzIIiWfEDPkGgd8EfdqKtCRJOACSvjzIlPF2l87baWsQQTYLA+vZkEtmbuMnx0xkfu6k7FI96z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pqmBHcb7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ukSI2R6t; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pqmBHcb7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ukSI2R6t; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 346F221192;
	Wed,  5 Nov 2025 07:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762326744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kXAgOysDR0iv133ShWDlyk3KMUK8BVW/8XvwvJquiOQ=;
	b=pqmBHcb7XXB95TPpLPCkl+GtTj4IiJO7d0f5GlP+7huYn75mVr7JE6ocMGHjNYFkg0J9WH
	O0ADkBjKjXPkBzcyL4ZxoXfHNVbVhqHlCmpcnR8K8ykFoHZoWaEgyDQpXFY/cZVR3RzYrQ
	Hgz7a3rul1kChFQy881nuSmM42D5bC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762326744;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kXAgOysDR0iv133ShWDlyk3KMUK8BVW/8XvwvJquiOQ=;
	b=ukSI2R6tkOJ2cClSpz13q3BodZrZP1dJ3J5E3pMfKfdEzg7grpGHlUUy6dC/W3ONMD0C8r
	KX2mUUgn3sXoNTCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762326744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kXAgOysDR0iv133ShWDlyk3KMUK8BVW/8XvwvJquiOQ=;
	b=pqmBHcb7XXB95TPpLPCkl+GtTj4IiJO7d0f5GlP+7huYn75mVr7JE6ocMGHjNYFkg0J9WH
	O0ADkBjKjXPkBzcyL4ZxoXfHNVbVhqHlCmpcnR8K8ykFoHZoWaEgyDQpXFY/cZVR3RzYrQ
	Hgz7a3rul1kChFQy881nuSmM42D5bC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762326744;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kXAgOysDR0iv133ShWDlyk3KMUK8BVW/8XvwvJquiOQ=;
	b=ukSI2R6tkOJ2cClSpz13q3BodZrZP1dJ3J5E3pMfKfdEzg7grpGHlUUy6dC/W3ONMD0C8r
	KX2mUUgn3sXoNTCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66445132DD;
	Wed,  5 Nov 2025 07:12:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vAbwFtf4CmmmFQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 05 Nov 2025 07:12:23 +0000
Message-ID: <c7d9f83b-34af-48f2-bab6-8c79c88f5104@suse.de>
Date: Wed, 5 Nov 2025 08:12:22 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/15] block: add zone write plug condition to debugfs
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
References: <20251104013147.913802-1-dlemoal@kernel.org>
 <20251104013147.913802-14-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251104013147.913802-14-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,wdc.com:email,lst.de:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 11/4/25 02:31, Damien Le Moal wrote:
> Modify queue_zone_wplug_show() to include the condition of a zone write
> plug to the zone_wplugs debugfs attribute of a zoned block device.
> To improve readability and ease of use, rather than the zone condition
> raw value, the zone condition name is given using blk_zone_cond_str().
> 
> Suggested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-zoned.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

