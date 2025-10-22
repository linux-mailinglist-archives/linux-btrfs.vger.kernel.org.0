Return-Path: <linux-btrfs+bounces-18154-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EA6BFA930
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 09:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A6184EA74F
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 07:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF6E2F83D8;
	Wed, 22 Oct 2025 07:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jVVU/a/u";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FwHGxIBf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jobb8kvn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="q2s0vJ4+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A822EC568
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Oct 2025 07:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761118320; cv=none; b=AbfJfNQHW96oUfrZxASvjX4fNcfr583bucjeC20SBV90u4LdgZ3KNDqSIee0DjAf7lKUm5qxb0/i2N5I9mepagYXsdFoT3Si2Nty4HNEHHN2ztyeuwtdI1iQhZkrHXO0icAuhyGn9xTDiKWyUbiwM0oqB6G+A63DNm6h7uPRf0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761118320; c=relaxed/simple;
	bh=nni058SerUWrPEH+xI5uMnP8DnngzYS4zOj5GDkfbFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GeSNvuDP75cr8TbEBATce0sJZxulg0sbGrQNThV1C2oEdfWWH42sjBY7sQGC/W09if4P27eBboIU1HSSVXQZC9ne3AY5Nmf6ols92CJ8rJncMQZtK37UTy3F1F3qeYMDx2tH7S8FODL4pi4ZKwRkmursXWySmiQNA+7pBOigWAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jVVU/a/u; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FwHGxIBf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jobb8kvn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=q2s0vJ4+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9ECAA1F391;
	Wed, 22 Oct 2025 07:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761118311;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QPxrhNSaar3ryimAQbdkokRF96kEc3aQalF5Fe5MeDE=;
	b=jVVU/a/u/q2/FwWuFGplhaZZBzKfcJTeg3DFiuJLVuVDi+zRE84xfmP1oVtZlRr+n/7vvj
	XY8+7dL7s5xn1ij+0HPLT8BSXliLg+lipY55fvGG6385szMb4trNgodU02xj5ECR62XH12
	yQeASH/SXxVpHYWr/qy9VEtzrVWzWoc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761118311;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QPxrhNSaar3ryimAQbdkokRF96kEc3aQalF5Fe5MeDE=;
	b=FwHGxIBfzTEPZ7/X1vEJtTa1UGaneh9dnyLwVeO+EMpmKdlpxGeT2DI6dHRp4wQnHbzi3z
	BsnL/4roa5+qz+CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761118307;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QPxrhNSaar3ryimAQbdkokRF96kEc3aQalF5Fe5MeDE=;
	b=jobb8kvnGuvzURwf63NHPQNWgsi3o6NQ4FjFHyDr5gZ27uDuGfzJ+x+vgtup4d4hpGqhRK
	DZUEF7psj9Z0k2yvOrNTkEZiqvCmuMe+dcTbIi2xVAcpCNmbiB4euZLu/FzC2z+0bTv7s/
	fmrDUkUQ2liW2LxAva33CiApq07S7cs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761118307;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QPxrhNSaar3ryimAQbdkokRF96kEc3aQalF5Fe5MeDE=;
	b=q2s0vJ4+QZKotK4d80wK6BDpqazzeAxeXeTgGx0gOk4jcQwITMkIKlkdKGAQK6K/9AoDIa
	Robw6QWVMbkVycBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 758011339F;
	Wed, 22 Oct 2025 07:31:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id e3+PHGOI+GjgFgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 22 Oct 2025 07:31:47 +0000
Date: Wed, 22 Oct 2025 09:31:38 +0200
From: David Sterba <dsterba@suse.cz>
To: Miquel =?iso-8859-1?Q?Sabat=E9_Sol=E0?= <mssola@mssola.com>
Cc: linux-btrfs@vger.kernel.org, clm@fb.com, dsterba@suse.com,
	johannes.thumshirn@wdc.com, fdmanana@suse.com, boris@bur.io,
	wqu@suse.com, neal@gompa.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] btrfs: declare free_ipath() via DEFINE_FREE() instead
Message-ID: <20251022073138.GX13776@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251021142749.642956-1-mssola@mssola.com>
 <20251021142749.642956-2-mssola@mssola.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251021142749.642956-2-mssola@mssola.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,twin.jikos.cz:mid];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Tue, Oct 21, 2025 at 04:27:46PM +0200, Miquel Sabaté Solà wrote:
> This transforms the signature to __free_ipath() instead of the original
> free_ipath(), but this function was only being used as a cleanup
> function anyways. Hence, define it as a helper and use it via the
> __free() attribute on all uses. This change also means that
> __free_ipath() will be inlined whereas that wasn't the case for the
> original one, but this shouldn't be a problem.
> 
> A follow up macro like we do with BTRFS_PATH_AUTO_FREE() has been
> discarded as the usage of this struct is not as widespread as that.

The point of adding the macros or at least the freeing wrappers is to
force the NULL initialization and to make it visible in the declarations
(typed all in capitals). The number of use should not be the main factor
and in this case it's 4 files.

