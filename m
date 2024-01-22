Return-Path: <linux-btrfs+bounces-1627-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9611837770
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jan 2024 00:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB5C31C22C22
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 23:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC12495C3;
	Mon, 22 Jan 2024 23:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="09N6/asb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2W6Ghoz2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="09N6/asb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2W6Ghoz2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3E5364DD;
	Mon, 22 Jan 2024 23:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705964751; cv=none; b=YvN2E4UiP5KhTTmQuo/3zr67DPnms1fgkHy7BoostUi1dYntjCAWblZnUUhHr6HDYXTdzsPYsFGRJie63MD0R06n3bPT4MJjqRZ0IWtJUX0A7tds81ubXbQ4RFCq//2HEFYVHTz6U9TRnB8gGwa4Y+DNC7DbQtg8vByRG4a7IgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705964751; c=relaxed/simple;
	bh=SALosj7hPzRWwZS+P+b6rHJSA9Y8WaIYJu0rYoaCQPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhAwdzb/EQwldPbUV0E/G3bXZZTYUO64rClLEIJg30T2AwUfElSsOo+ssEYRGPisIP1koXG0a/bMKTco+WMPVffh5nyIpiPtnnqlvD+7EqyIBmOPQY0AZrG014FCTLPGL8sOw9DyNUqntp2ab5PpTh/Ug5SMAr11i2glC6/Tpe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=09N6/asb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2W6Ghoz2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=09N6/asb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2W6Ghoz2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B9FD121FCF;
	Mon, 22 Jan 2024 23:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705964747;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RMmD19Va6uoSBzoselCt3P1uMVFvKzLAPpQQ76TCNpA=;
	b=09N6/asbA8EdQZS1+Xzdd7gQKmoGJEKaWPSYYXdu/ngXaGDGDV7A4nQl1cqRYEwFzht2mQ
	VL2dyh46xhr5RvGN07Og6ESJOsBerhbdIU+EQi3b8TUg6gnGwA/6PVwaPXvVTQu4NUxe/5
	bIpezahq+/25cFO02cehAv4FyaV54CY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705964747;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RMmD19Va6uoSBzoselCt3P1uMVFvKzLAPpQQ76TCNpA=;
	b=2W6Ghoz2bv1CrviVPmJHPGI3ACFonjz/0HCZriaQw1uPaXCTLKUC/Yy8QJ8NT66nrR+0Xt
	y/tn+HgKbwYuxlBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705964747;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RMmD19Va6uoSBzoselCt3P1uMVFvKzLAPpQQ76TCNpA=;
	b=09N6/asbA8EdQZS1+Xzdd7gQKmoGJEKaWPSYYXdu/ngXaGDGDV7A4nQl1cqRYEwFzht2mQ
	VL2dyh46xhr5RvGN07Og6ESJOsBerhbdIU+EQi3b8TUg6gnGwA/6PVwaPXvVTQu4NUxe/5
	bIpezahq+/25cFO02cehAv4FyaV54CY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705964747;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RMmD19Va6uoSBzoselCt3P1uMVFvKzLAPpQQ76TCNpA=;
	b=2W6Ghoz2bv1CrviVPmJHPGI3ACFonjz/0HCZriaQw1uPaXCTLKUC/Yy8QJ8NT66nrR+0Xt
	y/tn+HgKbwYuxlBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A3F1813310;
	Mon, 22 Jan 2024 23:05:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id vsKZJ8v0rmVBDAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 22 Jan 2024 23:05:47 +0000
Date: Tue, 23 Jan 2024 00:05:26 +0100
From: David Sterba <dsterba@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Btrfs fixes for 6.8-rc2
Message-ID: <20240122230526.GF31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1705946889.git.dsterba@suse.com>
 <CAHk-=wgHDYsNm7CG3szZUotcNqE_w+ojcF+JG88gn5px7uNs0Q@mail.gmail.com>
 <CAHk-=wiroGW6OMrPXrFg8mxYJa+362XJTsD5HkHXUHffcMieAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiroGW6OMrPXrFg8mxYJa+362XJTsD5HkHXUHffcMieAA@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.00
X-Spamd-Result: default: False [-1.00 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[37.85%]
X-Spam-Flag: NO

On Mon, Jan 22, 2024 at 02:54:31PM -0800, Linus Torvalds wrote:
> On Mon, 22 Jan 2024 at 14:34, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Bah. These fixes are garbage. Now my machine doesn't even boot. I'm
> > bisecting

Ah, sorry.

> My bisection says
> 
>    1e7f6def8b2370ecefb54b3c8f390ff894b0c51b is the first bad commit

We got a report today [1] that this commit is indeed bad,

https://lore.kernel.org/linux-btrfs/CABq1_vj4GpUeZpVG49OHCo-3sdbe2-2ROcu_xDvUG-6-5zPRXg@mail.gmail.com/

the timing was also unfortuate and too late to recall the pull request.

> but I'll still have to verify by testing the revert on top of my current tree.
> 
> It did revert cleanly, but I also note that if the zstd case is wrong,
> I assume the other very similar commits (for zlib and lzo) are
> potentially also wrong.
> 
> Let me reboot to verify that at least my machine boots.

Per the report revert makes it work again and zlib and lzo cases are not
affected.

I can send a pull request reverting all the three until we figure out
what's wrong, or you can do it as all revert cleanly.

