Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A05D59EF9C
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Aug 2022 01:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbiHWXUB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Aug 2022 19:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbiHWXT6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Aug 2022 19:19:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5DCE92
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Aug 2022 16:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661296771;
        bh=7nAqj5rQx0jKOShz1LfrpmLXoG1XJwX9g9PN5QKg/C8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=JQOkCJZGq/SgmLdrIf7NOrseGbS4tuB2tDdMGc8NZCnWnQqYRIpsQoLJT3fS+vEkH
         t3015TrSbfC7ZEmFUsKnzRYo/6AORBynRmscLGiRn42CGpjknWSVyknBGYGGO7Q/7d
         xQeCEPsw+gPgAL5LeKXkYmCbjcC2K4Tx6VhLZT38=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTAFb-1osJki0A9P-00UXOw; Wed, 24
 Aug 2022 01:19:31 +0200
Message-ID: <92a82ceb-9818-1328-3503-d79e1b9db17d@gmx.com>
Date:   Wed, 24 Aug 2022 07:19:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] btrfs: fix race between quota enable and quota rescan
 ioctl
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Cc:     yebin10@huawei.com, Filipe Manana <fdmanana@suse.com>
References: <a95c38a253bedfa00d073e120a2599faa0f8139d.1661254155.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <a95c38a253bedfa00d073e120a2599faa0f8139d.1661254155.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Dl3kPOU0qO56un0kWSEn0lAvBNyEvlOUozUsSQMHKmvkvxbCwvh
 FfsHFYJX+YZj6y623726xoaM0nWTZZywZTZVPT8ybm2WOKVU9V0HO2ENa2r8Jdq+fmuA4V0
 Vb05L0qHdo/rxO2mShZbBRtXeUpxh75XUQ2mqAAiMCnESk3oJ2Lcpd+wlF9mB7AqYrAV5oc
 8jkltbJr4NHJSeP+Lv7fA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:u7wHMoPgxmA=:cKAxZXqHmyrkcOmOOtiIy+
 HiabIWUOWirP64uWtwKoEmafpJ91N3UUz+gQMt7a3NA1InpHAybf14bz0u/gL/y5bQVhhhdKW
 3GBsVWBHwefN0G3J3ISP8HJyz1LiodcxLmN4DfgbKWaSgomAORAyXHNeWoe2zhknM/6dJIz23
 PZ+NYyZ6IcgW9gjFk4ByeXLLT5GLcpD7skLuBnJLJdgZmt/ItljoeBYtWBWOEuBU81HFnEKeB
 mLjbjBRKKKgnXy9VYxbRpvHuz3umRbxGNQL8x7+j7RY+hl/fSDeKUFO6lGRPEfs+OjuPSngjK
 wohnzMoHe4hrbKgxtCi4BrJK85AhCUjqzKQH0xBtqLLIXfZ5y0S+S79FAIJRtROrikx/Gzp96
 nKkPN2D3a2KZ0FUzfDYdb3gS6RJQKtzzu55eDaNxrI97UeakPxI0NMJP9yAbk+8MByK6Vpggs
 rVlVVltRBCJVIQXK9imqmvzXTQp4w+bSJ81GSlOYYCI8dre9LLFfdp/88ZUS10lSZUxG8NSzh
 h4mtx/DMciS0E6cDuCPitSfsKgnNrzYq02ZtN0YQtZD3Yv3ONHX9aHp0nty5hi4Ecy4EDmkZl
 haT/WEWdLr6Al8AxkTxXWecynrONSiGS4jtR1EwB928cttY4I6PTfKWQrZKkdtH1aIhmuCqON
 Y3PLT02ceGDxJL9P9cMzRJsB1AYKISUaOaZuy33AgnEmpVLgAsCMxRYRIMZmg6sNie6yKfsp7
 RWfT73tvp6g19Boxzif/x+R6RZcjTeLdVHbnIR6Q/WRwz2de38ferzTFm5p27U9XaFME0YjHr
 7DrIq4+LiqSiX7IiuCbCvMfHsG4gyLZu3DB0rTKnQBBu7Hh6+eDw0dCKq7OR4+8k379l+WYJc
 74X1y6kMQbmTRpkAwrc9JpZ8joyuvYu2uwNqh6ffil1wztynMRBdIu9akpx9Cq7XJ2uJYaRa+
 kqUKnQfE2Zxm3oN8nPtq/tDGP+RzkOB7ZOWabiD+XKY8Tn4gcUC4K1lQiTvgAZY0C/uybwKzc
 oKu4TctLb0ghfHhTZEtvMjazY4P3Iz2UD+AiJA93E97Gr5jHawmyDAEHVswx04rwkRN0wfuOR
 yFr7XjzkE6B27PDNWHkJJs4P/L/vUJprTjRbRVihX16k7Oa3kaVQGWBRw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/23 19:45, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> When enabling quotas, at btrfs_quota_enable(), after committing the
> transaction, we change fs_info->quota_root to point to the quota root we
> created and set BTRFS_FS_QUOTA_ENABLED at fs_info->flags. Then we try
> to start the qgroup rescan worker, first by initalizing it with a call
> to qgroup_rescan_init() - however if that fails we end up freeing the
> quota root but we leave fs_info->quota_root still pointing to it, this
> can later result in a use-after-free somewhere else.
>
> We have previously set the flags BTRFS_FS_QUOTA_ENABLED and
> BTRFS_QGROUP_STATUS_FLAG_ON, so we can only fail with -EINPROGRESS at
> btrfs_quota_enable(), which is possible if someone already called the
> quota rescan ioctl, and therefore started the rescan worker.
>
> So fix this by ignoring an -EINPROGRESS and asserting we can't get any
> other error.
>
> Reported-by: Ye Bin <yebin10@huawei.com>
> Link: https://lore.kernel.org/linux-btrfs/20220823015931.421355-1-yebin1=
0@huawei.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/qgroup.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index db723c0026bd..ba323dcb0a0b 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1174,6 +1174,21 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_i=
nfo)
>   		fs_info->qgroup_rescan_running =3D true;
>   	        btrfs_queue_work(fs_info->qgroup_rescan_workers,
>   	                         &fs_info->qgroup_rescan_work);
> +	} else {
> +		/*
> +		 * We have set both BTRFS_FS_QUOTA_ENABLED and
> +		 * BTRFS_QGROUP_STATUS_FLAG_ON, so we can only fail with
> +		 * -EINPROGRESS. That can happen because someone started the
> +		 * rescan worker by calling quota rescan ioctl before we
> +		 * attempted to initialize the rescan worker. Failure due to
> +		 * quotas disabled in the meanwhile is not possible, because
> +		 * we are holding a write lock on fs_info->subvol_sem, which
> +		 * is also acquired when disabling quotas.
> +		 * Ignore such error, and any other error would need to undo
> +		 * everything we did in the transaction we just committed.
> +		 */
> +		ASSERT(ret =3D=3D -EINPROGRESS);
> +		ret =3D 0;
>   	}
>
>   out_free_path:
