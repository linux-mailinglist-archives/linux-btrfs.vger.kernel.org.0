Return-Path: <linux-btrfs+bounces-18678-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 507C9C327AB
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 18:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E0C204EC04B
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 17:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748CE7DA66;
	Tue,  4 Nov 2025 17:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ad96QY4m";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pXZ12jyJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ad96QY4m";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pXZ12jyJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35E8339710
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Nov 2025 17:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279018; cv=none; b=n2IDUTeAyMrPNU/Ne5pU/sogVwkiZfv98TbG0hFZtIgzJyO/ydLZFYTJl5rvgYliPoo/vB3JhsRicHW6uTlj8e1SXXjf938eno06RD4Z+iPJRDg70iQCEhOP+DsXQEaSsJmGLvb7tcKl1Vy+uPMDspC1In5nuLB1Qey7GObGwbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279018; c=relaxed/simple;
	bh=tLImsQRnXall+fGJy0KSNwEfqLoUf7FGTEXhDy6v/s8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Y0YRrrQYDzfsFsyB2iw5+MKcRJx7zV336P9LxyeZBQttSdU1dpdLl2dbIfzIa0aeHfiH2BMhGumDa79LIZL7oVpcCKU2iYRea5Htuuytwo5LCA8OhfWXIS5iEAxgc+GUY6rWc5g5mz7lNrTcoUEJoB9E9Sa6tiLPdODy/Uo3bC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ad96QY4m; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pXZ12jyJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ad96QY4m; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pXZ12jyJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 03CFA2118E;
	Tue,  4 Nov 2025 17:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762279015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=72Df+f2BPsETgjqjYZwpqI0AkKut+6tw+H2/JoEAAV8=;
	b=ad96QY4mlJI1fmOEdgejpaoxLIb7EelqW7DX9QhtYO4sAe+HA6ahLM7/p4qBsQNJG4RCMw
	0+pbm8v8V0U+tuf8RclLqQjFR3hqGH5yCAahL9j9L0xj1YHFabUCfgebCo91pXf1rbG6Wo
	hAoIB/lZRJDDoxyolcMQRmvT816nHLA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762279015;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=72Df+f2BPsETgjqjYZwpqI0AkKut+6tw+H2/JoEAAV8=;
	b=pXZ12jyJm9f4fGWlohjkYbtOBtoga4Ca9oOXS8dl7XMZe3y+9POHM5YGpSq4/XXA8LunW4
	v+A/wk/o1mao73Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762279015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=72Df+f2BPsETgjqjYZwpqI0AkKut+6tw+H2/JoEAAV8=;
	b=ad96QY4mlJI1fmOEdgejpaoxLIb7EelqW7DX9QhtYO4sAe+HA6ahLM7/p4qBsQNJG4RCMw
	0+pbm8v8V0U+tuf8RclLqQjFR3hqGH5yCAahL9j9L0xj1YHFabUCfgebCo91pXf1rbG6Wo
	hAoIB/lZRJDDoxyolcMQRmvT816nHLA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762279015;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=72Df+f2BPsETgjqjYZwpqI0AkKut+6tw+H2/JoEAAV8=;
	b=pXZ12jyJm9f4fGWlohjkYbtOBtoga4Ca9oOXS8dl7XMZe3y+9POHM5YGpSq4/XXA8LunW4
	v+A/wk/o1mao73Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 82E08136D1;
	Tue,  4 Nov 2025 17:56:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8T6OHmY+CmnTHwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 04 Nov 2025 17:56:54 +0000
Message-ID: <d7b6727a-683f-4963-a388-d74cd2033537@suse.de>
Date: Tue, 4 Nov 2025 18:56:53 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/15] block: freeze queue when updating zone resources
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
 <20251104013147.913802-3-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251104013147.913802-3-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.991];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,lst.de:email,wdc.com:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On 11/4/25 02:31, Damien Le Moal wrote:
> Modify disk_update_zone_resources() to freeze the device queue before
> updating the number of zones, zone capacity and other zone related
> resources. The locking order resulting from the call to
> queue_limits_commit_update_frozen() is preserved, that is, the queue
> limits lock is first taken by calling queue_limits_start_update() before
> freezing the queue, and the queue is unfrozen after executing
> queue_limits_commit_update(), which replaces the call to
> queue_limits_commit_update_frozen().
> 
> This change ensures that there are no in-flights I/Os when the zone
> resources are updated due to a zone revalidation. In case of error when
> the limits are applied, directly call disk_free_zone_resources() from
> disk_update_zone_resources() while the disk queue is still frozen to
> avoid needing to freeze & unfreeze the queue again in
> blk_revalidate_disk_zones(), thus simplifying that function code a
> little.
> 
> Fixes: 0b83c86b444a ("block: Prevent potential deadlock in blk_revalidate_disk_zones()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   block/blk-zoned.c | 42 ++++++++++++++++++++++++------------------
>   1 file changed, 24 insertions(+), 18 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

