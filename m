Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8A16B0689
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Mar 2023 13:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjCHMCW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Mar 2023 07:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjCHMCV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Mar 2023 07:02:21 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD153193EA
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Mar 2023 04:02:18 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N4Qwg-1qbAJa1vja-011Ueh; Wed, 08
 Mar 2023 13:02:01 +0100
Message-ID: <7254ddb2-b072-6ae4-384d-a0bb630fd5e5@gmx.com>
Date:   Wed, 8 Mar 2023 20:01:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v7 04/13] btrfs: add support for inserting raid stripe
 extents
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "hch@infradead.org" <hch@infradead.org>
Cc:     David Sterba <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>
References: <cover.1677750131.git.johannes.thumshirn@wdc.com>
 <94293952cdc120b46edf82672af874b0877e1e83.1677750131.git.johannes.thumshirn@wdc.com>
 <3e2d5ede-fb00-3aa8-e55e-d088b8df9e60@gmx.com>
 <b5bfe1a9-51dc-2a94-5ebd-4673b896d5ea@wdc.com>
 <6eabe69c-3abe-255b-797f-7917cd6a33cd@gmx.com>
 <7bd4ce91-58e6-f68b-6d69-3f9deff39ff5@wdc.com>
 <ZACsVI3mfprrj4j6@infradead.org>
 <bde5197e-7313-5017-ffbf-a528559c38cb@wdc.com>
 <48acd511-7f69-4c42-44ea-a39973d57c98@gmx.com>
 <ZAIBQ0hzLTjOIYcr@infradead.org>
 <e9e7820b-9cf3-8361-cf3c-e4d59baa5b21@wdc.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <e9e7820b-9cf3-8361-cf3c-e4d59baa5b21@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ZMDAM1KO5TcodRomCGVind/qr9Tp5NQRwDZorSBD5WGnBD6/4yq
 KNJjLXVUGpDZmvwuaLkacgu9iIW06g96mbD0XvxtNSzbuQ0y6rngMqZ7X9lpWGfym9nLCqc
 2VA1TO61L8lAleTGqOXWiw64KkjfePAshN8ggZ3pWTQPU7hCO4mD6fgbpQgS4Tenc/rrk12
 AvZgj98/p2Sn2caisEwhw==
UI-OutboundReport: notjunk:1;M01:P0:BXKTlJeFe+I=;PL85njy7N5d1GYJIguRUzP9OwSe
 RTeq3XjZzfhyn1gkqht+YQBjS6Op3Uv36F7+Dn+h5xku0U9bFPZHVlwUkY6XNpzPPAM4xPLqu
 JKLFWuUjgwd3cCp4qoUT8XulYdH+xgqnAGsDNr/4YXhUfcwUqQgfid7lgsSCVOSLjYi5bYoaN
 XdMBnXRap4lzW+0DWFToiUhCcBnSkTJH+JbbohCrVUqeZzgyM9FUE4cyAszIhQf4k3ztmpc9y
 d+Im0pOE0lCqfnPyW1r1wiQLC25eDCzXGig3XG69OgpKUmnOY2p88sJPyiXbwrIy0SIhs1OL7
 YXppAC1VJnmktB1cTENJB+M6R+jQqw7vuXIQHOGf58sYUx3J7Nkx0YaIxErPtShk5IJjISHNu
 Ov6f/j8Hc5RqYCBHy5LEYIBjtBTDTV9f4tm/CkjfQUkak4YaGgskI8qSAiEN76AQLmIZcJvQS
 +f/Iy5w5KZoRtJqDR5g3oneEGQPnBgn1YzJcqLNVZvZEUyfHbK5qGutSsVWzZClEw3tawwBr4
 A3bboFnn+Nfx4emPfpk6WhIV3zulw8TnXpGwLtMrZTVjcaLojHGTQyIxduuLhO8utEiMELUG7
 vfCLPvUK1ODE5xAD4DV6B9N4zEgywBjyR88ho4O4A8dpsnGj4+Cf5ubb8NzYk+eNGY6nrCe7N
 BKz9gzQE5AvxFjdLJNrTjqj6OTUPmi92Kselp3FiM5WsWA8Q89DFRpKXVU4oDrMVgqygNsZFn
 wrsNbEPq2Rk1WYRiVcfO4maN6Q39PNtKYwQatySj477NVCAXQqqygXNLew3oswDoxZJwCS9tF
 n/fSu59bx32nH5OYum3svqErKNZwuhADChdgsjDItee8jsUlQKVnitavhyzSUSH2AviblxQY5
 WXIYnQTf1wKcM8Z1eV21s/GlRmqP4TFSPzUmDqqdpSwUWHR5fSv6ICpNvJPHGLmfuHi+XSxyV
 356PU+rvSZ42z1k9EH9Q0WxkBkU=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/8 17:11, Johannes Thumshirn wrote:
