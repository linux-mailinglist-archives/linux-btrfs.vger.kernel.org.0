Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3CD8446BA1
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Nov 2021 01:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbhKFAmN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 20:42:13 -0400
Received: from mout.gmx.net ([212.227.15.19]:39973 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232554AbhKFAmM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Nov 2021 20:42:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636159167;
        bh=S9CmpH7Kh8x1Zw4Kmq5osXpaMqwfXz0ZRE5PhlB1H0Y=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=CX8+wkvUJLpamn1/+gGCJZJ9BACh5UjejJaaRMuozHP+p93OAXWRCuXKrXB0pzof9
         beFQyG5ZxG42BLHaXftKm/5hnQ+9BW9zjJFFcUmu7MHjy1NGXqIhhy4b/pS9n0PBaP
         9NCjaRymhg7htaInwq9I9S1HP14rfD1e+nj/nCHQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MHGCo-1mwPGw1PFo-00DJjt; Sat, 06
 Nov 2021 01:39:27 +0100
Message-ID: <1e61296d-58ba-b45f-a38b-b1da9e9962a8@gmx.com>
Date:   Sat, 6 Nov 2021 08:39:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 12/20] btrfs-progs: mark reloc roots as used
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1636143924.git.josef@toxicpanda.com>
 <1da6c61af04c10b8a7e682676121e1031753fe69.1636143924.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <1da6c61af04c10b8a7e682676121e1031753fe69.1636143924.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GIyouT5jl/7TgbP7P+rZmodMbod1O2fIiupaofJ4m57zUmRFhEp
 U60IbUSfZ2o/qxoxMzLjOPL8cIFLst47t1ZVmCcAjV526aJ+lOezFStoGwa7DqfItZc8fqR
 +LtztLSEWY2wOjo8YTlqYLqBpnGlieLDuzVl0rM7ByUvORxX6OJz50+5VzADCalO9YAadnp
 lGcwtcNc7QLm3dgQX/Y7A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ijYYL/LhKfU=:PmUVdASZ6aM3ITSkycxzGR
 HrGiyjNPub7CZca/gWfQpQPUx7zMFsrIS9P8lMlLB5nMbado4jf6JCskM0j1+9Y/c758L8Vcn
 KY6y24IYIiZchy3kShGI1GJMbc6T+arhmmDGWFElEhagqiuAvEnX/bA01TrGNlsKj1AIOcSXo
 x39LZnyANAjPhwS6ebPx7OcB/NqgF4LpxVsyvbXZwkQfj7AIs/PHBp5AblBZd/WNRVJDn2Haq
 zlLp/uyLVVYqm/IUTF57JflU2xzyo8qTMbTWtTkBT4ylEAdLFCQFRseI+/qq4haegGAX78CxS
 F4Y/idebJZb08Iu3kpHoXuHyv7NYu4/XxlkkxeLjL6O0CezdGJrTsONsiKD+7QVT399dqpfBG
 qvdGj9F3LJfrjumJprjUPkFyJCc7u8X4QDCXjFSouZCtS13aWyGzVpccxRygpMPp6cLOXtJJg
 ST4l3jcKJqyvXp8752pnnPsxYf3w13mWcLdXGPzV/KeNcXkBfWykXQo2FrZNO7PAfT2ANWJjx
 +qqKq0aQ7YaZuEyzhQ/NNxeWOacikk/Nw/zXRk8VUZ32A5S6xgC9hL8v1EwDPvOZ8n0ATXZg8
 CvRnHLIlc+83SBvBhmTq7PHaEcZ8qj/yQAqevbLWjyiaEPZrwwrJOvhmsCxIAotHnPDP3RO+0
 SVYpzSoyCHYFTgO6lHJ4jZ3sbNFqsddbu+Wl068lIK7PYsRquhTbuvAz/Rwc4WIIKcBhqYFIh
 pNuWJZIt3bQdNRrsTQeUoAevTuEsjrqFg9ehYaLOf4Mwg2okvY2BtrAtSSYrp8h7BefjMb3iO
 tliUoSmOT2FAnNqIDjZcZl+ysBpL9UURetavtc+ULdE+wXjkmsJHMczcnhLl+cLHxlABZQNvj
 cVPVXkzwYB9oijTZ2qCfokWLSZeUIIni4fCBsZzOp6zT+SPvV0koBN8eD8Fo42s7cWP5qp8Dk
 gR55iizPa4Pj6PSYaEsD9OJhU1+1wItiPFqO5Z/mIoU/6lQfVOtrKx6s1fpgZ/+QcnGwvnRAA
 CBcD61ugN0gstK1J4PAwW6Q1LVvAOWsbwKF1Rd5mcruBOFiadk0wBddw3kmJYy4JkhSQmv+Wq
 ub2wD+xkj3Lsyw=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/6 04:28, Josef Bacik wrote:
> btrfs_mark_used_tree_blocks skips the reloc roots for some reason, which
> causes problems because these blocks are in use, and we use this helper
> to determine if the block accounting is correct with extent tree v2.

Any idea on why it's skipped in the first place?

Thanks,
Qu

>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   common/repair.c | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/common/repair.c b/common/repair.c
> index 79519140..413c3e86 100644
> --- a/common/repair.c
> +++ b/common/repair.c
> @@ -87,10 +87,6 @@ static int traverse_tree_blocks(struct btrfs_fs_info =
*fs_info,
>   			btrfs_item_key_to_cpu(eb, &key, i);
>   			if (key.type !=3D BTRFS_ROOT_ITEM_KEY)
>   				continue;
> -			/* Skip the extent root and reloc roots */
> -			if (key.objectid =3D=3D BTRFS_TREE_RELOC_OBJECTID ||
> -			    key.objectid =3D=3D BTRFS_DATA_RELOC_TREE_OBJECTID)
> -				continue;
>   			is_extent_root =3D
>   				key.objectid =3D=3D BTRFS_EXTENT_TREE_OBJECTID;
>   			/* If pin, skip the extent root */
>
