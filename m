Return-Path: <linux-btrfs+bounces-6919-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6D194340C
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 18:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7FD21F21F7C
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 16:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030381BC069;
	Wed, 31 Jul 2024 16:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qSi5+k3m";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vbzM2IlH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qSi5+k3m";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vbzM2IlH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7916F1A76C2;
	Wed, 31 Jul 2024 16:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722442861; cv=none; b=Ot5ELDhCPses5duYz639risLrog2acIkJ1AuLdoJgbqr4Os5T3ZnH/LW9Ub6QscdJgRzzG0xXtCG2K6g6YUjbImd8PYeCQdrTAIOUAJOkRJ9p8oIezlu41tEtG1v7hNEZbqQ553Awf6PFpCMe3kpZWcqSsov4AUgcOeLrEGJReo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722442861; c=relaxed/simple;
	bh=dX83oh2HuGEJQOagJRx9SFgH9vsmSDpDwNKi0FR9gZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRv6gXvIGu4a4qsdSsAjzZXPz2ptZoJrFPMOkdzjHD4PNMaPrFjKoP9US1kXjDfM1my89+9woNuvTO2S+ri/sm1K+06WAutsUY5WXBU1E0NoJgCQ23RRKkcMbjpQknvOBCEnkrPJEU00J25VfBH05SUfKNhEwKaO9jdIF6MBQAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qSi5+k3m; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vbzM2IlH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qSi5+k3m; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vbzM2IlH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B68271F82D;
	Wed, 31 Jul 2024 16:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722442857;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D9xFRjOegNiyUwD/F199FtWdIHUYh+LBaK2tIipgSv0=;
	b=qSi5+k3mMOmIuLVMSL+bvwdDG23pZMSyztHq40oJqOGXxeT918X5CPb4yq5WrlTErZ1JEq
	3SaV3NAPwrrbcS6Vp3DOdbRDQTLIY+bB22PKwNygCf1QipHkSqm755LTejLQuTdrm61YS8
	GoqgzI2k62XNXt/sHQBXjZ8RkKFdi/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722442857;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D9xFRjOegNiyUwD/F199FtWdIHUYh+LBaK2tIipgSv0=;
	b=vbzM2IlHH/FfxcHnRqo1FiN+cYURFcvigTxxMRZVhs6AF1wut4pCG5cuxFNp9/Ii/GYGsF
	jR9WzZZovFocc8CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722442857;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D9xFRjOegNiyUwD/F199FtWdIHUYh+LBaK2tIipgSv0=;
	b=qSi5+k3mMOmIuLVMSL+bvwdDG23pZMSyztHq40oJqOGXxeT918X5CPb4yq5WrlTErZ1JEq
	3SaV3NAPwrrbcS6Vp3DOdbRDQTLIY+bB22PKwNygCf1QipHkSqm755LTejLQuTdrm61YS8
	GoqgzI2k62XNXt/sHQBXjZ8RkKFdi/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722442857;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D9xFRjOegNiyUwD/F199FtWdIHUYh+LBaK2tIipgSv0=;
	b=vbzM2IlHH/FfxcHnRqo1FiN+cYURFcvigTxxMRZVhs6AF1wut4pCG5cuxFNp9/Ii/GYGsF
	jR9WzZZovFocc8CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9BDC51368F;
	Wed, 31 Jul 2024 16:20:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ETO4JWlkqmZNFwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 31 Jul 2024 16:20:57 +0000
Date: Wed, 31 Jul 2024 18:20:52 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic/019: redirect fsstress output to log file instead
Message-ID: <20240731162052.GS17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <0fdc35fdbc53f739fce1cb46ede8af97829aea11.1722441479.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fdc35fdbc53f739fce1cb46ede8af97829aea11.1722441479.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Wed, Jul 31, 2024 at 04:59:24PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Currently we are redirecting stdout and stderr of fsstress to /dev/null.
> In case we have a test failure, it's useful to know the seed that
> fsstress was using because it might be helpful to run it again with that
> same seed in the hope of being able to reproduce the failure.
> 
> So redirect stdout/stderr to the log file $seqres.full instead, so
> that we'll see a line like this after running the test:
> 
>     seed = 1722389488
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

