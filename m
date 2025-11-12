Return-Path: <linux-btrfs+bounces-18895-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A29F8C5367E
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 17:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B418E351180
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 16:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48B033AD8A;
	Wed, 12 Nov 2025 16:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Axd4WT4j";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5jxmSTG2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Axd4WT4j";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5jxmSTG2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6302D3233
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Nov 2025 16:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762964682; cv=none; b=Zc9Gq7Vg9nejD8zc8ivzWn68BZ+neEBZYRPnWt8T8BTqPdLa4iPBc7jK6nm1ocKTDi4gyx7a7EQR0xHf+rLvujQUevzYB3YHxFM9Qfq2hK7et47UHzCHqYgfjShcDv5Nai7b2keEAcbGHdH6HwvBDZfd/2il6BUK4KbuO6iMwB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762964682; c=relaxed/simple;
	bh=eQhRA7lEZIQ/mtI9ilVllaHzveXwoNdQ1MmVCzjS9U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RsuUJXqNNAfcrSFQwc+uSUzBFsG7BD/BjwaVj7zaMLfmocmSSUtAlUMFPkVt2KAw8CNKawnGPDcannmiegZXiktDJoPfwiOM7AFV4me+vFpVzNFYOhJon4xjbgLsGMilYNs4rp3f3rchHeQE8/LijxoZZZ1isTrURG5hA58A8TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Axd4WT4j; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5jxmSTG2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Axd4WT4j; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5jxmSTG2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 812DC1F393;
	Wed, 12 Nov 2025 16:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762964678;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Z+26c7MnxcJKEut5Z75ReTlz6zphc2tURntNVUsqao=;
	b=Axd4WT4jb0czOWocsuCb1josxe2HKOGz/vnWuLs/+nUKs/VMg/c16JcnszTWIZ8RlLs4KA
	ulucQylpkNydw2GWG42XuCHjSjR60mxSEEO8t8O25KUXQNL50k3XH2bYajOjpBFS60l2Bh
	KjZ+LDyuL+O7qXTm2EbvHUlNLxBWcUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762964678;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Z+26c7MnxcJKEut5Z75ReTlz6zphc2tURntNVUsqao=;
	b=5jxmSTG2Q6IvmQ9lUSZS+GsJCImLNwi/sS+mB0DMCXD5arBrvsIsV55nTD48f2BcrrMIZ0
	76XOspXodhBoEwAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Axd4WT4j;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5jxmSTG2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762964678;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Z+26c7MnxcJKEut5Z75ReTlz6zphc2tURntNVUsqao=;
	b=Axd4WT4jb0czOWocsuCb1josxe2HKOGz/vnWuLs/+nUKs/VMg/c16JcnszTWIZ8RlLs4KA
	ulucQylpkNydw2GWG42XuCHjSjR60mxSEEO8t8O25KUXQNL50k3XH2bYajOjpBFS60l2Bh
	KjZ+LDyuL+O7qXTm2EbvHUlNLxBWcUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762964678;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Z+26c7MnxcJKEut5Z75ReTlz6zphc2tURntNVUsqao=;
	b=5jxmSTG2Q6IvmQ9lUSZS+GsJCImLNwi/sS+mB0DMCXD5arBrvsIsV55nTD48f2BcrrMIZ0
	76XOspXodhBoEwAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6004F3EA61;
	Wed, 12 Nov 2025 16:24:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Upo/F8a0FGkkKAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 12 Nov 2025 16:24:38 +0000
Date: Wed, 12 Nov 2025 17:24:37 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 0/4] btrfs: enable encoded read/write/send for bs > ps
 cases
Message-ID: <20251112162437.GF13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1762814274.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1762814274.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 812DC1F393
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.21

On Tue, Nov 11, 2025 at 09:11:57AM +1030, Qu Wenruo wrote:
> [CHANGELOG]
> v4:
> - Rebased to the latest for-next branch
>   The new async-csum is causing conflicts related to
>   btrfs_csum_one_bio() and how to grab fs_info from compressed_bio.
> 
> v3:
> - Fix a bug in btrfs_repair_eb_io_failure() for nodesize < ps cases
>   In that case, we only need a single paddr slot, but a larger step
>   (nodesize instead of sectorsize).
>   Add a new @step parameter to btrfs_repair_io_failure() to handle this
>   special situation.
> 
> v2:
> - Fix smatch warnings
>   Mostly remove any ASSERT()s checking returned value of bio_alloc().
> 
> - Fix a bug in the btrfs_add_compressed_bio_folios()
>   Where the function still assumes large folios, but now we can have
>   regular folios.
> 
> 
> Previously encoded read/write/send is disabled for bs > ps cases,
> because they are either using regular pages or kvmallocated memories as
> buffer.
> 
> This means their buffers do not meet the folio size requirement (each 
> folio much contain at least one fs block, no block can cross large folio
> boundries).
> 
> 
> This series address the limits by allowing the following functionalities
> to support regular pages, without relying on large folios:
> 
> - Checksum calculation
>   Now instead of passing a single @paddr which is ensured to be inside a
>   large folio, an array, paddrs[], is passed in.
> 
>   For bs <= ps cases, it's still a single paddr.
> 
>   For bs > ps cases, we can accept an array of multiple paddrs, that
>   represents a single fs block.
> 
> - Read repair
>   Allow btrfs_repair_io_failure() to submit a bio with multiple
>   incontiguous pages.
> 
>   The same paddrs[] array building scheme.
> 
>   But this time since we need to submit a bio with multiple bvecs, we
>   can no longer use the current on-stack bio.
> 
>   This also brings a small improvement for metadata read-repair, we can
>   submit the whole metadata block in one go.
> 
> - Comprssed bio folios submission
>   Now the function btrfs_add_compressed_bio_folios() can handle both
>   large and regular folios, even handling different sized folios in the
>   array.
> 
> - Read verification
>   Just build the paddrs[] array for bs > ps cases and pass the array
>   into btrfs_calculate_block_csum_folio().
> 
> Unfortunately since there is no reliable on-stack VLA support, we have
> to pay the extra on-stack memory (128 bytes for x86_64, or 8 bytes for
> 64K page sized systems) everywhere, even if 99% of the cases our block
> size is no larger than page size.
> 
> The remaining part of full bs > ps support is:
> 
> - Direct IO support for bs > ps
>   This depends on a patch that is going through iomap/vfs tree instead.
>   Thus that part will only go through the v6.19 cycle
> 
> - RAID56 support
>   Which depends on the follow series which reduces btrfs_raid_bio size:
>   https://lore.kernel.org/linux-btrfs/cover.1759984060.git.wqu@suse.com/
> 
> Qu Wenruo (4):
>   btrfs: make btrfs_csum_one_bio() handle bs > ps without large folios
>   btrfs: make btrfs_repair_io_failure() handle bs > ps cases without
>     large folios
>   btrfs: make read verification handle bs > ps cases without large
>     folios
>   btrfs: enable encoded read/write/send for bs > ps cases

This looks good, thanks.  Please add it to for-next.

