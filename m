Return-Path: <linux-btrfs+bounces-8108-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBC597BBC5
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Sep 2024 13:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8162C1F23BB0
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Sep 2024 11:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2651898FB;
	Wed, 18 Sep 2024 11:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="E/UOL4Pl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="te6KCGVm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wgXOzuHV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LSWPr7Ct"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCCB1898F7;
	Wed, 18 Sep 2024 11:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726660424; cv=none; b=N4tLYe6L+D/MFqyqjJaXh5wPsKpo7UeCtrbvQO6LZI5ttkZtMlTo/jB+QlPD7GoHNTao46G1HNhZgioqmJuxayb+QnVuMy4zyEsD/FRIl6UtbGeee7hFrFPdgnCEu75QoJ54fnImdMaLOfp5UDSqUgt/fM5E6ifvCF9TmfIk0sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726660424; c=relaxed/simple;
	bh=Mt8lCbdWc8sFUC3gqvnymqgfSmFecJArFx7A5fRwBR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RGc2Iw5pwE2pVwdjOqIEpy1lnMO8E/oYBycrU0tEddiWQToo+jxfTnc85o4ksDUVXTQMCdnEmzZRrEpSvt+bUkv3/F+4tSQMHgTtlwXV55gTTFLgG8/1rWsFPZuZpdZ3JQCc83mOw6pN6Npzrs1bxvi6smoYtEBk/yBRcBcrlu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=E/UOL4Pl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=te6KCGVm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wgXOzuHV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LSWPr7Ct; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 294E922A60;
	Wed, 18 Sep 2024 11:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726660419;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D4tH86Yym+X4j/8gXF22xZSUbUCW7dHuQCeC8NxIruU=;
	b=E/UOL4Pl4YQrv2fLWLTzQkkhA2MGQWDIpu982vkCo23i7nEaA5ehvXPwDsOvrfqBFpqhnq
	YdxqrNRFwriFH7y+NvCQg6a6iBeSgsjqjyYnJjI+xEhe4leiWJse7APxq8qZMejXi+yId5
	AZOhW+tDkNw+zHY00A7FDLMZ24eFWng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726660419;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D4tH86Yym+X4j/8gXF22xZSUbUCW7dHuQCeC8NxIruU=;
	b=te6KCGVmZyLEufPeC5jJS1W+1GEXmnXjI89iSYrgFAOvPEtiWMGb5uPRAHXP6tNiCn5hSr
	06cQ8xsvP3b7P/Bw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wgXOzuHV;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=LSWPr7Ct
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726660418;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D4tH86Yym+X4j/8gXF22xZSUbUCW7dHuQCeC8NxIruU=;
	b=wgXOzuHVPvz1Xfu7zog8Qlrks7hMTaBZnRPcjHAJwV3m7ICdFha4NB2HBoUBBGlcdDkf4x
	WDfEdFjS99yxoIQ/5rqjq9E23NB0UCKP3g6lKQTKvrVh007oGotd4KsTDLACN7VxHljkLh
	eDp/wu7rxwNGBkYOd19ZW67Cvnpvas8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726660418;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D4tH86Yym+X4j/8gXF22xZSUbUCW7dHuQCeC8NxIruU=;
	b=LSWPr7CttP92UZOP2ybX1i62TXz4k6wAYsoVlnud09uVlnTJHXSwnE5m2cTxm1WUVu+nIt
	7ZMcHxgrG6x32HDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 07F0213508;
	Wed, 18 Sep 2024 11:53:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dm/AAUK/6mbvGgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 18 Sep 2024 11:53:38 +0000
Date: Wed, 18 Sep 2024 13:53:28 +0200
From: David Sterba <dsterba@suse.cz>
To: Luca Stefani <luca.stefani.ge1@gmail.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/2] btrfs: Don't block system suspend during fstrim
Message-ID: <20240918115328.GK2920@suse.cz>
Reply-To: dsterba@suse.cz
References: <20240917203346.9670-1-luca.stefani.ge1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917203346.9670-1-luca.stefani.ge1@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 294E922A60
X-Spam-Level: 
X-Spamd-Result: default: False [-2.71 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:dkim,suse.cz:mid];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.71
X-Spam-Flag: NO

On Tue, Sep 17, 2024 at 10:33:03PM +0200, Luca Stefani wrote:
> Changes since v5:
> * Make chunk size a define
> * Remove superfluous trim_interrupted checks
>   after moving them to trim_no_bitmap/trim_bitmaps
> 
> Changes since v4:
> * Set chunk size to 1G
> * Set proper error return codes in case of interruption
> * Dropped fstrim_range fixup as pulled in -next
> 
> Changes since v3:
> * Went back to manual chunk size
> 
> Changes since v2:
> * Use blk_alloc_discard_bio directly
> * Reset ret to ERESTARTSYS
> 
> Changes since v1:
> * Use bio_discard_limit to calculate chunk size
> * Makes use of the split chunks
> 
> Original discussion: https://lore.kernel.org/lkml/20240822164908.4957-1-luca.stefani.ge1@gmail.com/
> v1: https://lore.kernel.org/lkml/20240902114303.922472-1-luca.stefani.ge1@gmail.com/
> v2: https://lore.kernel.org/lkml/20240902205828.943155-1-luca.stefani.ge1@gmail.com/
> v3: https://lore.kernel.org/lkml/20240903071625.957275-4-luca.stefani.ge1@gmail.com/
> v4: https://lore.kernel.org/lkml/20240916101615.116164-1-luca.stefani.ge1@gmail.com/
> v5: https://lore.kernel.org/lkml/20240916125707.127118-1-luca.stefani.ge1@gmail.com/
> 
> ---
> 
> NB: I didn't change btrfs_discard_workfn yet to add error checks
> as I don't know what semantics we should have in that case.
> The work queue is always re-scheduled and created with WQ_FREEZABLE
> so it should be automatically frozen. Shall I simply add some logs?

About that, this may be a bit tricky, interrupting trim there is handled
but the accounting may get wrong. This is related but a different
problem than the suspend vs trim.

