Return-Path: <linux-btrfs+bounces-12763-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35343A7989B
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Apr 2025 01:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D0C3B1521
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Apr 2025 23:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B158F1F6699;
	Wed,  2 Apr 2025 23:14:24 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375ED1F6664
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Apr 2025 23:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743635664; cv=none; b=pXHRAfbbH7833IgkbnYitXzrskW5y3ZfkEaQrM1OYsMb0RjW7C2ToAo0BaGIqrNYiWbN3pOcLQlF0OF/i7+dFTpc/rxG+4wv4HpAgu+MPivvVJTqcfWd/eRhQwA0F1GR4MxsOGJB5LcozTC8dvYsCpST4Kk8fI7z379fHogvYqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743635664; c=relaxed/simple;
	bh=bh9FwyKO7MQC0dAcf0+70DDV4wyZEO73Pwk2Ndhp8eE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q+CKAExWGSnTH/x9EaUlgAJC2tpgwup9+apA9qASJ8MrTGe6igcueBW4F29qw4UaPTw7ELUcMdqW9cm25xVTRWCrvLlOs1334Itx8nte0NbKZm7BVfz81WWj9RB/80jG3ZncshhKwlzXGLStQJ5gVvNY2txKgzgmN5DSZid9EMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 44D741F385;
	Wed,  2 Apr 2025 23:14:20 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D2CF3137D4;
	Wed,  2 Apr 2025 23:14:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VE7HIsrE7WcZQwAAD6G6ig
	(envelope-from <ddiss@suse.de>); Wed, 02 Apr 2025 23:14:18 +0000
Date: Thu, 3 Apr 2025 10:14:09 +1100
From: David Disseldorp <ddiss@suse.de>
To: David Sterba <dsterba@suse.cz>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/7] btrfs: do more trivial BTRFS_PATH_AUTO_FREE
 conversions
Message-ID: <20250403101409.65af0c9f.ddiss@suse.de>
In-Reply-To: <20250402220225.GP32661@twin.jikos.cz>
References: <cover.1743549291.git.dsterba@suse.com>
	<b4a20aa684dc9f0324c7fe4728c1829a8b996f71.1743549291.git.dsterba@suse.com>
	<20250402113951.06f43687.ddiss@suse.de>
	<20250402220225.GP32661@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 44D741F385
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

On Thu, 3 Apr 2025 00:02:25 +0200, David Sterba wrote:

> On Wed, Apr 02, 2025 at 11:39:51AM +1100, David Disseldorp wrote:
> > Hi David
> > 
> > On Wed,  2 Apr 2025 01:18:06 +0200, David Sterba wrote:
> >   
> > > @@ -308,7 +308,7 @@ int btrfs_truncate_free_space_cache(struct btrfs_trans_handle *trans,
> > >  	bool locked = false;
> > >  
> > >  	if (block_group) {
> > > -		struct btrfs_path *path = btrfs_alloc_path();
> > > +		BTRFS_PATH_AUTO_FREE(path);
> > >  
> > >  		if (!path) {
> > >  			ret = -ENOMEM;  
> > 
> > This one looks broken. btrfs_search_slot() needs it allocated.  
> 
> Sorry, I don't see what you mean. There's no btrfs_search_slot() in
> btrfs_truncate_free_space_cache(), perhaps you mean a different
> function?

This will jump straight through to the -ENOMEM goto fail path... What am
I missing here?
With 91e5bfe317d8f8471fbaa3e70cf66cae1314a516 I see:
#define BTRFS_PATH_AUTO_FREE(path_name)                                 \              
        struct btrfs_path *path_name __free(btrfs_free_path) = NULL 

I would expect your change to instead be something like:

   BTRFS_PATH_AUTO_FREE(path);
   path = btrfs_alloc_path();

