Return-Path: <linux-btrfs+bounces-7073-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E94B494D751
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2024 21:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D55EB22F85
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2024 19:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A2815ADB1;
	Fri,  9 Aug 2024 19:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ahd6zNO+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DdxxULSu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ahd6zNO+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DdxxULSu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBC6A41
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Aug 2024 19:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723231886; cv=none; b=I6WrsSOufrSJYVE3GUfKOD8/j2VfGA++qE89wX4tLh2ONPfJ5heNG8olQgOBU5TFnEcw269aIl8VQlZ/OMVpRYEHQQnxOHBq4y3qHjnmjTDSGcgczqQNGOo6H8oL7k8CY1RUJQs43Ep87xpy56vsImWRP/l2Nj1Z3HwzNThHX8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723231886; c=relaxed/simple;
	bh=WW5gkdsxdYWht9aMgV5pjZyLlEpE2vaMLN6oRvYp0qE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUUiu1PTPOZ2f46gG6e3EPFK2/VeDhig3dhgrMTeDdylCBaBXtKqm/tTyxJrj4MT0HlU6ujTGiJN+NXsVXaxBJipX+tLaJUiZ/S8w5qTOC+SL7ZE7Q85b4DZVY42eLFCrs6w1ofVfUIa+hV1L60MZAhRvbIDUtOBRnkqA2xLGVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ahd6zNO+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DdxxULSu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ahd6zNO+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DdxxULSu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1A93921EE7;
	Fri,  9 Aug 2024 19:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723231882;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P06UolqoaMOFgAqHEm2by0+iZOCanawweblqAm1rOkI=;
	b=ahd6zNO+lPnPpQgIMS8jdSZMgUm1Wcag84LJJWiG3L1V6PjkmdPx/4Hbg+vKHczLz0m5d1
	9eHtlsrILCvHM0MwbkryVICGWIn6aXTtRLrOViddfm6zF3vy63HcE3WhVaJwffAqIc0wrr
	CV8cPanmOHoTljRokgwwPlYuJxSikJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723231882;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P06UolqoaMOFgAqHEm2by0+iZOCanawweblqAm1rOkI=;
	b=DdxxULSuz+HXGNfXcrPriUqacO/0vA2reRYLRigQZmNu3GBeYn68HTH02sCb4B2HWKlo1E
	dOiND8D02GG1hSDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ahd6zNO+;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=DdxxULSu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723231882;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P06UolqoaMOFgAqHEm2by0+iZOCanawweblqAm1rOkI=;
	b=ahd6zNO+lPnPpQgIMS8jdSZMgUm1Wcag84LJJWiG3L1V6PjkmdPx/4Hbg+vKHczLz0m5d1
	9eHtlsrILCvHM0MwbkryVICGWIn6aXTtRLrOViddfm6zF3vy63HcE3WhVaJwffAqIc0wrr
	CV8cPanmOHoTljRokgwwPlYuJxSikJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723231882;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P06UolqoaMOFgAqHEm2by0+iZOCanawweblqAm1rOkI=;
	b=DdxxULSuz+HXGNfXcrPriUqacO/0vA2reRYLRigQZmNu3GBeYn68HTH02sCb4B2HWKlo1E
	dOiND8D02GG1hSDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C9AD11379A;
	Fri,  9 Aug 2024 19:31:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 32QCMYlutmbFYwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 09 Aug 2024 19:31:21 +0000
Date: Fri, 9 Aug 2024 21:31:12 +0200
From: David Sterba <dsterba@suse.cz>
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v5] btrfs-progs: add --subvol option to mkfs.btrfs
Message-ID: <20240809193112.GD25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240808171721.370556-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808171721.370556-1-maharmstone@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.21
X-Rspamd-Queue-Id: 1A93921EE7
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
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO

