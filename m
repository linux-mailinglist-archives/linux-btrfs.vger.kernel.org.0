Return-Path: <linux-btrfs+bounces-4433-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9908AB3FF
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 18:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88479B21206
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 16:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F563137C37;
	Fri, 19 Apr 2024 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WWxAvuPy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8fOnIAPm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2TdZtICM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1Rzlq3XW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15FE12FB23
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 16:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545941; cv=none; b=e25tB/5XkHHfrakgFj7XiN3eDuNvGt0maluLExzGQ3BcGDKm2LnswppizdIPhK/3SCij2DAYmp4bETDgGSTRSJZGUucic2jWpKMSZLc5WFYbaGjDhi7UWVOtkhf96tNqvjBALlLnMjOPq0CszOe7Gjo6w/BbXQ8uRyzl1yRuWZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545941; c=relaxed/simple;
	bh=ov2y3xiABpM3cdqUNbkcQN+oZz9WyFEyngBnoMQRpPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EjA88jloZ1znFK0U8Cb6DQmR137eDFMCP/GPjMGw+om8wf44xmfpi2Hik+XhPIHIb4SXG1NXQF1Mu0ZFY9Rtfaxt4pMSpcz2lqxicSo0Wft2J3kRthcNr8sg1v4mUGu3ALoL5gV/YeV6+07aO5prQphFnMgHSWCRZkDeyiGix1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WWxAvuPy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8fOnIAPm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2TdZtICM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1Rzlq3XW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 910585D8F8;
	Fri, 19 Apr 2024 16:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713545937;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yhQMsxHgHXqC4FuP4fj6kOHASer4NutUEfMp3gwCqnI=;
	b=WWxAvuPye2mjD9Io9a/qc1tf59UM7OviDFFOoDxZYTHOWBDVc/HNmxA+xXvPcQ3dQxl0w1
	QbcJ5Tq0crXD9Qt/n8PaeeHnspWM0D6W0Epz0ugNM9EJGcARJjuIoRnqGIsiogwj1gTwm2
	FPWD2Q5MB3fVz+E3J3mmoGoyj4q3zWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713545937;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yhQMsxHgHXqC4FuP4fj6kOHASer4NutUEfMp3gwCqnI=;
	b=8fOnIAPmEmNzdC1fqyRRVcKR/cRvo28FOJa1Q/w0fzGA61ANbK2BiIMBoxTV8X0BZ7HIt0
	foO+zY5suCRPhvCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2TdZtICM;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1Rzlq3XW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713545936;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yhQMsxHgHXqC4FuP4fj6kOHASer4NutUEfMp3gwCqnI=;
	b=2TdZtICM87osnjl1fLpt9/3ywJo8rl63YnxnxmVGTdx+1Yjn/vEJTzx4p7+EUDYkhSvMAD
	fB5g/uzSZ3qI4/UBVB56inQVFLchayxdN+SB+SZTSBc+cj6UgRzFTDkFvxTaU8HQ0HXbtA
	0U56tSNWN2dvEeUuUynHa1RSHIh0UcM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713545936;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yhQMsxHgHXqC4FuP4fj6kOHASer4NutUEfMp3gwCqnI=;
	b=1Rzlq3XWYvCukwUD/GBd/NvEyaeCCJWAW2VXpuvHP9ILzB5Ht3S7SSwLa/M5xY4NJYWW1J
	EVztMPwm8YpVb4Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 71C0B13687;
	Fri, 19 Apr 2024 16:58:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id j8SUG9CiImb/HQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 19 Apr 2024 16:58:56 +0000
Date: Fri, 19 Apr 2024 18:51:21 +0200
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 01/11] btrfs: btrfs_cleanup_fs_roots handle ret
 variable
Message-ID: <20240419165121.GY3492@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1713370756.git.anand.jain@oracle.com>
 <5063cdad35934623ddefe8e49c4a2c105713beb3.1713370756.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5063cdad35934623ddefe8e49c4a2c105713beb3.1713370756.git.anand.jain@oracle.com>
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
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,oracle.com:email,suse.cz:dkim,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 910585D8F8
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.21

On Thu, Apr 18, 2024 at 03:08:33PM +0800, Anand Jain wrote:
> Since err represents the function return value, rename it as ret,
> and rename the original ret, which serves as a helper return value,
> to found. Also, optimize the code to continue call btrfs_put_root()
> for the rest of the root if even after btrfs_orphan_cleanup() returns
> error.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2: Rename to 'found' instead of 'ret2' (Josef).
>     Call btrfs_put_root() in the while-loop, avoids use of the variable
> 	'found' outside of the while loop (Qu).
>     Use 'unsigned int i' instead of 'int' (Goffredo).
> 
>  fs/btrfs/disk-io.c | 33 +++++++++++++++------------------
>  1 file changed, 15 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index c2dc88f909b0..d1d23736de3c 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2926,22 +2926,23 @@ static int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info)
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
>  			/* Avoid to grab roots in dead_roots. */
>  			if (btrfs_root_refs(&gang[i]->root_item) == 0) {
>  				gang[i] = NULL;
> @@ -2952,24 +2953,20 @@ static int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info)
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
> +			if (!ret)
> +				ret = btrfs_orphan_cleanup(gang[i]);

Please add a comment, this is not a common pattern.

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
> 2.41.0
> 

