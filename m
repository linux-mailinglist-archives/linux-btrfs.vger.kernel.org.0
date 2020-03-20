Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2737318D859
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Mar 2020 20:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgCTTXq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Mar 2020 15:23:46 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45579 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgCTTXq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Mar 2020 15:23:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id j10so3777227pfi.12
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Mar 2020 12:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Sz//dfsi8mMXJRANl1z9Ap7lJR6szdB0r0qsKBd3Sj0=;
        b=X77x/sflBGCEUXcgNA9iL14jJOAICZHgtXCIvGWnGXOq2tzIt6I6QP2CP8+3ANmf6Z
         Ls/yI1mrFxbEKSwKhPcX1fIqtVcdMl3b7EyQq+PyxReUqc9f++465B/OnWfJeUXHcPis
         1QnVCra9QdGvgJKfKDLI5l+b/8gHy3jDiEq/9//E73NCWFb6EmvvGJ/TsRQ2eF6punw9
         PWHtjkPTpct9GlswPWG6/kJf6Kx/Qj8aPHupNWLzYmGlj2FjqKLqLCTsx11XKHHJwdq3
         3HMheBOk9/JZEO4qclN0NouvRqtdg9AS+kIzpUV3iyof7RjqwMGfl38AAqVK/ntx1DVO
         WX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Sz//dfsi8mMXJRANl1z9Ap7lJR6szdB0r0qsKBd3Sj0=;
        b=KYrtdSe2jACOiBc/GXohDXXXBzyoYm65YavS7yIpAEpYfBUlYZ1737NN/7tVIqBiWM
         yTcPAjoUWFNQAOeDbKYaLYrDQlEAmPxjvt7ms0EJF2DAXUr+dJq18KUuvpi6XL0SkFC4
         6q8atwH0o1mKeyOrmCvejah1EI9ZliWI9MsoknoClNXRlmikGCKKb7ksHgtprw3JDHA1
         79y/UoBRoeiem1KUiO428xV1pgmZHu4fq5W9unj/gcNXMc/aYwtHrgMMqmZRQ4wPzP51
         h0TgIu4BKjoW/nukssa8cgNpuqLVK6NpXKKHgGozn4deQA8ny5StqT1EJdouWnicUbJA
         /NFQ==
X-Gm-Message-State: ANhLgQ0hAVYjI3NTnbSkMD70zx93f4yUFb80Zz1waiXItnjtdahaSNV3
        bsUp5TZRMcaKEe/aY2nPvcCOGQ==
X-Google-Smtp-Source: ADFU+vvqY5qEdBnT4sq9USzToRB8o/7zAZSlMg7mliTmTOPMAzA85dfA/XtLdbsPiMeVL6vxOn7aqw==
X-Received: by 2002:aa7:9433:: with SMTP id y19mr11380172pfo.233.1584732224147;
        Fri, 20 Mar 2020 12:23:44 -0700 (PDT)
Received: from vader ([2620:10d:c090:400::5:c783])
        by smtp.gmail.com with ESMTPSA id l1sm5667385pje.9.2020.03.20.12.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 12:23:43 -0700 (PDT)
Date:   Fri, 20 Mar 2020 12:23:42 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs-progs: Remove support for
 BTRFS_SUBVOL_CREATE_ASYNC
Message-ID: <20200320192342.GA32817@vader>
References: <20200316092836.29091-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316092836.29091-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 16, 2020 at 11:28:36AM +0200, Nikolay Borisov wrote:
> Kernel has removed support for this feature in 5.7 so let's remove
> support from progs as well.

Built and passed tests on my machine. A few very trivial nits below,
otherwise:

Reviewed-by: Omar Sandoval <osandov@fb.com>

Thanks!

> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
> Changelog v2:
>  * Removed async mentions in README.md
>  * Changed docs in libbtrfsutil/btrfsutil.h to mention async is unused.
>  * Removed tests using async_
>  * Changed python module's doc to mention the async_ parameter is unused.
> 
>  ioctl.h                                     |  4 +--
>  libbtrfsutil/README.md                      | 14 ++------
>  libbtrfsutil/btrfs.h                        |  4 +--
>  libbtrfsutil/btrfsutil.h                    | 18 +++++-----
>  libbtrfsutil/python/module.c                |  6 ++--
>  libbtrfsutil/python/tests/test_subvolume.py | 12 ++-----
>  libbtrfsutil/subvolume.c                    | 38 ++++++---------------
>  7 files changed, 29 insertions(+), 67 deletions(-)

[snip]

> diff --git a/libbtrfsutil/btrfsutil.h b/libbtrfsutil/btrfsutil.h
> index 0442af6ed67f..47d4cf1e5fe9 100644
> --- a/libbtrfsutil/btrfsutil.h
> +++ b/libbtrfsutil/btrfsutil.h
> @@ -366,7 +366,7 @@ struct btrfs_util_qgroup_inherit;
>   * btrfs_util_create_subvolume() - Create a new subvolume.
>   * @path: Where to create the subvolume.
>   * @flags: Must be zero.
> - * @async_transid: If not NULL, create the subvolume asynchronously (i.e.,
> + * @unused: No longer used
>   * without waiting for it to commit it to disk) and return the transaction ID
>   * that it was created in. This transaction ID can be waited on with
>   * btrfs_util_wait_sync().

