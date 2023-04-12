Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24DD6DE915
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Apr 2023 03:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjDLBtu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 11 Apr 2023 21:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjDLBtu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Apr 2023 21:49:50 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E633213A
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Apr 2023 18:49:48 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id jg21so24693321ejc.2
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Apr 2023 18:49:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681264187; x=1683856187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+OgarVTCYclY/QOm21YIoJ8ZT4IQznM36KDPGO7llM=;
        b=AfEYaEQhEv9qlBqRbuIUSxQ4d3L4fH7mkKXBtJa3IYjCmYjMC8limouwL9CH+nhSAt
         DhrQ0QkCDzHKiUrvZXOH9SUCl0OU/miI2UgrfZIsFpZc53CjBt3wBFyI/dsHb1A0B/kB
         2Nmh9IWayNzeZwn9iLDcsRj2p+R6INEiqAYzK1EgtzUyqlFggsY2bJoEMChrU34vy+Yi
         s2Pn/7FIWdWJmbax0VlKmfDPUMm911+vdwdH+kjMchzdZcpIve0lGWeB7qsuPgwptgKT
         79PE/DAmERjqGNd1FPES5UvUpHJ7B5spQW98d0UKk9WCWJQdPziOuOygYp6wGbcAeeLH
         H4qQ==
X-Gm-Message-State: AAQBX9ci72cXnP6hvOHtMVlMvr97OagjrlJd12gNQzQmRnkIYyk7fdVb
        A20m+jcWYF1kAx/jEESDOha78cafKvlBuExk
X-Google-Smtp-Source: AKy350YnvlFbYBhH67ZZKtYZyz0nyQ4p9jGtLhQ38qwlbpKyX2CIJ8s+avo0Odsn+dbfZCoqntjmaw==
X-Received: by 2002:a17:906:1098:b0:94a:8f3a:1a77 with SMTP id u24-20020a170906109800b0094a8f3a1a77mr498010eju.8.1681264186635;
        Tue, 11 Apr 2023 18:49:46 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id s21-20020a1709060c1500b0094a85f6074bsm2742712ejf.33.2023.04.11.18.49.46
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 18:49:46 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id sg7so36439343ejc.9
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Apr 2023 18:49:46 -0700 (PDT)
X-Received: by 2002:a17:906:a990:b0:93d:6382:d5b with SMTP id
 jr16-20020a170906a99000b0093d63820d5bmr5468512ejb.9.1681264186345; Tue, 11
 Apr 2023 18:49:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1681180159.git.wqu@suse.com> <4cc5819796bd2af6de78b7a1919b4f8ed02b985f.1681180159.git.wqu@suse.com>
In-Reply-To: <4cc5819796bd2af6de78b7a1919b4f8ed02b985f.1681180159.git.wqu@suse.com>
From:   Neal Gompa <neal@gompa.dev>
Date:   Tue, 11 Apr 2023 21:49:10 -0400
X-Gmail-Original-Message-ID: <CAEg-Je9T4MHtshrfpiTuEHZmbwaRWtJP9RUF_CKyQQOwQftxuA@mail.gmail.com>
Message-ID: <CAEg-Je9T4MHtshrfpiTuEHZmbwaRWtJP9RUF_CKyQQOwQftxuA@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs-progs: move block-group-tree out of
 experimental features
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 10, 2023 at 10:37 PM Qu Wenruo <wqu@suse.com> wrote:
>
> The feedback from the community on block group tree is very positive,
> the only complain is, end users need to recompile btrfs-progs with
> experimental features to enjoy the new feature.
>
> So let's move it out of experimental features and let more people enjoy
> faster mount speed.
>
> Also change the option of btrfstune, from `-b` to
> `--enable-block-group-tree` to avoid short option.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  Documentation/btrfs-man5.rst |  6 ++++++
>  Documentation/btrfstune.rst  |  4 ++--
>  Documentation/mkfs.btrfs.rst |  5 +++++
>  common/fsfeatures.c          |  4 +---
>  tune/main.c                  | 18 ++++++++----------
>  5 files changed, 22 insertions(+), 15 deletions(-)
>
> diff --git a/Documentation/btrfs-man5.rst b/Documentation/btrfs-man5.rst
> index b50064fe9931..c625a9585457 100644
> --- a/Documentation/btrfs-man5.rst
> +++ b/Documentation/btrfs-man5.rst
> @@ -66,6 +66,12 @@ big_metadata
>          the filesystem uses *nodesize* for metadata blocks, this can be bigger than the
>          page size
>
> +block_group_tree
> +        (since: 6.1)
> +
> +        block group item representation using a dedicated b-tree, this can greatly
> +        reduce mount time for large filesystems.
> +
>  compress_lzo
>          (since: 2.6.38)
>
> diff --git a/Documentation/btrfstune.rst b/Documentation/btrfstune.rst
> index f4400f1f527a..c84c1e7e7092 100644
> --- a/Documentation/btrfstune.rst
> +++ b/Documentation/btrfstune.rst
> @@ -24,8 +24,8 @@ means.  Please refer to the *FILESYSTEM FEATURES* in :doc:`btrfs(5)<btrfs-man5>`
>  OPTIONS
>  -------
>
> --b
> -        (since kernel 6.1, needs experimental build of btrfs-progs)
> +--enable-block-group-tree
> +        (since kernel 6.1)
>          Enable block group tree feature (greatly reduce mount time),
>          enabled by mkfs feature *block-group-tree*.
>

