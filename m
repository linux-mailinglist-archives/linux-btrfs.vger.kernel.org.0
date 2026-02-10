Return-Path: <linux-btrfs+bounces-21614-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKYCGXqAi2m+UwAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21614-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 20:01:14 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C83FC11E7A7
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 20:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC7DC303FF26
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 19:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0E42874F5;
	Tue, 10 Feb 2026 19:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q51IOO6X";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3GYDLMND";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PDp5ryaB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3VpAjq9N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F63E1F03EF
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 19:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770750049; cv=none; b=NGyNrsMus+cmRIF7A13eonIjMPTrQulEsDAgWo3yQMz3NWuPwQO6rz/YANYnDkxlPrd0yfBHJtCZZoXP9hogF2El7TgdE+b5UapOSCcmnwQ4dO0IAtVTLBQafj9pPS44a6w6j+5stKBtLLZ8DckkIET0fdOGyF4bCAm/gGJXlwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770750049; c=relaxed/simple;
	bh=giwq7FCRKAM2RN9y68DwNxUkXJmcjTbLyMjzreG6oOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEaV6zPG//83Bj+kox8FbwaODT2MVN6fHOWgiHsHOK0aVyrwH7PufaDiZMLJN9bzrqMTbYN4RUewE1m1MPOAm8ITWAn4niN5wye82EjgV9xw/O9vcRVBFQvSR24FObolKv1uM8tGE5jyFneHMHgiBjk7o0ECJFP3dyTKCcvnmNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q51IOO6X; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3GYDLMND; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PDp5ryaB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3VpAjq9N; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 50C895BD7B;
	Tue, 10 Feb 2026 19:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770750039;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JZib4ShoqtVZS38Lh2TVUDA2Qh9bVPu0T7SSVWXYdT0=;
	b=Q51IOO6XRFLN3O35n4jfmCunjHWF/QpG7GGw5oVExaHL4Og4LHtRN6H3+/oLClQ+V0xUB0
	miO1QZZq3N5wLpwdyAHYfiSHBhAO7Af6tBr3HcDrnjkrsiXVaNbydXmOHh3i3PyG5TzzcE
	Q+tfg9ZOZ7S7bNna7tcSIKEAprmmgN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770750039;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JZib4ShoqtVZS38Lh2TVUDA2Qh9bVPu0T7SSVWXYdT0=;
	b=3GYDLMND9Snzw6srpsNZS0nZN0MTQZEXwxDDI8sZlFtcWVVLQc6nfU3zwClzQyH2A5WWQF
	PDUJOoEtF9j9GxAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=PDp5ryaB;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3VpAjq9N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770750038;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JZib4ShoqtVZS38Lh2TVUDA2Qh9bVPu0T7SSVWXYdT0=;
	b=PDp5ryaBMXTBb481++utz1r/8IfGbqhLkRIZu/w0Oz7Q0Pv6Lnop8KhybiaU4gz1TRhUVA
	XDpusy7P3wzPtV7oGFrM4YWOfkczQ/n8Ocxlv3ivpExrnQ5X/Ll3D5Fdm5NjMCJRIoFw/U
	Uz9FkCbzggyi3RpUBdaNMX4TmBtvlko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770750038;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JZib4ShoqtVZS38Lh2TVUDA2Qh9bVPu0T7SSVWXYdT0=;
	b=3VpAjq9N7F2FVZXLNXMAQDFE9JInmwZVHwYCcwzgbmwrXVIrXhWr34jkBXssjw19nWk51E
	bDgKJHIvSDsrolAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 387163EA62;
	Tue, 10 Feb 2026 19:00:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OrabDVaAi2k2EgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 10 Feb 2026 19:00:38 +0000
Date: Tue, 10 Feb 2026 20:00:37 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove pointless WARN_ON() in cache_save_setup()
Message-ID: <20260210190037.GC26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <3564f83a19c18e63f7382bf234b7fb610e454cc1.1770733555.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3564f83a19c18e63f7382bf234b7fb610e454cc1.1770733555.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.21
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
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21614-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	RCVD_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,suse.cz:replyto,suse.cz:dkim,twin.jikos.cz:mid]
X-Rspamd-Queue-Id: C83FC11E7A7
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 02:27:27PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> This WARN_ON(ret) is never executed since the previous if statement makes
> us jump into the 'out_put' label when ret is not zero. The existing
> transaction abort inside the if statement also gives us a stack trace,
> so we don't need to move the WARN_ON(ret) into the if statement either.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

