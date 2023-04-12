Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E786DF640
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Apr 2023 14:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjDLM4p convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 12 Apr 2023 08:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbjDLMys (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Apr 2023 08:54:48 -0400
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FBD8697
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Apr 2023 05:54:17 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-94a35b0ec77so262351266b.3
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Apr 2023 05:54:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681303967; x=1683895967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2FeG+qsvchFGjqVkyHhuxXCvN45NZPFe2I9HSZzTr8M=;
        b=LUYh6I1a07cMNy/76/QS54n4RnTHmmWF8uY2my6v0IyXeNrm69WTTx08om7/btXj7R
         925qjfMbCs89OylNrqjVJ5MlttPbL/s+Zjc40CHgbymwZsJjoWzyfk2CNLmT2YDYA8aj
         vjPUuT22yCnxoUKyO4JXN5W1MMWxmh10xNKSnqmJk8gmlEKvrQljX6T4hJLu+XdNyYcg
         znVh+5q8SDPEFbM38AypWk/FJAKrsMKbK+UP14fCVC89ul7c07nmpsuaOOVPpznUPhYp
         Bt0DyQdvxgAR95ExuP+eYySZzIqDbpNnXbJBJRxNuOmLs+6NjP5ZncI7KhfE7nvXVlAC
         TwOw==
X-Gm-Message-State: AAQBX9eYJXAvn5Bn1OwGEU113OajLPO0aiJRWRNlu+JMzjuhYq6AOLyp
        g5/2sRs1l8vZ8ag5Lnhw56JqFXEOrmGf/g==
X-Google-Smtp-Source: AKy350ZhrAlEOEYlpNVSEhVGD8fDKPuuyWRw1r62hZ7OzSgEZJNCo7i3MhQnqoTRrMVFE13tNZjoww==
X-Received: by 2002:aa7:d54b:0:b0:504:8986:58da with SMTP id u11-20020aa7d54b000000b00504898658damr2039439edr.42.1681303967372;
        Wed, 12 Apr 2023 05:52:47 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id t11-20020a508d4b000000b005027d31615dsm6848173edt.62.2023.04.12.05.52.47
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 05:52:47 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id sg7so39950457ejc.9
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Apr 2023 05:52:47 -0700 (PDT)
X-Received: by 2002:a17:906:794c:b0:94e:4697:337a with SMTP id
 l12-20020a170906794c00b0094e4697337amr1593251ejo.0.1681303967085; Wed, 12 Apr
 2023 05:52:47 -0700 (PDT)
MIME-Version: 1.0
References: <db16bb361ef4fb39c71c236dd3985ed88b85ecd0.1681282065.git.wqu@suse.com>
In-Reply-To: <db16bb361ef4fb39c71c236dd3985ed88b85ecd0.1681282065.git.wqu@suse.com>
From:   Neal Gompa <neal@gompa.dev>
Date:   Wed, 12 Apr 2023 08:52:10 -0400
X-Gmail-Original-Message-ID: <CAEg-Je_LPwaV68CO-SZvmPtV6qyH6-fGP2WkduniZ-95LAkzMA@mail.gmail.com>
Message-ID: <CAEg-Je_LPwaV68CO-SZvmPtV6qyH6-fGP2WkduniZ-95LAkzMA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: remove unused raid56 functions which were
 dedicated for scrub
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

On Wed, Apr 12, 2023 at 3:16 AM Qu Wenruo <wqu@suse.com> wrote:
>
> Since the scrub rework, the following raid56 functions are no longer
> called:
>
> - raid56_add_scrub_pages()
> - raid56_alloc_missing_rbio()
> - raid56_submit_missing_rbio()
>
> Those functions are all utilized by scrub to handle missing device cases
> for RAID56.
>
> However the new scrub code handle them in a completely different method:
>
> - If it's data stripes, go recovery path through btrfs_submit_bio()
> - If it's P/Q stripes, it would be handled through
>   raid56_parity_submit_scrub_rbio()
>   And that function would handle dev-replace and repair properly.
>
> Thus we can safely remove those functions.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/raid56.c | 47 -----------------------------------------------
>  fs/btrfs/raid56.h |  7 -------
>  2 files changed, 54 deletions(-)
>
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index ed6343f566d4..2fab37f062de 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -2376,23 +2376,6 @@ struct btrfs_raid_bio *raid56_parity_alloc_scrub_rbio(struct bio *bio,
>         return rbio;
>  }
>
> -/* Used for both parity scrub and missing. */
> -void raid56_add_scrub_pages(struct btrfs_raid_bio *rbio, struct page *page,
> -                           unsigned int pgoff, u64 logical)
> -{
> -       const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
> -       int stripe_offset;
> -       int index;
> -
> -       ASSERT(logical >= rbio->bioc->full_stripe_logical);
> -       ASSERT(logical + sectorsize <= rbio->bioc->full_stripe_logical +
> -                                      BTRFS_STRIPE_LEN * rbio->nr_data);
> -       stripe_offset = (int)(logical - rbio->bioc->full_stripe_logical);
> -       index = stripe_offset / sectorsize;
> -       rbio->bio_sectors[index].page = page;
> -       rbio->bio_sectors[index].pgoff = pgoff;
> -}
> -
>  /*
>   * We just scrub the parity that we have correct data on the same horizontal,
>   * so we needn't allocate all pages for all the stripes.
> @@ -2764,33 +2747,3 @@ void raid56_parity_submit_scrub_rbio(struct btrfs_raid_bio *rbio)
>         if (!lock_stripe_add(rbio))
>                 start_async_work(rbio, scrub_rbio_work_locked);
>  }
> -
> -/* The following code is used for dev replace of a missing RAID 5/6 device. */
> -
> -struct btrfs_raid_bio *
> -raid56_alloc_missing_rbio(struct bio *bio, struct btrfs_io_context *bioc)
> -{
> -       struct btrfs_fs_info *fs_info = bioc->fs_info;
> -       struct btrfs_raid_bio *rbio;
> -
> -       rbio = alloc_rbio(fs_info, bioc);
> -       if (IS_ERR(rbio))
> -               return NULL;
> -
> -       rbio->operation = BTRFS_RBIO_REBUILD_MISSING;
> -       bio_list_add(&rbio->bio_list, bio);
> -       /*
> -        * This is a special bio which is used to hold the completion handler
> -        * and make the scrub rbio is similar to the other types
> -        */
> -       ASSERT(!bio->bi_iter.bi_size);
> -
> -       set_rbio_range_error(rbio, bio);
> -
> -       return rbio;
> -}
> -
> -void raid56_submit_missing_rbio(struct btrfs_raid_bio *rbio)
> -{
> -       start_async_work(rbio, recover_rbio_work);
> -}
> diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
> index 6583c225b1bd..0f7f31c8cb98 100644
> --- a/fs/btrfs/raid56.h
> +++ b/fs/btrfs/raid56.h
> @@ -187,19 +187,12 @@ void raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
>                            int mirror_num);
>  void raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc);
>
> -void raid56_add_scrub_pages(struct btrfs_raid_bio *rbio, struct page *page,
> -                           unsigned int pgoff, u64 logical);
> -
>  struct btrfs_raid_bio *raid56_parity_alloc_scrub_rbio(struct bio *bio,
>                                 struct btrfs_io_context *bioc,
>                                 struct btrfs_device *scrub_dev,
>                                 unsigned long *dbitmap, int stripe_nsectors);
>  void raid56_parity_submit_scrub_rbio(struct btrfs_raid_bio *rbio);
>
> -struct btrfs_raid_bio *
> -raid56_alloc_missing_rbio(struct bio *bio, struct btrfs_io_context *bioc);
> -void raid56_submit_missing_rbio(struct btrfs_raid_bio *rbio);
> -
>  int btrfs_alloc_stripe_hash_table(struct btrfs_fs_info *info);
>  void btrfs_free_stripe_hash_table(struct btrfs_fs_info *info);
>
> --
> 2.39.2
>

LGTM.

Reviewed-by: Neal Gompa <neal@gompa.dev>



--
真実はいつも一つ！/ Always, there's only one truth!
