Return-Path: <linux-btrfs+bounces-21092-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEA9GwAteGl7oQEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21092-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 04:12:00 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 914068F6E7
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 04:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9487F3017F09
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 03:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75AC187FE4;
	Tue, 27 Jan 2026 03:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zyiccSq9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iQbNMT48";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zyiccSq9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iQbNMT48"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEA52FD1B6
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Jan 2026 03:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769483438; cv=none; b=ATt0lzIh0ay/B/TSWKHnL5yzfDrnrFFT2HR3f/xol04oTCsNBiWJdLDu+xKiWKhOqsC1pGeA2k2pxovvrVwjysEVvIdC7FpvuTiJXacfPf/vQKmgcu3jFyDnE8pOujkuSFWjSf2M3S7w9sPj4Zr+Oghcp1cOj1tBAZ6kp+bUCk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769483438; c=relaxed/simple;
	bh=/dSrMBuV1a6eGgL/ENfBv/7O2xOfCCjyx2Bi2n6qDOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BEfSfbht+I1YH8W1pjHcJlNiQjBs66itMndFIc9bsrVovKfvBC7d7Ou//ecP4/dUySkWDG9oZJK8U+lOpf/hdg79yDLyeNPiVJsf04RswxROUJHTX6lmj2/WslzFSITyoP95t5aBuTYq/yy0PPWyVcPfszPzBrjxPh/WPhCcyEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zyiccSq9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iQbNMT48; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zyiccSq9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iQbNMT48; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A2D655BCD9;
	Tue, 27 Jan 2026 03:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769483434;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JLdDfNpfZNOZq5oBaEbFafxbzJxdJjeFu8rSQyEbv4Y=;
	b=zyiccSq9wqh6RiKJmkCyP0NLBxJTsaFKw6yGl/pIS18DwmhxFo+we1kJAQDPniPbsYEocm
	9as8lRM5EYcq9+oqkIB2JYWRpgKHqYCVzjldllJeIlxCjn4Z8gc8bz+qQlAyB9qYfiacbz
	ZG8EkIVRDPs0RUCk/55RSXas5MRtLIc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769483434;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JLdDfNpfZNOZq5oBaEbFafxbzJxdJjeFu8rSQyEbv4Y=;
	b=iQbNMT48M5eYTo4pRZL48P30ZZb2Devtu5xlKynRuZvwyYeWsjLW/k8vaqBdvNmWkJ+zr+
	hcSTFOdkhTyp/fCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zyiccSq9;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iQbNMT48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769483434;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JLdDfNpfZNOZq5oBaEbFafxbzJxdJjeFu8rSQyEbv4Y=;
	b=zyiccSq9wqh6RiKJmkCyP0NLBxJTsaFKw6yGl/pIS18DwmhxFo+we1kJAQDPniPbsYEocm
	9as8lRM5EYcq9+oqkIB2JYWRpgKHqYCVzjldllJeIlxCjn4Z8gc8bz+qQlAyB9qYfiacbz
	ZG8EkIVRDPs0RUCk/55RSXas5MRtLIc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769483434;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JLdDfNpfZNOZq5oBaEbFafxbzJxdJjeFu8rSQyEbv4Y=;
	b=iQbNMT48M5eYTo4pRZL48P30ZZb2Devtu5xlKynRuZvwyYeWsjLW/k8vaqBdvNmWkJ+zr+
	hcSTFOdkhTyp/fCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 84A6113712;
	Tue, 27 Jan 2026 03:10:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nVNvH6oseGkVewAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 27 Jan 2026 03:10:34 +0000
Date: Tue, 27 Jan 2026 04:10:33 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-btrfs@vger.kernel.org, Chris Mason <clm@meta.com>
Subject: Re: [PATCH] btrfs: fix copying the flags of btrfs_bio after split
Message-ID: <20260127031033.GB26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20260126080524.612184-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126080524.612184-1-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.21
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21092-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
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
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,wdc.com:email]
X-Rspamd-Queue-Id: 914068F6E7
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 09:05:24AM +0100, Johannes Thumshirn wrote:
> When a btrfs_bio gets split, only 'bbio->csum_search_commit_root' gets
> copied to the new btrfs_bio, all the other flags don't.
> 
> Copy the rest of the flags as well.
> 
> Reported-by: Chris Mason <clm@meta.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Please add the link to the report when you add it to for-next.