> Signed-off-by: Miquel Sabaté Solà <mssola@mssola.com>
> ---
>  fs/btrfs/backref.c | 10 +---------
>  fs/btrfs/backref.h |  7 ++++++-
>  fs/btrfs/inode.c   |  4 +---
>  fs/btrfs/ioctl.c   |  3 +--
>  fs/btrfs/scrub.c   |  4 +---
>  5 files changed, 10 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index e050d0938dc4..a1456402752a 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -2785,7 +2785,7 @@ struct btrfs_data_container *init_data_container(u32 total_bytes)
>   * allocates space to return multiple file system paths for an inode.
>   * total_bytes to allocate are passed, note that space usable for actual path
>   * information will be total_bytes - sizeof(struct inode_fs_paths).
> - * the returned pointer must be freed with free_ipath() in the end.
> + * the returned pointer must be freed with __free_ipath() in the end.
>   */
>  struct inode_fs_paths *init_ipath(s32 total_bytes, struct btrfs_root *fs_root,
>  					struct btrfs_path *path)
> @@ -2810,14 +2810,6 @@ struct inode_fs_paths *init_ipath(s32 total_bytes, struct btrfs_root *fs_root,
>  	return ifp;
>  }
>  
> -void free_ipath(struct inode_fs_paths *ipath)
> -{
> -	if (!ipath)
> -		return;
> -	kvfree(ipath->fspath);
> -	kfree(ipath);
> -}
> -
>  struct btrfs_backref_iter *btrfs_backref_iter_alloc(struct btrfs_fs_info *fs_info)
>  {
>  	struct btrfs_backref_iter *ret;
> diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
> index 25d51c246070..d3b1ad281793 100644
> --- a/fs/btrfs/backref.h
> +++ b/fs/btrfs/backref.h
> @@ -241,7 +241,12 @@ char *btrfs_ref_to_path(struct btrfs_root *fs_root, struct btrfs_path *path,
>  struct btrfs_data_container *init_data_container(u32 total_bytes);
>  struct inode_fs_paths *init_ipath(s32 total_bytes, struct btrfs_root *fs_root,
>  					struct btrfs_path *path);
> -void free_ipath(struct inode_fs_paths *ipath);
> +
> +DEFINE_FREE(ipath, struct inode_fs_paths *,
> +	if (_T) {

You can drop the if() as kvfree/kfree handles NULL pointers and we don't
do that in the struct btrfs_path either.

> +		kvfree(_T->fspath);
> +		kfree(_T);
> +	})
>  
>  int btrfs_find_one_extref(struct btrfs_root *root, u64 inode_objectid,
>  			  u64 start_off, struct btrfs_path *path,
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 79732756b87f..4d154209d70b 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -130,7 +130,7 @@ static int data_reloc_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
>  	struct btrfs_fs_info *fs_info = warn->fs_info;
>  	struct extent_buffer *eb;
>  	struct btrfs_inode_item *inode_item;
> -	struct inode_fs_paths *ipath = NULL;
> +	struct inode_fs_paths *ipath __free(ipath) = NULL;

I'd spell the name in full, like __free(free_ipath) or
__free(inode_fs_paths) so it matches the type not the variable name.

>  	struct btrfs_root *local_root;
>  	struct btrfs_key key;
>  	unsigned int nofs_flag;
> @@ -193,7 +193,6 @@ static int data_reloc_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
>  	}
>  
>  	btrfs_put_root(local_root);
> -	free_ipath(ipath);
>  	return 0;
>  
>  err:
> @@ -201,7 +200,6 @@ static int data_reloc_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
>  "checksum error at logical %llu mirror %u root %llu inode %llu offset %llu, path resolving failed with ret=%d",
>  		   warn->logical, warn->mirror_num, root, inum, offset, ret);
>  
> -	free_ipath(ipath);
>  	return ret;
>  }
>  
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 692016b2b600..453832ded917 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -3298,7 +3298,7 @@ static long btrfs_ioctl_ino_to_path(struct btrfs_root *root, void __user *arg)
>  	u64 rel_ptr;
>  	int size;
>  	struct btrfs_ioctl_ino_path_args *ipa = NULL;
> -	struct inode_fs_paths *ipath = NULL;
> +	struct inode_fs_paths *ipath __free(ipath) = NULL;
>  	struct btrfs_path *path;
>  
>  	if (!capable(CAP_DAC_READ_SEARCH))
> @@ -3346,7 +3346,6 @@ static long btrfs_ioctl_ino_to_path(struct btrfs_root *root, void __user *arg)
>  
>  out:
>  	btrfs_free_path(path);
> -	free_ipath(ipath);
>  	kfree(ipa);
>  
>  	return ret;
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index fe266785804e..74d8af1ff02d 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -505,7 +505,7 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
>  	struct btrfs_inode_item *inode_item;
>  	struct scrub_warning *swarn = warn_ctx;
>  	struct btrfs_fs_info *fs_info = swarn->dev->fs_info;
> -	struct inode_fs_paths *ipath = NULL;
> +	struct inode_fs_paths *ipath __free(ipath) = NULL;
>  	struct btrfs_root *local_root;
>  	struct btrfs_key key;
>  
> @@ -569,7 +569,6 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
>  				  (char *)(unsigned long)ipath->fspath->val[i]);
>  
>  	btrfs_put_root(local_root);
> -	free_ipath(ipath);
>  	return 0;
>  
>  err:
> @@ -580,7 +579,6 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
>  			  swarn->physical,
>  			  root, inum, offset, ret);
>  
> -	free_ipath(ipath);
>  	return 0;
>  }
>  
> -- 
> 2.51.1
> 

