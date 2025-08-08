Return-Path: <linux-btrfs+bounces-15930-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0DBB1E6F9
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 13:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF27C3A8182
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 11:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03E41FBE9B;
	Fri,  8 Aug 2025 11:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M3ric6gE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fdTHUiR5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M3ric6gE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fdTHUiR5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2BF145329
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Aug 2025 11:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754651389; cv=none; b=ozIkL/nAau1ZZ4wgYVf/J6ohhOS37tcx1rWaJxqjfmgF1pYjbjmcnnCgN9GmVAMVi1duuONBnfNaUw0fZdWDiOhdvDvL7sDG5e34XcsWWt2cAkuf1AJ9vbj9Rb86zoQF14tWg9ujBTPLgUVREVTF2/X4Grq58+iHZ2u1Ncr2qzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754651389; c=relaxed/simple;
	bh=4QYpFkfIj0VcuBzOnbiCwk2J6SNxnbo06CB4HFZqF7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CzccfH1nfRy0mhVYFBqF8Ad0h4JzDx9nWZG6nM0j9hnhL1cIwZMjv3NmYuKbdFMCYhzcmJu1UxyGTw8J4y+kZrcECY8Rg/bKUN+GLuHoIiSTZWeAtacvpq9zeS/qSXLgGI5QouJY07lJk/N9GBpTBIFdHUHoiVqi0EMiFgiSzPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=M3ric6gE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fdTHUiR5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=M3ric6gE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fdTHUiR5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7740D33E26;
	Fri,  8 Aug 2025 11:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754651384;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ym8WO+BpMB3t2MEOYkuKP1Xd/YRF4hrUH71EKgqu3Qc=;
	b=M3ric6gEWn0JnjT0EDOUt2S/zGPclGoM3LTQxgCoAntpyNRxmiwoLd1tDLlrHd76Hbyswb
	1OUkoLUP6mPyxmtZGLMihNNqYGm45OFHCvzBsTWkXWtfo6WgDazhl/F63SzFVNaIJ+W2cb
	qBfFuiYQr2vgk7iPlluyva3Hi98rSAM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754651384;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ym8WO+BpMB3t2MEOYkuKP1Xd/YRF4hrUH71EKgqu3Qc=;
	b=fdTHUiR5a5/oQ0iEMeGB4ldF4o/Q6YiE5FQor26ZeFnpf9buLj0ZSiSf88O9uIYfE24mRQ
	hGJxjQG462OlGJBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=M3ric6gE;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=fdTHUiR5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754651384;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ym8WO+BpMB3t2MEOYkuKP1Xd/YRF4hrUH71EKgqu3Qc=;
	b=M3ric6gEWn0JnjT0EDOUt2S/zGPclGoM3LTQxgCoAntpyNRxmiwoLd1tDLlrHd76Hbyswb
	1OUkoLUP6mPyxmtZGLMihNNqYGm45OFHCvzBsTWkXWtfo6WgDazhl/F63SzFVNaIJ+W2cb
	qBfFuiYQr2vgk7iPlluyva3Hi98rSAM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754651384;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ym8WO+BpMB3t2MEOYkuKP1Xd/YRF4hrUH71EKgqu3Qc=;
	b=fdTHUiR5a5/oQ0iEMeGB4ldF4o/Q6YiE5FQor26ZeFnpf9buLj0ZSiSf88O9uIYfE24mRQ
	hGJxjQG462OlGJBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6062513A7E;
	Fri,  8 Aug 2025 11:09:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1FcfF/jalWjbdQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 08 Aug 2025 11:09:44 +0000
Date: Fri, 8 Aug 2025 13:09:42 +0200
From: David Sterba <dsterba@suse.cz>
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3 0/3] btrfs: ref_tracker for delayed_nodes
Message-ID: <20250808110942.GQ6704@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1754609966.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1754609966.git.loemra.dev@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 7740D33E26
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.21

On Thu, Aug 07, 2025 at 04:53:53PM -0700, Leo Martins wrote:
> The leading btrfs related crash in our fleet is a soft lockup in
> btrfs_kill_all_delayed_nodes caused by a btrfs_delayed_node leak.
> This patchset introduces ref_tracker infrastructure to detect this
> leak. I'm mirroring the way REF_VERIFY is setup with a Kconfig and
> a mount option. I've run a full fstests suite with ref_tracker enabled
> and experienced roughly a 7% slowdown in runtime.
> 
> Changelog:
> v1: https://lore.kernel.org/linux-btrfs/fa19acf9dc38e93546183fc083c365cdb237e89b.1752098515.git.loemra.dev@gmail.com/
> v2: https://lore.kernel.org/linux-btrfs/20250805194817.3509450-1-loemra.dev@gmail.com/T/#mba44556cfc1ae54c84255667a52a65f9520582b7
> 
> v2->v3:
> - wrap ref_tracker and ref_tracker_dir in btrfs helper structs
> - fix long function formatting
> - new Kconfig CONFIG_BTRFS_FS_REF_TRACKER + ref_tracker mount option

We don't want new config options, the REF_VERIFY is there historically
but is not an example to follow. I think this was mentioned already in
previou iterations.

> - add a print to expose potential leaks
> - move debug fields to the end of the struct
> 
> v1->v2:
> - remove typedefs, now functions always take struct ref_tracker **
> - put delayed_node::count back to original position to not change
>   delayed_node struct size
> - cleanup ref_tracker_dir if btrfs_get_or_create_delayed_node
>   fails to create a delayed_node
> - remove CONFIG_BTRFS_DELAYED_NODE_REF_TRACKER and use
>   CONFIG_BTRFS_DEBUG
> 
> Leo Martins (3):
>   btrfs: implement ref_tracker for delayed_nodes
>   btrfs: print leaked references in kill_all_delayed_nodes
>   btrfs: add mount option for ref_tracker
> 
>  fs/btrfs/Kconfig         |  12 +++
>  fs/btrfs/delayed-inode.c | 193 ++++++++++++++++++++++++++++-----------
>  fs/btrfs/delayed-inode.h |  93 +++++++++++++++++++
>  fs/btrfs/fs.h            |   1 +
>  fs/btrfs/super.c         |  13 +++
>  5 files changed, 257 insertions(+), 55 deletions(-)
> 
> -- 
> 2.47.3
> 

