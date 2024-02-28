Return-Path: <linux-btrfs+bounces-2859-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7723D86B1E4
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 15:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04FD42892E1
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 14:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F59159574;
	Wed, 28 Feb 2024 14:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FTNunIMv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mZUV9WiW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FTNunIMv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mZUV9WiW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325465FF16
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Feb 2024 14:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709130829; cv=none; b=Anfh+3dzsYc60sg8rNAI1YwtH0T4na+sbNBAvny+tnkJI/rMESAhYCRQHgvNptA+IVuPr6fphK9pVDFeZHJo8FEmjbqGcIYuaNBWA6/PtKLMn6YzsUoFgyCdF33OGgJrIfJTIRrtW7FvybWXj2gh/K/nVfNlvedfiUlBHtlj9XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709130829; c=relaxed/simple;
	bh=wCqGLKJ3NZAMYFQv8JmkShaIjeTsTYbDJ1Mb5ifkbqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wb9aeWDWRqQ/Id42hUijmEFIsIUd/ndpU3bufDiZQspqXD0PmSX6h0uY6exN4GCdc79+4QeAkKwvubdZ4Q2rUe61Jr/FBiOF6XQ/EEBXjIpxAQxAg9vjyp4B6vgOuuGXEIulaKMige1GPCtKjQop8IMd301rT/pDzXQXbr8q91c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FTNunIMv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mZUV9WiW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FTNunIMv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mZUV9WiW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7B7421F796;
	Wed, 28 Feb 2024 14:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709130826;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Waj+9u2frx2u8JWBNPc9e2T4oAAQbqT8vUt4xo5vafE=;
	b=FTNunIMvHOz3wcQdKqkmO7+4/Mn3oB4wuSSFY4UUlFGvH4KT5R42h6z7Xiq4XLkYcKrEeJ
	fVb/oRMcDrq6JkwzzSzHi3pDbCiogJgDiPFjVcYnarVX9I5t2vZMOWQLRrszSzimFc7rwF
	sz3ua3uj1xdlpQSUZr85BK2R3JFQDkU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709130826;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Waj+9u2frx2u8JWBNPc9e2T4oAAQbqT8vUt4xo5vafE=;
	b=mZUV9WiWdF/dRTCO0mDzAW6nWLK8UBjgEx2Vj8xlclKpHJYH9+ISabR80albp+i2UgqU6G
	VGt6QLbEPTFHQBDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709130826;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Waj+9u2frx2u8JWBNPc9e2T4oAAQbqT8vUt4xo5vafE=;
	b=FTNunIMvHOz3wcQdKqkmO7+4/Mn3oB4wuSSFY4UUlFGvH4KT5R42h6z7Xiq4XLkYcKrEeJ
	fVb/oRMcDrq6JkwzzSzHi3pDbCiogJgDiPFjVcYnarVX9I5t2vZMOWQLRrszSzimFc7rwF
	sz3ua3uj1xdlpQSUZr85BK2R3JFQDkU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709130826;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Waj+9u2frx2u8JWBNPc9e2T4oAAQbqT8vUt4xo5vafE=;
	b=mZUV9WiWdF/dRTCO0mDzAW6nWLK8UBjgEx2Vj8xlclKpHJYH9+ISabR80albp+i2UgqU6G
	VGt6QLbEPTFHQBDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5BB4D13A42;
	Wed, 28 Feb 2024 14:33:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id QF41FkpE32XKGAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 28 Feb 2024 14:33:46 +0000
Date: Wed, 28 Feb 2024 15:33:05 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, WA AM <waautomata@gmail.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: Super blocks checksum error on HM-SMR device
Message-ID: <20240228143305.GO17966@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <CANU2Z0EvUzfYxczLgGUiREoMndE9WdQnbaawV5Fv5gNXptPUKw@mail.gmail.com>
 <e88f9520-1d10-4d66-94fa-3ee86c515118@gmx.com>
 <da2e52b1-eb47-4e34-bb00-f606e16f01e6@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da2e52b1-eb47-4e34-bb00-f606e16f01e6@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.80 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[gmx.com,gmail.com,vger.kernel.org,wdc.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

On Mon, Feb 26, 2024 at 03:06:40PM +0000, Johannes Thumshirn wrote:
> On 24.02.24 22:52, Qu Wenruo wrote:
> > 
> > 
> > 在 2024/2/24 22:46, WA AM 写道:
> >> Greetings,
> >>
> >> I have a Western Digital Ultrastar DC HC620 (Hs14), a HM-SMR device.
> >> It is formatted to zoned BTRFS by `mkfs.btrfs`
> >> `btrfs scrub` reports the following errors:
> >>
> >> Scrub started:    Sat Feb 24 15:42:38 2024
> >> Status:           finished
> >> Duration:         0:09:34
> >> Total to scrub:   76.64GiB
> >> Rate:             136.72MiB/s
> >> Error summary:    super=2
> >>    Corrected:      0
> >>    Uncorrectable:  0
> >>    Unverified:     0
> >>
> >> [Sat Feb 24 15:42:38 2024] BTRFS info (device sdb): scrub: started on devid 1
> >> [Sat Feb 24 15:42:38 2024] BTRFS error (device sdb): super block at
> >> physical 65536 devid 1 has bad csum
> >> [Sat Feb 24 15:42:38 2024] BTRFS error (device sdb): super block at
> >> physical 67108864 devid 1 has bad csum
> >> [Sat Feb 24 15:52:12 2024] BTRFS info (device sdb): scrub: finished on
> >> devid 1 with status: 0
> >>
> >>
> >> What went wrong with the super blocks?
> > 
> > I believe it's a false alert.
> > 
> > As for zoned devices btrfs no longer puts super blocks at fixed physical
> > locations, but I'm not an expert on zoned detailed.
> > 
> > @Johannes and @naohiro, mind to check the situation?
> 
> Yes it doesn't and scrub_supers() grabs the super block addresses via 
> btrfs_sb_offset() instead of using btrfs_sb_log_location().
> 
> So this definitely is a bug, which we must fix.
> 
> Something like this (untested) should do the trick for this case, but I 
> haven't audited other uses of btrfs_sb_offset() if they're safe (a.k.a. 
> non-zoned only).
> 
> 
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 0123d2728923..08293c0095ed 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -2805,7 +2805,10 @@ static noinline_for_stack int scrub_supers(struct 
> scrub_ctx *sctx,
>                  gen = btrfs_get_last_trans_committed(fs_info);
> 
>          for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
> -               bytenr = btrfs_sb_offset(i);
> +               ret = btrfs_sb_log_location(scrub_dev, i, 0, &bytenr);
> +               if (ret)
> +                       goto out_free_page;

That indeed looks like the scrub rewrite dropped support for zoned super
blocks, any use of btrfs_sb_offset() could be considered suspicious if
it's not behind !btrfs_is_zoned().

