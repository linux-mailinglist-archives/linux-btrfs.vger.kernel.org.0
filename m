Return-Path: <linux-btrfs+bounces-18715-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C083C342C5
	for <lists+linux-btrfs@lfdr.de>; Wed, 05 Nov 2025 08:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E10914EFEDF
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Nov 2025 07:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3CF2D2397;
	Wed,  5 Nov 2025 07:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rFnoBMMw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GOw5CN6I";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rFnoBMMw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GOw5CN6I"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAB025291B
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Nov 2025 07:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762326677; cv=none; b=BzjGsZ2Lu2EICtqZOq5jdMcR+uf2fLAu764UKA6IjGRhOXTHlYF9J5o346GNuAC6I1X1xEFFAECd/2DQKHdjqF5KVkWEH8ToRJFmOu1Ml1SB5/cqhj69C6h4bRBpb+DjZWnpK87uAIO3j89U7u4/UoG0nNiFRa0r1gS45rwMOwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762326677; c=relaxed/simple;
	bh=NeOjyGUvIJClEzs3f/I0sHmcKLxtKshZp1sUOHpHgVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Pgk8CMQNP2sWgyLOmXpdQ6szpenbgFOSoibZCfpXJ8+OmsNpy48EYozYeMZ1Qzqu/7rysdo8ksWAh9lFc7eENz0swOq00Nwf2dXJYg2n5ilPba3PTT0nr4jddwj6R2/d4iA8Krh0gdrBRTvWtF6MoQxPWzW3jUJkwyDy3QMKGjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rFnoBMMw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GOw5CN6I; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rFnoBMMw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GOw5CN6I; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7F72A1F397;
	Wed,  5 Nov 2025 07:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762326673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ksQCo3Ad1VfdJUV7onmvH6G6iW7WglY8N/GR2YtrkfM=;
	b=rFnoBMMwQCLrredczS2A+OGMgWFLLPlw5ExzGSiORskXO20tfdCrPFZIJ0ffVxegdjJeHt
	OkgdU+1dVIlrG/PyFmc1JDAksS0GnSMnLvw7PRnjOO+hTbnKlHmQaNMPRaMnlN5tHi+DKW
	FEoYRnPvcnaEpwQNsu+IYxus4OwfND0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762326673;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ksQCo3Ad1VfdJUV7onmvH6G6iW7WglY8N/GR2YtrkfM=;
	b=GOw5CN6IiaZ+5r4zEgIp0v2E9r3ZHclMbanpQGZnp9ck8XswOuAQaFIYkLdg6wI/7Abo1i
	pvCofUH3YJw2XRAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rFnoBMMw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GOw5CN6I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762326673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ksQCo3Ad1VfdJUV7onmvH6G6iW7WglY8N/GR2YtrkfM=;
	b=rFnoBMMwQCLrredczS2A+OGMgWFLLPlw5ExzGSiORskXO20tfdCrPFZIJ0ffVxegdjJeHt
	OkgdU+1dVIlrG/PyFmc1JDAksS0GnSMnLvw7PRnjOO+hTbnKlHmQaNMPRaMnlN5tHi+DKW
	FEoYRnPvcnaEpwQNsu+IYxus4OwfND0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762326673;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ksQCo3Ad1VfdJUV7onmvH6G6iW7WglY8N/GR2YtrkfM=;
	b=GOw5CN6IiaZ+5r4zEgIp0v2E9r3ZHclMbanpQGZnp9ck8XswOuAQaFIYkLdg6wI/7Abo1i
	pvCofUH3YJw2XRAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B449D132DD;
	Wed,  5 Nov 2025 07:11:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vZMZKpD4CmnXFAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 05 Nov 2025 07:11:12 +0000
Message-ID: <ca71da48-0ee2-44b6-badf-5ed933d2a4ff@suse.de>
Date: Wed, 5 Nov 2025 08:11:12 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/15] block: introduce BLKREPORTZONESV2 ioctl
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
 <20251104013147.913802-12-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251104013147.913802-12-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 7F72A1F397
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,suse.de:dkim,suse.de:mid,suse.de:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.51

On 11/4/25 02:31, Damien Le Moal wrote:
> Introduce the new BLKREPORTZONESV2 ioctl command to allow user
> applications access to the fast zone report implemented by
> blkdev_report_zones_cached(). This new ioctl is defined as number 142
> and is documented in include/uapi/linux/fs.h.
> 
> Unlike the existing BLKREPORTZONES ioctl, this new ioctl uses the flags
> field of struct blk_zone_report also as an input. If the user sets the
> BLK_ZONE_REP_CACHED flag as an input, then blkdev_report_zones_cached()
> is used to generate the zone report using cached zone information. If
> this flag is not set, then BLKREPORTZONESV2 behaves in the same manner
> as BLKREPORTZONES and the zone report is generated by accessing the
> zoned device.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-zoned.c             | 25 ++++++++++++++++++++++---
>   block/ioctl.c                 |  1 +
>   include/uapi/linux/blkzoned.h | 32 +++++++++++++++++++++++++++-----
>   include/uapi/linux/fs.h       |  2 +-
>   4 files changed, 51 insertions(+), 9 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

