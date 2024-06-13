Return-Path: <linux-btrfs+bounces-5688-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2852F905FAA
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 02:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BD55283FCE
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 00:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD04D848E;
	Thu, 13 Jun 2024 00:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fm3uGj5v";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0ZaLQVS9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fm3uGj5v";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0ZaLQVS9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407E44A2C
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 00:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718238187; cv=none; b=LwV40Q0Cx5OuYwqa0b2dxMQbMNlWHh5F2ptn6Gw3L60kEp2EDmlibf+iNXVDVsaG4Mq6VL0GZjQ5r2LkmrU1k44zq0RX/SREoSAz4Nw+qxL821IEIzgqkbnMXKv/PBCY8BCExkuRMFYY2z+z8kA4xOlhJeIlX4CfewsyzPghmfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718238187; c=relaxed/simple;
	bh=H8kFIC+rqXfIYPrkWEl7Bm985BaMBhJkcrDHleKwohA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i92X4QRcZ+kr23hD0N93s5d4he4tufSccEWfi3c/CkBvl6Koo5jThPDtqVg/xrq/0ESDsjs6zLRZMsz/Tp2knlh02mA+UpUoUOsWqBmelQ2MD4OyLmHlscBUVycSc0fTHXmzNMndAzisafWYhoWeS/DzUbhxvSL53WCBP8wbwog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fm3uGj5v; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0ZaLQVS9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fm3uGj5v; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0ZaLQVS9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0818834B7B;
	Thu, 13 Jun 2024 00:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718238183;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aZEp5pCtc3myPa7WqSeigqxczuVYsHImQGEtW4cU3R8=;
	b=fm3uGj5vbtCqfYAZThJkOTW2wrDywJ4jr8ArqJf8LmPd10P+ebce6lPGlDsq2XhTU9PsmR
	iGwX4OdgbmczoNIulaBubzBrXmmywOiDQwhsaAngU+il6nFy0IG/spfd0hkw67JSJPZ7pU
	d+w3ATrPYM32mFxd54LGHX2mahB8Sjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718238183;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aZEp5pCtc3myPa7WqSeigqxczuVYsHImQGEtW4cU3R8=;
	b=0ZaLQVS9+C6zmaxmi1SzbvUyWB/QngNNv28mPuSCjV4Yj2awWPQn4eKO5dUssPdC+Ekcdk
	D+SwTZkmiFi48GDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=fm3uGj5v;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0ZaLQVS9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718238183;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aZEp5pCtc3myPa7WqSeigqxczuVYsHImQGEtW4cU3R8=;
	b=fm3uGj5vbtCqfYAZThJkOTW2wrDywJ4jr8ArqJf8LmPd10P+ebce6lPGlDsq2XhTU9PsmR
	iGwX4OdgbmczoNIulaBubzBrXmmywOiDQwhsaAngU+il6nFy0IG/spfd0hkw67JSJPZ7pU
	d+w3ATrPYM32mFxd54LGHX2mahB8Sjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718238183;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aZEp5pCtc3myPa7WqSeigqxczuVYsHImQGEtW4cU3R8=;
	b=0ZaLQVS9+C6zmaxmi1SzbvUyWB/QngNNv28mPuSCjV4Yj2awWPQn4eKO5dUssPdC+Ekcdk
	D+SwTZkmiFi48GDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D796F13A7F;
	Thu, 13 Jun 2024 00:23:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tAp1NOY7amYMYQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 13 Jun 2024 00:23:02 +0000
Date: Thu, 13 Jun 2024 02:23:01 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Srivathsa Dara <srivathsa.d.dara@oracle.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	Rajesh Sivaramasubramaniom <rajesh.sivaramasubramaniom@oracle.com>,
	Junxiao Bi <junxiao.bi@oracle.com>, "clm@fb.com" <clm@fb.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"dsterba@suse.com" <dsterba@suse.com>
