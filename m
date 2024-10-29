Return-Path: <linux-btrfs+bounces-9217-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E04829B581F
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 01:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F730283EE4
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 00:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F0520B208;
	Wed, 30 Oct 2024 00:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fCIKlTlN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oPj6n9oe";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Bb9u8BHb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0o7eJAEo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07A718E36D
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Oct 2024 00:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730246412; cv=none; b=gszYE71mJBFx6+UANiyfcXnLQM7otcFalV04ksY86kUeBEoahH3eXQt757fe+YL7H26W02MdpriswdEydDtzWjAoY12EmtbNeP5YWE8W3dGyNKzm2oelCbpehKOnC5NkLtbhJyVlFZ7Qxf7SGZ7ECAfGazweqBd9yzrcczekA04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730246412; c=relaxed/simple;
	bh=5KdURaCVBMsCfu/2fRHJ1snvcUdwLc8Q780S3JsKT9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZ7WNKHw+FmwBhHLw0of6J0jqp3/cfBzFfuQOdJ3C3+aYx4RGZWbOhDQIPk2xmNYeA1rGVm8zz6k/9mNPMmbGXM2PDtvfoMZwaTSDa8mLz24TJtkPTnvl6/2dg8UbW3DFmIl/mEoWa6TqNd2MZgymojW8nax6BH+NQ08J0Mv554=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fCIKlTlN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oPj6n9oe; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Bb9u8BHb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0o7eJAEo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D36B91FBFB;
	Wed, 30 Oct 2024 00:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730246408;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NfHVfqdSTvj6QGg/ecWuWr1W1+fejWlZI8oEaYJrIF8=;
	b=fCIKlTlNZudCCzuTxCbVSV5C0xQxwP5YWpJ1170P59a6uf7NxQC40vqq7BjiwIWc70OiXt
	sM6Moe73RCabjLvCr1sn2gAoEpB+T5Fm6fhOobIIIN5pv6L8nSHgVruSLrjL4q4luOPKFU
	MF9J6Wf2j2oJzG89AEa2Phs00/3gJy0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730246408;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NfHVfqdSTvj6QGg/ecWuWr1W1+fejWlZI8oEaYJrIF8=;
	b=oPj6n9oe2UwuW8ofYul5TEvEB/7nC50JU8rPa+I7ftk+eFRICm7YBMcq5nb8pNKLANkHi0
	g0gaAVRqub9pVFCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Bb9u8BHb;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0o7eJAEo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730246407;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NfHVfqdSTvj6QGg/ecWuWr1W1+fejWlZI8oEaYJrIF8=;
	b=Bb9u8BHbIwEDm6qyzcH6VHo9Sxd7jMZ4JkqtcJtS3Mey4CyyghrbYzm/hgf2/NVT6QXdaK
	jw58mrTnc2tYf383IovgzyxYQTbacxpP3mPGLwTYLLPz3vOd7m4JN0953vOxqoXvqz53YW
	/z5Paq1JUV7MOBxMLAMAZaoBJRTvehY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730246407;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NfHVfqdSTvj6QGg/ecWuWr1W1+fejWlZI8oEaYJrIF8=;
	b=0o7eJAEooRfTzsNLRlvX2Dl4ZDdvE/vaLyT0f1NQpJ/Jx+DBCsk7PoT+Z4maJ2j/3jPqNy
	Y8QPBykhM5qc8UBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AFE4D13A2D;
	Wed, 30 Oct 2024 00:00:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id M1B4KQd3IWepFwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 30 Oct 2024 00:00:07 +0000
Date: Wed, 30 Oct 2024 00:59:51 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	Enno Gotthold <egotthold@suse.com>, Fabian Vogt <fvogt@suse.com>
Subject: Re: [PATCH v2] btrfs: fix mount failure due to remount races
Message-ID: <20241029235951.GV31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <a682e48c161eece38f8d803103068fed5959537d.1729665365.git.wqu@suse.com>
 <20241023163237.GD31418@twin.jikos.cz>
 <08e45ca0-5ed9-4684-940f-1e956a936628@gmx.com>
 <20241025190221.GM31418@twin.jikos.cz>
 <9f395072-1a01-4cac-9332-cd7a7f6042a5@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f395072-1a01-4cac-9332-cd7a7f6042a5@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: D36B91FBFB
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmx.com];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto,twin.jikos.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Sat, Oct 26, 2024 at 07:27:02AM +1030, Qu Wenruo wrote:
> 在 2024/10/26 05:32, David Sterba 写道:
> > On Thu, Oct 24, 2024 at 07:23:20AM +1030, Qu Wenruo wrote:
> >> 在 2024/10/24 03:02, David Sterba 写道:
> >>> On Wed, Oct 23, 2024 at 05:08:51PM +1030, Qu Wenruo wrote:
> >>>> +	if (!(fc->sb_flags & SB_RDONLY) && (mnt->mnt_sb->s_flags & SB_RDONLY))
> >>>> +		ret = btrfs_reconfigure(fc);
> >>>
> >>> This gives me a warning (gcc 13.3.0):
> >>>
> >>> fs/btrfs/super.c: In function ‘btrfs_reconfigure_for_mount’:
> >>> fs/btrfs/super.c:2011:56: warning: suggest parentheses around ‘&&’ within ‘||’ [-Wparentheses]
> >>>    2011 |         if (!fc->oldapi || !(fc->sb_flags & SB_RDONLY) && (mnt->mnt_sb->s_flags & SB_RDONLY))
> >>>         |                            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>>
> >> Weird, my local patch/branch shows no fc->oldapi usage, thus no warning.
> >>
> >> The involved lines are:
> >>
> >> -	ret = btrfs_reconfigure(fc);
> >> +	if (!(fc->sb_flags & SB_RDONLY) && (mnt->mnt_sb->s_flags & SB_RDONLY))
> >> +		ret = btrfs_reconfigure(fc);
> >>
> >> Thus no warning.
> >
> > This was caused on my side. The patch does not apply cleanly on for-next
> > or my misc-next, I'm using wiggle to merge the changes and it for some
> > reason always adds the fc->oldapi to the conditions. Please refresh the
> > patch and resend, thanks.
> 
> I have already mentioned this has a dependency on the following patch:
> 
> https://lore.kernel.org/linux-btrfs/e1a70aa6dd0fc9ba6c7050a5befb3bd5b75a1377.1729664802.git.wqu@suse.com/
> 
> Furthermore that patch should have a higher priority, as it breaks the
> very basic of subvolume RO/RW mount.

Sorry, I have a hard time to keep up context for each patch, I've been
sweeping mails for anything that we need to get to 6.13. Can you please
resend patches that are related together in one series/thread, like the
mount option fixes and the folio or subpage fixes? That would help to
ensure I don't miss something. Thanks.

