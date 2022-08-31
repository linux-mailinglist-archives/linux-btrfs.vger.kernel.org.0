Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC625A7851
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Aug 2022 10:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiHaIAZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 Aug 2022 04:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbiHaIAW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 Aug 2022 04:00:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8246529832
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Aug 2022 01:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661932817;
        bh=CqDcMDiZd65FdLIejoTpgjwW0ucATGg2lFmPwRMwcRI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=MQZcqKp7kfRb0pFED6cexQiZMAxwdHVPgN6oXjcXk+jtK6nmerf0oVvc6hhO6HjVT
         R/ztyoRdEFZQwVqKXj09mUa4uGih2JHjJmMK/W/O1vS1bfj3k4oZ0OEB9K1fmpt3i2
         +9j1ZreIk+QJaPjOD/+R6tETsIfaVHC7v7wfle7Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M5fMY-1oUwXK1SVm-007AE8; Wed, 31
 Aug 2022 10:00:17 +0200
Message-ID: <bd6749cf-d04c-a26e-992b-a0f40a4461c5@gmx.com>
Date:   Wed, 31 Aug 2022 16:00:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] btrfs-progs: free extent buffer after repairing wrong
 transid eb
Content-Language: en-US
To:     Su Yue <glass@fydeos.io>, linux-btrfs@vger.kernel.org
Cc:     l@damenly.su
References: <20220830124752.45550-1-glass@fydeos.io>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220830124752.45550-1-glass@fydeos.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VFZyTWPtlJVHNeeeKBM3BAN43dW6tAr7sc0hyIMNtcaoI1F25tw
 w0TtuASkP+vN18BQ359luwlkTZTzqt2ShVmxYGiUIT6ybuIyquiByUHuh+bBDMzKjj6/jsQ
 9QbNTLXQWTRqtrs9rhG6byyMGvQ+XMWbRPqMo5qMuDmy22+gtgGknb6/ejhPzStlDA8pOL0
 fdRJtPZWT8lmJu3d7QcuQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S2ugmXyVt+E=:bHyaCELGfMsMvOfNvkbBr3
 +UtDmLspg1VgNciD4fJxbbkcK5IOqWkSzPUJ+ET1C4Mmk5vS3TDxJOzRx1Njgi472KfM7TQVL
 ww279PJ6SneWoChR68UoZkUmUUGKxDPl6g3eAvg6LC3WIyBkXqNnXvM3bp1cvZnyY51NZlc7q
 uhBKmDnnMT3PRra0BHsD18h1pmuMk+UaeFdF5fLLHuEVQeQNi131PXg1sWs/wtZbz23unSdzY
 hMnQRsd+w2oj0VN2CFQQJ291+dxB/4ELd1J2yh3YN9etIu+kuCKweYD/l4s0UcIhApEQ2oNej
 rjCDROpMN9RzGadzPZq3gsKE/Lm3AO/vuADAFGYH510g8JYrojVSLny1/jpQqDOUGikD6RW7r
 ZTtV4HgtrgyIqQRaxjSWZbtYT5q4eYKelNt4jNDFS1LLE2FWF82/2xNigGJ39sMzg1vosTwYK
 EvB1myfxurn7aGdHWdbEPHjkPaIM1TDgVTWgN5RC8MpGkcRZMlmrdU3SkJR3X89o9k/pNV4y8
 SggoPwlOILm1gUZ2Czc807j/S19SJcR4P53+xEnaJxeueCYwO2voGI9mOndZ198iaABuOKtSQ
 5YtkeY41uhXuo4175cpD3kpnt2RgHuhIsm3SFk5R3uGwEHzJ8tZ7QPrtt3ePsgICYIYHSR5I/
 0gft0qu7/nseoPaN5OPfi0G/nuW3Gy8ZG6pYkCgZG9nY/jtVxSAFg4XNkPARaUlaJBws+SH4J
 BsmvdzJosEsnD36JyZOh3xbqq8vuF+mgGuJG/ri3xACcNIgboSp+3s0TRmvcv2iLS2oJ/LvXw
 KmgkZf6PBkKHKO3DADctMKySsyY7pY0zExT9u0OfZFV1sRtA2E91a41sao+HF7nHRwXVmqzxW
 hzqndC2s1FwULMFiGAGWvMmJ83QxZE26eSYyuldlNsKge+vOsA9+NUPL0P97MZpB2wVkDhT91
 eZ/GK73/OMRYZLmDrs+idEVz2CS7AqBPi6XVnj+UZ9kBgLwXUHUd4pjXWXdsu5yS97xiPneW6
 AJjx6TEvU414OssgsXAdyPcA4MDxwaTImYDcr2rlTnpiYUphydPrmjJhgfLvM2CcZbefFYznz
 5VR4c4m4Gb2/A4TBthHcUObOjtataKSylXCtLXX+4BtDdmPLxvQZ1Kx/7oA8uBjzzUnq53+TM
 gkZKPrDEna/WqkQkitFL42P9g6
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/30 20:47, Su Yue wrote:
> In read_tree_block, extent buffer EXTENT_BAD_TRANSID flagged will
> be added into fs_info->recow_ebs with an increment of its refs.
>
> The corresponding free_extent_buffer should be called after we
> fix transid error by cowing extent buffer then remove them from
> fs_info->recow_ebs.
>
> Otherwise, extent buffers will be leaked as fsck-tests/002 reports:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D RUN CHECK /root/btrfs-progs/btrfs check --repair --fo=
rce ./default_case.img.restored
> parent transid verify failed on 29360128 wanted 9 found 755944791
> parent transid verify failed on 29360128 wanted 9 found 755944791
> parent transid verify failed on 29360128 wanted 9 found 755944791
> Ignoring transid failure
> [1/7] checking root items
> Fixed 0 roots.
> [2/7] checking extents
> [3/7] checking free space cache
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> extent buffer leak: start 29360128 len 4096
> enabling repair mode
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Fixes: c64485544baa ("Btrfs-progs: keep track of transid failures and fi=
x them if possible")
> Signed-off-by: Su Yue <glass@fydeos.io>

Great to fix the fsck/002 runs.

Have you hit any other eb leaks? My extra noisy patch to crash progs
when eb leaks failed at fsck/002.

Not sure if there are any other remaining.

Thanks,
Qu
> ---
>   check/main.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/check/main.c b/check/main.c
> index 0ba38f73c0a4..0dd18d07ff5d 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -10966,6 +10966,7 @@ static int cmd_check(const struct cmd_struct *cm=
d, int argc, char **argv)
>   				      struct extent_buffer, recow);
>   		list_del_init(&eb->recow);
>   		ret =3D recow_extent_buffer(root, eb);
> +		free_extent_buffer(eb);
>   		err |=3D !!ret;
>   		if (ret) {
>   			error("fails to fix transid errors");
