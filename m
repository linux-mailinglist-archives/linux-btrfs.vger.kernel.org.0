Return-Path: <linux-btrfs+bounces-20145-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F1FCF8151
	for <lists+linux-btrfs@lfdr.de>; Tue, 06 Jan 2026 12:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 372D130EB67E
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jan 2026 11:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF38326947;
	Tue,  6 Jan 2026 11:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aKKp3V0z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XqIpzVgE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aKKp3V0z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XqIpzVgE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658773081A4
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Jan 2026 11:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767699152; cv=none; b=sjPsLTG47ftMVFt8l3wn06KTWJ5fEgact7eHKKVR/0HZMfdLdqBbxm9q2vgbFduxIP/W/lmV8KDH/ez9xHNoNuS1f971YM/YInq6gpT2R5PQutEXpjGj3UkjAt9xvPK3SwMk4uHWspRYCi3dZ9NIu+NyEHq59y+He5Zg7bLvA8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767699152; c=relaxed/simple;
	bh=rrRXSVXdSouS8MT2u2F/sq/JdijcDteRsXKGfw5viNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNuDN2Kz241Pa+X9A+IKmNkjdmPLEPbTOgBg4K6bHpHXHK2Y80qju7PyPpVCBNQ/XoI9pFD6wBLaiPuSi0DRSBIUD3dfkZyNn9aX+RB07zEWQK7HY88Ky4M/Pd6NMZFMVUFZU4eVH0mX5U+UB4fWK0xKuAP0mz1DqSjPgyBtxz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aKKp3V0z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XqIpzVgE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aKKp3V0z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XqIpzVgE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 91534339E3;
	Tue,  6 Jan 2026 11:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767699149;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QHLyfzHWZ77Uj/I7TxrwflW3uCbFZpdhVO5attcji8s=;
	b=aKKp3V0zKoDEBSsGuNZU+IQoyBnRziKb49fv4CKvis/tUonNRzwDXfQjKYSXOZhtaUKMCj
	jjM+mEh0qezVjcc7miXNjfzVQDffJUpTMP3b8oZItmdaxdn1nFyRzNQ9za3N2v/OIirELl
	gobF+Fzc5lrK5r2uhlQFg/qdQto3ULY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767699149;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QHLyfzHWZ77Uj/I7TxrwflW3uCbFZpdhVO5attcji8s=;
	b=XqIpzVgEyniORWV91kWkZ2czOeE//iXV8zZlxnVeaojpKyXQ/wo3eATdD6eEa2gvIoY4vb
	azHVGuMadoRmDfDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767699149;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QHLyfzHWZ77Uj/I7TxrwflW3uCbFZpdhVO5attcji8s=;
	b=aKKp3V0zKoDEBSsGuNZU+IQoyBnRziKb49fv4CKvis/tUonNRzwDXfQjKYSXOZhtaUKMCj
	jjM+mEh0qezVjcc7miXNjfzVQDffJUpTMP3b8oZItmdaxdn1nFyRzNQ9za3N2v/OIirELl
	gobF+Fzc5lrK5r2uhlQFg/qdQto3ULY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767699149;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QHLyfzHWZ77Uj/I7TxrwflW3uCbFZpdhVO5attcji8s=;
	b=XqIpzVgEyniORWV91kWkZ2czOeE//iXV8zZlxnVeaojpKyXQ/wo3eATdD6eEa2gvIoY4vb
	azHVGuMadoRmDfDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7381E3EA63;
	Tue,  6 Jan 2026 11:32:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id foQDHM3yXGkMVgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 06 Jan 2026 11:32:29 +0000
Date: Tue, 6 Jan 2026 12:32:28 +0100
From: David Sterba <dsterba@suse.cz>
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Chris Mason <clm@fb.com>, yunbolyu@smu.edu.sg,
	kexinsun@smail.nju.edu.cn, ratnadiraw@smu.edu.sg,
	xutong.ma@inria.fr, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: update outdated comment
Message-ID: <20260106113228.GC21071@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251230163245.102164-1-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251230163245.102164-1-Julia.Lawall@inria.fr>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -3.95
X-Spam-Level: 
X-Spamd-Result: default: False [-3.95 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.15)[-0.771];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]

On Tue, Dec 30, 2025 at 05:32:45PM +0100, Julia Lawall wrote:
> The function add_block_group_free_space() was renamed
> btrfs_add_block_group_free_space() by commit 6fc5ef782988 ("btrfs:
> add btrfs prefix to free space tree exported functions").  Update
> the comment accordingly.
> 
> Do some reorganization of the next few lines to keep the comment
> within 80 characters
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Added to for-next, thanks.

