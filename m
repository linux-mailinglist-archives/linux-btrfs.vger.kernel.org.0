Return-Path: <linux-btrfs+bounces-16021-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDD5B225F4
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 13:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ACC7163B78
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 11:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB15A2ECD1D;
	Tue, 12 Aug 2025 11:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pKfPZAy4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RBZycv8A";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2RVmtOl5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="31yXk9dD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0222E9ED8
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Aug 2025 11:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754998554; cv=none; b=jqfA3RcXqip0ft463/bADKrg4DVItVvLms+zEKcnUm08bI8wBV3mYKRMebXhADvp1nBaLltTdVyP6mHz830ZQNTXRo4inUiEmR8rXkaRZy26xNVUC8DMNK2yj21VRQLQ6+1hVBvBiyLvYonPjPUDGDVDYcBdFB2Z5u+4sgzu0FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754998554; c=relaxed/simple;
	bh=W27HQXCMx8aHLOhK6yxuceOBWyLMX2rye4q/sLCK2AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMt0zhV6XkCIPsuTnfizwz4W+ZW4Ao+SsR2YIe3x+2SuWLxNW0kUkKVYVfMHexPfJWYs9mgQ/jjr0jOQNuMakHaja7r2XmXngAua8waM6Ky5YDaB5bMl5AhfPSk6GenfLMINyrCxuRAaks+RozvJdqCQBGxqqA242qyAbCrFGwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pKfPZAy4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RBZycv8A; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2RVmtOl5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=31yXk9dD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F36141F45E;
	Tue, 12 Aug 2025 11:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754998551;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W27HQXCMx8aHLOhK6yxuceOBWyLMX2rye4q/sLCK2AE=;
	b=pKfPZAy4ypNLJ3SPJhFYMspRNdVmgMj19c0UEXgCXNeSVlPMdc93A3kGSvSIB4zKyoSKCi
	DB+Q9SlVEUcyKGWuXgvWQdft7aaLEJdwDyatk3eDP8iwt6pwvfz/EGTWkvO99a7+sfVSaV
	zfiPWwcyjPHjl0Jf+SYqYe3sAJ2uyiA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754998551;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W27HQXCMx8aHLOhK6yxuceOBWyLMX2rye4q/sLCK2AE=;
	b=RBZycv8A8wOoK5NULIeU6M+VYQR3xvE8yFvoPFxL3QyF7u2jw3jnEdIQgTX4dGGuTVrQqA
	JrduCnO+jJNtFfDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754998550;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W27HQXCMx8aHLOhK6yxuceOBWyLMX2rye4q/sLCK2AE=;
	b=2RVmtOl500bIe/gLxhv87EKLm/MD0ZuLsTbTdtcxr6raXnbJscX/nsqr9LKCI0ZKu5xoaE
	dUfedDnf/L1UVnpPIBGMrh1zmFSwg+tY4/a0q4lOdhMQBArYCF2hOW7IDuIaaaU2tHqNdW
	nuwx1EmgYtewhzLXd0kKHpTWIGq5VSA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754998550;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W27HQXCMx8aHLOhK6yxuceOBWyLMX2rye4q/sLCK2AE=;
	b=31yXk9dD7YT/PJ9WJYeVY4LVDvRmqVOLBdcnd6EtBIrWC1mtdcwHLlPwrOAiZsXhaOLlxa
	k1EsmHc5xtNWFRBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E10C1136C7;
	Tue, 12 Aug 2025 11:35:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U7eCNhYnm2gHHQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 12 Aug 2025 11:35:50 +0000
Date: Tue, 12 Aug 2025 13:35:41 +0200
From: David Sterba <dsterba@suse.cz>
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3 0/3] btrfs: ref_tracker for delayed_nodes
Message-ID: <20250812113541.GD5507@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1754609966.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1754609966.git.loemra.dev@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.00

On Thu, Aug 07, 2025 at 04:53:53PM -0700, Leo Martins wrote:
> The leading btrfs related crash in our fleet is a soft lockup in
> btrfs_kill_all_delayed_nodes caused by a btrfs_delayed_node leak.
> This patchset introduces ref_tracker infrastructure to detect this
> leak. I'm mirroring the way REF_VERIFY is setup with a Kconfig and
> a mount option.

To avoid copying REF_VERIFY in the future, I'd like to see moved it
under debug config as well. The runtime cost if disabled is negligible,
there's one extra memeber in the btrfs_ref structure but that's also
acceptable.

