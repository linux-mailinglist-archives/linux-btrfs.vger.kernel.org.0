Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3150F7ABBBC
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Sep 2023 00:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjIVW2g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 18:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjIVW2f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 18:28:35 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA42319A
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 15:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1695421706; x=1696026506; i=quwenruo.btrfs@gmx.com;
 bh=l6sq8Fz1zy8oIMWlOltCBG7Kup9sS+ipm8A7hZWhbRQ=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=ER5akyJvkVJfwxFxsI4jWlobEt/0cQP/9xiB9y6xIMvwyQFM/LTWNFgkhNE86+dMsKiBuPM10I3
 5mINV7GFt2zO9xOg6LMt4LlmVuTojFAO/r+O+0+hg+lsKxB+hXjutucbkEwr9rzumADQ/nQmf3r8v
 bUFHZduQitDYyEyjke/LIuymnuU1qf6aqlKxSKcCX1wZ0b8zfj66dbtxfTs4VAoMSLj/umdjwYTHQ
 K99yPN2BshtF2gFbMJ0kAq/W1q9YEXzymJTrO1TXbG7B2R2q638H3/3llO1JYg6NJXEdicGOHkYuy
 l0EVx5QDOiWk5aZk6DSUs9OKMpNKyA5Zb7+Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.6.112.4] ([173.244.62.37]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M5fIQ-1qlSWx3Evi-0079mP; Sat, 23
 Sep 2023 00:28:26 +0200
Message-ID: <fd48c401-ffa3-4fe3-b536-18413f4de32c@gmx.com>
Date:   Sat, 23 Sep 2023 07:58:23 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] btrfs: relocation: use more natural types for
 tree_block bitfields
Content-Language: en-US
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1695380646.git.dsterba@suse.com>
 <e62321f3079658ce3c5a278e48c84e5d66c306b3.1695380646.git.dsterba@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <e62321f3079658ce3c5a278e48c84e5d66c306b3.1695380646.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xdPt4gmyOtbIy1Q4ZZcOqy6jQFqLicfGFZAGO45TMLcKTXtLfkL
 xJnPWdh6Jnt5oJJZhnvdaRUKkDMdPZSJhpB/Eox+V9y0ysy4Gjzo+MGFLgiosIka1oTWPOr
 Gcap/FgvOf5vJ7IRD3tL/9znipCRYQ98lmEqBLZJsH3euI5bnP6cMUOGYa8Z1gxa+tRpqe1
 ZH7NOCr6Y6+ODCjpgI0rA==
UI-OutboundReport: notjunk:1;M01:P0:/5x0bNw6w0o=;4SjqgfiFLLTFg0x++aCdlIg+Y7U
 gyzU9D4pU4WYR8psHID7ekXmnPCAfq9ax2wHpRaVoioMnzitsGeaN3NJ4CUrUEyqy0JOTPKzh
 xUlvJpM9GWBunDFQ5RFp061uV37osoBVZUdOSc/yC9MFeVog3OKI/ber4tRM2AIOVDQIlLcsS
 KCT9R8K0qgdjEYJItUA97VlW9JbOHUZl24+KYu+6j+oAuC0VuC/x95DWp2JNw/49VboBcCvl1
 Cw1foel5fzZOclzSU6vlxCrAK+ocyJaunyTpVb0jBKMXk6CqxDHEbyJJUPXymK2HLl98szG5c
 swu1niRpON3cDNevn7ufh9qxjR7UPHgBvfwbOmuxV94u0XMMuzHfSUIew2FcR7RWxLvAi9jP7
 d7L0GxJLw4RWq5dakcfuBJ62UXJDEyhYxhGlSROLI1rwNAFFPXlC0FnR2Qmn9MRp1PLZihFbU
 Tn1N7FL6rBTdrcgGXBRinBZI9z1RhPWSuUe1/yMbJ8xNYBSvPJS+Nu3cvG3ldOQeA2njbSKLA
 j5pPCmsMEf6gtQ0GxDQfbPoWboqwUWZ493uGYLlkGYQHCRuLXb+BEWVFd0iOw2Po0yQsGHAsA
 uJggxI53BvUy0Jm3KAVIN1L0nQeYQiCVFZd8evMUKA05lPXiuzdWSzudSUEaIA/fOcc39INtp
 LIAG8gltXAe/Ah7Rlcq/uWSrcowuNQFrjuZdmBhIlQ72tNJq02kVZQ2h3F4P7kAg0XDNGjUHL
 UlZPa+stkF2fNpiqcIUzwg+EkFUz+YYJK2IuGAln9dXc7SsAUsey7ukpGgidfIEDkSezBxnJz
 8kuYWJyKFET9LlV2OOGhPxPtR5Fw9oU7vJyGFVchgCTKek8t+k6Os9PaeBgBMu60Jt5FA3QgA
 t3+JsBETQWTia73h0BwWtmJ4/dwAM7Bm1gq0sgW8G2PozyYGDNwJsLqG/uuFI5ZFb+mxEWbpw
 2QjznPRjrxk+qg1eUDLYXfNL5U0=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/22 20:37, David Sterba wrote:
> We don't need to use bitfields for tree_block::level and
> tree_block::key_ready, there's enough padding in the structure for
> proper types.
>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/relocation.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 6e8e14d1aeaa..9ff3572a8451 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -111,8 +111,8 @@ struct tree_block {
>   	}; /* Use rb_simple_node for search/insert */
>   	u64 owner;
>   	struct btrfs_key key;
> -	unsigned int level:8;
> -	unsigned int key_ready:1;
> +	u8 level;
> +	bool key_ready;
>   };
>
>   #define MAX_EXTENTS 128
> @@ -2664,7 +2664,7 @@ static int get_tree_block_key(struct btrfs_fs_info=
 *fs_info,
>   	else
>   		btrfs_node_key_to_cpu(eb, &block->key, 0);
>   	free_extent_buffer(eb);
> -	block->key_ready =3D 1;
> +	block->key_ready =3D true;
>   	return 0;
>   }
>
> @@ -3313,7 +3313,7 @@ static int add_tree_block(struct reloc_control *rc=
,
>   	block->key.objectid =3D rc->extent_root->fs_info->nodesize;
>   	block->key.offset =3D generation;
>   	block->level =3D level;
> -	block->key_ready =3D 0;
> +	block->key_ready =3D false;
>   	block->owner =3D owner;
>
>   	rb_node =3D rb_simple_insert(blocks, block->bytenr, &block->rb_node);
