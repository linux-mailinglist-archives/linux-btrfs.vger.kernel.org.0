Return-Path: <linux-btrfs+bounces-11773-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65040A4402C
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 14:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0116017D04A
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 13:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDCA268FD9;
	Tue, 25 Feb 2025 13:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vJEEEH75";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="N2UD3wV6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HJBkBnfj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lg0SGv1I"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC8C263C72
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 13:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740488753; cv=none; b=Wuy5gyczlfEXyp6+hTsPwUepzwUPQjam5WShAGGFpFQ02mDn3KpyAm5r5gCMHpppxPuGNq0IX6mzM8JeQa/9FrWt4zNZwlBHBbE6nfBaQd7oteqThmSRi3EPXSLNHyOYBSEDqOFbnYDoQa/+3QbEGutnIhjEJaKi/6Jae2RrAV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740488753; c=relaxed/simple;
	bh=nNRENbj47C757eI3O+j4rEdLJnqu4mGPOzg6f2Wzopg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFbU4DlbAo0EeEFuBytNdD02qOqxaTRzSV5DBebBF8Z573OkFH0SDHlGGIju9YmPRgTWgFMJ3d4C6Y+5dD0R8aETY3uk01Ml+r/CmXNyi4IxLSFSBPvYTZQLNKTkp8p954lCa83+qPygW3WM9dGzZa4gR3OlQSzH86tXYkxhFNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vJEEEH75; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=N2UD3wV6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HJBkBnfj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Lg0SGv1I; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E78D01F44F;
	Tue, 25 Feb 2025 13:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740488749;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CD6/222OVOMHEoojKGtkH/gO4xIODvHYzzG3OLS6xUg=;
	b=vJEEEH75Ow4zpsarDToy0RNicVUQc6zI72MaU4UVCPk4WzxYkg2Ur7L9tIAZ2GQGOxvJ+0
	TtDEiPD2D9OanH5c9moD3CuVK53xmUacuD5SeGDdGU1lFtJOeoLvtE8Xyiqs31aeGeGHme
	DHvnQ6w5FAjeOLzNOZ0NZFDvEYk1v/A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740488749;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CD6/222OVOMHEoojKGtkH/gO4xIODvHYzzG3OLS6xUg=;
	b=N2UD3wV6jIACVKgj20uUBRiG6KzIOwGUrwnr3gD1/44V2fy9RaJkFn4CYFd9+49Nqdftkp
	6MQpo5quJMKr3GAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=HJBkBnfj;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Lg0SGv1I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740488746;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CD6/222OVOMHEoojKGtkH/gO4xIODvHYzzG3OLS6xUg=;
	b=HJBkBnfjblV+0dkpwqEBgNThF4rAfJp37FyBjm+iQ9Y4yo87ejt7rbj4XSAvsO6rNOVYzC
	XJjDv0unaH+xOvdJFNT/j2yVdtMofNAUgRXGi6qfmrnfGhPBnabXybqwWTkrMpOCYjDmGV
	vyHl7e3iKZgWJg/ekZGb6DKlDF23Nk0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740488746;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CD6/222OVOMHEoojKGtkH/gO4xIODvHYzzG3OLS6xUg=;
	b=Lg0SGv1IwCQ3JOJtWWWlcMnAGiqP4Ubf+xrpDrbWqjZtNMr+0xMUCgyxTRkyzOklwEH0/h
	2Ujdxnv9bb5ViDBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BFE8413332;
	Tue, 25 Feb 2025 13:05:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rLCaLirAvWcdXAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 25 Feb 2025 13:05:46 +0000
Date: Tue, 25 Feb 2025 14:05:41 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 3/3] btrfs: allow buffered write to avoid full page
 read if it's block aligned
