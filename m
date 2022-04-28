Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB72513EA0
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 00:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352987AbiD1Woq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Apr 2022 18:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352944AbiD1Wop (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Apr 2022 18:44:45 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605E0939C2
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 15:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651185679;
        bh=MuZywHiNtgA2mGfIS9VPm3USJa9mECoTazlJTYGYQyc=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=djiljFbBO0iigF98o9GAq2xFdCoYmlyRD7rvil2NoXhffWTM6BntGBxxxSZ0zWmFe
         IIoeQAS6tKvaHmZyM3+GtBEBlixl9yJqqu6nRPnaG8R2aN2aNtmKUAGC9t8mGHetLz
         hBF9Y6XZB5L2HaAdAsUlLu8EPjByBgADntpdtAls=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1My36T-1o4T691ZDr-00zW53; Fri, 29
 Apr 2022 00:41:19 +0200
Message-ID: <82eb8269-bf14-1396-7452-a8671ed24511@gmx.com>
Date:   Fri, 29 Apr 2022 06:41:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH RFC v2 02/12] btrfs: always save bio::bi_iter into
 btrfs_bio::iter before submitting
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1651043617.git.wqu@suse.com>
 <b11499d578ab90258d83ec9be6d46df78c1056bf.1651043617.git.wqu@suse.com>
 <YmqXZ1Oa8UX3n2ZP@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <YmqXZ1Oa8UX3n2ZP@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:b8me0bJ03OrVC6s9uYn3d8BOLWLA/0FpqUqik4BS+1WLlQM5ixW
 mO4eh4VpDTRP7JsifSUD+mQ6/o8NBRRuH3oygJlVr5FF4AfST9fZCgzyJ4wlYghClfQ2Nrq
 SIAO8YyDyujKzOCS8hVMQufjqhi1HicQk1PxhPZ34pCHkBheGHYWithgFUdshpN9Ctn0uLb
 loLU8qvtXyiiQ/PueEJaQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2NUluGNGPyI=:GQyG/Kg1gJ1SR7bpULO8QH
 PeeOFWDaTanJ+SxxXk9iU94MokaFI2fkH30PxDyZAEqSbcZPbQSuEAV7+6qWoDs72u7cpe14t
 kHREMM4GLWEaXTvGKosefLIsJ3F3nH78QPQ6zY/tK3Tmv97IiSyCU+F3+rLyHAUMJ89JCwW2s
 liBb/OJxEqBIa1yl/xA5zp7ELQER2n0RVnRwnLmiLPyVgRUMyvwyy1VhXGLnmduQucdnePnYw
 3u/o48x/luJ0yTX0dzCqGCbmch8yxGifEvn7PN4uigwVGnO3+k3c7fCQ4EPjkApwDlDtXO8bw
 I13Rh+9dyT4WpZsUYuD66EUOsn9drBcRFCvH6R11HsIVICN3ufroGjfG7yG8u4bLzN3fdkxxk
 eopA4lYLnd4EX+eyLykK0sQplJ/b6fqbpGfkgPs78HIzfyoZN8BGyh5bzmxealBISoG0Dswlr
 n3Hf7R5MtoANlUV6ahhdsg8B/an3StQRdNMRaGH1dL+161k5/YcqqsqVbyOskfXoQWPuC2MtR
 PVMKpGwnJvUBuZvld42z5mp9bYoinXzSh/RkJ/Pf9WdYB2zNhLa4COsRCduFCn3M8Jq9edSkp
 dGZblMR1Nc8srCa1fc74sOlabwpPfRQmaFzuBVZWgeNvhM+pPWQzPPJBchn493Fe2bXescfza
 kOMRGI8+1nvx4Mrytu4mCCqXzyCFykPYOgZK4C7LtUY90l5lZtbafNCs4iKe/7fz9jVJfxJSB
 9zIJOvNlI5+8YLjyW7YurUPSeyoxYYiAmTOLqURD6h99vD4TFj5/lAwQ4usl1oeD6ieA+MKv8
 CYYe/TGSOnIxvvB3Srl/fHZ7y2E/I5DlJs+XqjdqdxOKAYrF7jyM5ggMJI5hAeaBbyDmvx9XB
 kWpSoFlnN7UQk5n9ZgfhIDoU7neSYCJH3hjsugCKkS8LPcCwgSaP7hTxCUjptdt39LX04pB20
 PSZlZR0uqaE5lGF2/CQpJ55p2zfme7gTLtEvae1+MX4cJ7PnmQ3YSV6boN0PGKbKVkGeqHXNA
 loxRdLNMVU/lNPC/fOu/B96ldrSRAP7tnw6lw3Kv1YAI81CgqNYl6jJo5Y+GwQh09Sya7yA/6
 LIfbjj2GDzIVMY=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/28 21:32, Christoph Hellwig wrote:
