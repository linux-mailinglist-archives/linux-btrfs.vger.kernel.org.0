Return-Path: <linux-btrfs+bounces-18713-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB4EC34298
	for <lists+linux-btrfs@lfdr.de>; Wed, 05 Nov 2025 08:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 001644F07CF
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Nov 2025 07:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C202D239B;
	Wed,  5 Nov 2025 07:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o1pBQe1Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6SkfPJ++";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o1pBQe1Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6SkfPJ++"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A4E1A23B9
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Nov 2025 07:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762326561; cv=none; b=HFfmt8bkVWErLTrjFJ+ffIYPqBp5RaabBvT128WTcW1i386V79yOFNNcRKncJQoelrebdw8BbZNaG5urzEDendAkP/0Kbu12TIS6MEeLM3oOk7/jbq+eB259FMsj+wdgMUV5aLvD/wQ9EgBM0czRn4HyKbvfdPrIjaiiM2Cv/O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762326561; c=relaxed/simple;
	bh=3lgZuFDMOgLwdwn68DTYI9xWFeGqdTKdwUIuxPOopO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tcPIEpj1EU3F2ouf+D0225G8feeMbSnu9xWeE1P7zeh7fRuVYK1sAdM6Ar0TGhK6v3V+XyQoiZLCX2QhkIIJcUFuRO5z3cXtfv1ssIK164HYIdfcyUf4GPLB6a9zUuJsbQBalmCs5jCPZ3Ot322Qu+Dl7b/rlYwUgcVrZ0RSz9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o1pBQe1Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6SkfPJ++; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o1pBQe1Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6SkfPJ++; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4EC841F394;
	Wed,  5 Nov 2025 07:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762326557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S8/T7RiFHI1VVVixCs0zWFLgYXmKOqjKf8eYz8wcHcA=;
	b=o1pBQe1QHfu4BlBIKcLfDc2GNzLpLisP2TC4E7VaKNSezNfYvU8Nfs2iVbe6Bsbn6Wig4q
	Mva3bTOLOR975yn68r++GIHtmLg8zJrjMDeqhrWH2yu62c889PsnSNI6/UYUuZwjXNa8rQ
	2AlCy0Js7OcQJ4iTEYSGL8iVoWJZf+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762326557;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S8/T7RiFHI1VVVixCs0zWFLgYXmKOqjKf8eYz8wcHcA=;
	b=6SkfPJ++NBct6x/ay8R5aLj01Oh96d9Z5IzYVTo0wfjkx1RLW0qXR4BzGS68k+y0qwm0+M
	32bczFVp6cmo35Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=o1pBQe1Q;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6SkfPJ++
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762326557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S8/T7RiFHI1VVVixCs0zWFLgYXmKOqjKf8eYz8wcHcA=;
	b=o1pBQe1QHfu4BlBIKcLfDc2GNzLpLisP2TC4E7VaKNSezNfYvU8Nfs2iVbe6Bsbn6Wig4q
	Mva3bTOLOR975yn68r++GIHtmLg8zJrjMDeqhrWH2yu62c889PsnSNI6/UYUuZwjXNa8rQ
	2AlCy0Js7OcQJ4iTEYSGL8iVoWJZf+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762326557;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S8/T7RiFHI1VVVixCs0zWFLgYXmKOqjKf8eYz8wcHcA=;
	b=6SkfPJ++NBct6x/ay8R5aLj01Oh96d9Z5IzYVTo0wfjkx1RLW0qXR4BzGS68k+y0qwm0+M
	32bczFVp6cmo35Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 07799132DD;
	Wed,  5 Nov 2025 07:09:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YqBEOxv4CmneEgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 05 Nov 2025 07:09:15 +0000
Message-ID: <c229f14a-e7af-4787-9bf0-2a374eefef83@suse.de>
Date: Wed, 5 Nov 2025 08:09:15 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/15] block: introduce blkdev_get_zone_info()
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
 <20251104013147.913802-10-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251104013147.913802-10-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4EC841F394
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,wdc.com:email,suse.de:email,suse.de:mid,suse.de:dkim];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On 11/4/25 02:31, Damien Le Moal wrote:
> Introduce the function blkdev_get_zone_info() to obtain a single zone
> information from cached zone data, that is, either from the zone write
> plug for the target zone if it exists and from the disk zones_cond
> array otherwise.
> 
> Since sequential zones that do not have a zone write plug are either
> full, empty or in a bad state (read-only or offline), the zone write
> pointer can be inferred from the zone condition cached in the disk
> zones_cond array. For sequential zones that have a zone write plug, the
> zone condition and zone write pointer are obtained from the condition
> and write pointer offset managed with the zone write plug. This allows
> obtaining the information for a zone much more quickly than having to
> execute a report zones command on the device.
> 
> blkdev_get_zone_info() falls back to using a regular zone report if the
> target zone is flagged as needing an update with the
> BLK_ZONE_WPLUG_NEED_WP_UPDATE flag, or if the target device does not
> use zone write plugs (i.e. a device mapper device). In this case, the
> new function blkdev_report_zone_fallback() is used and the zone
> condition is reported consistantly with the cahced report, that is, the
> BLK_ZONE_COND_ACTIVE condition is used in place of the implicit open,
> explicit open and closed conditions. This is achieved by adding the
> .report_active field to struct blk_report_zones_args and by having
> disk_report_zone() sets the correct zone condition if .report_active is
> true.
> 
> In preparation for using blkdev_get_zone_info() in upcoming file systems
> changes, also export this function as a GPL symbol.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   block/blk-zoned.c      | 141 +++++++++++++++++++++++++++++++++++++++++
>   include/linux/blkdev.h |   3 +
>   2 files changed, 144 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

