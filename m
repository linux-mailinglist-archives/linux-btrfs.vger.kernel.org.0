Return-Path: <linux-btrfs+bounces-6914-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF63194329C
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 17:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC60D1C214B0
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 15:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FA811CBD;
	Wed, 31 Jul 2024 15:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="u5jsIclr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E0613FFC
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jul 2024 15:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722438132; cv=none; b=ffULrcQrCZnVCIFiVuYmtVc5eh4C2A56km5Bd4jnaVGlpVPa7kIDTcfZyc0d1ExuB4sA8O3NIHJarq3WR2fyQLzY8tlo9SR5UmiV7uYcps4brwFAvOm8g4Pd35wE6/qQahCAMQQjc2ZWh3OewuVsMkMhFey6Yd5r6JTF55J9apg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722438132; c=relaxed/simple;
	bh=b7fcxS8m5oA6GK9UZgALGRChBqI74/PUUF1ZlCU/BgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9d3QMHv6HIBVc2lMGW5czO48dGHix+rNWVk+Y2ifGKo41PMdBXEF/F+3ye2Ud35bBOrv4gnjPqNhb093ymfMd5qgxHSbhZLUfEqSzQTx2F7sljgoXPm1iCsqHD7LaA2aF9mN6wGltpk9ukGUUEUBMRnX3aEf4by6WGsMEWd9wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=u5jsIclr; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b7acf213a3so30544716d6.1
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Jul 2024 08:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722438129; x=1723042929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bq++TTE8oPr/hauksobwNXmZBiIr2aFKhXqh1uCHjHI=;
        b=u5jsIclr7cSxuOghTu62Q/nOARLSvFFi6LX/tMNhfCBaf/YrBqb2cH9CSv77qFC7QL
         /p8wHC0VW0oPt7feNYgWiLaYPxDXXg6PY/ZT4jHEM/xlAUWLzUcpuYFQHYxYqPgnuy2p
         f6V67mOQ1uufHJ6lVMRsqJdOFM9C/uW42YTqG9Hv17VZvQysrcJH20jiqEE+/XXV5UTA
         oTLzH75ueLL+kJVwiqLbasde635a28kiZEWWX5SXh1tP3B0SmVns+mjWKXXOoFT6I9Xa
         AMLrz7lJuwFHHSl710H3d4930c942kLclGjSX+Bgp+nIAGLEFKaMSBn05yoPIFgz+TBA
         2P9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722438129; x=1723042929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bq++TTE8oPr/hauksobwNXmZBiIr2aFKhXqh1uCHjHI=;
        b=LlVjGbU6l/Sp8p0MRWc9Zin2/I7QkejwU3CL/R76UIFn5/dA3nkDUXv21a1fmKd0T7
         eu9q7XY3TDpZZLjk6dCpYghzscNlRauz/2IVXE3qRwVTaqlBIDQJ2jvweheIh4xaTgbv
         wnontW3n3EJJ8oEaAP72FygkAUADjJmqlEKKpN9DEVehPOXrQN7zgiHWXQPE0d4/58Xh
         GZeUOIAsxYfHQotuBKYEolPbHM7KSonm/UNs3f5fkNCVHrstig3Oz85EnA0AsQVe7lZb
         qGhdeday7HFV0yLZUruJAE7k2jeCWYFx6fnasHBZ9eXdpunAp9bwwmKIPIdY5VBS3nLN
         tfLg==
X-Gm-Message-State: AOJu0YwogxbeJa1lTAH6GkrK8oSCmZnE6hd7kK+oiZE2O+SoaJd8hkY/
	SkZsYEj3u0tcu66X2bldi2V30ZGTBcZRxoX+PHGV6RBMrsQ7JDaI7lnCde6x2hHqWkQtXhSXnZK
	n
X-Google-Smtp-Source: AGHT+IEFvDXkjs61EDpKsEp1e8dIvOSHzq810dPmWcVt0q/oZ/5shi22gpktl8po6nHHhkVFKADyVg==
X-Received: by 2002:a05:6214:19ee:b0:6b0:729c:5efc with SMTP id 6a1803df08f44-6bb55b156d4mr183007746d6.56.1722438128500;
        Wed, 31 Jul 2024 08:02:08 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fb01b05sm74741726d6.134.2024.07.31.08.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 08:02:07 -0700 (PDT)
