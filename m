Return-Path: <linux-btrfs+bounces-20971-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEcYJDL5c2mf0gAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20971-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 23:41:54 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D0B7B355
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 23:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA788301AA7D
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 22:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56742D0601;
	Fri, 23 Jan 2026 22:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="r3/ovzge";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="y6O5EQtv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fi+bWHl9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jNVorIaE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B447C1DF75D
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Jan 2026 22:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769208103; cv=none; b=J+akeV1FujtwVaYJpGkNwte7KOvBJXNMtYDSknR2mtO2t1u2F/6uO+x0hCeFFQsVDBzbR5d70wUnDoHd/3rGAdLg/WFGy3oxY3TGYn1Ma/s1+xtcqytjecAC1XggovUqG7Y8PBIsw1NXd4KOmYUG4vsfEO+omJOFi27sOb+Jm2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769208103; c=relaxed/simple;
	bh=hxkmj97tl3p6m2MfyIdIOaAJLjvaA0VAPrNv9G+gzlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNaZ2ERjvMsrc8OXE/TrNe7+TK+Iln6m9dSlR4VYscLVLlBSjglpu7y5ORpvJ5Pr1KMng2D5kEkv2ez2LbQXDUo/q3wdyYWEnqG9ma4tQxUSp0LH8GHBLRlRKQ6r6MUD3xsbs/UzfB5AnrOV9sFEFNhsQXm9LYMBpoFbR19TTe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=r3/ovzge; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=y6O5EQtv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fi+bWHl9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jNVorIaE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CFA0D5BCD3;
	Fri, 23 Jan 2026 22:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769208100;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KJS1FBbzAT8IJE95hpfCMbgvs9DkvJefpUJ7ubrYYS4=;
	b=r3/ovzgeExDrPWestmucOv0Tjy5NFvfVrZdMlnJ1K3/89UjrqAXGtYshFzfMCqo/458qFP
	24N6s6H5HSsR+8cb2y08vtS7PwQb32y2w18OsiFbUtBmVahX4e5PGkcblIv3d1W3pQoH2u
	5lLX/EvwbyHVa8I/sVDKVSpYc5/W9hM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769208100;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KJS1FBbzAT8IJE95hpfCMbgvs9DkvJefpUJ7ubrYYS4=;
	b=y6O5EQtvO7DUxosrSIZqTx53fP4nJY5UDG26ISlt9zJWIYQ2+3UmvBrzjA9JxNLpys0+hc
	kdfEQl4koVP88NDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769208099;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KJS1FBbzAT8IJE95hpfCMbgvs9DkvJefpUJ7ubrYYS4=;
	b=fi+bWHl9XH5xmNuXBafjpraeLLTe5e5MNfr52QU4DY/gIWPTYvYlFzU7+T3O3ZGfAatEQd
	7ytTBvgTew1/800S8ItgqDb06k7eSf0sDMUbHwzJ3e9aqi1oAMdFvho41efXE8c6p2CHAX
	cjSq7MwATxuDETMDBu9F6KklG186l9E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769208099;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KJS1FBbzAT8IJE95hpfCMbgvs9DkvJefpUJ7ubrYYS4=;
	b=jNVorIaEtbhlCbZFFIo1bLYaTGkHteX6GzlVhd5YveXjGhpfvvvCqbtuOP/gmsDriuVJZX
	y0xdZH5iZ4fddVAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B4DD81395E;
	Fri, 23 Jan 2026 22:41:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2KH3KyP5c2kVAgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 23 Jan 2026 22:41:39 +0000
Date: Fri, 23 Jan 2026 23:41:34 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH] btrfs-progs: zoned: fix loading of DUP block-groups with
 mismatching alloc_offsets
Message-ID: <20260123224134.GW26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20260123081428.473986-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123081428.473986-1-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20971-lists,linux-btrfs=lfdr.de];
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
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,twin.jikos.cz:mid]
X-Rspamd-Queue-Id: 36D0B7B355
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 09:14:28AM +0100, Johannes Thumshirn wrote:
> When loading DUP block-groups where one of the backing zones is on a
> conventional zone and one is on a sequential zone,
> btrfs_load_block_group_dup() returns with -EIO as the allocation offsets
> of both block-groups differ.
> 
> In case only one zone is conventional and the other zone is sequential,
> set the alloc_offset to the write pointer location of the sequential
> zone.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Added to devel, thanks.

