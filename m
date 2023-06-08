Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743DE727A67
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 10:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbjFHItQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 04:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbjFHIsp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 04:48:45 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA8830F6
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 01:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686214085; x=1686818885; i=quwenruo.btrfs@gmx.com;
 bh=1vI512pWJh0puSYWQtxfTtGGkcu6qYbKSZAEKD0Gtr0=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=hIZI3wKOZaLzxU2znj8ZEjmJ2wg9nVE+S6tXcjfv7snViWEOhY67dlnDPX3kU0DP0kH8Zgb
 pB5lE/tBhX+goATuay7sKkZen1jkCnazZ8oFRAO70rCOHIRw+pqBdy60K7cTeHq+LEal5eAqg
 +tdllkP1JgRZwqM3Yd8yC1/pDprkM1kgiKrhMljZoet4XGEdMuyNlN+2yUvzkd4cfq6d4Nwhs
 uuvQg2G3cxMFm0ubxsiBhD6PjbprnI6TVcpNz3vTxgGE4yUaVQksHiAWfJyclvpgBAUBqST4V
 JqGnQWPrX+w1fcxaNrezJR73wg00Y0DymwvM8JnhymjBUsZEw4MA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MV63q-1qZKYE4AI2-00S7as; Thu, 08
 Jun 2023 10:48:05 +0200
Message-ID: <ba5c2e1c-d3bb-4710-7b8b-a02bd9e414a2@gmx.com>
Date:   Thu, 8 Jun 2023 16:48:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 04/13] btrfs: do not BUG_ON() on tree mod log failure at
 __btrfs_cow_block()
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1686164789.git.fdmanana@suse.com>
 <33736c36355cd1d902b9f2ccc65d5f6fc13c5e56.1686164806.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <33736c36355cd1d902b9f2ccc65d5f6fc13c5e56.1686164806.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:76Fs6r5YoiRVIe9eZJEdK+08/IeCpzpQtNPwy/Uh91/IRPj31IG
 F2AI9uE3qaBA+U8ZEqe2rnUQAd51PpcCrdLcMARdvykqJEiNUjy9ZbU+0LZOlgDHuk8k+HM
 vbg/i57jLrI38UFkgKCVVFh4VgdJpYTWRJLX7GXXBmJNPiL8U2pgdmsc7bok7KZqM54OPuo
 C5tI7DoxoQvDPwJEAb4HA==
UI-OutboundReport: notjunk:1;M01:P0:CobZsi0TZnE=;QVJgLirpVcoAS7zGmXH3KB5Nhbi
 MlJ8vixXtS7wW4bcmBFpC9CIDKLI/gOHN9vHpnyxVA/RstAHvMknAb40pSf0Ew6aK36AXuv3X
 G0y+aPBybeR1i6Y8iKGogrWF5OPw6wBrl8hvgcN99WZ/lTGJ3BNm08yAfu4DkkjXMQ2LHeEl6
 C+mPqBJfG1jCK4DR3fgwL9KS5WrrIEdbvRYGvBRB1zhoq8LKfv9cpkKZKX7xYQyoU2f+3z6kO
 trhyyUZ+2ZeR1XNcOGONp/AvwPk3oCIftVzQuRKIEYC9nFO0B9UeAY2Md3HRoBQi4XZhA/sVn
 o116TNFNW2huYJZWjfdDxIOFhJkA3QWAJs/4Kffru6dtc2zqgOqlaQrs82EzFnU8XWohTRxo4
 4Gm1X2NAdqX7gre0xeiltVOSKwm0fdIVIN0Y8HE/VxIq+ZIj6+s/qxaFBRv0lyfYMVmEFRcjq
 1FMieXanT6F+40ft8HPwMf+pIspNq2pGfqgKBO8d8LnJ5/NavtFm2ldXwQQpqcLOpMQO1vj5D
 6dtoX318S2qyrsq+iLOlHBelPhOGlbyKdX2d+laTew7/dH9SUdHUxeZtidO0xsHnmGc7MHdPn
 8R2BPA0BKbWNoaIXEK1BLUdmi6AJPpH08V/Q3QSIBhoSAzeyLyz/cLW5Yw1YWrve61qx5BwAo
 oabB8c4i8mOiHmCYxy2zd542o1eM3Ssc1sw506j/Ibx4kpMUWbXFkDDQlhWl8XGlOS3tBtbHE
 OP5GDwIcZI6LlJjSB4tPxosopmnjaNyg/MhU16C9okcu+BjRE/5fl1yTZe22kQJpR90eF/eh5
 ocSwCjiNpIbschdZBiKCSQ+DTmzeNxcShPb79+ts5MS4VrY/l1l+TLM/OaleFdwaQdAkWp43y
 kw/OLYcYc2WFoLOJ5FeH+UZTeuueAkvbsshQRD0XTRmZsSPJDZDCTILUqMnkOXYRBoMFLbnde
 K3ojuGsxZJF5t8Tw7t+EfJjrZDQ=
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
> At __btrfs_cow_block(), instead of doing a BUG_ON() in case we fail to
> record a tree mod log root insertion operation, do a transaction abort
> instead. There's really no need for the BUG_ON(), we can properly
> release all resources in this context and turn the filesystem to RO mode
> and in an error state instead.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/ctree.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 8496535828de..d6c29564ce49 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -584,9 +584,14 @@ static noinline int __btrfs_cow_block(struct btrfs_=
trans_handle *trans,
>   		    btrfs_header_backref_rev(buf) < BTRFS_MIXED_BACKREF_REV)
>   			parent_start =3D buf->start;
>
> -		atomic_inc(&cow->refs);
>   		ret =3D btrfs_tree_mod_log_insert_root(root->node, cow, true);
> -		BUG_ON(ret < 0);
> +		if (ret < 0) {
> +			btrfs_tree_unlock(cow);
> +			free_extent_buffer(cow);
> +			btrfs_abort_transaction(trans, ret);
> +			return ret;
> +		}
> +		atomic_inc(&cow->refs);
>   		rcu_assign_pointer(root->node, cow);
>
>   		btrfs_free_tree_block(trans, btrfs_root_id(root), buf,
