Return-Path: <linux-btrfs+bounces-1487-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDF982F48F
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 19:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A85BA1C239E1
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 18:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561371CFA7;
	Tue, 16 Jan 2024 18:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pNg7g5bC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RAiBODWH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pNg7g5bC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RAiBODWH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA161CF81
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jan 2024 18:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705430881; cv=none; b=PfY/AIQWyS1v1/0qkPdlSBkLKIEA3+goPCqM699te+xH4vziVOU1G8ep6N5Vw6G+1hfsOvhVJleXu3e1g2of/t9X0aCYGSi/DrYJOeQsB4W14+WU7KMm9Cf46hOrydtrx9jFCZuT3Bgz7X16T5Lb5orWv9bTKClZgE/IGFnOk7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705430881; c=relaxed/simple;
	bh=mHgSQgyRGHS+iDOecj1MQ/4mWsqGOybWPl/NRPQg7mM=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:Reply-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent:X-Spam-Level:
	 X-Spam-Score:X-Spamd-Result:X-Spam-Flag; b=NP51bf9Ur76C6pvUEAz4AuGnKUZKcSb5sjLWiKwQVxEYTrhs+BeG6trmx1xoKS3T6JSvcvR0jkcNTUSaPC82cIxQ248P1JmsbE4fey3M3PM3dKQ85Uuv9Ke/DdtRthXXCAxBBOOynub3Yl58/kBPeYZPwSQKwykz/K6FtOB5cbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pNg7g5bC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RAiBODWH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pNg7g5bC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RAiBODWH; arc=none smtp.client-ip=195.135.223.130
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B5450220B3;
	Tue, 16 Jan 2024 18:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705430876;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PVNTakAfSW44HQnT78r3QOsr8XR9AdVfFyvLvq83o/g=;
	b=pNg7g5bCiOmzYS/e9Ss9Kp/2YvX+NEES8MlaCRfYoMJcblgAtCS2MyWKKFtmBVVLNiZNB9
	pr6m/UYAXMaZhWAIOhX4D+DSywAN/wHTYBW7vpnCX63R/3Qpn4Ds5wuPLPxcGX3Jo7syIC
	EHDaUrykPgONmUMZLYF98ndpr2zFIFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705430876;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PVNTakAfSW44HQnT78r3QOsr8XR9AdVfFyvLvq83o/g=;
	b=RAiBODWHYJ2KVLnYGReoJDWKieCJLoJDbTXtX0zMdg4H+gpMJXiGJ962veB4d+xWzFaqz0
	5i+Z0A0M5MD48rAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705430876;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PVNTakAfSW44HQnT78r3QOsr8XR9AdVfFyvLvq83o/g=;
	b=pNg7g5bCiOmzYS/e9Ss9Kp/2YvX+NEES8MlaCRfYoMJcblgAtCS2MyWKKFtmBVVLNiZNB9
	pr6m/UYAXMaZhWAIOhX4D+DSywAN/wHTYBW7vpnCX63R/3Qpn4Ds5wuPLPxcGX3Jo7syIC
	EHDaUrykPgONmUMZLYF98ndpr2zFIFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705430876;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PVNTakAfSW44HQnT78r3QOsr8XR9AdVfFyvLvq83o/g=;
	b=RAiBODWHYJ2KVLnYGReoJDWKieCJLoJDbTXtX0zMdg4H+gpMJXiGJ962veB4d+xWzFaqz0
	5i+Z0A0M5MD48rAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D2EC133CF;
	Tue, 16 Jan 2024 18:47:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ybClIVzPpmV9OwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 16 Jan 2024 18:47:56 +0000
Date: Tue, 16 Jan 2024 19:47:38 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs-progs: convert-ext2: insert a dummy inode item
 before inode ref
