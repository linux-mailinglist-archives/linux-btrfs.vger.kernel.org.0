Return-Path: <linux-btrfs+bounces-13099-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 723FCA90BFA
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 21:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E271D5A2805
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 19:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F14A22489F;
	Wed, 16 Apr 2025 19:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ujoOcuZZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hXSGZJWm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ujoOcuZZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hXSGZJWm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F9F2236F4
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 19:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744830676; cv=none; b=pAPBZjhmwZMTzOhoGfBL5oo+UtryU9lzZ9AVh3erCHVn/kTVBTQ2gNoPZ//SSzDwTO2Q9dCGkxuuIATmBzp+zpVUsMUyarfL4Zy7LVpF50Zq4w1v7BJG4TOi9pCBR3aXIsA+0p/FbiMrLL6qOwY7xQhvOimcBzEGAZEWgXCHIZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744830676; c=relaxed/simple;
	bh=qxow67/tTid/gvtGXWL5QJlHwTsgWdmACZ/TwaexjAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCSkd9CyMM5T2C3ixPDvC7p7EF1QkDZpDsc6KU1/luMvRBRshEc3YiOLM3alA4YGD77HieEGVhmDGNgOzEJYrpt4els0ajItXAOgU4j21BKHDzxMA/bLFI9QdN8kasMyz3THFB6WaVXBpetmLmXTToe2v9tmcxDal+BIUer1HTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ujoOcuZZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hXSGZJWm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ujoOcuZZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hXSGZJWm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1FE311F745;
	Wed, 16 Apr 2025 19:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744830673;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xN34V2v/JLw7HZPG3CFCZbnxOx6GOqVTfHppFi0uAHA=;
	b=ujoOcuZZ8pQik+Y3IjXdldyiFbH5wgvRVhYbqgrQr/4o+1MKjXVf48McnK+xWArRd6kCh3
	/nPkXsRkpusnFbhScx4pzYW4/HVgehP6gYMg+SP5zlTV3i/3iQ4hVD6vW7JOlOcGnZwPRi
	dEP1uyBNK0/9MkNMkaJni8iGPRt9Kr4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744830673;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xN34V2v/JLw7HZPG3CFCZbnxOx6GOqVTfHppFi0uAHA=;
	b=hXSGZJWmqW0q409RjDJY7Tb1KZ8HA6wokoeQzimsP2D7Bb//HuBqSoqbbMQD0ezSPKgdoy
	cl8Gisg7Le1wCHDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744830673;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xN34V2v/JLw7HZPG3CFCZbnxOx6GOqVTfHppFi0uAHA=;
	b=ujoOcuZZ8pQik+Y3IjXdldyiFbH5wgvRVhYbqgrQr/4o+1MKjXVf48McnK+xWArRd6kCh3
	/nPkXsRkpusnFbhScx4pzYW4/HVgehP6gYMg+SP5zlTV3i/3iQ4hVD6vW7JOlOcGnZwPRi
	dEP1uyBNK0/9MkNMkaJni8iGPRt9Kr4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744830673;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xN34V2v/JLw7HZPG3CFCZbnxOx6GOqVTfHppFi0uAHA=;
	b=hXSGZJWmqW0q409RjDJY7Tb1KZ8HA6wokoeQzimsP2D7Bb//HuBqSoqbbMQD0ezSPKgdoy
	cl8Gisg7Le1wCHDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01E7D13976;
	Wed, 16 Apr 2025 19:11:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NaVDANEAAGgvHAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 16 Apr 2025 19:11:13 +0000
Date: Wed, 16 Apr 2025 21:11:11 +0200
From: David Sterba <dsterba@suse.cz>
To: Filipe Manana <fdmanana@kernel.org>
Cc: =?utf-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>,
	Sun YangKai <sunk67188@gmail.com>, "clm@fb.com" <clm@fb.com>,
	"dsterba@suse.com" <dsterba@suse.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"neelx@suse.com" <neelx@suse.com>
Subject: Re: [PATCH 1/3] btrfs: get rid of path allocation in
 btrfs_del_inode_extref()
Message-ID: <20250416191111.GC13877@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250415033854.848776-1-frank.li@vivo.com>
 <3353953.aeNJFYEL58@saltykitkat>
 <20250415155637.GG16750@suse.cz>
 <SEZPR06MB5269DCFA737F179B0F552B01E8BD2@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <CAL3q7H7z_iVmeuRNXQvvZseB9ntSDz9_tUTXB0KvrcsSQVJb9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H7z_iVmeuRNXQvvZseB9ntSDz9_tUTXB0KvrcsSQVJb9w@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vivo.com,gmail.com,fb.com,suse.com,toxicpanda.com,vger.kernel.org];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Apr 16, 2025 at 02:37:33PM +0100, Filipe Manana wrote:
> On Wed, Apr 16, 2025 at 2:24 PM 李扬韬 <frank.li@vivo.com> wrote:
> >
> >
> >
> > > Also a good point, the path should be in a pristine state, as if it were just allocated. Releasing paths in other functions may want to keep the bits but in this case we're crossing a function boundary and the same assumptions may not be the same.
> >
> > > Release resets the ->nodes, so what's left is from ->slots until the the end of the structure. And a helper for that would be desirable rather than opencoding that.
> >
> > IIUC, use btrfs_reset_path instead of btrfs_release_path?
> >
> > noinline void btrfs_reset_path(struct btrfs_path *p)
> > {
> >         int i;
> >
> >         for (i = 0; i < BTRFS_MAX_LEVEL; i++) {
> >                 if (!p->nodes[i])
> >                         continue;
> >                 if (p->locks[i])
> >                         btrfs_tree_unlock_rw(p->nodes[i], p->locks[i]);
> >                 free_extent_buffer(p->nodes[i]);
> >         }
> >         memset(p, 0, sizeof(struct btrfs_path));
> > }
> >
> > BTW, I have seen released paths being passed across functions in some other paths.
> >
> > Should these also be changed to reset paths, or should these flags be cleared in the release path?
> 
> Please don't complicate things unnecessarily.
> The patch is fine, all that needs to be done is to call
> btrfs_release_path() before passing the path to
> btrfs_del_inode_extref(), which resets nodes, slots and locks.

But this leaves the bits set, btrfs_insert_inode_ref() sets
path->skip_release_on_error, this should be reset. In this case it may
not be significant but I'd rather make the path reusing pattern correct
from the beginning.

My idea was to add only

btrfs_reset_path() {
        memset(p, 0, sizeof(struct btrfs_path));
}

and use it in conection with btrfs_release_path() only in case it's
optimizing the allocation.

