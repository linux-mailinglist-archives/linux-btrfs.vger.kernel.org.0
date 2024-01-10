Return-Path: <linux-btrfs+bounces-1337-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7EF829199
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 01:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B4F2285E8C
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 00:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071F7644;
	Wed, 10 Jan 2024 00:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xidxSA0U";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="W6gEhKJM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xidxSA0U";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="W6gEhKJM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFEC383
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 00:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 643421F840;
	Wed, 10 Jan 2024 00:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704847691;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JyNUMEkcUYtHVV6RKmiIE5M1YEkerTpLStUdjvVpqxc=;
	b=xidxSA0Ugv4sDrFsul/zjLrToh6Mpi1Z0t4ZCwfO3zAKXniI2NOATtgusqiXfLBBhoQGTu
	aGXbvQfogLYHk/DGqE13zCgKDwITNDlIY9rb7NOxsNwn729nxvnAJwv7m1ivZtdp7RIjcM
	ZcTFra11UrU7tT5rFQzFEyCVYW1YdwQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704847691;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JyNUMEkcUYtHVV6RKmiIE5M1YEkerTpLStUdjvVpqxc=;
	b=W6gEhKJMqDrIUtW7W+MhSv3OhU8Tl3AK4QBMeVoKZiemVIul+NE6qbq/EbhyQuAYWvgfRW
	RA3ZozpM/I+90NAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704847691;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JyNUMEkcUYtHVV6RKmiIE5M1YEkerTpLStUdjvVpqxc=;
	b=xidxSA0Ugv4sDrFsul/zjLrToh6Mpi1Z0t4ZCwfO3zAKXniI2NOATtgusqiXfLBBhoQGTu
	aGXbvQfogLYHk/DGqE13zCgKDwITNDlIY9rb7NOxsNwn729nxvnAJwv7m1ivZtdp7RIjcM
	ZcTFra11UrU7tT5rFQzFEyCVYW1YdwQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704847691;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JyNUMEkcUYtHVV6RKmiIE5M1YEkerTpLStUdjvVpqxc=;
	b=W6gEhKJMqDrIUtW7W+MhSv3OhU8Tl3AK4QBMeVoKZiemVIul+NE6qbq/EbhyQuAYWvgfRW
	RA3ZozpM/I+90NAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4297A13786;
	Wed, 10 Jan 2024 00:48:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Nn7ED0vpnWX8ZgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 10 Jan 2024 00:48:11 +0000
Date: Wed, 10 Jan 2024 01:47:52 +0100
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] btrfs-progs Documentation: placeholder for
 contents.rst file
Message-ID: <20240110004752.GL28693@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1704438755.git.anand.jain@oracle.com>
 <b30031c129e92c7e99c7e5bc818a456cd5828cc8.1704438755.git.anand.jain@oracle.com>
 <20240108213325.GI28693@twin.jikos.cz>
 <328e7958-6b77-093a-f3be-bcb07e85e0eb@oracle.com>
 <20240109162359.GK28693@twin.jikos.cz>
 <542615e6-fad2-3469-f173-f761e33880a6@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <542615e6-fad2-3469-f173-f761e33880a6@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: ***
X-Spam-Score: 3.50
X-Spamd-Result: default: False [3.50 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.00)[43.07%];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO

On Wed, Jan 10, 2024 at 06:06:11AM +0530, Anand Jain wrote:
> >>>> ---
> >>>> RFC because the empty contents.rst to fix the error.
> >>>
> >>> Adding an empty file to silence the error is probably ok but what's the
> >>> reason to have it?
> >>
> >> While contents.rst similar to index.rst with its Table of Contents
> >> (TOC) and toctree directives. But, I am not sure yet if we can replace
> >> index.rst with contents.rst. And doing it ended up with multiple errors.
> >> So, I abandoned the idea, restored to creating an empty file instead.
> >> It appears that contents.rst is needed only in older versions like'
> >> 1.7.6.
> > 
> > Ok then, the empty file would be a fix but it leads to this warning on a
> > newer version:
> > 
> > .../contents.rst: WARNING: document isn't included in any toctree
> > 
> > We could add it conditionally at build time in case the sphinx version
> > is old, with something like that:
> > 
> > .PHONY: contents.rst
> > 
> > contents.rst:
> > 	if "sphinx --version < 3.2.1"; then touch contents.rst; fi
> 
> Ah. Thanks let me try.
> 
> Also, I am testing it manually using man, is there anything I am missing?

I think not, the manual pages are default build target, although you can
also try 'make html' if it's without warnings.