Message-ID: <20250225130541.GQ5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1739328504.git.wqu@suse.com>
 <4516745df779bcccc39e9ca357575c20fa70c927.1739328504.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4516745df779bcccc39e9ca357575c20fa70c927.1739328504.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: E78D01F44F
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
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,twin.jikos.cz:mid,suse.cz:dkim,suse.cz:replyto]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Wed, Feb 12, 2025 at 01:22:47PM +1030, Qu Wenruo wrote:
> [BUG]
> Since the support of block size (sector size) < page size for btrfs,
> test case generic/563 fails with 4K block size and 64K page size:
> 
>     --- tests/generic/563.out	2024-04-25 18:13:45.178550333 +0930
>     +++ /home/adam/xfstests-dev/results//generic/563.out.bad	2024-09-30 09:09:16.155312379 +0930
>     @@ -3,7 +3,8 @@
>      read is in range
>      write is in range
>      write -> read/write
>     -read is in range
>     +read has value of 8388608
>     +read is NOT in range -33792 .. 33792
>      write is in range
>     ...
> 
> [CAUSE]
> The test case creates a 8MiB file, then buffered write into the 8MiB
> using 4K block size, to overwrite the whole file.
> 
> On 4K page sized systems, since the write range covers the full block and
> page, btrfs will no bother reading the page, just like what XFS and EXT4
> do.
> 
> But 64K page sized systems, although the 4K sized write is still block
> aligned, it's not page aligned any more, thus btrfs will read the full
> page, causing more read than expected and fail the test case.
> 
> [FIX]
> To skip the full page read, we need to do the following modification:
> 
> - Do not trigger full page read as long as the buffered write is block
>   aligned
>   This is pretty simple by modifying the check inside
>   prepare_uptodate_page().
> 
> - Skip already uptodate blocks during full page read
>   Or we can lead to the following data corruption:
> 
>   0       32K        64K
>   |///////|          |
> 
>   Where the file range [0, 32K) is dirtied by buffered write, the
>   remaining range [32K, 64K) is not.
> 
>   When reading the full page, since [0,32K) is only dirtied but not
>   written back, there is no data extent map for it, but a hole covering
>   [0, 64k).
> 
>   If we continue reading the full page range [0, 64K), the dirtied range
>   will be filled with 0 (since there is only a hole covering the whole
>   range).
>   This causes the dirtied range to get lost.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c | 4 ++++
>  fs/btrfs/file.c      | 5 +++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 64812045a42d..abf43805ea92 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -971,6 +971,10 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
>  			end_folio_read(folio, true, cur, end - cur + 1);
>  			break;
>  		}
> +		if (btrfs_folio_test_uptodate(fs_info, folio, cur, blocksize)) {
> +			end_folio_read(folio, true, cur, blocksize);
> +			continue;
> +		}
>  		em = get_extent_map(BTRFS_I(inode), folio, cur, end - cur + 1, em_cached);
>  		if (IS_ERR(em)) {
>  			end_folio_read(folio, false, cur, end + 1 - cur);
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 81e6cb599585..83a7238e8c2e 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -804,14 +804,15 @@ static int prepare_uptodate_folio(struct inode *inode, struct folio *folio, u64
>  {
>  	u64 clamp_start = max_t(u64, pos, folio_pos(folio));
>  	u64 clamp_end = min_t(u64, pos + len, folio_pos(folio) + folio_size(folio));
> +	const u32 sectorsize = inode_to_fs_info(inode)->sectorsize;

In such cases you can name the local variables blocksize, this is the
least intrusive way to convert it from the sectorsize.

>  	int ret = 0;
>  
>  	if (folio_test_uptodate(folio))
>  		return 0;
>  
>  	if (!force_uptodate &&
> -	    IS_ALIGNED(clamp_start, PAGE_SIZE) &&
> -	    IS_ALIGNED(clamp_end, PAGE_SIZE))
> +	    IS_ALIGNED(clamp_start, sectorsize) &&
> +	    IS_ALIGNED(clamp_end, sectorsize))
>  		return 0;
>  
>  	ret = btrfs_read_folio(NULL, folio);
> -- 
> 2.48.1
> 

