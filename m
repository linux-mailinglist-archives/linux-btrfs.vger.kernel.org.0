Return-Path: <linux-btrfs+bounces-3937-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB37898FB6
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 22:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7259A1C22323
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 20:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23EC13AA4D;
	Thu,  4 Apr 2024 20:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="adaBaPGt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lt1z5CtE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="adaBaPGt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lt1z5CtE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A8B6FE26;
	Thu,  4 Apr 2024 20:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712262858; cv=none; b=UKS5kZUx44ErP0qIvo3iKqtXF/7Zfv4FXk6irW1/nwKgKgWtS5+cwSenOR7/P4pNA/Lv6Pnmc1UfiFVMlK0s5bcQ6+yvdT3YW9V58Ec7Z8fbd9IUj8LP1aYyt1HwGEsJkubi3bRkhcL+TS9QFI6SWe1HqYwOMXUCQnPsNtMIs5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712262858; c=relaxed/simple;
	bh=q6em1spNjxJpPQRYktP0FiN58iENw53pzN56vBpUAB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YiF1GuAwe3jVw07MPdbsCmjEkeqinqkF8TrkQtg5Kqa0n5PaVyL1ok4JqJeLSQ2u1qkcQ1Mt1uU2jK5h5p9tp3o20DUGc9WPrgiNGHYPvoyCOhqOQrir3w4D3l98xIClbnATXlgCAri0pWKrWLaLOGF569v4NBJaZoDfy1wDtcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=adaBaPGt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lt1z5CtE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=adaBaPGt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lt1z5CtE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 637C01F44B;
	Thu,  4 Apr 2024 20:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712262855;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUK+NOXkYpb3P/0N0Mw2ewEpgRitgCtwAYay9/jlRbE=;
	b=adaBaPGtYHlkgCvQZ0usrsEcJZRuMWtrzmguJvU4waE6FTWZ9rLBRQ8jfaJqDTSSz2LKZ2
	E+vtufteH5W3ilm+voKdwG8RJemHr33Ykulb9JhiOqsPzJh60QRwwRqtCiqR7Of8e7WUr5
	1YHnBDrzqtwOAhFzJDsxu9n2zOlllP8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712262855;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUK+NOXkYpb3P/0N0Mw2ewEpgRitgCtwAYay9/jlRbE=;
	b=lt1z5CtE1jJJX5sMv+XpkdD/idKvlPCgiwuCKpq7r0Qs4yFxgB4xUCEspKSu7+OGbRiTSC
	/gHBNAE+HjmzYvDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712262855;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUK+NOXkYpb3P/0N0Mw2ewEpgRitgCtwAYay9/jlRbE=;
	b=adaBaPGtYHlkgCvQZ0usrsEcJZRuMWtrzmguJvU4waE6FTWZ9rLBRQ8jfaJqDTSSz2LKZ2
	E+vtufteH5W3ilm+voKdwG8RJemHr33Ykulb9JhiOqsPzJh60QRwwRqtCiqR7Of8e7WUr5
	1YHnBDrzqtwOAhFzJDsxu9n2zOlllP8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712262855;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUK+NOXkYpb3P/0N0Mw2ewEpgRitgCtwAYay9/jlRbE=;
	b=lt1z5CtE1jJJX5sMv+XpkdD/idKvlPCgiwuCKpq7r0Qs4yFxgB4xUCEspKSu7+OGbRiTSC
	/gHBNAE+HjmzYvDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4024213298;
	Thu,  4 Apr 2024 20:34:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 8kk6D8cOD2azdwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 04 Apr 2024 20:34:15 +0000
Date: Thu, 4 Apr 2024 22:26:45 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2 2/7] btrfs: reduce the log level for
 btrfs_dev_stat_inc_and_print()
Message-ID: <20240404202644.GN14596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1710906371.git.wqu@suse.com>
 <8f3e7a57b40973e62c0d758922971566ca96fb2e.1710906371.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f3e7a57b40973e62c0d758922971566ca96fb2e.1710906371.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Wed, Mar 20, 2024 at 02:24:52PM +1030, Qu Wenruo wrote:
> Currently when we increase the device statistics, it would always lead
> to an error message in the kernel log.
> 
> However this output is mostly duplicated with the existing ones:
> 
> - For scrub operations
>   We always have the following messages:
>   * "fixed up error at logical %llu"
>   * "unable to fixup (regular) error at logical %llu"
> 
>   So no matter if the corruption is repaired or not, it scrub would
>   output an error message to indicate the problem.
> 
> - For non-scrub read operations
>   We also have the following messages:
>   * "csum failed root %lld inode %llu off %llu" for data csum mismatch
>   * "bad (tree block start|fsid|tree block level)" for metadata
>   * "read error corrected: ino %llu off %llu" for repaired data/metadata
> 
> So the error message from btrfs_dev_stat_inc_and_print() is duplicated.
> 
> The real usage for the btrfs device statistics is for some user space
> daemon to check if there is any new errors, acting like some checks on
> SMART, thus we don't really need/want those messages in dmesg.
> 
> This patch would reduce the log level to debug (disabled by default) for
> btrfs_dev_stat_inc_and_print().
> For users really want to utilize btrfs devices statistics, they should
> go check "btrfs device stats" periodically, and we should focus the
> kernel error messages to more important things.

I kind if disagree with each point.

The message is meant to be logged as it will happen in production and
outside of development, so the debug level does not make sense.

The stats message is not duplicated for the individual causes, it
additionally tracks the whole state.

Logging important messages to system log is a common thing and we do that
a lot, this makes debugging and anlyzing things easier. We can't
expect that there would always be a daemon collecting the stats, there's
not standardized or recommended tool for that. A quick look to dmesg can
show that something is wrong.

What we can do: reduce the number messages so the whole stats are
printed once per transaction if there is a change.

We can also tune which events also print the stats, for example flush
errors are more interesting than read/write, comparing the number of
events that can happen in a batch.