Date: Wed, 31 Jul 2024 11:02:05 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs-progs: add --subvol option to mkfs.btrfs
Message-ID: <20240731150205.GB3908975@perftesting>
References: <20240730093833.1169945-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730093833.1169945-1-maharmstone@fb.com>

On Tue, Jul 30, 2024 at 10:38:26AM +0100, Mark Harmstone wrote:
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
> 
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> ---
> Changes from first patch:
> * Rebased against upstream changes
> * Rewrote so that directory sizes are correct within transactions
> * Changed --subvol so that it is relative to cwd rather than rootdir, so
> that in future we might allow out-of-tree subvols
> 
>  mkfs/main.c                                 | 316 +++++++++++++++++++-
>  mkfs/rootdir.c                              | 125 +++++++-
>  mkfs/rootdir.h                              |  21 +-
>  tests/mkfs-tests/034-rootdir-subvol/test.sh |  33 ++
>  4 files changed, 479 insertions(+), 16 deletions(-)
>  create mode 100755 tests/mkfs-tests/034-rootdir-subvol/test.sh
> 
> diff --git a/mkfs/main.c b/mkfs/main.c
> index e000aeff..6c98b954 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -442,6 +442,7 @@ static const char * const mkfs_usage[] = {
>  	"Creation:",
>  	OPTLINE("-b|--byte-count SIZE", "set size of each device to SIZE (filesystem size is sum of all device sizes)"),
>  	OPTLINE("-r|--rootdir DIR", "copy files from DIR to the image root directory"),
> +	OPTLINE("-u|--subvol SUBDIR", "create SUBDIR as subvolume rather than normal directory"),
>  	OPTLINE("--shrink", "(with --rootdir) shrink the filled filesystem to minimal size"),
>  	OPTLINE("-K|--nodiscard", "do not perform whole device TRIM"),
>  	OPTLINE("-f|--force", "force overwrite of existing filesystem"),
> @@ -1016,6 +1017,19 @@ static void *prepare_one_device(void *ctx)
>  	return NULL;
>  }
>  
> +static int subvol_compar(const void *p1, const void *p2)
> +{
> +	const struct rootdir_subvol *s1 = *(const struct rootdir_subvol**)p1;
> +	const struct rootdir_subvol *s2 = *(const struct rootdir_subvol**)p2;
> +
> +	if (s1->depth < s2->depth)
> +		return 1;
> +	else if (s1->depth > s2->depth)
> +		return -1;
> +	else
> +		return 0;
> +}
> +
>  int BOX_MAIN(mkfs)(int argc, char **argv)
>  {
>  	char *file;
> @@ -1057,6 +1071,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>  	char *label = NULL;
>  	int nr_global_roots = sysconf(_SC_NPROCESSORS_ONLN);
>  	char *source_dir = NULL;
> +	LIST_HEAD(subvols);
>  
>  	cpu_detect_flags();
>  	hash_init_accel();
> @@ -1087,6 +1102,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>  			{ "data", required_argument, NULL, 'd' },
>  			{ "version", no_argument, NULL, 'V' },
>  			{ "rootdir", required_argument, NULL, 'r' },
> +			{ "subvol", required_argument, NULL, 'u' },
>  			{ "nodiscard", no_argument, NULL, 'K' },
>  			{ "features", required_argument, NULL, 'O' },
>  			{ "runtime-features", required_argument, NULL, 'R' },
> @@ -1104,7 +1120,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>  			{ NULL, 0, NULL, 0}
>  		};
>  
> -		c = getopt_long(argc, argv, "A:b:fl:n:s:m:d:L:R:O:r:U:VvMKq",
> +		c = getopt_long(argc, argv, "A:b:fl:n:s:m:d:L:R:O:r:U:VvMKqu:",
>  				long_options, NULL);
>  		if (c < 0)
>  			break;
> @@ -1210,6 +1226,27 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>  				free(source_dir);
>  				source_dir = strdup(optarg);
>  				break;
> +			case 'u': {
> +				struct rootdir_subvol *s;
> +
> +				s = malloc(sizeof(struct rootdir_subvol));
> +				if (!s) {
> +					error("out of memory");
> +					ret = 1;
> +					goto error;
> +				}
> +
> +				s->dir = strdup(optarg);
> +				s->srcpath = NULL;
> +				s->destpath = NULL;
> +				s->parent = NULL;
> +				s->parent_inum = 0;
> +				INIT_LIST_HEAD(&s->children);
> +				s->root = NULL;
> +
> +				list_add_tail(&s->list, &subvols);
> +				break;
> +				}
>  			case 'U':
>  				strncpy_null(fs_uuid, optarg, BTRFS_UUID_UNPARSED_SIZE);
>  				break;
> @@ -1274,6 +1311,154 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>  		ret = 1;
>  		goto error;
>  	}
> +	if (!list_empty(&subvols) && source_dir == NULL) {
> +		error("the option --subvol must be used with --rootdir");
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
> +	}
> +
> +	if (!list_empty(&subvols)) {
> +		unsigned int num_subvols = 0;
> +		size_t source_dir_len = strlen(source_dir);
> +		struct rootdir_subvol **arr, **ptr, *s;
> +
> +		list_for_each_entry(s, &subvols, list) {
> +			char *path;
> +			struct rootdir_subvol *s2;
> +
> +			if (!path_exists(s->dir)) {
> +				error("subvol %s does not exist",
> +				      s->dir);
> +				ret = 1;
> +				goto error;
> +			}
> +
> +			if (!path_is_dir(s->dir)) {
> +				error("subvol %s is not a directory", s->dir);
> +				ret = 1;
> +				goto error;
> +			}
> +
> +			path = realpath(s->dir, NULL);
> +
> +			if (!path) {
> +				error("could not get canonical path to %s",
> +				      s->dir);
> +				ret = 1;
> +				goto error;
> +			}
> +
> +			s->srcpath = path;
> +			s->srcpath_len = strlen(path);
> +
> +			if (s->srcpath_len >= source_dir_len + 1 &&
> +			    !memcmp(path, source_dir, source_dir_len) &&
> +			    path[source_dir_len] == '/') {
> +				s->destpath_len = s->srcpath_len - source_dir_len - 1;
> +
> +				s->destpath = malloc(s->destpath_len + 1);
> +				if (!s->destpath) {
> +					error("out of memory");
> +					ret = 1;
> +					goto error;
> +				}
> +
> +				memcpy(s->destpath, s->srcpath + source_dir_len + 1,
> +				       s->destpath_len);
> +				s->destpath[s->destpath_len] = 0;
> +			} else {
> +				error("subvol %s is not a child of %s",
> +				      s->dir, source_dir);
> +				ret = 1;
> +				goto error;
> +			}
> +
> +			for (s2 = list_first_entry(&subvols, struct rootdir_subvol, list);
> +			     s2 != s; s2 = list_next_entry(s2, list)) {
> +				if (!strcmp(s2->srcpath, path)) {
> +					error("subvol %s specified more than once",
> +					      s->dir);
> +					ret = 1;
> +					goto error;
> +				}
> +			}
> +
> +			s->depth = 0;
> +			for (i = 0; i < s->destpath_len; i++) {
> +				if (s->destpath[i] == '/')
> +					s->depth++;
> +			}
> +
> +			num_subvols++;
> +		}
> +
> +		/* Reorder subvol list by depth. */
> +
> +		arr = malloc(sizeof(struct rootdir_subvol*) * num_subvols);
> +		if (!arr) {
> +			error("out of memory");
> +			ret = 1;
> +			goto error;
> +		}
> +
> +		ptr = arr;
> +
> +		list_for_each_entry(s, &subvols, list) {
> +			*ptr = s;
> +			ptr++;
> +		}
> +
> +		qsort(arr, num_subvols, sizeof(struct rootdir_subvol*),
> +		      subvol_compar);
> +
> +		INIT_LIST_HEAD(&subvols);
> +		for (i = 0; i < num_subvols; i++) {
> +			list_add_tail(&arr[i]->list, &subvols);
> +		}
> +
> +		free(arr);

This whole bit is unnecessary, we have list_sort() available to us.

> +
> +		/* Assign subvols to parents. */
> +
> +		list_for_each_entry(s, &subvols, list) {
> +			if (s->depth == 0)
> +				break;
> +
> +			for (struct rootdir_subvol *s2 = list_next_entry(s, list);
> +			     !list_entry_is_head(s2, &subvols, list);
> +			     s2 = list_next_entry(s2, list)) {
> +				if (s2->depth == s->depth)
> +					continue;
> +
> +				if (s->destpath_len <= s2->destpath_len + 1)
> +					continue;
> +
> +				if (s->destpath[s2->destpath_len] != '/')
> +					continue;
> +
> +				if (memcmp(s->destpath, s2->destpath, s2->destpath_len))
> +					continue;
> +
> +				s->parent = s2;
> +				list_add_tail(&s->child_list, &s2->children);
> +
> +				break;
> +			}
> +		}
> +	}

