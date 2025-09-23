Return-Path: <linux-btrfs+bounces-17102-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5D6B947CC
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 08:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4A5218A3049
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 06:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C5230DECF;
	Tue, 23 Sep 2025 06:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HuZEU4bm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1e5w/83v";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HuZEU4bm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1e5w/83v"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA377266584
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Sep 2025 06:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758607371; cv=none; b=mSPUlsZYn79AwqB4KZagd865RSag91sW81GeGa/VpyvyqhPgVajmhoarTpTYMm1jK0WEBfRSDF0ozPw+87/LkATX/OHT0CxejEVx/Yg+3WyL1Gue6731qBbz8kiFvpZUVPvV4V6X1UjQ9x67nl34AkEW/yIzpfZVJ0C9P22m2Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758607371; c=relaxed/simple;
	bh=/5a33Vu1pszQZ33/bUGbyANa6SvZqKiUGg9Z7Oy2j9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEbkFY53Tx8W8WJheJ9azA1ZO/dMTa26wAXjBIUhifDMcCIwOHNJGn3MITZaWrbeYqPCP3f38Cj76Bcx2PHwHERABeNMFUQeO+bvOUOw7kvGCzpEdlDI31F4y73e0fBgujtWMUDvTFZ1TTUIcozwcoVawA2irxPF8pfpN/usqD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HuZEU4bm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1e5w/83v; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HuZEU4bm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1e5w/83v; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 494491F387;
	Tue, 23 Sep 2025 06:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758607361;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ymgO+Q67MSz3m2EkAasdjVAzCSbKKe+Oj9Fve5wkQ4E=;
	b=HuZEU4bmFeFi1m5kY376Uy+3gFdAj4QN9zR4V7hfki3GFebeCjPHzALejvj28hRlVucyzT
	J6xYZh8zqcodfg4vRJ29tGFFP4ZsD5v32DFqQLljvO/U60okNz0ImMOqtTqj4lhivM+Vdq
	JFUezvrnkwB7dybeWmU00lCgV6mXBpk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758607361;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ymgO+Q67MSz3m2EkAasdjVAzCSbKKe+Oj9Fve5wkQ4E=;
	b=1e5w/83vlLpSv2OUUo3kzRbp6ww0A1Tv2njm8LExGte+Y9rITesMsmiR1vNj8i6Uwfdn/n
	sWDIZKPeLd+eWUBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=HuZEU4bm;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="1e5w/83v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758607361;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ymgO+Q67MSz3m2EkAasdjVAzCSbKKe+Oj9Fve5wkQ4E=;
	b=HuZEU4bmFeFi1m5kY376Uy+3gFdAj4QN9zR4V7hfki3GFebeCjPHzALejvj28hRlVucyzT
	J6xYZh8zqcodfg4vRJ29tGFFP4ZsD5v32DFqQLljvO/U60okNz0ImMOqtTqj4lhivM+Vdq
	JFUezvrnkwB7dybeWmU00lCgV6mXBpk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758607361;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ymgO+Q67MSz3m2EkAasdjVAzCSbKKe+Oj9Fve5wkQ4E=;
	b=1e5w/83vlLpSv2OUUo3kzRbp6ww0A1Tv2njm8LExGte+Y9rITesMsmiR1vNj8i6Uwfdn/n
	sWDIZKPeLd+eWUBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B4AA132C9;
	Tue, 23 Sep 2025 06:02:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tjgbCgE40miGEwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 23 Sep 2025 06:02:41 +0000
Date: Tue, 23 Sep 2025 08:02:39 +0200
From: David Sterba <dsterba@suse.cz>
To: Sun YangKai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH v4] btrfs: more trivial BTRFS_PATH_AUTO_FREE conversions
Message-ID: <20250923060239.GQ5333@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250922113310.29724-4-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922113310.29724-4-sunk67188@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 494491F387
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21

On Mon, Sep 22, 2025 at 07:30:07PM +0800, Sun YangKai wrote:
> Trivial pattern for the auto freeing with goto -> return conversions
> if possible. No other function cleanup.
> 
> The following cases are considered trivial in this patch:
> 
> 1. Cases where there are no operations between btrfs_free_path() and the
>    function return.
> 2. Cases where only simple cleanup operations (such as kfree(), kvfree(),
>    clear_bit(), and fs_path_free()) are present between
>    btrfs_free_path() and the function return.
> 
> Signed-off-by: Sun YangKai <sunk67188@gmail.com>
> 
> ---
> 
> Changelog:
> v1 -> v3:
> * Directly return 0 if info is NULL in send.c:get_inode_info()
> * Limit the scope of the conversion to only what is described
>   in the commit message.
> 
> v3 -> v4:
> * Fix missing conversions of BTRFS_PATH_AUTO_FREE
>   and tested with btrfs/quick group in xfstests

Added to for-next, thanks.

