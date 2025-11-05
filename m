Return-Path: <linux-btrfs+bounces-18718-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 070A1C342E0
	for <lists+linux-btrfs@lfdr.de>; Wed, 05 Nov 2025 08:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2C84034B475
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Nov 2025 07:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7F02D23A8;
	Wed,  5 Nov 2025 07:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="15ehS71h";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WZqtjCmZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="15ehS71h";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WZqtjCmZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F071A23B9
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Nov 2025 07:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762326812; cv=none; b=H4RguIAlpmKXoeHrIEsjUuxU0taH7JIxF9GXzjnDmryjvtc23KFFTMc3DU/z4AAn+WZp3u3V1yLmBJzNgwpYlzBIU8A2yqT6gX2eTlvmqBw2XO6sgod9rQ5NR0IFS2dSzwAmoxFAGX35e5K+u7gpmKlVIqmt1Ef00Q12+yTPSi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762326812; c=relaxed/simple;
	bh=6buDsgkObLRHEk4bLt1U975Il0m3a8kg7vWs1HuKNt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pgY+8xilvZkZx5DvibbBcsrybHjFNO/6n4zmY/W09DF1neScA6fP/HuH427ym6RgnwF91sLzoSgcMSIGgSD5ffbwmIn7hyDOloeG9UFp5ZDgW6uPYkVFSRXrj8LqRnZv6TJB3KNz3TdBhqwhqd5abadl6ZRODci9eqx+PkJOALY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=15ehS71h; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WZqtjCmZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=15ehS71h; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WZqtjCmZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6198F1F394;
	Wed,  5 Nov 2025 07:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762326809; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O1a55L6eu+gyi8zUO1ywz4lkQc8YLbGa317PQqwBunM=;
	b=15ehS71hGPn11c1PE+qsAGqXEK9jtnSO4uwc7XoPfSf0sDhXXSCYTEgyiGjzRlDdIo0hcI
	Ixx1FTnin/4l7IALHbXQYMc15OfpwYeGb+vCpBlnu9viakTyxZe7SZwHhCDN6Q3Sh9nkCK
	yxoTY9+NrVqKV/9dFgztjGAZva6D+90=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762326809;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O1a55L6eu+gyi8zUO1ywz4lkQc8YLbGa317PQqwBunM=;
	b=WZqtjCmZw6u3IeInXtmu+NkG8A2zk2FLqmzIjqEjdFjmalz9wLFOBLXxZRVkFvJxS8TzX0
	Gmne2eel+pD5qqDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=15ehS71h;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WZqtjCmZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762326809; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O1a55L6eu+gyi8zUO1ywz4lkQc8YLbGa317PQqwBunM=;
	b=15ehS71hGPn11c1PE+qsAGqXEK9jtnSO4uwc7XoPfSf0sDhXXSCYTEgyiGjzRlDdIo0hcI
	Ixx1FTnin/4l7IALHbXQYMc15OfpwYeGb+vCpBlnu9viakTyxZe7SZwHhCDN6Q3Sh9nkCK
	yxoTY9+NrVqKV/9dFgztjGAZva6D+90=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762326809;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O1a55L6eu+gyi8zUO1ywz4lkQc8YLbGa317PQqwBunM=;
	b=WZqtjCmZw6u3IeInXtmu+NkG8A2zk2FLqmzIjqEjdFjmalz9wLFOBLXxZRVkFvJxS8TzX0
	Gmne2eel+pD5qqDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C5139132DD;
	Wed,  5 Nov 2025 07:13:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jt1/Lhj5Cmn1FgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 05 Nov 2025 07:13:28 +0000
Message-ID: <1aca72f5-df99-4277-a36b-e9d259f77afd@suse.de>
Date: Wed, 5 Nov 2025 08:13:28 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/15] btrfs: use blkdev_report_zones_cached()
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
 <20251104013147.913802-15-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251104013147.913802-15-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6198F1F394
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,wdc.com:email,suse.de:email,suse.de:mid,suse.de:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On 11/4/25 02:31, Damien Le Moal wrote:
> Modify btrfs_get_dev_zones() and btrfs_sb_log_location_bdev() to replace
> the call to blkdev_report_zones() with blkdev_report_zones_cached() to
> speed-up mount operations. btrfs_get_dev_zone_info() is also modified to
> take into account the BLK_ZONE_COND_ACTIVE condition, which is
> equivalent to either BLK_ZONE_COND_IMP_OPEN, BLK_ZONE_COND_EXP_OPEN or
> BLK_ZONE_COND_CLOSED.
> 
> With this change, mounting a freshly formatted large capacity (30 TB)
> SMR HDD completes under 100ms compared to over 1.8s before.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Acked-by: David Sterba <dsterba@suse.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/zoned.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

