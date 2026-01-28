Return-Path: <linux-btrfs+bounces-21151-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CE/qIvqZeWkNxwEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21151-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 06:09:14 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A46389D284
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 06:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 25D05300728E
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 05:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8433B3346A0;
	Wed, 28 Jan 2026 05:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YhcmgE+o";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kwQyzwBY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YhcmgE+o";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kwQyzwBY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1561233065D
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Jan 2026 05:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769576948; cv=none; b=cO+lQB3MibizmMvKuCcirTPrML0TfIljQop5nYQprO9KC+Qm8iNlrBHtYVEwezVxms1GoYsz2iOyTBkLUIduQvQlhWxsk6Gxq+nMY3aPwoPqYfOMXXctfcSakEmJz9TzbYB/qO4atEfbQyQwfCaP1offUaTlbMVJN+v3qi2PBsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769576948; c=relaxed/simple;
	bh=VkD8w9wGRKsnIW8qtg+100HOPgBxkvx8LdKT4CRtvb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3siShjLHQSvFH+C/VspV3lR44jlBPEapcjzfrR3JWE8dMHegU8yIg7BBHy1gdJFSH0tAfM6zC2qc34zOxXJftFPK4suoFlttcgew4vbTQ2jWAGyEqVQst+hyNr9dFHDjj+CGRqN4nt2yepYpYvNoG3b0l4fMyXH/86JBlBX8m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YhcmgE+o; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kwQyzwBY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YhcmgE+o; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kwQyzwBY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1BF415BCDF;
	Wed, 28 Jan 2026 05:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769576945;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I8RfHQFEBEblEukY1vsqZUmFkhKi6vJfNRRY31tRK7w=;
	b=YhcmgE+oY+pLnSAiiYdZBGQSwekmVYdjIVRjC1wYXD1SqGOMbbXy7/0E/JKtM6CucUQ//n
	Hv/WYltMfePR7m5M/HmoxGhRo3CGNwqQdNlC4B54CFxiMvKgBjtZQL3NQ3O9WWEbjVwi80
	TMxUtSZWZxW7SFR2ixA1Ukk/Pk2p+X0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769576945;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I8RfHQFEBEblEukY1vsqZUmFkhKi6vJfNRRY31tRK7w=;
	b=kwQyzwBYR1ov8u6U/BDUyY6IRTvFOi/M0Y0M0vuluPg3wYc6KXTUx4WEIiLONbROrn7QYO
	MxaibUxvgkS+9EBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769576945;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I8RfHQFEBEblEukY1vsqZUmFkhKi6vJfNRRY31tRK7w=;
	b=YhcmgE+oY+pLnSAiiYdZBGQSwekmVYdjIVRjC1wYXD1SqGOMbbXy7/0E/JKtM6CucUQ//n
	Hv/WYltMfePR7m5M/HmoxGhRo3CGNwqQdNlC4B54CFxiMvKgBjtZQL3NQ3O9WWEbjVwi80
	TMxUtSZWZxW7SFR2ixA1Ukk/Pk2p+X0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769576945;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I8RfHQFEBEblEukY1vsqZUmFkhKi6vJfNRRY31tRK7w=;
	b=kwQyzwBYR1ov8u6U/BDUyY6IRTvFOi/M0Y0M0vuluPg3wYc6KXTUx4WEIiLONbROrn7QYO
	MxaibUxvgkS+9EBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D97AA3EA61;
	Wed, 28 Jan 2026 05:09:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id itprNPCZeWn/aQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 28 Jan 2026 05:09:04 +0000
Date: Wed, 28 Jan 2026 06:09:03 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 0/9] btrfs: used compressed_bio structure for read and
 write
Message-ID: <20260128050903.GD26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1769566870.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1769566870.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -8.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21151-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	RCVD_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.cz:replyto,suse.cz:dkim,twin.jikos.cz:mid]
X-Rspamd-Queue-Id: A46389D284
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 01:06:59PM +1030, Qu Wenruo wrote:
> I was never a huge fan of the current btrfs_compress_folios() interface:
> 
> - Complex and duplicated parameter list
> 
>   * A folio array to hold all folios
>     Which means extra error handling.
> 
>   * A @nr_folios pointer
>     That pointer is both input and output, representing the number of max
>     folios, but also the number of compressed folios.
> 
>     The number of input folios is not really necessary, it's always no
>     larger than DIV_ROUND_UP(len, PAGE_SIZE) in the first place.
> 
>   * A @total_in pointer
>     Again an pointer as both input and output, representing the filemap
>     range length, and how many bytes are compressed in this run.
> 
>     However if we failed to compress the full range, all supported
>     algorithms will return an error, thus fallback to uncompressed path.
> 
>     Thus there is no need to use it as an output pointer.
> 
>   * A @total_compressed point
>     Again an pointer as both input and output, representing the max
>     number of compressed size, and the final compressed size.
> 
>     However we do not need it as an input at all, we always error out
>     if the compressed size is larger than the original size.
> 
> - Extra error cleanup handling
> 
>   We need to cleanup the compressed_folios[] array during error
>   handling.
> 
> Replace the old btrfs_compress_folios() interface with
> btrfs_compress_bio(), which has the following benefits:
> 
> - Simplified parameter list
> 
>   * inode
>   * start
>   * len
>   * compress_type
>   * compress_level 
>   * write_flags
> 
>     No parameter is sharing input and output members, and all are very
>     straightforward (except the last write_flags, which is just an extra
>     bio flag).
> 
> - Directly return a compressed_bio structure
> 
>   With minor modifications, that pointer can be passed to
>   btrfs_submit_bio().
> 
>   The caller still needs to do proper round up and fill the proper
>   disk_bytenr/num_bytes before submission.
> 
>   And for error handling, simply call cleanup_compressed_bio() then
>   everything is cleaned up properly (at least I hope so).
> 
> - No more extra folios array passing and error handling
> 
> 
> Qu Wenruo (9):
>   btrfs: introduce lzo_compress_bio() helper
>   btrfs: introduce zstd_compress_bio() helper
>   btrfs: introduce zlib_compress_bio() helper
>   btrfs: introduce btrfs_compress_bio() helper
>   btrfs: switch to btrfs_compress_bio() interface for compressed writes
>   btrfs: remove the old btrfs_compress_folios() infrastructures
>   btrfs: get rid of compressed_folios[] usage for compressed read
>   btrfs: get rid of compressed_folios[] usage for encoded writes
>   btrfs: get rid of compressed_bio::compressed_folios[]

A big rework but the end result looks good and it's a net improvement,
namely removing the folio array allocation from the IO paths. I've seen
a lot of code copied from the existing implementations, with the adapted
code to the newly used interfaces. We can still take it to 6.20, though
there are only a few days to decide. Tests of v4 look good so far, I'll
put the series to linux-next.

