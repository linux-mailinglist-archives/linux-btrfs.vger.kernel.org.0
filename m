Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B54727AE4
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 11:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbjFHJMF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 05:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234696AbjFHJLj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 05:11:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F1B18F
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 02:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686215491; x=1686820291; i=quwenruo.btrfs@gmx.com;
 bh=MNISzNEGMhcWuLLo2z7xZkSuXrFS0V9j5PZvThONrGY=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=cbua7Ww+JqpOUnuYhxhpB2+cwuCTPbX7YbY7S9C17rUP9wFPrbIykCMcqb7uNlrYVeQDNAC
 BbLeFUEWoK62IIuTImcjqKQMnZ+utS2bKU52UcBDVKlO2GlfIcBptPpa1mMuC92CT3StR/Sg3
 MlDviwiGP69aStqOp8bRgj/ZXrYuwtYl15i2qtFXUneojIiJltVebOzzv3wcL9IUbFB6zVV7/
 wmxOsWpdXyL+mXocY6/hayXqz31JUICaXCBtIm0uwEzwgnmI2L4P67GL0sf4aJg8tP0ErOTGj
 qpYMPxGwCOFarlFNjvDrq3OH/ebuxg5v5ItaGev0NZDuvqR5LIUQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MJVHU-1qR2uh0IKe-00JuVa; Thu, 08
 Jun 2023 11:11:31 +0200
Message-ID: <fbcc5e03-74c9-a34d-4775-51b7702769a9@gmx.com>
Date:   Thu, 8 Jun 2023 17:11:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 11/13] btrfs: do not BUG_ON() on tree mod log failure at
 insert_new_root()
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1686164789.git.fdmanana@suse.com>
 <7d9be8388f0a32f5ae8bcaf73c215997e76253ed.1686164820.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <7d9be8388f0a32f5ae8bcaf73c215997e76253ed.1686164820.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hGCaXWlDc1vOWxlC6pSwNj8W2i7+m9JPaSESM5fhPzCKX7/f47n
 1oSjeqbHvaUVxTosEOih70/z1uOF/R96gwZrSu8sC2J4sL8scPiR7ju6iF5X01eFRGbPdHc
 tn7kcWkeUq+n1C8z/oe9Sj6jzr6XzZ/lpRz++R/T8qGPewtluQFcpYRpGp3+16nJcf6XOAE
 qGOLtb8XVu/zNqLdaq7zA==
UI-OutboundReport: notjunk:1;M01:P0:9aE9OqaGNvk=;XFU+FWIDj9UzH9P5Yv0QTKNO2Dj
 q3xVYB5tlSkSivlNt0Zc0y6BQszEIBXmLaSuanYspZGIlRHRt6g5nX57Mi5XUlNL7uyfXBLIm
 0/fylb0oaunCmfeYpSyFgxuzcMg10dXCjDpo/c8E8UvmYCXO770/yTRwdDSGjx5/zc0lUV8Uj
 rTtUXSe3JSIY7WXdO43uiGASotHYiRmg01EpVMxTj7346kcTlG1TJpeF/pLQnMP1/hW52u+N1
 0pqbYuSWv48r7ysxW5sP36NcRHl5XmsvqUgkKJSjgZ1cv4TbVb8UZ26wrlowL6z6yJ2QGZpdM
 xq2I7px0MvKJPqiXC44+DQOYauMWlEdE59cagynJL2ckJQAWJRx+vkiG4Al2Vr1Mchn1oyzd1
 prfonzaFykJnWvRYVlPhDxFS5jHkq/zAsEqyjfAUny4HmBajwhTvlPN8Ocpq8djkxfvro7Rzm
 5Elz+Mrxjx3hPMaWwe8A5+GF+dCLNhnKLNcKeAmihl8EoWJMgXUYnXC2z+RZv4PK/oSzwbcPH
 fUlqwAMdamI49gwF3J8rgyaQJ2RDdm0jU882BzCEo824jzyuOUCea0mQjXo59TvNm2jdnQ6zy
 JGF/0S9LnqvptMo0LljUT5qwHQIpObDy1vSY82yhR9bl2C+m5LC9pYRmUj/oXLXaTq6m5h7nF
 gzLE5BKpe99ERo6IvaELzp7o+kEFDqucL/kuSN8wXxNMXN2+QRLBdGBUcreF/jtCr+qnFkchy
 zzcYWyDS1Z46gSqJvrIKRgpM8flQJSUWwRs15MGRBLjpt4KFHAAZ2ojxaBIZqtJMDMPzuMcLO
 F6sZC9WMGE5XWHIAZvb7WCZzOXCQfe8x4mfm8QhOCEfBKMyeWwG5Yh+M7FXkFfY9HtU6u7+2s
 An8nRffzU0EKwUZ2ek12/axOtJZquPc7v+xh4OzjmJVvnFBcCQKgABzbUMmKeMGbWIen3Nc+E
 h9Mk+KrCC/Keuh+Dgb02d/rAfig=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
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
> At insert_new_root(), instead of doing a BUG_ON() in case we fail to
> record the tree mod log operation, just return the error to the callers
> after releasing the allocated tree block. At this point we haven't made
> any changes to the b+tree, so we haven't left it in an inconsistent stat=
e
> and therefore have no need to abort the transaction. All we need to do i=
s
> to unlock and free the extent buffer we just allocated with the purpose
> of making it the new root.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/ctree.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index e3c949fa136f..6e59343034d6 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -2956,7 +2956,12 @@ static noinline int insert_new_root(struct btrfs_=
trans_handle *trans,
>
>   	old =3D root->node;
>   	ret =3D btrfs_tree_mod_log_insert_root(root->node, c, false);
> -	BUG_ON(ret < 0);
> +	if (ret < 0) {
> +		btrfs_free_tree_block(trans, btrfs_root_id(root), c, 0, 1);
> +		btrfs_tree_unlock(c);
> +		free_extent_buffer(c);
> +		return ret;
> +	}
>   	rcu_assign_pointer(root->node, c);
>
>   	/* the super has an extra ref to root->node */
