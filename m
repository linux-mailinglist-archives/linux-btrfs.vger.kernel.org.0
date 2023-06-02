Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D03671FACE
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jun 2023 09:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbjFBHPs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Jun 2023 03:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233768AbjFBHPr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Jun 2023 03:15:47 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DE7C0
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Jun 2023 00:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1685690142; x=1686294942; i=quwenruo.btrfs@gmx.com;
 bh=U5YxQGZtBaW2jMSV9JpS/PnyDGKi32WCORB9EzhlWs8=;
 h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
 b=R0ztFDP8kHfui60MclJeqQYYdkpzyaIaxYqgWB8WepcZqOH4V2ZBODBfRDM1mAu2dCx6ypf
 xuu6XYYqdglxmKY3NYnGXpQ/ovRdx/j7n9kNEj0Eh0fBJ05MPo/D4WCspO70rgl4O4CNft5Hk
 /vO5sxnnAvjuKSyKrc+mtebbVOWDzmE/i2rB5gRd7XijtXIrJR1V+EehW4maodB1y6LQnFDtJ
 4YYSpBxbWFgvER9sMD0rFpeqdJm0SoGnLN1okGRhL04MbpNN9K+JmkntDRyl+JRdHk7OHVxVq
 fWReuHGakfBcBVe+gKwmizBig+H/IXrBeA3dDsA0/xbGUtcjfYEw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MryXN-1qRgJU3WU9-00o1yH; Fri, 02
 Jun 2023 09:15:42 +0200
Message-ID: <f188e0d6-1189-6c3b-28b2-837ac12cb92f@gmx.com>
Date:   Fri, 2 Jun 2023 15:15:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] btrfs: fix a crash in metadata repair path
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.cz>
References: <cd4159ae5d32fdb87deba4bf6485819614016c11.1685088405.git.wqu@suse.com>
In-Reply-To: <cd4159ae5d32fdb87deba4bf6485819614016c11.1685088405.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3aCPwpeTQRltgtNOMCKWtPC0HMqyzP8lrzqQJnmrynVo8r6IpND
 Eo7sex5kQUB3hvukyQcKNbg/RZbICXNkFVQI0W1tK85PXoEBpLLQlvvP2dR472CM7IFks7A
 ODFcT8DJQDCsNvXjMbz2g8pmXC1P+1jeo8BM7HcPDqiw+ODgYk3wyQybrWMsuCCSFQFi2W5
 u1KhClsit2UXkzathPusA==
UI-OutboundReport: notjunk:1;M01:P0:njHZ4ywO4kU=;1lVeO4WzKsPx+quhSO/Ahh4QcpG
 Tb5xk+U2LL2K2V8wZ4xqVT3vv4kgx2ZOyG9Y7+phIu7oqaYWNi8jBONPECLYgqw+6QthXTYw7
 lBczyRWNCIap7rH47CW2GVEHFcy9qayqy/B6S1LPYNqOUTCr08Oj66EAmPJqVx88v0rcJKIIx
 SkEF5NldhX6yNxykJHC4CkzA5a0XuXbS+DFCZ0jQIjU2ap9xE8kthi6SF4Pw1pDASHm+7xQrj
 s/FK62z6KGJElPoOlooKohM+JpTYe7hE3P6g0RBRFaGVJbF75A8ppwb5IMsXp1/8/LK4Why1g
 YZcZ2wHRQ7noUWCa2OVe2EEXoJhvpREP3FXkfCpMiOpyVrwKZhEmg7018LvXp/WPVpN7tRErt
 e8BSttPmaRSzQsQVRtUN1OkaHfIrOfo9DBKxLztxT2Mp1RECCgTAYVDbUYs9abvjW4gtz+cV0
 ojoL8j3fb/8KtUt7OIINDBLAwBupAUAfr1sIu+xj3DajSEoSfxmMBgOADqbXs4wQ4QwRbiR24
 kxbvb2C4lq8H1DwgyWwd03vIK7ponelSRhFYmv+9rjhkjkIC953UBIW/crLqqWZ1BAUv8EdDL
 345PtPOTnKQiPLUt2+6DLLMCoyxmoKsqPRSJCs73lk8gbt035WAa8P7ZsOYxQr5xRruOarUu5
 tVHeGNV+/zfD/YEveBADiP32Q/qq2xN2j38QtyExnEx5O22K7YqSYorgsN4pOOSQoxWrIVf+3
 Y55icFGSXAGZkmgt1E3SF0bK8wKcvaQS4cZBsYxqa4+fW824WpQ+ayHBkHRRhw+YMkO8P+DBu
 UgX5p+2ClY5+j0wPNk7HcAs/AIOhULlCdaf1RL4CIn11Ck2rZEWQiFxIkrWYToJBAmP/q+o+k
 G41WI1my7TCNSeo+/iJ21/ApmggWOL6hsJP6irjPvsuCBbBlA2QM6of5tRU7oSldLGjq6Jlcv
 KMCRrcz+YWWhLbo0eZYsavX7ls4=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi David,

