Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74013446B94
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Nov 2021 01:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbhKFA3k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 20:29:40 -0400
Received: from mout.gmx.net ([212.227.17.20]:56181 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231912AbhKFA33 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Nov 2021 20:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636158405;
        bh=3z8MnSPmZRjL7UO8jpi2kyux8ikGZRqZXpNimf1XEac=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=e+E6MVBjM66F2bXgzynNAYxzJh37CcGk7gPdh4Prk6O3SSA13kyxii5vkqtg1uXBd
         kwysXT5/L7mS3oN5WPpQcQXUFxT8WFEKpPNJqTS6LYVqbaYtJ3J6BTJGriYB/6COon
         CHnK7iFjQuydFXtJ/cHQr3sruDRFJc+WJ8Ul5Bis=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M6lpG-1mpDI22MzG-008KXm; Sat, 06
 Nov 2021 01:26:45 +0100
Message-ID: <44a9bf05-a7a0-ff0e-c0dd-45fa86732a1e@gmx.com>
Date:   Sat, 6 Nov 2021 08:26:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 08/20] btrfs-progs: image: keep track of seen blocks when
 walking trees
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1636143924.git.josef@toxicpanda.com>
 <b0f1ed7e3a0049232fe27491c9931f821ee87566.1636143924.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <b0f1ed7e3a0049232fe27491c9931f821ee87566.1636143924.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:opZMgUUjGQnTQ/EDj77RuFLaUw0xPpb3JRdt/Fkk4kphiWEtWAI
 +IqowryZUCzd64MEDnLVKzwVEffkqpf1z7k5jp17L/mvzrTXZJaYLxI8LrJZGBbmctqhybM
 HzqFqfBPN7YCsohetHqNu2b5rnvlYfLxIrfDrI53p/cmpAhq1+ScBQ/JP21CTx3QSJcH4tI
 /lb+2TuIphJxg1hBlg2NQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:e7Qy7QFs6L8=:F8txgkd6hy4JzXUX0BfA5R
 pT0rXRx1CGjHiDysfYuq8J+REiTZGGj9ba6ad4lxLWVf3eFxNxcGLtfbQ4S/e3gwTPyu2T9Ea
 gFVTzp3pxaCO/8s069WF+E+DeFwINMw2L/36TUMOj5zWJWwJ0VKMFSrQy6lfei0zTp3ilonEk
 ly5ndCBf6lJ2Ifoo686XfWcydsuvxsLkq1q0iuabkn+q8g6lAnJ941lVb/7gPL2tMIikDCYoX
 G0OYh5ZZKYKWL4xUv6DAuLZXR8MzWJ1K4OXfEIqjj0mhSQ7boX2TEfMbLWJXZIgodz6XA1fgT
 1oFl+K2TN1L6lU9iGNO0eW5Ju1NE2ZAYkYZYHCk/XKXzqGFi1GtfML7x/qAZT10o1iGkEJV9I
 KjJ5hbbDa5LGyIJZwxKHzDIKmGMmaplmoVsI3BR4m8eT00hD64qN8SLaq03bb4pS1jbbNIUr1
 D993zLzCXiWdhctD0z9QCnqWolvJlN0ik9Z942G3EASS21IKng5I4eZkfQ+XfzRLUnaOM/Upk
 QcOYa1OfQKqbGyMtA4OVAVtbtcDzXguHlTQ3EyWqiFoQBYiI2ndxEHbPRAOJR6uzzbDogT/L9
 L44/XLS32zqfiOmRB6n2pzeUOnVsJQ1z62LIIeLmMHuWLnSpsj6urDJhtLEJGO9kEyZLCGG1z
 rseuuYEmQ+1B+eKGcbJeQGJu4WSv8r2Joad3ntHKD7Z9VbY2Y4+87Rer2/uV42E73q6huReQa
 CuDFX3D+v5j8n1fRNRUk3wEK9c5av8udi0ys6oQkddgH34bhmrzX+ainVfxfydZQ/u1ov/Q+s
 63XfR/WyO2eUNwEMayFtt30CIOZcTQ37Ar+OXqXaQJg2eWjCO9gIo56ZhNbLuKD3HESEpCVXG
 9yM1OhdfhqE8naQFQBhVRvJD0BFr2hYes/iF02U3JHO8IWeIrFXyCPyEAtNxEQbfHNQOYlXo/
 922JTwTYMHy0N31NcvspO1PZLr5TKARC+mejkJw1f/ve+wLDfLm68TApVXAvO1OaQ2Y59crcd
 1soQ8TYUujNI7Wx8qMIDe2P/fopyYlGq/dzzKDPrkRfRbMhy3v63T6lbZM5RyCfQQRLq7/+i6
 xtmcUq77Vogf8w=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/6 04:28, Josef Bacik wrote:
> Extent tree v2 no longer tracks all allocated blocks on the file system,
> so we'll have to default to walking trees to generate metadata images.
> There's an annoying drawback with walking trees with btrfs-image where
> we'll happily copy multiple blocks over and over again if there are
> snapshots.  Fix this by keeping track of blocks we've seen and simply
> skipping blocks that we've already queued up for copying.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

It looks to me, as long as the misc-tests ran fine.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   image/main.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/image/main.c b/image/main.c
> index dbce17e7..57e0cb6c 100644
> --- a/image/main.c
> +++ b/image/main.c
> @@ -93,6 +93,8 @@ struct metadump_struct {
>   	pthread_cond_t cond;
>   	struct rb_root name_tree;
>
> +	struct extent_io_tree seen;
> +
>   	struct list_head list;
>   	struct list_head ordered;
>   	size_t num_items;
> @@ -461,6 +463,7 @@ static void metadump_destroy(struct metadump_struct =
*md, int num_threads)
>   		free(name->sub);
>   		free(name);
>   	}
> +	extent_io_tree_cleanup(&md->seen);
>   }
>
>   static int metadump_init(struct metadump_struct *md, struct btrfs_root=
 *root,
> @@ -476,6 +479,7 @@ static int metadump_init(struct metadump_struct *md,=
 struct btrfs_root *root,
>   	memset(md, 0, sizeof(*md));
>   	INIT_LIST_HEAD(&md->list);
>   	INIT_LIST_HEAD(&md->ordered);
> +	extent_io_tree_init(&md->seen);
>   	md->root =3D root;
>   	md->out =3D out;
>   	md->pending_start =3D (u64)-1;
> @@ -771,6 +775,14 @@ static int copy_tree_blocks(struct btrfs_root *root=
, struct extent_buffer *eb,
>   	int i =3D 0;
>   	int ret;
>
> +	bytenr =3D btrfs_header_bytenr(eb);
> +	if (test_range_bit(&metadump->seen, bytenr,
> +			   bytenr + fs_info->nodesize - 1, EXTENT_DIRTY, 1))
> +		return 0;
> +
> +	set_extent_dirty(&metadump->seen, bytenr,
> +			 bytenr + fs_info->nodesize - 1);
> +
>   	ret =3D add_extent(btrfs_header_bytenr(eb), fs_info->nodesize,
>   			 metadump, 0);
>   	if (ret) {
>
