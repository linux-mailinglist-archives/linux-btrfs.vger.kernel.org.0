Return-Path: <linux-btrfs+bounces-3878-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 390D98971CA
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 15:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA68A1F22EB6
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 13:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91ADB148856;
	Wed,  3 Apr 2024 13:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NCjEDwhm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eHArVQrj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2659814831E
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Apr 2024 13:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712152674; cv=none; b=c2k8Ael00QqD6yUQgOxuflz9aH9iXHXrYpTUECuB0psrxE2B3I2NgqI+hOKMipTinOJlUrOtot3B9HKJheYh+InjFw4vkvWNaW93YR5BJHzPNbH0T+akFThd3UudWQLcgzAbar/1A1rniF/2mcNC6+YqoXFw5r3BWJATvnWk3KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712152674; c=relaxed/simple;
	bh=n9XBFBOlfgqIS2I5PmKuYvEm16F8TCBUguqdlIqPtxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/KaMkys5Lt5BatipnceFyJ0xIMttz1lpbMxRgKjOArfzXlylgDSfbC4J1J21nX18ISt2mxxL0IdPMQYDR776Y61j6YBr8dDJntfR4TaoNncd+0bJ5xBMrKAdZNzfFTfT0808BqnrAK/ceycPJlNxc3chIGqK1JHtAtnIxHKT4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NCjEDwhm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eHArVQrj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7C73D5CD2A;
	Wed,  3 Apr 2024 13:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712152671;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8+VgoVN5CQnEGY7e2ilNrh9llcEKCQVtAtEWKyoCRXE=;
	b=NCjEDwhmfi+dlKK61U6nQQs6HLjDX18DcfxCYxdFjJTtwedPWf3u+JmpKCxT5EzzPDhNkF
	slVDIeu/NDLMSRdTD4wJFjx6N5Oc0wo6f5iQPnpVKwtBiG2xET048F26IVFy0kKj19oHD8
	4DkfkWiqOQLDt3cyz0XQlRC9RUtkuPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712152671;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8+VgoVN5CQnEGY7e2ilNrh9llcEKCQVtAtEWKyoCRXE=;
	b=eHArVQrjxmWgQoMgwj3jve8DPFnev+LeEKia8YcBOOda5uDQMUn8exDvjJCB//LcYN2+zB
	TBIjh1gIdR37YlDw==
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 710E31331E;
	Wed,  3 Apr 2024 13:57:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 5B5vG19gDWYVVQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 03 Apr 2024 13:57:51 +0000
Date: Wed, 3 Apr 2024 15:50:29 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/5] btrfs-progs: zoned devices support for bgt feature
Message-ID: <20240403135029.GH14596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1712095635.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1712095635.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-6.57 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-2.57)[98.08%];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.977];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo,suse.cz:replyto]
X-Spam-Score: -6.57
X-Spam-Level: 
X-Spam-Flag: NO

On Wed, Apr 03, 2024 at 08:37:35AM +1030, Qu Wenruo wrote:
> [CHANGELOG]
> v2:
> - Remove the header cleanup for tune/main.c
>   That would cause compiling error as our expertimental features
>   still rely on that header.

You don't need to resend the whole patchset, deleting a commit can be
done locally in case it's trivial and does not cause other conflicts.
For build checks it's of course OK to update the branch and push.
Now in devel, thanks.