I still don't see this fix merged for misc-next, any update on this?

Thanks,
Qu

On 2023/5/26 20:30, Qu Wenruo wrote:
> [BUG]
> Test case btrfs/027 would crash with subpage (64K page size, 4K
> sectorsize) with the following dying messages:
>
>   debug: map_length=3D16384 length=3D65536 type=3Dmetadata|raid6(0x104)
>   assertion failed: map_length >=3D length, in fs/btrfs/volumes.c:8093
>   ------------[ cut here ]------------
>   kernel BUG at fs/btrfs/messages.c:259!
>   Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
>   Call trace:
>    btrfs_assertfail+0x28/0x2c [btrfs]
>    btrfs_map_repair_block+0x150/0x2b8 [btrfs]
>    btrfs_repair_io_failure+0xd4/0x31c [btrfs]
>    btrfs_read_extent_buffer+0x150/0x16c [btrfs]
>    read_tree_block+0x38/0xbc [btrfs]
>    read_tree_root_path+0xfc/0x1bc [btrfs]
>    btrfs_get_root_ref.part.0+0xd4/0x3a8 [btrfs]
>    open_ctree+0xa30/0x172c [btrfs]
>    btrfs_mount_root+0x3c4/0x4a4 [btrfs]
>    legacy_get_tree+0x30/0x60
>    vfs_get_tree+0x28/0xec
>    vfs_kern_mount.part.0+0x90/0xd4
>    vfs_kern_mount+0x14/0x28
>    btrfs_mount+0x114/0x418 [btrfs]
>    legacy_get_tree+0x30/0x60
>    vfs_get_tree+0x28/0xec
>    path_mount+0x3e0/0xb64
>    __arm64_sys_mount+0x200/0x2d8
>    invoke_syscall+0x48/0x114
>    el0_svc_common.constprop.0+0x60/0x11c
>    do_el0_svc+0x38/0x98
>    el0_svc+0x40/0xa8
>    el0t_64_sync_handler+0xf4/0x120
>    el0t_64_sync+0x190/0x194
>   Code: aa0403e2 b0fff060 91010000 959c2024 (d4210000)
>
> [CAUSE]
> In btrfs/027 we test RAID6 with missing devices, in this particular
> case, we're repairing a metadata at the end of a data stripe.
>
> But at btrfs_repair_io_failure(), we always pass a full PAGE for repair,
> and for subpage case this can cross stripe boundary and lead to the
> above BUG_ON().
>
> This metadata repair code is always there, since the introduction of
> subpage support, but this can trigger BUG_ON() after the bio split
> ability at btrfs_map_bio().
>
> [FIX]
> Instead of passing the old PAGE_SIZE, we calculate the correct length
> based on the eb size and page size for both regular and subpage cases.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/disk-io.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index c461a46ac6f2..65ac7b95d3a4 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -176,7 +176,6 @@ static int btrfs_repair_eb_io_failure(const struct e=
xtent_buffer *eb,
>   				      int mirror_num)
>   {
>   	struct btrfs_fs_info *fs_info =3D eb->fs_info;
> -	u64 start =3D eb->start;
>   	int i, num_pages =3D num_extent_pages(eb);
>   	int ret =3D 0;
>
> @@ -185,12 +184,14 @@ static int btrfs_repair_eb_io_failure(const struct=
 extent_buffer *eb,
>
>   	for (i =3D 0; i < num_pages; i++) {
>   		struct page *p =3D eb->pages[i];
> +		u64 start =3D max_t(u64, eb->start, page_offset(p));
> +		u64 end =3D min_t(u64, eb->start + eb->len, page_offset(p) + PAGE_SIZ=
E);
> +		u32 len =3D end - start;
>
> -		ret =3D btrfs_repair_io_failure(fs_info, 0, start, PAGE_SIZE,
> -				start, p, start - page_offset(p), mirror_num);
> +		ret =3D btrfs_repair_io_failure(fs_info, 0, start, len,
> +				start, p, offset_in_page(start), mirror_num);
>   		if (ret)
>   			break;
> -		start +=3D PAGE_SIZE;
>   	}
>
>   	return ret;
