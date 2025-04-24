Return-Path: <linux-btrfs+bounces-13382-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F20DA9A9E2
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 12:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05E8E7AF811
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 10:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09707221FAA;
	Thu, 24 Apr 2025 10:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y65ESiOk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gJ+VZ2Qa";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y65ESiOk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gJ+VZ2Qa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA6646B8
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Apr 2025 10:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745489866; cv=none; b=fPHxMIo5+PV2h5A3yNOpvheIq3HBmZwrSm3eHa3wSxQ5aEb1fGTfIfL24NKhKnJmaiJCc4aIovTvcpA1Laup3mgDGqdUYBIEgRwFaT8JSzVGlSg5Petyi8dhJAgU0LDNNteoBK9n3MM08FAYjVlVL88RDqO2IoFvgWtqRy19CpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745489866; c=relaxed/simple;
	bh=gafRQH11ppUuOWU14cB3Vpxia4uDyQUm2tx4ytI9b00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mX/ATjLzCy6vX6aY2waXVZNET+AHLtFqsrGGNt/IOR2BURndMXxWFluYpgOhsr7hcl+p3zBLCyMkjLesvtNHeJ6Nei+j0qH32eDrX29yYY57qckLszYRQvuD5A5tJBCW5Y1k0j8bdSBTuvndDZu+mx95rKLhI+HyfN0z5VW8lSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y65ESiOk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gJ+VZ2Qa; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y65ESiOk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gJ+VZ2Qa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DBE741F399;
	Thu, 24 Apr 2025 10:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745489861;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dr3UsdIcQ3F+p97w/QAeaCJq4BbhFgijwvWh12wHaKE=;
	b=y65ESiOkdNbPIeeByUcucNb1JPA4GqLBDfuPrnXxTA8qme+jOuLCzJegX8eQ33KXkU0x2z
	4KpkMFXVvawnIGDZ9B36ZXzPTE3xUIbhd9YBH/68dtALC6Ox0tJ+ndnUHh0BwrB0ZkgvTb
	SkG9kRlEae4NEMaVlTkubts3dZx9ebU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745489861;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dr3UsdIcQ3F+p97w/QAeaCJq4BbhFgijwvWh12wHaKE=;
	b=gJ+VZ2QadgQ8il/XtW1mLEZxzYKQQJBpRVfGbRlTd+edHcOAc9KhQYKdoEJaYdLPV5mNc1
	WU509/spKT8YXbCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745489861;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dr3UsdIcQ3F+p97w/QAeaCJq4BbhFgijwvWh12wHaKE=;
	b=y65ESiOkdNbPIeeByUcucNb1JPA4GqLBDfuPrnXxTA8qme+jOuLCzJegX8eQ33KXkU0x2z
	4KpkMFXVvawnIGDZ9B36ZXzPTE3xUIbhd9YBH/68dtALC6Ox0tJ+ndnUHh0BwrB0ZkgvTb
	SkG9kRlEae4NEMaVlTkubts3dZx9ebU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745489861;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dr3UsdIcQ3F+p97w/QAeaCJq4BbhFgijwvWh12wHaKE=;
	b=gJ+VZ2QadgQ8il/XtW1mLEZxzYKQQJBpRVfGbRlTd+edHcOAc9KhQYKdoEJaYdLPV5mNc1
	WU509/spKT8YXbCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B960B139D0;
	Thu, 24 Apr 2025 10:17:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sPYPLcUPCmjtJwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 24 Apr 2025 10:17:41 +0000
Date: Thu, 24 Apr 2025 12:17:36 +0200
From: David Sterba <dsterba@suse.cz>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	kdevops@lists.linux.dev
Subject: Re: btrfs v6.15-rc2 baseline
Message-ID: <20250424101736.GL3659@suse.cz>
Reply-To: dsterba@suse.cz
References: <Z__4Fu6VsCVDFKkO@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z__4Fu6VsCVDFKkO@bombadil.infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Wed, Apr 16, 2025 at 11:33:58AM -0700, Luis Chamberlain wrote:
> btrfs developers,
> 
> kdevops has run fstests on v6.15-rc2 across the different btrfs profiles
> it currently defines, and the results are below.
> 
> The btrfs profiles which kdevops currently supports are:
> 
>   - btrfs_simple
>   - btrfs_nohofspace
>   - btrfs_noholes
>   - btrfs_holes
>   - btrfs_holes_zstd
>   - btrfs_noholes_lzo
>   - btrfs_fspace
>   - btrfs_noholes_zlib
>   - btrfs_noholes_zstd

I don't know how much VM power you have to run all the setups, some of
thhem can be removed as they are duplicating the defaults. We've
switched to 'noholes' by default, so anything with 'holes' can be
removed. Same with free space tree (space_cache=v2).

> These are defined in the btrfs jinja2 template on kdevops [0] and described
> on the ext4 kconfig [1]. Adding support for more profiles is just a matter
> of editing these two files, please feel free to send a patch if you'd like
> kdevops to test more profiles. A full tarball of the fstests results are
> available on kdevops-results-archive [2]. Since we leverage git-lfs, you can
> opt to only download this single tarball as follows:
> 
> GIT_LFS_SKIP_SMUDGE=1 git clone https://github.com/linux-kdevops/kdevops-results-archive.git
> cd kdevops-results-archive
> git lfs fetch --include "fstests/gh/linux-btrfs-kpd/20250416/0001/linux-6-15-rc2/8ffd015db85f.xz"
> git lfs checkout "fstests/gh/linux-btrfs-kpd/20250416/0001/linux-6-15-rc2/8ffd015db85f.xz"
> 
> Few questions:
> 
>  - Is this useful information?

Yes.

>  - Do you want results for each rc release posted to the mailing list?

Yes, ideally in some terse form with the summary lines only, the full
list of Failures seems too much. Tuning fstests to run with 0 failures
involves adding expunges/excludes or other workarounds.

Another idea is to post only the diff from one week to another, once
some baseline is established.

> 
> [0] https://github.com/linux-kdevops/kdevops/blob/main/playbooks/roles/fstests/templates/btrfs/btrfs.config
> [1] https://github.com/linux-kdevops/kdevops/blob/main/workflows/fstests/btrfs/Kconfig

There are some configured options that are default, like the
discard=async, so they can be removed for the configs related to
mainline.

