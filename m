Return-Path: <linux-btrfs+bounces-13627-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F8FAA738A
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 15:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C1AD9A2C65
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 13:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C562561D1;
	Fri,  2 May 2025 13:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XV+KFyrM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rO6tI9ia";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XV+KFyrM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rO6tI9ia"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696C2254B1D
	for <linux-btrfs@vger.kernel.org>; Fri,  2 May 2025 13:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746192256; cv=none; b=uyZL8tEX0zQe0nVztRs48Vzc8++nH6AI9Lh+XH2eC7ijEkWTTXjnUXarN+OvYSy9IyCXtZBOSwKzi3m1YTN29TuNxmD1pOXbRUzcvKyd731/7bEg5tcQ+gXzc7iBa2OJTSkIm4VWwhHwq8i38msTRl54wc8llVL2nyZgu4+1ngY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746192256; c=relaxed/simple;
	bh=AvBGsxZlHEo42WauqbeRouOMKyBWoVRrFOVdHWTB8jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rnq4t/19i/cMpY8QoBEBaQFTzRmXkw7f9KrYaa5v7YB1KG0mUKQZuQ3deo6URUuPCZ32kps/nk8LXklTP1qycaO4QcqrXiZ55us+56K9ZbHcgGfyJD/aqhSenn3B9P5jB1VgvIRB0aQ6ExVtxLJKtVDU4mcq5BsaztFA17BYCeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XV+KFyrM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rO6tI9ia; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XV+KFyrM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rO6tI9ia; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 670D821264;
	Fri,  2 May 2025 13:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746192252;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MD1sx5gCBs9TgA/3Z3qZVmMz9v5Vb5IDfb2KTSu16WM=;
	b=XV+KFyrMUVf+2zPQQNe7/IZ96fJ4zyDrr5ErazjMU1H4KJaH6TbxKhAORxAK6OGiRHoODp
	itbnmNouRzzlC6ajeqKMSBadHcfjC/wZ3j1nd0HnSmfJKZ2TkOlqwO8HYPx3Z83Ew5UsoP
	dahRWPfq9xZcLoKApaLeH5shIoVXJ00=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746192252;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MD1sx5gCBs9TgA/3Z3qZVmMz9v5Vb5IDfb2KTSu16WM=;
	b=rO6tI9ia7r4I3sxvYIyntmOPhpc2eTqeT7UqO+SnLtnDwgL9/tUF6DSoYKFsDwj1AA4nAp
	SVgJJoRPY4BB4tCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746192252;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MD1sx5gCBs9TgA/3Z3qZVmMz9v5Vb5IDfb2KTSu16WM=;
	b=XV+KFyrMUVf+2zPQQNe7/IZ96fJ4zyDrr5ErazjMU1H4KJaH6TbxKhAORxAK6OGiRHoODp
	itbnmNouRzzlC6ajeqKMSBadHcfjC/wZ3j1nd0HnSmfJKZ2TkOlqwO8HYPx3Z83Ew5UsoP
	dahRWPfq9xZcLoKApaLeH5shIoVXJ00=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746192252;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MD1sx5gCBs9TgA/3Z3qZVmMz9v5Vb5IDfb2KTSu16WM=;
	b=rO6tI9ia7r4I3sxvYIyntmOPhpc2eTqeT7UqO+SnLtnDwgL9/tUF6DSoYKFsDwj1AA4nAp
	SVgJJoRPY4BB4tCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 448BE13687;
	Fri,  2 May 2025 13:24:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 13+8D3zHFGgVGgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 02 May 2025 13:24:12 +0000
Date: Fri, 2 May 2025 15:24:07 +0200
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] Transaction aborts in free-space-tree.c
Message-ID: <20250502132407.GR9140@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1746031378.git.dsterba@suse.com>
 <CAPjX3FcAA=2cR4WqxFUOXZ4zYHS8hS75-ii0HPKQddgwhtr=Vg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPjX3FcAA=2cR4WqxFUOXZ4zYHS8hS75-ii0HPKQddgwhtr=Vg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Fri, May 02, 2025 at 03:15:49PM +0200, Daniel Vacek wrote:
> On Wed, 30 Apr 2025 at 18:45, David Sterba <dsterba@suse.com> wrote:
> >
> > Fix the transaction abort pattern in free-space-tree, it's been there
> > from the beginning and not conforming to the pattern we use elsewhere.
> >
> > David Sterba (4):
> >   btrfs: move transaction aborts to the error site in
> >     convert_free_space_to_bitmaps()
> >   btrfs: move transaction aborts to the error site in
> >     convert_free_space_to_extents()
> >   btrfs: move transaction aborts to the error site in
> >     remove_from_free_space_tree()
> >   btrfs: move transaction aborts to the error site in
> >     add_to_free_space_tree()
> >
> >  fs/btrfs/free-space-tree.c | 48 +++++++++++++++++++++++++-------------
> >  1 file changed, 32 insertions(+), 16 deletions(-)
> 
> This looks like unnecessary duplicating the code. Shall we rather go
> the other way around?

What do you mean? There's some smilarity among the functions so yeah
the add/remove pairs can be merged to one, but this is orthogonal to the
transaction abot calls.

