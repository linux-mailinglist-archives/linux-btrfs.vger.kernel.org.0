Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A766DE90E
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Apr 2023 03:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjDLBqQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 11 Apr 2023 21:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjDLBqP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Apr 2023 21:46:15 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD6F44B9
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Apr 2023 18:46:13 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id f26so18908019ejb.1
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Apr 2023 18:46:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681263971; x=1683855971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0I+YFqvyaOfE/FwTjIy3+6YaLAdKCfSWVCf1X2B2fo=;
        b=AVp3P+w4vvtbLabisMjmahdo/hNPq6i4mbCjPWweZv7ZCAicIps/Dfp6fvAcDnvC+X
         1pddnOqhJw7n7h5PE5B+tMulPtKe4pHdD1Zt8eHdG75cjNcl2gw7w/Fb62Kz3sGscpJP
         gF80JDfzqIp8DoOjyvkBkndTWoAk/ahRIHchMrFYD+8DRA8ugB3q+ASz4dvV5HMhhnfZ
         iOBWZf9gQEfw7x91liGIIfsKvT4CjF898A0Gbq5JLVLoSMj/LFzPrFP39prIZqqwFxaN
         r/0IVvy+TX0TmmurD4Q5LjbmT1qCKpdhmHm33QAkYHW5OesTpjbmRhHOOV8Yg0TbtzFl
         l/Ng==
X-Gm-Message-State: AAQBX9dUtgVPokHf7DUPlv7yTMy1Rp2Mce6u7kifa4oRyWRf/U2KZIsr
        vDwzxjb1yO+oRqq1xd4EVVuV7mqyDYdCwYOM
X-Google-Smtp-Source: AKy350YQAyjPCtQ8O2BpBdeCL4R3VaUKnbd7ImEMrEiuHwldlS3OjIs+7vkgBkie8QPjSalXTz1Ddw==
X-Received: by 2002:a17:907:76eb:b0:93b:2d0b:b60e with SMTP id kg11-20020a17090776eb00b0093b2d0bb60emr4838941ejc.74.1681263971376;
        Tue, 11 Apr 2023 18:46:11 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id hd10-20020a170907968a00b008d606b1bbb1sm6673862ejc.9.2023.04.11.18.46.10
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 18:46:10 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-94a34d38291so184780466b.3
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Apr 2023 18:46:10 -0700 (PDT)
X-Received: by 2002:a50:954f:0:b0:4fc:ebe2:2fc9 with SMTP id
 v15-20020a50954f000000b004fcebe22fc9mr7494028eda.3.1681263970672; Tue, 11 Apr
 2023 18:46:10 -0700 (PDT)
MIME-Version: 1.0
References: <61e8946ae040075ce2fe378e39b500c4ac97e8a3.1681151504.git.sweettea-kernel@dorminy.me>
In-Reply-To: <61e8946ae040075ce2fe378e39b500c4ac97e8a3.1681151504.git.sweettea-kernel@dorminy.me>
From:   Neal Gompa <neal@gompa.dev>
Date:   Tue, 11 Apr 2023 21:45:34 -0400
X-Gmail-Original-Message-ID: <CAEg-Je_BJpdr+K8rA_NHzykBRT6qmGjzfei3NCzjWBW2kVObmg@mail.gmail.com>
Message-ID: <CAEg-Je_BJpdr+K8rA_NHzykBRT6qmGjzfei3NCzjWBW2kVObmg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: don't commit transaction for every subvol create
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@meta.com
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

On Tue, Apr 11, 2023 at 3:22 PM Sweet Tea Dorminy
<sweettea-kernel@dorminy.me> wrote:
>
> Recently a Meta-internal workload encountered subvolume creation taking
> up to 2s each, significantly slower than directory creation. As they
> were hoping to be able to use subvolumes instead of directories, and
> were looking to create hundreds, this was a significant issue. After
> Josef investigated, it turned out to be due to the transaction commit
> currently performed at the end of subvolume creation.
>
> This change improves the workload by not doing transaction commit for every
> subvolume creation, and merely requiring a transaction commit on fsync.
> In the worst case, of doing a subvolume create and fsync in a loop, this
> should require an equal amount of time to the current scheme; and in the
> best case, the internal workload creating hundreds of subvols before
> fsyncing is greatly improved.
>
> While it would be nice to be able to use the log tree and use the normal
> fsync path, logtree replay can't deal with new subvolume inodes
> presently.
>
> It's possible that there's some reason that the transaction commit is
> necessary for correctness during subvolume creation; however,
> git logs indicate that the commit dates back to the beginning of
> subvolume creation, and there are no notes on why it would be necessary.
>
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> ---
>  fs/btrfs/ioctl.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 25833b4eeaf5..a6f1ee2dc1b9 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -647,6 +647,8 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
>         }
>         trans->block_rsv = &block_rsv;
>         trans->bytes_reserved = block_rsv.size;
> +       /* tree log can't currently deal with an inode which is a new root */
> +       btrfs_set_log_full_commit(trans);
>
>         ret = btrfs_qgroup_inherit(trans, 0, objectid, inherit);
>         if (ret)
> @@ -755,10 +757,7 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
>         trans->bytes_reserved = 0;
>         btrfs_subvolume_release_metadata(root, &block_rsv);
>
> -       if (ret)
> -               btrfs_end_transaction(trans);
> -       else
> -               ret = btrfs_commit_transaction(trans);
> +       btrfs_end_transaction(trans);
>  out_new_inode_args:
>         btrfs_new_inode_args_destroy(&new_inode_args);
>  out_inode:
> --
> 2.40.0
>

Wouldn't the consequence of this mean that we lose some guarantees
around subvolume creation? That is, without it being committed, we
would have a window in which the subvolume and data can be written
without being written to disk? If so, how large is that window?


-- 
真実はいつも一つ！/ Always, there's only one truth!
