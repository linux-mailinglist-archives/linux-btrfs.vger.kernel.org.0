Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7738D509D82
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Apr 2022 12:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388261AbiDUKYB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Apr 2022 06:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiDUKYA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Apr 2022 06:24:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEE715710
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Apr 2022 03:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650536461;
        bh=vQmypahnxHxuXYenou3zkxZ7+Dfg3Svx4XioGSJFYqo=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=GytC96tNp984iNnzHi2fVF9k9yTT7djLXkmktERSoOZq6CUL9IoYc8oC6oDvPGDXP
         e0DVUJvoovcPI8oEL047Q6HeYP4sNo1cBUTMfnfAAwObBzT3grXHLhg+iNlfr9GIqv
         hNMPtRJHtSiARr3/h1B6EA2r+eYOGn6pPvyDOAKg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mg6Zw-1oP45K3kb8-00hcki; Thu, 21
 Apr 2022 12:21:01 +0200
Message-ID: <2a5f7724-e864-b96f-34cb-7d76b609e3bd@gmx.com>
Date:   Thu, 21 Apr 2022 18:20:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] btrfs: do not BUG_ON() on failure to update inode when
 setting xattr
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <bf2fb575bc7b960b925693b9d64a802f4c477fc3.1650535321.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <bf2fb575bc7b960b925693b9d64a802f4c477fc3.1650535321.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FyoYFW3JZ3PB6TefwwSGXNfM9s6jno1gtk/+o8PNd63ApO2B9Ev
 6D4l4EcEAa7JrKAESveTTQUvymlxxxwtr6tevnQImBtpCEqPP3jYkZPbrBv0q/LzFQs9R7p
 F8KEPf7b6S+qbyD5hVhX+FcuwJIXtFuAm0QngaKOKOXY2VveI2jpvP8UDuVOpAzyB+X0GGb
 T4RzxId3kKInUxAykeGvg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XNd0WmqK91o=:85OHBv0N8fta5Icar0jPCd
 5haI0276mLCRyhn92Pz1UrfSgAV5sf/PqQJ3l4wQguKpGeazRGHQBQtMxlHG11ZMQpl/e1iCp
 UrkGXu4lL9+kJujIsWsCYYi1B/31GZqQJq7UbKmFdRg4L7FvKW6IZSdn/jrYqnvJ3zctnR/kD
 YV2YKV9jvxcpyMYr+EuRd/u6/c8S1NhWZUX42RE11mwppb++PjxPww5lL9K76GsLlrHzKxKCZ
 Lvyl2QZpRlZhiX5zLSUhY3VnT2bGQkQ7oFrwZC1FhMgzGYl8+WzmGPGDSgomKQk0Dx8GHUaYu
 Lnk1qwlkUNxrD9D6OnKp8mp7+eQippXfoifAhTAdv/Y/5gIptRhqIYHR70Km/weTyTgt9e2Od
 SROoVnVLFgLzPpgG48UaMMcFCJkLpYkiIjJa1u2FduwOjNITNL3xzZlpaxXL+DW5dXLMwdBfG
 O40K8ICwhizfO3Ash0CLKnF3xaI1uPcqBYAi4FoMUrL84xW86vkYELJAL7hOy8DdI+SltIiuI
 Bsy4J51ba1UGCui9YXzbpftncoKEW3tjlvsCSI552ps2GfDPAnnAJbOGFFjESTRQXfJ682JmS
 fRcO5RBBBHpF0MxHJxBoBdaiJqVuDK8kAVZ6FckcA83juQasYGf5kykFChgvV0apQZ/vbhJpn
 1UdP/hftAzbDMmOoyfP+IYz6EKuUKrHJpbCJppCdd9vEdwBFAYLhYsh8GO0B785wJTKGPNhb9
 nkV7j0AImnujirubZgInP37g5IZrlFH+rS9iMcVzQv8I4kPv+au90qnDDQs7VkpbNns/FVC7u
 N8RZT80c4yPtxykMUKYCIQKuQRDCx0vhTJNqyQE7i08ZM09QmDwfXUuG8mvUWhR/ASnDAnCEw
 t+M/pHz8gzbqCP+xEMJ3Yt0dAdRU7GCPXIUWRuDa6hf1Pzhb2Zh2955U1htjKo+MbW5qoERe+
 lTVoZdrWmvTCzK2BDfBmAmKb7ADzRqJBkBCT1iOJ2RLm52dOd6nbNP31ckrkEq3Pu6Y78j+KW
 afIBwMXNRa5PrN2EC6KwnwfY7dbg5ufzbL2CTVzPsFthLmzgGB0AV7JJXEtmgT8ZdAPLTihvv
 6sQ98GaK9ZNYug=
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/21 18:03, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> We are doing a BUG_ON() if we fail to update an inode after setting (or
> clearing) a xattr, but there's really no reason to not instead simply
> abort the transaction and return the error to the caller. This should be
> a rare error because we have previously reserved enough metadata space t=
o
> update the inode and the delayed inode should have already been setup, s=
o
> an -ENOSPC or -ENOMEM, which are the possible errors, are very unlikely =
to
> happen.
>
> So replace the BUG_ON()s with a transaction abort.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/xattr.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
> index f9d22ff3567f..4a2a5cb1c202 100644
> --- a/fs/btrfs/xattr.c
> +++ b/fs/btrfs/xattr.c
> @@ -262,7 +262,8 @@ int btrfs_setxattr_trans(struct inode *inode, const =
char *name,
>   	inode_inc_iversion(inode);
>   	inode->i_ctime =3D current_time(inode);
>   	ret =3D btrfs_update_inode(trans, root, BTRFS_I(inode));
> -	BUG_ON(ret);
> +	if (ret)
> +		btrfs_abort_transaction(trans, ret);
>   out:
>   	if (start_trans)
>   		btrfs_end_transaction(trans);
> @@ -401,7 +402,8 @@ static int btrfs_xattr_handler_set_prop(const struct=
 xattr_handler *handler,
>   		inode_inc_iversion(inode);
>   		inode->i_ctime =3D current_time(inode);
>   		ret =3D btrfs_update_inode(trans, root, BTRFS_I(inode));
> -		BUG_ON(ret);
> +		if (ret)
> +			btrfs_abort_transaction(trans, ret);
>   	}
>
>   	btrfs_end_transaction(trans);
