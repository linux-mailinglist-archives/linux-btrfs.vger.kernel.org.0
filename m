Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A114C6DE924
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Apr 2023 03:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjDLBwC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 11 Apr 2023 21:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjDLBv6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Apr 2023 21:51:58 -0400
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EA344B9
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Apr 2023 18:51:55 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id gb34so25225634ejc.12
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Apr 2023 18:51:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681264314; x=1683856314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YMheL8mbMw7DdDaGkFdmgcZJzCS3MC0I5xFQw/R6yxA=;
        b=KPt9yPg7ZtzEYgoyA2qFFJJHSvttSf/OcT//2he5VHkC0B1S52ZCYEFZk1GLlgjugJ
         qEw1DixAkn1G49A9oDT36KEa2J0Q6lLsQcOHU+tLdj/qyqdknzV03AHHNj78BNJXtz4W
         sALWMQgoHqyZi6e4xhbLpLA1Ix6JmbGT/PEUtXrDczq/SQ2Vp07Fw8E4uZRiJkktoWD8
         h1ebUVNfSeP5NE939SCOaRYEsW0g3L+iXK/mo/5yGQEOaZ+EbY3x0vIKqIaNoxqt6Ogj
         B7axwhvNkWjcQ8xuHQpDzIsGCo0gRApeq5u6QJWXYrramX3N1EH6nEdU8mfxP+6Wmh5n
         Anfg==
X-Gm-Message-State: AAQBX9cFqdGXSy5gtSJ8ta6VrZnSxpV8KBlBQUHh/2ZyKRPucq6VCZkf
        Dymoy3KPu8PrFGVNDaFMDHqns5MfiWrN1BCy
X-Google-Smtp-Source: AKy350ZKlIjDpdeDGUOWF1OBreXFuD3kA68/hebsmQ6y+LgxKL5MepbIOUJ5CpSCiSDPhgMgfDGQ6A==
X-Received: by 2002:a17:906:16cf:b0:94b:95ae:bd3d with SMTP id t15-20020a17090616cf00b0094b95aebd3dmr1069664ejd.22.1681264313961;
        Tue, 11 Apr 2023 18:51:53 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id rk18-20020a170907215200b0094a77168584sm2981842ejb.125.2023.04.11.18.51.53
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 18:51:53 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-94a342f3ebcso239796066b.0
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Apr 2023 18:51:53 -0700 (PDT)
X-Received: by 2002:a50:9b56:0:b0:4fb:c8e3:1ae2 with SMTP id
 a22-20020a509b56000000b004fbc8e31ae2mr6149397edj.3.1681264313364; Tue, 11 Apr
 2023 18:51:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1681180159.git.wqu@suse.com> <1ca85433fb63d9c9cf66da72e407381c0146b76c.1681180159.git.wqu@suse.com>
