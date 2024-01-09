Return-Path: <linux-btrfs+bounces-1326-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C21788289EB
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jan 2024 17:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D5FC286B3F
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jan 2024 16:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBCD3A1D0;
	Tue,  9 Jan 2024 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OhE+Cs7W";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Za91Z5/x";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QuqPDQqX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z0Kuavmt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3962939FFC
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Jan 2024 16:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2630521E5B;
	Tue,  9 Jan 2024 16:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704817455;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZI8etPH5p266ML+mme6shSYxSB8QOPuOi/8aXYuKcu0=;
	b=OhE+Cs7WeFzZR1TJfjtHgd2klkyHNxmj0u3wZLOGE95iTUmZRM/hxB8n+2JHIi2M2ojb95
	DWF9ITv56+ftg+SLq3Nz14zIirKojmMYNFqe22UOv3/JgbClL9y7S1u8JGuDIcuxUWVjhn
	JRETWCdCa4YuonpVkkw67Q74yp2COqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704817455;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZI8etPH5p266ML+mme6shSYxSB8QOPuOi/8aXYuKcu0=;
	b=Za91Z5/xb5jKJpsLdh4qpi7J8ANfW7aX2cUKOAlVr9R5pPuYCOz8RpVPY9tIWhC3b8o4cb
	Yrg6rcNNMvZV1yDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704817454;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZI8etPH5p266ML+mme6shSYxSB8QOPuOi/8aXYuKcu0=;
	b=QuqPDQqXNUNbeOdOJfZi3mk6fsfYwk9s4jAl3VAt/r/oDXbpT8AIioyPOVg10pqkgFiRsN
	XGPeV7GBL9Odtk6lB6rEoBfrkdmO7HAbo6r6DbIWnHMVCXn6KqFvyl/153N+CrMJwOYXJX
	KHrpTfHNTFpAYaEIZCbgImVvPwJ+Lac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704817454;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZI8etPH5p266ML+mme6shSYxSB8QOPuOi/8aXYuKcu0=;
	b=Z0KuavmtNZgLvJ74w8HmWUZ+Xb3HMfKTjiNQwwyOTggdLVRUtoOPWjQJNuNH6ekgsmQ37T
	+34tzR9yPTgDE+Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 042A3134E8;
	Tue,  9 Jan 2024 16:24:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r8GSAC5znWXadAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 09 Jan 2024 16:24:14 +0000
Date: Tue, 9 Jan 2024 17:23:59 +0100
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] btrfs-progs Documentation: placeholder for
 contents.rst file
Message-ID: <20240109162359.GK28693@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1704438755.git.anand.jain@oracle.com>
 <b30031c129e92c7e99c7e5bc818a456cd5828cc8.1704438755.git.anand.jain@oracle.com>
 <20240108213325.GI28693@twin.jikos.cz>
 <328e7958-6b77-093a-f3be-bcb07e85e0eb@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <328e7958-6b77-093a-f3be-bcb07e85e0eb@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-1.22 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.22)[72.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -1.22

On Tue, Jan 09, 2024 at 09:25:37PM +0800, Anand Jain wrote:
> 
> 
> 
> On 09/01/2024 05:33, David Sterba wrote:
> > On Mon, Jan 08, 2024 at 04:31:08PM +0800, Anand Jain wrote:
> >> For now, to circumvent the build error, create a placeholder file
> >> named contents.rst.
> >>
> >> Sphinx error:
> >> master file btrfs-progs/Documentation/contents.rst not found
> > 
> > I don't see that error with sphinx 7.2.6, which version do you use?
> > 
> 
>    python3-sphinx-3.4.3-7.el9.noarch  -- no issues
>    python3-sphinx-1.7.6-3.el8.noarch  -- build errors as above.
> 
> 
> >> make[1]: *** [Makefile:37: man] Error 2
> >> make: *** [Makefile:502: build-Documentation] Error 2
> >>
> >> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> >> ---
> >> RFC because the empty contents.rst to fix the error.
> > 
> > Adding an empty file to silence the error is probably ok but what's the
> > reason to have it?
> 
> While contents.rst similar to index.rst with its Table of Contents
> (TOC) and toctree directives. But, I am not sure yet if we can replace
> index.rst with contents.rst. And doing it ended up with multiple errors.
> So, I abandoned the idea, restored to creating an empty file instead.
> It appears that contents.rst is needed only in older versions like'
> 1.7.6.

Ok then, the empty file would be a fix but it leads to this warning on a
newer version:

.../contents.rst: WARNING: document isn't included in any toctree

We could add it conditionally at build time in case the sphinx version
is old, with something like that:

.PHONY: contents.rst

contents.rst:
	if "sphinx --version < 3.2.1"; then touch contents.rst; fi