These three lines need to be deleted, too.

> @@ -375,7 +375,7 @@ struct btrfs_util_qgroup_inherit;
>   * Return: %BTRFS_UTIL_OK on success, non-zero error code on failure.
>   */
>  enum btrfs_util_error btrfs_util_create_subvolume(const char *path, int flags,
> -						  uint64_t *async_transid,
> +						  uint64_t *unused,
>  						  struct btrfs_util_qgroup_inherit *qgroup_inherit);
> 
>  /**
> @@ -385,7 +385,7 @@ enum btrfs_util_error btrfs_util_create_subvolume(const char *path, int flags,
>   * should be created.
>   * @name: Name of the subvolume to create.
>   * @flags: See btrfs_util_create_subvolume().
> - * @async_transid: See btrfs_util_create_subvolume().
> + * @unused: See btrfs_util_create_subvolume().
>   * @qgroup_inherit: See btrfs_util_create_subvolume().
>   *
>   * Return: %BTRFS_UTIL_OK on success, non-zero error code on failure.
> @@ -393,7 +393,7 @@ enum btrfs_util_error btrfs_util_create_subvolume(const char *path, int flags,
>  enum btrfs_util_error btrfs_util_create_subvolume_fd(int parent_fd,
>  						     const char *name,
>  						     int flags,
> -						     uint64_t *async_transid,
> +						     uint64_t *unused,
>  						     struct btrfs_util_qgroup_inherit *qgroup_inherit);
> 
>  /**
> @@ -418,7 +418,7 @@ enum btrfs_util_error btrfs_util_create_subvolume_fd(int parent_fd,
>   * @source: Path of the existing subvolume to snapshot.
>   * @path: Where to create the snapshot.
>   * @flags: Bitmask of BTRFS_UTIL_CREATE_SNAPSHOT_* flags.
> - * @async_transid: See btrfs_util_create_subvolume(). If
> + * @unused: See btrfs_util_create_subvolume(). If
>   * %BTRFS_UTIL_CREATE_SNAPSHOT_RECURSIVE was in @flags, then this will contain
>   * the largest transaction ID of all created subvolumes.

The "If ..." description needs to go away, too.

>   * @qgroup_inherit: See btrfs_util_create_subvolume().
> @@ -427,7 +427,7 @@ enum btrfs_util_error btrfs_util_create_subvolume_fd(int parent_fd,
>   */
>  enum btrfs_util_error btrfs_util_create_snapshot(const char *source,
>  						 const char *path, int flags,
> -						 uint64_t *async_transid,
> +						 uint64_t *unused,
>  						 struct btrfs_util_qgroup_inherit *qgroup_inherit);
> 
>  /**
> @@ -435,7 +435,7 @@ enum btrfs_util_error btrfs_util_create_snapshot(const char *source,
>   */
>  enum btrfs_util_error btrfs_util_create_snapshot_fd(int fd, const char *path,
>  						    int flags,
> -						    uint64_t *async_transid,
> +						    uint64_t *unused,
>  						    struct btrfs_util_qgroup_inherit *qgroup_inherit);
> 
>  /**
> @@ -446,13 +446,13 @@ enum btrfs_util_error btrfs_util_create_snapshot_fd(int fd, const char *path,
>   * be created.
>   * @name: Name of the snapshot to create.
>   * @flags: See btrfs_util_create_snapshot().
> - * @async_transid: See btrfs_util_create_snapshot().
> + * @unused: See btrfs_util_create_snapshot().
>   * @qgroup_inherit: See btrfs_util_create_snapshot().
>   */
>  enum btrfs_util_error btrfs_util_create_snapshot_fd2(int fd, int parent_fd,
>  						     const char *name,
>  						     int flags,
> -						     uint64_t *async_transid,
> +						     uint64_t *unused,
>  						     struct btrfs_util_qgroup_inherit *qgroup_inherit);
> 
>  /**
> diff --git a/libbtrfsutil/python/module.c b/libbtrfsutil/python/module.c
> index f8260c84ec76..a8aa50bdd7ed 100644
> --- a/libbtrfsutil/python/module.c
> +++ b/libbtrfsutil/python/module.c
> @@ -237,8 +237,7 @@ static PyMethodDef btrfsutil_methods[] = {
>  	 "Create a new subvolume.\n\n"
>  	 "Arguments:\n"
>  	 "path -- string, bytes, or path-like object\n"
> -	 "async_ -- create the subvolume without waiting for it to commit to\n"
> -	 "disk and return the transaction ID\n"
> +	 "async_ -- No longer used\n"

Lowercase "no" for consistency with the other docstrings.

>  	 "qgroup_inherit -- optional QgroupInherit object of qgroups to\n"
>  	 "inherit from"},
>  	{"create_snapshot", (PyCFunction)create_snapshot,
> @@ -251,8 +250,7 @@ static PyMethodDef btrfsutil_methods[] = {
>  	 "path -- string, bytes, or path-like object\n"
>  	 "recursive -- also snapshot child subvolumes\n"
>  	 "read_only -- create a read-only snapshot\n"
> -	 "async_ -- create the subvolume without waiting for it to commit to\n"
> -	 "disk and return the transaction ID\n"
> +	 "async_ -- No longer used\n"

Ditto