Message-ID: <20240116184738.GE31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <6e1e07ad53a9e716be28e4d505042a50c1676254.1705134953.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e1e07ad53a9e716be28e4d505042a50c1676254.1705134953.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.92
X-Spamd-Result: default: False [-3.92 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.12)[-0.587];
	 RCPT_COUNT_TWO(0.00)[2];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Sat, Jan 13, 2024 at 07:07:06PM +1030, Qu Wenruo wrote:
> [BUG]
> There is a report about failed btrfs-convert, which shows the following
> error:
> 
>   Create btrfs metadata
>   corrupt leaf: root=5 block=5001931145216 slot=1 ino=89911763, invalid previous key objectid, have 89911762 expect 89911763
>   leaf 5001931145216 items 336 free space 7 generation 90 owner FS_TREE
>   leaf 5001931145216 flags 0x1(WRITTEN) backref revision 1
>   fs uuid 8b69f018-37c3-4b30-b859-42ccfcbe2449
>   chunk uuid 448ce78c-ea41-49f6-99dc-46ad80b93da9
>           item 0 key (89911762 INODE_REF 3858733) itemoff 16222 itemsize 61
>                   index 171 namelen 51 name: [FILENAME1]
>           item 1 key (89911763 INODE_REF 3858733) itemoff 16161 itemsize 61
>                   index 103 namelen 51 name: [FILENAME2]
> 
> [CAUSE]
> When iterating a directory, btrfs-convert would insert the DIR_ITEMs,
> along with the INODE_REF of that inode.
> 
> This leads to above stray INODE_REFs, and trigger the tree-checker.
> 
> This can only happen for large fs, as for most cases we have all these
> modified tree blocks cached, thus tree-checker won't be triggered.
> But when the tree block cache is not hit, and we have to read from disk,
> then such behavior can lead to above tree-checker error.
> 
> [FIX]
> Insert a dummy INODE_ITEM for the INODE_REF first, the inode items would
> be updated when iterating the child inode of the directory.
> 
> Issue: #731
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Thanks, the cached data are uncovering some bugs, I wonder if
https://github.com/kdave/btrfs-progs/issues/349 could be also caused by
that.

> ---
>  check/mode-common.h   | 15 ---------------
>  common/utils.h        | 16 ++++++++++++++++
>  convert/source-ext2.c | 30 ++++++++++++++++++++----------
>  convert/source-fs.c   | 20 ++++++++++++++++++++
>  4 files changed, 56 insertions(+), 25 deletions(-)
> 
> ---
> Changelog:
> v2:
> - Initialized dummy inodes' mode/generation/transid
>   As the mode can still trigger tree-checker warnings.
> 
> diff --git a/check/mode-common.h b/check/mode-common.h
> index 894bbbb8141b..80672e51e870 100644
> --- a/check/mode-common.h
> +++ b/check/mode-common.h
> @@ -167,21 +167,6 @@ static inline bool is_valid_imode(u32 imode)
> 
>  int recow_extent_buffer(struct btrfs_root *root, struct extent_buffer *eb);
> 
> -static inline u32 btrfs_type_to_imode(u8 type)
> -{
> -	static u32 imode_by_btrfs_type[] = {
> -		[BTRFS_FT_REG_FILE]	= S_IFREG,
> -		[BTRFS_FT_DIR]		= S_IFDIR,
> -		[BTRFS_FT_CHRDEV]	= S_IFCHR,
> -		[BTRFS_FT_BLKDEV]	= S_IFBLK,
> -		[BTRFS_FT_FIFO]		= S_IFIFO,
> -		[BTRFS_FT_SOCK]		= S_IFSOCK,
> -		[BTRFS_FT_SYMLINK]	= S_IFLNK,
> -	};
> -
> -	return imode_by_btrfs_type[(type)];
> -}

Why did you move this helper to utils.h? Here it's available for
anything that needs it. Mkfs and convert share some code, no style
problem to cross include from each other. Also moving it to utils.h is
going the opposite way, it's a header that's a default if there's no
better place. Lot of code has been factored out of it.

