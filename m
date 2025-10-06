Return-Path: <linux-btrfs+bounces-17470-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFDBBBEE61
	for <lists+linux-btrfs@lfdr.de>; Mon, 06 Oct 2025 20:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54B013BEE5B
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Oct 2025 18:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB272D3EF6;
	Mon,  6 Oct 2025 18:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G87hevSk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vd2Tp3wM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G87hevSk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vd2Tp3wM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB20122A4E9
	for <linux-btrfs@vger.kernel.org>; Mon,  6 Oct 2025 18:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759774600; cv=none; b=T7C996h+AiU3xOSxOiB7yuSRyKGwo1wvU3tavJ47yVjoUY1d1VEX00MzN6/C+sYh6HTCQ+oMLPMgebhtq6qdtrI7aVs2SkmDvboavwvfg7QRcQ54cZOvjIAytaEv2KiZxDK885zw2EAVX9CkeiZYszQIokePvS+TU5mUn4CBhBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759774600; c=relaxed/simple;
	bh=0TC9SnXyGfNOfg1Q0SwcoehxrP0rq6BOmuGmZA3Ymg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKalDEHCMi40/uRMbwcH2pckSQ6NR3C8hrOiCmTjlNWRHUb/xTlSS6qvcT40GrOSq2z2Dnv9rBel7vI2mCIY1Auzbry5Zf8sIy0DY8SFujgDmLlfxiu24uDfpPk/WNwPMTD4Tv3ftpPlctbyXuTL0s7YuwWBlIhHlYTxKBY/bv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G87hevSk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vd2Tp3wM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G87hevSk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vd2Tp3wM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C7B1820136;
	Mon,  6 Oct 2025 18:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759774596;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=382qtnwOZ6mja55xXUOLhqZtpTFBi0HQ1lquNVBTs5s=;
	b=G87hevSkGG25tiq6CZ1MPs8e/adinsi/LjRMlt9OLNrKAvKUNvjKQKEl/oRoucTMUaFH6x
	f/odouVYN4SkykhtWle/d0i7X5nQ8M4uRB1GVx9VDMJA8n2rX8dKoLbrelmUdA/R9cw0KF
	QptAgKGM8BGqQMFMPsWNeW4L0oivwjA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759774596;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=382qtnwOZ6mja55xXUOLhqZtpTFBi0HQ1lquNVBTs5s=;
	b=vd2Tp3wM7+KEv5Ooaw0T3UwQf2/igrq/FTPNgvVMmkStf7Ti6iXaEvvi+wEoMIumf9+PDG
	CX0qPPHOTSMimuAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759774596;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=382qtnwOZ6mja55xXUOLhqZtpTFBi0HQ1lquNVBTs5s=;
	b=G87hevSkGG25tiq6CZ1MPs8e/adinsi/LjRMlt9OLNrKAvKUNvjKQKEl/oRoucTMUaFH6x
	f/odouVYN4SkykhtWle/d0i7X5nQ8M4uRB1GVx9VDMJA8n2rX8dKoLbrelmUdA/R9cw0KF
	QptAgKGM8BGqQMFMPsWNeW4L0oivwjA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759774596;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=382qtnwOZ6mja55xXUOLhqZtpTFBi0HQ1lquNVBTs5s=;
	b=vd2Tp3wM7+KEv5Ooaw0T3UwQf2/igrq/FTPNgvVMmkStf7Ti6iXaEvvi+wEoMIumf9+PDG
	CX0qPPHOTSMimuAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AFEC113700;
	Mon,  6 Oct 2025 18:16:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tBZyKoQH5GgNXAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 06 Oct 2025 18:16:36 +0000
Date: Mon, 6 Oct 2025 20:16:35 +0200
From: David Sterba <dsterba@suse.cz>
To: Leo Martins <loemra.dev@gmail.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com, fstests@vger.kernel.org
Subject: Re: [PATCH v2 3/3] fstests: btrfs: test RAID conversions under stress
Message-ID: <20251006181635.GD4412@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <55d549d2-fec1-442f-ad9f-875d2ec6c864@suse.com>
 <20251006173757.296087-1-loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251006173757.296087-1-loemra.dev@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-2.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.50

On Mon, Oct 06, 2025 at 10:37:51AM -0700, Leo Martins wrote:
> On Sat, 4 Oct 2025 11:24:27 +0930 Qu Wenruo <wqu@suse.com> wrote:
> 
> > 
> > 
> > 在 2025/10/4 09:11, Leo Martins 写道:
> > > Add test to test btrfs conversion while being stressed. This is
> > > important since btrfs no longer allows allocating from different RAID
> > > block_groups during conversions meaning there may be added enospc
> > > pressure.
> > > 
> > > Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> > 
> > Please do not mix patches for different projects into the same patchset.
> > 
> > A lot of us are using b4 to merge (kernel/progs) patches, which will 
> > merge the whole series, including the one intended to fstests.
> > 
> > Thanks,
> > Qu
> 
> Got it, sorry about that. Should I resend the patches?

Please don't unless there are changes. We can always apply the patches
one by one, but more patch versions in the mailinglist need more
tracking and sometimes discussions are torn.

