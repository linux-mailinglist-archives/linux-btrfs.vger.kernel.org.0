Return-Path: <linux-btrfs+bounces-4723-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C1E8BABF4
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 13:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5FF8280DCD
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 11:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63ED1152DF7;
	Fri,  3 May 2024 11:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xojJtg2U";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qx4ttNnv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="q7zMaWDY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sQE1lSeQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03074152179
	for <linux-btrfs@vger.kernel.org>; Fri,  3 May 2024 11:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714737419; cv=none; b=AgRsu4QtJFExO4/53JPDAvW785fd5Ho5HP23ryJOQM7Zy+ujmeYvK6Y6y89jCmCP6NzwXwtm1Gz6ObuaWfRSpU2cYpOXhNr5oHWZxY7WFcoYNqABOWuQ/oSX8N3CI27DZ+b6L+M4gcmy9kMKa3QCxE4v25HdnzFOCd7k3Bx+d3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714737419; c=relaxed/simple;
	bh=KIXtb2y29fy68rQP3AUczOlchLhSLhl+RseR2S/6Wl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTm5CVK8TPQyR0WPhcU1c9QwOxRVCuX2fGnNXDPYJuUd9ObWxgf+ULjffqdM1f3wcar0Ty4a8muxqXtPjJ8eOywbuBF74g+4/DIj9mDxngsDbwIKir1BV3LCqMSfX3g8/PsoFk2/4tjXpFcQ3AAsNKLfJHB38ohpNkTHkxh6EaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xojJtg2U; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qx4ttNnv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=q7zMaWDY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sQE1lSeQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CC14E338EC;
	Fri,  3 May 2024 11:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714737415;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x6NTsAhvO/QV2QjrQ7qE5IKwNOA6UtVRnuKDMA6Vozg=;
	b=xojJtg2UHbNICFesiYyaE5AFwys0/VtaQsUW/P1i7w6Sw76SOg7fcb5uJ9lGrXkz7V+DTG
	yjMAC37dA5qvbGnZhwqWOnil/eX7gsl58Heh0zOdoqSon9DMiGRwLbVuPQhVE16ImvkgW1
	wVzmUup9n4wbLL43KNblaUU0ZSRsPMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714737415;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x6NTsAhvO/QV2QjrQ7qE5IKwNOA6UtVRnuKDMA6Vozg=;
	b=qx4ttNnvpFfWKCkjzXsigFvLzoj8pORReoJVFyBF7Dm8KBhWNPnS5JRO1caeu+slQ+bGvV
	IPqISAUWFPHZ+SCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=q7zMaWDY;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=sQE1lSeQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714737414;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x6NTsAhvO/QV2QjrQ7qE5IKwNOA6UtVRnuKDMA6Vozg=;
	b=q7zMaWDYyqcPULhrSP1QxErFfGyDBwWDbMxPr474W8EpbRE8N1padnDyXEL376/VfiGJO+
	FVYtvQ41NO1XaV3SvLR3rF8kCuIFmhxgjZDUuBfr3xvXDNR93nL9AnOX2Ah5iZyOPEb+rr
	vyy7s6awZhK+7x8kF+WpqVxBdqAs9AI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714737414;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x6NTsAhvO/QV2QjrQ7qE5IKwNOA6UtVRnuKDMA6Vozg=;
	b=sQE1lSeQ+FFzf9Ks57tLWnvJ8qyyGu7xV7/ahiweiHRZf9cCyIUmhdPCjmALI4qo/i8Bpa
	2RW3B0PB0M5LPdCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B7F8E139CB;
	Fri,  3 May 2024 11:56:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tee3LAbRNGYdYwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 03 May 2024 11:56:54 +0000
Date: Fri, 3 May 2024 13:49:30 +0200
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/4] btrfs-progs: convert: struct blk_iterate_data, add
 ext2-specific file inode pointers
Message-ID: <20240503114930.GW2585@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1714722726.git.anand.jain@oracle.com>
 <df071a4eaaf83d9474449f281ba8b1f905922744.1714722726.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df071a4eaaf83d9474449f281ba8b1f905922744.1714722726.git.anand.jain@oracle.com>
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
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: CC14E338EC
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.21

On Fri, May 03, 2024 at 05:08:53PM +0800, Anand Jain wrote:
> To obtain the file data extent flags, we require the use of ext2 helper
> functions, pass these pointer in the 'struct blk_iterate_data'. However,
> this struct is a common function across both 'reiserfs' and 'ext4'
> filesystems. Since there is no further development on 'convert-reiserfs',
> this patch avoids creating a mess which won't be used.

Even though there will be no more reiserfs development you should not
clutter the generic API for filesystems with ext2-specific members.

> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  convert/source-ext2.c | 4 ++++
>  convert/source-fs.h   | 5 +++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/convert/source-ext2.c b/convert/source-ext2.c
> index a3f61bb01171..625387e95857 100644
> --- a/convert/source-ext2.c
> +++ b/convert/source-ext2.c
> @@ -324,6 +324,10 @@ static int ext2_create_file_extents(struct btrfs_trans_handle *trans,
>  	init_blk_iterate_data(&data, trans, root, btrfs_inode, objectid,
>  			convert_flags & CONVERT_FLAG_DATACSUM);
>  
> +	data.ext2_fs = ext2_fs;
> +	data.ext2_ino = ext2_ino;
> +	data.ext2_inode = ext2_inode;
> +
>  	err = ext2fs_block_iterate2(ext2_fs, ext2_ino, BLOCK_FLAG_DATA_ONLY,
>  				    NULL, ext2_block_iterate_proc, &data);
>  	if (err)
> diff --git a/convert/source-fs.h b/convert/source-fs.h
> index b26e1842941d..0e71e79eddcc 100644
> --- a/convert/source-fs.h
> +++ b/convert/source-fs.h
> @@ -20,6 +20,7 @@
>  #include "kerncompat.h"
>  #include <sys/types.h>
>  #include <pthread.h>
> +#include <ext2fs/ext2fs.h>
>  #include "kernel-shared/uapi/btrfs_tree.h"
>  #include "convert/common.h"
>  
> @@ -118,6 +119,10 @@ struct btrfs_convert_operations {
>  };
>  
>  struct blk_iterate_data {
> +	ext2_filsys ext2_fs;
> +	struct ext2_inode *ext2_inode;
> +	ext2_ino_t ext2_ino;

This should be a void pointer filled by the target filesystem
implementation that fills it with anything it needs.

> +
>  	struct btrfs_trans_handle *trans;
>  	struct btrfs_root *root;
>  	struct btrfs_root *convert_root;
> -- 
> 2.39.3
> 

