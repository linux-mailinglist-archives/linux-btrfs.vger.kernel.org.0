Return-Path: <linux-btrfs+bounces-1395-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B850182B210
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jan 2024 16:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 510E62859D0
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jan 2024 15:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FF64F217;
	Thu, 11 Jan 2024 15:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T0C2mlLz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rZ1rIsym";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T0C2mlLz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rZ1rIsym"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B7A4CE01;
	Thu, 11 Jan 2024 15:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 966621FBAD;
	Thu, 11 Jan 2024 15:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704987991;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nyGnkTpDkCQODLv1dHvo4JLTb7MOnektuQjecIOtmts=;
	b=T0C2mlLzu9Wa4doab1YB0VeC/jFGkKhj7JFUn1xN5bMAjSNpr1/9ld8pl92+gvlDJUen25
	GnfwH0JDD6AMhECVWDKnCwalquGOK/tK82jVLtk3jVj5uTKuF8x1GhiKsR0GNYNIakVbZQ
	sEPeiKm8BIulb3afxkQ50YkrLYW6Mj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704987991;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nyGnkTpDkCQODLv1dHvo4JLTb7MOnektuQjecIOtmts=;
	b=rZ1rIsymKzvyqN1n4uMj3wy/d3A4NPzBHbnEctKbWVSFYJwpjggS4pkR4Nk8ibDWtaZfTT
	wGo0Jn/r4E3bikDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704987991;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nyGnkTpDkCQODLv1dHvo4JLTb7MOnektuQjecIOtmts=;
	b=T0C2mlLzu9Wa4doab1YB0VeC/jFGkKhj7JFUn1xN5bMAjSNpr1/9ld8pl92+gvlDJUen25
	GnfwH0JDD6AMhECVWDKnCwalquGOK/tK82jVLtk3jVj5uTKuF8x1GhiKsR0GNYNIakVbZQ
	sEPeiKm8BIulb3afxkQ50YkrLYW6Mj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704987991;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nyGnkTpDkCQODLv1dHvo4JLTb7MOnektuQjecIOtmts=;
	b=rZ1rIsymKzvyqN1n4uMj3wy/d3A4NPzBHbnEctKbWVSFYJwpjggS4pkR4Nk8ibDWtaZfTT
	wGo0Jn/r4E3bikDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 79BED138E5;
	Thu, 11 Jan 2024 15:46:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id xN8/HVYNoGX3eAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 11 Jan 2024 15:46:30 +0000
Date: Thu, 11 Jan 2024 16:46:15 +0100
From: David Sterba <dsterba@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Btrfs updates for 6.8
Message-ID: <20240111154615.GF31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1704481157.git.dsterba@suse.com>
 <CAHk-=wjju0S87C+pdF=0i0hVky+HeMj1xVFwUdV867YoLheL5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjju0S87C+pdF=0i0hVky+HeMj1xVFwUdV867YoLheL5Q@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=T0C2mlLz;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rZ1rIsym
X-Spamd-Result: default: False [-0.01 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[13.52%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.01
X-Rspamd-Queue-Id: 966621FBAD
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Wed, Jan 10, 2024 at 09:34:28AM -0800, Linus Torvalds wrote:
> On Fri, 5 Jan 2024 at 11:04, David Sterba <dsterba@suse.com> wrote:
> >
> > There are possible minor merge conflicts reported by linux-next.
> 
> Bah. The block open mode changes were ugly. I did my best to make the
> end result legible.
> 
> You may want to note the btrfs_open_mode() helper I added and possibly
> do it differently.

Thanks, 1200+ lines of the merge diff certainly did not make it easy.
My local tests passed and the conflict resolution seem to do the
right thing. Josef sent a different fixup [1] altough it seems he
based it on the master branch without your resolution, but the logic
looks equivalent.

[1] https://lore.kernel.org/linux-btrfs/2fe68e18d89abb7313392c8da61aaa9881bbe945.1704917721.git.josef@toxicpanda.com/