> On 03.03.23 15:16, hch@infradead.org wrote:
>> On Fri, Mar 03, 2023 at 06:35:30AM +0800, Qu Wenruo wrote:
>>> Just make the in-memory RST update happen in finish_ordered_io() should be
>>> good enough.
>>> Then we can keep the RST tree update in delayed ref.
>>
>> Independent of the workqueue changes, doing the RST update in
>> finish_ordered_io feels like the right thing to me, although my
>> gut feeling migh not be properly adjusted to btrfs yet :)
>>
> 
> Btw, this would look sth like the following (untested):
> 
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index ab8f1c21a773..f22e34b4328f 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -352,21 +352,6 @@ static void btrfs_raid56_end_io(struct bio *bio)
>          btrfs_put_bioc(bioc);
>   }
>   
> -static void btrfs_raid_stripe_update(struct work_struct *work)
> -{
> -       struct btrfs_bio *bbio =
> -               container_of(work, struct btrfs_bio, end_io_work);
> -       struct btrfs_io_stripe *stripe = bbio->bio.bi_private;
> -       struct btrfs_io_context *bioc = stripe->bioc;
> -       int ret;
> -
> -       ret = btrfs_add_ordered_stripe(bioc);
> -       if (ret)
> -               bbio->bio.bi_status = errno_to_blk_status(ret);
> -       btrfs_orig_bbio_end_io(bbio);
> -       btrfs_put_bioc(bioc);
> -}
> -
>   static void btrfs_orig_write_end_io(struct bio *bio)
>   {
>          struct btrfs_io_stripe *stripe = bio->bi_private;
> @@ -393,10 +378,12 @@ static void btrfs_orig_write_end_io(struct bio *bio)
>                  stripe->physical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
>   
>          if (btrfs_need_stripe_tree_update(bioc->fs_info, bioc->map_type)) {
> -               INIT_WORK(&bbio->end_io_work, btrfs_raid_stripe_update);
> -               queue_work(btrfs_end_io_wq(bioc->fs_info, bio),
> -                       &bbio->end_io_work);
> -               return;
> +               struct btrfs_ordered_extent *oe;
> +
> +               oe = btrfs_lookup_ordered_extent(bbio->inode, bbio->file_offset);
> +               btrfs_get_bioc(bioc);
> +               oe->bioc = bioc;

Looks valid to me.

Bioc would get a slightly longer lifespan, but it should be fine I guess?

Thanks,
Qu

> +               btrfs_put_ordered_extent(oe);
>          }
>   
>          btrfs_orig_bbio_end_io(bbio);
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 6b0cff5c50fb..704e8705bbb9 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3159,6 +3159,11 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
>                  btrfs_rewrite_logical_zoned(ordered_extent);
>                  btrfs_zone_finish_endio(fs_info, ordered_extent->disk_bytenr,
>                                          ordered_extent->disk_num_bytes);
> +       } else if (ordered_extent->bioc) {
> +               ret = btrfs_add_ordered_stripe(ordered_extent->bioc);
> +               btrfs_put_bioc(ordered_extent->bioc);
> +               if (ret)
> +                       goto out;
>          }
>   
>          if (test_bit(BTRFS_ORDERED_TRUNCATED, &ordered_extent->flags)) {
> diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
> index 18007f9c00ad..e3939bb8a525 100644
> --- a/fs/btrfs/ordered-data.h
> +++ b/fs/btrfs/ordered-data.h
> @@ -157,6 +157,8 @@ struct btrfs_ordered_extent {
>           * command in a workqueue context
>           */
>          u64 physical;
> +
> +       struct btrfs_io_context *bioc;
>   };
>   
>   static inline void
> 
