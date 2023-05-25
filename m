Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9D2710A2C
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 May 2023 12:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240345AbjEYKdo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 May 2023 06:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjEYKdn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 May 2023 06:33:43 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F330612E
        for <linux-btrfs@vger.kernel.org>; Thu, 25 May 2023 03:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1685010818; i=quwenruo.btrfs@gmx.com;
        bh=lKqvEmo+9hqb19Ja4e8OgoruG0RlVB4dkXObEzN2BbM=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=QXwITastbjZoFwRnXeayL/8lquesp0idQYBB8k2I0qTnY2NOYLeRu6dimYtk5elGs
         0LxA8Wvl5L0/A9i8kCGkxhPalBa+luN3ySZchYmNtG0Sf52xrDmK/9PZTt1JRGT4BL
         +Ygqt+mwOQyvj+sHLiV4tsF5p15mpLy+GugCJgPfJi5ATzLIBoE3qqiXdGWeoZ4Njb
         aKDF3gXmtmZLqujLafZzmofA70QPwvLzQ7CYCpRcEaU/XTFwFTQj7DurB/M2/ucw/5
         hNqDRZk5Ul0fAiZMkEqhpi6gbm+zR5DpthaNf+IRH/z+FleFtxw1uuWiNmM5YT3Vx4
         irffJr87orZmg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mnpnm-1qUGBX40K2-00pPI9; Thu, 25
 May 2023 12:33:38 +0200
Message-ID: <ed72d204-214b-fd3c-7a5b-724df2a961a8@gmx.com>
Date:   Thu, 25 May 2023 18:33:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 5/9] btrfs: open code set_extent_bits_nowait
Content-Language: en-US
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1684967923.git.dsterba@suse.com>
 <a497320d91b1e08e0766f44844746e235478630e.1684967923.git.dsterba@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <a497320d91b1e08e0766f44844746e235478630e.1684967923.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ScmYlSdzuSdPsJfnJXMS2eMRbT0hkf5428KzhbmZv3rtvTD5lym
 An2LpxQbtvRhmVVZvjIYyWUay0ZOSDQAk5sUFNwU4ww1b9Ao3SqtnTjsUfL9o6di+SlVi0Q
 zJRRJwBsCYC/1JQwPUGt/deV7WznaD6rrZJCaufF2S8Tqf2lYXUvPpC1z8pP2U5ErflZ/ZI
 pyajoiBXuPzc8THO3vP4g==
UI-OutboundReport: notjunk:1;M01:P0:tQhDSjb4dsM=;K9Ov+PflWAzYlO2J0PhNOphvJYQ
 Kz19S2+XWzvaXPALI+WKSFL69wS36eEsZeaPNGULZ3bl+/QOVRlWzPfFuT7j4cmRCcY55pV78
 g2HxSZf8xwAdTH2kkbn6vnm8ma0Y/9Qs/yQCFhNpRhjQK8gswR1buFBGHEYhkvq4JmRShRPzV
 EwWGPnPzL/NSZC94sTc6Q0GfCeFxtcJukSdNlhIx8kcE1Ov8rkII0WhCSGk7WnmGcKM+h5T7U
 k9i6b09PVX1MVc/iQniVXWfsm7ees+/IQXcLRFllggaK432QeTTtbqAm77PXZLSRG/0771Ljz
 qhUiF1f36Etnr0NdZt3kwg2JLdPhSJ7yTbelr0OpmqHqEzRUYkmakA4wcTWaHdrTsPaCbBuZC
 AvMdOfHi99o8KCKwmsSB6fnjMUB4sGFyD7G0995502aiJu4ZRomBh/KVFNDyrrE6m32Fq4doo
 vixHzA+ZK1QovdhiNf/gMTiTWAV3Ueq32BG5x1HlBbgEsjjNAmgRVJdWS+SrrQnO82qGPrd0U
 9rFvSc8OuLBi9PPf1y5HXfKTOaSr5jbwXGUyqY/+pskjjM/2Hm4P+UT6iaKW2yB1MKk2Qkkyf
 gdotBR3KVi+APY692nYY7PKFm/eiZLxDgBBJUrXrjEPGZKkLjWFgKQ8pFzZHmdb3howHQkkSb
 CZvBkvooaPkHpre6FPO/3A88LxUHELkzrIVtNRnnfS9TnwdOO+vp6DsdPXzFQ+U50Ck1Roamq
 QuEbxbdwZVmabr0iftMUxFG5HdHQEKWHff5b5sPYshfqP/X7o7wW6b6I0IFUkdBYByYr3EX7V
 SArteH04umnQkzgS2vGa82SYkCJMHB3qGn9ThSOOTYqcvApWAOm6oH0QD3Ww6det6/XpDOVNt
 VqcL5/ngPpdmfdpYUtD0zJLrsQNy/mz1puaJ+fiAJHuP/QWMxURyYQeTJS3Rd+p4xjXXG9ijV
 0lebi+1cxPfuu4LLtdw5cjPMzio=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/25 07:04, David Sterba wrote:
> The helper only passes GFP_NOWAIT as gfp flags and is used two times.
>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/extent-io-tree.h | 6 ------
>   fs/btrfs/extent_map.c     | 5 +++--
>   fs/btrfs/zoned.c          | 4 ++--
>   3 files changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
> index 0fc54546a63d..ef9d54cdee5c 100644
> --- a/fs/btrfs/extent-io-tree.h
> +++ b/fs/btrfs/extent-io-tree.h
> @@ -156,12 +156,6 @@ int set_record_extent_bits(struct extent_io_tree *t=
ree, u64 start, u64 end,
>   int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
>   		   u32 bits, struct extent_state **cached_state, gfp_t mask);
>
> -static inline int set_extent_bits_nowait(struct extent_io_tree *tree, u=
64 start,
> -					 u64 end, u32 bits)
> -{
> -	return set_extent_bit(tree, start, end, bits, NULL, GFP_NOWAIT);
> -}
> -
>   static inline int set_extent_bits(struct extent_io_tree *tree, u64 sta=
rt,
>   		u64 end, u32 bits)
>   {
> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> index 138afa955370..918ce12ea412 100644
> --- a/fs/btrfs/extent_map.c
> +++ b/fs/btrfs/extent_map.c
> @@ -364,8 +364,9 @@ static void extent_map_device_set_bits(struct extent=
_map *em, unsigned bits)
>   		struct btrfs_io_stripe *stripe =3D &map->stripes[i];
>   		struct btrfs_device *device =3D stripe->dev;
>
> -		set_extent_bits_nowait(&device->alloc_state, stripe->physical,
> -				 stripe->physical + stripe_size - 1, bits);
> +		set_extent_bit(&device->alloc_state, stripe->physical,
> +			       stripe->physical + stripe_size - 1, bits, NULL,
> +			       GFP_NOWAIT);
>   	}
>   }
>
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index bda301a55cbe..b82a350c4c59 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1611,8 +1611,8 @@ void btrfs_redirty_list_add(struct btrfs_transacti=
on *trans,
>   	memzero_extent_buffer(eb, 0, eb->len);
>   	set_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags);
>   	set_extent_buffer_dirty(eb);
> -	set_extent_bits_nowait(&trans->dirty_pages, eb->start,
> -			       eb->start + eb->len - 1, EXTENT_DIRTY);
> +	set_extent_bit(&trans->dirty_pages, eb->start, eb->start + eb->len - 1=
,
> +			EXTENT_DIRTY, NULL, GFP_NOWAIT);
>   }
>
>   bool btrfs_use_zone_append(struct btrfs_bio *bbio)
