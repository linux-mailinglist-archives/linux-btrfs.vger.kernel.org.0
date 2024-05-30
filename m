Return-Path: <linux-btrfs+bounces-5369-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B53848D5172
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 May 2024 19:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D868C1C23568
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 May 2024 17:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6149487BC;
	Thu, 30 May 2024 17:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GIdF+Fzu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EYWXA6nK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EkEkKmAw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9Bpi1fSF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59392C6AE
	for <linux-btrfs@vger.kernel.org>; Thu, 30 May 2024 17:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717091125; cv=none; b=X1Qs4R5dg0PU5mjKkL9LFTBCWdWaygyCI0IvqFzBQzusN76BEyk0Rmgl16/H3Vp2CCtWG9SQC3cOAP2TYtl2p04BU8Id4vPohPes+bRnK8e3mhZlEeIEUck4okLizhlf1DJtS36y+/4lHjsAJN7hhB02DD+Nz1+H/kLtFblUolc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717091125; c=relaxed/simple;
	bh=et+RnSL562/ImqajW+wv/+TEJneguwcitNlqUTJIY2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9OsQh9H5qSqmkkre39bd+ipJUoDFvKdMjI7CruXeYlFsiDTw35sw733BN469DL4tJXlv6rlplNf5tRycZUyoUS1I463X1F9mEeOBhzUCo0NyCEY6gO9HN8X1NpXlxEoGcVqPeVS3ghAtaHdYNnspN43xGoG6rFd3cmmhM9hqxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GIdF+Fzu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EYWXA6nK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EkEkKmAw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9Bpi1fSF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C91CC1F769;
	Thu, 30 May 2024 17:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717091120;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qCsG0jOrPK5jpkcynPkDfBdyck3N/Jh0Yo6hLvQYm8I=;
	b=GIdF+FzuTGCubXvzLlEn/9jhgQm9B7z0vGhk6VPd92/g+aQkXKAJd9sbu52fnMglhnBa4Y
	mV+A1H7um2ZbeMLM8rB6PMvpGpeax8bNh+WuSqL8VThyxu4dUYoJWLnowcVTDbBU6eLdUa
	9hqk4K4WKcGsLhgXVUG5+FeJiTfOng8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717091120;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qCsG0jOrPK5jpkcynPkDfBdyck3N/Jh0Yo6hLvQYm8I=;
	b=EYWXA6nKUs0QZeEACbOkmuoooRCdXfF1ofiDgTJUY37oXuPjsWd7Ghi0GazoYt2+vS5oFR
	pAvWF+71YSGwKtDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EkEkKmAw;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9Bpi1fSF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717091119;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qCsG0jOrPK5jpkcynPkDfBdyck3N/Jh0Yo6hLvQYm8I=;
	b=EkEkKmAwmMyaSheivjwvToYb4CBUP/lP92YM5VdD/oBnDoxjMkMZG9xSvTKZF5CD1tSssG
	pyTt+2tTXz3EyBM+hWLC3qUcbYricQmOE3ZCnAZgeSiMlWGGANhA1YfheZCfoAhwOA9Aqv
	CgdRekc9wfIoxIs57YX3a/JxfsyUW/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717091119;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qCsG0jOrPK5jpkcynPkDfBdyck3N/Jh0Yo6hLvQYm8I=;
	b=9Bpi1fSFZAeqTECzOSU8glnktyFJZCVFwAY9cQPXLiqRZaQpYsiQZo19wq708ay/yAfxN/
	t5lpZ56SpwPkLbAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A32BB13A6C;
	Thu, 30 May 2024 17:45:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9Z6mJy+7WGYpIQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 30 May 2024 17:45:19 +0000
Date: Thu, 30 May 2024 19:45:18 +0200
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: Srivathsa Dara <srivathsa.d.dara@oracle.com>,
	linux-btrfs@vger.kernel.org, rajesh.sivaramasubramaniom@oracle.com,
	junxiao.bi@oracle.com, clm@fb.com, josef@toxicpanda.com,
	dsterba@suse.com
Subject: Re: [RESEND PATCH] btrfs-progs: convert: Add 64 bit block numbers
 support
Message-ID: <20240530174518.GC25460@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240530053754.4115449-1-srivathsa.d.dara@oracle.com>
 <d09a35c0-001d-472c-939d-2cebee21192e@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d09a35c0-001d-472c-939d-2cebee21192e@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,rasivara-arm2:email,oracle.com:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C91CC1F769
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.21

On Thu, May 30, 2024 at 07:00:34PM +0800, Anand Jain wrote:
> On 30/05/2024 13:37, Srivathsa Dara wrote:
> > In ext4, number of blocks can be greater than 2^32. Therefore, if
> > btrfs-convert is used on filesystems greater than or equal to 16TiB
> > (Staring from 16TiB, number of blocks overflow 32 bits), it fails to
> > convert.
> > 
> > Example:
> > 
> > Here, /dev/sdc1 is 16TiB partition intitialized with an ext4 filesystem.
> > 
> > [root@rasivara-arm2 opc]# btrfs-convert -d -p /dev/sdc1
> > btrfs-convert from btrfs-progs v5.15.1
> > 
> > convert/main.c:1164: do_convert: Assertion `cctx.total_bytes != 0` failed, value 0
> > btrfs-convert(+0xfd04)[0xaaaaba44fd04]
> > btrfs-convert(main+0x258)[0xaaaaba44d278]
> > /lib64/libc.so.6(__libc_start_main+0xdc)[0xffffb962777c]
> > btrfs-convert(+0xd4fc)[0xaaaaba44d4fc]
> > Aborted (core dumped)
> > 
> > Fix it by considering 64 bit block numbers.
> > 
> > Signed-off-by: Srivathsa Dara <srivathsa.d.dara@oracle.com>
> > ---
> >   convert/source-ext2.c | 6 +++---
> >   convert/source-ext2.h | 2 +-
> >   2 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/convert/source-ext2.c b/convert/source-ext2.c
> > index 2186b252..afa48606 100644
> > --- a/convert/source-ext2.c
> > +++ b/convert/source-ext2.c
> > @@ -288,8 +288,8 @@ error:
> >   	return -1;
> >   }
> >   
> > -static int ext2_block_iterate_proc(ext2_filsys fs, blk_t *blocknr,
> > -			        e2_blkcnt_t blockcnt, blk_t ref_block,
> > +static int ext2_block_iterate_proc(ext2_filsys fs, blk64_t *blocknr,
> > +			        e2_blkcnt_t blockcnt, blk64_t ref_block,
> >   			        int ref_offset, void *priv_data)
> >   {
> >   	int ret;
> > @@ -323,7 +323,7 @@ static int ext2_create_file_extents(struct btrfs_trans_handle *trans,
> >   	init_blk_iterate_data(&data, trans, root, btrfs_inode, objectid,
> >   			convert_flags & CONVERT_FLAG_DATACSUM);
> >   
> > -	err = ext2fs_block_iterate2(ext2_fs, ext2_ino, BLOCK_FLAG_DATA_ONLY,
> > +	err = ext2fs_block_iterate3(ext2_fs, ext2_ino, BLOCK_FLAG_DATA_ONLY,
> 
> 
>   Are there any ext2progs library version dependencies when using
>   ext2fs_block_iterate3()?

There are but we don't have to worry, the function was added in 1998
https://github.com/tytso/e2fsprogs/commit/674a4ee1e3e05133ddad701730bfc21c283272a4

