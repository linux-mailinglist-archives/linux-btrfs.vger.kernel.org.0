Return-Path: <linux-btrfs+bounces-2803-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B715867AEC
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 16:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C7951C2165C
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 15:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF1A12BF12;
	Mon, 26 Feb 2024 15:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JciYq2IO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HvjPH1Qq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FwDkxcOA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ejkG3u4f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D550D129A91
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Feb 2024 15:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708963019; cv=none; b=CbhJR6T3rQHMURd3ZYywU2cmpFMVrjeOUpiTH8Q/fLy4QCZpU2HIL+adsJw8ZTG2Ja0dHK3sI4e28iYojR3CwIP3UI0y6TnO0tB7sK2PYLjjIwkysB1zH8ibRAw/W7YbYkRUtHCbXaXzH4bRYdfnxsvm71PHAbAxhIHe8KEmZ8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708963019; c=relaxed/simple;
	bh=VWyEwHC8lEKo37cFhaYV3y2c1HXfB0qEpDxBK89PfDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g9dJiLje6bC7vYGe5ro08hipUgUMY0D98fB+EW+ASLinIH9r6aijpEbpj4Juw00VdvE/SdH857ka6AkmV7SqX8mf+l6KOWIAyT/1IEJa7XpY2LB7QxFRBViJvdm8rneIRMBhDARao66eBTPV58ajNG/3l6iCNCEdmGj6hleaY14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JciYq2IO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HvjPH1Qq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FwDkxcOA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ejkG3u4f; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DE14F1FB5E;
	Mon, 26 Feb 2024 15:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708963016;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E+AiBFujTPApw4nSJPxpC7Eo65GGD0/FHH20UjitfOY=;
	b=JciYq2IOdcj+1X09O0uzjdScioDDSHNUwYEYKbEcGm0ZDthgRJiG6JoAP6ycZd6vLQnKo4
	nr0dKd6Ra7GZkpmiSQSFGIi6uJEumJuaAgRBQ4pe/F3fSpmX7ohwbmvtq7oAXDlEZLJ4Yw
	B67bZ7IGKFh5hxLYytZme4lic3K80IE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708963016;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E+AiBFujTPApw4nSJPxpC7Eo65GGD0/FHH20UjitfOY=;
	b=HvjPH1Qqv4kUPF372Jq2pW+PmCZOS8hH4rMaVRa7sNyJfG6yeDQ+CxdEZ6NETthgeQsz+0
	cFwBs5osJGLvqfAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708963015;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E+AiBFujTPApw4nSJPxpC7Eo65GGD0/FHH20UjitfOY=;
	b=FwDkxcOA9Ix0SEkOpePOjIi6bWuAutaDDYKGrV81F1vb4MT/DqIbFDPpz9mJMVRNRVcY98
	tRMWwT2mlHIFg3meDwMs3WpgEyeqCpMj6oSHeKSmoZpYPm7J/JNYUGLaVqmedsPOWaYiwT
	XHOjSZ+wuBGbHCJerICVP0CQ9VgrKBk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708963015;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E+AiBFujTPApw4nSJPxpC7Eo65GGD0/FHH20UjitfOY=;
	b=ejkG3u4fQrLql9qqxuv+JI4jWvbEJqkONWSNSJJODTXFZxxrNJg9GRcvk8UCtqNaPf4Qzj
	8nNJnRPkCEGcRvDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C2EAE1329E;
	Mon, 26 Feb 2024 15:56:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id qv1lL8e03GX2dQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 26 Feb 2024 15:56:55 +0000
Date: Mon, 26 Feb 2024 16:56:11 +0100
From: David Sterba <dsterba@suse.cz>
To: Tavian Barnes <tavianator@tavianator.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: Corruption while bisecting (was: [PATCH] btrfs: tree-checker:
 dump the page status if hit something wrong)
Message-ID: <20240226155611.GG17966@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <CABg4E-=u7m_g3HCFUYHS-+RC==pefkUZXiTT2Aor86jruHSF9Q@mail.gmail.com>
 <f9296554-9c90-4991-a67e-d1a8defafca3@gmx.com>
 <CABg4E-nWKrpS+BVuiPosikO1ZSotcfqLo0BFjF7h-_G70G2KBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABg4E-nWKrpS+BVuiPosikO1ZSotcfqLo0BFjF7h-_G70G2KBg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FwDkxcOA;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ejkG3u4f
X-Spamd-Result: default: False [-0.19 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 FREEMAIL_ENVRCPT(0.00)[gmx.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 TO_DN_SOME(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[gmx.com,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.18)[70.14%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.19
X-Rspamd-Queue-Id: DE14F1FB5E
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Mon, Feb 26, 2024 at 10:49:40AM -0500, Tavian Barnes wrote:
> On Mon, Feb 26, 2024 at 3:30 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> > 在 2024/2/26 06:00, Tavian Barnes 写道:
> root@archiso ~ # dmesg | grep svg
> [ 2967.927789] BTRFS warning (device dm-0): checksum error at logical
> 7270571376640 on dev /dev/mapper/slash3, physical 920567676928, root
> 136483, inode 60843632, offset 110592, length 4096, links 1 (path:
> usr/share/inkscape/tutorials/tutorial-shapes.nl.svg)
> root@archiso ~ # xxd -s 920567676928 -l 32 /dev/mapper/slash3
> d6561c0000: 1a9c a774 a62d 61dc 96e6 fca8 0070 2326  ...t.-a......p#&
> d6561c0010: 7579 99b0 096d d4f2 453d 54e1 ec76 81e0  uy...m..E=T..v..
> 
> That matches the file contents at the beginning of the corruption.  At
> first I thought maybe the device tree was corrupt, pointing the stripe
> to the wrong disk offset and reading something random, but then I
> thought to check the raw encrypted bytes as the corresponding offset:
> 
> root@archiso ~ # cryptsetup luksDump /dev/nvme3n1p2 | grep -B2 offset
> Data segments:
>  0: crypt
>        offset: 16777216 [bytes]
> root@archiso ~ # xxd -s $((920567676928 + 16777216)) -l 32 /dev/nvme3n1p2
> d6571c0000: 0000 0000 0000 0000 0000 0000 0000 0000  ................
> d6571c0010: 0000 0000 0000 0000 0000 0000 0000 0000  ................
> 
> So what I'm seeing is basically a whole stripe that has been zeroed
> out, and LUKS is decrypting those zeros to random bytes.

That's a good find and the explanation sounds plausible. Not the first
time we see strange errors in connection with LUKS/dm-crypt and discard.

