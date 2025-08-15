Return-Path: <linux-btrfs+bounces-16090-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCEEB2889C
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Aug 2025 01:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3D0558351B
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Aug 2025 23:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB322C3755;
	Fri, 15 Aug 2025 23:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mChjz8/R";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="D0tyYxDt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mChjz8/R";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="D0tyYxDt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5912253F21
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Aug 2025 23:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755298894; cv=none; b=CEtIVo307b88qHIlBk1NXZDe4DY7bIrk2loosWvaOUPozKDePKO2b9f2+FOBXoToOkv48Z7V4nM+qVzv2DQTpRsw6MmZfOMscPmGziW7LOXKXCmmGxAZAUy/PWJj9alkvZbkD0+8TIYhcj0U6cL6IDrWLxKGA6O7ezr8iLNgCoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755298894; c=relaxed/simple;
	bh=7cRZrQzDtOj0g/LkCLpitkMRYryZhGwb3dbjfHMDSDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwkp4/RY2vDzOeT8yQJg5q+F231P9C/63u2YtV/hZIPtcr0MD+dKAAIF9VUGwRGBhwVhCNXt15CMf0PUb1TCVcCl2yU0ePAApfwNc57FEBrBGTx+NesLvKS5Xkmlddsq6u5BpUOPc6OmgWsywMWeZ/KRbBrjgX6uJosJJTjEezg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mChjz8/R; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=D0tyYxDt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mChjz8/R; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=D0tyYxDt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D365521215;
	Fri, 15 Aug 2025 23:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755298890;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7cRZrQzDtOj0g/LkCLpitkMRYryZhGwb3dbjfHMDSDY=;
	b=mChjz8/Rv4CzxCa1g5iKFwXrihU3spReCf0oVvB+maYHty15CmUM6W01kvJkO4xtv3Y9Vo
	xc1u/H7RaBl46pSlgHnqhkcG50tS0aHddxRFnZ3JrJGlfmgokQGkjd3wAwSxdymDfsngyD
	MpnUXEkHPaEFG7rvvg2V09MPtAGAp5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755298890;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7cRZrQzDtOj0g/LkCLpitkMRYryZhGwb3dbjfHMDSDY=;
	b=D0tyYxDtCfkcj/jlwkm61kgcwFHDqU5vMSnEsZjupFxigW+/cGMZgWOJa6NEUl58skY23L
	NmlvqxC1AtGWysAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755298890;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7cRZrQzDtOj0g/LkCLpitkMRYryZhGwb3dbjfHMDSDY=;
	b=mChjz8/Rv4CzxCa1g5iKFwXrihU3spReCf0oVvB+maYHty15CmUM6W01kvJkO4xtv3Y9Vo
	xc1u/H7RaBl46pSlgHnqhkcG50tS0aHddxRFnZ3JrJGlfmgokQGkjd3wAwSxdymDfsngyD
	MpnUXEkHPaEFG7rvvg2V09MPtAGAp5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755298890;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7cRZrQzDtOj0g/LkCLpitkMRYryZhGwb3dbjfHMDSDY=;
	b=D0tyYxDtCfkcj/jlwkm61kgcwFHDqU5vMSnEsZjupFxigW+/cGMZgWOJa6NEUl58skY23L
	NmlvqxC1AtGWysAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C880A1368C;
	Fri, 15 Aug 2025 23:01:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OnHGMEq8n2h9BAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 15 Aug 2025 23:01:30 +0000
Date: Sat, 16 Aug 2025 01:01:25 +0200
From: David Sterba <dsterba@suse.cz>
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v4 0/3] btrfs: ref_tracker for delayed_nodes
Message-ID: <20250815230125.GG22430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1755035080.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1755035080.git.loemra.dev@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Tue, Aug 12, 2025 at 04:04:38PM -0700, Leo Martins wrote:
> The leading btrfs related crash in our fleet is a soft lockup in
> btrfs_kill_all_delayed_nodes caused by a btrfs_delayed_node leak.
> This patchset introduces ref_tracker infrastructure to detect this
> leak. The feature is compiled in via CONFIG_BTRFS_DEBUG and enabled
> via a ref_tracker mount option. I've run a full fstests suite with
> ref_tracker enabled and experienced roughly a 7% slowdown in runtime.

Besides the Kconfig option fixup the patchset looks good. I'll add it to
for-next, thanks.

