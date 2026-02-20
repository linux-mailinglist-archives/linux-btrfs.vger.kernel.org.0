Return-Path: <linux-btrfs+bounces-21808-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SM3YEbuEmGnKJQMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21808-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Feb 2026 16:58:51 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE5B1691F0
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Feb 2026 16:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20CAB30980E6
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Feb 2026 15:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4502034AAE3;
	Fri, 20 Feb 2026 15:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Tn0uurDU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cnrl3e2S";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Tn0uurDU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cnrl3e2S"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B9A29B78F
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Feb 2026 15:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771603093; cv=none; b=J7etqZKJ6WmQ5KB89xHEBjk7QZSrPeSEeWBbTlhUkYGpXwtrKuG1W1FcAmpzKmzc56gSUOcILbx+ddlaskzgOzBKm4jQbkuEZX6pdSDk5WRbuoHakt+9K/pMuXBYZZAsmtxeIm7iDtN6k/ubi108yB5c1gpXBuUJHbuTJWqvuyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771603093; c=relaxed/simple;
	bh=vnqq5jqn3ZJKbgpXNwBsBfRP292fnY4kTTe8+CWDOOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYDG9iyIJDP7muJnpDeLnQrKJ5nkfZIi+nzupmZf0dsyo+UA8oo5Pz0p17AL3zdg+ukIRSdZ/dBz2MBfUnBZ3v3qjRjpIPUhXVM7ynPA0W0+xHX7lb3NAUA5cvwP9pE/9pE8ddHQVERdaxNOltfD3qYVk2n/SZIXpI2f3/8p9/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Tn0uurDU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cnrl3e2S; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Tn0uurDU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cnrl3e2S; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 811C53E6C9;
	Fri, 20 Feb 2026 15:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771603084;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YB9vcWuYOHDIOhDwlp5XO1FTJbF2wB7a/MNQ8u4RPLw=;
	b=Tn0uurDU59+4jhtdnIf2Cqnqx9wIhPRNRp65O2l1n69ueiUeKY6913EoWWX0UAZ7WRhkLP
	r0iXbtgEu+L5/C9QLrJ6p1p9oB72nJ4lhBfvPJK9ozevDyMqD0sxYnqQGDUG/i+obn3PuJ
	Qb71JJEgoE/vpROq+BTfwVjw8cW47AQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771603084;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YB9vcWuYOHDIOhDwlp5XO1FTJbF2wB7a/MNQ8u4RPLw=;
	b=cnrl3e2SeWv5mYzLi9jR2E954hO3zxBbdlR+0ACOvWNaJy0ys7KIbGTLKN28s9sA+oCK2r
	sFpu3Opr7mp1uEBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Tn0uurDU;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=cnrl3e2S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771603084;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YB9vcWuYOHDIOhDwlp5XO1FTJbF2wB7a/MNQ8u4RPLw=;
	b=Tn0uurDU59+4jhtdnIf2Cqnqx9wIhPRNRp65O2l1n69ueiUeKY6913EoWWX0UAZ7WRhkLP
	r0iXbtgEu+L5/C9QLrJ6p1p9oB72nJ4lhBfvPJK9ozevDyMqD0sxYnqQGDUG/i+obn3PuJ
	Qb71JJEgoE/vpROq+BTfwVjw8cW47AQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771603084;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YB9vcWuYOHDIOhDwlp5XO1FTJbF2wB7a/MNQ8u4RPLw=;
	b=cnrl3e2SeWv5mYzLi9jR2E954hO3zxBbdlR+0ACOvWNaJy0ys7KIbGTLKN28s9sA+oCK2r
	sFpu3Opr7mp1uEBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6401D3EA65;
	Fri, 20 Feb 2026 15:58:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UEE7GIyEmGnLAgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 20 Feb 2026 15:58:04 +0000
Date: Fri, 20 Feb 2026 16:58:03 +0100
From: David Sterba <dsterba@suse.cz>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org, fdmanana@kernel.org,
	Chris Mason <clm@fb.com>
Subject: Re: [PATCH] btrfs: fix chunk map leak in btrfs_map_block() after
 btrfs_translate_remap()
Message-ID: <20260220155802.GJ26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20260220131002.6269-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220131002.6269-1-mark@harmstone.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21808-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
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
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:replyto,suse.cz:dkim,fb.com:email,harmstone.com:email,twin.jikos.cz:mid,btrfs.readthedocs.io:url]
X-Rspamd-Queue-Id: 9EE5B1691F0
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 01:09:54PM +0000, Mark Harmstone wrote:
> If the call to btrfs_translate_remap() in btrfs_map_block() returns an
> error code, we were leaking the chunk map. Fix it by jumping to out
> rather than returning directly.
> 
> Signed-off-by: Mark Harmstone <mark@harmstone.com>
> Fixes: 18ba64992871 ("btrfs: redirect I/O for remapped block groups")
> Suggested-by: Chris Mason <clm@fb.com>

If it's a but then it's Reported-by

> Link: https://lore.kernel.org/linux-btrfs/20260125125830.2352988-1-clm@meta.com/

Please sort the tags according to
https://btrfs.readthedocs.io/en/latest/dev/Developer-s-FAQ.html#ordering

as it's been for a long time and saves me editing each patch. Thanks.

