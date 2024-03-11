Return-Path: <linux-btrfs+bounces-3191-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F4C878859
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 19:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3098B229FA
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 18:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF275D908;
	Mon, 11 Mar 2024 18:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JDtWb1dI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ONKc+iQJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JDtWb1dI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ONKc+iQJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C7D59148;
	Mon, 11 Mar 2024 18:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182905; cv=none; b=Me1edpeErImkqf+IsBhrgQ7t/DqvpQIG6tNaHh+hOzmOMX+SOsISEUXDP9jbxYVZj42sYbICNHl7fu9K15zXnqGea8EaUFsRriEcvJrTWdglGbrdq895zbrr38sa/e7fEijcR9AYsmAyqVaUq/Me+dahBPbrzRkAM010WllV8gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182905; c=relaxed/simple;
	bh=1ITc6fS71N5fn7IPkKbleMIYuCc76Gh9T8fxKOMottU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rb8pYfVxTsBq7kcj8KR6J6yRiNTCgETPDLgTO4H9rwHEHNHqBPaukTMGZ+CEXw5kOzpEaHfEAo3xn7APrp3iOOgNBi3tvA2T1/B25MM6GyqvtjwtXhpFZGEedZkCzeWdCDZM08RvnjFrx+otBMCTCr14qGbuc463iFxJyGkCWZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JDtWb1dI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ONKc+iQJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JDtWb1dI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ONKc+iQJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3DB2C34F83;
	Mon, 11 Mar 2024 18:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710182902;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1gW/cs08wXpsQGb0z1TBwnPJpVO0bgSQkKtya/Mw1tM=;
	b=JDtWb1dIVDo474APekp8jGZqIYnb5BuGINDaN5Z3ma10FGfu46gVu8BQWhs/NyZQ78Jc2u
	eVNpxURRPl7VwL8a02g6kHU2Oa5w8XSygLFfsynoAyYsKq/MHSYz4NzlFAtYdGYtjxr8M+
	IO1IwwmXCn2HWvUje6oDIgQmFy4NNhE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710182902;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1gW/cs08wXpsQGb0z1TBwnPJpVO0bgSQkKtya/Mw1tM=;
	b=ONKc+iQJ3kxSAOVx+wwG3+eiJG/5N8bgOYFm8/FOxIvmZJPHxb1vtex62a9lFWvoEbtJHk
	juSbLDUsIh+t/qCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710182902;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1gW/cs08wXpsQGb0z1TBwnPJpVO0bgSQkKtya/Mw1tM=;
	b=JDtWb1dIVDo474APekp8jGZqIYnb5BuGINDaN5Z3ma10FGfu46gVu8BQWhs/NyZQ78Jc2u
	eVNpxURRPl7VwL8a02g6kHU2Oa5w8XSygLFfsynoAyYsKq/MHSYz4NzlFAtYdGYtjxr8M+
	IO1IwwmXCn2HWvUje6oDIgQmFy4NNhE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710182902;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1gW/cs08wXpsQGb0z1TBwnPJpVO0bgSQkKtya/Mw1tM=;
	b=ONKc+iQJ3kxSAOVx+wwG3+eiJG/5N8bgOYFm8/FOxIvmZJPHxb1vtex62a9lFWvoEbtJHk
	juSbLDUsIh+t/qCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E96713695;
	Mon, 11 Mar 2024 18:48:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KvM0B/ZR72VwQgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 11 Mar 2024 18:48:22 +0000
Date: Mon, 11 Mar 2024 19:41:08 +0100
From: David Sterba <dsterba@suse.cz>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Filipe Manana <fdmanana@suse.com>, David Sterba <dsterba@suse.com>,
	stable@vger.kernel.org, patches@lists.linux.dev,
	Josef Bacik <josef@toxicpanda.com>, Sasha Levin <sashal@kernel.org>,
	Chris Mason <clm@fb.com>, linux-btrfs <linux-btrfs@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6.7 001/162] btrfs: fix deadlock with fiemap and extent
 locking
Message-ID: <20240311184108.GS2604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240304211551.833500257@linuxfoundation.org>
 <20240304211551.880347593@linuxfoundation.org>
 <CAKisOQGCiJUUc62ptxp08LkR88T5t1swcBPYi84y2fLP6Tag7g@mail.gmail.com>
 <da17e97b-1880-415d-8cdb-07e79808e702@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da17e97b-1880-415d-8cdb-07e79808e702@leemhuis.info>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.39
X-Spamd-Result: default: False [-3.39 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.11)[-0.550];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.48)[97.64%]
X-Spam-Flag: NO

On Mon, Mar 11, 2024 at 10:15:31AM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 06.03.24 13:39, Filipe Manana wrote:
> > On Mon, Mar 4, 2024 at 9:26 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> >>
> >> 6.7-stable review patch.  If anyone has any objections, please let me know.
> > 
> > It would be better to delay the backport of this patch (and the
> > followup fix) to any stable release, because it introduced another
> > regression for which there is a reviewed fix but it's not yet in
> > Linus' tree:
> > 
> > https://lore.kernel.org/linux-btrfs/cover.1709202499.git.fdmanana@suse.com/
> 
> Those two missed 6.8 afaics. Will those be heading to mainline any time
> soon?

Yes, in the 6.9 pull request.

> And how fast afterwards will it be wise to backport them to 6.8?
> Will anyone ask Greg for that when the time has come?

The commits have stable tags and will be processed in the usual way.

