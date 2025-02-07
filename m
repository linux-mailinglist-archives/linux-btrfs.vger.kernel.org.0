Return-Path: <linux-btrfs+bounces-11347-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA49A2CD0B
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2025 20:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 649503AB67D
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2025 19:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4EF19CC05;
	Fri,  7 Feb 2025 19:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="klMrNwXN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fjLuku+0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="klMrNwXN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fjLuku+0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C468423C8CB;
	Fri,  7 Feb 2025 19:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738957692; cv=none; b=ohKwiYoMsktNSC+d6GiunWhosSXl0WBN3QneJ5oFp+U1qFiKs9O4EMYZDiVv1ZTD3CMk1S3J9XkpvpwN2YtAzmLIWfb5H5gRh8V9qtIbjMwqNpKTkUOtOWHdfX8faG5G/RfzK6Lx26gXFDfgNFRE+7naB0gS3GkIv2JsCWUCQTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738957692; c=relaxed/simple;
	bh=CCnA9zjjCz0q7IrDviAdyHhoBFx0NDMm7KnhrMwXuUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gs/IHlRUfBi26ibg4fdxK3d57Q2WjN2p49V6TmJ7SH5SEt4TbPpFp8xgDTk/MqXjPuwFOKsEX0dlmgLGnoPFu6YKllWtwL0YiiN1qxmSp9+2j9iC62yHw7w7ufYvu+NTTyWQc1enq0shgQ1e4griVPF97tWhK6juw/AK+UqOe1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=klMrNwXN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fjLuku+0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=klMrNwXN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fjLuku+0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C7A762116E;
	Fri,  7 Feb 2025 19:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738957688;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KtpXowidEIrM6XOTHSfAW6hUtQEoRK0kPdHOE3Zz/WY=;
	b=klMrNwXNyVt+UoUG2xsindrLrdJfWjRZX2D/8L51i9Tki5nMqgYJmkdvgO5brKgmQrU2b3
	FmouNCGdIHn3WBi7mjUBkuFdDo70tQtNFCjKFb+2DNW7IWJWRsWcjak5FPUmerYdeZ4wYp
	nFU0HjqKA1gN3jloBNFJyNsTyydires=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738957688;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KtpXowidEIrM6XOTHSfAW6hUtQEoRK0kPdHOE3Zz/WY=;
	b=fjLuku+0YQQkQR3hpBLR7yJt+Mcrv/hfjWwVfCvumQGgpAroGoASgMIt41t5ekeBKYPdCT
	wCMHoyQI5Io+gBDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738957688;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KtpXowidEIrM6XOTHSfAW6hUtQEoRK0kPdHOE3Zz/WY=;
	b=klMrNwXNyVt+UoUG2xsindrLrdJfWjRZX2D/8L51i9Tki5nMqgYJmkdvgO5brKgmQrU2b3
	FmouNCGdIHn3WBi7mjUBkuFdDo70tQtNFCjKFb+2DNW7IWJWRsWcjak5FPUmerYdeZ4wYp
	nFU0HjqKA1gN3jloBNFJyNsTyydires=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738957688;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KtpXowidEIrM6XOTHSfAW6hUtQEoRK0kPdHOE3Zz/WY=;
	b=fjLuku+0YQQkQR3hpBLR7yJt+Mcrv/hfjWwVfCvumQGgpAroGoASgMIt41t5ekeBKYPdCT
	wCMHoyQI5Io+gBDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ABA7B13694;
	Fri,  7 Feb 2025 19:48:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BOu3KXhjpmciGAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 07 Feb 2025 19:48:08 +0000
Date: Fri, 7 Feb 2025 20:48:03 +0100
From: David Sterba <dsterba@suse.cz>
To: David Sterba <dsterba@suse.cz>
Cc: Daniel Vacek <neelx@suse.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Nick Terrell <terrelln@fb.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] btrfs: zstd: enable negative compression levels mount
 option
