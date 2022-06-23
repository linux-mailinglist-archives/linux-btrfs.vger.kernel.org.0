Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C47557740
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jun 2022 11:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiFWJ5i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jun 2022 05:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiFWJ5h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jun 2022 05:57:37 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508D52E9E7
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jun 2022 02:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655978251;
        bh=vLcbxtJKJWbEB/ku1DomHwBJN9pmmCSH8KfKNRNPdfI=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=F/4tMXlt+7zxPNwPYkwLZwrzP6FPBQKdgkLcQhhgULTLKJBVEPRwmPCFVo0i1d8U6
         XnIu1n+L658zh0OBkNE+JZaPOL0CCHaSMYkHEf+TBgoSTP8Rs7awvWST+AVDFjHzhE
         HKQue1XCbJOcSm2jGAzZzCK5D301GbInAYv/Fm+g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MtOGU-1noZSH0Vkk-00uqLJ; Thu, 23
 Jun 2022 11:57:31 +0200
Message-ID: <4466c55e-7270-7d63-a591-e119fb5e3f8a@gmx.com>
Date:   Thu, 23 Jun 2022 17:57:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] btrfs: Properly flag filesystem with
 BTRFS_FEATURE_INCOMPAT_BIG_METADATA
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20220623075547.1430106-1-nborisov@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220623075547.1430106-1-nborisov@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0uVpMG6xQdeXAOgXps1FRdOZQceVEfNJG2jV6+GdvbJHwb4CMhw
 deTgTFRmjsPHkrFuUu7qblYmrEJ6myhfuR+GNyiWXzo/FG2TksuQ92+l0rTWNbZ0/tBVf7P
 x6HSmvcrnemD9z8PyyIOJkDpK8ZY2EfaKuaV0J8sg+MztU79ohVH3o5vyCJEcxmtqAuJX/g
 bl4wrFDlElwctMoT9xJ+A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XFjcE6lUmoM=:WYN/Tvw/mUB6DszKQxRgrO
 YOFFeg9Kjyg1z75csVuXC2VDR4VjqarGYKuh4P+ZtKGGbJd9orxv69GWYVWyu631rqO9X1xzp
 9TpvKXUeEo6ZbxXyZDDDV6scHP8OpHtX44dz20oj/a8aRdsjCaj7f1JrcPWy9WKatu3w/rBOP
 97LbkrM6cKcYR8wajMQLQHIh8JKd4yRW9tq5V87g4Uuy/7AUj38aQypQG7bRrFPiD9ZoT7CsF
 k1ecbj5te/8aKMd5KbfCzwvOwgG+NJLPg3Kv/GheroBv7W8XcBKii6EwzVdO/CKuuhYUPOATb
 DC7GR5AybxDYlJuz6qursCnMM17Ta+1vGu4rZBI3Zy1zTt96xt1HJgXr9SLKpBpQfbEGcM8cj
 yTRlKogRdDh12hSBaOK/I523PQejxV48vt7ityVS9pGR4RowBJ+i452gMcjdFTTLxaV3gaVL1
 F1UiszvNH4YQ3uECp471RS6ALs+DAaT3EjN5hzcfS0eWUVQIPityJhCOSO2IDNsZFbdvOE+LW
 BybE1T1N4ckbNn5F5oAXz52BU95neKXA3jffB0UNnc6ZVIK2Zdm2YuuN6mRfMkN8Olw2FNnkM
 LEgq/KLmpDOKFf+QUz06aCrceXXhwIXbSvr4HDfp9k5m6PPtRAZiTbCR9T7i4KjZ/cwO2k5YH
 rRrZd2qbo7S93dTXhgl+2h9omtDULvbgbSB+fZVrsJCXRfMQKjDbk7EsLR5T+BBaQtorI56AY
 32D2MqR2GEMvapfp3bfouO0WrtKcz07rP6JEz56JDAWWSW0pO2m51gJ5UgMNib8tTwvOkb4V9
 Rgtuo3E0gm5LrvigqE7X6WohqB9GxYhkErimZOetCw/rpBzfO1h4Hmf1yZEt44cg6C80z0cHv
 Xv5G0k/3cQxvsKmw1zCgX7Y5JntJZqxaDNhxH4IiPWRtWrDKEcPtBsTYv6uTTtNBIzApc45Ee
 OfxT6qIWKMIxVfjV4nqc3PKR47P/wKiyETA9q8TomngzubFMC/8seX/tRGH2eKBv7oMiJh2s8
 Le1j7x76/xH12S6hubR64TPdsYsaRrXYpBC1QqxE8St19pX61hf2AplGNW3ewO14puMy1lKLI
 D/A15Kr2FCnhTMY470GuTq1bUTVhUCTYmD8rVQjBGSB32T38aLPQqClSQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/23 15:55, Nikolay Borisov wrote:
> Commit 6f93e834fa7c seeimingly inadvertently moved the code responsible
> for flagging the filesystem as having BIG_METADATA to a place where
> setting the flag was essentially lost.

Sorry, I didn't see the problem here.

The existing check seems fine to me, mind to share why the existing call
timing is bad?

Thanks,
Qu

> This means that
> filesystems created with kernels containing this bug (starting with 5.15=
)
> can potentially be mounted by older (pre-3.10) kernels. In reality
> chances for this happening are low because there are other incompat
> flags introduced in the mean time. Still the correct behavior is to set
> INCOMPAT_BIG_METADAT flag and persist this in the superblock.
>
> Fixes: 6f93e834fa7c ("btrfs: fix upper limit for max_inline for page siz=
e 64K")
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>   fs/btrfs/disk-io.c | 21 +++++++++++----------
>   1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 800ad3a9c68e..c3d92aadc820 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3464,16 +3464,6 @@ int __cold open_ctree(struct super_block *sb, str=
uct btrfs_fs_devices *fs_device
>   	 */
>   	fs_info->compress_type =3D BTRFS_COMPRESS_ZLIB;
>
> -	/*
> -	 * Flag our filesystem as having big metadata blocks if they are bigge=
r
> -	 * than the page size.
> -	 */
> -	if (btrfs_super_nodesize(disk_super) > PAGE_SIZE) {
> -		if (!(features & BTRFS_FEATURE_INCOMPAT_BIG_METADATA))
> -			btrfs_info(fs_info,
> -				"flagging fs with big metadata feature");
> -		features |=3D BTRFS_FEATURE_INCOMPAT_BIG_METADATA;
> -	}
>
>   	/* Set up fs_info before parsing mount options */
>   	nodesize =3D btrfs_super_nodesize(disk_super);
> @@ -3514,6 +3504,17 @@ int __cold open_ctree(struct super_block *sb, str=
uct btrfs_fs_devices *fs_device
>   	if (features & BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA)
>   		btrfs_info(fs_info, "has skinny extents");
>
> +	/*
> +	 * Flag our filesystem as having big metadata blocks if they are bigge=
r
> +	 * than the page size.
> +	 */
> +	if (btrfs_super_nodesize(disk_super) > PAGE_SIZE) {
> +		if (!(features & BTRFS_FEATURE_INCOMPAT_BIG_METADATA))
> +			btrfs_info(fs_info,
> +				"flagging fs with big metadata feature");
> +		features |=3D BTRFS_FEATURE_INCOMPAT_BIG_METADATA;
> +	}
> +
>   	/*
>   	 * mixed block groups end up with duplicate but slightly offset
>   	 * extent buffers for the same range.  It leads to corruptions
