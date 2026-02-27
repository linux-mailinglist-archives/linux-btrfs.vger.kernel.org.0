Return-Path: <linux-btrfs+bounces-22036-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJ0LCD7foGk4nwQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22036-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 01:03:10 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CD11B11C2
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 01:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8123C3019CBC
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 00:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3062818A6CF;
	Fri, 27 Feb 2026 00:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FD6z12ME";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g1K3u5lm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FD6z12ME";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g1K3u5lm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81E781732
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 00:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772150579; cv=none; b=i0jOEeoAnZcAc63NGSNR5or6dlz+tysJelGzsPJV4BwE/2G71xxqURLR/cqy1Viy+yPGsTpZtrPv/Pq2PuS5v++XcS/WNq/h1tne376KehV8QiE5KB4mNB99wu/cfhLgTYzZr8b3e9eagIUd8dOzDb5MPiCIOObNVKjY14f+1kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772150579; c=relaxed/simple;
	bh=ntAueLg4f/iqopL9BkVVognNPyoGcQlrME7dRjvYKKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1LVUyt+M2Y8kofI+IGtuImJvmo6FTMJKgaTaKNcuWXL1cRcjl4+t5qIQsunZ2fWUpAbcRvIgudNbU4hdrQRfZUNfT3IFjROrLHcd7hY3w9BvDCL8nt93p/5nF/txIJA7kCd+2mZP19DL/fiNr1+TkVz2t9QJ0MuuvU/tAZ/O5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FD6z12ME; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g1K3u5lm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FD6z12ME; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g1K3u5lm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1B51C1FA93;
	Fri, 27 Feb 2026 00:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772150576;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=80YXSHPsIM+ddHzhJBaXkMeCbiAPaDJjoQSWWUNA4jM=;
	b=FD6z12MEdKudhHmnW2eArBevWgIAuR+gPBNUT4FdXVextNDtMXJI2vu8pUgU2FtngSsXv3
	ycIU7WzUIqVDs6uDdy9RU2al/GDjpXqGdjKtTTzoJb9RmbkDmeiAau+bXZv71xjElhJGEH
	hS0NbtVXmHNK7DL5XFmxJv5BbU1oNco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772150576;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=80YXSHPsIM+ddHzhJBaXkMeCbiAPaDJjoQSWWUNA4jM=;
	b=g1K3u5lm2tewfIcKpq2NYrdyHOHusxNL0iIC4hK8bVhNZ1z9kXNx8WBbSxxCEAUNcu1eBm
	3bTuRY+b2HQD/uBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772150576;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=80YXSHPsIM+ddHzhJBaXkMeCbiAPaDJjoQSWWUNA4jM=;
	b=FD6z12MEdKudhHmnW2eArBevWgIAuR+gPBNUT4FdXVextNDtMXJI2vu8pUgU2FtngSsXv3
	ycIU7WzUIqVDs6uDdy9RU2al/GDjpXqGdjKtTTzoJb9RmbkDmeiAau+bXZv71xjElhJGEH
	hS0NbtVXmHNK7DL5XFmxJv5BbU1oNco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772150576;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=80YXSHPsIM+ddHzhJBaXkMeCbiAPaDJjoQSWWUNA4jM=;
	b=g1K3u5lm2tewfIcKpq2NYrdyHOHusxNL0iIC4hK8bVhNZ1z9kXNx8WBbSxxCEAUNcu1eBm
	3bTuRY+b2HQD/uBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 021433EA69;
	Fri, 27 Feb 2026 00:02:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6BhRADDfoGnlYwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 27 Feb 2026 00:02:56 +0000
Date: Fri, 27 Feb 2026 01:02:54 +0100
From: David Sterba <dsterba@suse.cz>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org, boris@bur.io, Chris Mason <clm@fb.com>
Subject: Re: [PATCH] btrfs: read key again after incrementing slot in
 move_existing_remaps()
Message-ID: <20260227000254.GI26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20260225103610.18494-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225103610.18494-1-mark@harmstone.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22036-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	RCVD_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,fb.com:email]
X-Rspamd-Queue-Id: A2CD11B11C2
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 10:36:06AM +0000, Mark Harmstone wrote:
> Fix move_existing_remaps() so that if we increment the slot because the
> key we encounter isn't a REMAP_BACKREF, we don't reuse the objectid and
> offset of the old item.
> 
> Link: https://lore.kernel.org/linux-btrfs/20260125123908.2096548-1-clm@meta.com/
> Reported-by: Chris Mason <clm@fb.com>
> Fixes: bbea42dfb91f ("btrfs: move existing remaps before relocating block group")
> Signed-off-by: Mark Harmstone <mark@harmstone.com>

Added to for-next, thanks.