This whole subvol list processing bit is large enough to be its own helper, and
could go into mkfs/rootdir.c

>  
>  	if (*fs_uuid) {
>  		uuid_t dummy_uuid;
> @@ -1823,6 +2008,51 @@ raid_groups:
>  		error_msg(ERROR_MSG_START_TRANS, "%m");
>  		goto out;
>  	}
> +
> +	if (!list_empty(&subvols)) {
> +		struct rootdir_subvol *s;
> +		u64 objectid = BTRFS_FIRST_FREE_OBJECTID;
> +
> +		list_for_each_entry_reverse(s, &subvols, list) {
> +			struct btrfs_key key;
> +
> +			s->objectid = objectid;
> +
> +			trans = btrfs_start_transaction(root, 1);
> +			if (IS_ERR(trans)) {
> +				errno = -PTR_ERR(trans);
> +				error_msg(ERROR_MSG_START_TRANS, "%m");
> +				ret = 1;
> +				goto error;
> +			}
> +
> +			ret = btrfs_make_subvolume(trans, objectid);
> +			if (ret < 0) {
> +				error("failed to create subvolume: %d", ret);
> +				goto out;
> +			}
> +
> +			ret = btrfs_commit_transaction(trans, root);
> +			if (ret) {
> +				errno = -ret;
> +				error_msg(ERROR_MSG_COMMIT_TRANS, "%m");
> +				goto out;
> +			}
> +
> +			key.objectid = objectid;
> +			key.type = BTRFS_ROOT_ITEM_KEY;
> +			key.offset = (u64)-1;
> +
> +			s->root = btrfs_read_fs_root(fs_info, &key);
> +			if (IS_ERR(s->root)) {
> +				error("unable to fs read root: %lu", PTR_ERR(s->root));
> +				goto out;
> +			}
> +
> +			objectid++;
> +		}
> +	}
> +

