Return-Path: <linux-btrfs+bounces-21879-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gF3fFWm4nWmQRQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21879-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 15:40:41 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B01E8188803
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 15:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A4C03152F72
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 14:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D32A39E6F7;
	Tue, 24 Feb 2026 14:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KOzfG96m";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ch2iOmjf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KOzfG96m";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ch2iOmjf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF8339B490
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Feb 2026 14:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771943755; cv=none; b=LzppJPmzWbDzZXmd5Rf3smxLChkbb8vQCqyLZ/lkaX41Loeik/mSEEdTQfnd5GfPz2Tp0nhAJ54+hYpWbuEPZ72kfTzSkD79jP5ECsfwXjWOIQG4N9phWG9q7v7PZaFkET45h995PXBhypQRGFNBEf6c/hzOaVegt29UHZhESAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771943755; c=relaxed/simple;
	bh=WOBHhEjihVDOQ8bnWGkzSsgTHaakZqeI5St+wsjfrSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jq/rpsbGCwtBs1O1HDuY1hv1kdKmkMPNzY9SpGHz65zwFX1sfOE7yE5gKobTQixSMo6u80Li39fgLwA6p/wZz5g6asN1CHdHOHRuS6C2d5AL1WqZ4YhRXoAGSDfYw4yDHO9hHzLZN0MLsmcCJ8VzBuBurOPbrbj0jW0rhbg7GvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KOzfG96m; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ch2iOmjf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KOzfG96m; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ch2iOmjf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5057A5BCE4;
	Tue, 24 Feb 2026 14:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771943752;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Y++uy/5PEEJcAKVz4nc6/vYJaw6h4RfpqBgL0HYXa0=;
	b=KOzfG96mePFCPgDTfu8wZnnieTCj0+QhAAKtKrIu4AExv0mS41WU6YP3ZmvvyGLIVSkTP+
	9Nh8TXsNynGTrGgO060B70idjTpiK1VWG6LHvMD3NBtx0nNas9EQMtP/tNGoZmLTKxW1Zp
	JYImI++BkN/YhETHy6DnH8lzRV0Uyw0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771943752;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Y++uy/5PEEJcAKVz4nc6/vYJaw6h4RfpqBgL0HYXa0=;
	b=Ch2iOmjfUw0x330Cnc5oCsD+WrHMm6/NH0Mg/Gb8NmbuHLxzGAQ0UjwYT/571M9MwplGhQ
	iy36U13lbR0W7aCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771943752;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Y++uy/5PEEJcAKVz4nc6/vYJaw6h4RfpqBgL0HYXa0=;
	b=KOzfG96mePFCPgDTfu8wZnnieTCj0+QhAAKtKrIu4AExv0mS41WU6YP3ZmvvyGLIVSkTP+
	9Nh8TXsNynGTrGgO060B70idjTpiK1VWG6LHvMD3NBtx0nNas9EQMtP/tNGoZmLTKxW1Zp
	JYImI++BkN/YhETHy6DnH8lzRV0Uyw0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771943752;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Y++uy/5PEEJcAKVz4nc6/vYJaw6h4RfpqBgL0HYXa0=;
	b=Ch2iOmjfUw0x330Cnc5oCsD+WrHMm6/NH0Mg/Gb8NmbuHLxzGAQ0UjwYT/571M9MwplGhQ
	iy36U13lbR0W7aCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 34F003EA68;
	Tue, 24 Feb 2026 14:35:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vkfADEi3nWmuUgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 24 Feb 2026 14:35:52 +0000
Date: Tue, 24 Feb 2026 15:35:51 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: reduce the size of compressed_bio
Message-ID: <20260224143550.GW26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1771558832.git.wqu@suse.com>
 <49989e5c6c08710861a59af5d3b5148d2978e480.1771558832.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49989e5c6c08710861a59af5d3b5148d2978e480.1771558832.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21879-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	RCVD_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,twin.jikos.cz:mid,suse.cz:replyto,suse.cz:dkim]
X-Rspamd-Queue-Id: B01E8188803
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 02:11:51PM +1030, Qu Wenruo wrote:
> The member compressed_bio::compressed_len can be replaced by the bio
> size, as we always submit the full compressed data without any partial
> read/write.
> 
> Furthermore we already have enough ASSERT()s making sure the bio size
> matches the ordered extent or the extent map.
> 
> This saves 8 bytes from compressed_bio:
> 
> Before:
> 
>  struct compressed_bio {
>         u64                        start;                /*     0     8 */
>         unsigned int               len;                  /*     8     4 */
>         u8                         compress_type;        /*    12     1 */
>         bool                       writeback;            /*    13     1 */
> 
>         /* XXX 2 bytes hole, try to pack */
> 
>         struct btrfs_bio *         orig_bbio;            /*    16     8 */
>         struct btrfs_bio           bbio __attribute__((__aligned__(8))); /*    24   304 */
> 
>         /* XXX last struct has 1 bit hole */
> 
>         /* size: 328, cachelines: 6, members: 6 */
>         /* sum members: 326, holes: 1, sum holes: 2 */
>         /* member types with bit holes: 1, total: 1 */
>         /* forced alignments: 1 */
>         /* last cacheline: 8 bytes */
> } __attribute__((__aligned__(8)));

Nice and I think we can't do much better here. Two bytes left for flags
if needed.

Reviewed-by: David Sterba <dsterba@suse.com>

