Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C31F529B47
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 09:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbiEQHnU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 03:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242074AbiEQHnJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 03:43:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994A912D31
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 00:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652773372;
        bh=3wO7ll07HlhDaW9L4BKNFR3aBZZOKyYF2mKDoWQ/afM=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=BlV4wf+79Z0rfmszdAiqkwqtYOkk0VBjaKLYXXF7Q3QpH35/nk8JXLll9zMtA+P0X
         osBc+CFTdw3goVRub1Gm+yHgl1GrUgnmWsChbflNjRaJcfgRCTBf57FrPOUb3t4WW+
         Dg/0vTqj8GoUResLwIwB73rVURBK+wKSxtpDQBjs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M4Jqb-1nqajk1nDV-000Oyi; Tue, 17
 May 2022 09:42:52 +0200
Message-ID: <51ac74ff-ada4-a3ee-5638-2fad8fc14f03@gmx.com>
Date:   Tue, 17 May 2022 15:42:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC ONLY 2/8] btrfs: move btrfs_io_context to volumes.h
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <6bd71ff55e48686fc917736e686143ca7d5d2c64.1652711187.git.johannes.thumshirn@wdc.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <6bd71ff55e48686fc917736e686143ca7d5d2c64.1652711187.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sHXWP687tCgkvV7qcaMz5Cp0HUjWJR14hzDHclANefVPbMzZk7h
 uIviCr5qfkl+heIRrUF6/d8TqJiHaa5I+ScsZNWmunYywHunGI82N7xR7cZF/NnoAY7UicN
 BWL+581ajySIonO+GNi05iHWrdGKk84s1xIyonXCjS05/NFicEclIBl9KWWdAFdwBPCqRw6
 jJruAibylUz5EhfRnmIEA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rqYap0vP/l8=:jRCMb1ntzlD+71HKQ6pS6w
 yTGQXmbzT9TXn+ECkpCqrRrd2zjGLl+cjgiM47JMkLG1EQ7C4Tk42R8Geinlt0ANbac7Kqi21
 fhdh4ayVP5O6365D1BMK+y3iLp/LwjI24geCmSKHA8y+iiIgSN1z/cofhqKfkoR21eOMhQLaQ
 gehgXtkKX5C+cr/MtHF+rLUgEZWZ5ypQ+Lya3QHlLYJckHKGuNSb3xcokvvkT7QjBe4d0p0rw
 f1ZcXU72GXVhmVjnNFKE9AJmP8GujI7v0858ECq6g3GymCkawiA2tPSM70R29tHS2w7wLnySr
 +1/nSaawRErns5H8fVFgAk/6WWgdVqI0/hTKiiRUT3DhHC4vhvP5hlGtnBIsH4swfd4IWxXEt
 pt0eKvsn1X/4RZx+2+YYimYLoshovNV08be8quYIGIMVVlrne0ayLucrnpj3mX42BU2MIw7Vq
 +7DczYX0ES9tp/poMxgdGzs656160RuMVlPbMWnfBOHx65eaKs8+lt7dLkR5AH1wAmzFFztyO
 +CGQrtGzSwl6OyW8J7Fe+8e51+OFPyikWyYx0E2VBb4QZ8vsDXMqTcbP5NW/9mK3OJ/tjCRkl
 4Bq5QWSszmkDsb+HlCIts86a9wnO2hKPQYh4cqAD3EJ/SQyBjvM5hATTAAHP/mvTUwVrpTBQB
 dhExvfnMhuBZMZOspg3801XgdViJHeUvBU1cPdl29mai9xZJCIZVfumFozQmXOEn8pgSjK7E8
 aWAB6H/6dF9I+VEBIlKLwWUjFO2jf6qVvJAtQKWXa2HTH3B8ilgzO85UdJm3CkszwI6E7w7Nw
 AdW5eKVnMxZcuC9ejqgyEvSkhZhvtwGM99X1bekvk8xp3BfnFdUyhm2oVgzVk1YMxmm+vW+C1
 V4oV5OHGVdX6QGKUVeItaBx0bgkx0xX3gN98dtXwBBgBpK9KSXX3cWT4nW/osCiQBVnewC+rU
 wo0Dcaro1VGr11M8ZM5AP4qIGpCleQzefn9EFnqN2w37jtGH8CNUl83Tyqz0fuO6FXiQDC84o
 2FpHBH/dRMTeqSIG4HD5MZnh+VV53zr0VVMpZyh8jxQ2P+X1uoLFdlTP9bpQzewUaCVf2x8xF
 aGLDa58kPecaREg6AelbtP3n/l9PjkXLug/v5jZXdwT6Uek7GWCZtrOFw==
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/16 22:31, Johannes Thumshirn wrote:
> In preparation for upcoming changes, move 'struct btrfs_io_context' to
> volumes.h, so we can use it outside of volumes.c