On Thu, Aug 08, 2024 at 06:17:16PM +0100, Mark Harmstone wrote:
> This patch adds a --subvol option, which tells mkfs.btrfs to create the
> specified directories as subvolumes.
> 
> Given a populated directory img, the command
> 
> $ mkfs.btrfs --rootdir img --subvol img/usr --subvol img/home --subvol img/home/username /dev/loop0
> 
> will create subvolumes usr and home within the FS root, and subvolume
> username within the home subvolume. It will fail if any of the
> directories do not yet exist.

Can this be fixed so the intermediate directories are created if they
don't exist? So for example

mkfs.btrfs --rootdir dir --subvolume /var/lib/images

where dir contains only /var. I don't think it's that common but we
should not make users type something can be done programmaticaly.

> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> ---
>  mkfs/main.c                                 | 146 ++++++++++++++++++--
>  mkfs/rootdir.c                              | 131 ++++++++++++++----
>  mkfs/rootdir.h                              |   9 +-
>  tests/mkfs-tests/036-rootdir-subvol/test.sh |  33 +++++
>  4 files changed, 277 insertions(+), 42 deletions(-)
>  create mode 100755 tests/mkfs-tests/036-rootdir-subvol/test.sh
> 
> Changelog:
> 
> Patch 2:
> * Rebased against upstream changes
> * Rewrote so that directory sizes are correct within transactions
> * Changed --subvol so that it is relative to cwd rather than rootdir, so
> that in future we might allow out-of-tree subvols
> 
> Patch 3:
> * Changed btrfs_mkfs_fill_dir so it doesn't start a transaction itself
> * Moved subvol creation and linking into traverse_directory
> * Removed depth calculation code, no longer needed
> 
> Patch 4:
> * Rebased against upstream changes
> 
> Patch 5:
> * Removed some useless calls to list_empty
> 
> diff --git a/mkfs/main.c b/mkfs/main.c
> index b24b148d..ebf2a9c0 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -440,6 +440,7 @@ static const char * const mkfs_usage[] = {
>  	"Creation:",
>  	OPTLINE("-b|--byte-count SIZE", "set size of each device to SIZE (filesystem size is sum of all device sizes)"),
>  	OPTLINE("-r|--rootdir DIR", "copy files from DIR to the image root directory"),
> +	OPTLINE("-u|--subvol SUBDIR", "create SUBDIR as subvolume rather than normal directory"),

Please mention that it can be specified multiple times.

>  	OPTLINE("--shrink", "(with --rootdir) shrink the filled filesystem to minimal size"),
>  	OPTLINE("-K|--nodiscard", "do not perform whole device TRIM"),
>  	OPTLINE("-f|--force", "force overwrite of existing filesystem"),
> @@ -1055,6 +1056,9 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>  	char *label = NULL;
>  	int nr_global_roots = sysconf(_SC_NPROCESSORS_ONLN);
>  	char *source_dir = NULL;
> +	size_t source_dir_len = 0;
> +	struct rootdir_subvol *rds;

Please use a more descriptive variable name.

> +	LIST_HEAD(subvols);
>  
>  	cpu_detect_flags();
>  	hash_init_accel();
> @@ -1085,6 +1089,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>  			{ "data", required_argument, NULL, 'd' },
>  			{ "version", no_argument, NULL, 'V' },
>  			{ "rootdir", required_argument, NULL, 'r' },
> +			{ "subvol", required_argument, NULL, 'u' },
>  			{ "nodiscard", no_argument, NULL, 'K' },
>  			{ "features", required_argument, NULL, 'O' },
>  			{ "runtime-features", required_argument, NULL, 'R' },
> @@ -1102,7 +1107,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>  			{ NULL, 0, NULL, 0}
>  		};
>  
> -		c = getopt_long(argc, argv, "A:b:fl:n:s:m:d:L:R:O:r:U:VvMKq",
> +		c = getopt_long(argc, argv, "A:b:fl:n:s:m:d:L:R:O:r:U:VvMKqu:",
>  				long_options, NULL);
>  		if (c < 0)
>  			break;
> @@ -1208,6 +1213,22 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>  				free(source_dir);
>  				source_dir = strdup(optarg);
>  				break;
> +			case 'u': {
> +				struct rootdir_subvol *s;

Please avoid sinle letter variables (except 'i' for indexing).

> +
> +				s = malloc(sizeof(struct rootdir_subvol));
> +				if (!s) {
> +					error("out of memory");

There's the error_msg ERROR_MSG_MEMORY template for errors, please use it.

> +					ret = 1;
> +					goto error;
> +				}
> +
> +				s->dir = strdup(optarg);
> +				s->full_path = NULL;
> +
> +				list_add_tail(&s->list, &subvols);
> +				break;
> +				}
>  			case 'U':
>  				strncpy_null(fs_uuid, optarg, BTRFS_UUID_UNPARSED_SIZE);
>  				break;
> @@ -1272,6 +1293,71 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>  		ret = 1;
>  		goto error;
>  	}
> +	if (!list_empty(&subvols) && source_dir == NULL) {
> +		error("the option --subvol must be used with --rootdir");

This may be also allowed, e.g. for use case that creates the skeleton of
the subvolumes but does not fill it with files that can be later
copied over the existing structure. As this may be more comples doing
that in another patch is ok.

> +		ret = 1;
> +		goto error;
> +	}
> +
> +	if (source_dir) {
> +		char *canonical = realpath(source_dir, NULL);
> +
> +		if (!canonical) {
> +			error("could not get canonical path to %s", source_dir);
> +			ret = 1;
> +			goto error;
> +		}
> +
> +		free(source_dir);
> +		source_dir = canonical;
> +		source_dir_len = strlen(source_dir);
> +	}
> +
> +	list_for_each_entry(rds, &subvols, list) {
> +		char *path;
> +		struct rootdir_subvol *rds2;
> +
> +		if (!path_exists(rds->dir)) {
> +			error("subvol %s does not exist", rds->dir);

In error messages please use 'subvolume'

> +			ret = 1;
> +			goto error;
> +		}
> +
> +		if (!path_is_dir(rds->dir)) {
> +			error("subvol %s is not a directory", rds->dir);
> +			ret = 1;
> +			goto error;
> +		}
> +
> +		path = realpath(rds->dir, NULL);
> +
> +		if (!path) {
> +			error("could not get canonical path to %s", rds->dir);
> +			ret = 1;
> +			goto error;
> +		}
> +
> +		rds->full_path = path;
> +
> +		if (strlen(path) < source_dir_len + 1 ||
> +		    memcmp(path, source_dir, source_dir_len) ||

Please use explicit == 0 or != 0 for memcmp (and strcmp).

> +		    path[source_dir_len] != '/') {
> +			error("subvol %s is not a child of %s", rds->dir,
> +			      source_dir);
> +			ret = 1;
> +			goto error;
> +		}
> +
> +		for (rds2 = list_first_entry(&subvols, struct rootdir_subvol, list);
> +		     rds2 != rds; rds2 = list_next_entry(rds2, list)) {
> +			if (!strcmp(rds2->full_path, path)) {
> +				error("subvol %s specified more than once",
> +					rds->dir);

I wonder if this should be a hard error, mentioning the subvolume twice
does not change anything and it's slightly more convenient for example
when the subvolume list is generated

> +				ret = 1;
> +				goto error;
> +			}
> +		}
> +	}
>  
>  	if (*fs_uuid) {
>  		uuid_t dummy_uuid;
> @@ -1821,24 +1907,37 @@ raid_groups:
>  		error_msg(ERROR_MSG_START_TRANS, "%m");
>  		goto out;
>  	}
> -	ret = btrfs_rebuild_uuid_tree(fs_info);
> -	if (ret < 0)
> -		goto out;
> -
> -	ret = cleanup_temp_chunks(fs_info, &allocation, data_profile,
> -				  metadata_profile, metadata_profile);
> -	if (ret < 0) {
> -		error("failed to cleanup temporary chunks: %d", ret);
> -		goto out;
> -	}
>  
>  	if (source_dir) {
>  		pr_verbose(LOG_DEFAULT, "Rootdir from:       %s\n", source_dir);
> -		ret = btrfs_mkfs_fill_dir(source_dir, root);
> +
> +		trans = btrfs_start_transaction(root, 1);
> +		if (IS_ERR(trans)) {
> +			errno = -PTR_ERR(trans);
> +			error_msg(ERROR_MSG_START_TRANS, "%m");
> +			goto out;
> +		}
> +
> +		ret = btrfs_mkfs_fill_dir(trans, source_dir, root,
> +					  &subvols);
>  		if (ret) {
>  			error("error while filling filesystem: %d", ret);
> +			btrfs_abort_transaction(trans, ret);
> +			goto out;
> +		}
> +
> +		ret = btrfs_commit_transaction(trans, root);
> +		if (ret) {
> +			errno = -ret;
> +			error_msg(ERROR_MSG_COMMIT_TRANS, "%m");
>  			goto out;
>  		}
> +
> +		list_for_each_entry(rds, &subvols, list) {
> +			pr_verbose(LOG_DEFAULT, "  Subvol from:      %s\n",

The messages is probably copied from the 'Rootdir from' but here the
'from' does not make sense as it's only creating the subvolume, not
copying files "from" it.

> +				   rds->full_path);
> +		}
> +
>  		if (shrink_rootdir) {
>  			pr_verbose(LOG_DEFAULT, "  Shrink:           yes\n");
>  			ret = btrfs_mkfs_shrink_fs(fs_info, &shrink_size,
> @@ -1853,6 +1952,17 @@ raid_groups:
>  		}
>  	}
>  
> +	ret = btrfs_rebuild_uuid_tree(fs_info);
> +	if (ret < 0)
> +		goto out;
> +
> +	ret = cleanup_temp_chunks(fs_info, &allocation, data_profile,
> +				  metadata_profile, metadata_profile);
> +	if (ret < 0) {
> +		error("failed to cleanup temporary chunks: %d", ret);
> +		goto out;
> +	}
> +
>  	if (features.runtime_flags & BTRFS_FEATURE_RUNTIME_QUOTA ||
>  	    features.incompat_flags & BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA) {
>  		ret = setup_quota_root(fs_info);
> @@ -1946,6 +2056,18 @@ error:
>  	free(label);
>  	free(source_dir);
>  
> +	while (!list_empty(&subvols)) {
> +		struct rootdir_subvol *head = list_entry(subvols.next,
> +					      struct rootdir_subvol,
> +					      list);
> +
> +		free(head->dir);
> +		free(head->full_path);
> +
> +		list_del(&head->list);
> +		free(head);
> +	}
> +
>  	return !!ret;
>  
>  success:
> diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
> index 05787dc3..8f5658e1 100644
> --- a/mkfs/rootdir.c
> +++ b/mkfs/rootdir.c
> @@ -40,6 +40,8 @@
>  #include "common/messages.h"
>  #include "common/utils.h"
>  #include "common/extent-tree-utils.h"
> +#include "common/root-tree-utils.h"
> +#include "common/path-utils.h"
>  #include "mkfs/rootdir.h"
>  
>  static u32 fs_block_size;
> @@ -68,6 +70,7 @@ static u64 ftw_data_size;
>  struct inode_entry {
>  	/* The inode number inside btrfs. */
>  	u64 ino;
> +	struct btrfs_root *root;
>  	struct list_head list;
>  };
>  
> @@ -91,6 +94,8 @@ static struct rootdir_path current_path = {
>  };
>  
>  static struct btrfs_trans_handle *g_trans = NULL;
> +static struct list_head *g_subvols;
> +static u64 next_subvol_id = BTRFS_FIRST_FREE_OBJECTID;
>  
>  static inline struct inode_entry *rootdir_path_last(struct rootdir_path *path)
>  {
> @@ -111,13 +116,15 @@ static void rootdir_path_pop(struct rootdir_path *path)
>  	free(last);
>  }
>  
> -static int rootdir_path_push(struct rootdir_path *path, u64 ino)
> +static int rootdir_path_push(struct rootdir_path *path, struct btrfs_root *root,
> +			     u64 ino)
>  {
>  	struct inode_entry *new;
>  
>  	new = malloc(sizeof(*new));
>  	if (!new)
>  		return -ENOMEM;
> +	new->root = root;
>  	new->ino = ino;
>  	list_add_tail(&new->list, &path->inode_list);
>  	path->level++;
> @@ -409,13 +416,83 @@ static u8 ftype_to_btrfs_type(mode_t ftype)
>  	return BTRFS_FT_UNKNOWN;
>  }
>  
> +static int ftw_add_subvol(const char *full_path, const struct stat *st,
> +			  int typeflag, struct FTW *ftwbuf,
> +			  struct rootdir_subvol *s)

No single letter parameters

> +{
> +	int ret;
> +	struct btrfs_key key;
> +	struct btrfs_root *new_root;
> +	struct inode_entry *parent;
> +	struct btrfs_inode_item inode_item = { 0 };
> +	u64 subvol_id, ino;
> +
> +	subvol_id = next_subvol_id++;
> +
> +	ret = btrfs_make_subvolume(g_trans, subvol_id);
> +	if (ret < 0) {
> +		error("failed to create subvolume: %d", ret);
> +		return ret;
> +	}
> +
> +	key.objectid = subvol_id;
> +	key.type = BTRFS_ROOT_ITEM_KEY;
> +	key.offset = (u64)-1;
> +
> +	new_root = btrfs_read_fs_root(g_trans->fs_info, &key);
> +	if (IS_ERR(new_root)) {
> +		error("unable to fs read root: %lu", PTR_ERR(new_root));
> +		return -PTR_ERR(new_root);
> +	}
> +
> +	parent = rootdir_path_last(&current_path);
> +
> +	ret = btrfs_link_subvolume(g_trans, parent->root, parent->ino,
> +				   path_basename(s->full_path),
> +				   strlen(path_basename(s->full_path)), new_root);
> +	if (ret) {
> +		error("unable to link subvolume %s", path_basename(s->full_path));
> +		return ret;
> +	}
> +
> +	ino = btrfs_root_dirid(&new_root->root_item);
> +
> +	ret = add_xattr_item(g_trans, new_root, ino, full_path);
> +	if (ret < 0) {
> +		errno = -ret;
> +		error("failed to add xattr item for the top level inode in subvol %llu: %m",

Please also add the full_path to the error message

> +		      subvol_id);
> +		return ret;
> +	}
> +	stat_to_inode_item(&inode_item, st);
> +
> +	btrfs_set_stack_inode_nlink(&inode_item, 1);
> +	ret = update_inode_item(g_trans, new_root, &inode_item, ino);
> +	if (ret < 0) {
> +		errno = -ret;
> +		error("failed to update root dir for root %llu: %m", subvol_id);
> +		return ret;
> +	}
> +
> +	ret = rootdir_path_push(&current_path, new_root, ino);
> +	if (ret < 0) {
> +		errno = -ret;
> +		error("failed to allocate new entry for subvol %llu ('%s'): %m",
> +		      subvol_id, full_path);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static int ftw_add_inode(const char *full_path, const struct stat *st,
>  			 int typeflag, struct FTW *ftwbuf)
>  {
>  	struct btrfs_fs_info *fs_info = g_trans->fs_info;
> -	struct btrfs_root *root = fs_info->fs_root;
> +	struct btrfs_root *root;
>  	struct btrfs_inode_item inode_item = { 0 };
>  	struct inode_entry *parent;
> +	struct rootdir_subvol *rds;
>  	u64 ino;
>  	int ret;
>  
> @@ -436,7 +513,10 @@ static int ftw_add_inode(const char *full_path, const struct stat *st,
>  
>  	/* The rootdir itself. */
>  	if (unlikely(ftwbuf->level == 0)) {
> -		u64 root_ino = btrfs_root_dirid(&root->root_item);
> +		u64 root_ino;
> +
> +		root = fs_info->fs_root;
> +		root_ino = btrfs_root_dirid(&root->root_item);
>  
>  		UASSERT(S_ISDIR(st->st_mode));
>  		UASSERT(current_path.level == 0);
> @@ -462,7 +542,7 @@ static int ftw_add_inode(const char *full_path, const struct stat *st,
>  		}
>  
>  		/* Push (and initialize) the rootdir directory into the stack. */
> -		ret = rootdir_path_push(&current_path,
> +		ret = rootdir_path_push(&current_path, root,
>  					btrfs_root_dirid(&root->root_item));
>  		if (ret < 0) {
>  			errno = -ret;
> @@ -511,6 +591,18 @@ static int ftw_add_inode(const char *full_path, const struct stat *st,
>  	while (current_path.level > ftwbuf->level)
>  		rootdir_path_pop(&current_path);
>  
> +	if (S_ISDIR(st->st_mode)) {
> +		list_for_each_entry(rds, g_subvols, list) {
> +			if (!strcmp(full_path, rds->full_path)) {

Please use == 0 or != for stcmp.

> +				return ftw_add_subvol(full_path, st, typeflag,
> +						      ftwbuf, rds);
> +			}
> +		}
> +	}
> +
> +	parent = rootdir_path_last(&current_path);
> +	root = parent->root;
> +
>  	ret = btrfs_find_free_objectid(g_trans, root,
>  				       BTRFS_FIRST_FREE_OBJECTID, &ino);
>  	if (ret < 0) {
> @@ -529,7 +621,6 @@ static int ftw_add_inode(const char *full_path, const struct stat *st,
>  		return ret;
>  	}
>  
> -	parent = rootdir_path_last(&current_path);
>  	ret = btrfs_add_link(g_trans, root, ino, parent->ino,
>  			     full_path + ftwbuf->base,
>  			     strlen(full_path) - ftwbuf->base,
> @@ -556,7 +647,7 @@ static int ftw_add_inode(const char *full_path, const struct stat *st,
>  		return ret;
>  	}
>  	if (S_ISDIR(st->st_mode)) {
> -		ret = rootdir_path_push(&current_path, ino);
> +		ret = rootdir_path_push(&current_path, root, ino);
>  		if (ret < 0) {
>  			errno = -ret;
>  			error("failed to allocate new entry for inode %llu ('%s'): %m",
> @@ -597,49 +688,31 @@ static int ftw_add_inode(const char *full_path, const struct stat *st,
>  	return 0;
>  };
>  
> -int btrfs_mkfs_fill_dir(const char *source_dir, struct btrfs_root *root)
> +int btrfs_mkfs_fill_dir(struct btrfs_trans_handle *trans, const char *source_dir,
> +			struct btrfs_root *root, struct list_head *subvols)
>  {
>  	int ret;
> -	struct btrfs_trans_handle *trans;
>  	struct stat root_st;
>  
>  	ret = lstat(source_dir, &root_st);
>  	if (ret) {
>  		error("unable to lstat %s: %m", source_dir);
> -		ret = -errno;
> -		goto out;
> -	}
> -
> -	trans = btrfs_start_transaction(root, 1);
> -	if (IS_ERR(trans)) {
> -		ret = PTR_ERR(trans);
> -		errno = -ret;
> -		error_msg(ERROR_MSG_START_TRANS, "%m");
> -		goto fail;
> +		return -errno;
>  	}
>  
>  	g_trans = trans;
> +	g_subvols = subvols;
>  	INIT_LIST_HEAD(&current_path.inode_list);
>  
>  	ret = nftw(source_dir, ftw_add_inode, 32, FTW_PHYS);
>  	if (ret) {
>  		error("unable to traverse directory %s: %d", source_dir, ret);
> -		goto fail;
> -	}
> -	ret = btrfs_commit_transaction(trans, root);
> -	if (ret) {
> -		errno = -ret;
> -		error_msg(ERROR_MSG_COMMIT_TRANS, "%m");
> -		goto out;
> +		return ret;
>  	}
>  	while (current_path.level > 0)
>  		rootdir_path_pop(&current_path);
>  
>  	return 0;
> -fail:
> -	btrfs_abort_transaction(trans, ret);
> -out:
> -	return ret;
>  }
>  
>  static int ftw_add_entry_size(const char *fpath, const struct stat *st,
> diff --git a/mkfs/rootdir.h b/mkfs/rootdir.h
> index 4233431a..128e9e09 100644
> --- a/mkfs/rootdir.h
> +++ b/mkfs/rootdir.h
> @@ -28,7 +28,14 @@
>  struct btrfs_fs_info;
>  struct btrfs_root;
>  
> -int btrfs_mkfs_fill_dir(const char *source_dir, struct btrfs_root *root);
> +struct rootdir_subvol {
> +	struct list_head list;
> +	char *dir;
> +	char *full_path;
> +};
> +
> +int btrfs_mkfs_fill_dir(struct btrfs_trans_handle *trans, const char *source_dir,
> +			struct btrfs_root *root, struct list_head *subvols);
>  u64 btrfs_mkfs_size_dir(const char *dir_name, u32 sectorsize, u64 min_dev_size,
>  			u64 meta_profile, u64 data_profile);
>  int btrfs_mkfs_shrink_fs(struct btrfs_fs_info *fs_info, u64 *new_size_ret,
> diff --git a/tests/mkfs-tests/036-rootdir-subvol/test.sh b/tests/mkfs-tests/036-rootdir-subvol/test.sh
> new file mode 100755
> index 00000000..ccd6893f
> --- /dev/null
> +++ b/tests/mkfs-tests/036-rootdir-subvol/test.sh
> @@ -0,0 +1,33 @@
> +#!/bin/bash
> +# smoke test for mkfs.btrfs --subvol option
> +
> +source "$TEST_TOP/common" || exit
> +
> +check_prereq mkfs.btrfs
> +check_prereq btrfs
> +
> +setup_root_helper
> +prepare_test_dev
> +
> +tmp=$(_mktemp_dir mkfs-rootdir)
> +
> +touch $tmp/foo
> +mkdir $tmp/dir
> +mkdir $tmp/dir/subvol
> +touch $tmp/dir/subvol/bar

Please quote all shell variables
(https://github.com/kdave/btrfs-progs/tree/devel/tests#coding-style-best-practices)

> +
> +run_check_mkfs_test_dev --rootdir "$tmp" --subvol "$tmp/dir/subvol"
> +run_check $SUDO_HELPER "$TOP/btrfs" check "$TEST_DEV"
> +
> +run_check_mount_test_dev
> +run_check_stdout $SUDO_HELPER "$TOP/btrfs" subvolume list "$TEST_MNT" | \
> +	cut -d\  -f9 > "$tmp/output"
> +run_check_umount_test_dev
> +
> +result=$(cat "$tmp/output")
> +
> +if [ "$result" != "dir/subvol" ]; then
> +	_fail "dir/subvol not in subvolume list"
> +fi
> +
> +rm -rf -- "$tmp"
> -- 
> 2.44.2
> 
> 

