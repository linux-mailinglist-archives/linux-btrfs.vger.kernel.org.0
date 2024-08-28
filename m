Return-Path: <linux-btrfs+bounces-7601-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA2C961B04
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 02:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAAB7285177
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 00:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302C8F4E2;
	Wed, 28 Aug 2024 00:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JZe8n1SS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pDx/AY3W";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZDl1pLZ7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yLuR1RqH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF7113FFC
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2024 00:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724804188; cv=none; b=LMVs81ptHmmj/UPbdBI3r8KOcMQUmLivT8K/OD4ozek6gyZcnq6ZFi/zY3su5YTLbF2Oso7rHZfVVOLnz4+87txG63eyJ5IN/DiDuYtBXnngcqC/+5G96d70ZPEqoBho5wlko6ujIzKOi2d1Sij/C5Ihj95CD0s2OncGNGRoKkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724804188; c=relaxed/simple;
	bh=clZ2UTKVgPxyzUFKqvcKIu16hbp6kN8c4B0R2o/F6Vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4UBejA4Au59kVYcbIwFRbGcZNJzKtKM4+SYz/2i5i3etF5mkPf64rpUWlIA3wCxOhOy+Wgk27ncN91MCpdIv77F/atOoXhQiF9okFlH1vlWx3FQTgUwbLS5q92/BXB4A/YpjSG3CUKmm654dYWZP+gmenuGlbaPao7RuWDu4dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JZe8n1SS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pDx/AY3W; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZDl1pLZ7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yLuR1RqH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DF7581FB9B;
	Wed, 28 Aug 2024 00:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724804178;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ar3TNkMnSSAt9eRFlmnEaSnaRDuuGYPMkkzRbZ4FXSM=;
	b=JZe8n1SSEZF1m6pOUGTulJVzY+HibgJjOfENYFMiI2fRrpMVucJ94Ruo3icK5KbqhYmgCx
	UPvemw75uJricLDPWa41pJFemP6dVLiv3rqONJvBdD1XjbJpYdDYRo2zBR0uSHAhs3zVPM
	TPxXGKx57cmTPsp9Y5L8BvZ7X2dWEjM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724804178;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ar3TNkMnSSAt9eRFlmnEaSnaRDuuGYPMkkzRbZ4FXSM=;
	b=pDx/AY3WLg9M2LGm9HjfcFI+WgRzRNj/r5qcIbLaEW34dcCpbk4gcckYgd2PhgE7uyLEOG
	vjqK1jd94pnZU2Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724804177;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ar3TNkMnSSAt9eRFlmnEaSnaRDuuGYPMkkzRbZ4FXSM=;
	b=ZDl1pLZ7/D5qrwkJ2CQcBVE/0pD4N7DMrvRnV/okqj5nBCrIjXRFhLKwqTpYkcS6zCmvcq
	cLrXOvWVDa3alBgyXWwGTQ+zzNc3kzfDc3hq6giWRmt8vdqSjQyKBNyf2IE04d3Q05z238
	HzZdkt8KF5nbu35xmkFAaoCWhPNgiQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724804177;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ar3TNkMnSSAt9eRFlmnEaSnaRDuuGYPMkkzRbZ4FXSM=;
	b=yLuR1RqHtazXgfZLEqqGDK0NTkYQbHwzbjmJ3EOIVIieBNOtT+5Xu50YgqdAPKwuWdYhza
	c32B/xtAfOimJlDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF4F11373A;
	Wed, 28 Aug 2024 00:16:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZeQ7LlFszmYJQAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 28 Aug 2024 00:16:17 +0000
Date: Wed, 28 Aug 2024 02:16:01 +0200
From: David Sterba <dsterba@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Leo Martins <loemra.dev@gmail.com>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH v2 1/3] btrfs: DEFINE_FREE for btrfs_free_path
Message-ID: <20240828001601.GC25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1724785204.git.loemra.dev@gmail.com>
 <6951e579322f1389bcc02de692a696880edb2a7e.1724785204.git.loemra.dev@gmail.com>
 <20240827203058.GA2576577@perftesting>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827203058.GA2576577@perftesting>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -2.50
X-Spamd-Result: default: False [-2.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.988];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,fb.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Aug 27, 2024 at 04:30:58PM -0400, Josef Bacik wrote:
> On Tue, Aug 27, 2024 at 12:08:43PM -0700, Leo Martins wrote:
> > Add a DEFINE_FREE for btrfs_free_path. This defines a function that can
> > be called using the __free attribute. Defined a macro
> > BTRFS_PATH_AUTO_FREE to make the declaration of an auto freeing path
> > very clear.
> > ---
> >  fs/btrfs/ctree.c | 2 +-
> >  fs/btrfs/ctree.h | 4 ++++
> >  2 files changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> > index 451203055bbfb..f0bdea206d672 100644
> > --- a/fs/btrfs/ctree.c
> > +++ b/fs/btrfs/ctree.c
> > @@ -196,7 +196,7 @@ struct btrfs_path *btrfs_alloc_path(void)
> >  /* this also releases the path */
> >  void btrfs_free_path(struct btrfs_path *p)
> >  {
> > -	if (!p)
> > +	if (IS_ERR_OR_NULL(p))
> >  		return;
> >  	btrfs_release_path(p);
> >  	kmem_cache_free(btrfs_path_cachep, p);
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index 75fa563e4cacb..babc86af564a2 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -6,6 +6,7 @@
> >  #ifndef BTRFS_CTREE_H
> >  #define BTRFS_CTREE_H
> >  
> > +#include "linux/cleanup.h"
> >  #include <linux/pagemap.h>
> >  #include <linux/spinlock.h>
> >  #include <linux/rbtree.h>
> > @@ -599,6 +600,9 @@ int btrfs_search_slot_for_read(struct btrfs_root *root,
> >  void btrfs_release_path(struct btrfs_path *p);
> >  struct btrfs_path *btrfs_alloc_path(void);
> >  void btrfs_free_path(struct btrfs_path *p);
> > +DEFINE_FREE(btrfs_free_path, struct btrfs_path *, if (!IS_ERR_OR_NULL(_T)) btrfs_free_path(_T))
> 
> Remember to run "git commit -s" so you get your signed-off-by automatically
> added.
> 
> You don't need the extra IS_ERR_OR_NULL bit if the free has it, so you can keep
> the change above and just have btrfs_free_path(_T) here.  Thanks,

The pattern I'd suggest is to keep the special NULL checks in the
functions so it's obvious that it's done, the macro wrapping the cleanup
functil will be a simple call to the freeing function.