Subject: Re: [PATCH v2] btrfs-progs: convert: Add 64 bit block numbers support
Message-ID: <20240613002301.GT18508@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240606102215.3695032-1-srivathsa.d.dara@oracle.com>
 <c3060faf-f0e8-4bd2-865b-332e423a8801@gmx.com>
 <DM6PR10MB4347A0EADF68B973447C5591A0C72@DM6PR10MB4347.namprd10.prod.outlook.com>
 <20240612203743.GQ18508@twin.jikos.cz>
 <20240613000200.GS18508@twin.jikos.cz>
 <cd0fca3a-94bf-4913-882f-ee433a61e06f@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd0fca3a-94bf-4913-882f-ee433a61e06f@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 0818834B7B
X-Spam-Score: -4.21
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmx.com];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Thu, Jun 13, 2024 at 09:40:57AM +0930, Qu Wenruo wrote:
> 在 2024/6/13 09:32, David Sterba 写道:
> > On Wed, Jun 12, 2024 at 10:37:43PM +0200, David Sterba wrote:
> >> On Tue, Jun 11, 2024 at 06:03:30AM +0000, Srivathsa Dara wrote:
> >>>> 在 2024/6/6 19:52, Srivathsa Dara 写道:
> >>>>>    	if (err)
> >>>>>    		goto error;
> >>>>> diff --git a/convert/source-ext2.h b/convert/source-ext2.h index
> >>>>> d204aac5..62c9b1fa 100644
> >>>>> --- a/convert/source-ext2.h
> >>>>> +++ b/convert/source-ext2.h
> >>>>> @@ -46,7 +46,7 @@ struct btrfs_trans_handle;
> >>>>>    #define ext2fs_get_block_bitmap_range2 ext2fs_get_block_bitmap_range
> >>>>>    #define ext2fs_inode_data_blocks2 ext2fs_inode_data_blocks
> >>>>>    #define ext2fs_read_ext_attr2 ext2fs_read_ext_attr
> >>>>> -#define ext2fs_blocks_count(s)		((s)->s_blocks_count)
> >>>>> +#define ext2fs_blocks_count(s)		(((s)->s_blocks_count_hi << 32) | (s)->s_blocks_count)
> >>>>
> >>>> This is definitely needed, or it would trigger the ASSERT().
> >>>>
> >>>> But again, the newer btrfs-progs no longer go with internally defined ext2fs_blocks_count(), but using the one from e2fsprogs headers, and the library version is already returning blk64_t.
> >>>
> >>> Okay, got it.
> >>>
> >>> Tested the code base with the commit c23e068aaf91, it does handle 64 bit block numbers.
> >>
> >> So, is this patch still needed? I'm not sure after Qu fixed the
> >> iteration, the tests pass without the patch too.
> >
> > Locally the test succeeds (e2fsprogs 1.47.0), however in the github CI
> > it fails with:
> >
> > mke2fs -t ext4 -b 4096 -F /home/runner/work/btrfs-progs/btrfs-progs/tests/test.img
> > mke2fs 1.46.5 (30-Dec-2021)
> > mke2fs: Device size reported to be zero.  Invalid partition specified, or
> > 	partition table wasn't reread after running fdisk, due to
> > 	a modified partition being busy and in use.  You may need to reboot
> > 	to re-read your partition table.
> 
> The error is from mke2fs, and considering how old the version is in CI,
> it may be e2fsprogs itself unable to properly detect the 16T file.
> 
> If we begin to start add checks on e2fsprogs, it's going to end up ugly...
> 
> Any good idea to go forward?
> Update CI (which seems impossible) or make the mke2fs part as mayfail
> and skip it?

I think using mayfail for mke2fs is the best option, I don't want to
check versions. The release of 1.46.5 is 2021-12-30, this is not that
old and likely widely used. Skipping the particular case is not a big
deal as it'll be covered on other testing instances.

