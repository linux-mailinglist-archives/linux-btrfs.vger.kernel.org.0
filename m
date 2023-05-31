Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E683A717AA3
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 10:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235003AbjEaItf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 04:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbjEaItH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 04:49:07 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AC7E56
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 01:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1685522916; i=quwenruo.btrfs@gmx.com;
        bh=7q6qPXZkguZA6OsmpiagdN+SX5FBTvnkF0AvKsNOX+M=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=tNiK2yBMxq1yR/jcd30IFxH4jV43vkWODwYAt+foasC2urVhGtXexYRnnqgKs32A9
         fekD15r+w7PxvvwbCHo6xP1UhN4/ECqkFxGZ3ugh/LhaNfIqZFnu1HABWrVJfvQUz+
         A6B6iJ3Z/q4gXSEtYeMANO0VBFG6vH9oepnvRExCrT/vai6Cs+dUJQhnB1uZZXGBpD
         6p5zkVXJpWe1TK1iZdIswjliGayY/CxLD51HsY+EcKNg4Nae8zSPfo6DuQoI2R3FQM
         ZITL9xZXKkvqCyf5djfmqwZBOgNDRgzufk4Y3mDB1vydpyi3l2wUuKDEXn8XnRzJMI
         552f/W/XYMS9A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MVeMA-1pctFf1eJo-00RWlG; Wed, 31
 May 2023 10:48:36 +0200
Message-ID: <81ad4855-ca9e-8f72-d00c-f721160fa6f4@gmx.com>
Date:   Wed, 31 May 2023 16:48:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 4/6] btrfs: rename __btrfs_map_block to btrfs_map_block
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230531041740.375963-1-hch@lst.de>
 <20230531041740.375963-5-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230531041740.375963-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RJ+EpQ2nv12zR+eYHPjh61MzpiZ1dLIwNiqRH9lFJlgH/WSw/Bv
 WNlEf2iAUDyX4z/7CeAKW0dajzUQcmjcyGKXVEEMGAcS8Bf59CF1ruFFL1SXjUncwb+mL5y
 fJSJlPrqB+W6nBnSZ6dcAS0u+TIyw1LqKubDfB+xSbqPr5JUthM2Ff+E66Igrkxg5JKbv5c
 +lUFm44T3gpxrUhPMjSrw==
UI-OutboundReport: notjunk:1;M01:P0:Ak+o1kMKjNM=;UXjzzaa0QGDtVev9t1m+tbfcOZ6
 27YpiubmBUpRNaNqaRXXbWSXxzjml3ERCss557r9mcCKCDISXSBnH3BZVhPisOMql2oUvXSrh
 AUjFVM/y/tm8A5bc3iWgN8sNHEUpp4TrD+n7IW41flN8YD5w8vPxTSn3Rec65bXMTVTbykEuZ
 TP4wU9JfKOOca5UqGpRwfX7MUWB2VXmsY3UFUckl46gDx5jpwXTYj7irgUVkTPhDk2Fr8GpiN
 gzbajLFv+tXrtNbo14RHHwG0m/SG0pX/cwkJiLwZvo7S+AW/2p4ySpBpET0BH5Um8hX151vFe
 VzxOrSCWu/bdqwa/6k6s7NC+BWhunXE/bWxBuMG/h7lmk1os5EIug1T0LfkqfmmCRXePLz9I1
 NBj66wwhArqJPJjTai5FFdks7sbZDYbg3aXYlBa44mc0J/oGGk+G/ysf0Vdzj/LAXjAuV0gcf
 wcerVSpE9AiTLAOMbvciy9o4mrnHelk9+1spd3Fq/i8HZG/wxMXajVCGJ+wLc7YnTbUSVG6e/
 /cB4hMtctGriW9ZMcVYBakHTZiZGeNb95qg2C52rBsBL2LKBHGm8oeDHujGS2dc1Cij1e8bSi
 HGvbf/RBJit8c+Fql88m6koqhG8Fj2MFjbPJ7e1UNjqUfW96cXyPeRwLFfBBeJDCYNppzt0XT
 JS5IdAz3A5QGzR6Wz615FJZjU0QWkZxRh5Ofdmrz1LDThPK0IWTkQwPFfXGXQTa8E3TOWURFe
 zENdrPrdReMEOj2OSDJS6Bx4BLqLRufi0FCZfuTdXgZoTrX96Gie7UMw0kkm33PA+FB9l9hUQ
 Q7fchLFAh69IFIc4CU546avJzvsbfC2pyKBoZblGH2utm4ogQnzedfw/jEpB+nMPyyopL4mNy
 zqJKMzGS+FY3Q78rNtP52PKYeMGFN2kZzVcXRFG5iQhaTxYl02C7j/BPuqv4CausDng7NegbD
 Pz23DnK8ud5QhXbpZ3P5OW0hYKQ=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/31 12:17, Christoph Hellwig wrote:
