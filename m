Return-Path: <linux-btrfs+bounces-18716-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65404C342C8
	for <lists+linux-btrfs@lfdr.de>; Wed, 05 Nov 2025 08:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F26818C337F
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Nov 2025 07:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3222D239B;
	Wed,  5 Nov 2025 07:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Wnmtq7wd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tvOiwC+j";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Wnmtq7wd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tvOiwC+j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2314F2C324F
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Nov 2025 07:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762326718; cv=none; b=FFIZ0lmCqQJctXpS2QgW7ANmp5O2uvP67snRoVxQTLrw48WsDxhwmhOgO/qvp1M/MYVicqVh7Zl15nVT7C3syhBqiYwV/ryheWRuJ3mtFFGUUCiHaiE3hqGCgaHnpl/UPewdYVTZMGfr+Y5iI7fMQtuKKO1jlipTR/XDm6Ymu2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762326718; c=relaxed/simple;
	bh=6Mdv73sGYR3HPTBR+MfR1iGRnBkevOlytq9dMJ/Khxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hljASZy0efIhcegpQ17v7c+ECO5i0bJyVy56Y13uami9hOVs0m1fD/P9i2WE9wvdbL+1nU1DEbSoauwIHi3Nkozpt0lI1wrNi/rtZLGv6hDNG8aexu3pcp2EnMopuKTIVzarfp75cqCxqKHH4lbS56UJ11K0q5aibmvghQWdjTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Wnmtq7wd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tvOiwC+j; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Wnmtq7wd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tvOiwC+j; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 38EB221192;
	Wed,  5 Nov 2025 07:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762326714; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4d54C35MbHOtsQ0vFtO7Mf9zgOgclyZbeYmbXxDdTeo=;
	b=Wnmtq7wdroASGjT4Cyn9/nvwdN1RhoEXEO6ICviC5VKZCU6pMZPY+jx4PImNstUQymFRGe
	IfBuxGY5dyiaZEkv1+a3P8qDo/sctfyU6mPY3dOBtYaWd2ULGEDKVFnn+TScRrf2DyKoiU
	hiH++y+hd2B0RZa6fuiw1PG+hIDVeHw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762326714;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4d54C35MbHOtsQ0vFtO7Mf9zgOgclyZbeYmbXxDdTeo=;
	b=tvOiwC+jf+OZuAawFq/iwTeFvC+0+jXCZTojRfkrbsskhQroxDLkvdsSOGvpkCapwX7qk0
	jWcWnAHQPOnYAWBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Wnmtq7wd;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tvOiwC+j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762326714; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4d54C35MbHOtsQ0vFtO7Mf9zgOgclyZbeYmbXxDdTeo=;
	b=Wnmtq7wdroASGjT4Cyn9/nvwdN1RhoEXEO6ICviC5VKZCU6pMZPY+jx4PImNstUQymFRGe
	IfBuxGY5dyiaZEkv1+a3P8qDo/sctfyU6mPY3dOBtYaWd2ULGEDKVFnn+TScRrf2DyKoiU
	hiH++y+hd2B0RZa6fuiw1PG+hIDVeHw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762326714;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4d54C35MbHOtsQ0vFtO7Mf9zgOgclyZbeYmbXxDdTeo=;
	b=tvOiwC+jf+OZuAawFq/iwTeFvC+0+jXCZTojRfkrbsskhQroxDLkvdsSOGvpkCapwX7qk0
	jWcWnAHQPOnYAWBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A7E91132DD;
	Wed,  5 Nov 2025 07:11:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OngLJ7n4CmmHFQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 05 Nov 2025 07:11:53 +0000
Message-ID: <c6b1cea7-50c1-4b8e-9cee-9555e47ff0ad@suse.de>
Date: Wed, 5 Nov 2025 08:11:53 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/15] block: improve zone_wplugs debugfs attribute
 output
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
 <20251104013147.913802-13-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251104013147.913802-13-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 38EB221192
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,wdc.com:email,acm.org:email,suse.de:email,suse.de:mid,suse.de:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On 11/4/25 02:31, Damien Le Moal wrote:
> Make the output of the zone_wplugs debugfs attribute file more easily
> readable by adding the name of the zone write plugs fields in the
> output.
> 
> No functional changes.
> 
> Suggested-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   block/blk-zoned.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index ea61ad7905c0..2180d5256f9f 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -2305,8 +2305,10 @@ static void queue_zone_wplug_show(struct blk_zone_wplug *zwplug,
>   	zwp_bio_list_size = bio_list_size(&zwplug->bio_list);
>   	spin_unlock_irqrestore(&zwplug->lock, flags);
>   
> -	seq_printf(m, "%u 0x%x %u %u %u\n", zwp_zone_no, zwp_flags, zwp_ref,
> -		   zwp_wp_offset, zwp_bio_list_size);
> +	seq_printf(m,
> +		"Zone no: %u, flags: 0x%x, ref: %u, wp ofst: %u, pending BIO: %u\n",
> +		zwp_zone_no, zwp_flags, zwp_ref,
> +		zwp_wp_offset, zwp_bio_list_size);
>   }
>   
>   int queue_zone_wplugs_show(void *data, struct seq_file *m)

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

