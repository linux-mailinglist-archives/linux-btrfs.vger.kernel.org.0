Return-Path: <linux-btrfs+bounces-2788-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C57B8673CA
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 12:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8A0EB2B076
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 11:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA0E4D58A;
	Mon, 26 Feb 2024 11:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ea2u37fl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ozh6W9l4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ea2u37fl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ozh6W9l4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A6A4C63D;
	Mon, 26 Feb 2024 11:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708947269; cv=none; b=jby4M7FfQ5sYcfM2oYBQatxzi08I5+NImDlNC70M36t2zJjd4ebSFbuehC9zqLG5ckcAmGyM+FMQztAuvnJ63FjxjA1LCZPggMy6tpUnpQuAk1sQoEsnlPchp1UoZGSz7mtNHjp4ZTmwEaNqSoIURZwkZZg/RDwAJQO8PVNHLyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708947269; c=relaxed/simple;
	bh=bkn0pttY0k0GUw+HSPoZaArKcmEbL8Oidn+P4Fb+8gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjkGeDURXEzBlkj2zKaJl6k0qkJLNNAWexhhPIRtrnPD2V4OyOPwAsb1xLP7JfNcH9ZsrY72wGMhKjNtMMWT2t9MyRD54dazCg0TX4tI2uhaxKpBo7zAUtUOFbYMM65XC/NI3MDFMQjonPFtnWeuBzlLU3GDnEdzZ/w2Jz6nuVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ea2u37fl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ozh6W9l4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ea2u37fl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ozh6W9l4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 527F32248B;
	Mon, 26 Feb 2024 11:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708947264;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=74080eP7ArZHUOM4SBsTWZXqFA3soTIrD6J7yyv/bWc=;
	b=Ea2u37fl7QPJzSqhrazZkgBBtuqbHnmC5z5SkrnsxYvzt4/9Zlvah9oBFXlQ1aWGkCLCvk
	YJNqzE1qJjaJ6NNrJxxZfoepyeyrRqkUEIMCrA1oaMu4NywM6aEsmLjyxrfP5rX97ET7IL
	/aBEJHb8yQtWp1MqN16cnItCQ1RCvuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708947264;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=74080eP7ArZHUOM4SBsTWZXqFA3soTIrD6J7yyv/bWc=;
	b=Ozh6W9l47wuE1hmPIGbRg3SAWFtg6OqCBY+Rz+GRZRkQU/dpoiUiHgOdd7xbDv261Pbdcm
	m2H+lhiDhM+Rc6Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708947264;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=74080eP7ArZHUOM4SBsTWZXqFA3soTIrD6J7yyv/bWc=;
	b=Ea2u37fl7QPJzSqhrazZkgBBtuqbHnmC5z5SkrnsxYvzt4/9Zlvah9oBFXlQ1aWGkCLCvk
	YJNqzE1qJjaJ6NNrJxxZfoepyeyrRqkUEIMCrA1oaMu4NywM6aEsmLjyxrfP5rX97ET7IL
	/aBEJHb8yQtWp1MqN16cnItCQ1RCvuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708947264;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=74080eP7ArZHUOM4SBsTWZXqFA3soTIrD6J7yyv/bWc=;
	b=Ozh6W9l47wuE1hmPIGbRg3SAWFtg6OqCBY+Rz+GRZRkQU/dpoiUiHgOdd7xbDv261Pbdcm
	m2H+lhiDhM+Rc6Dg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3975C13A43;
	Mon, 26 Feb 2024 11:34:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id tELZDUB33GXsMQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 26 Feb 2024 11:34:24 +0000
Date: Mon, 26 Feb 2024 12:33:40 +0100
From: David Sterba <dsterba@suse.cz>
To: Zorro Lang <zlang@redhat.com>
Cc: David Sterba <dsterba@suse.com>, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] generic/733: disable for btrfs
Message-ID: <20240226113340.GA17966@suse.cz>
Reply-To: dsterba@suse.cz
References: <20240222095048.14211-1-dsterba@suse.com>
 <20240225154123.pswx5nznphszonns@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240225154123.pswx5nznphszonns@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Ea2u37fl;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Ozh6W9l4
X-Spamd-Result: default: False [-0.36 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.35)[76.46%];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.36
X-Rspamd-Queue-Id: 527F32248B
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Sun, Feb 25, 2024 at 11:41:23PM +0800, Zorro Lang wrote:
> On Thu, Feb 22, 2024 at 10:50:48AM +0100, David Sterba wrote:
> > This tests if a clone source can be read but in btrfs there's an
> > exclusive lock and the test always fails. The functionality might be
> > implemented in btrfs in the future but for now disable the test.
> > 
> > CC: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> >  tests/generic/733 | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tests/generic/733 b/tests/generic/733
> > index d88d92a4705add..b26fa47dad776f 100755
> > --- a/tests/generic/733
> > +++ b/tests/generic/733
> > @@ -18,7 +18,7 @@ _begin_fstest auto clone punch
> >  . ./common/reflink
> >  
> >  # real QA test starts here
> > -_supported_fs generic
> > +_supported_fs generic ^btrfs
> 
> If only need a blacklist, you can write "^btrfs" directly, e.g.
> 
>   _supported_fs ^btrfs
> 
> then others (except btrfs) are in whitelist, don't need the "generic".

Ok thanks, do I need to resend or would you update the commit?

