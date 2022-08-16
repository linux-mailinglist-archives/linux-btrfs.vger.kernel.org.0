Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F21595289
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Aug 2022 08:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiHPGaS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Aug 2022 02:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiHPGaB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Aug 2022 02:30:01 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF3E3649CE
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Aug 2022 17:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660610726;
        bh=uX0Xp40x8zJe3SWBPoegHG57D97DTPCeZpUXLT+pEeQ=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Y11cSeI0AGDhhq5XrpDiXFbqJXW9h2L29NIY7eCCFIrwSmqrlXQuourdB5pEQv8vT
         O2QFoZD93aINE8FH/1QAoW27sj4JFGBbndgNka8+36Doo1zNgk0+O1FuXlnSu4JUxN
         FIozKLOix2ybfnJ+DeLfjSogxbIggbmaZ7lZI5qc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MGz1f-1oAGRS2stP-00E5P0; Tue, 16
 Aug 2022 02:45:26 +0200
Message-ID: <f578f0d3-5433-36be-26d5-851833624c49@gmx.com>
Date:   Tue, 16 Aug 2022 08:45:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] Check if root is readonly while setting xattr
Content-Language: en-US
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.cz>
References: <20220815193402.7fmuwafu3qpalniz@fiona>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220815193402.7fmuwafu3qpalniz@fiona>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qsh7IpRnyllAA6MuxPPpygfVIrhjHaxTKPX/AvsK5e6N2n8FRic
 3zNKtjJyAtAChS24ix68K1zpfY6f4QBPxjsqbD9BDPHmiv1x/p0ErXOx6DklZXKUXd5uluO
 a8jYh3KHPkQ80TwlDYABzUyd9+hpJIexd/hqJakTJR5GgNqAO/6pCmhggZPt4m5HwKiyXz7
 VNr5qxNmbVE0Zke/0t4rQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sCLr91/6wCc=:qM11MG/kYapo3XcSQDbtwU
 otNOYnagJfzgG8BWCOGC0V8bD7L7kMHDxN1mEVvbcvQAMPPO5LZfruzymYepaRRYp1mILV1Xf
 DSqgzLxa9GSOO7iyEk3fbIEujf9L3rCp4ZFpEPlNg7OILX6SuYZG/o0U7ZKGzyvNjZoAcxvAU
 z3tMoZl520osMyZ2h80uIZ8EbM6NfX/UdTYJvmRg7O5/yZ2K7UkwqqWpOsQqGrwbJhN2zFPWS
 TBIkoHN2L744rAGxUH5YE1sWh6HrbWVNgzw+exZqj5yyYCe7nB+BxAf6BP6wqxUhJylZL/GHj
 mAGDhCT2P3r0cqWqO2QWjE6JVSBzxkZYHjFAifDXBkgTlJIYINxz5REKuR0THuWLZaMzmaVNu
 4G3nDGTC93ImFrybRYqcbmLQ+hx5wTrkwNqJuc9jpstWzCNSTbpeSJHYpe9S2AMh6/802g2u3
 BjZXi5+jH2fQZEbe0IHMX8NwAxVSEc7hMIjWaO+356JRPCaPiTZjPBG4Tjdb2yxJw1/jW5DbS
 yE0rSxWi/EMJALEjl8l9TGONV0ZQ4K+I+gCoh0+iScOAzAa7cjLC1RC9WAUNBNCTjfeXGzNyg
 lHCMuCermWiodAjfoTWyC/BghyK79NRWJcRF/fgMtQyZia8RuckiYvNkkdMmsmGCYfo/b6mQU
 O1lnlK34Obe48DNzFQrTn0jtLYCRkl2bt7a91QnpFFRTKoG8oZhq39Vg8hy2xOgvlTD2jqt4/
 5rKvkC4wKr3JKwbi3jGd0yzlCgcQ17lyuQdy9RLYUbB9tb+i1/DLC8t47Gsox77W20ook+tuK
 m2SmCqd+rF7u6kOjkizG0VjMJTITueaL6aXPEYwosrX7W/00XAVlC5d5bXmqZbobPZMSgIC1O
 4MayMFSVBIIhxU23pktTtNudECXDrf3nEIgxHwqnmlH7fLxFVzm3e8hycaQK9C81VGpaCXNgF
 dNyYGDsz0SI/Vc7kox6uUaKRex1TBG9Sd47uYsOK66308e9c8KWn1uW3VLIPt2wI7cLh/omm6
 NagDLItYf73uxmLiRoBkpm3pn11qinaAmR2X8HgjpmE+cKFARSkd7hoqJGJM0KkQHUnKxXtl3
 cJNYybIyyFFV0o1o+KiYIqajWv0+Hi3cAZmp7J7dFfQ3LBbyzDx8OEEvg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/16 03:34, Goldwyn Rodrigues wrote:
> For a filesystem which has btrfs read-only property set to true, all
> write operations including xattr should be denied. However, security
> xattr can still be changed even if btrfs ro property is true.
>
> This patch checks if the root is read-only before performing the set
> xattr operation.
>
> Testcase:
>
> #!/bin/bash
>
> DEV=3D/dev/vdb
> MNT=3D/mnt
>
> mkfs.btrfs -f $DEV
> mount $DEV $MNT
> echo "file one" > $MNT/f1
> setfattr -n "security.one" -v 2 $MNT/f1
> btrfs property set $MNT ro true
>
> # Following statement should fail
> setfattr -n "security.one" -v 1 $MNT/f1
>
> umount $MNT
>
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
>
>
> diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
> index 7421abcf325a..5bb8d8c86311 100644
> --- a/fs/btrfs/xattr.c
> +++ b/fs/btrfs/xattr.c
> @@ -371,6 +371,9 @@ static int btrfs_xattr_handler_set(const struct xatt=
r_handler *handler,
>   				   const char *name, const void *buffer,
>   				   size_t size, int flags)
>   {
> +	if (btrfs_root_readonly(BTRFS_I(inode)->root))
> +		return -EROFS;
> +
>   	name =3D xattr_full_name(handler, name);
>   	return btrfs_setxattr_trans(inode, name, buffer, size, flags);
>   }
>
