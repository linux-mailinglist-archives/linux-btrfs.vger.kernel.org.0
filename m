Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D69797F84
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 02:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240155AbjIHAGP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 20:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjIHAGO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 20:06:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9969D
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 17:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1694131568; x=1694736368; i=quwenruo.btrfs@gmx.com;
 bh=1q8jl6tZtNazJvf/B0LZEY2PCc1CdUxkuPmn8ddSjHc=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=fqSZxVihBW5cvwSZyNLkxzwPcEgmyEhfu9hvvsjcrKlsZuDweG2UYQEN457RgJLpcoCJFbq
 c9A0NpdZx2fWvermtizaKUyGh1Tz/oSSLQe9LLALIvHzKuVgljezRsEKAZ+0yDkAbEe9jkJrX
 wysb84HsinH1qjZQBa2urBrh/g6t0imuUMWcCO5ZvJh5h89op+PKHnkvoGH+GHF5p7mWeNdaY
 WzDtmOwGe83DxWl5fYzziI1ZZlyCfIwismKEV1vh4+kPqNJn89WL6EC/7vFC6dTuOqPSG7S54
 l6iEoEjT4cW9c9RB2bK0i7bJLCOCAqnMcBRHIBqU+6XhS9OKynMA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTRMi-1qCnxr2CHk-00Tlg8; Fri, 08
 Sep 2023 02:06:08 +0200
Message-ID: <d2f53cb0-7e09-4211-bc21-e2a4fc195dfa@gmx.com>
Date:   Fri, 8 Sep 2023 08:06:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] btrfs: reduce size of struct btrfs_ref
Content-Language: en-US
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1694126893.git.dsterba@suse.com>
 <c9b508651bafb53e98b9f194271d4b7b2d309cba.1694126893.git.dsterba@suse.com>
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
In-Reply-To: <c9b508651bafb53e98b9f194271d4b7b2d309cba.1694126893.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bFsKk5ON3mKh6qgxP2H3U64BK2Y1DjoXjY067HuEjKvRekYhFZB
 789rgadYcxUWAAuIEjp1RePmf20HUiT9ks3ve6bFhZtdPHo/X8wISdj8ADZGspwG0Dbs/qn
 ybNzYfqxnpFcJz7+M5BLYZLVri8+pM2vx5M1IzM+cRskU2PvxQbSAlIdQZYs/f3651IZGju
 SUGaNzqwVKFyfvjNxK4ig==
UI-OutboundReport: notjunk:1;M01:P0:6OcF+YF5ITc=;CyUEv56JErnmF++u55gQt+uWviG
 US2CXo7B0NlaL3dJA5Wh9fGgYW8Dwd34DShAIQ4jJD7rAm1lhRdEfBM/j8Cwaa3XDK/rnXaWN
 JrwhJi4vM5HVljKCtArSt2A4uXFJY8dSHUcOYWKaldJ7G3Y3yyhDG/DMb3LAK4lz9TKj5FxmM
 6DaKGY9efJJCH5Gx26Vc2lguVG2hSpEmT92UIPExIK4pwjVYhaRDnaT7VdefB3SDeNslwcnGw
 w7D8d7eThjqCRFOIEJl7w8It5rhunNdtaJCTptDVj6Q2KDVwDGgmwD5CmKhJYpFzxxfWr2PR2
 6fA1KrbkH5kJzxakvb0wsUrcYzMf7/hS4q6bVOu4Pvkungy5H27OzFirfLKZ+/MRce94UxPpe
 4swaYts2zNwVfK/6DCQufLACy+w1dD/aCLRE53TFWjQo6ydKU+UMs7kb7v1XilMW6+oGe7NY8
 gBTmDiR5dXe63BRb94WaNLIYY7B+klOiCRyffmvKpArBZxfkZ46KZ8PpWLMgqRZV8eO35i9Vq
 2NiF1OFjzeEYXKK8ReOcpgPCPZ0sTC7hEyph1omg/uFpRro1Vp2bEdlsxDz3R13whgze5On4U
 vFAKgS3/7NeLoOg8fodsi472xDZV8Uiri3Av7BnUfjkfjTMD5T/OR+8XKJAl5XJecTNHMAGHP
 A744ssx+Hj5onDQGWRZrG1Ls8sun2hLTs/bMnoV8WBYeciiFssWlAdP72dAYdHTRDSrnc5i0d
 FYixR+5M6JkVpd/gge1xY9ZDc2aAWW/KM+fL0wN2GKZ2bw/brgU7o/PsfCtKITd0K+f/+0rGR
 TMfr6CD2ZPd4SPMwLTIt/YP7bFzX1JhVhiV3BGQ4+5VeOHX+8eZw6Qxdt6MD6z2npfpdwwO/j
 /tO1gikbb4aK7UJB28+HYlUDaXC1f4cBABZDVn25JlLwrYKPuup5C+miKGwb3S9+fDZt8wxI5
 /eDnADV3CJ349Ws9DuWZE1CtitU=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/8 07:09, David Sterba wrote:
