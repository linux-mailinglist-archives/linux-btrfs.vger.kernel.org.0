Return-Path: <linux-btrfs+bounces-14138-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A97ABD835
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 May 2025 14:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A46D1B62794
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 May 2025 12:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC0C1C5F35;
	Tue, 20 May 2025 12:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ficsp2VO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qVmxSm/J";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xG8sgSmn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tc7n9/4x"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2CE219E8
	for <linux-btrfs@vger.kernel.org>; Tue, 20 May 2025 12:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747744173; cv=none; b=C/dW9iOKaMDWhtxsYec2vci3Rf8m1fks2rXg3NI3M0RPEyP0zLuk0oGE059AmQ0GeiQaZDuTPGwLVryfS4FB3RqibtDy8LM6/mh1XRdkueT2Vv8ZQau0whWxmFXx7roIuE2Ur8/FwMeA9gpC6dt6ZDWbJjwhe6XHAKHpFAa+A1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747744173; c=relaxed/simple;
	bh=SirNfbguh2v6Pi+0pR9CrECj+PLb/xytQD+mO/x2Lkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqE4Rjx69d09sYgwlmsBGWLsU7lKT0fF0HTTjEDj75ueWn+fRGPfiu4U/KFR6DE2EKgCGpCn1p5GG9xGxF1lhGoSdIWyQhTSmAuS5JRCdsSEbOuTCFkWv2ZumFCEENEf+ekTIveFJja1WrkTWgqcxsQBc1lPGd3OSoiSVaAbVYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ficsp2VO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qVmxSm/J; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xG8sgSmn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tc7n9/4x; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F0FE1206C5;
	Tue, 20 May 2025 12:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747744170;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rZHQkQL0rBqLlsg4bLY3XrKomfF5ZjoNjzcs8RIBheY=;
	b=ficsp2VO7JgcAtStwHEOLC+G85KBoDHjGNfAeoQpqWF0CSJsnURHvz6dh/W9/ApovN9rrz
	3Yq1DXhOT7XtiRjCp2xnNOuWKK4iUrQmuCe4RNM/7FC6Wa5a1h8FNaJOdiY1ODr8fdzLJn
	VSYoiGDHH5CUTGdJ1wy//VwswxK33oM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747744170;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rZHQkQL0rBqLlsg4bLY3XrKomfF5ZjoNjzcs8RIBheY=;
	b=qVmxSm/JcOkfTkndqegakHCVvY+NV0vDfnBtnMGftj2pWoc9bHNQhWZLxXwEhpg8vFKa4T
	SflaGbhjlrX565DA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xG8sgSmn;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="tc7n9/4x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747744169;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rZHQkQL0rBqLlsg4bLY3XrKomfF5ZjoNjzcs8RIBheY=;
	b=xG8sgSmn8UBQOQNxIQhie0xm+XIqAz0th3n2xVaRS8OESTSeB5fzUTr9LHm2/Joheq9Pvm
	77Po2Nn4VrMfTzbK+1+nrPO/RVOSwb5UC+2sWLVlY87fNgvyjM7aL7RucNJpIBwwfLdN7Z
	GsdtBJ9Q7olr2x9mKKjixi7pfQcVN7Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747744169;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rZHQkQL0rBqLlsg4bLY3XrKomfF5ZjoNjzcs8RIBheY=;
	b=tc7n9/4xsjnUeJiDfxie1VdZ/o/rFhShsiSrdHiDyRLOwchaSANS5ToIHwvZ9zit2WkqVc
	bkp1W13sQpXERdBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4D1413888;
	Tue, 20 May 2025 12:29:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id p3WmN6l1LGj6BwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 20 May 2025 12:29:29 +0000
Date: Tue, 20 May 2025 14:29:24 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: generic/537: remove the btrfs specific mount
 option
Message-ID: <20250520122924.GA19362@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250519052839.148623-1-wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519052839.148623-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Action: no action
X-Spam-Level: 
X-Rspamd-Queue-Id: F0FE1206C5
X-Spam-Score: -1.21
X-Spam-Flag: NO
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.21 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]

On Mon, May 19, 2025 at 02:58:39PM +0930, Qu Wenruo wrote:
> Although btrfs deprecated "norecovery" mount option in upstream kernel
> commit a1912f712188 ("btrfs: remove code for inode_cache and recovery
> mount options"), later "norecovery" mount option is re-introduced for
> compatibility by commit 440861b1a03c ("btrfs: re-introduce 'norecovery'
> mount option").
> 
> Instead the btrfs specific mount option "nologreplay" is already
> deprecated for a long time and is going to be removed soon.
> 
> So use the generic "norecovery" for all filesystems.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

