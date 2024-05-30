Return-Path: <linux-btrfs+bounces-5368-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE988D5107
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 May 2024 19:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15C24285A38
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 May 2024 17:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41124643A;
	Thu, 30 May 2024 17:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iqC3nJ3p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ExbgnvMw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="deqFkYNz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fYCCeusQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25648433C2
	for <linux-btrfs@vger.kernel.org>; Thu, 30 May 2024 17:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717090162; cv=none; b=rYRlJ1p3wEzIQqSc9wObON330ngqt0ZdpTvyls5ZYCM3qMryH6qAUyBDFOkURLjUmERtCLeDZlxTUyODnOdVymzwjqYI80TtgALyhAcuQ9mA/rkDCrw4w8ZXaIBbyTxzcGhG4D6mLFodyUlOiaPnz7iuxOI3ietKIz3fuHbPBhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717090162; c=relaxed/simple;
	bh=YSHjAv+PzoboeeCLmtFpWapLp+ULAQ9MTHqrT++OgpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SroIx9lc2lv+bXpgqV9I/VKcHXEZV1wFM6ov4+CkJ60RGrllth3SR6qeFUNujrRyzyp3pQpKIyLEQ0kT6t/s+U4NmqmwjiMSUefxhOvsUCuHutfIOevNtXH9z3SU7q8MAMOLr1grCspCRVuSA1VnkubVN+g3mhw/pqS2S8h46n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iqC3nJ3p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ExbgnvMw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=deqFkYNz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fYCCeusQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2C2EF21265;
	Thu, 30 May 2024 17:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717090159;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/TAbU/GXKMFQWaMMkpnnZZrhbkZhl09GDBi0OOl1ls=;
	b=iqC3nJ3p/esDub06WWV8/ZKdoDkX6miQcl1NBFLRZGqJHgx1iLzRAyo8UuKll970Yd2M94
	P9lFYmq0xYhH3KzXesn1XLVWVRzeVhMt6EEvOobUJ33GF7isHs5yL6HZVZzPmIrkOQck9p
	ascidRQu1PmTBuLyvst7yQzWNXB4PAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717090159;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/TAbU/GXKMFQWaMMkpnnZZrhbkZhl09GDBi0OOl1ls=;
	b=ExbgnvMwJX+dWQQ/xV3vPiWG2Teb3EpV2HQlfEEplPnn936j2CMjgryphnkfYsHnc3WifE
	z3NrMsHuB/lrcFAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=deqFkYNz;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=fYCCeusQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717090158;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/TAbU/GXKMFQWaMMkpnnZZrhbkZhl09GDBi0OOl1ls=;
	b=deqFkYNz1QXMqYM7cuOW4FnEK+0yEvwC7vx036oaIddWUVmLICtBPDb1CDPKhPgCrAJKv1
	WotjCifqpbbPRDLNQzi3eNPg78Yn/mnBe3GpX4Je4qV6E97NR+wgCszTnLbuvlr6Xkl/ZA
	rwlfB7/1TZAyDJat0N2TiCEwZw0sJdc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717090158;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/TAbU/GXKMFQWaMMkpnnZZrhbkZhl09GDBi0OOl1ls=;
	b=fYCCeusQrZpgrwKG9fxwxFAlYUfTEHTC02U0ZiywSnXq45NNrwtxWAcFJ0SuT7pPGOBJJj
	me/mTRvWnHbsWlDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0879E13A42;
	Thu, 30 May 2024 17:29:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l7PQAW63WGYJHQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 30 May 2024 17:29:18 +0000
Date: Thu, 30 May 2024 19:29:16 +0200
From: David Sterba <dsterba@suse.cz>
To: Srivathsa Dara <srivathsa.d.dara@oracle.com>
Cc: linux-btrfs@vger.kernel.org, rajesh.sivaramasubramaniom@oracle.com,
	junxiao.bi@oracle.com, clm@fb.com, josef@toxicpanda.com,
	dsterba@suse.com
