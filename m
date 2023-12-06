Return-Path: <linux-btrfs+bounces-684-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 159DA80635C
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 01:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5DED1F216F2
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 00:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895D436D;
	Wed,  6 Dec 2023 00:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pPMYUw4V";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YnsU4AKc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230021BD
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Dec 2023 16:21:54 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AD3D01FBFA;
	Wed,  6 Dec 2023 00:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1701822112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+l8lkWaGLB+iT1QFHdhsuycSHkvpx96T/xF8HphuKZQ=;
	b=pPMYUw4VbxnGiBEOGqD1ksG7pnB7XFDO152eqrWSG8EbpuXs0Ke4x1jjgh7gfTEbffLKGD
	lF8BN08OoY3ebgdItCQhy1KarUjMG3GsHDcIVrWLX8zq10iw+SsmwzMdY1vMsdN//ZAbg2
	Drx7SnKArFh4tm2WnSl2W8dO2zJG+0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1701822112;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+l8lkWaGLB+iT1QFHdhsuycSHkvpx96T/xF8HphuKZQ=;
	b=YnsU4AKcw7KYZTeVnLoHcPupN7z/BILEXQHuc3s/mo0ODQJjialmmRfu6e61wltQfa6KoF
	sOHY/a9Oqr46J0Ag==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2CF71139DC;
	Wed,  6 Dec 2023 00:21:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id O8GeMp6+b2VtLAAAn2gu4w
	(envelope-from <ddiss@suse.de>); Wed, 06 Dec 2023 00:21:50 +0000
Date: Wed, 6 Dec 2023 11:21:43 +1100
From: David Disseldorp <ddiss@suse.de>
To: David Sterba <dsterba@suse.cz>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: drop unused memparse() parameter
Message-ID: <20231206112143.7d1df045@echidna>
In-Reply-To: <20231205142253.GD2751@twin.jikos.cz>
References: <20231205111329.6652-1-ddiss@suse.de>
	<20231205142253.GD2751@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.65
X-Spamd-Result: default: False [-3.65 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.05)[-0.228];
	 RCPT_COUNT_TWO(0.00)[2];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[19.70%]

On Tue, 5 Dec 2023 15:22:53 +0100, David Sterba wrote:

> On Tue, Dec 05, 2023 at 10:13:29PM +1100, David Disseldorp wrote:
> > The @retptr parameter for memparse() is optional.
> > btrfs_devinfo_scrub_speed_max_store() doesn't use it for any input
> > validation, so the parameter can be dropped.  
> 
> Or should it be used for validation? memparse is also used in
> btrfs_chunk_size_store() that accepts whitespace as trailing characters
> (namely '\n' if the value is from echo).

It probably should have been used for validation when originally added,
but the current behaviour is now part of the sysfs scrub_speed_max API.
Failing on invalid input would break scripts which do things like
  echo clear > /sys/fs/btrfs/UUID/devinfo/1/scrub_speed_max

Cheers, David

