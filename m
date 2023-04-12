Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77896E01DB
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Apr 2023 00:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjDLWf4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 12 Apr 2023 18:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDLWfz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Apr 2023 18:35:55 -0400
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3911040D3
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Apr 2023 15:35:54 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-502739add9dso5905160a12.0
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Apr 2023 15:35:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681338952; x=1683930952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ea/HperSRuFSFLQaF2loZwlb9bL4CYh+tMHVDYLkDI4=;
        b=iZOyHMmdmVtw64T1toaOChkuE/rfv4ZsMkHa7mq7uBTMkHMovEm1OLsaXVrW+WKF2I
         bGjhi4C92HwFpQ+bCbs6iU8PcQfYZfzYjDi9BkyPa9UH62K87b2R9QJjqQAkbjwKX+Ca
         xaKoMOzKQbz1MKHbHMXeGI1TqxOLJGYoK9aiN7/KnGYidSYb7eBnHX8Td6XhzvU1KS1S
         Eb6DLVr9awiq7bvbN1MZrYQ1RXshn/zq2ZmukoxoVSwp2vXpXsQXiLfb+WldYioSPeJk
         CbnuuswEf6HI71kwcrOXNdxt0EJtdo3xVBiX8HZrsvYfsXGy0yOBq7/Q2fDq04qfGU4S
         CQPw==
X-Gm-Message-State: AAQBX9dmxSS0Dwh4W65YPh4TzvKvjhUv3KwKsTBkN83jqSrOcoDgXSnK
        afHTWwCO8woDmSK4z/Wk3fdaPaCGZLzTyw==
X-Google-Smtp-Source: AKy350ZCuUkIsSyaSPhUXZ7YysZeShGYVj2Li5jyFYtP9RbNifYXdLjah5eWDG63L0J7H1WAa28XPw==
X-Received: by 2002:aa7:d88e:0:b0:504:b325:bd4d with SMTP id u14-20020aa7d88e000000b00504b325bd4dmr228468edq.12.1681338952316;
        Wed, 12 Apr 2023 15:35:52 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id n6-20020aa7db46000000b00504b203c4f1sm15799edt.40.2023.04.12.15.35.51
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 15:35:51 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id z9so5669335ejx.11
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Apr 2023 15:35:51 -0700 (PDT)
X-Received: by 2002:a17:906:db09:b0:926:5020:1421 with SMTP id
 xj9-20020a170906db0900b0092650201421mr232762ejb.9.1681338951553; Wed, 12 Apr
 2023 15:35:51 -0700 (PDT)
MIME-Version: 1.0
References: <61e8946ae040075ce2fe378e39b500c4ac97e8a3.1681151504.git.sweettea-kernel@dorminy.me>
In-Reply-To: <61e8946ae040075ce2fe378e39b500c4ac97e8a3.1681151504.git.sweettea-kernel@dorminy.me>
From:   Neal Gompa <neal@gompa.dev>
Date:   Wed, 12 Apr 2023 18:35:15 -0400
X-Gmail-Original-Message-ID: <CAEg-Je9a9EdsRmBBm6-+BQ-Fyc6cDEi4GqFHL4HaCocwqqJ94A@mail.gmail.com>
Message-ID: <CAEg-Je9a9EdsRmBBm6-+BQ-Fyc6cDEi4GqFHL4HaCocwqqJ94A@mail.gmail.com>
Subject: Re: [PATCH] btrfs: don't commit transaction for every subvol create
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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

Reviewed-by: Neal Gompa <neal@gompa.dev>


-- 
真実はいつも一つ！/ Always, there's only one truth!