Subject: Re: [RESEND PATCH] btrfs-progs: convert: Add 64 bit block numbers
 support
Message-ID: <20240530172916.GB25460@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240530053754.4115449-1-srivathsa.d.dara@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530053754.4115449-1-srivathsa.d.dara@oracle.com>
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
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,oracle.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 2C2EF21265
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.21

On Thu, May 30, 2024 at 05:37:54AM +0000, Srivathsa Dara wrote:
> In ext4, number of blocks can be greater than 2^32. Therefore, if
> btrfs-convert is used on filesystems greater than or equal to 16TiB
> (Staring from 16TiB, number of blocks overflow 32 bits), it fails to
> convert.
> 
> Example:
> 
> Here, /dev/sdc1 is 16TiB partition intitialized with an ext4 filesystem.
> 
> [root@rasivara-arm2 opc]# btrfs-convert -d -p /dev/sdc1
> btrfs-convert from btrfs-progs v5.15.1
> 
> convert/main.c:1164: do_convert: Assertion `cctx.total_bytes != 0` failed, value 0
> btrfs-convert(+0xfd04)[0xaaaaba44fd04]
> btrfs-convert(main+0x258)[0xaaaaba44d278]
> /lib64/libc.so.6(__libc_start_main+0xdc)[0xffffb962777c]
> btrfs-convert(+0xd4fc)[0xaaaaba44d4fc]
> Aborted (core dumped)
> 
> Fix it by considering 64 bit block numbers.
> 
> Signed-off-by: Srivathsa Dara <srivathsa.d.dara@oracle.com>
> ---
>  convert/source-ext2.c | 6 +++---
>  convert/source-ext2.h | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/convert/source-ext2.c b/convert/source-ext2.c
> index 2186b252..afa48606 100644
> --- a/convert/source-ext2.c
> +++ b/convert/source-ext2.c
> @@ -288,8 +288,8 @@ error:
>  	return -1;
>  }
>  
> -static int ext2_block_iterate_proc(ext2_filsys fs, blk_t *blocknr,
> -			        e2_blkcnt_t blockcnt, blk_t ref_block,
> +static int ext2_block_iterate_proc(ext2_filsys fs, blk64_t *blocknr,
> +			        e2_blkcnt_t blockcnt, blk64_t ref_block,
>  			        int ref_offset, void *priv_data)
>  {
>  	int ret;
> @@ -323,7 +323,7 @@ static int ext2_create_file_extents(struct btrfs_trans_handle *trans,
>  	init_blk_iterate_data(&data, trans, root, btrfs_inode, objectid,
>  			convert_flags & CONVERT_FLAG_DATACSUM);
>  
> -	err = ext2fs_block_iterate2(ext2_fs, ext2_ino, BLOCK_FLAG_DATA_ONLY,
> +	err = ext2fs_block_iterate3(ext2_fs, ext2_ino, BLOCK_FLAG_DATA_ONLY,
>  				    NULL, ext2_block_iterate_proc, &data);
>  	if (err)
>  		goto error;
> diff --git a/convert/source-ext2.h b/convert/source-ext2.h
> index d204aac5..73c39e23 100644
> --- a/convert/source-ext2.h
> +++ b/convert/source-ext2.h
> @@ -46,7 +46,7 @@ struct btrfs_trans_handle;
>  #define ext2fs_get_block_bitmap_range2 ext2fs_get_block_bitmap_range
>  #define ext2fs_inode_data_blocks2 ext2fs_inode_data_blocks
>  #define ext2fs_read_ext_attr2 ext2fs_read_ext_attr
> -#define ext2fs_blocks_count(s)		((s)->s_blocks_count)
> +#define ext2fs_blocks_count(s)		((s)->s_blocks_count_hi << 32) | (s)->s_blocks_count

Looks like there's missing closing )

