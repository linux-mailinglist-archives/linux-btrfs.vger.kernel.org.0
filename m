Return-Path: <linux-btrfs+bounces-5993-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 683D6918498
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2024 16:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09BB21F2B6FC
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2024 14:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45401186E29;
	Wed, 26 Jun 2024 14:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gwl0hxv5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mFO32Har";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gwl0hxv5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mFO32Har"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29551822C2
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2024 14:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719412783; cv=none; b=YGkX3FA7IaVT17JeUm201T1R9JlJ2VwhQwbZngCHProTQXZbwzGHP0NVro/yPQ834I4/UvFacrYfZeZQZxMVWZdVy2qGKy7EGXz7Z6+ZnwbEN/x+PAFqVP2cTYejD9Z8T0lmeUPVhqgyFqsekvkcVrB5HxR3Ddjb4YUpAWf2oUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719412783; c=relaxed/simple;
	bh=wbvNB2CfoCSqtLDyMitLzJHk5jt8pUCW2jWYDxvz/Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iB/Ou1u66Usll5QDz9neNXyLVUQlz7lDrW+3JOeZ/KCXNai6e/wVNe1V/B6VoZsxDhTmaOfc7S+QnXT24IDDDkVtLdQfO13rjsI0ASjcNiWQt2e39BPuNyc4qqMxhKz7WsAPB+7y2JdPV7ZQ1AyDJYQwH/ew/XL6aEr3QAUR16o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gwl0hxv5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mFO32Har; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gwl0hxv5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mFO32Har; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C8F6D21A60;
	Wed, 26 Jun 2024 14:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719412779;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4zPMCrqCFETwzAaLDoTxRFi/edNdC4GFpnbpZU4Vhrk=;
	b=gwl0hxv5w0avhA3itqUvTYPg2hRtp3qGzuUHzRDECbQufaAhxczamjpBbaP87KLyU8iPgA
	2jUkhAVoB6C5XlAja4OMlJ3FW+DShrGMQ5tGhT/XE/76NYxT7jp88kdK3xBDKyQu0wFwKW
	qnCkVLyaVq0bQfgUrVwPau8gWr0jV1w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719412779;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4zPMCrqCFETwzAaLDoTxRFi/edNdC4GFpnbpZU4Vhrk=;
	b=mFO32Har64tT1OHgbj8K7iGz1R4fe1AMb00CylYeF+rojvQeET6DjMvEtAAHn/qRsWHlSg
	lpBBQ857NJy7tMDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719412779;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4zPMCrqCFETwzAaLDoTxRFi/edNdC4GFpnbpZU4Vhrk=;
	b=gwl0hxv5w0avhA3itqUvTYPg2hRtp3qGzuUHzRDECbQufaAhxczamjpBbaP87KLyU8iPgA
	2jUkhAVoB6C5XlAja4OMlJ3FW+DShrGMQ5tGhT/XE/76NYxT7jp88kdK3xBDKyQu0wFwKW
	qnCkVLyaVq0bQfgUrVwPau8gWr0jV1w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719412779;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4zPMCrqCFETwzAaLDoTxRFi/edNdC4GFpnbpZU4Vhrk=;
	b=mFO32Har64tT1OHgbj8K7iGz1R4fe1AMb00CylYeF+rojvQeET6DjMvEtAAHn/qRsWHlSg
	lpBBQ857NJy7tMDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5382139C2;
	Wed, 26 Jun 2024 14:39:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VxK9KysofGbcWAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 26 Jun 2024 14:39:39 +0000
Date: Wed, 26 Jun 2024 16:39:34 +0200
From: David Sterba <dsterba@suse.cz>
To: Filipe Manana <fdmanana@kernel.org>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/11] Inode type conversion
Message-ID: <20240626143934.GA25756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1719246104.git.dsterba@suse.com>
 <CAL3q7H4SEL0vFz_r-BDre_RU+mM6SQ8TP5HuA2FS6fKbVVBvGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H4SEL0vFz_r-BDre_RU+mM6SQ8TP5HuA2FS6fKbVVBvGg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[3]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Wed, Jun 26, 2024 at 03:06:29PM +0100, Filipe Manana wrote:
> On Mon, Jun 24, 2024 at 5:24 PM David Sterba <dsterba@suse.com> wrote:
> >
> > A small batch converting inode to btrfs_inode for internal functions and
> > data structures.
> >
> > David Sterba (11):
> >   btrfs: pass a btrfs_inode to btrfs_readdir_put_delayed_items()
> >   btrfs: pass a btrfs_inode to btrfs_readdir_get_delayed_items()
> >   btrfs: pass a btrfs_inode to is_data_inode()
> >   btrfs: switch btrfs_block_group::inode to struct btrfs_inode
> >   btrfs: pass a btrfs_inode to btrfs_ioctl_send()
> >   btrfs: switch btrfs_pending_snapshot::dir to btrfs_inode
> >   btrfs: switch btrfs_ordered_extent::inode to struct btrfs_inode
> >   btrfs: pass a btrfs_inode to btrfs_compress_heuristic()
> >   btrfs: pass a btrfs_inode to btrfs_set_prop()
> >   btrfs: pass a btrfs_inode to btrfs_load_inode_props()
> >   btrfs: pass a btrfs_inode to btrfs_inode_inherit_props()
> 
> One of these changes to the properties is broken.
> btrfs/048 triggers this:

Thanks for the report, I'll take a look.