In fact I don't think the naming itself (from myself) is that good.

It maybe a good idea to also do a rename here.

I have some bad alternatives, but doesn't seem better than the current
generic naming either:

- btrfs_io_mapping
- btrfs_mapping_context

Thus I guess the current name is chosen mostly due to lack of better ones.

Thanks,
Qu

>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/volumes.h | 90 +++++++++++++++++++++++-----------------------
>   1 file changed, 45 insertions(+), 45 deletions(-)
>
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index bd297f23d19e..894d289a3b50 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -32,6 +32,51 @@ struct btrfs_io_geometry {
>   	u64 raid56_stripe_offset;
>   };
>
> +struct btrfs_io_stripe {
> +	struct btrfs_device *dev;
> +	u64 physical;
> +	u64 length; /* only used for discard mappings */
> +};
> +
> +/*
> + * Context for IO subsmission for device stripe.
> + *
> + * - Track the unfinished mirrors for mirror based profiles
> + *   Mirror based profiles are SINGLE/DUP/RAID1/RAID10.
> + *
> + * - Contain the logical -> physical mapping info
> + *   Used by submit_stripe_bio() for mapping logical bio
> + *   into physical device address.
> + *
> + * - Contain device replace info
> + *   Used by handle_ops_on_dev_replace() to copy logical bios
> + *   into the new device.
> + *
> + * - Contain RAID56 full stripe logical bytenrs
> + */
> +struct btrfs_io_context {
> +	refcount_t refs;
> +	atomic_t stripes_pending;
> +	struct btrfs_fs_info *fs_info;
> +	u64 map_type; /* get from map_lookup->type */
> +	bio_end_io_t *end_io;
> +	struct bio *orig_bio;
> +	void *private;
> +	atomic_t error;
> +	int max_errors;
> +	int num_stripes;
> +	int mirror_num;
> +	int num_tgtdevs;
> +	int *tgtdev_map;
> +	/*
> +	 * logical block numbers for the start of each stripe
> +	 * The last one or two are p/q.  These are sorted,
> +	 * so raid_map[0] is the start of our full stripe
> +	 */
> +	u64 *raid_map;
> +	struct btrfs_io_stripe stripes[];
> +};
> +
>   /*
>    * Use sequence counter to get consistent device stat data on
>    * 32-bit processors.
> @@ -354,51 +399,6 @@ static inline void btrfs_bio_free_csum(struct btrfs=
_bio *bbio)
>   	}
>   }
>
> -struct btrfs_io_stripe {
> -	struct btrfs_device *dev;
> -	u64 physical;
> -	u64 length; /* only used for discard mappings */
> -};
> -
> -/*
> - * Context for IO subsmission for device stripe.
> - *
> - * - Track the unfinished mirrors for mirror based profiles
> - *   Mirror based profiles are SINGLE/DUP/RAID1/RAID10.
> - *
> - * - Contain the logical -> physical mapping info
> - *   Used by submit_stripe_bio() for mapping logical bio
> - *   into physical device address.
> - *
> - * - Contain device replace info
> - *   Used by handle_ops_on_dev_replace() to copy logical bios
> - *   into the new device.
> - *
> - * - Contain RAID56 full stripe logical bytenrs
> - */
> -struct btrfs_io_context {
> -	refcount_t refs;
> -	atomic_t stripes_pending;
> -	struct btrfs_fs_info *fs_info;
> -	u64 map_type; /* get from map_lookup->type */
> -	bio_end_io_t *end_io;
> -	struct bio *orig_bio;
> -	void *private;
> -	atomic_t error;
> -	int max_errors;
> -	int num_stripes;
> -	int mirror_num;
> -	int num_tgtdevs;
> -	int *tgtdev_map;
> -	/*
> -	 * logical block numbers for the start of each stripe
> -	 * The last one or two are p/q.  These are sorted,
> -	 * so raid_map[0] is the start of our full stripe
> -	 */
> -	u64 *raid_map;
> -	struct btrfs_io_stripe stripes[];
> -};
> -
>   struct btrfs_device_info {
>   	struct btrfs_device *dev;
>   	u64 dev_offset;
