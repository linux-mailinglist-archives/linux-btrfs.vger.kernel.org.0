Return-Path: <linux-btrfs+bounces-9958-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A63DC9DBB02
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2024 17:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9D221608BF
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2024 16:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011081BD9E5;
	Thu, 28 Nov 2024 16:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dz3NEMkF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="js4XkjV0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dz3NEMkF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="js4XkjV0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE4B1BD9CB
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Nov 2024 16:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732810003; cv=none; b=GcGl2/sBS5UKzBKFhIaHQgYhGTohyC6JPBrCHAvTRt6yNiHu4qa6Ezxsp2xpemIQW1MDPJ5qfa4bU+n0EB5abPb6SZ+t7LAydheLQXDaGBGUcwYIwDengcNJ0rDNmOU6sTFvqwVsoXubbL1SXhEsvgVeRAA9WKHPKgMyMlKm3wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732810003; c=relaxed/simple;
	bh=hJ1WwOfZmdFEJAZQkfHoaztEXYkSBCUIOKkCOpLvyrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXiikP5TONRdISe1GXIcZb77vaAwDAixTIVgsXRpPTPECGbLnmEBomLdq46U9k1S+YL5Q088PH1TgLeFtzRWHU+F1EA5SZWak5hZzM+6eJbEErZSIs10HqgjVAkCAd4CC9tGEoGnJJJr7ZG1A0K/QzppePjg8j1eXrOCgvptI8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dz3NEMkF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=js4XkjV0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dz3NEMkF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=js4XkjV0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4A8C221133;
	Thu, 28 Nov 2024 16:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732809999;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cOfktGEJtchxNy8KARg8nQ7dvuapbt2ncUsxncBvtRA=;
	b=dz3NEMkFEpDfZakPg12KeZTOMGM9M4tAzm6cdu7liwvrMPJY1N0oENRZ65eO9SL+gPW603
	DoO5vjYKBE9fcYZt6tOhETOd5wRR3iXh3ZAxszgo7ZOa4Ty1QoBV6k3Qqj6RPZu8+3vjfL
	86M6jtjKz2BQqLG8/UtWYXGZGvalPX0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732809999;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cOfktGEJtchxNy8KARg8nQ7dvuapbt2ncUsxncBvtRA=;
	b=js4XkjV0PzCyIs4ynG2v9BneFyacsuBtsE0ZX0zRJIi4Ruk7z0EL6pCJbf9TCQiIRbWv9P
	GGeoDd2js1sJQbAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732809999;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cOfktGEJtchxNy8KARg8nQ7dvuapbt2ncUsxncBvtRA=;
	b=dz3NEMkFEpDfZakPg12KeZTOMGM9M4tAzm6cdu7liwvrMPJY1N0oENRZ65eO9SL+gPW603
	DoO5vjYKBE9fcYZt6tOhETOd5wRR3iXh3ZAxszgo7ZOa4Ty1QoBV6k3Qqj6RPZu8+3vjfL
	86M6jtjKz2BQqLG8/UtWYXGZGvalPX0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732809999;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cOfktGEJtchxNy8KARg8nQ7dvuapbt2ncUsxncBvtRA=;
	b=js4XkjV0PzCyIs4ynG2v9BneFyacsuBtsE0ZX0zRJIi4Ruk7z0EL6pCJbf9TCQiIRbWv9P
	GGeoDd2js1sJQbAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3608213974;
	Thu, 28 Nov 2024 16:06:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +5yuDA+VSGcaNQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 28 Nov 2024 16:06:39 +0000
Date: Thu, 28 Nov 2024 17:06:37 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Johannes Thumshirn <jth@kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v4] btrfs: handle bio_split() error
Message-ID: <20241128160637.GW31418@suse.cz>
Reply-To: dsterba@suse.cz
References: <3b491cb4fcb7c34bd8cd5265871ff115395fca79.1732786874.git.jth@kernel.org>
 <20241128145028.GV31418@twin.jikos.cz>
 <90533ed1-089b-4232-8450-b209ca0e8d64@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90533ed1-089b-4232-8450-b209ca0e8d64@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Nov 28, 2024 at 03:40:56PM +0000, Johannes Thumshirn wrote:
> On 28.11.24 15:50, David Sterba wrote:
> > On Thu, Nov 28, 2024 at 10:42:01AM +0100, Johannes Thumshirn wrote:
> >> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> >>
> >> Commit bfebde92bd31 ("block: Rework bio_split() return value") changed
> >> bio_split() so that it can return errors.
> > 
> > Where is this commit or what are the merge plans?
> > 
> 
> It is 'e546fe1da9bd ("block: Rework bio_split() return value")' in 
> Linus' tree,. I must have had it applied locally,  sorry for that.

I see, so it was merged to 6.12-rc4, I thought there was some inter-git tree
dependency but we can merge it as usual.

