Return-Path: <linux-btrfs+bounces-18542-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B596EC2B77F
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 12:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A11D3BA70B
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 11:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0522FFDFF;
	Mon,  3 Nov 2025 11:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GnFiK307";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9p9ERH+N";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YuFfkVS2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eVgOC0V+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AD72F2603
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Nov 2025 11:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762170072; cv=none; b=E4sepImc7neJvisVfdP3BwWOaZPXVlJcUK9nIOelBpWQDAqvm5/KM9IrxGqKWg488UkZ4XaYF8bxjmBqXjM1c6Usj+SmF7xr6vkN+YHYP8vURDNbzVYS7hh42o8o8VJMwTuMZCJ4p604P4dva+wU7L39ofzE4+mCp2qB1G5+Rdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762170072; c=relaxed/simple;
	bh=gfpe9Ieic29WTye2FdoDQKnv5AsbD6Y4O3iq/F0+2TI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=En3qBGv51ZQBhoY2BvBhFdm2kp7QG2hGOMnEJaky4NsmrCaXtjplQs3ZBgv868WVcGOAgw7RyKB98Ne2VBuM5l3sax4ebz207xOf0ABCcyZUsK/gxzoIMA5JhPrBdH9xsoG5O/ftwgBgKq32plzdC6BZ368oKhH8RVdDX7fqGmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GnFiK307; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9p9ERH+N; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YuFfkVS2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eVgOC0V+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D4A8921AB9;
	Mon,  3 Nov 2025 11:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762170069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hnWHmC0GhHJr8yhikrEe9iwl7aeuCKJ/Kg1kvJIiWy0=;
	b=GnFiK307v7gxVOjgWFv1HYihI+pG6DC96tu0uRuXx4qG/OQ7qAW5FVJvZtciJlrKJBs0g8
	vcJri/+w8gVTF6VHb8WWB9ATK5NP63bK4vstc5ZsA3T0z+LxIiGG+g6l58pOznRbhGVtfC
	eimnZfBs1dNsjSM6C6rJ5lSIgBfV+Jc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762170069;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hnWHmC0GhHJr8yhikrEe9iwl7aeuCKJ/Kg1kvJIiWy0=;
	b=9p9ERH+NwU7FfwNdPvPTBVG+SV8IA5r5NNLDMghKrIyMiC1pNx1OLsZrvrNaHqb5whoQO0
	WpNP3UaDYQBqvMCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762170068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hnWHmC0GhHJr8yhikrEe9iwl7aeuCKJ/Kg1kvJIiWy0=;
	b=YuFfkVS2fEHkPyeK99I8W84VK0ccnnPc7sGWb/mc+wutKzLjsAycsUmDPQbjCpPST0qI39
	3zOEPbnkExrvpd0fOkZy373V9yJPZ8/xQNvMlMX0KjE3dW5ZMFA05M9dpWwXmIzoPYTA4z
	h3hoAo25XQbj3OFpuqtyCicoUpDr+IU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762170068;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hnWHmC0GhHJr8yhikrEe9iwl7aeuCKJ/Kg1kvJIiWy0=;
	b=eVgOC0V+VD1WpGHlNvIvty3FVY9x8yXwFz9zf3nrKqc+/7fYR3FH0n4zIXEDA8HXcY/zk+
	/5+HiV1Hq+FpfjDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD9511364F;
	Mon,  3 Nov 2025 11:41:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oyvmKdSUCGkSLwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 03 Nov 2025 11:41:08 +0000
Message-ID: <8947e877-cd53-4f1d-989c-bdde311c00e9@suse.de>
Date: Mon, 3 Nov 2025 12:41:08 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] block: handle zone management operations
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
References: <20251031061307.185513-1-dlemoal@kernel.org>
 <20251031061307.185513-4-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251031061307.185513-4-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On 10/31/25 07:12, Damien Le Moal wrote:
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
Hmm.
Question remains: what _is_ the status of a write pointer once a
zone management operation is in flight?
I would argue it's turning into a Schroedinger state, and so we
cannot make any assumptions here.
In particular we cannot issue any other write I/O to that zone once
the operation is in flight, and so it becomes meaningless if we set
the write pointer before or after the zone operation.
Once the operation fails we have to issue a 'report write pointer'
command anyway as I'd be surprised if we could assume that a failure
in a zone management command would leave the write pointer unmodified.
So I would assume that zone write plugging already blocks the zone
while an zone management command is in flight.
But if it does, why do we need this patch?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

