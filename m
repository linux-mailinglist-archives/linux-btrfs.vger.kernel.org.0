Return-Path: <linux-btrfs+bounces-3229-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C247879959
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Mar 2024 17:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7476B244A5
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Mar 2024 16:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883D312B149;
	Tue, 12 Mar 2024 16:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ydLvVPDR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FFT5A/MF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ydLvVPDR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FFT5A/MF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8BC7C09F;
	Tue, 12 Mar 2024 16:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710262118; cv=none; b=JNDVytC+Xeg5tMDhUqfSZ+cRpScj2gfOOBpdFsPVYn8B/CMWR6REeBtJH/rSgJaNr1dmkslgXVJa1NkdXcPxn24pm8Rfr/udWPTZDkRK5m3NAxwrM9BSUx/On499jFWPQYW/44fjHzpKhHjCR2i2XOrKxGXHz3Hmz6wiwZNs+xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710262118; c=relaxed/simple;
	bh=TPjS8vmpIo22gwCDkXTZjyD2CnPvPYATxjQ4BhXhyVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gK0AusZ9W6ZcEhW+odCHbOA9NdC/6GGuoRXy4PSWTQlEPSL5Q+/v5dRh+Q1owKLaU+EhU9dUsSmChngy0DWl94qKEBwDTZ7rblHYgO5/uR2XkA2AamgTjG1Ox5NYissUcuLr0lDPS8rZJEQ5ptVkkR3SCslyEDGkNHCWfzYhOpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ydLvVPDR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FFT5A/MF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ydLvVPDR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FFT5A/MF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 40E691F443;
	Tue, 12 Mar 2024 16:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710262109;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cq4hwcOlzXzmjgJTEVyDAeiB7l5KhslbrvkSY+O64fo=;
	b=ydLvVPDRXWY90+5duLod0hqkg1rQ/gdSPJn2161BHP1X3hxIxHJhe3ErkOY3V+j5j7C+qx
	u2SJGkYU6+6syGFUMdvRlKGyv+JHhXbW0QFCvQd6Y5kuV06kEbvkXuMbMGzktEoaxCkodz
	8+7BnU1lJbQazmjG1ae7sXatSsH+Fsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710262109;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cq4hwcOlzXzmjgJTEVyDAeiB7l5KhslbrvkSY+O64fo=;
	b=FFT5A/MF812zqHKI/APpHwi0r164IHfso75PnSpBV5hy0MnUHAIInXvgvgvXGVgbGVwGK8
	6776g6MoM4ou85Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710262109;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cq4hwcOlzXzmjgJTEVyDAeiB7l5KhslbrvkSY+O64fo=;
	b=ydLvVPDRXWY90+5duLod0hqkg1rQ/gdSPJn2161BHP1X3hxIxHJhe3ErkOY3V+j5j7C+qx
	u2SJGkYU6+6syGFUMdvRlKGyv+JHhXbW0QFCvQd6Y5kuV06kEbvkXuMbMGzktEoaxCkodz
	8+7BnU1lJbQazmjG1ae7sXatSsH+Fsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710262109;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cq4hwcOlzXzmjgJTEVyDAeiB7l5KhslbrvkSY+O64fo=;
	b=FFT5A/MF812zqHKI/APpHwi0r164IHfso75PnSpBV5hy0MnUHAIInXvgvgvXGVgbGVwGK8
	6776g6MoM4ou85Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2773B13795;
	Tue, 12 Mar 2024 16:48:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xgh0CV2H8GWZUwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 12 Mar 2024 16:48:29 +0000
Date: Tue, 12 Mar 2024 17:41:19 +0100
From: David Sterba <dsterba@suse.cz>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: dsterba@suse.cz, Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>, stable@vger.kernel.org,
	patches@lists.linux.dev, Josef Bacik <josef@toxicpanda.com>,
	Sasha Levin <sashal@kernel.org>, Chris Mason <clm@fb.com>,
	linux-btrfs <linux-btrfs@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6.7 001/162] btrfs: fix deadlock with fiemap and extent
 locking
Message-ID: <20240312164119.GW2604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240304211551.833500257@linuxfoundation.org>
 <20240304211551.880347593@linuxfoundation.org>
 <CAKisOQGCiJUUc62ptxp08LkR88T5t1swcBPYi84y2fLP6Tag7g@mail.gmail.com>
 <da17e97b-1880-415d-8cdb-07e79808e702@leemhuis.info>
 <20240311184108.GS2604@twin.jikos.cz>
 <d9d46e16-ae73-4495-98a4-ab08ac501132@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9d46e16-ae73-4495-98a4-ab08ac501132@leemhuis.info>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
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
	 NEURAL_HAM_SHORT(-0.20)[-0.977];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Mon, Mar 11, 2024 at 08:23:23PM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 11.03.24 19:41, David Sterba wrote:
> > On Mon, Mar 11, 2024 at 10:15:31AM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
> >> On 06.03.24 13:39, Filipe Manana wrote:
> >>> On Mon, Mar 4, 2024 at 9:26 PM Greg Kroah-Hartman
> >>> <gregkh@linuxfoundation.org> wrote:
> >>>>
> >>>> 6.7-stable review patch.  If anyone has any objections, please let me know.
> >>>
> >>> It would be better to delay the backport of this patch (and the
> >>> followup fix) to any stable release, because it introduced another
> >>> regression for which there is a reviewed fix but it's not yet in
> >>> Linus' tree:
> >>>
> >>> https://lore.kernel.org/linux-btrfs/cover.1709202499.git.fdmanana@suse.com/
> >>
> >> Those two missed 6.8 afaics. Will those be heading to mainline any time
> >> soon?
> > 
> > Yes, in the 6.9 pull request.
> 
> Great!
> 
> >> And how fast afterwards will it be wise to backport them to 6.8?
> >> Will anyone ask Greg for that when the time has come?
> > The commits have stable tags and will be processed in the usual way.
> 
> I'm missing something. The first change from Filipe's series linked
> above has a fixes tag, but no stable tag afaics:
> https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git/commit/?h=for-6.9&id=978b63f7464abcfd364a6c95f734282c50f3decf
> 
> So there is no guarantee that Greg will pick it up; and I assume if he
> does he only will do so after -rc1 (or later, if the CVE stuff continues
> to keep him busy). As Filipe wrote "can actually have serious
> consequences" this got me slightly worried. That's why I'm a PITA here,
> sorry -- but as I said, maybe I'm missing something.

Well it's the timing, last week before a final release the branches
don't receive any insignificant changes like reviewed-by or stable tags.
The patch connection is also done by the Fixes tag and a missing
CC:stable can be substituted by explicit requests for backport if
needed.

