Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DADB529B3C
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 09:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241557AbiEQHmB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 03:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242353AbiEQHkZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 03:40:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BFA49264
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 00:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652773166;
        bh=8tsx7m51KpDjK5f6CB7uctsrdT4yxQ7hxnJl+WlR4NI=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=A/FpatNEJt75EFOJn02aH/Xxvt1j6rk8hd+xhU8+Vsym+ItfYEok6qWs/rUkS9FX6
         Dxqyhfv0GuG9MHmTq3oGA+429UcDfeKbrCuxU1R+6rAiZ6/dw8V0Mi2kBHR7lqo03b
         Y9PSwqd9yIllbQYNHy1z7+aNRjI3Y11d/a7P+VWk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MHoNC-1o4dhs3TvC-00Evpq; Tue, 17
 May 2022 09:39:26 +0200
Message-ID: <cf5f8445-a622-bc8e-bfdf-8084a00e87ee@gmx.com>
Date:   Tue, 17 May 2022 15:39:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC ONLY 1/8] btrfs: add raid stripe tree definitions
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <06a217ce02243fe88b9649d689df89eea7a570c7.1652711187.git.johannes.thumshirn@wdc.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <06a217ce02243fe88b9649d689df89eea7a570c7.1652711187.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jRZMljA947X8l6uupu0wxXHcuEXMKyYvt6WqQT3ocg5xeidqAVv
 qbV8N8LPpMpSQiO3wMuTPHtKdZWTeeD4dhUkrI3VHhbOoQpCxDkB90UsOTNM/yJL/IQfAZh
 bE+jEXp/+GkgckmkqBwo4EgPaZ9xkgtfNGiGKMuNDQQaGYBBccB7dlHdIyQx5pIwfzH2tel
 ct8silR/iNs8CNV8AWGfQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vDb0gZ4jF7U=:X94mWeo5kcnH+NO9MGSkee
 IDi1JsFJ4vygNdKxd9vgJmKRHV0F9gr5zz7dONgKuXHJqEfvDnXfXQgvax7M75rxvIU87Efye
 lFZqtUlzN5V3uSY8VkeV1IbmHU2JrF4mEXgQeTMgpIsaaap7FnCeLR82As5ysrP9mgqSp+I9H
 t5sFwy/6tOteQpmPnZyfID7Nyqa2irM9z5bdYUguudB4N8++kn88NgIJ9qHtXX6WDkrx8A3Lx
 /Zj+6KUg/OxVPNH/lAUjD8F95+5J5YrVCr267VxP0oKKuY5cZDA7tr7jXY1c/FRj7E0RIXU7N
 2kB8oIJcwV9rjh0unxKZgigyGggOChzW0v6Z7m1Vqh0bqpVBA+RGnXoRjzHPTOSjh+GjzqyJ7
 ne8NaHSnWe7t/S7s5wpYkwas6JVCMEJ+QguDLHzoXOfk40s0nhPCIZVMdhGTzitZ3pbJrjXN7
 ArwV+L8ZOSHw2fKBY5LRHYxGFeZ2uR1sgY1l0GXP9QjKPl1GhrXX0/TK1Ebf6hVN2VyfAvfT8
 mPSQYpA4aOxVFul415Psu1C1Kn5OSfGSAeRMn7d0X+SwTGhFw//AGjbIM7oXqJ8Hv12HtLUxc
 07+DNcSqKYJ9uS9RobU8LCMwcF9iCs3AqBF1n4YPOe/PEsHjw6uFvHxqGrkXto6vlHvbVRki+
 OGTnYcUlyu/qr6M6RkNr4yoM3DB5dPSSjYQZmt7UHY6NeyIq2oCpQ4zN3Ayl2WMJK1u3YbYk6
 gP7HAed7791bns1Hd/O2llnBJK36AZkYi9tgtgWRw44U5t1ZuTs5jWNdR3DWM8njXdLy5Qt+h
 uQMRqdNOKJ1De0zAgtjSJSTdvwspqN+sWA7yznu8fB+70b9UJZkltZZNAQDINgf/lGkfvvdID
 Gp2DoHxASMz8sKbVvfYsIAwDSjM7/KJzsUys87WWnPAWEGic8dFfgxulAb0BMOQSJ5RaJhoUM
 gI0WyKyN1WvIh9UYuHw62gH4JxfxxYFMlggXiaSLJVUhcfgyV5CAmEJw8I8m0IMDdXQZveNGa
 Yeb8lt8A6KOKgxT8kk3/4r52QP/ocaEIhu7CcW+eUb+9phBHmSDTYzFZvRjUIq+Bc4vSpFbWN
 TO4eNMIHAJ0Fa1xzOhj6pBoLqislO02aURo+NYguE1RYnaDQyYc+ZbS8g==
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
> Add definitions for the raid-stripe-tree. This tree will hold informatio=
in
> about the on-disk layout of the stripes in a RAID set.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/ctree.h                | 28 ++++++++++++++++++++++++++++
>   include/uapi/linux/btrfs_tree.h | 17 +++++++++++++++++
>   2 files changed, 45 insertions(+)
>
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 7328fb17b7f5..20aa2ebac7cd 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1878,6 +1878,34 @@ BTRFS_SETGET_FUNCS(timespec_nsec, struct btrfs_ti=
mespec, nsec, 32);
>   BTRFS_SETGET_STACK_FUNCS(stack_timespec_sec, struct btrfs_timespec, se=
c, 64);
>   BTRFS_SETGET_STACK_FUNCS(stack_timespec_nsec, struct btrfs_timespec, n=
sec, 32);
>
> +BTRFS_SETGET_FUNCS(stripe_extent_devid, struct btrfs_stripe_extent, dev=
id, 64);
> +BTRFS_SETGET_FUNCS(stripe_extent_offset, struct btrfs_stripe_extent, of=
fset, 64);
> +BTRFS_SETGET_STACK_FUNCS(stack_stripe_extent_devid, struct btrfs_stripe=
_extent, devid, 64);
> +BTRFS_SETGET_STACK_FUNCS(stack_stripe_extent_offset, struct btrfs_strip=
e_extent, offset, 64);
> +
> +static inline struct btrfs_stripe_extent *btrfs_stripe_extent_nr(
> +					 struct btrfs_dp_stripe *dps, int nr)
> +{
> +	unsigned long offset =3D (unsigned long)dps;
> +	offset +=3D offsetof(struct btrfs_dp_stripe, extents);
> +	offset +=3D nr * sizeof(struct btrfs_stripe_extent);
> +	return (struct btrfs_stripe_extent *)offset;
> +}
> +
> +static inline u64 btrfs_stripe_extent_devid_nr(const struct extent_buff=
er *eb,
> +					       struct btrfs_dp_stripe *dps,
> +					       int nr)
> +{
> +	return btrfs_stripe_extent_devid(eb, btrfs_stripe_extent_nr(dps, nr));
> +}
> +
> +static inline u64 btrfs_stripe_extent_offset_nr(const struct extent_buf=
fer *eb,
> +						struct btrfs_dp_stripe *dps,
> +						int nr)
> +{
> +	return btrfs_stripe_extent_offset(eb, btrfs_stripe_extent_nr(dps, nr))=
;
> +}
> +
>   /* struct btrfs_dev_extent */
>   BTRFS_SETGET_FUNCS(dev_extent_chunk_tree, struct btrfs_dev_extent,
>   		   chunk_tree, 64);
> diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_=
tree.h
> index b069752a8ecf..a2d28d83cc96 100644
> --- a/include/uapi/linux/btrfs_tree.h
> +++ b/include/uapi/linux/btrfs_tree.h
> @@ -56,6 +56,9 @@
>   /* Holds the block group items for extent tree v2. */
>   #define BTRFS_BLOCK_GROUP_TREE_OBJECTID 11ULL
>
> +/* tracks RAID stripes in block groups. */
> +#define BTRFS_RAID_STRIPE_TREE_OBJECTID 12ULL
> +
>   /* device stats in the device tree */
>   #define BTRFS_DEV_STATS_OBJECTID 0ULL
>
> @@ -264,6 +267,8 @@
>    */
>   #define BTRFS_QGROUP_RELATION_KEY       246
>
> +#define BTRFS_RAID_STRIPE_KEY 247
> +
>   /*
>    * Obsolete name, see BTRFS_TEMPORARY_ITEM_KEY.
>    */
> @@ -488,6 +493,18 @@ struct btrfs_free_space_header {
>   	__le64 num_bitmaps;
>   } __attribute__ ((__packed__));
>
> +struct btrfs_stripe_extent {
> +	/* btrfs device-id this raid extent  lives on */
> +	__le64 devid;
> +	/* offset from  the devextent start */
> +	__le64 offset;

Considering we have 1G stripe length limit (at least for now), u32 may
be large enough?

Although u64 is definitely future proof.

> +} __attribute__ ((__packed__));
> +

Mind to mention the key format?

My guess is, it's (<logical bytenr>, BTRFS_RAID_STRIPE_KEY, <length>)?

Thanks,
Qu

> +struct btrfs_dp_stripe {
> +	/* array of stripe extents this stripe is comprised of */
> +	struct btrfs_stripe_extent extents;
> +} __attribute__ ((__packed__));
> +
>   #define BTRFS_HEADER_FLAG_WRITTEN	(1ULL << 0)
>   #define BTRFS_HEADER_FLAG_RELOC		(1ULL << 1)
>
