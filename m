Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC2549572E
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jan 2022 01:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378311AbiAUADw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jan 2022 19:03:52 -0500
Received: from mout.gmx.net ([212.227.17.20]:44825 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1378263AbiAUADv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jan 2022 19:03:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1642723425;
        bh=lvE54ENVtSCXpnSItfSlZTLr2oXdV4b1gZye0/+wEF8=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=GufjWN+gbebGyHwGyUmP6Hm6FjDGdU2aTD4o1tL5M0t7QOH81FW3nELXFPAzv7Iqk
         RoiBYYFGOpUssPug1SZRBHX4TQY3XQIHvyOcGoYcNB2wQP1kv3NiumL7Kcf/BL40+V
         5ZhG6dskgDvvBrjMIR5C2gus/jFdUeGQyvDvJZxU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQvD5-1mynQc0oIp-00O1VY; Fri, 21
 Jan 2022 01:03:45 +0100
Message-ID: <4dd733ed-73ac-9e41-f716-0e04161bbfc6@gmx.com>
Date:   Fri, 21 Jan 2022 08:03:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] btrfs: update writeback index when starting defrag
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20aad8ccf0fbdecddd49216f25fa772754f77978.1642700395.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20aad8ccf0fbdecddd49216f25fa772754f77978.1642700395.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MEWbfdFOBJY1HYO0dZHhGNb9VspE/SntNt4ceJpcXlY0U1r5YxO
 tar0yZ9iru4airxZwreEzg06YVa/nIfC5go694PsxhgZl1/vBiUEGQc7VohxYOE6lhyYCp9
 HxHjmHv+eV3hogRxUjRoZAO0Ok/FswhuDAXXZvfYVHfQF8Si6+cD9goVp7zan8jwleUhevV
 PmUPw55tZRXp/qNQ/vdxQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:28qkxZI39P4=:i6LRPg5LNzPdTxkNRx9AFp
 ZhaSG+5cyQi0NaWPKDqKnK5fGnKQqqoCVR/VxuPYEKNc+/VGNC9fbTADhS0gegqQ/Zxo16O2O
 Yh9YLFQ+tF57iUzB72xwF0YoY5d1cFU01k1rq8PLerz5+9bmBrIleRSjQjmEygpY0D10xTmxz
 uzvvRT+90HwXapfhynrY6vZJ/NafuoMRz3EsK5KOGU/4pCrv+TLMtk7ucPW1uweINRlrOGnFp
 MrLNd4jlqZOflYxMnTWNgmGqKwy/8wqHSuLfJQlWjEKVe2eAJQY5bBKWVrk3pWH1G80mgCORX
 6c1JBkzvKVJsfu/hhFnA6joX4NtsaMo3NbjKWEAU3r96z/pQiF20X0a/A1hieDwYa1SSkg+ZE
 PzHvHW1Vh3SKnsu7Y/DyTzW8ILGGkNFVOztCwno7d+H3BDTc3EGFcNHX41LtrbXqop6N198gj
 rUDLaNK3bh5Yniabg6cV9gCKhLu2tmdlCp7bTxYq0Cw09pGtC76Bxbzz6KJfRMP9k+Oj9bkz2
 8EavPmaNKIFfo5OJI7iZ+we9wYw88HRHJPuLk+YuORkNgJ11p4SmmASt9EyfiO825lNyWq5At
 yesq8iBe99yjonJU+tSXoL9LTl9AaZQsOVK6hvFjAuUzywBjUKTejvt/GROFq2P9czmTEKqmO
 9VnEGcxlBz4Ibt0vFswJcw1ppHKQ20zDPR0RzR9bF63fwxrPUXEiuqFXWdyG0f6dZGxUZ3VNQ
 Pr69kkkxbQhIr3e4uyEq5w9scp3gFto8QEALbkTIz2UvbVyYaQeHABV5BI0w1McU7V1yaGzlL
 xqwEFp0ZLfw354nKqpX/Vrp0T03kVDk9nNHs5VpBIRWVBKNmlP+tYju5HKQrpcQOau4+sTIjq
 0RfEvajdejwqZ5asZe+fNnomQaZ59+0mF2giBKLTv74tMTk0RhI0DrYRzphwyJPoH2G9yn27K
 sra5Ywcj0Pt7hha5emnW1WCT/qImFkw8YzEUClWmsZBUDbIrg/hLpK2YNkMDnaoECI/jnFaQm
 v6D+g6roBp95q5qbft35NjuV8LiJ4Gdx3B1uFt0CPkFaDESgO8LIuWQRTQk7BLDTccE3lDiR3
 73zl4zLr21GZI4=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/21 01:41, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> When starting a defrag, we should update the writeback index of the
> inode's mapping in case it currently has a value beyond the start of the
> range we are defragging. This can help performance and often result in
> getting less extents after writeback - for e.g., if the current value
> of the writeback index sits somewhere in the middle of a range that
> gets dirty by the defrag, then after writeback we can get two smaller
> extents instead of a single, larger extent.
>
> We used to have this before the refactoring in 5.16, but it was removed
> without any reason to do so. Orginally it was added in kernel 3.1, by
> commit 2a0f7f5769992b ("Btrfs: fix recursive auto-defrag"), in order to
> fix a loop with autodefrag resulting in dirtying and writing pages over
> and over, but some testing on current code did not show that happening,
> at least with the test described in that commit.
>
> So add back the behaviour, as at the very least it is a nice to have
> optimization.

Writeback_index is always one mystery to me.

In fact just re-checking the writeback_index usage, I found the metadata
writeback is reading that value just like data writeback.
But we don't have any call sites to set writeback_index for btree inode.

Is there any better doc for the proper behavior for writeback_index?

Thanks,
Qu

>
> Fixes: 7b508037d4cac3 ("btrfs: defrag: use defrag_one_cluster() to imple=
ment btrfs_defrag_file()")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/ioctl.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index bfe5ed65e92b..95d0e210f063 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1535,6 +1535,7 @@ int btrfs_defrag_file(struct inode *inode, struct =
file_ra_state *ra,
>   	int compress_type =3D BTRFS_COMPRESS_ZLIB;
>   	int ret =3D 0;
>   	u32 extent_thresh =3D range->extent_thresh;
> +	pgoff_t start_index;
>
>   	if (isize =3D=3D 0)
>   		return 0;
> @@ -1576,6 +1577,14 @@ int btrfs_defrag_file(struct inode *inode, struct=
 file_ra_state *ra,
>   			file_ra_state_init(ra, inode->i_mapping);
>   	}
>
> +	/*
> +	 * Make writeback start from the beginning of the range, so that the
> +	 * defrag range can be written sequentially.
> +	 */
> +	start_index =3D cur >> PAGE_SHIFT;
> +	if (start_index < inode->i_mapping->writeback_index)
> +		inode->i_mapping->writeback_index =3D start_index;
> +
>   	while (cur < last_byte) {
>   		const unsigned long prev_sectors_defragged =3D sectors_defragged;
>   		u64 cluster_end;
