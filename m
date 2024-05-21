Return-Path: <linux-btrfs+bounces-5165-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A198CB107
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 17:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CD2CB23FE4
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 15:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126C3143C58;
	Tue, 21 May 2024 15:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PABfA6tW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0iI4BkNt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PABfA6tW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0iI4BkNt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BCE143C50
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 15:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716304259; cv=none; b=hOSAx0tnVUKQwQ9v0JNTCFXrBbr4JWlOO+3dhJHNaGZrd79DMyjzqXmJsRhU8CdQ+67R+wxvBgXLGmXZEJD54nfzubcBggmxsWukax/5pziM4BK1TjSvizAsbZRMguL0oC6Z/A0YKigPFy3oXp07rud5aA7R89b9fCYDjVHJyCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716304259; c=relaxed/simple;
	bh=QuqPjhSJWY+a81khK8mzW6T7w1+gLVanXKgys63c6Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9D+w9Fs964dH+oIfcBVEd2CefxeV0pNT83fl9sTDKb2RcZuNJrPekbsFbO5/o9D+u9q/jqYQMyV8v3rFm9gW8asErQ9UzxWvYBSbFAkfguFP7mhALfQfm+D6eF8A84WLyM8c7B+yfUYzaDS4nBZidt8Rlgx6RtCndONt9GoKts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PABfA6tW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0iI4BkNt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PABfA6tW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0iI4BkNt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6BCCD3480F;
	Tue, 21 May 2024 15:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716304255;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t+AL7MFKXfognGFeVW91oJ7f/7vP1tBOjMCpYNvtiLQ=;
	b=PABfA6tW9cD1wd3oHifFDYxiYT0ynD6yG2fJEwiFl64ZtdbYTHOsxHr6FS6uQjfxr8VbH2
	1qIbgx4E+shLsxMj5xzrDeJlqZ/JANHD7dKM/fxHWeWOq7Hi5+GLUyanHmXjrm8aD4FQNd
	MJNvuCwu6vvEGDlyrTdzY3Ddf+0096s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716304255;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t+AL7MFKXfognGFeVW91oJ7f/7vP1tBOjMCpYNvtiLQ=;
	b=0iI4BkNttMeXUKUeFmPBk40mJ0mJPIHRBbT88hbZYGCB3dTrkoWUDDoxOANMw9lM4VbUw/
	QjwEhhN/KMZciwDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716304255;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t+AL7MFKXfognGFeVW91oJ7f/7vP1tBOjMCpYNvtiLQ=;
	b=PABfA6tW9cD1wd3oHifFDYxiYT0ynD6yG2fJEwiFl64ZtdbYTHOsxHr6FS6uQjfxr8VbH2
	1qIbgx4E+shLsxMj5xzrDeJlqZ/JANHD7dKM/fxHWeWOq7Hi5+GLUyanHmXjrm8aD4FQNd
	MJNvuCwu6vvEGDlyrTdzY3Ddf+0096s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716304255;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t+AL7MFKXfognGFeVW91oJ7f/7vP1tBOjMCpYNvtiLQ=;
	b=0iI4BkNttMeXUKUeFmPBk40mJ0mJPIHRBbT88hbZYGCB3dTrkoWUDDoxOANMw9lM4VbUw/
	QjwEhhN/KMZciwDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52F4A13685;
	Tue, 21 May 2024 15:10:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hk8OFH+5TGabPAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 21 May 2024 15:10:55 +0000
Date: Tue, 21 May 2024 17:10:50 +0200
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 1/6] btrfs: btrfs_cleanup_fs_roots handle ret variable
Message-ID: <20240521151050.GO17126@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1715783315.git.anand.jain@oracle.com>
 <2a831fc01d65612914702b968174945f2f7e1c79.1715783315.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a831fc01d65612914702b968174945f2f7e1c79.1715783315.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]

On Thu, May 16, 2024 at 07:12:10PM +0800, Anand Jain wrote:
> Since err represents the function return value, rename it as ret,
> and rename the original ret, which serves as a helper return value,
> to found. Also, optimize the code to continue call btrfs_put_root()
> for the rest of the root if even after btrfs_orphan_cleanup() returns
> error.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v3: Add a code comment.
> v2: Rename to 'found' instead of 'ret2' (Josef).
>     Call btrfs_put_root() in the while-loop, avoids use of the variable
> 	'found' outside of the while loop (Qu).
>     Use 'unsigned int i' instead of 'int' (Goffredo).
> 
>  fs/btrfs/disk-io.c | 38 ++++++++++++++++++++------------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index a91a8056758a..d38cf973b02a 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2925,22 +2925,23 @@ static int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info)
>  {
>  	u64 root_objectid = 0;
>  	struct btrfs_root *gang[8];
> -	int i = 0;
> -	int err = 0;
> -	unsigned int ret = 0;
> +	int ret = 0;
>  
>  	while (1) {
> +		unsigned int i;
> +		unsigned int found;
> +
>  		spin_lock(&fs_info->fs_roots_radix_lock);
> -		ret = radix_tree_gang_lookup(&fs_info->fs_roots_radix,
> +		found = radix_tree_gang_lookup(&fs_info->fs_roots_radix,
>  					     (void **)gang, root_objectid,
>  					     ARRAY_SIZE(gang));
> -		if (!ret) {
> +		if (!found) {
>  			spin_unlock(&fs_info->fs_roots_radix_lock);
>  			break;
>  		}
> -		root_objectid = btrfs_root_id(gang[ret - 1]) + 1;
> +		root_objectid = btrfs_root_id(gang[found - 1]) + 1;
>  
> -		for (i = 0; i < ret; i++) {
> +		for (i = 0; i < found; i++) {

You could also move the declaration of 'i' to the for loop as you move
the other definition anyway.

>  			/* Avoid to grab roots in dead_roots. */
>  			if (btrfs_root_refs(&gang[i]->root_item) == 0) {
>  				gang[i] = NULL;
> @@ -2951,24 +2952,25 @@ static int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info)
>  		}
>  		spin_unlock(&fs_info->fs_roots_radix_lock);
>  
> -		for (i = 0; i < ret; i++) {
> +		for (i = 0; i < found; i++) {
>  			if (!gang[i])
>  				continue;
>  			root_objectid = btrfs_root_id(gang[i]);
> -			err = btrfs_orphan_cleanup(gang[i]);
> -			if (err)
> -				goto out;
> +			/*
> +			 * Continue to release the remaining roots after the first
> +			 * error without cleanup and preserve the first error
> +			 * for the return.
> +			 */
> +			if (!ret)
> +				ret = btrfs_orphan_cleanup(gang[i]);
>  			btrfs_put_root(gang[i]);
>  		}
> +		if (ret)
> +			break;
> +
>  		root_objectid++;
>  	}
> -out:
> -	/* Release the uncleaned roots due to error. */
> -	for (; i < ret; i++) {
> -		if (gang[i])
> -			btrfs_put_root(gang[i]);
> -	}
> -	return err;
> +	return ret;
>  }
>  
>  /*
> -- 
> 2.38.1
> 

