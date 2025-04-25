Return-Path: <linux-btrfs+bounces-13418-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01614A9C85F
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 13:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E35C188CAB1
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 11:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6076624C084;
	Fri, 25 Apr 2025 11:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GX3fh73E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OVriwnLf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GX3fh73E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OVriwnLf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3260D24A049
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Apr 2025 11:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745582299; cv=none; b=pv1oscUJE1z/QcBdbTf8ez/FRZXatO+kby9LdwzDK6vsijjTAS/E6QQnC7nxPLz/AUX+WJp8NUoIHbzPoLpQpiZOxH+1IVNjrKHM3AHkVH6lLmbRTEWQrP3sXirsP/mzxap4uFAtTYn1XMcsD8sXu4u1djfVpYe8tikRMcD4G+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745582299; c=relaxed/simple;
	bh=eeSWWXfwywPFP1EXOlS/IX84kQZ5dJrJQTCz+0J13NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iz9SUnmZEB+dAI5MAKwYCKaFOaxCiTtAuMFm+51g21QIKyxZn8VyMldEKJhuwZuzfloi1Jy/fXozzDLfghW5Gor7bS3A+NPpXuNlM8EUQaWuPPIAGA/7PCYgXGY++AubsCD4e3zwywbgha/9ds+GNQxyw1GwWMb0QXgjYa0n03g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GX3fh73E; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OVriwnLf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GX3fh73E; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OVriwnLf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1904A21182;
	Fri, 25 Apr 2025 11:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745582295;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VwSRiksGW7GNeN6l0n/zQF6xP95F5RbpJ0sRvEvWRjc=;
	b=GX3fh73ED0DHt3Yt2/bJ1L6mPqLLqoNOIz+ZR7aMa9X8Xpv0vuOARD5LOHhYBRPUgEePpw
	E40obYMai/LJmtQlfziqdmcU45WVKzuhSxiMOU4224FQEb+5MclLKzcnbTTi527yJdbuA/
	JSkK/nn9rE5Uti9XAvQ+tappeM8cSgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745582295;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VwSRiksGW7GNeN6l0n/zQF6xP95F5RbpJ0sRvEvWRjc=;
	b=OVriwnLf3wWE5MZdJKd6xPYzJdFFAdpG/mCrz1oof3U60TraYGAHbBe8/THL8tcVdx52M5
	/zJ1ctEYOdivXpCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=GX3fh73E;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=OVriwnLf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745582295;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VwSRiksGW7GNeN6l0n/zQF6xP95F5RbpJ0sRvEvWRjc=;
	b=GX3fh73ED0DHt3Yt2/bJ1L6mPqLLqoNOIz+ZR7aMa9X8Xpv0vuOARD5LOHhYBRPUgEePpw
	E40obYMai/LJmtQlfziqdmcU45WVKzuhSxiMOU4224FQEb+5MclLKzcnbTTi527yJdbuA/
	JSkK/nn9rE5Uti9XAvQ+tappeM8cSgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745582295;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VwSRiksGW7GNeN6l0n/zQF6xP95F5RbpJ0sRvEvWRjc=;
	b=OVriwnLf3wWE5MZdJKd6xPYzJdFFAdpG/mCrz1oof3U60TraYGAHbBe8/THL8tcVdx52M5
	/zJ1ctEYOdivXpCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E00041398F;
	Fri, 25 Apr 2025 11:58:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4kUSNtZ4C2hzOwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 25 Apr 2025 11:58:14 +0000
Date: Fri, 25 Apr 2025 13:58:13 +0200
From: David Sterba <dsterba@suse.cz>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH] btrfs: fix folio leak in btrfs_clone_extent_buffer()
Message-ID: <20250425115813.GE31681@suse.cz>
Reply-To: dsterba@suse.cz
References: <3a03310eda52461869be5711dc712f295c190b83.1745531701.git.boris@bur.io>
 <CAL3q7H60DfC0+ysf_Yw7bBOaDExPqpRU4==xHz4pYxHt3k-woQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H60DfC0+ysf_Yw7bBOaDExPqpRU4==xHz4pYxHt3k-woQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 1904A21182
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Fri, Apr 25, 2025 at 10:18:38AM +0100, Filipe Manana wrote:
> On Thu, Apr 24, 2025 at 10:54 PM Boris Burkov <boris@bur.io> wrote:
> >
> > If btrfs_clone_extent_buffer() hits an error halfway through attaching
> > the folios, it will not call folio_put() on its folios.
> >
> > Unify its error handling behavior with alloc_dummy_extent_buffer() under
> > a new function 'cleanup_extent_buffer_folios()'
> 
> So this misses any indication that this fixes a bug introduced by:
> 
> "btrfs: fix broken drop_caches on extent buffer folios"

Thanks for noticing, this was not obvious.

> With a subject and description like this, it's almost sure this patch
> will be automatically picked for stable backports, and if it gets
> backported it will break things unless that other patch is backported
> too.
> 
> Also, since the bug was introduced by the other patch and it's not yet
> in Linus' tree, it would be better to update that patch with this
> one's content.
> That's normally what we do - I know both patches are already in
> github's for-next (I didn't even get a chance to review this one since
> it all happened during my evening), and it's ok to rebase and squash
> patches.

Agreed, as long as the a buggy patch is in for-next there shuld be no
need for a fixup unless the branch is frozen for merge window.

Also non-trivial patches should not be pushed to for-next too quickly,
exactly to give people chance to have a look. For trivial, clearly
correct or non-code updates I would not care much if it's applied
without much delay.