> We can reduce two members' size that in turn reduce size of struct
> btrfs_ref from 64 to 56 bytes. As the structure is often used as a local
> variable several functions reduce their stack usage.
>
> - make enum btrfs_ref_type packed, there are only 4 values
>
> - switch action and its values to a packed enum
>
> Final structure layout:
>
> struct btrfs_ref {
>          enum btrfs_ref_type        type;                 /*     0     1=
 */
>          enum btrfs_delayed_ref_action action;            /*     1     1=
 */

Considering both type and action have only 4 values, we can further pack
them into a single u8.

Although this means we can not directly use enum type, but u8 type instead=
.

Thanks,
Qu

>          bool                       skip_qgroup;          /*     2     1=
 */
>
>          /* XXX 5 bytes hole, try to pack */
>
>          u64                        bytenr;               /*     8     8=
 */
>          u64                        len;                  /*    16     8=
 */
>          u64                        parent;               /*    24     8=
 */
>          union {
>                  struct btrfs_data_ref data_ref;          /*    32    24=
 */
>                  struct btrfs_tree_ref tree_ref;          /*    32    16=
 */
>          };                                               /*    32    24=
 */
>
>          /* size: 56, cachelines: 1, members: 7 */
>          /* sum members: 51, holes: 1, sum holes: 5 */
>          /* last cacheline: 56 bytes */
> };
>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   fs/btrfs/delayed-ref.h | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
> index b8e14b0ba5f1..224278d4516f 100644
> --- a/fs/btrfs/delayed-ref.h
> +++ b/fs/btrfs/delayed-ref.h
> @@ -9,10 +9,16 @@
>   #include <linux/refcount.h>
>
>   /* these are the possible values of struct btrfs_delayed_ref_node->act=
ion */
> -#define BTRFS_ADD_DELAYED_REF    1 /* add one backref to the tree */
> -#define BTRFS_DROP_DELAYED_REF   2 /* delete one backref from the tree =
*/
> -#define BTRFS_ADD_DELAYED_EXTENT 3 /* record a full extent allocation *=
/
> -#define BTRFS_UPDATE_DELAYED_HEAD 4 /* not changing ref count on head r=
ef */
> +enum btrfs_delayed_ref_action {
> +	/* Add one backref to the tree */
> +	BTRFS_ADD_DELAYED_REF =3D 1,
> +	/* Delete one backref from the tree */
> +	BTRFS_DROP_DELAYED_REF,
> +	/* Record a full extent allocation */
> +	BTRFS_ADD_DELAYED_EXTENT,
> +	/* Not changing ref count on head ref */
> +	BTRFS_UPDATE_DELAYED_HEAD,
> +} __packed;
>
>   struct btrfs_delayed_ref_node {
>   	struct rb_node ref_node;
> @@ -183,7 +189,7 @@ enum btrfs_ref_type {
>   	BTRFS_REF_DATA,
>   	BTRFS_REF_METADATA,
>   	BTRFS_REF_LAST,
> -};
> +} __packed;
>
>   struct btrfs_data_ref {
>   	/* For EXTENT_DATA_REF */
> @@ -223,7 +229,7 @@ struct btrfs_tree_ref {
>
>   struct btrfs_ref {
>   	enum btrfs_ref_type type;
> -	int action;
> +	enum btrfs_delayed_ref_action action;
>
>   	/*
>   	 * Whether this extent should go through qgroup record.