In-Reply-To: <1ca85433fb63d9c9cf66da72e407381c0146b76c.1681180159.git.wqu@suse.com>
From:   Neal Gompa <neal@gompa.dev>
Date:   Tue, 11 Apr 2023 21:51:17 -0400
X-Gmail-Original-Message-ID: <CAEg-Je_V7TNj1U5_7ODu4GuAEgUqy_3V_2ipdHu=hh8FsRvs9A@mail.gmail.com>
Message-ID: <CAEg-Je_V7TNj1U5_7ODu4GuAEgUqy_3V_2ipdHu=hh8FsRvs9A@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs-progs: mkfs: make -R|--runtime-features option deprecated
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 10, 2023 at 10:42 PM Qu Wenruo <wqu@suse.com> wrote:
>
> The option -R|--runtime-features is introduced to support features that
> doesn't result a full incompat flag change, thus things like
> free-space-tree and quota features are put here.
>
> But to end users, such separation of features is not helpful and can be
> sometimes confusing.
>
> Thus we're already migrating those runtime features into -O|--features
> option under experimental builds.
>
> I believe this is the proper time to move those runtime features into
> -O|--features option, and mark the -R|--runtime-features option
> deprecated.
>
> For now we still keep the old option as for compatibility purposes.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  Documentation/mkfs.btrfs.rst | 25 ++++---------------------
>  common/fsfeatures.c          |  6 ------
>  mkfs/main.c                  |  3 ++-
>  3 files changed, 6 insertions(+), 28 deletions(-)
>
> diff --git a/Documentation/mkfs.btrfs.rst b/Documentation/mkfs.btrfs.rst
> index ba7227b31f72..e80f4c5c83ee 100644
> --- a/Documentation/mkfs.btrfs.rst
> +++ b/Documentation/mkfs.btrfs.rst
> @@ -161,18 +161,6 @@ OPTIONS
>
>                  $ mkfs.btrfs -O list-all
>
> --R|--runtime-features <feature1>[,<feature2>...]
> -        A list of features that be can enabled at mkfs time, otherwise would have
> -        to be turned on on a mounted filesystem.
> -        To disable a feature, prefix it with *^*.
> -
> -        See section *RUNTIME FEATURES* for more details.  To see all available
> -        runtime features that **mkfs.btrfs** supports run:
> -
> -        .. code-block:: bash
> -
> -                $ mkfs.btrfs -R list-all
> -
>  -f|--force
>          Forcibly overwrite the block devices when an existing filesystem is detected.
>          By default, **mkfs.btrfs** will utilize *libblkid* to check for any known
> @@ -199,6 +187,10 @@ OPTIONS
>  -l|--leafsize <size>
>          Removed in 6.0, used to be alias for *--nodesize*.
>
> +-R|--runtime-features <feature1>[,<feature2>...]
> +        Removed in 6.4, used to specify features not affecting on-disk format.
> +        Now all such features are merged into `-O|--features` option.
> +
>  SIZE UNITS
>  ----------
>
> @@ -279,15 +271,6 @@ zoned
>          see *ZONED MODE* in :doc:`btrfs(5)<btrfs-man5>`, the mode is automatically selected when
>          a zoned device is detected
>
> -
> -RUNTIME FEATURES
> -----------------
> -
> -Features that are typically enabled on a mounted filesystem, e.g. by a mount
> -option or by an ioctl. Some of them can be enabled early, at mkfs time.  This
> -applies to features that need to be enabled once and then the status is
> -permanent, this does not replace mount options.
> -
>  quota
>          (kernel support since 3.4)
>
> diff --git a/common/fsfeatures.c b/common/fsfeatures.c
> index 169e47e92582..4aca96f6e4fe 100644
> --- a/common/fsfeatures.c
> +++ b/common/fsfeatures.c
> @@ -99,7 +99,6 @@ static const struct btrfs_feature mkfs_features[] = {
>                 VERSION_NULL(default),
>                 .desc           = "mixed data and metadata block groups"
>         },
> -#if EXPERIMENTAL
>         {
>                 .name           = "quota",
>                 .runtime_flag   = BTRFS_FEATURE_RUNTIME_QUOTA,
> @@ -109,7 +108,6 @@ static const struct btrfs_feature mkfs_features[] = {
>                 VERSION_NULL(default),
>                 .desc           = "quota support (qgroups)"
>         },
> -#endif
>         {
>                 .name           = "extref",
>                 .incompat_flag  = BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF,
> @@ -143,7 +141,6 @@ static const struct btrfs_feature mkfs_features[] = {
>                 VERSION_TO_STRING2(default, 5,15),
>                 .desc           = "no explicit hole extents for files"
>         },
> -#if EXPERIMENTAL
>         {
>                 .name           = "free-space-tree",
>                 .compat_ro_flag = BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |
> @@ -154,7 +151,6 @@ static const struct btrfs_feature mkfs_features[] = {
>                 VERSION_TO_STRING2(default, 5,15),
>                 .desc           = "free space tree (space_cache=v2)"
>         },
> -#endif
>         {
>                 .name           = "raid1c34",
>                 .incompat_flag  = BTRFS_FEATURE_INCOMPAT_RAID1C34,
> @@ -185,8 +181,6 @@ static const struct btrfs_feature mkfs_features[] = {
>                 VERSION_NULL(default),
>                 .desc           = "block group tree to reduce mount time"
>         },
> -#endif
> -#if EXPERIMENTAL
>         {
>                 .name           = "extent-tree-v2",
>                 .incompat_flag  = BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2,

Shouldn't the removal of the EXPERIMENTAL tags be a separate commit?
It seems unrelated and the commit message doesn't say anything about
this.

> diff --git a/mkfs/main.c b/mkfs/main.c
> index f5e34cbda612..78cc2b598b25 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -424,7 +424,6 @@ static const char * const mkfs_usage[] = {
>         OPTLINE("-n|--nodesize SIZE", "size of btree nodes"),
>         OPTLINE("-s|--sectorsize SIZE", "data block size (may not be mountable by current kernel)"),
>         OPTLINE("-O|--features LIST", "comma separated list of filesystem features (use '-O list-all' to list features)"),
> -       OPTLINE("-R|--runtime-features LIST", "comma separated list of runtime features (use '-R list-all' to list runtime features)"),
>         OPTLINE("-L|--label LABEL", "set the filesystem label"),
>         OPTLINE("-U|--uuid UUID", "specify the filesystem UUID (must be unique)"),
>         "Creation:",
> @@ -440,6 +439,7 @@ static const char * const mkfs_usage[] = {
>         OPTLINE("--help", "print this help and exit"),
>         "Deprecated:",
>         OPTLINE("-l|--leafsize SIZE", "removed in 6.0, use --nodesize"),
> +       OPTLINE("-R|--runtime-features LIST", "removed in 6.4, use -O|--features"),
>         NULL
>  };
>
> @@ -1140,6 +1140,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>                                 char *orig = strdup(optarg);
>                                 char *tmp = orig;
>
> +                               warning("runtime features are deprecated, use -O|--features instead.");
>                                 tmp = btrfs_parse_runtime_features(tmp,
>                                                 &features);
>                                 if (tmp) {
> --
> 2.39.2
>


-- 
真実はいつも一つ！/ Always, there's only one truth!
