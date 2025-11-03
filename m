Return-Path: <linux-btrfs+bounces-18540-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B847C2B446
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 12:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEE983AB46C
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 11:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705133019B8;
	Mon,  3 Nov 2025 11:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X0IF/W7j";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UwR073Kh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X0IF/W7j";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UwR073Kh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBEE221FDA
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Nov 2025 11:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762168531; cv=none; b=sAjzmkiqzWBzS51GoBAqHObC33AuffeHhzKvT/cV6CzkH3gxo76dTjDbILhwBiK6StG1JWB6vCphdtUO6GIH/5bl9yJ5CyDNl429R2VyGemuafmrPL8Fr1QmR7+wNQjDlibCJx/lx5d9s2ZPRawT0Z8tped5CqIkKNJ7lEoe7DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762168531; c=relaxed/simple;
	bh=PE5jjBcPySyviyWDBDTXr8YVrE1ft91DMQKGMM12dHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eHL1lbKPYuCzsubyGFivFrLQnKwWux1FditQzLLLmonxleaJB/PZfUfumMqA59uN4Zzu8hAioYivyKmmv4XiI8rXMc6VEqjxeksMrbuRzzWV90WFkGCjVscXRcbP11V5sbKNMwlWCgHt0IRJjeeoCrQvy7AWV/IEZ/9qSntB8rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X0IF/W7j; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UwR073Kh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X0IF/W7j; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UwR073Kh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 17F7021CBE;
	Mon,  3 Nov 2025 11:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762168527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bk+wS36EfJQGoEmnN2KOAKKyPv/E2ZOJY94ROMtWko4=;
	b=X0IF/W7j5x+S0GqYfFot2EpvNPQndbJlqqWCNmoLaHcIQ+q+Wq9JCIzmR8gmn6TGZCP5PS
	4L5Rx/cXdX0m+WXB3LC1X+PvN7iyPgCMNvrVo+kJEVaVJKT3e2+Uw6OfNHQ35Y+WjtJHpj
	+/G6FGj5o7ISqnvDt4uetORbOTS85mw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762168527;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bk+wS36EfJQGoEmnN2KOAKKyPv/E2ZOJY94ROMtWko4=;
	b=UwR073KhJOzcyHNOrrqBvG9sUm5B/XZXIvYyB0p9iQhqyrVkFq683qcQfPh85/7SyaaMrI
	We7fjwNqoMSk0YCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762168527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bk+wS36EfJQGoEmnN2KOAKKyPv/E2ZOJY94ROMtWko4=;
	b=X0IF/W7j5x+S0GqYfFot2EpvNPQndbJlqqWCNmoLaHcIQ+q+Wq9JCIzmR8gmn6TGZCP5PS
	4L5Rx/cXdX0m+WXB3LC1X+PvN7iyPgCMNvrVo+kJEVaVJKT3e2+Uw6OfNHQ35Y+WjtJHpj
	+/G6FGj5o7ISqnvDt4uetORbOTS85mw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762168527;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bk+wS36EfJQGoEmnN2KOAKKyPv/E2ZOJY94ROMtWko4=;
	b=UwR073KhJOzcyHNOrrqBvG9sUm5B/XZXIvYyB0p9iQhqyrVkFq683qcQfPh85/7SyaaMrI
	We7fjwNqoMSk0YCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E6C40139A9;
	Mon,  3 Nov 2025 11:15:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JPzkN86OCGkJFgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 03 Nov 2025 11:15:26 +0000
Message-ID: <16252f59-d52a-4acf-baa8-055eca54904e@suse.de>
Date: Mon, 3 Nov 2025 12:15:26 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] block: cleanup blkdev_report_zones()
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
 <20251031061307.185513-3-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251031061307.185513-3-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 10/31/25 07:12, Damien Le Moal wrote:
> The variable capacity is used only in one place and so can be removed
> and get_capacity(disk) used directly instead.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   block/blk-zoned.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

