Return-Path: <linux-btrfs+bounces-5676-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CE8905CE8
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2024 22:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0147F1F22E39
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2024 20:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B9F86ADC;
	Wed, 12 Jun 2024 20:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KJYZi4iv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gjP3yqmq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KJYZi4iv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gjP3yqmq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1091C8564B
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Jun 2024 20:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718224672; cv=none; b=iOw650ZYoNVNVMc7u8mR8TTqkrha+cPtI5beJg+92exTRbS7c9fMBgRG7FiYh1QgI7D77kEmW3cePY2yRWAzT8nQqxfv6BS0zlpLk2rnbWGhg8BUPXgb5Qn3bk8Yi9SIemiUB0nxcok0L/mG+gzXHUVpD9su6g03nXHzv22U6fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718224672; c=relaxed/simple;
	bh=qRd3qI9uutRQB42QPi6Zl5t/zpJuRn2XjezoEudk8k4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsvG7tCIqc/1z6WwvJGrdXef+sxFxDv1uhXs07o8LkzQ/advpSiEdssXBc07YePfHN0sZGLy8Tb/j8XH8txYJifX8FLJg1H6dU6RSUQKvwSo+417FeR5Z6AIBvjJWdERSY5Rq0p+WwGGBoXVl9fu2t+AH+/z5alU8eYJDsmPJOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KJYZi4iv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gjP3yqmq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KJYZi4iv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gjP3yqmq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 044E35C722;
	Wed, 12 Jun 2024 20:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718224669;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T/vlyiKle6/R/bjwbofjzmTH9P4Te7P9EczZ+8L5JGs=;
	b=KJYZi4ivpfi5dOMxqncto0Of7sov4yYIifXBlc3OnMh966R2M8Udv/xspFjjrSaCFnkICN
	RVOWo91f+25HNaur3a6tT6NUlzLmcUKeTAbxbiHEWxtMdwRcCXYEbrKZ7HJtgahtBWHvaQ
	8DyNO61uAbzkAfDaMAOJmzLD9Hvj4o4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718224669;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T/vlyiKle6/R/bjwbofjzmTH9P4Te7P9EczZ+8L5JGs=;
	b=gjP3yqmqBfXfXYGEVM1RqX61pzOFqCS5YSMlGhWQK8Mw0UMnDzDs1iPZJ/EsAFe+KOLW+k
	Qu4Nin3j6+T91kAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KJYZi4iv;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gjP3yqmq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718224669;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T/vlyiKle6/R/bjwbofjzmTH9P4Te7P9EczZ+8L5JGs=;
	b=KJYZi4ivpfi5dOMxqncto0Of7sov4yYIifXBlc3OnMh966R2M8Udv/xspFjjrSaCFnkICN
	RVOWo91f+25HNaur3a6tT6NUlzLmcUKeTAbxbiHEWxtMdwRcCXYEbrKZ7HJtgahtBWHvaQ
	8DyNO61uAbzkAfDaMAOJmzLD9Hvj4o4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718224669;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T/vlyiKle6/R/bjwbofjzmTH9P4Te7P9EczZ+8L5JGs=;
	b=gjP3yqmqBfXfXYGEVM1RqX61pzOFqCS5YSMlGhWQK8Mw0UMnDzDs1iPZJ/EsAFe+KOLW+k
	Qu4Nin3j6+T91kAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D03641372E;
	Wed, 12 Jun 2024 20:37:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HdigMhwHambrLQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 12 Jun 2024 20:37:48 +0000
Date: Wed, 12 Jun 2024 22:37:43 +0200
From: David Sterba <dsterba@suse.cz>
To: Srivathsa Dara <srivathsa.d.dara@oracle.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	Rajesh Sivaramasubramaniom <rajesh.sivaramasubramaniom@oracle.com>,
	Junxiao Bi <junxiao.bi@oracle.com>, "clm@fb.com" <clm@fb.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"dsterba@suse.com" <dsterba@suse.com>
Subject: Re: [PATCH v2] btrfs-progs: convert: Add 64 bit block numbers support
Message-ID: <20240612203743.GQ18508@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240606102215.3695032-1-srivathsa.d.dara@oracle.com>
 <c3060faf-f0e8-4bd2-865b-332e423a8801@gmx.com>
 <DM6PR10MB4347A0EADF68B973447C5591A0C72@DM6PR10MB4347.namprd10.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM6PR10MB4347A0EADF68B973447C5591A0C72@DM6PR10MB4347.namprd10.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 044E35C722
