Return-Path: <linux-btrfs+bounces-18680-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1804EC32D58
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 20:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9099A34D309
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 19:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42EF284671;
	Tue,  4 Nov 2025 19:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MRk2MwnG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sa9o5gVR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MRk2MwnG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sa9o5gVR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3169125F99B
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Nov 2025 19:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762285179; cv=none; b=GTPP2Y520siAaYeWksIcMFkdFnmNAGLcR8CQvdjfpPYtr0e2eT7WC8owjUPsuM/hna/ZVzjXkQpSlf8pBMEtNvwxdE3wvCJEQx9n0UugbKBHe8npGS3fFbn7nF42lQqgOgclnCRggOyHbWYCgWdOgH13deZjtpXHtBm1xQjIWLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762285179; c=relaxed/simple;
	bh=V5bCAJoydFOcRk31/Kp59Z9FI3PuJewEm0mBxvgh8uE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gL+ycyHHYRz4TCSWnBAd0W7jr73GMtxM6Z/vbXDYKQP+uyIDP+OIJbs3kJmfJgx0Mh8h0FDoa+U1F6eWSifPOuUDciO/QIm/oLMnlibf3gNJfutX8AKgARUwGGUDas/nenUZURSfVsu90Hcl2ErLWJX2Zyh8tMPqiWVUxNphAco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MRk2MwnG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sa9o5gVR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MRk2MwnG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sa9o5gVR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4FEA02119D;
	Tue,  4 Nov 2025 19:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762285175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Em075iaBhD+Tx3zzVstmXsKw7x6Kx+d+zo1oYM7vGw4=;
	b=MRk2MwnG1ZpEIX37KbBErZmCQ+QQ9nffNT8+nVGFwd3xUKAJSGCGXYJP+8K8ervS7aT1yZ
	jDOHRz1tcjF60LNsUniWLMkqLTI2Xemb+q0toqtMLYHMvvgW4u6x51sQvmzR7JhxqlpU5M
	J8cJFOlSUsfJUaw5HpvdJkobf4oDDLs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762285175;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Em075iaBhD+Tx3zzVstmXsKw7x6Kx+d+zo1oYM7vGw4=;
	b=sa9o5gVRp2zS5Cd4A3wCQQPggTyLBWhZq2pPZjiqvxA6KVuIWvilL5trOA4NPrGdMoDSc1
	ot7D1h8prmfJDEDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762285175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Em075iaBhD+Tx3zzVstmXsKw7x6Kx+d+zo1oYM7vGw4=;
	b=MRk2MwnG1ZpEIX37KbBErZmCQ+QQ9nffNT8+nVGFwd3xUKAJSGCGXYJP+8K8ervS7aT1yZ
	jDOHRz1tcjF60LNsUniWLMkqLTI2Xemb+q0toqtMLYHMvvgW4u6x51sQvmzR7JhxqlpU5M
	J8cJFOlSUsfJUaw5HpvdJkobf4oDDLs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762285175;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Em075iaBhD+Tx3zzVstmXsKw7x6Kx+d+zo1oYM7vGw4=;
	b=sa9o5gVRp2zS5Cd4A3wCQQPggTyLBWhZq2pPZjiqvxA6KVuIWvilL5trOA4NPrGdMoDSc1
	ot7D1h8prmfJDEDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C17FA139A9;
	Tue,  4 Nov 2025 19:39:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TLliLXZWCmlFAwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 04 Nov 2025 19:39:34 +0000
Message-ID: <5da10962-05f0-4c25-9e0d-7d2576a0e525@suse.de>
Date: Tue, 4 Nov 2025 20:39:34 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/15] block: introduce disk_report_zone()
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
 <20251104013147.913802-5-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251104013147.913802-5-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 11/4/25 02:31, Damien Le Moal wrote:
> Commit b76b840fd933 ("dm: Fix dm-zoned-reclaim zone write pointer
> alignment") introduced an indirect call for the callback function of a
> report zones executed with blkdev_report_zones(). This is necessary so
> that the function disk_zone_wplug_sync_wp_offset() can be called to
> refresh a zone write plug zone write pointer offset after a write error.
> However, this solution makes following the path of a zone information
> harder to understand.
> 
> Clean this up by introducing the new blk_report_zones_args structure to
> define a zone report callback and its private data and introduce the
> helper function disk_report_zone() which calls both
> disk_zone_wplug_sync_wp_offset() and the zone report user callback
> function for all zones of a zone report. This helper function must be
> called by all block device drivers that implement the report zones
> block operation in order to correctly report a zone information.
> 
> All block device drivers supporting the report_zones block operation are
> updated to use this new scheme.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   block/blk-zoned.c                 | 79 ++++++++++++++++---------------
>   drivers/block/null_blk/null_blk.h |  3 +-
>   drivers/block/null_blk/zoned.c    |  4 +-
>   drivers/block/ublk_drv.c          |  4 +-
>   drivers/block/virtio_blk.c        | 11 +++--
>   drivers/block/zloop.c             |  4 +-
>   drivers/md/dm-zone.c              | 54 +++++++++++----------
>   drivers/md/dm.h                   |  3 +-
>   drivers/nvme/host/core.c          |  5 +-
>   drivers/nvme/host/multipath.c     |  4 +-
>   drivers/nvme/host/nvme.h          |  2 +-
>   drivers/nvme/host/zns.c           | 10 ++--
>   drivers/scsi/sd.h                 |  2 +-
>   drivers/scsi/sd_zbc.c             | 20 +++-----
>   include/linux/blkdev.h            |  7 ++-
>   include/linux/device-mapper.h     | 10 +++-
>   16 files changed, 120 insertions(+), 102 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

