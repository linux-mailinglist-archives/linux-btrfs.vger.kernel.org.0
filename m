Return-Path: <linux-btrfs+bounces-18541-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76285C2B453
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 12:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5ABE44EAAA2
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 11:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074E03019AF;
	Mon,  3 Nov 2025 11:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="T2cmJCIR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+ywv+G+I";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JLFk3m1B";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="smTMsLHl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14BF221FDA
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Nov 2025 11:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762168659; cv=none; b=k6+b0GwXzhvkCb4uqzWMnbksyllJqMFh0VZ6QP/11AWylgmUmqrhleCFw1J3m4DWfdvnIGkBi0PFkgOL2W4Cos5fyx6fv4c19lCk3RkmRcn4nlUy4cw/ja9c/tsIwy6QpesqrXdQcaO+9dCVswCNCkYHkYq7xGoQ1SwXYQ+exsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762168659; c=relaxed/simple;
	bh=PYnKimL9C1poOiobYUKOydyLJTnMwWi2JZnxzXATDuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Fhoov8sZ3fCf7QVTUog3rTyBvQdm0UK4/pusnEmNmXazlnGB5YTMJZy/NZoN4bQQiW5K4/+fxPyegWCegzaS/aOO9QpVP2NPJrohxrB1F8C0JjrWcVznmQd6TpIEz1QK3mcKFx62uztFNG14vQ/5l+DwR8qn8Pawcnc32IYL6TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=T2cmJCIR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+ywv+G+I; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JLFk3m1B; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=smTMsLHl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C6F381F7C4;
	Mon,  3 Nov 2025 11:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762168656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wXdUrem8sAALhKYjhxC1IdzSmgHyEFcuHW/uUtjlUkg=;
	b=T2cmJCIRgxBlnxDE/4DEgrC44Mp8J4CbeDdXVLsvzErSYwpxv1e7SS9z/ebdXMlg+AFRe2
	6QqiB+Atv7giockwqpI/DEfJ+iraRcfQx2V2qKQbf1J22/LBHPD7cB8jiJuA1F08RIcuJF
	L6B32Sqkig6yl1a3hb9ISbhT+YXPq+Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762168656;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wXdUrem8sAALhKYjhxC1IdzSmgHyEFcuHW/uUtjlUkg=;
	b=+ywv+G+I+N8WRsaR9jhITdzsbsWuHyWbLQLLa5bEIJgYeFKceP5okYKZpfDyD67vki6mh8
	TvrMq68jY7I/e2Bg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JLFk3m1B;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=smTMsLHl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762168655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wXdUrem8sAALhKYjhxC1IdzSmgHyEFcuHW/uUtjlUkg=;
	b=JLFk3m1BFdhbpsdgNDhBxUPPrqZfj+kRMuEpjFe76iccVqA2rt0eaR4B++T/DvHD/sxC4T
	lk9Z2q+0ZkWrdpby8fZ19mmC+COpCswHwmqglyC5ZneIZ1gK1A06YGMwRzDj7Iu62M2/fW
	pHWZHodm3CcnBBAJHknPW/n/JDrPN7Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762168655;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wXdUrem8sAALhKYjhxC1IdzSmgHyEFcuHW/uUtjlUkg=;
	b=smTMsLHlYxbtlOno0P19mCJID/OAAdJfc3z9zU/JRXUMKLU3eSbBKujVSgeZL0LX3kk0DX
	ni+ksW/UiuUefIDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B4DC139A9;
	Mon,  3 Nov 2025 11:17:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7SxCIU+PCGkdGAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 03 Nov 2025 11:17:35 +0000
Message-ID: <6511ddae-86c4-448d-8879-0567965ff257@suse.de>
Date: Mon, 3 Nov 2025 12:17:35 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] block: freeze queue when updating zone resources
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
 <20251031061307.185513-2-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251031061307.185513-2-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: C6F381F7C4
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.51

On 10/31/25 07:12, Damien Le Moal wrote:
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
> resources are updated due to a zone revalidation.
> 
> Fixes: 0b83c86b444a ("block: Prevent potential deadlock in blk_revalidate_disk_zones()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   block/blk-zoned.c | 19 ++++++++++++++-----
>   1 file changed, 14 insertions(+), 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

