Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1711C717AA0
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 10:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbjEaItO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 04:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235163AbjEaIss (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 04:48:48 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B3910E
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 01:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1685522891; i=quwenruo.btrfs@gmx.com;
        bh=xYZ/TzJ4jc5PRsuaaJtdCz/GxcI6FnUN4eFzPUsyuws=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=NI+28WNXTovIH0HP/OCNwPRcwOFKawQkAw8QtQIIYv20ppW7vyA3t35cbUA6nGZhY
         OQj2+OatukD5nwkG71Ar7JNAxESX7O0IhLtUMO4wwIqACRY6kdkT6OHpODPxKAvezo
         U8i52LzM2J+kRD3BIiYI6tbXtBEJL0DxHwpZ9OnRZl4r3FZw3WpQkzupnRvwGMssXE
         d9adnsd+upSBIa/4sCk4FDqdeN+jO7J/YDWvwB9SP0/U+sOYaOkgvHUwcMbPQBGz93
         849+DYM4/w3zfna9H3NzYILdiNugo0RKYOSHeMtnzV7OfsDiQICVM8zmafzcgJ2OA1
         l8xN8EEZDQeXg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N0Fxf-1qFme52nsF-00xO4m; Wed, 31
 May 2023 10:48:11 +0200
Message-ID: <bb7899ed-b2b6-b7f8-dd40-50094a1bee09@gmx.com>
Date:   Wed, 31 May 2023 16:48:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 3/6] btrfs: remove btrfs_map_block
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230531041740.375963-1-hch@lst.de>
 <20230531041740.375963-4-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230531041740.375963-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BVB/vOYVw4WdSi3F/Y7NWkmL40LgZuv2S5gNl1hVGWuE/czJrll
 1pd2btPS/l7t2C67IkuZmgIzwxtB2cMvTavXRc3BRRA5/G1A60KzJqoiLWnQsdfd51pep7d
 FRaXvYJEJNLmYEx5lM7L5GTmNob+8RUGledNADrY9PC6uUojPyw38HQmYdprhmAdmjPly0A
 dBvYlg1FceDZfZuf6isNA==
UI-OutboundReport: notjunk:1;M01:P0:B82xytpIC+E=;iJwu7a4EX3+xC646Mr2Lo6qeYih
 QTnAkeZUOLwkgAhtUb8febRU74s7lsQ9fHHS9Drg4c3gEmFzJHmBr1Un+ochVXcqAdgZNE4W2
 X7SoFLWE7Axpjl3OP+sqPs5EpGeCTCgZbFBwISTGbWpc+DxDniOJN5DJyOwi4GuP+k+xiuqvx
 OPFTbqHEy7WK3mKsLtp7NCJbW2raetYW04q8U1VMnZMcj1ou/MTZGTsYdLEr2dZumaXKvcpky
 V7+YBwhzK+5INSCmEOMDKquDyf3zaqM/sarmFOdTAmT+q3ZJeVVmYhp7SqNpx/pyAkFw4ayKv
 gL373Y3BQ8xofRfh+1q1z1TuOpyN+FTkoyyPRP/Uq20BQMgaiIcgV5KJeBhdmuH747JOCBtxv
 Z4s25SL56HSFcuzIvoAN7DLWik9DcfTamfvhl0uPtmbfx+/yv46lzARwzDnE9EBmv4jPJnBIt
 4eUri3mao+5Iitd9J97/kxMeUiwrHodH4SXot310Jt24kooVNHE+MlFwOKJH3V8ZqBIKGfHWy
 qjbqHfxM/4ROeqS3Z96hk4xtFGC1yeY/b8EH+VC/aZ34pgQ41vk3sIi9037OoNjC48NyEQiYe
 wsqko9Skg+6NWCKsHC2Bh1ZnVDB5cvjWpcdjVxgMqqoYSIwQsuYNHLXa/BkHYwayFriyBB8vZ
 v6c8AgSHN7SSbpVRMWNnElPlNG0nAP3snhZuzvvZEfuQIgzP4rMpXoH5iD2CizGmYCM+DQXZ7
 sS7sYQq+OFJPRA32PGFPek/Rjg6Ql8oPCY7CWebdMlKACj5HoaeMkZxBRI4+z+56Q7abHT7JF
 q7TVeicT2e0WqKrBGoqtOsRYigrPmzKX3BS90Brybb6uL2qbvlWw2InVxVtHDVHfvmd00Eqx2
 nX2f/nJWJzffC7ysnEqionj4SxlwofKGOv1pF8RESRIFrsZSuG3OZPIw5Yxa6jC/nsR5CkVbl
 IDk7hNHKOblW41ZfCgGd0RuAOXk=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/31 12:17, Christoph Hellwig wrote:
> There are no users of btrfs_map_block left, so remove it.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/volumes.c | 8 --------
>   fs/btrfs/volumes.h | 3 ---
>   2 files changed, 11 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index c236bfba0cec3b..4c6405c4ce041d 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6481,14 +6481,6 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_in=
fo, enum btrfs_map_op op,
>   	return ret;
>   }
>
> -int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op=
,
> -		      u64 logical, u64 *length,
> -		      struct btrfs_io_context **bioc_ret, int mirror_num)
> -{
> -	return __btrfs_map_block(fs_info, op, logical, length, bioc_ret,
> -				 NULL, &mirror_num, 0);
> -}
> -
>   /* For Scrub/replace */
>   int btrfs_map_sblock(struct btrfs_fs_info *fs_info, enum btrfs_map_op =
op,
>   		     u64 logical, u64 *length,
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index e960a51abf873d..481f3ace988c44 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -582,9 +582,6 @@ static inline unsigned long btrfs_chunk_item_size(in=
t num_stripes)
>
>   void btrfs_get_bioc(struct btrfs_io_context *bioc);
>   void btrfs_put_bioc(struct btrfs_io_context *bioc);
> -int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op=
,
> -		    u64 logical, u64 *length,
> -		    struct btrfs_io_context **bioc_ret, int mirror_num);
>   int btrfs_map_sblock(struct btrfs_fs_info *fs_info, enum btrfs_map_op =
op,
>   		     u64 logical, u64 *length,
>   		     struct btrfs_io_context **bioc_ret);
