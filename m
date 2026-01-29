Return-Path: <linux-btrfs+bounces-21207-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKI8FMvPemnU+gEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21207-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jan 2026 04:11:07 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B4FAB59C
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jan 2026 04:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14EF93009500
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jan 2026 03:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CFF330D29;
	Thu, 29 Jan 2026 03:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eCoWbmV6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WRyZOm3n";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eCoWbmV6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WRyZOm3n"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADB2318B91
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Jan 2026 03:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769656238; cv=none; b=tgFMIw+qifCjPKh6cirLvwkd4AyfvIbtu/xoIzrQ4Pfn57Q3qv+2jB0QtvIlgN2qbkMy5dCbXV0SNvDYK7G+8V4jwjufgOywIxNmDwmaIYGisksQCgoXaKTrq6JxtFGZ91lNgg2shBcUDmRKEAFMnJsHRaSMa+gzNvhTZSjHZis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769656238; c=relaxed/simple;
	bh=xvEeDeqQXiMkiqBQGsJ4JOc/esHlznOQrv3giRGw/8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d76+4aMslQqH/uMUYNAgfPCi79wT2TeUj6B4aVb2DhqmZt44zcjNeNOVsGczChC3UnXHP5jmvD7zXJvKjAuOfMVFz2gAjYRthOIeTyC4hCfu2q+JmnwuTaU95PxEmZEUiqBPqF33ouylwugfcBBiHgqvcp3nKV8MoPFV72EJ9UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eCoWbmV6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WRyZOm3n; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eCoWbmV6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WRyZOm3n; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CC9E833EF9;
	Thu, 29 Jan 2026 03:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769656234;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X00wGFCz/MCmsYU28CI87jzxMCOZINcaD8V1rWuMmHo=;
	b=eCoWbmV6a0tWtrQ2HNinbNFRnNyHnC4Sqr0KE2R3w5UE8WjyB2Tp1woHEpYW3fo/W30+eg
	5uPj6MiTJKgvq+9AO8Cnr3eezlPOoU+wkvaSnZS81qOiA8UtEvYIMHIn2coP/K+RDGwZBY
	fQO0SLBVBSmSZoqrSykQzlR326HUpOE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769656234;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X00wGFCz/MCmsYU28CI87jzxMCOZINcaD8V1rWuMmHo=;
	b=WRyZOm3n8kunuDNf8GsdHT686o4xB8qlEpdHVQ99K7a2twlGEjY9mfj2b7BfkSyhvxLfB3
	8cA6iCqnixTmU/CQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=eCoWbmV6;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WRyZOm3n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769656234;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X00wGFCz/MCmsYU28CI87jzxMCOZINcaD8V1rWuMmHo=;
	b=eCoWbmV6a0tWtrQ2HNinbNFRnNyHnC4Sqr0KE2R3w5UE8WjyB2Tp1woHEpYW3fo/W30+eg
	5uPj6MiTJKgvq+9AO8Cnr3eezlPOoU+wkvaSnZS81qOiA8UtEvYIMHIn2coP/K+RDGwZBY
	fQO0SLBVBSmSZoqrSykQzlR326HUpOE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769656234;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X00wGFCz/MCmsYU28CI87jzxMCOZINcaD8V1rWuMmHo=;
	b=WRyZOm3n8kunuDNf8GsdHT686o4xB8qlEpdHVQ99K7a2twlGEjY9mfj2b7BfkSyhvxLfB3
	8cA6iCqnixTmU/CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A94673EA61;
	Thu, 29 Jan 2026 03:10:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g0QqKarPemmdQgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 29 Jan 2026 03:10:34 +0000
Date: Thu, 29 Jan 2026 04:10:29 +0100
From: David Sterba <dsterba@suse.cz>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: zoned: fixup last alloc pointer after extent
 removal for RAID0/10
Message-ID: <20260129031029.GI26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20260123124136.4110463-1-naohiro.aota@wdc.com>
 <20260123124136.4110463-3-naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123124136.4110463-3-naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.21
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21207-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	RCVD_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:replyto,suse.cz:dkim]
X-Rspamd-Queue-Id: A2B4FAB59C
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 09:41:36PM +0900, Naohiro Aota wrote:
>  	u32 stripe_index = 0;
> +	bool has_partial = false, has_conventional = false;

has_partial is bool

> +		has_partial |= ((zone_info[i].alloc_offset & BTRFS_STRIPE_LEN_MASK) != 0);

And this is a bitwise operation. There's no operator ||= so this would
be better written as an 'if'

		if (condition)
			has_partial = true;

> +
>  		if (test_bit(0, active) != test_bit(i, active)) {
>  			if (unlikely(!btrfs_zone_activate(bg)))
>  				return -EIO;
> @@ -1630,24 +1746,48 @@ static int btrfs_load_block_group_raid10(struct btrfs_block_group *bg,
>  	}
>  
>  	for (int i = 0; i < map->num_stripes; i++) {
> -		if (zone_info[i].alloc_offset == WP_MISSING_DEV)
> -			continue;
> +		int idx = i / map->sub_stripes;
>  
> -		if (test_bit(0, active) != test_bit(i, active)) {
> -			if (unlikely(!btrfs_zone_activate(bg)))
> -				return -EIO;
> -		} else {
> -			if (test_bit(0, active))
> -				set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &bg->runtime_flags);
> +		if (raid0_allocs[idx] == WP_CONVENTIONAL) {
> +			has_conventional = true;
> +			raid0_allocs[idx] = btrfs_stripe_nr_to_offset(stripe_nr);
> +
> +			if (stripe_index > idx)
> +				raid0_allocs[idx] += BTRFS_STRIPE_LEN;
> +			else if (stripe_index == idx)
> +				raid0_allocs[idx] += stripe_offset;
>  		}
>  
> -		if (zone_info[i].alloc_offset == WP_CONVENTIONAL) {
> -			zone_info[i].alloc_offset = btrfs_stripe_nr_to_offset(stripe_nr);
> +		if ((i % map->sub_stripes) == 0) {
> +			/* Verification */
> +			if (i != 0) {
> +				if (prev_offset < raid0_allocs[idx]) {
> +					btrfs_err(fs_info,
> +					  "zoned: stripe position disorder found in BG %llu",
> +						  bg->start);
> +					return -EIO;
> +				}
>  
> -			if (stripe_index > (i / map->sub_stripes))
> -				zone_info[i].alloc_offset += BTRFS_STRIPE_LEN;
> -			else if (stripe_index == (i / map->sub_stripes))
> -				zone_info[i].alloc_offset += stripe_offset;
> +				if (has_partial && (raid0_allocs[idx] & BTRFS_STRIPE_LEN_MASK)) {
> +					btrfs_err(fs_info,
> +				  "zoned: multiple partial written stripe found in BG %llu",
> +						  bg->start);
> +					return -EIO;
> +				}
> +			}
> +			prev_offset = raid0_allocs[idx];
> +			has_partial |= ((raid0_allocs[idx] & BTRFS_STRIPE_LEN_MASK) != 0);

Same here. I'll update the commit in for-next.

