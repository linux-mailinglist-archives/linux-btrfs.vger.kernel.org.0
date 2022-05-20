Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7B552E94F
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 May 2022 11:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346505AbiETJtn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 May 2022 05:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238325AbiETJtl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 May 2022 05:49:41 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455C0149ABD
        for <linux-btrfs@vger.kernel.org>; Fri, 20 May 2022 02:49:40 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220520094938euoutp0127159dc480031f8abfa5c2bff036bd28~wx0jBdPsT3017530175euoutp01V
        for <linux-btrfs@vger.kernel.org>; Fri, 20 May 2022 09:49:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220520094938euoutp0127159dc480031f8abfa5c2bff036bd28~wx0jBdPsT3017530175euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653040178;
        bh=Cd4MiX2UhhpYiFT3ppA9Gtgu70Wo18Bs/MRMVlg2BnA=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=ti3Rb4PwB44GZF/yJdzeUsvWUtkCBQ3PMzlnGpMY80lkyCA6msY3iILQWpAU2MnpM
         DO3lUiGp+LaHt8OF2kCJf0iPT1NhOInDGXY03dz78P35airgtLvzO1Urv6WVbi0EDg
         Zx5agAkjQGGGp1dLTuFLYUjUNVACCizoTU+0gWVQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220520094938eucas1p23722d7e99d34bea462d2cb15f2a2dbab~wx0ivf8XS3018230182eucas1p2t;
        Fri, 20 May 2022 09:49:38 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id E0.5A.10260.23467826; Fri, 20
        May 2022 10:49:38 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220520094937eucas1p21b0ff98b43c0450197c48f063ad6f43c~wx0iRhNuO2830428304eucas1p22;
        Fri, 20 May 2022 09:49:37 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220520094937eusmtrp1df41d4af75ff20ec34a3b0f69c75ccd6~wx0iQ7Snm1570815708eusmtrp1t;
        Fri, 20 May 2022 09:49:37 +0000 (GMT)
X-AuditID: cbfec7f5-bf3ff70000002814-c5-62876432108c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 98.B9.09404.13467826; Fri, 20
        May 2022 10:49:37 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220520094937eusmtip2512164f033948a168f0e6dfb92ecb28b~wx0iJcMu41937119371eusmtip2N;
        Fri, 20 May 2022 09:49:37 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.20) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 20 May 2022 10:49:36 +0100
Message-ID: <0c65b704-dd61-6881-fe1d-017c4226fbeb@samsung.com>
Date:   Fri, 20 May 2022 11:49:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.8.1
Subject: Re: [PATCH v2] btrfs:zoned: fix comment description for
 sb_write_pointer logic
Content-Language: en-US
To:     <naohiro.aota@wdc.com>, <dsterba@suse.com>,
        <Johannes.Thumshirn@wdc.com>