> On Wed, Apr 27, 2022 at 03:18:48PM +0800, Qu Wenruo wrote:
>> Lower level bio mapping, from driver to dm, even btrfs chunk mapping
>> can modify bio::bi_iter.
>>
>> This prevents us from doing two things:
>>
>> - Iterate the bio range of a cloned bio
>>    This is only utilized by direct IO, thus it's already using
>>    btrfs_bio::iter, which is populated in btrfs_bio_clone_partial().
>>
>> - Grab the original logical bytenr of a bio
>>    This will be utilized by incoming read repair patches.
>>
>> So to make sure all btrfs_bio submitted to own a proper iter, this patc=
h
>> will assigned btrfs_bio::iter in the following call sites:
>
> Independent of what we want to do with the saved iter in the future
> I don't think this is an improvement.  The place where we can start
> advancing the iter is after the bio is submit by btrfs_map_bio, so that
> is the one central place where it should be saved.  I actually had
> a patch like that in one my my wip branches:
>
> ---
> From: Christoph Hellwig <hch@lst.de>
> Subject: btrfs: centralize stashing away ->bi_iter in btrfs_map_bio
>
> Once a bio is submitted to a driver, the driver can advance bi_iter.
> Save to the copy in the btrfs_bio just before that can happen rather
> than in random places high up in the stack.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/extent_io.c | 7 +------
>   fs/btrfs/volumes.c   | 3 +++
>   2 files changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 07888cce3bce6..002b1ea92e398 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2683,7 +2683,6 @@ int btrfs_repair_one_sector(struct inode *inode,
>   	}
>
>   	bio_add_page(repair_bio, page, failrec->len, pgoff);
> -	repair_bbio->iter =3D repair_bio->bi_iter;
>
>   	btrfs_debug(btrfs_sb(inode->i_sb),
>   		    "repair read error: submitting new read to mirror %d",
> @@ -3209,14 +3208,11 @@ struct bio *btrfs_bio_alloc(unsigned int nr_iove=
cs)
>
>   struct bio *btrfs_bio_clone(struct block_device *bdev, struct bio *bio=
)
>   {
> -	struct btrfs_bio *bbio;
>   	struct bio *new;
>
>   	/* Bio allocation backed by a bioset does not fail */
>   	new =3D bio_alloc_clone(bdev, bio, GFP_NOFS, &btrfs_bioset);
> -	bbio =3D btrfs_bio(new);
> -	btrfs_bio_init(bbio);
> -	bbio->iter =3D bio->bi_iter;
> +	btrfs_bio_init(btrfs_bio(new));
>   	return new;
>   }
>
> @@ -3235,7 +3231,6 @@ struct bio *btrfs_bio_clone_partial(struct bio *or=
ig, u64 offset, u64 size)
>   	btrfs_bio_init(bbio);
>
>   	bio_trim(bio, offset >> 9, size >> 9);
> -	bbio->iter =3D bio->bi_iter;
>   	return bio;
>   }
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 748614b00ffa2..f282a58a12344 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6750,6 +6750,9 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *f=
s_info, struct bio *bio,
>   	int total_devs;
>   	struct btrfs_io_context *bioc =3D NULL;
>
> +	/* stash away the iter as the low-level processing can advance it */
> +	btrfs_bio(bio)->iter =3D bio->bi_iter;

The problem here is, if any endio function needs to grab the original
bio, and btrfs submit bio hooks failed before btrfs_map_bio(), like some
failure from btrfs_bio_wq_end_io(), then we will call bio_endio(), and
the endio just got an empty iter.

Thanks,
Qu

> +
>   	length =3D bio->bi_iter.bi_size;
>   	map_length =3D length;
>