> Now that the old btrfs_map_block is gone, drop the leading underscores
> from __btrfs_map_block.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/bio.c             |  4 ++--
>   fs/btrfs/check-integrity.c |  4 ++--
>   fs/btrfs/dev-replace.c     |  2 +-
>   fs/btrfs/volumes.c         | 16 ++++++++--------
>   fs/btrfs/volumes.h         | 10 +++++-----
>   5 files changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index ae6345668d2d01..85511a8a480194 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -622,8 +622,8 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbi=
o, int mirror_num)
>   	int error;
>
>   	btrfs_bio_counter_inc_blocked(fs_info);
> -	error =3D __btrfs_map_block(fs_info, btrfs_op(bio), logical, &map_leng=
th,
> -				  &bioc, &smap, &mirror_num, 1);
> +	error =3D btrfs_map_block(fs_info, btrfs_op(bio), logical, &map_length=
,
> +				&bioc, &smap, &mirror_num, 1);
>   	if (error) {
>   		ret =3D errno_to_blk_status(error);
>   		goto fail;
> diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
> index fe15367000141a..3caf339c4bb3e4 100644
> --- a/fs/btrfs/check-integrity.c
> +++ b/fs/btrfs/check-integrity.c
> @@ -1464,8 +1464,8 @@ static int btrfsic_map_block(struct btrfsic_state =
*state, u64 bytenr, u32 len,
>   	struct btrfs_device *device;
>
>   	length =3D len;
> -	ret =3D __btrfs_map_block(fs_info, BTRFS_MAP_READ, bytenr, &length, &b=
ioc,
> -				NULL, &mirror_num, 0);
> +	ret =3D btrfs_map_block(fs_info, BTRFS_MAP_READ, bytenr, &length, &bio=
c,
> +			      NULL, &mirror_num, 0);
>   	if (ret) {
>   		block_ctx_out->start =3D 0;
>   		block_ctx_out->dev_bytenr =3D 0;
> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> index dc3f30c79320a1..5e86bea0a9507c 100644
> --- a/fs/btrfs/dev-replace.c
> +++ b/fs/btrfs/dev-replace.c
> @@ -41,7 +41,7 @@
>    *   All new writes will be written to both target and source devices,=
 so even
>    *   if replace gets canceled, sources device still contains up-to-dat=
e data.
>    *
> - *   Location:		handle_ops_on_dev_replace() from __btrfs_map_block()
> + *   Location:		handle_ops_on_dev_replace() from btrfs_map_block()
>    *   Start:		btrfs_dev_replace_start()
>    *   End:		btrfs_dev_replace_finishing()
>    *   Content:		Latest data/metadata
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 4c6405c4ce041d..53059ee04f9b60 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6232,11 +6232,11 @@ static void set_io_stripe(struct btrfs_io_stripe=
 *dst, const struct map_lookup *
>   			stripe_offset + (stripe_nr << BTRFS_STRIPE_LEN_SHIFT);
>   }
>
> -int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op =
op,
> -		      u64 logical, u64 *length,
> -		      struct btrfs_io_context **bioc_ret,
> -		      struct btrfs_io_stripe *smap, int *mirror_num_ret,
> -		      int need_raid_map)
> +int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op=
,
> +		    u64 logical, u64 *length,
> +		    struct btrfs_io_context **bioc_ret,
> +		    struct btrfs_io_stripe *smap, int *mirror_num_ret,
> +		    int need_raid_map)
>   {
>   	struct extent_map *em;
>   	struct map_lookup *map;
> @@ -6486,7 +6486,7 @@ int btrfs_map_sblock(struct btrfs_fs_info *fs_info=
, enum btrfs_map_op op,
>   		     u64 logical, u64 *length,
>   		     struct btrfs_io_context **bioc_ret)
>   {
> -	return __btrfs_map_block(fs_info, op, logical, length, bioc_ret,
> +	return btrfs_map_block(fs_info, op, logical, length, bioc_ret,
>   				 NULL, NULL, 1);
>   }
>
> @@ -8066,8 +8066,8 @@ int btrfs_map_repair_block(struct btrfs_fs_info *f=
s_info,
>
>   	ASSERT(mirror_num > 0);
>
> -	ret =3D __btrfs_map_block(fs_info, BTRFS_MAP_WRITE, logical, &map_leng=
th,
> -				&bioc, smap, &mirror_ret, true);
> +	ret =3D btrfs_map_block(fs_info, BTRFS_MAP_WRITE, logical, &map_length=
,
> +			      &bioc, smap, &mirror_ret, true);
>   	if (ret < 0)
>   		return ret;
>
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 481f3ace988c44..c70805c8d89554 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -585,11 +585,11 @@ void btrfs_put_bioc(struct btrfs_io_context *bioc)=
;
>   int btrfs_map_sblock(struct btrfs_fs_info *fs_info, enum btrfs_map_op =
op,
>   		     u64 logical, u64 *length,
>   		     struct btrfs_io_context **bioc_ret);
> -int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op =
op,
> -		      u64 logical, u64 *length,
> -		      struct btrfs_io_context **bioc_ret,
> -		      struct btrfs_io_stripe *smap, int *mirror_num_ret,
> -		      int need_raid_map);
> +int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op=
,
> +		    u64 logical, u64 *length,
> +		    struct btrfs_io_context **bioc_ret,
> +		    struct btrfs_io_stripe *smap, int *mirror_num_ret,
> +		    int need_raid_map);
>   int btrfs_map_repair_block(struct btrfs_fs_info *fs_info,
>   			   struct btrfs_io_stripe *smap, u64 logical,
>   			   u32 length, int mirror_num);
