Return-Path: <linux-btrfs+bounces-1530-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52466830D8F
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 20:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1B98B215A9
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 19:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDA824A11;
	Wed, 17 Jan 2024 19:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pBAyXJA3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bEQyoUXO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pBAyXJA3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bEQyoUXO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D53E249FE
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 19:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705521510; cv=none; b=gvECdngf8Mwk/uVSzbGh7qSJtJX6mzta2FJIXTnUFFLu/be1jAJ0iE1mBUnKNMIq3CKCzhXmSOoiDhDQJdUjHnjwjhAiEHSA6Lq2yKuWkL7GnYB2WqDBUPXIsYzjZwmdamwUYoxvVyHWQH4b1JRV0p2dSs70RyKkPT7DmYId69Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705521510; c=relaxed/simple;
	bh=CcdSNi6nsJcRYK30kzWHXGgo8zHDyY2O6jAQNlWy3Nw=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:Reply-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent:X-Spamd-Result:
	 X-Rspamd-Server:X-Spam-Score:X-Rspamd-Queue-Id:X-Spam-Level:
	 X-Spam-Flag:X-Spamd-Bar; b=RUG+8eifJAvVJ/CI4YTC37JRL/eE/g67HPG7+vKZ2rbtN4XGkb436KA3XvoLApr9lCEYW43i4ODm2g6hCNV92EcnA8M/6M8owuMkDIvlMM24XXe/M66rWSTO5vt+sRe7XuAQtBLvkESlqpnb4Ru1mOCLLfflQLckym//QvHXseQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pBAyXJA3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bEQyoUXO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pBAyXJA3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bEQyoUXO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2701C1F387;
	Wed, 17 Jan 2024 19:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705521506;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c8ZLlWEyJc/QH2WQ/NE78P9o5WaXRgOLBdT2d2vUB6I=;
	b=pBAyXJA31jIweovE4BPxuYUFOsfWU4Gk4eWCYmFhxW2lcYNHNV1zq/ITXez7Df7dTntuwA
	ba8Y5NxBg483i8e3/D+nD0S5ddIhlW5JSGlHi0Z/YWB+b/g9i7/mdqWvOcnsWNWQ4Lr4bV
	wvWAouk+z0fMptB2I7lgJVJG9KTADvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705521506;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c8ZLlWEyJc/QH2WQ/NE78P9o5WaXRgOLBdT2d2vUB6I=;
	b=bEQyoUXOd9qnLyoGvMj7ui4J50BR7CYwznxZXgbS1QZxRGj1QBpiUOo25LbntakbtKboGJ
	a+HEu4BFEa0RFXAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705521506;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c8ZLlWEyJc/QH2WQ/NE78P9o5WaXRgOLBdT2d2vUB6I=;
	b=pBAyXJA31jIweovE4BPxuYUFOsfWU4Gk4eWCYmFhxW2lcYNHNV1zq/ITXez7Df7dTntuwA
	ba8Y5NxBg483i8e3/D+nD0S5ddIhlW5JSGlHi0Z/YWB+b/g9i7/mdqWvOcnsWNWQ4Lr4bV
	wvWAouk+z0fMptB2I7lgJVJG9KTADvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705521506;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c8ZLlWEyJc/QH2WQ/NE78P9o5WaXRgOLBdT2d2vUB6I=;
	b=bEQyoUXOd9qnLyoGvMj7ui4J50BR7CYwznxZXgbS1QZxRGj1QBpiUOo25LbntakbtKboGJ
	a+HEu4BFEa0RFXAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 10CC413482;
	Wed, 17 Jan 2024 19:58:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id URqlA2IxqGWzZQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 17 Jan 2024 19:58:26 +0000
Date: Wed, 17 Jan 2024 20:58:03 +0100
From: David Sterba <dsterba@suse.cz>
To: Goffredo Baroncelli <kreijack@libero.it>
Cc: linux-btrfs@vger.kernel.org, Goffredo Baroncelli <kreijack@inwind.it>
Subject: Re: [PATCH] btrfs fi us: wrong values in case of raid5 and not root
Message-ID: <20240117195803.GN31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <e8659631b0481defe32fcde435432da630af6789.1704400902.git.kreijack@inwind.it>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8659631b0481defe32fcde435432da630af6789.1704400902.git.kreijack@inwind.it>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pBAyXJA3;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=bEQyoUXO
X-Spamd-Result: default: False [-0.01 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 FREEMAIL_ENVRCPT(0.00)[inwind.it,libero.it];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[libero.it:email,inwind.it:email,suse.cz:dkim];
	 FREEMAIL_TO(0.00)[libero.it];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,inwind.it];
	 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.01
X-Rspamd-Queue-Id: 2701C1F387
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Thu, Jan 04, 2024 at 09:41:42PM +0100, Goffredo Baroncelli wrote:
> From: Goffredo Baroncelli <kreijack@inwind.it>
> 
> In case of a raid5/6 filesystem 'btrfs fi us' returns wrong values
> without the root capabilities.
> 
> $ sudo btrfs fi us /tmp/raid5fs  # as root
> Overall:
>     Device size:                   3.00GiB
>     Device allocated:              1.51GiB		<--- OK
>     Device unallocated:            1.49GiB		<--- OK
>     Device missing:                  0.00B
>     Device slack:                    0.00B
>     Used:                        769.03MiB		<--- OK
>     Free (estimated):              1.32GiB      (min: 1.32GiB) <-OK
>     Free (statfs, df):             1.32GiB
>     Data ratio:                       1.50		<--- OK
>     Metadata ratio:                   1.50		<--- OK
>     Global reserve:                5.50MiB      (used: 0.00B)
>     Multiple profiles:                  no
> [...]
> 
> $ btrfs fi us /tmp/raid5fs      # as user
> WARNING: cannot read detailed chunk info, per-device usage will not be shown, run as root
> Overall:
>     Device size:                   3.00GiB
>     Device allocated:                0.00B		<--- WRONG
>     Device unallocated:            3.00GiB		<--- WRONG
>     Device missing:                  0.00B
>     Device slack:                    0.00B
>     Used:                            0.00B		<--- WRONG
>     Free (estimated):                0.00B      (min: 8.00EiB) <- WRONG
>     Free (statfs, df):             1.32GiB
>     Data ratio:                       0.00		<--- WRONG
>     Metadata ratio:                   0.00		<--- WRONG
>     Global reserve:                5.50MiB      (used: 0.00B)
>     Multiple profiles:                  no
> [...]
> 
> The reason is that the BTRFS_IOC_SPACE_INFO ioctl doesn't return enough
> info. To bypass it a scan of the chunks is required when a raid5/6
> profile is present.
> 
> To avoid providing wrong information, in case of a raid5/6 filesystem
> without the root capabilities the "btrfs fi us" is not executed at all
> and a warning with a suggestion to run it as root is printed.
> 
> $ ./btrfs fi us /tmp/t/
> WARNING: cannot read detailed chunk info, per-device usage will not be shown, run as root
> WARNING: due to the presence of a raid5/raid6 profile, we cannots compute some values;
> WARNING: run as root instead.
> $
> 
> Signed-off-by: Goffredo Baroncelli <kreijack@libero.it>

Added to devel, thanks.

