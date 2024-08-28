Return-Path: <linux-btrfs+bounces-7626-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF59962D2F
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 18:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 741CD1F21517
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 16:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959E51A38FC;
	Wed, 28 Aug 2024 16:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YKZtJsWB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RObWFX4R";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JDAszp+2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DqeX5W2D"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76D67E574
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2024 16:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724860973; cv=none; b=D42ZRtdakDeBA7EbjTVuNoxblHL/T/VJCSyHqxdsQFnvdcD4z9JngnEEdfyoRkjeZbk8ERxzWG8edQ6VBQ7hjLBYsUe5i4DvGtFf5n4QP0Nu/pawIOgNlN+jFTH3dSm4QkffEq8SPvsZ39gil4g/6sp+5fA5tClv8KapTNw2viE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724860973; c=relaxed/simple;
	bh=oCLjDEQb4gcPoI1crBx2CtzSYayZ0nvjO60tRUoaemk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGczlaT/vCnSnhWDVPR5gd0RgGMbnexaC0t79a2a2C1ibKN8vmfSK664ZJsYn3q/bHW2FOcss90szGrQ+LTCw+ddNgF7Bi6JlwsiKD59/qHWoDJfgQQqiZ9fQHRfetnQBoaNM0JMKOZ+aA7rEQHOulEP/nvsY4x2TwPkrcmsG8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YKZtJsWB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RObWFX4R; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JDAszp+2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DqeX5W2D; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F265B21B58;
	Wed, 28 Aug 2024 16:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724860970;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k5Qp2XZv1HFGanbrWyzjwUpHXfVDhq02z23VVf2G4Ac=;
	b=YKZtJsWBFAjXvSnIy/3YodzMqKBnMIWAr5mHVgHkmYfNd9TFDd+2AMNvJ9OJfKRlcKzWSc
	RH4Ay8QzCv4Lry4YPvmGK3PDeqIrhEkrl2jRqa89YO4B5x7A/wB1FyRsl7KKghP68P1Fku
	VgC9GIiMP7XKuaWF+bjK4yV7T4n1Tms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724860970;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k5Qp2XZv1HFGanbrWyzjwUpHXfVDhq02z23VVf2G4Ac=;
	b=RObWFX4RfFPTiTgWGh6CKnwsSB06f0dc0xEGJngtigrT8R1OkdVUefYjqcYuMpzItFCYdY
	2AiRTMurta8sovAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JDAszp+2;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=DqeX5W2D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724860969;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k5Qp2XZv1HFGanbrWyzjwUpHXfVDhq02z23VVf2G4Ac=;
	b=JDAszp+2cEwkiOMVawc00vdUnkcp4ReVY661kZlc/iMtRXaKckv14aXQVOPQIehimgoSTG
	OSltus0KBqNCvi4vTtW+Ay2y9TUP7yaoxnfs+yxFij+5IiV9k/hup4jCtk9RHdyt4FAHI0
	bJVhCCYqjZy+2xfaFgDWL4N4IOf1pBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724860969;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k5Qp2XZv1HFGanbrWyzjwUpHXfVDhq02z23VVf2G4Ac=;
	b=DqeX5W2DusfeDQxfCjaGc4YQC17/kO9ZgX9c57G+bk4Qvc9AUNwO8vxSFJVxtVG9hqOsxX
	rp8fPitXCLaAcXAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DBCAE138D2;
	Wed, 28 Aug 2024 16:02:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0VI6NSlKz2alXAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 28 Aug 2024 16:02:49 +0000
Date: Wed, 28 Aug 2024 18:02:44 +0200
From: David Sterba <dsterba@suse.cz>
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3 0/3] btrfs path auto free
Message-ID: <20240828160244.GH25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1724792563.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724792563.git.loemra.dev@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: F265B21B58
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Aug 27, 2024 at 03:41:30PM -0700, Leo Martins wrote:
> The DEFINE_FREE macro defines a wrapper function for a given memory
> cleanup function which takes a pointer as an argument and calls the
> cleanup function with the value of the pointer. The __free macro adds
> a scoped-based cleanup to a variable, using the __cleanup attribute
> to specify the cleanup function that should be called when the variable
> goes out of scope.
> 
> Using this cleanup code pattern ensures that memory is properly freed
> when it's no longer needed, preventing memory leaks and reducing the
> risk of crashes or other issues caused by incorrect memory management.
> Even if the code is already memory safe, using this pattern reduces
> the risk of introducing memory-related bugs in the future
> 
> In this series of patches I've added a DEFINE_FREE for btrfs_free_path
> and created a macro BTRFS_PATH_AUTO_FREE to clearly identify path
> declarations that will be automatically freed.
> 
> I've included some simple examples of where this pattern can be used.
> The trivial examples are ones where there is one exit path and the only
> cleanup performed is a call to btrfs_free_path.
> 
> There appear to be around 130 instances that would be a pretty simple to
> convert to this pattern.

I'm not sure what exactly are you counting, the number seems too much.

> Is it worth going back and updating
> all trivial instances or would it be better to leave them and use the pattern
> in new code?

Using it in new code sounds like a better option for the start so we
don't cause too much churn in code that hasn't otherwise changed for a
long time.

> Another option is to have all path declarations declared
> with BTRFS_PATH_AUTO_FREE and not remove any btrfs_free_path instances.
> In theory this would not change the functionality as it is fine to call
> btrfs_free_path on an already freed path.

That would require adding path = NULL after each btrfs_free_path() so
the auto free does not free it twice.

Changing all instances of path declarations may not be feasible, the
pattern of path freeing right before return is not that widespread,
sometimes mixed with btrfs_release_path.

I've sent some comments for v2 that I don't see fixed in v3. Also please
for patchset iterations write a short list of changes between.

