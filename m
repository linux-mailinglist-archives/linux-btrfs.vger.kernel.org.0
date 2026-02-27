Return-Path: <linux-btrfs+bounces-22042-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YdJiK/3koGm/nwQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22042-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 01:27:41 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC9C1B1370
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 01:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73AD9304B3A7
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 00:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116F72512FF;
	Fri, 27 Feb 2026 00:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gmS37Rez";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CelsoNp/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gmS37Rez";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CelsoNp/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0BF221DB6
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 00:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772152052; cv=none; b=Gfq87s9R37EdaG+DnGxvaTd9J9qTCBwLIZiA32SuiGCLf/bgLd5QTWzU0vu1vm2K9BuRlU5aC5J7f/xX0oKi+m3udJM2UTtjUSo3SiMxLmiV7lzCgL+ROs/M+wJNHwMP4FaJRCDIlGVgL5Wwjgyk1tKQo921UxyCL/L1A7RGTGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772152052; c=relaxed/simple;
	bh=YDi3+C2tiN31Pu3ooJndMEeISG42nfMESeVGTmeWTm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6WTdVA/aPHCW8JGKdpsZ84IxdxzhhM+IDDzgCaLyaV7ZMdQDYrs1SPYN5lVT5EPByTYjvfdkLxkb2Sj4tT3rnO60ndVxz4q6zd4vU7S+2419E62aSd34Pt9lFevCZdYR045ONm1Dz2A5HLgcLNfATt1S4VWIEMR2L+v6SJhR9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gmS37Rez; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CelsoNp/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gmS37Rez; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CelsoNp/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6C3813F801;
	Fri, 27 Feb 2026 00:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772152048;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PtL5toJs7TckBKLS/lrNqdOKGab6SUI4Yf9GY6SSgps=;
	b=gmS37RezhnMVrqNvcU1RbHhzx/HECbAJhQKN2oWhs1bQxLT7OcuwYf5hztmAqhJ4ajERCa
	UGjKmfbboVzCJn5QhqXvbFkxjeCnxSuKSdtoEJmpn4QbPNKVYFyRXp9OvB9ODGJokZ0h+R
	hVLRYqxBOf9QP+ljWf/8S3mez/aMKMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772152048;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PtL5toJs7TckBKLS/lrNqdOKGab6SUI4Yf9GY6SSgps=;
	b=CelsoNp/Wj7dbRIx1cenX2qMfWcFgdQd+VeyeFUEubO8PPLfWTE5kros9AZ2sdHorw/Eh8
	Imw+TxZ4gVbHSyCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gmS37Rez;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="CelsoNp/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772152048;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PtL5toJs7TckBKLS/lrNqdOKGab6SUI4Yf9GY6SSgps=;
	b=gmS37RezhnMVrqNvcU1RbHhzx/HECbAJhQKN2oWhs1bQxLT7OcuwYf5hztmAqhJ4ajERCa
	UGjKmfbboVzCJn5QhqXvbFkxjeCnxSuKSdtoEJmpn4QbPNKVYFyRXp9OvB9ODGJokZ0h+R
	hVLRYqxBOf9QP+ljWf/8S3mez/aMKMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772152048;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PtL5toJs7TckBKLS/lrNqdOKGab6SUI4Yf9GY6SSgps=;
	b=CelsoNp/Wj7dbRIx1cenX2qMfWcFgdQd+VeyeFUEubO8PPLfWTE5kros9AZ2sdHorw/Eh8
	Imw+TxZ4gVbHSyCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4AB953EA69;
	Fri, 27 Feb 2026 00:27:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pQULEvDkoGmaewAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 27 Feb 2026 00:27:28 +0000
Date: Fri, 27 Feb 2026 01:27:27 +0100
From: David Sterba <dsterba@suse.cz>
To: Miquel =?iso-8859-1?Q?Sabat=E9_Sol=E0?= <mssola@mssola.com>
Cc: dsterba@suse.com, clm@fb.com, naohiro.aota@wdc.com, kees@kernel.org,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: replace kcalloc() calls to kzalloc_objs()
Message-ID: <20260227002727.GJ26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20260224214544.562283-1-mssola@mssola.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260224214544.562283-1-mssola@mssola.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22042-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[suse.cz:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[suse.cz];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	RCVD_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,twin.jikos.cz:mid]
X-Rspamd-Queue-Id: CBC9C1B1370
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 10:45:44PM +0100, Miquel Sabaté Solà wrote:
> Commit 2932ba8d9c99 ("slab: Introduce kmalloc_obj() and family")
> introduced, among many others, the kzalloc_objs() helper, which has some
> benefits over kcalloc(). Namely, internal introspection of the allocated
> type now becomes possible, allowing for future alignment-aware choices
> to be made by the allocator and future hardening work that can be type
> sensitive. Dropping 'sizeof' comes also as a nice side-effect.
> 
> Moreover, this also allows us to be in line with the recent tree-wide
> migration to the kmalloc_obj() and family of helpers. See
> commit 69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj for
> non-scalar types").
> 
> Reviewed-by: Kees Cook <kees@kernel.org>
> Signed-off-by: Miquel Sabaté Solà <mssola@mssola.com>

Added to for-next, thanks.

> -	buf = kcalloc(map->num_stripes, sizeof(u64), GFP_NOFS);
> +	buf = kzalloc_objs(*buf, map->num_stripes, GFP_NOFS);

> -	pointers = kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
> -	unmap_array = kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
> +	pointers = kzalloc_objs(*pointers, rbio->real_stripes, GFP_NOFS);
> +	unmap_array = kzalloc_objs(*unmap_array, rbio->real_stripes, GFP_NOFS);

> -	pointers = kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
> -	unmap_array = kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
> +	pointers = kzalloc_objs(*pointers, rbio->real_stripes, GFP_NOFS);
> +	unmap_array = kzalloc_objs(*unmap_array, rbio->real_stripes, GFP_NOFS);

I've changed it to the type in the above cases so it's a direct
conversion that only removes the sizeof(). For the rest there are no
strong preferences so we'll keep it as is, and my preference for new code
is to use the types.