I think it would make more sense to declare version 6.3 as the version
here, since it would effectively be the first version where it's not
experimental anymore.

> diff --git a/Documentation/mkfs.btrfs.rst b/Documentation/mkfs.btrfs.rst
> index e80f4c5c83ee..fe52f4406bf2 100644
> --- a/Documentation/mkfs.btrfs.rst
> +++ b/Documentation/mkfs.btrfs.rst
> @@ -283,6 +283,11 @@ free-space-tree
>          Enable the free space tree (mount option *space_cache=v2*) for persisting the
>          free space cache.
>
> +block-group-tree
> +        (kernel support since 6.1)
> +
> +        Enable the block group tree to greatly reduce mount time for large filesystems.
> +

Ditto.

>  BLOCK GROUPS, CHUNKS, RAID
>  --------------------------
>
> diff --git a/common/fsfeatures.c b/common/fsfeatures.c
> index 4aca96f6e4fe..50500c652265 100644
> --- a/common/fsfeatures.c
> +++ b/common/fsfeatures.c
> @@ -171,7 +171,6 @@ static const struct btrfs_feature mkfs_features[] = {
>                 .desc           = "support zoned devices"
>         },
>  #endif
> -#if EXPERIMENTAL
>         {
>                 .name           = "block-group-tree",
>                 .compat_ro_flag = BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE,
> @@ -181,6 +180,7 @@ static const struct btrfs_feature mkfs_features[] = {
>                 VERSION_NULL(default),
>                 .desc           = "block group tree to reduce mount time"
>         },
> +#if EXPERIMENTAL
>         {
>                 .name           = "extent-tree-v2",
>                 .incompat_flag  = BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2,
> @@ -222,7 +222,6 @@ static const struct btrfs_feature runtime_features[] = {
>                 VERSION_TO_STRING2(default, 5,15),
>                 .desc           = "free space tree (space_cache=v2)"
>         },
> -#if EXPERIMENTAL
>         {
>                 .name           = "block-group-tree",
>                 .compat_ro_flag = BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE,
> @@ -232,7 +231,6 @@ static const struct btrfs_feature runtime_features[] = {
>                 VERSION_NULL(default),
>                 .desc           = "block group tree to reduce mount time"
>         },
> -#endif
>         /* Keep this one last */
>         {
>                 .name           = "list-all",
> diff --git a/tune/main.c b/tune/main.c
> index c5d2e37aef3d..f5a94cdbdb5f 100644
> --- a/tune/main.c
> +++ b/tune/main.c
> @@ -70,6 +70,7 @@ static const char * const tune_usage[] = {
>         OPTLINE("-x", "enable skinny metadata extent refs (mkfs: skinny-metadata)"),
>         OPTLINE("-n", "enable no-holes feature (mkfs: no-holes, more efficient sparse file representation)"),
>         OPTLINE("-S <0|1>", "set/unset seeding status of a device"),
> +       OPTLINE("--enable-block-group-tree", "enable block group tree (mkfs: block-group-tree, for less mount time)"),
>         "",
>         "UUID changes:",
>         OPTLINE("-u", "rewrite fsid, use a random one"),
> @@ -84,7 +85,6 @@ static const char * const tune_usage[] = {
>         "",
>         "EXPERIMENTAL FEATURES:",
>         OPTLINE("--csum CSUM", "switch checksum for data and metadata to CSUM"),
> -       OPTLINE("-b", "enable block group tree (mkfs: block-group-tree, for less mount time)"),
>  #endif
>         NULL
>  };
> @@ -113,27 +113,22 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
>         btrfs_config_init();
>
>         while(1) {
> -               enum { GETOPT_VAL_CSUM = GETOPT_VAL_FIRST };
> +               enum { GETOPT_VAL_CSUM = GETOPT_VAL_FIRST,
> +                      GETOPT_VAL_ENABLE_BLOCK_GROUP_TREE };
>                 static const struct option long_options[] = {
>                         { "help", no_argument, NULL, GETOPT_VAL_HELP},
> +                       { "enable-block-group-tree", no_argument, NULL,
> +                               GETOPT_VAL_ENABLE_BLOCK_GROUP_TREE},
>  #if EXPERIMENTAL
>                         { "csum", required_argument, NULL, GETOPT_VAL_CSUM },
>  #endif
>                         { NULL, 0, NULL, 0 }
>                 };
> -#if EXPERIMENTAL
> -               int c = getopt_long(argc, argv, "S:rxfuU:nmM:b", long_options, NULL);
> -#else
>                 int c = getopt_long(argc, argv, "S:rxfuU:nmM:", long_options, NULL);
> -#endif
>
>                 if (c < 0)
>                         break;
>                 switch(c) {
> -               case 'b':
> -                       btrfs_warn_experimental("Feature: conversion to block-group-tree");
> -                       to_bg_tree = true;
> -                       break;
>                 case 'S':
>                         seeding_flag = 1;
>                         seeding_value = arg_strtou64(optarg);
> @@ -167,6 +162,9 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
>                         ctree_flags |= OPEN_CTREE_IGNORE_FSID_MISMATCH;
>                         change_metadata_uuid = 1;
>                         break;
> +               case GETOPT_VAL_ENABLE_BLOCK_GROUP_TREE:
> +                       to_bg_tree = true;
> +                       break;
>  #if EXPERIMENTAL
>                 case GETOPT_VAL_CSUM:
>                         btrfs_warn_experimental(
> --
> 2.39.2
>


-- 
真実はいつも一つ！/ Always, there's only one truth!
