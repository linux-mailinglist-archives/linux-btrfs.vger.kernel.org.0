Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E445706199
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 May 2023 09:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjEQHrU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 May 2023 03:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjEQHrM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 May 2023 03:47:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E36BE0;
        Wed, 17 May 2023 00:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1684309617; i=quwenruo.btrfs@gmx.com;
        bh=Xr67vpYDyZ5grM4fMWPYUR80Gv55IfxlC1885OUfA3o=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=WchLrt6eVkYLpUN2cuW1RgdMR0azemJoPLfMHjBh2YS+D7QXS4byAI+RfDcnnC3ld
         9X/LQvoXxd82P2PDmVxeWbcadwCeA9QmTFZFelhXFII51jK0ADEKN/jejc/QDp8cW5
         9ox1idEk1yKkBmFvTFqAgdWmiffx6AwObRcm/khNvvDmUgBewP/FpobnR5kiuN3x43
         q6mQNxcfeRcQS/nQ1XKJsblKsJ2NEpDoj9qFgEG8oUKKsdJGLpv+tXaoKAtE9/Xvre
         PWisHDb82LhcGr267XmWGHM74SY3r4dDY155CxWxGy2DDFWZmtVjXkH1lp5xrnzW6y
         f8Jytw3E4HBaw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N0Fxf-1qKrE41zj5-00xOAy; Wed, 17
 May 2023 09:46:56 +0200
Message-ID: <f90eb6c1-4491-ecd2-1fdd-56580088c993@gmx.com>
Date:   Wed, 17 May 2023 15:46:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] btrfs: fix uninitialized warning in btrfs_log_inode
To:     zhangshida <starzhangzsd@gmail.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangshida@kylinos.cn, k2ci <kernel-bot@kylinos.cn>
References: <20230516013430.2712449-1-zhangshida@kylinos.cn>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230516013430.2712449-1-zhangshida@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7s+p74qnnrldHeSLzYQGpYmdqpavwMtTfkeBqDvEDOTm741G9bv
 zNig/R0gDVEc555Wb5Ndk952JhTCvP+ijCFtGIFPNgZk2PIr2NpQssni9tiQUHxajqLwI3p
 Dlu0gkb2Fw+Hi6ILNYGqtecfY6P3idbrZ3+jWvpqOjfddL2cdTMiPuJByx8N+RD9sSbYl4k
 BEhw4XqMYDL2UXigwUibg==
UI-OutboundReport: notjunk:1;M01:P0:nkRTytzW5tw=;2j13uW4JI0HOHzpfgjJ6SGhLHCC
 UQmZX3295FEHclYFcrkGyh1YAKdjSlACqosJA14niQ5nboUvzRZR25KYArgduryVKFlTGTBc3
 mnz0ITgZpQqj66RPj5e2QQ40YEPyggfcKD02hv0UX+gFtHAGoWtKOHfH+L2AyWY7TRSxFKgB8
 ylL29XQ4S89t+BG+o9an7wtkzC0T2vNFlJxYzol7RiXc37Y8/LRlb38eN1+n4/1tJEvwZqIiF
 btwCEb86ly/KFGGuP2E+MDA1Df8r3y7/lP1BKy7dlnYZ8eij+PHeOW3CNZE2hhw0Q0WOh+W1j
 T7RPJ9+Ql1AAsdVtc/EM329//R8xxpIKCRuXvDJblsAhgTvhstVMvAOO0a/oCbtY25fkCqYVR
 HXjXZNfjzYTfPqvyrzx2ibN/V5QKJM8eOgz41LGIW0ggcj5yZWL+xFca+k0s8M4uuWB/sfWok
 SLVW5obtJKJX5M0BzKRgzjAmmPEQETXbB+obuJKn2Wqvb/NfnIJ/q0zc5uTU0OayqELJyDeYs
 pcMuTIC4dLAgHtG94ufhP3nztJI/7NhitLg+s/M0LfVuU3oDcKgwGvMjBBOrS+U4RrS6n5A7X
 bwO/V5D/MrEwiq8kp4CmworOoUZQqbHMkJrG7nIXqWZwzRUxi1xePblJd5B/iUWkSMs+9JCao
 O23/H4oX75990BR7yVZ8NHj947Z8hOzGhrX3HvE6q/QqcBRWkm5xH3yMaknyNUcnK68Rkg20Y
 d//IJPJDNTNrWHDvX4qDVTC8dfvw3b5Uqo6HZLKV9vDDTBEWiyyJGN1f5lnZWQTr9xSG9poam
 JKGzZrBbzRs9M80lOABZ8/89RbjgS9StpNRcSJnaGggyDVF/AcgnUs5mjvncuZwA79qMsYJv0
 gBJo2djxu7hsucreuOQA8FP5ZVkF07kWe74bS0iAKQrLLFjLWhf60jaeXr6WOPaopB4iyDYbU
 W5LN3CmSSAkf2HsU/ib3vqh/Yho=
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/16 09:34, zhangshida wrote:
> From: Shida Zhang <zhangshida@kylinos.cn>
>
> From: Shida Zhang <zhangshida@kylinos.cn>
>
> This fixes the following warning reported by gcc 10 under x86_64:

Full gcc version please.
Especially you need to check if your gcc10 is the latest release.

If newer gcc (12.2.1) tested without such error, it may very possible to
be a false alert.

And in fact it is.

@first_dir_index would only be assigned to @last_range_start if
last_range_end !=3D 0.

Thus the loop must have to be executed once, and @last_range_start won't
be zero.

Please do check your environment (especially your gcc version and
backports), before sending such trivial patches.
Under most cases, it helps nobody.

Thanks,
Qu

>
> ../fs/btrfs/tree-log.c: In function =E2=80=98btrfs_log_inode=E2=80=99:
> ../fs/btrfs/tree-log.c:6211:9: error: =E2=80=98last_range_start=E2=80=99=
 may be used uninitialized in this function [-Werror=3Dmaybe-uninitialized=
]
>   6211 |   ret =3D insert_dir_log_key(trans, log, path, key.objectid,
>        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   6212 |       first_dir_index, last_dir_index);
>        |       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../fs/btrfs/tree-log.c:6161:6: note: =E2=80=98last_range_start=E2=80=99 =
was declared here
>   6161 |  u64 last_range_start;
>        |      ^~~~~~~~~~~~~~~~
>
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> ---
>   fs/btrfs/tree-log.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 9b212e8c70cc..d2755d5e338b 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -6158,7 +6158,7 @@ static int log_delayed_deletions_incremental(struc=
t btrfs_trans_handle *trans,
>   {
>   	struct btrfs_root *log =3D inode->root->log_root;
>   	const struct btrfs_delayed_item *curr;
> -	u64 last_range_start;
> +	u64 last_range_start =3D 0;
>   	u64 last_range_end =3D 0;
>   	struct btrfs_key key;
>
