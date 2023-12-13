Return-Path: <linux-btrfs+bounces-950-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C198122C0
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Dec 2023 00:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0C721F219C8
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 23:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E252F77B33;
	Wed, 13 Dec 2023 23:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T5elBqsq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WEXAWav4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T5elBqsq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WEXAWav4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04406A3
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Dec 2023 15:22:50 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 21D8922308;
	Wed, 13 Dec 2023 23:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702509768;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4SZ6W5UycOmsOMkSVcvZsUW11j4YuteeUWVQNOTwaR4=;
	b=T5elBqsqgtgSy2t4ZYFz2LEGh6wEvdQHQOEExuDSiloKVtZYZGnBBypcu3n4QKNIsmG2gv
	Ws8PVAUDwbP4zHRbbomFu2+ovAx++VNhcso0ilBnH5/+ArjComh75TpL5fnE1iu97OPSAl
	hLRCntwT6t1o75orXxIt2m33RatTxzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702509768;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4SZ6W5UycOmsOMkSVcvZsUW11j4YuteeUWVQNOTwaR4=;
	b=WEXAWav4iYo2XJFTb5nt7we3MIOxjMn2kJdciyU5AMwsHByU+Wxim8Kp2iKbZ5cRtE/nhZ
	kYRv89f+MMY/7cDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702509768;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4SZ6W5UycOmsOMkSVcvZsUW11j4YuteeUWVQNOTwaR4=;
	b=T5elBqsqgtgSy2t4ZYFz2LEGh6wEvdQHQOEExuDSiloKVtZYZGnBBypcu3n4QKNIsmG2gv
	Ws8PVAUDwbP4zHRbbomFu2+ovAx++VNhcso0ilBnH5/+ArjComh75TpL5fnE1iu97OPSAl
	hLRCntwT6t1o75orXxIt2m33RatTxzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702509768;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4SZ6W5UycOmsOMkSVcvZsUW11j4YuteeUWVQNOTwaR4=;
	b=WEXAWav4iYo2XJFTb5nt7we3MIOxjMn2kJdciyU5AMwsHByU+Wxim8Kp2iKbZ5cRtE/nhZ
	kYRv89f+MMY/7cDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0073A13240;
	Wed, 13 Dec 2023 23:22:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id NwY5O8c8emW1PgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 13 Dec 2023 23:22:47 +0000
Date: Thu, 14 Dec 2023 00:15:52 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
	David Disseldorp <ddiss@suse.de>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: drop unused memparse() parameter
Message-ID: <20231213231552.GK3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20231205111329.6652-1-ddiss@suse.de>
 <19fc847b-7df6-41fc-ad52-f4e7f6d13201@suse.com>
 <20231207121537.GU2751@twin.jikos.cz>
 <d8cd0a73-9ea8-4990-bcbe-949ff9c8cad8@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8cd0a73-9ea8-4990-bcbe-949ff9c8cad8@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Score: -4.00
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmx.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[gmx.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Fri, Dec 08, 2023 at 06:26:50AM +1030, Qu Wenruo wrote:
> > The value that can be read from the sysfs file is in bytes and it's so
> > that applications do not need to interpret it, like multiplying with
> > 1024. We'll probably never return the pretty values with suffixes in
> > sysfs files.
> >
> > However, on the input side the suffixes are a convenience, setting to
> > limit the throughput as '32m' is better than typing '32000000' and
> > counting zeros or $((32*1024*1024)) or 33554432.
> >
> > This is why memparse is there and kstrtoull does not do that.
> 
> That suffix is causing confusion already, just check my "25e" case.
> (It does not only lead to huge number, but also lead to incorrect value
> even if we treat "e" as a suffix)
> 
> Furthermore, the convenience argument is not that strong, you won't
> expect end users to do the change for a fs every time.
> Thus it's mostly managed by a small script or some other tool.
> 
> In that case I don't think doing extra bash calculation is a big deal
> anyway.

This is a nice study of convenience vs extra work "that's no big deal".
The sysfs files can be used by scripts, often times it's the only access
to some settings (like /usr/bin/rescan-scsi-bus.sh/usr/bin/rescan-scsi-bus.sh).
The value format, naming of the sysfs files is inconsistent and
navigating to a particular directory and setting some magic value is I
think common. Another example are trace points, or dynamic printk.

There are tools abstracting that but sometimes it's a person that needs
to type it and the shortcuts like the suffix are convenient because
there's no extra need to type exact syntax and numbers for a $((...))
expression. Ask 3 people if they'd prefer to type "4m" or
"$((4*1024*1024))".

If you ask me I'm all for allowing "4m" and I did that several times
when testing things like the discard tunables, chunk size or the scrub
limits. I consider the sysfs files an interface for human interaction so
even if it's used like that in 10% of time it's still saving typing or
allowing one to focus on the real prolem instead of shell sytax.

