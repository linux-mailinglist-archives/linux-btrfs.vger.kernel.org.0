Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C23A797F7A
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 02:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236933AbjIHABR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 20:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjIHABQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 20:01:16 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E0F9D
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 17:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1694131269; x=1694736069; i=quwenruo.btrfs@gmx.com;
 bh=QpsSREMz+DHMx/FT6lf9QKHc7ZLDBl3AIn9oBBtO8pk=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=iPbq0yKH8xWsdGcRQzyu5yLcMIPKcrsQBloMv93MPKFi7MVBjy8HcXZ67U3jgQMn8rZvMOI
 fYMgseQFz77hpIjCV90lnSnb4R/lwcc6UzNmBh7lOdaC9JErN42lHoPrSVVNEgb/jMXmzbBO6
 CDB7wvW+Lye1+bvIXWwt0E+WOb2Xh1QhRAoagCPtEz/Df2digqOOB5XM0YdhWs0ARQwT2jl4Y
 BxJ8yavPEDn9ONGvInDThVI8/aqsxCvGtYpCKrtJkiZuAwtdaxzOtlLXCe+jsdRzo5/Uch6/b
 nsFQS/LGt6f5klAu/OOQUbqor/6utosZMqZwTOsXP9s+Qs0WTjEg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M42jQ-1qeOvs3j9s-0003QV; Fri, 08
 Sep 2023 02:01:09 +0200
Message-ID: <c2edc383-1d2a-4349-9492-4246779a4a21@gmx.com>
Date:   Fri, 8 Sep 2023 08:01:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] btrfs: reduce size of prelim_ref::level
Content-Language: en-US
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1694126893.git.dsterba@suse.com>
 <270b9ad9e44ece857f8ec5fa006a484459c1fddd.1694126893.git.dsterba@suse.com>
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
In-Reply-To: <270b9ad9e44ece857f8ec5fa006a484459c1fddd.1694126893.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aUaKYuGmcDg6WGVPtVdfXSN2MVNauD1zKrTnO1xLZlyOehrbkya
 JvbUTt5QDfJxJevMNbyd6eggXtIj2/attMgLLLoFEC1iQamsNS6y68RQMMAbmADBJtBxDIF
 7dApsbIR8X1RNjc9g1ps82ZfFWIsZImEYawNHguyxtuwaTz1cuycPKeI8WPQgfzxapdN0mU
 tTsk9FYlRUa0ncciRut0Q==
UI-OutboundReport: notjunk:1;M01:P0:gn9i9+bDEAc=;vAFSY18V2dtcLI36lsF/vPEueqV
 rhEc6AdQxy4U2oB8qfhg1wfkDhwwHLwmDaZ98nZljNnXpoIC1FjuyrONzbdXVkiK2VPtrVxQS
 Xjpl354K2lAvWUAmVSbdF7gPIYwUitFa41UPTUaKZOW+7Mobpw0r399BRkM94aEYNXPIuGNpt
 /r0jh72F1I2zPID0TJ84DvLwYSmkfOoJ7D1iCWKjVWK25f3u65DuQhUU0SBfr4TwsOgAHU7Cu
 OTqyFKErnaow/Sp2k2P7ZNAf6gpGQuLZAfDNT82+670I58nsDK8uoVlX6T+RXmNbEAhMmdyyf
 8YfLa6rwCfStG+hahUyuJJGYe/OkG0SS7OjNJwcDceRfAty8HoigUcfPbq7Fg3x2YvBxXNbMG
 +zJ6B1KgEp42URn69dU7pmFw2ShwP6vjCrmE1mgx5iXVuce3aXPwoqrgt5NYCYUMaus3tEd1j
 G2rI1L1wQWYHQ+rWLCY9l8BF5P8ba7x4ppzUSygoVFjWiJTTD2wAGta0upH66hnfqfHuJJk8C
 2Tc8dqYH9qU7x0vVpE9RFvGEDW+fnpUY8U+iS19531M76IY4716X8XO7uA3OjsECBp8rZyw5G
 ce7KIsQhl5iHKZfMNdErVLikKxRd0n3RehxpAcFS5pqN+fx9gUwAHKofNo+pwScdA631rJll8
 W3gF2zrNxDAEydlZcuDr73xg3vlpYHst5SbRiTKoQIYojVJmIWoC3t1fKvJXkOcS56+EkPSwx
 5SmT4R9A9Wftu8QKnNpyTHcNSG8P1x0iwr1oANIhEVu3KbT27PztMB24uBoslAFiPTX5ypnOk
 kTCJlWyoauf1NRKMlFddwl4STC2ohv0JaRQvmJomuKt9j6D5CIgm6Nf44i/aMk41tR7J+MEQ2
 eOiin8FNgEUeVFYeULns4tFysiU4sII0WqiyAzC1wqUlmgbcNef3tiyVuv9K9rdwLH4QMIwtf
 or0RddDSLtQsD9DF8y5RsnKpcIs=
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
> The values of level are bounded and fit into a byte so let's use it for
> the structure to reduce size from 88 to 80 bytes on a release build,
> which increases number of objects in the default 8K slab from 93 to 102.
>
> struct prelim_ref {
>          struct rb_node             rbnode __attribute__((__aligned__(8)=
)); /*     0    24 */
>          u64                        root_id;              /*    24     8=
 */
>          struct btrfs_key           key_for_search;       /*    32    17=
 */
>          u8                         level;                /*    49     1=
 */
>
>          /* XXX 2 bytes hole, try to pack */
>
>          int                        count;                /*    52     4=
 */
>          struct extent_inode_elem * inode_list;           /*    56     8=
 */
>          /* --- cacheline 1 boundary (64 bytes) --- */
>          u64                        parent;               /*    64     8=
 */
>          u64                        wanted_disk_byte;     /*    72     8=
 */
>
>          /* size: 80, cachelines: 2, members: 8 */
>          /* sum members: 78, holes: 1, sum holes: 2 */
>          /* forced alignments: 1 */
>          /* last cacheline: 16 bytes */
> } __attribute__((__aligned__(8)));
>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/backref.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
> index 1616e3e3f1e4..79742935399f 100644
> --- a/fs/btrfs/backref.h
> +++ b/fs/btrfs/backref.h
> @@ -247,7 +247,7 @@ struct prelim_ref {
>   	struct rb_node rbnode;
>   	u64 root_id;
>   	struct btrfs_key key_for_search;
> -	int level;
> +	u8 level;
>   	int count;
>   	struct extent_inode_elem *inode_list;
>   	u64 parent;
