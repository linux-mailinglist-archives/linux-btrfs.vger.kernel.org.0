Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A6B727A2E
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 10:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbjFHIlL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 04:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbjFHIkt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 04:40:49 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49544272C
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 01:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686213635; x=1686818435; i=quwenruo.btrfs@gmx.com;
 bh=0CHUKhbiKZINQAirRLv73mXWPvAYl6yOM1EETSphEzo=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=aVMOOcwQoZRp2MNLEHNU95MkdyVBRVWM473vUKvTDrZx1mWc4dua8PA3V7PZCjSFG/BWUpQ
 vSOgyQ+76uDXr92QI+8+4DYj8ie6obN9hfzx06XTTUR2kXDozZMEjtvs/wBwk8LR8lXT/sWwZ
 r+S3+EQCpxcDE4uCCqWtFG+v8xSe6wjVllUQkfK7B/qglEPkcbS5JIPc9KdJZbLH47YL7nXLO
 HrDOTrNyWker+9Z060gdZiX9D0FeCww0NK3CgFd4Ec0XJoBDivIPDHOTIT0X6+ZbFrXcpc++w
 yVDnz3untIylDpPvFiw1USpG5dk5HDSFvCjIn1jBzPJYPjhXNGJg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MZCfD-1qbn2x3g3d-00V6zf; Thu, 08
 Jun 2023 10:40:35 +0200
Message-ID: <b39e8fbc-7cde-c109-26f6-6fa39fc8a4e7@gmx.com>
Date:   Thu, 8 Jun 2023 16:40:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 02/13] btrfs: fix extent buffer leak after failure tree
 mod log failure at split_node()
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1686164789.git.fdmanana@suse.com>
 <33c0bac2c25c330f773ba765c98efa3992cdc166.1686164803.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <33c0bac2c25c330f773ba765c98efa3992cdc166.1686164803.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oY6u7W5vgDGtEl8Fjl1p63EM25gHtHANVEN1f0ZSFYPgb3n4aoO
 py/4aG3MJFbYIMedvKuC1EHGyoPrz0XDbWLXk0Chu+8Rk642JS1vGJxWMVn3vhaobfg6ieX
 9GZ2EzIH8/VIKLp17cpv9uo21ALMhA2oyooP5L39bSmP8WxNpsKssOjgr7SiefP86QZesqY
 WR7v7jyT+Ol+V1KPXjGeg==
UI-OutboundReport: notjunk:1;M01:P0:1fHfI4EO6qI=;kGuxylDkhONAUX0efyEJ64F+njf
 B3uxrpCIK1ygkRcX8h1N/W44u/HqolTzOxbKH0vXcXhERIw5EIrDXhhwmukW+DYtr1agm67DH
 JblyDIzf205z9caEKXIXFTZcoeYYan1WNTmBBw1CyOO6jUoQnVieiywIdzBPByZyXQPxgNx3R
 T245wiFcNGLOKTJpYhdCbRN54LCoLHnXYyYNgvQHN3axTCZ7X0VoBBQQOr5eHUQ6ttT0gZOEB
 F4Hkh0rUxOtEoiI0NepN0du6XI4izCZUVd3n2T+ZYfJBSIoKAChrNMdTkvR1g/hXqvAPR96f4
 oJBNkMIe0Gw+WW0tKulo9xgSbOkDGXXlbGZL9yY1G2BBce3/3NhZ8NnuA3iyGcrG+AgHqrtqx
 bVIev8Y2l3IL2n+T1ggJKj6cXBOq9ibAsqxhaCqc9vab/rn2CVB5ZTbXCkhlmccSuhlvlhLaU
 PBR8TpacmN4tPFNTduRqZv9iaKaoX0GAFUYfebZdWJFBLL/h+pHPlItqdpY5KdwqlDSxpN9vT
 SnC3fuYM1Gt2IBbISApL7Ft1LijMLIdHwh4vfVr6xUqtDLEyPMJw3Nn7fc+UhX69FByIE6HR1
 AYlv5SSJpIhy1KzV5qa4D+VTBrCmrEVVGc5VhWjbmn5p459n7fRH3M9Jdure4xbyq8PaLdxlJ
 6COVuQXu0Rd3iiIZuW/hTlhwfTUxcRoCb34NOrL0yFHrX7qTJYlox21APasZHxZ/HXpiSgYJD
 Wu09yv8INMad3WXL2QA0jkLyNlgPQvQdvAJzNa/d0QiOEP0iSFNvLESwT6aBIFq0sP85UfElU
 PE+R3jrQzybAW8gDFDUxHn70YajEs8NmK9RTzP9WNHaHaaK6pxIwlHHoAmmZAI1KT14Ot8rOg
 9UwxLHZ1W3kgEm0CjLhvvpd+QDxw4qtNroeDzYYKaVZXYlQ3Sk+DjiCtroX3g53sqWf55Jxrk
 rf0A6OPSPj6Xe7LPMM3FL3pOYSA=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/8 03:24, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> At split_node(), if we fail to log the tree mod log copy operation, we
> return without unlocking the split extent buffer we just allocated and
> without decrementing the reference we own on it. Fix this by unlocking
> it and decrementing the ref count before returning.
>
> Fixes: 5de865eebb83 ("Btrfs: fix tree mod logging")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/ctree.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 7f7f13965fe9..8496535828de 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -3053,6 +3053,8 @@ static noinline int split_node(struct btrfs_trans_=
handle *trans,
>
>   	ret =3D btrfs_tree_mod_log_eb_copy(split, c, 0, mid, c_nritems - mid)=
;
>   	if (ret) {
> +		btrfs_tree_unlock(split);
> +		free_extent_buffer(split);
>   		btrfs_abort_transaction(trans, ret);
>   		return ret;
>   	}
