Return-Path: <linux-btrfs+bounces-12327-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16721A651E4
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 14:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84B843A694F
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 13:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC24723F39A;
	Mon, 17 Mar 2025 13:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KncC3r63";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rlfS7ilL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KncC3r63";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rlfS7ilL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EE023771E
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 13:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742219711; cv=none; b=W7/WZNvGs0o/f84MkI+vJZj0iQ8GsoNe+XhwCpUkzfVZfGkiUVs595r0n7HG+wCuZKBu7kRtmzmtxdf7TerWVJbP5nOa65Dc5U/SyyNa50mvFRhKJEax5mdXhl/dBNYAj8+Lw3/+SBY4j3+OSjxB5vjaxsjMyRZ6RwiqUWfHgew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742219711; c=relaxed/simple;
	bh=+CJ1zU+SN8X2lfXfdcV8W6g+1RBR6fu75YDUsA8DIEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/wBp07zO+r7t2LzKaOx0/U0XfYpazN857LvokNVU6kkL3utirPwK+ye+5X6v2ILHZ8PvwlH8wxCofUI6niDhKDdrxSryIJ3E4Md9OYkyyrkJ+FjSRIO/hvzUWyX84I5w0EBwwufBTG0ZIBTvJsCjsVkEwyRdTUguwfhOW2goZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KncC3r63; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rlfS7ilL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KncC3r63; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rlfS7ilL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8BB3121D94;
	Mon, 17 Mar 2025 13:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742219707;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wE+GM3ssuTEYUbx4OK1/XIBSE90vAzh0Ricbf3lHXhE=;
	b=KncC3r63L8pXfv3fZrQGLRbw0dCaWr1jDKMNaEzFDe4tOOMj5lkLoRRITs3D1vbxe8kkq7
	yLS8VfjFaz57XXv5boctIS0+OYHeKZDeXMtDrViRenOUkPg7aJsslF/521GqwKBANiKeQD
	pUR4nQQfYCfWyzDJp0aFoXKhtuTNQlA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742219707;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wE+GM3ssuTEYUbx4OK1/XIBSE90vAzh0Ricbf3lHXhE=;
	b=rlfS7ilL3nJu3/crkCxQfTVH3lpPDAMQ5iNcqkGQgEFwvuE/W3mN3Jnw+uxSKaSdPb5itn
	fzVJSWEQHD9J2LCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742219707;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wE+GM3ssuTEYUbx4OK1/XIBSE90vAzh0Ricbf3lHXhE=;
	b=KncC3r63L8pXfv3fZrQGLRbw0dCaWr1jDKMNaEzFDe4tOOMj5lkLoRRITs3D1vbxe8kkq7
	yLS8VfjFaz57XXv5boctIS0+OYHeKZDeXMtDrViRenOUkPg7aJsslF/521GqwKBANiKeQD
	pUR4nQQfYCfWyzDJp0aFoXKhtuTNQlA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742219707;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wE+GM3ssuTEYUbx4OK1/XIBSE90vAzh0Ricbf3lHXhE=;
	b=rlfS7ilL3nJu3/crkCxQfTVH3lpPDAMQ5iNcqkGQgEFwvuE/W3mN3Jnw+uxSKaSdPb5itn
	fzVJSWEQHD9J2LCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F051132CF;
	Mon, 17 Mar 2025 13:55:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QsScGrsp2GfNYwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 17 Mar 2025 13:55:07 +0000
Date: Mon, 17 Mar 2025 14:55:02 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/9] btrfs: remove ASSERT()s for folio_order() and
 folio_test_large()
Message-ID: <20250317135502.GW32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1742195085.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1742195085.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -8.00
X-Spamd-Result: default: False [-8.00 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Mar 17, 2025 at 05:40:45PM +1030, Qu Wenruo wrote:
> [CHANGELOG]
> v3:
> - Prepare btrfs_end_repair_bio() to support larger folios
>   Unfortunately folio_iter structure is way too large compared to
>   bvec_iter, thus it's not a good idea to convert bbio::saved_iter to
>   folio_iter.
> 
>   Thankfully it's not that complex to grab the folio from a bio_vec.
> 
> - Add a new patch to prepare defrag for larger data folios

I was not expecting v3 as the series was in for-next so I did some edits
to changelogs, namely changing 'larger folios' -> 'large folios' as this
is how it's called in MM. Although technically the folios are larger I'd
like to keep using the same terminology.

There are new patches so feel free to replace the whole series, I'm
going to do a pass over the whole branch anyway so will fix anything
thats left. Right now it's the last chance to get the patches to 6.15 so
I don't want delay it on your side.

