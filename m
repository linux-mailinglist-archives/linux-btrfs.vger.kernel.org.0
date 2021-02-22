Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 803AC3222B4
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Feb 2021 00:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbhBVXmo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Feb 2021 18:42:44 -0500
Received: from mout.gmx.net ([212.227.15.18]:59465 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231215AbhBVXmm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Feb 2021 18:42:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614037269;
        bh=NwM7JEgH3zhlpiLcXvhbvrRTcL69w8XrzPXbsfc5AiI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=OcGnDV5hEXgSNjfZFUax4JBBN0RCa8nxeHrr3QBKpfQknOHh8SjOPQVo6TMc5BcUA
         IeztfkCBOmkuooVygRRicNM5ooTpL4zb8rhH4q5oQK+wSqLHs95QQQ0UVzYVtzb+7Q
         X03vixgcYpkF0GXqqpODjPd5pwNnveMBo8TXujfc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MdefD-1lnwcn3wFF-00Zg8N; Tue, 23
 Feb 2021 00:41:09 +0100
Subject: Re: [PATCH 1/6] btrfs: Free correct amount of space in
 btrfs_delayed_inode_reserve_metadata
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20210222164047.978768-1-nborisov@suse.com>
 <20210222164047.978768-2-nborisov@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <6a5e7c60-d8ee-cf6c-065c-c2450308602c@gmx.com>
Date:   Tue, 23 Feb 2021 07:41:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210222164047.978768-2-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fpqSz4YFwdz3v+SRg8DLVB8OqEJU0V0vxef0qxG3JxxLxk42390
 9zcpZinGIv2aJ9mKPt3M7EwLQo45dzAohxVhR1M/2C+evLH9+iDZzeccrymNSeAHc7B43RQ
 E4vAeHwBaShsKsJW/OlmfRDl7+5iDzeT3gyH1LCQIAAiTmF552CUHFu/fPP16LX9P43WBcS
 I2rICYA/6sd9ncjoIFmPg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wJlvuHSsZTg=:4nS4/ynRPo0cL3coY8avUV
 2+2Jq9Zdn0jOtQ17MR/vXqHD1myWPU4gVu+XQFxtoUu7qoT2Ifa4VDaUI+KelJGRI8hq6yF+B
 48lQEQXLvDVgk2e6WnFbuRZQSVaKJA+dc1vmER+OYFXrwhkbdW6YZhHFC4TyjyNjg9R3G+i9L
 6UFw2S7ghQLEmXV3rtowdSyMv+2+pZY1KUiFY/nKWW4wv+DGPdyXrSF+VRXnpWkd9cnnm+EK2
 GjiZeR5dL2vk4Ql2UG9PqJA7j6R/PPy4ZPio+FVyDUDh6qlULuhaCUoDQH9DL6PPOLOfewa3N
 L7ty1v1s/8bKIkBJsPMVOTdXTwTxqZ2jKmTQrW4pzMGP0qzAzDgYfTFyoA7hLC/wubXMkpc3R
 j2zKufdDGy3OmXbfYBfghSqU9wOaUVV4AJlHr9c96SOEIH5PYT//DySMhHHHEZD3ZFdEDspgE
 9lhUUeWVhJbldOSj4fcmdMcxfyvH6zlv91Amg/KKWSwcijgOdIb0MrxcChG/HXzy24Tdcdsd+
 e1WseRO878Qz8ELaWxpaIsNjTqpd1AMhU3L3RkuB1hF5U+OOrYrq4ZlytvzF/TO4D2QMESfZh
 HVdnuFdxj+C9dPSkAGeEBynYu2bdU8Ig5kRDV5fEs4HkwjkZfjxnpaUPvucLEuDiOd+W2aqaN
 LcNX3bIfFaCAGN3pVyoboocl4IlgKNR3bjmCDimQN5oOBcDLujT6NQw9a46T70lWJ8tS40xgE
 Tpl8ztofrd9y7TqMWrGwfNVYeC22qE8XZN6GDZhnPc4J2Wcm7LROx2in/CKXzRZmvsSuCHy05
 6uPQa19K+iUnxWZOeP7uATBjViNg1X7PCDr1v2WGWSyL2dEOfKQ8Z/XSloyrS2GBp6jgfNLcb
 cycT4hVETAOJbqJnZdbQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/2/23 =E4=B8=8A=E5=8D=8812:40, Nikolay Borisov wrote:
> Following commit f218ea6c4792 ("btrfs: delayed-inode: Remove wrong
> qgroup meta reservation calls") this function now reserves num_bytes,
> rather than the fixed amount of nodesize. As such this requires the
> same amount to be freed in case of failure. Fix this by adjusting
> the amount we are freeing.
>
> Fixes f218ea6c4792 ("btrfs: delayed-inode: Remove wrong qgroup meta rese=
rvation calls")
>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>   fs/btrfs/delayed-inode.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index ec0b50b8c5d6..ac9966e76a2f 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -649,7 +649,7 @@ static int btrfs_delayed_inode_reserve_metadata(
>   						      btrfs_ino(inode),
>   						      num_bytes, 1);
>   		} else {
> -			btrfs_qgroup_free_meta_prealloc(root, fs_info->nodesize);
> +			btrfs_qgroup_free_meta_prealloc(root, num_bytes);
>   		}
>   		return ret;
>   	}
>
