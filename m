Return-Path: <linux-btrfs+bounces-21874-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGf8HmywnWmgQwQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21874-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 15:06:36 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1C81882CE
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 15:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A7273042FD0
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 14:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4EC39E6C8;
	Tue, 24 Feb 2026 14:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RG+no8eo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9fH/K6GO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RG+no8eo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9fH/K6GO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE4237BE70
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Feb 2026 14:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771941988; cv=none; b=Mq9YVLXs23j9rdDe5EXBvT2j2kQuEUuWNg8JMW5t4kpNocQulrWPCBJ5RfqitWAe+eiVxoO1QfTOiN5N7kmsshWWITr5YqywnOZAGbdHo+aXtTWhet8pnIj2FGGJgx345ovkeLxxzcTDsIr3ZLrezJ0O0GThQSyiMEANc1mmprc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771941988; c=relaxed/simple;
	bh=TvBcfJpzeMvbOiHk9oQ4EfZpkmOrQz8dE2DSt2bi7kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovy5NocKYJV6UErJtOnLT5tdAquzGtj/A363IverBhuvjcSh9xxkv4DEal4v4wzTw61XgfZojiDjQ7KRVwOS3nNlpRDiOI0xKuRccoPZoTJqUKBafCw6OvrzUDi6UcyoHrU4FvnMTJd4MrmuJi8i5FSdpeT8imOL03FhrIzW1vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RG+no8eo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9fH/K6GO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RG+no8eo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9fH/K6GO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6CA4D3F260;
	Tue, 24 Feb 2026 14:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771941985;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j3oBHG2GcoFKoMs8xQCr7v6uWv56CCeNsrFM6xKH8z8=;
	b=RG+no8eo2FtLbaB0ZdiGc4oqeed3FEl8mFrvmsin2KVwW5BK6ILM6oOsrIPCS7UCho3eAe
	dV76cg852LC4T/7QnVabeWNpnFFUriHGhD6f/jPuMLKQ3RlpfOv/wXogLG8/oOjlK0ld2+
	4wK+4gdy347HPHK059fktCgo8sezUQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771941985;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j3oBHG2GcoFKoMs8xQCr7v6uWv56CCeNsrFM6xKH8z8=;
	b=9fH/K6GOJ5ZrU4xpPcyADfPEBNpbFVsmT2F72SLjDv0vUIyhWxW1MLhsrLQBDU9yW/2heC
	2Tdw9V73teEkxjBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771941985;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j3oBHG2GcoFKoMs8xQCr7v6uWv56CCeNsrFM6xKH8z8=;
	b=RG+no8eo2FtLbaB0ZdiGc4oqeed3FEl8mFrvmsin2KVwW5BK6ILM6oOsrIPCS7UCho3eAe
	dV76cg852LC4T/7QnVabeWNpnFFUriHGhD6f/jPuMLKQ3RlpfOv/wXogLG8/oOjlK0ld2+
	4wK+4gdy347HPHK059fktCgo8sezUQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771941985;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j3oBHG2GcoFKoMs8xQCr7v6uWv56CCeNsrFM6xKH8z8=;
	b=9fH/K6GOJ5ZrU4xpPcyADfPEBNpbFVsmT2F72SLjDv0vUIyhWxW1MLhsrLQBDU9yW/2heC
	2Tdw9V73teEkxjBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 520703EA68;
	Tue, 24 Feb 2026 14:06:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yC/PE2GwnWmpMgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 24 Feb 2026 14:06:25 +0000
Date: Tue, 24 Feb 2026 15:06:24 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: do compressed bio size roundup and zeroing in one
 go
Message-ID: <20260224140624.GU26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <5d98d50379077b98164f3b962ada7b0526e1d4bb.1771544612.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d98d50379077b98164f3b962ada7b0526e1d4bb.1771544612.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21874-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	RCVD_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 0B1C81882CE
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 10:13:38AM +1030, Qu Wenruo wrote:
> Currently we zero out all the remaining bytes of the last folio of
> the compressed bio, then round the bio size to fs block boundary.
> 
> But that is done in two different functions, zero_last_folio() to zero
> the remaining bytes of the last folio, and round_up_last_block() to
> round up the bio to fs block boundary.
> 
> There are some minor problems:
> 
> - zero_last_folio() is zeroing ranges we won't submit
>   This is mostly affecting block size < page size cases, where we can
>   have a large folio (e.g. 64K), but the fs block size is only 4K.
> 
>   In that case, we may only want to submit the first 4K of the folio,
>   the remaining range won't matter, but we still zero them all.
> 
>   This causes unnecessary CPU usage just to zero out some bytes we won't
>   utilized.
> 
> - compressed_bio_last_folio() is called twice in two different functions
>   Which in theory we only need to call it once.
> 
> Enhance the situation by:
> 
> - Only zero out bytes up to the fs block boundary
>   Thus this will reduce some overhead for bs < ps cases.
> 
> - Move the folio_zero_range() call into round_up_last_block()
>   So that we can reuse the same folio returned by
>   compressed_bio_last_folio().
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