CC:     <linux-btrfs@vger.kernel.org>, <gost.dev@samsung.com>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20220517184532.76400-1-p.raghav@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.20]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42LZduzneV2jlPYkg78HOS0u/GhksvjbdY/J
        4tLjFewWE49vZnVg8Vi/5SqLx+dNch7tB7qZApijuGxSUnMyy1KL9O0SuDLmHH/JXDCTt+L0
        YdkGximcXYwcHBICJhKLHql1MXJxCAmsYJR4dHcrK4TzhVHi25pJbBDOZ0aJs9OXMXcxcoJ1
        NDVNhUosZ5Q40raQGa7q98Mb7BDOLkaJH8vWs4K08ArYSaxZPgvMZhFQlVhzYRIjRFxQ4uTM
        JywgtqhAhMS0WWfYQGxhgUiJ7llfwOLMAuISt57MZwKxRQR8JHasvcwIEbeU+LHoPQvIE2wC
        WhKNnewgYU4BK4kFL55CtWpKtG7/zQ5hy0tsfzuHGeJnJYltv0wgnqmVWHvsDNjJEgI3OCQa
        tp9jgki4SJzZcYURwhaWeHV8CzuELSNxenIPC4RdLfH0xm9miOYWRon+nevZIBZYS/SdyYGo
        cZR4emcv1F4+iRtvBSHO4ZOYtG068wRG1VlIATELycOzkHwwC8kHCxhZVjGKp5YW56anFhvn
        pZbrFSfmFpfmpesl5+duYgQmlNP/jn/dwbji1Ue9Q4xMHIyHGCU4mJVEeBlzW5KEeFMSK6tS
        i/Lji0pzUosPMUpzsCiJ8yZnbkgUEkhPLEnNTk0tSC2CyTJxcEo1MLXsfzAjJsTxmfy1GTc5
        9Qzz1i6P6joQcSs40sDTTt1/7a++qdNr17jxTIm43SylNWPVi/7pW+62XMksqv33X15Q2qJj
        808hjuWhfmEXjq87Wu2/7LzF7awTqzvrXib8aSn/f3d70nHvVQGH9u+esyH+kG1gl0IM8+t5
        vTcWP5cOO/fG3J25SVGI74Vyqm3Nu8hjzPpPZx3i94xwmlH5bY7u4TKjxcE+O10tf9Y67O9f
        pi/7iLmveobRiTtrzk9fErJDpVWFx3x69LulveFlH/c/74maNmej9jHG+dYHBJm+tup87NAT
        jtkw0bV6WtL7qJZdzyLybc/unqXR9XU3484L63TeNlSdZdb9JVB9U1CJpTgj0VCLuag4EQBI
        F1thlwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsVy+t/xe7qGKe1JBmuuaFpc+NHIZPG36x6T
        xaXHK9gtJh7fzOrA4rF+y1UWj8+b5DzaD3QzBTBH6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZ
        mVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GXMOf6SuWAmb8Xpw7INjFM4uxg5OSQETCSamqay
        dTFycQgJLGWUOHbiKyNEQkbi05WP7BC2sMSfa11QRR8ZJaZ/3QPl7GKUuPvoMCtIFa+AncSa
        5bPAbBYBVYk1FyYxQsQFJU7OfMICYosKREg82H0WrEZYIFKie9YXsDizgLjErSfzmUBsEQEf
        iR1rLzNCxC0lfix6zwKxrJdRYu+s6UDNHBxsAloSjZ1g13EKWEksePEUao6mROv23+wQtrzE
        9rdzmEHKJQSUJLb9MoF4plbi1f3djBMYRWchuW4WkitmIZk0C8mkBYwsqxhFUkuLc9Nzi430
        ihNzi0vz0vWS83M3MQIjcduxn1t2MK589VHvECMTB+MhRgkOZiURXsbcliQh3pTEyqrUovz4
        otKc1OJDjKbAIJrILCWanA9MBXkl8YZmBqaGJmaWBqaWZsZK4ryeBR2JQgLpiSWp2ampBalF
        MH1MHJxSDUyOc3ZVVNRZa3MqGSZ0rrDXqONKUvv6bMMlv3MhNTz3FFR8tljuD8w/PvPp5w0R
        H74LTe7eY8ZYfHrPtJiCv1I2yhFReZ0uRgppDK2zl8osP70m/f87NtFE4TSmTZ9+rJk+bb4p
        u635QtGCdZenHp0oGldueII98qehveHlhycT9Dc/Ddj3kbUo7vmz00aP+RjOcdscNI2rjpsv
        c5Lb/s3Jt0/EW9eLeX32Dv5T372Sfc2DDcolxodmv3tVapHyJ1+l9dNTwfvlW3XFHnItXWHE
        eCnp+KK8M0/Z7uwPNwhWVegNi7HJOzFvvl2v1CqGD4dvXhOdHzfH+vb8XuZ/R1aKVW87GXTV
        cMEMrTlcczYqsRRnJBpqMRcVJwIA/VjLZU0DAAA=
X-CMS-MailID: 20220520094937eucas1p21b0ff98b43c0450197c48f063ad6f43c
X-Msg-Generator: CA
X-RootMTR: 20220517184533eucas1p289b49362dc7697534f7243115758951e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220517184533eucas1p289b49362dc7697534f7243115758951e
References: <CGME20220517184533eucas1p289b49362dc7697534f7243115758951e@eucas1p2.samsung.com>
        <20220517184532.76400-1-p.raghav@samsung.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

ping....
On 5/17/22 20:45, Pankaj Raghav wrote:
> - Empty[0] && In use[1] should be an invalid state instead of returning
>   zone 0 wp
> - Empty[0] && Full[1] should be returning zone 0 wp instead of zone 1 wp
> - In use[0] && Empty[1] should be returning zone 0 wp instead of being an
>   invalid state
> - In use[0] && Full[1] should be returning zone 0 wp instead of returning
>   zone 1 wp
> - Full[0] && Empty[1] should be returning zone 1 wp instead of returning
>   zone 0 wp
> - Full[0] && In use[1] should be returning zone 1 wp instead of returning
>   zone 0 wp
> 
> Fix the comments to represent the actual logic used for sb_write_pointer
> as indicated above.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
> Changes since v1:
> - Explain the changes in commit log(David)
> 
>  fs/btrfs/zoned.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 057babaa3e05..c09b1b0208c4 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -94,9 +94,9 @@ static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
>  	 * Possible states of log buffer zones
>  	 *
>  	 *           Empty[0]  In use[0]  Full[0]
> -	 * Empty[1]         *          x        0
> -	 * In use[1]        0          x        0
> -	 * Full[1]          1          1        C
> +	 * Empty[1]         *          0        1
> +	 * In use[1]        x          x        1
> +	 * Full[1]          0          0        C
>  	 *
>  	 * Log position:
>  	 *   *: Special case, no superblock is written
