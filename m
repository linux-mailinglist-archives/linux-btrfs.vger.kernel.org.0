Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C13527491
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 May 2022 00:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbiENW5s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 14 May 2022 18:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbiENW5r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 14 May 2022 18:57:47 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C337FDFE7;
        Sat, 14 May 2022 15:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652569052;
        bh=w8RMGlF8PBSTdY9uAdbVW6/7q/4v6L+pMSdR2CnBngo=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=DYB2dIZEVNkwu6BvadoxkaaI2Zs5k2rspunwNBRaH+0umVbhaLwJ+M88mb4N3vaPP
         v9fRQJjPBmTe/MdZSjKN/PVTW0kG5BhygEuTMTr3+m6lJlaY1W30GEPrPu/IfadiDA
         qQYatRvPQ9wVKwrIjk1qd10LgcLT3FlgmfEuCie4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mwwdf-1ng1tA0bU3-00yR7A; Sun, 15
 May 2022 00:57:32 +0200
Message-ID: <120e4c34-da48-7d86-4a50-c31a3804600d@gmx.com>
Date:   Sun, 15 May 2022 06:57:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] btrfs: Fix an error handling path in
 btrfs_read_sys_array()
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <d915ceb4d459aff89c0264113db21592a6806db1.1652517184.git.christophe.jaillet@wanadoo.fr>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <d915ceb4d459aff89c0264113db21592a6806db1.1652517184.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:00+xlstjVOSAPX9HMb0nU3WWl0szE8W/DslPlHX6p4SH0pam0RV
 h8bDuMtQL8fjAMeXlyq2eT4MUD9AXSo8Fbs0wjp1GeMhshysmONmsoBR9jHgOjghHVc0/nx
 IWwzmch1RP3PQ8Hlz9Yaj/z2QpMrv+Jwv+ebV0MDxbc/65wgglcXwtxgIZeycGFsfe75uMW
 mxxpEpOhulZ2s/xVkkgdQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1qn5SjC9dCE=:AyEA74wM8k1gm0dKavPbr/
 bLLNUwRx6n8Z4XnLoFAD7FpfqiACRNZtOreT58SZ6xBJDreKOMPY34HxVdvZIMDGgw4kLAbUF
 Hm7mgCdvLbYNuuL4X1ddEJUOOWp/STd7RmHBwRAIeeBrs4WiGcScaJc7TuEZNlEOPMZKlbkI6
 ZNBDypYd1cQToLjmB5QM20v2PlxwlDl6WmkJILcUUe0L2BLgihSuoYO5BFVR295dTncaV7VWX
 /pzgpYwM4ly2I5FwmQZaCqOkcTTyfem+QzQgI/ad3ZBExpsJtKOeYAycdpOx26dZGKBB5y80P
 87rnMyNQL5dC3JXxLHjJ9aGW+UPZZyxcjxJsxlMjmate2uv+B+avsAbUENT7fXGv46V8KTSA7
 beyI6rYBi2em1njSeUrF2hkDdqwgtKDhc4pHoDvOXLEPWffNVfhq7qAAvLeK/G0sbrPbJKAsD
 AsnsFWgRxsoYBc8k8ScW/9g7UwHj9DUWYah9jSKPat8gtY1armfu68UZtppBfq5nHAmw+aO5j
 0APfLxI+Kt9S9xLBYW+HBKg0nF8xrVRntLeRXZ/OUyZrnPHX/yOsd1TUP72RGqoTTbmqExQ4G
 d1GBil1SjcaxcvlVf9/2TKEnwGxhe29ZhSM8vSEQYRikNBTfa/sfM9Z/g5+NgpbOrfGNZL7ab
 7u1y+XraugPmIE+lh96fvNc+7+DzF7SM4yU57eDJyvak9/sH6KXgT7ZaVR4Q8svo1V8SeNfaJ
 aty9heq6Wpn/LRUej6lyl1LGbU6FfNm5pa+zo43tsuzjwluJr5q6ulDpW9t5Hwx9vkzCtA7qK
 pQkZfO2G5KFDEBpeE90jtrgd/O1vFgw3kHfbFLAY+/PaYP135aZTGe1l/MnV2DeH8Fo7QfLha
 6qBcwWiR3v2x3618ocUMrX01vnymI3dVXiR9wLgbBochqPF65mIB7SLuA7lpCigJq3Y+FJvq3
 UTwnWyAAx6jEtZjDEisIOUl3V/cUWsWmZb11sS0Pv0KkzzqCZ9anGSWWPyHs1aHI1H4W3T/kz
 SoSWPI7g7ZSeHygNGbNqnmPLIGgAHW+BV0rkhuzLfGUodxpeVMN8We4+bJQBTIlid7xkNOYuv
 RliX34r0sgH/DVPRTOOGI86YFpmVoV/hDBPAfDTNWVk717X3JIgh2uBKw==
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/14 20:01, Christophe JAILLET wrote:
> If alloc_dummy_extent_buffer() we should return an error code, not 0 tha=
t
> would mean success.
>
> Fixes: a1fc41ac28d3 ("btrfs: use dummy extent buffer for super block sys=
 chunk array read")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Qu Wenruo <wqu@suse.com>

All my fault, thanks for catching it.
Qu

> ---
>   fs/btrfs/volumes.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index b2d5a54ea172..9c20049d1fec 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -7359,7 +7359,7 @@ int btrfs_read_sys_array(struct btrfs_fs_info *fs_=
info)
>   	 */
>   	sb =3D alloc_dummy_extent_buffer(fs_info, BTRFS_SUPER_INFO_OFFSET);
>   	if (!sb)
> -		return PTR_ERR(sb);
> +		return -ENOMEM;
>   	set_extent_buffer_uptodate(sb);
>
>   	write_extent_buffer(sb, super_copy, 0, BTRFS_SUPER_INFO_SIZE);
