Return-Path: <linux-btrfs+bounces-18677-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A680C3277B
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 18:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 92C574EBFA5
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 17:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118D3337BA4;
	Tue,  4 Nov 2025 17:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1oGK9Wlw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Mut4Kb+h";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1oGK9Wlw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Mut4Kb+h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C9C33BBDC
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Nov 2025 17:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762278935; cv=none; b=P3E8NMgYB6Do8xVCC8E4PASgi+YzyINgsdvhfZzAEsMETeAeMjm4JJgmeOQU03jZ9MA3JVpNYmVYTNCU/LQVLmJeKlH2KkjAJM1pxacAmOEV20KGF1nySe5/iP2oKnnDUHvAcMEnuQvUxndFLYTNWK38a76TOGwViCF+H0c41AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762278935; c=relaxed/simple;
	bh=Uflt1BUm18HPLVV8TZr9Kk+KXTK7PClhqwMZjwCcEkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fCEYvMREceC/kxUfN1ctvsyKsZxTdX2pqts2BA6+bB2DgDl0LxnbzQDnEQdNYfWo+ivxXV9Hfxuf2D1duw7epN1t4FrVL0EycL0anZofDmUYGIBCK+w2aBFLUPrpMdWhBY7boJ7/7ncUshQx+VaejuMXInNsxSl6Qz9tu/Fq0xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1oGK9Wlw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Mut4Kb+h; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1oGK9Wlw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Mut4Kb+h; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1853121174;
	Tue,  4 Nov 2025 17:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762278930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rHd2eFoirDazFmsA5WtLKtkEgeModSBKHWr5WI9janA=;
	b=1oGK9WlwrBPSGNkB/1bZxsknUz91EFsK7rh1LgGEkGR/rpNzFKE1FkqhESnW6ilXwbMd3B
	hin0iBlMLcoQjc9ZcxaqZqvFUmlAF49DqFm2tM7USm5Ce8jj7rnKmIAP8sriUKE9m1ZDUq
	XdaOzvHsKKECSGiUScT67lgJW2BtI5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762278930;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rHd2eFoirDazFmsA5WtLKtkEgeModSBKHWr5WI9janA=;
	b=Mut4Kb+hFZqwDOeWHnJSXEaZBOqA3AnCP+fQPY6TgwB14Tg/3eGgddrWweoJAHdRa5FGiq
	uGixNavXGYYft6Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762278930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rHd2eFoirDazFmsA5WtLKtkEgeModSBKHWr5WI9janA=;
	b=1oGK9WlwrBPSGNkB/1bZxsknUz91EFsK7rh1LgGEkGR/rpNzFKE1FkqhESnW6ilXwbMd3B
	hin0iBlMLcoQjc9ZcxaqZqvFUmlAF49DqFm2tM7USm5Ce8jj7rnKmIAP8sriUKE9m1ZDUq
	XdaOzvHsKKECSGiUScT67lgJW2BtI5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762278930;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rHd2eFoirDazFmsA5WtLKtkEgeModSBKHWr5WI9janA=;
	b=Mut4Kb+hFZqwDOeWHnJSXEaZBOqA3AnCP+fQPY6TgwB14Tg/3eGgddrWweoJAHdRa5FGiq
	uGixNavXGYYft6Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 78841136D1;
	Tue,  4 Nov 2025 17:55:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fBHjGxE+Cmk9HgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 04 Nov 2025 17:55:29 +0000
Message-ID: <d22ea013-76d9-4c61-a762-4afeed804557@suse.de>
Date: Tue, 4 Nov 2025 18:53:48 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/15] block: handle zone management operations
 completions
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
 <20251104013147.913802-2-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251104013147.913802-2-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.988];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 11/4/25 02:31, Damien Le Moal wrote:
> The functions blk_zone_wplug_handle_reset_or_finish() and
> blk_zone_wplug_handle_reset_all() both modify the zone write pointer
> offset of zone write plugs that are the target of a reset, reset all or
> finish zone management operation. However, these functions do this
> modification before the BIO is executed. So if the zone operation fails,
> the modified zone write pointer offsets become invalid.
> 
> Avoid this by modifying the zone write pointer offset of a zone write
> plug that is the target of a zone management operation when the
> operation completes. To do so, modify blk_zone_bio_endio() to call the
> new function blk_zone_mgmt_bio_endio() which in turn calls the functions
> blk_zone_reset_all_bio_endio(), blk_zone_reset_bio_endio() or
> blk_zone_finish_bio_endio() depending on the operation of the completed
> BIO, to modify a zone write plug write pointer offset accordingly.
> These functions are called only if the BIO execution was successful.
> 
> Fixes: dd291d77cc90 ("block: Introduce zone write plugging")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   block/blk-zoned.c | 139 ++++++++++++++++++++++++++++++----------------
>   block/blk.h       |  14 +++++
>   2 files changed, 104 insertions(+), 49 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