I would also put this in its own helper;

>  	ret = btrfs_rebuild_uuid_tree(fs_info);
>  	if (ret < 0)
>  		goto out;
> @@ -1835,8 +2065,24 @@ raid_groups:
>  	}
>  
>  	if (source_dir) {
> +		LIST_HEAD(subvol_children);
> +
>  		pr_verbose(LOG_DEFAULT, "Rootdir from:       %s\n", source_dir);
> -		ret = btrfs_mkfs_fill_dir(source_dir, root);
> +
> +		if (!list_empty(&subvols)) {
> +			struct rootdir_subvol *s;
> +
> +			list_for_each_entry(s, &subvols, list) {
> +				if (s->parent)
> +					continue;
> +
> +				list_add_tail(&s->child_list,
> +					      &subvol_children);
> +			}
> +		}
> +
> +		ret = btrfs_mkfs_fill_dir(source_dir, root, &subvol_children,
> +					  "");
>  		if (ret) {
>  			error("error while filling filesystem: %d", ret);
>  			goto out;
> @@ -1853,6 +2099,59 @@ raid_groups:
>  		} else {
>  			pr_verbose(LOG_DEFAULT, "  Shrink:           no\n");
>  		}
> +
> +		if (!list_empty(&subvols)) {
> +			struct rootdir_subvol *s;
> +
> +			list_for_each_entry_reverse(s, &subvols, list) {
> +				pr_verbose(LOG_DEFAULT,
> +					   "  Subvol from:      %s -> %s\n",
> +					   s->srcpath, s->destpath);
> +			}
> +		}
> +	}
> +
> +	if (!list_empty(&subvols)) {
> +		struct rootdir_subvol *s;
> +
> +		list_for_each_entry(s, &subvols, list) {
> +			ret = btrfs_mkfs_fill_dir(s->srcpath, s->root,
> +						  &s->children, s->destpath);
> +			if (ret) {
> +				error("error while filling filesystem: %d",
> +				      ret);
> +				goto out;
> +			}
> +		}
> +
> +		list_for_each_entry_reverse(s, &subvols, list) {
> +			struct btrfs_root *parent = s->parent ? s->parent->root : root;
> +
> +			trans = btrfs_start_transaction(parent, 1);
> +			if (IS_ERR(trans)) {
> +				errno = -PTR_ERR(trans);
> +				error_msg(ERROR_MSG_START_TRANS, "%m");
> +				goto out;
> +			}
> +
> +			ret = btrfs_link_subvolume(trans, parent,
> +						 s->parent_inum,
> +						 path_basename(s->destpath),
> +						 strlen(path_basename(s->destpath)),
> +						 s->root);
> +			if (ret) {
> +				error("unable to link subvolume %s",
> +					path_basename(s->destpath));
> +				goto out;
> +			}
> +
> +			ret = btrfs_commit_transaction(trans, parent);
> +			if (ret) {
> +				errno = -ret;
> +				error_msg(ERROR_MSG_COMMIT_TRANS, "%m");
> +				goto out;
> +			}
> +		}
>  	}
>  
>  	if (features.runtime_flags & BTRFS_FEATURE_RUNTIME_QUOTA ||
> @@ -1948,6 +2247,19 @@ error:
>  	free(label);
>  	free(source_dir);
>  
> +	while (!list_empty(&subvols)) {
> +		struct rootdir_subvol *head = list_entry(subvols.next,
> +					      struct rootdir_subvol,
> +					      list);
> +
> +		free(head->dir);
> +		free(head->srcpath);
> +		free(head->destpath);
> +
> +		list_del(&head->list);
> +		free(head);
> +	}
> +
>  	return !!ret;
>  
>  success:
> diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
> index 2b39f6bb..e3e576b2 100644
> --- a/mkfs/rootdir.c
> +++ b/mkfs/rootdir.c
> @@ -184,17 +184,58 @@ static void free_namelist(struct dirent **files, int count)
>  	free(files);
>  }
>  
> -static u64 calculate_dir_inode_size(const char *dirname)
> +static u64 calculate_dir_inode_size(const char *src_dir,
> +				    struct list_head *subvol_children,
> +				    const char *dest_dir)
>  {
>  	int count, i;
>  	struct dirent **files, *cur_file;
>  	u64 dir_inode_size = 0;
> +	struct rootdir_subvol *s;
>  
> -	count = scandir(dirname, &files, directory_select, NULL);
> +	count = scandir(src_dir, &files, directory_select, NULL);
>  
>  	for (i = 0; i < count; i++) {
> +		size_t name_len;
> +
>  		cur_file = files[i];
> -		dir_inode_size += strlen(cur_file->d_name);
> +		name_len = strlen(cur_file->d_name);
> +
> +		/* Skip entry if it's going to be a subvol (it will be accounted
> +		 * for in btrfs_link_subvolume). */
> +		if (cur_file->d_type == DT_DIR && !list_empty(subvol_children)) {
> +			bool skip = false;
> +
> +			list_for_each_entry(s, subvol_children, child_list) {
> +				if (!strcmp(dest_dir, "")) {
> +					if (!strcmp(cur_file->d_name, s->destpath)) {
> +						skip = true;
> +						break;
> +					}
> +				} else {
> +					if (s->destpath_len != strlen(dest_dir) + 1 +
> +					    name_len)
> +						continue;
> +
> +					if (memcmp(s->destpath, dest_dir, strlen(dest_dir)))
> +						continue;
> +
> +					if (s->destpath[strlen(dest_dir)] != '/')
> +						continue;
> +
> +					if (!memcmp(s->destpath + strlen(dest_dir) + 1,
> +						    cur_file->d_name, name_len)) {

This comparison code is exists twice, pull it out into a helper and use it here
and when you're building the children relationship.  Thanks,

Josef

> +						skip = true;
> +						break;
> +					}
> +				}
> +			}
> +
> +			if (skip)
> +				continue;
> +		}
> +
> +		dir_inode_size += name_len;
>  	}
>  
>  	free_namelist(files, count);
> @@ -207,7 +248,9 @@ static int add_inode_items(struct btrfs_trans_handle *trans,
>  			   struct btrfs_root *root,
>  			   struct stat *st, const char *name,
>  			   u64 self_objectid,
> -			   struct btrfs_inode_item *inode_ret)
> +			   struct btrfs_inode_item *inode_ret,
> +			   struct list_head *subvol_children,
> +			   const char *dest_dir)
>  {
>  	int ret;
>  	struct btrfs_inode_item btrfs_inode;
> @@ -218,7 +261,9 @@ static int add_inode_items(struct btrfs_trans_handle *trans,
>  	objectid = self_objectid;
>  
>  	if (S_ISDIR(st->st_mode)) {
> -		inode_size = calculate_dir_inode_size(name);
> +		inode_size = calculate_dir_inode_size(name,
> +						      subvol_children,
> +						      dest_dir);
>  		btrfs_set_stack_inode_size(&btrfs_inode, inode_size);
>  	}
>  
> @@ -430,7 +475,9 @@ end:
>  }
>  
>  static int copy_rootdir_inode(struct btrfs_trans_handle *trans,
> -			      struct btrfs_root *root, const char *dir_name)
> +			      struct btrfs_root *root, const char *dir_name,
> +			      struct list_head *subvol_children,
> +			      const char *dest_dir)
>  {
>  	u64 root_dir_inode_size;
>  	struct btrfs_inode_item *inode_item;
> @@ -468,7 +515,8 @@ static int copy_rootdir_inode(struct btrfs_trans_handle *trans,
>  	leaf = path.nodes[0];
>  	inode_item = btrfs_item_ptr(leaf, path.slots[0], struct btrfs_inode_item);
>  
> -	root_dir_inode_size = calculate_dir_inode_size(dir_name);
> +	root_dir_inode_size = calculate_dir_inode_size(dir_name, subvol_children,
> +						       dest_dir);
>  	btrfs_set_inode_size(leaf, inode_item, root_dir_inode_size);
>  
>  	/* Unlike fill_inode_item, we only need to copy part of the attributes. */
> @@ -493,7 +541,9 @@ error:
>  
>  static int traverse_directory(struct btrfs_trans_handle *trans,
>  			      struct btrfs_root *root, const char *dir_name,
> -			      struct directory_name_entry *dir_head)
> +			      struct directory_name_entry *dir_head,
> +			      struct list_head *subvol_children,
> +			      const char *dest_dir)
>  {
>  	int ret = 0;
>  
> @@ -519,12 +569,21 @@ static int traverse_directory(struct btrfs_trans_handle *trans,
>  		goto fail_no_dir;
>  	}
>  
> +	dir_entry->dest_dir = strdup(dest_dir);
> +	if (!dir_entry->dest_dir) {
> +		error_msg(ERROR_MSG_MEMORY, NULL);
> +		ret = -ENOMEM;
> +		goto fail_no_dir;
> +	}
> +
>  	parent_inum = highest_inum + BTRFS_FIRST_FREE_OBJECTID;
>  	dir_entry->inum = parent_inum;
>  	list_add_tail(&dir_entry->list, &dir_head->list);
>  
> -	ret = copy_rootdir_inode(trans, root, dir_name);
> +	ret = copy_rootdir_inode(trans, root, dir_name, subvol_children,
> +				 dest_dir);
>  	if (ret < 0) {
> +		free(dir_entry->dest_dir);
>  		errno = -ret;
>  		error("failed to copy rootdir inode: %m");
>  		goto fail_no_dir;
> @@ -555,7 +614,7 @@ static int traverse_directory(struct btrfs_trans_handle *trans,
>  		}
>  
>  		for (i = 0; i < count; i++) {
> -			char tmp[PATH_MAX];
> +			char tmp[PATH_MAX], cur_dest[PATH_MAX];
>  
>  			cur_file = files[i];
>  
> @@ -570,6 +629,33 @@ static int traverse_directory(struct btrfs_trans_handle *trans,
>  				pr_verbose(LOG_INFO, "ADD: %s\n", tmp);
>  			}
>  
> +			if (S_ISDIR(st.st_mode)) {
> +				if (!strcmp(parent_dir_entry->dest_dir, "")) {
> +					strcpy(cur_dest, cur_file->d_name);
> +				} else {
> +					strcpy(cur_dest, parent_dir_entry->dest_dir);
> +					strcat(cur_dest, "/");
> +					strcat(cur_dest, cur_file->d_name);
> +				}
> +			}
> +
> +			/* Omit child if it is going to be a subvolume. */
> +			if (!list_empty(subvol_children) && S_ISDIR(st.st_mode)) {
> +				struct rootdir_subvol *s;
> +				bool skip = false;
> +
> +				list_for_each_entry(s, subvol_children, child_list) {
> +					if (!strcmp(cur_dest, s->destpath)) {
> +						s->parent_inum = parent_inum;
> +						skip = true;
> +						break;
> +					}
> +				}
> +
> +				if (skip)
> +					continue;
> +			}
> +
>  			/*
>  			 * We can not directly use the source ino number,
>  			 * as there is a chance that the ino is smaller than
> @@ -589,7 +675,8 @@ static int traverse_directory(struct btrfs_trans_handle *trans,
>  
>  			ret = add_inode_items(trans, root, &st,
>  					      cur_file->d_name, cur_inum,
> -					      &cur_inode);
> +					      &cur_inode, subvol_children,
> +					      cur_dest);
>  			if (ret == -EEXIST) {
>  				if (st.st_nlink <= 1) {
>  					error(
> @@ -638,6 +725,15 @@ static int traverse_directory(struct btrfs_trans_handle *trans,
>  					goto fail;
>  				}
>  				dir_entry->inum = cur_inum;
> +
> +				dir_entry->dest_dir = strdup(cur_dest);
> +				if (!dir_entry->dest_dir) {
> +					free(dir_entry->path);
> +					error_msg(ERROR_MSG_MEMORY, NULL);
> +					ret = -ENOMEM;
> +					goto fail;
> +				}
> +
>  				list_add_tail(&dir_entry->list,
>  					      &dir_head->list);
>  			} else if (S_ISREG(st.st_mode)) {
> @@ -661,6 +757,7 @@ static int traverse_directory(struct btrfs_trans_handle *trans,
>  		}
>  
>  		free_namelist(files, count);
> +		free(parent_dir_entry->dest_dir);
>  		free(parent_dir_entry->path);
>  		free(parent_dir_entry);
>  
> @@ -680,7 +777,8 @@ fail_no_dir:
>  	goto out;
>  }
>  
> -int btrfs_mkfs_fill_dir(const char *source_dir, struct btrfs_root *root)
> +int btrfs_mkfs_fill_dir(const char *source_dir, struct btrfs_root *root,
> +			struct list_head *subvol_children, const char* dest_dir)
>  {
>  	int ret;
>  	struct btrfs_trans_handle *trans;
> @@ -705,7 +803,8 @@ int btrfs_mkfs_fill_dir(const char *source_dir, struct btrfs_root *root)
>  		goto fail;
>  }
>  
> -	ret = traverse_directory(trans, root, source_dir, &dir_head);
> +	ret = traverse_directory(trans, root, source_dir, &dir_head,
> +				 subvol_children, dest_dir);
>  	if (ret) {
>  		error("unable to traverse directory %s: %d", source_dir, ret);
>  		goto fail;
> diff --git a/mkfs/rootdir.h b/mkfs/rootdir.h
> index 8d5f6896..64402dbe 100644
> --- a/mkfs/rootdir.h
> +++ b/mkfs/rootdir.h
> @@ -33,10 +33,29 @@ struct directory_name_entry {
>  	const char *dir_name;
>  	char *path;
>  	ino_t inum;
> +	char *dest_dir;
>  	struct list_head list;
>  };
>  
> -int btrfs_mkfs_fill_dir(const char *source_dir, struct btrfs_root *root);
> +struct rootdir_subvol {
> +	struct list_head list;
> +	struct list_head child_list;
> +	char *dir;
> +	char *srcpath;
> +	size_t srcpath_len;
> +	char *destpath;
> +	size_t destpath_len;
> +	struct rootdir_subvol *parent;
> +	u64 parent_inum;
> +	struct list_head children;
> +	unsigned int depth;
> +	u64 objectid;
> +	struct btrfs_root *root;
> +};
> +
> +int btrfs_mkfs_fill_dir(const char *source_dir, struct btrfs_root *root,
> +			struct list_head *subvol_children,
> +			const char* dest_dir);
>  u64 btrfs_mkfs_size_dir(const char *dir_name, u32 sectorsize, u64 min_dev_size,
>  			u64 meta_profile, u64 data_profile);
>  int btrfs_mkfs_shrink_fs(struct btrfs_fs_info *fs_info, u64 *new_size_ret,
> diff --git a/tests/mkfs-tests/034-rootdir-subvol/test.sh b/tests/mkfs-tests/034-rootdir-subvol/test.sh
> new file mode 100755
> index 00000000..ccd6893f
> --- /dev/null
> +++ b/tests/mkfs-tests/034-rootdir-subvol/test.sh
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

