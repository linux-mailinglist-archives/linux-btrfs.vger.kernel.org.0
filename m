Return-Path: <linux-btrfs+bounces-4076-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A952E89E433
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 22:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 354F51F22166
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 20:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDB7158202;
	Tue,  9 Apr 2024 20:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tJwGHGeB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qoAYXa17";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gmruwtvu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xnmgCK9/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7F3157E79
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Apr 2024 20:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712693513; cv=none; b=jRc7uM0EZGu2DnzAC4kW7fRLagCQ7QTd99F1xK0rizJO5P3a5QlTK1Dv11OrNUh4N9zV1hSU+b7+HHvX2nCJYYyXH94wKPS3jL+Y+D5xObpL6Y+qstCpFEm42vP8vw/lpWKrKVaKmdAzLBxRNWDh5euHPswFLp2BjdbBgFM3zf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712693513; c=relaxed/simple;
	bh=5v20anIEqVDazhQCu9E7vQZi8BbakPuZ5aVCmu8buBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJy5lsJnM3rGbYOFmPXKL2v1ClEDfrrfUG75bGfx/UooJhVDHxd0xsXuZ3vYkbY5zkBCB4v8mmRK4Vzm9VCP3pTjhFRarGb543t+l2beNrDlNDA9cNaFUclJwBNGwlEnnYa1drUlW37eBMbZQ34GeOXh3PjinjJy16LgFjl+K+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tJwGHGeB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qoAYXa17; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gmruwtvu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xnmgCK9/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 36A3620E5F;
	Tue,  9 Apr 2024 20:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712693509;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NV/Ht7oyG1vjeYxvUoQCQYhd/PpyH7qzdbblDIqVG/Y=;
	b=tJwGHGeBI8X5O8BPCFsxSyA4gNaIy2HfjlqAIKeMiYuiyZo8DSmY1yNvGBBnh0uXZ2XL6y
	R6X3AjzQRyWjKU+V4epY0hVkw4TS65t1zcYWuqjxJ1rLXqFhGw2l9QYpGKvGty5QxKr1O4
	qw43lb6GiVH1HK6bbVinCJnjouMQDFI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712693509;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NV/Ht7oyG1vjeYxvUoQCQYhd/PpyH7qzdbblDIqVG/Y=;
	b=qoAYXa17mC14zMcew8MKcT7j1pSAQWCklViM0vxgWuD3OJN0afdiShOOZ+mZBu6AFga6yz
	Cr0v9qUX/YXJh1DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712693508;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NV/Ht7oyG1vjeYxvUoQCQYhd/PpyH7qzdbblDIqVG/Y=;
	b=gmruwtvuuLyFV44hX03QlGBz9KbFthMYEqstbp7ZB3f9YeRFsxpftyogD+6d88H4Gg19oF
	GzSIjc8ZXnLjEZo3n8gG1JSWQJsnBhBvMCEcRTYEeXxdFjes9wnL4OAvZ12hiw9PfSnHXa
	tgms92XdS3juYwPPjLhgLJku7lFzsaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712693508;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NV/Ht7oyG1vjeYxvUoQCQYhd/PpyH7qzdbblDIqVG/Y=;
	b=xnmgCK9/hIjYG8/JE2BpcNaEz+Fvz5Gs1l/8VMtwWs7oTV1rVd20Z1xAC2fMCSGyoOGsKe
	nhCMy0S6tdYK4GAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 20CDA1332F;
	Tue,  9 Apr 2024 20:11:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id kyt6BwShFWZKTwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 09 Apr 2024 20:11:48 +0000
Date: Tue, 9 Apr 2024 22:04:18 +0200
From: David Sterba <dsterba@suse.cz>
To: "David F." <df7729@gmail.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: Preconfigured BTRFS Virtual Drives for testing?
Message-ID: <20240409200418.GK3492@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <CAGRSmLtrH7GNzAE2o69qvfEMk9mTR1a=zUq36dzwkCeQTz7F8A@mail.gmail.com>
 <f1e7424c-64a8-4752-8a36-fa08f902ce7b@gmx.com>
 <CAGRSmLuKoYmxVJ+w=Bb2RxXUi6Z79mU+yLmxhc_OfWtmkhFg8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGRSmLuKoYmxVJ+w=Bb2RxXUi6Z79mU+yLmxhc_OfWtmkhFg8Q@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-0.00 / 50.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.00)[22.89%];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmx.com,vger.kernel.org];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns]
X-Spam-Score: -0.00
X-Spam-Flag: NO

On Sat, Apr 06, 2024 at 12:31:14AM -0700, David F. wrote:
> How can I set up btrfs so that the chunk_tree, extent_tree, and root
> of roots all exist with all 8 levels (0-7) in use (or say I only want
> 4 levels)?

Not all roots are filled with enough data that would lead to tree height
more than 2, the extent tree usually is the highest one.

Reaching high levels by incrementally inserting items would be quite
time consuming, best would be to build the trees from bottom but then
it's a bit artificial and all the constraints would have to be
satisfied.

I did a quick calculation how much space would be consumed by one tree
with 4096 node size, each node half filled (so they're not merged). I
don't think you'd be able to store images of filesystems above level 4:

Node size: 4096
Node keys per level max: 121
Node keys per level min: 60

level 0 nodemin=             1 nodemax=               1 (sizemin=   4.000K) (sizemax=   4.000K)
level 1 nodemin=            60 nodemax=             121 (sizemin= 240.000K) (sizemax= 484.000K)
level 2 nodemin=          3600 nodemax=           14641 (sizemin=  14.062M) (sizemax=  57.191M)
level 3 nodemin=        216000 nodemax=         1771561 (sizemin= 843.750M) (sizemax=   6.758G)
level 4 nodemin=      12960000 nodemax=       214358881 (sizemin=  49.438G) (sizemax= 817.714G)
level 5 nodemin=     777600000 nodemax=     25937424601 (sizemin=   2.897T) (sizemax=  96.624T)
level 6 nodemin=   46656000000 nodemax=   3138428376721 (sizemin= 173.807T) (sizemax=  11.418P)
level 7 nodemin= 2799360000000 nodemax= 379749833583241 (sizemin=  10.184P) (sizemax=   1.349E)

The min means the nodes are half filled, max is using the full capacity.

For comparison with 16K node size:

Node keys per level max: 493
Node keys per level min: 246

level 0 nodemin=                 1 nodemax=                   1 (sizemin=  16.000K) (sizemax=     16.000K)
level 1 nodemin=               246 nodemax=                 493 (sizemin=   3.844M) (sizemax=      7.703M)
level 2 nodemin=             60516 nodemax=              243049 (sizemin= 945.562M) (sizemax=      3.709G)
level 3 nodemin=          14886936 nodemax=           119823157 (sizemin= 227.157G) (sizemax=      1.786T)
level 4 nodemin=        3662186256 nodemax=         59072816401 (sizemin=  54.571T) (sizemax=    880.254T)
level 5 nodemin=      900897818976 nodemax=      29122898485693 (sizemin=  13.110P) (sizemax=    423.794P)
level 6 nodemin=   221620863468096 nodemax=   14357588953446649 (sizemin=   3.149E) (sizemax=    204.034E)
level 7 nodemin= 54518732413151616 nodemax= 7078291354049197957 (sizemin= 774.758E) (sizemax= 100588.570E)

