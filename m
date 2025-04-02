Return-Path: <linux-btrfs+bounces-12764-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F46A79919
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Apr 2025 01:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 980C67A4957
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Apr 2025 23:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD1C1F55E0;
	Wed,  2 Apr 2025 23:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QobiYmDH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FQojC/KK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vZKPD4LM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DWtJyz1W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161751F3B83
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Apr 2025 23:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743637515; cv=none; b=Ah5r0YXXZgyNY1IWo+G7rB7+KlV2HgZSTqNFa2PCw6LHSi3dMzWy7L3uZGnCIIQ+0xROHZPmKhrwYsHiECfH0spXZShCNbv83ApNYHUKL4ACQSszC17X28oovJ1cBxzdvKOgPq8e7z9xlZBDg/yLHzDjczUVk2QOtTK5CwrISLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743637515; c=relaxed/simple;
	bh=APkondp1OaqV+NTikYgwuBuacDkrcRd5c1sSTX82Ins=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYvLlYLzR7WjJ2mlZspgxppI+4ftTSJEmpASLULb16ITl8evQEQN4NIIrvkc+QIIyNgsmkz26fXL8JfT7NQq0JDXMej84lN3wwflSUJ4a6+EoQYY7dUcLWcNb+QpXRNpVDGrr+bIQxXeB/nHG+6GhXWhH//BSU+wB2/gg+WeUYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QobiYmDH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FQojC/KK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vZKPD4LM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DWtJyz1W; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E81F31F78A;
	Wed,  2 Apr 2025 23:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743637511;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g4ANhn8Jw3ZNDunExEvogwxKbJmB0AKs+3f1akdYS8I=;
	b=QobiYmDHkvffPxfq85H7ALMh+0bxHHZcGmtkondKz+5VRshJA3HtkIMchZvs5EG1uAFTWl
	yclFgeS4e8kJTEsVMIhT8V9P8UCXIDMcQcRUjhyc6NSdJIa5SCW1tWF3C4qqPlTXUKrJ/M
	rwqlkF08polE/uftBLyWGvPfKCp6eKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743637511;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g4ANhn8Jw3ZNDunExEvogwxKbJmB0AKs+3f1akdYS8I=;
	b=FQojC/KKoaul+YduiQkatjVF9a0Uk+i8DfWxOAq4i2tFJCUsXkXUxtTbgi3drRhFN0XDSS
	Gjq7GcdPXii0KsAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vZKPD4LM;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=DWtJyz1W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743637510;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g4ANhn8Jw3ZNDunExEvogwxKbJmB0AKs+3f1akdYS8I=;
	b=vZKPD4LMl83Vs6fs9iMRcB4eXuQMK8O5GIL9tT3URVmO5RqKqttJEWNIZdemY7E/OsXp6w
	dO710ZRP2OnCTf5lFTBZHR+jWM2hY6+wfe6bIeRAT6/Y3WJDUZwdnZKThlaURwXNeGC2qo
	kU++x3YCn1teOSWJxitRYLA6h65Os30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743637510;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g4ANhn8Jw3ZNDunExEvogwxKbJmB0AKs+3f1akdYS8I=;
	b=DWtJyz1WoQIY7jDNbTIWd1gfhcZviC977utquG9beQ3iibi8FeoOnZFvoKlAt55+VVMsn5
	xVwtMOroO9lAMODw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D064313A4B;
	Wed,  2 Apr 2025 23:45:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Oh9QMgbM7WffSgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 02 Apr 2025 23:45:10 +0000
Date: Thu, 3 Apr 2025 01:45:09 +0200
From: David Sterba <dsterba@suse.cz>
To: David Disseldorp <ddiss@suse.de>
Cc: David Sterba <dsterba@suse.cz>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/7] btrfs: do more trivial BTRFS_PATH_AUTO_FREE
 conversions
Message-ID: <20250402234509.GR32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1743549291.git.dsterba@suse.com>
 <b4a20aa684dc9f0324c7fe4728c1829a8b996f71.1743549291.git.dsterba@suse.com>
 <20250402113951.06f43687.ddiss@suse.de>
 <20250402220225.GP32661@twin.jikos.cz>
 <20250403101409.65af0c9f.ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403101409.65af0c9f.ddiss@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: E81F31F78A
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Thu, Apr 03, 2025 at 10:14:09AM +1100, David Disseldorp wrote:
> On Thu, 3 Apr 2025 00:02:25 +0200, David Sterba wrote:
> 
> > On Wed, Apr 02, 2025 at 11:39:51AM +1100, David Disseldorp wrote:
> > > Hi David
> > > 
> > > On Wed,  2 Apr 2025 01:18:06 +0200, David Sterba wrote:
> > >   
> > > > @@ -308,7 +308,7 @@ int btrfs_truncate_free_space_cache(struct btrfs_trans_handle *trans,
> > > >  	bool locked = false;
> > > >  
> > > >  	if (block_group) {
> > > > -		struct btrfs_path *path = btrfs_alloc_path();
> > > > +		BTRFS_PATH_AUTO_FREE(path);
> > > >  
> > > >  		if (!path) {
> > > >  			ret = -ENOMEM;  
> > > 
> > > This one looks broken. btrfs_search_slot() needs it allocated.  
> > 
> > Sorry, I don't see what you mean. There's no btrfs_search_slot() in
> > btrfs_truncate_free_space_cache(), perhaps you mean a different
> > function?
> 
> This will jump straight through to the -ENOMEM goto fail path... What am
> I missing here?
> With 91e5bfe317d8f8471fbaa3e70cf66cae1314a516 I see:
> #define BTRFS_PATH_AUTO_FREE(path_name)                                 \              
>         struct btrfs_path *path_name __free(btrfs_free_path) = NULL 
> 
> I would expect your change to instead be something like:
> 
>    BTRFS_PATH_AUTO_FREE(path);
>    path = btrfs_alloc_path();

Duh, of course, you're right, thanks for catching it.