X-Spam-Score: -4.21
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmx.com,vger.kernel.org,oracle.com,fb.com,toxicpanda.com,suse.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Tue, Jun 11, 2024 at 06:03:30AM +0000, Srivathsa Dara wrote:
> > 在 2024/6/6 19:52, Srivathsa Dara 写道:
> > > In ext4, number of blocks can be greater than 2^32. Therefore, if 
> > > btrfs-convert is used on filesystems greater than 16TiB (Staring from 
> > > 16TiB, number of blocks overflow 32 bits), it fails to convert.
> > >
> > > Example:
> > >
> > > Here, /dev/sdc1 is 16TiB partition intitialized with an ext4 filesystem.
> > >
> > > [root@rasivara-arm2 opc]# btrfs-convert -d -p /dev/sdc1 btrfs-convert 
> > > from btrfs-progs v5.15.1
> > >
> > > convert/main.c:1164: do_convert: Assertion `cctx.total_bytes != 0` 
> > > failed, value 0 btrfs-convert(+0xfd04)[0xaaaaba44fd04]
> > > btrfs-convert(main+0x258)[0xaaaaba44d278]
> > > /lib64/libc.so.6(__libc_start_main+0xdc)[0xffffb962777c]
> > > btrfs-convert(+0xd4fc)[0xaaaaba44d4fc]
> > > Aborted (core dumped)
> > >
> > > Fix it by considering 64 bit block numbers.
> > >
> > > Signed-off-by: Srivathsa Dara <srivathsa.d.dara@oracle.com>
> > > ---
> > >   convert/source-ext2.c | 6 +++---
> > >   convert/source-ext2.h | 2 +-
> > >   2 files changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/convert/source-ext2.c b/convert/source-ext2.c index 
> > > 2186b252..afa48606 100644
> > > --- a/convert/source-ext2.c
> > > +++ b/convert/source-ext2.c
> > > @@ -288,8 +288,8 @@ error:
> > >   	return -1;
> > >   }
> > >
> > > -static int ext2_block_iterate_proc(ext2_filsys fs, blk_t *blocknr,
> > > -			        e2_blkcnt_t blockcnt, blk_t ref_block,
> > > +static int ext2_block_iterate_proc(ext2_filsys fs, blk64_t *blocknr,
> > > +			        e2_blkcnt_t blockcnt, blk64_t ref_block,
> > >   			        int ref_offset, void *priv_data)
> > >   {
> > >   	int ret;
> > > @@ -323,7 +323,7 @@ static int ext2_create_file_extents(struct btrfs_trans_handle *trans,
> > >   	init_blk_iterate_data(&data, trans, root, btrfs_inode, objectid,
> > >   			convert_flags & CONVERT_FLAG_DATACSUM);
> > >
> > > -	err = ext2fs_block_iterate2(ext2_fs, ext2_ino, BLOCK_FLAG_DATA_ONLY,
> > > +	err = ext2fs_block_iterate3(ext2_fs, ext2_ino, BLOCK_FLAG_DATA_ONLY,
> > >   				    NULL, ext2_block_iterate_proc, &data);
> > 
> > I'm wondering does ext2 really supports 64bit block number.
> 
> No, it doesn't.
> 
> > 
> > For ext* fs with extent support (3 and 4), we're no longer utilizing ext2fs_block_iterate2(), instead we go with iterate_file_extents() instead, and that function is already using blk64_t for both file offset and the block number.
> > 
> > I'm guessing the code base doesn't have the latest c23e068aaf91
> > ("btrfs-progs: convert: rework file extent iteration to handle unwritten
> > extents") commit yet?
> 
> I've used btrfs-progs-6.8.1, it doesn't have this commit.
> 
> > 
> > 
> > >   	if (err)
> > >   		goto error;
> > > diff --git a/convert/source-ext2.h b/convert/source-ext2.h index 
> > > d204aac5..62c9b1fa 100644
> > > --- a/convert/source-ext2.h
> > > +++ b/convert/source-ext2.h
> > > @@ -46,7 +46,7 @@ struct btrfs_trans_handle;
> > >   #define ext2fs_get_block_bitmap_range2 ext2fs_get_block_bitmap_range
> > >   #define ext2fs_inode_data_blocks2 ext2fs_inode_data_blocks
> > >   #define ext2fs_read_ext_attr2 ext2fs_read_ext_attr
> > > -#define ext2fs_blocks_count(s)		((s)->s_blocks_count)
> > > +#define ext2fs_blocks_count(s)		(((s)->s_blocks_count_hi << 32) | (s)->s_blocks_count)
> > 
> > This is definitely needed, or it would trigger the ASSERT().
> > 
> > But again, the newer btrfs-progs no longer go with internally defined ext2fs_blocks_count(), but using the one from e2fsprogs headers, and the library version is already returning blk64_t.
> 
> Okay, got it.
> 
> Tested the code base with the commit c23e068aaf91, it does handle 64 bit block numbers.

So, is this patch still needed? I'm not sure after Qu fixed the
iteration, the tests pass without the patch too.