Message-ID: <20250207194803.GP5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250130175821.1792279-1-neelx@suse.com>
 <20250205181705.GL5777@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205181705.GL5777@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: *
X-Spamd-Result: default: False [1.00 / 50.00];
	REPLYTO_EQ_TO_ADDR(5.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: 1.00

On Wed, Feb 05, 2025 at 07:17:05PM +0100, David Sterba wrote:
> On Thu, Jan 30, 2025 at 06:58:19PM +0100, Daniel Vacek wrote:
> > This patch allows using the fast modes (negative compression levels) of zstd
> > as a mount option.
> > 
> > As per the results, the compression ratio is lower:
> > 
> > for level in {-15..-1} 1 2 3; \
> > do printf "level %3d\n" $level; \
> >   mount -o compress=zstd:$level /dev/sdb /mnt/test/; \
> >   grep sdb /proc/mounts; \
> >   cp -r /usr/bin       /mnt/test/; sync; compsize /mnt/test/bin; \
> >   cp -r /usr/share/doc /mnt/test/; sync; compsize /mnt/test/doc; \
> >   cp    enwik9         /mnt/test/; sync; compsize /mnt/test/enwik9; \
> >   cp    linux-6.13.tar /mnt/test/; sync; compsize /mnt/test/linux-6.13.tar; \
> >   rm -r /mnt/test/{bin,doc,enwik9,linux-6.13.tar}; \
> >   umount /mnt/test/; \
> > done |& tee results | \
> > awk '/^level/{print}/^TOTAL/{print$3"\t"$2"  |"}' | paste - - - - -
> > 
> > 		266M	bin  |	45M	doc  |	953M	wiki |	1.4G	source
> > =============================+===============+===============+===============+
> > level -15	180M	67%  |	30M	68%  |	694M	72%  |	598M	40%  |
> > level -14	180M	67%  |	30M	67%  |	683M	71%  |	581M	39%  |
> > level -13	177M	66%  |	29M	66%  |	671M	70%  |	566M	38%  |
> > level -12	174M	65%  |	29M	65%  |	658M	69%  |	548M	37%  |
> > level -11	174M	65%  |	28M	64%  |	645M	67%  |	530M	35%  |
> > level -10	171M	64%  |	28M	62%  |	631M	66%  |	512M	34%  |
> > level  -9	165M	62%  |	27M	61%  |	615M	64%  |	493M	33%  |
> > level  -8	161M	60%  |	27M	59%  |	598M	62%  |	475M	32%  |
> > level  -7	155M	58%  |	26M	58%  |	582M	61%  |	457M	30%  |
> > level  -6	151M	56%  |	25M	56%  |	565M	59%  |	437M	29%  |
> > level  -5	145M	54%  |	24M	55%  |	545M	57%  |	417M	28%  |
> > level  -4	139M	52%  |	23M	52%  |	520M	54%  |	391M	26%  |
> > level  -3	135M	50%  |	22M	50%  |	495M	51%  |	369M	24%  |
> > level  -2	127M	47%  |	22M	48%  |	470M	49%  |	349M	23%  |
> > level  -1	120M	45%  |	21M	47%  |	452M	47%  |	332M	22%  |
> > level   1	110M	41%  |	17M	39%  |	362M	38%  |	290M	19%  |
> > level   2	106M	40%  |	17M	38%  |	349M	36%  |	288M	19%  |
> > level   3	104M	39%  |	16M	37%  |	340M	35%  |	276M	18%  |
> > 
> > Signed-off-by: Daniel Vacek <neelx@suse.com>
> > ---
> > Changes in v4:
> >  * Fix a bug with workspace lru_list.
> >  * Keep the levels down to -15 as agreed.
> 
> Thanks, I'll add the patch to for-next soon. The information about times
> is only a changelog update so this can be done later once we have it.

Now added to for-next.

