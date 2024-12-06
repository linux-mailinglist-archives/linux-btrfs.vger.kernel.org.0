Return-Path: <linux-btrfs+bounces-10102-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 217A59E794D
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2024 20:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9AC418882E1
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2024 19:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F56F1FFC69;
	Fri,  6 Dec 2024 19:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v5TRq3xN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tubEEL/v";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v5TRq3xN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tubEEL/v"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B851FFC44
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Dec 2024 19:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733514666; cv=none; b=Gta3st53AEWA0ZgAcfADqaEYalL2ANuI/ObZH6fW1FVZyjJuvXNjnCD2Mk4eWXToAH4///uW3aeVAmkbWlsXZDiUiuv+emWFG+CSjOzJrARtGC2R2hY+wsv2eXajCFhNSb5sTBVw6ng5Zznx8TsjdlzOfgG8idE36yb8PEHFv8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733514666; c=relaxed/simple;
	bh=3r3dMSVHRhWKSgyaFsuZtiawlh4q3qufCX3KsMZf574=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjd+0tTRsjeq3kMcAhj9PfGKoN+SAzRVV76rRjbAW+pHtFrrIk1iWyS5/NSGUBoRMoF7SBzCrBCxCr8A4JF2/UQgKcq4Vj2XM4yB/PvWsImiHc3j906dTiF3FP7NQKFjOGJcwVxF2s88moWdNf7h6a37/NpkJAbr3HNOvcgPR2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v5TRq3xN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tubEEL/v; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v5TRq3xN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tubEEL/v; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 18FDE1F37E;
	Fri,  6 Dec 2024 19:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733514662;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g394jAkDWO8T5jDFvkv4RK8Rauy5akBxSwLDH2v6ZlU=;
	b=v5TRq3xNxoc51US4dlfNoCJeOdvsWRT3BZ6u/QPn1tgUOsd/ceiPaA2ez7hYemDL/J8VRU
	oBS23EIhX20M7zbl/Akb8tnyD/Hx7uIsJGCXzAQsvdo3n2APiGpoYa4NToIDDXn5kLy2GP
	JB673gB8GFap+9nMn9wIe24KMGIZDbc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733514662;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g394jAkDWO8T5jDFvkv4RK8Rauy5akBxSwLDH2v6ZlU=;
	b=tubEEL/vs1TEbppuEoJ4r7bmg7bngNEo6NQFESG0urxvwFmwRcmaWabpZcoXNA42Zv2jxE
	tzG8x13fdKb2ddDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733514662;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g394jAkDWO8T5jDFvkv4RK8Rauy5akBxSwLDH2v6ZlU=;
	b=v5TRq3xNxoc51US4dlfNoCJeOdvsWRT3BZ6u/QPn1tgUOsd/ceiPaA2ez7hYemDL/J8VRU
	oBS23EIhX20M7zbl/Akb8tnyD/Hx7uIsJGCXzAQsvdo3n2APiGpoYa4NToIDDXn5kLy2GP
	JB673gB8GFap+9nMn9wIe24KMGIZDbc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733514662;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g394jAkDWO8T5jDFvkv4RK8Rauy5akBxSwLDH2v6ZlU=;
	b=tubEEL/vs1TEbppuEoJ4r7bmg7bngNEo6NQFESG0urxvwFmwRcmaWabpZcoXNA42Zv2jxE
	tzG8x13fdKb2ddDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E358C13647;
	Fri,  6 Dec 2024 19:51:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3Av0NqVVU2fSRAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 06 Dec 2024 19:51:01 +0000
Date: Fri, 6 Dec 2024 20:51:00 +0100
From: David Sterba <dsterba@suse.cz>
To: David Sterba <dsterba@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH 2/2] btrfs: add delayed ref self tests
Message-ID: <20241206195100.GM31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1731614132.git.josef@toxicpanda.com>
 <78564483832375111f2d9541678cffa5d3c0c30a.1731614132.git.josef@toxicpanda.com>
 <20241115183305.GW31418@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241115183305.GW31418@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: *
X-Spamd-Result: default: False [1.00 / 50.00];
	REPLYTO_EQ_TO_ADDR(5.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4]
X-Spam-Score: 1.00
X-Spam-Flag: NO

On Fri, Nov 15, 2024 at 07:33:05PM +0100, David Sterba wrote:
> On Thu, Nov 14, 2024 at 02:57:49PM -0500, Josef Bacik wrote:
> > +	node_check.root = FAKE_ROOT_OBJECTID;
> > +	if (validate_ref_node(node, &node_check)) {
> > +		test_err("node check failed");
> > +		goto out;
> > +	}
> > +	delete_delayed_ref_node(head, node);
> > +	ret = 0;
> > +out:
> > +	if (head)
> > +		btrfs_unselect_ref_head(delayed_refs, head);
> > +	btrfs_destroy_delayed_refs(trans->transaction);
> > +	return ret;
> > +}
> > +
> > +int btrfs_test_delayed_refs(u32 sectorsize, u32 nodesize)
> > +{
> > +	struct btrfs_transaction transaction;
> > +	struct btrfs_trans_handle trans;
> 
> Build complains
> 
>   CC [M]  fs/btrfs/tests/delayed-refs-tests.o
> fs/btrfs/tests/delayed-refs-tests.c: In function ‘btrfs_test_delayed_refs’:
> fs/btrfs/tests/delayed-refs-tests.c:1012:1: warning: the frame size of 2056 bytes is larger than 2048 bytes [-Wframe-larger-than=]
> 
> Please change that to kmalloc so we don't get warning reports on configs that
> bloat data structures. On release config the sizes are like 480 + 168, which is ok.

Fixed in for-next.

