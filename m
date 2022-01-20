Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDF7495714
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jan 2022 00:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244889AbiATXlh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jan 2022 18:41:37 -0500
Received: from mout.gmx.net ([212.227.15.19]:35333 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231563AbiATXlh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jan 2022 18:41:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1642722092;
        bh=mF1JNy0VgWjCka5PbBCOIevEJ4eW/kznEoWsL//HK2M=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=VkjgYxUdf3/+JZJssV7v57mjFfHVwKLrckQ5Vp+yu4dMGYD4S0LVxku+ilO/0KWPZ
         LcAVK/+ZixkwSSn51x7fHXQiTpVrsRdm8PELADZR6i2WYYxmD69LZiG0ahOrX3RoDJ
         B00mfKG+IAVyfn043VuRNfOXXn5nWk8HUSooK0Rs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MWzk3-1mm6io1oe9-00XM6H; Fri, 21
 Jan 2022 00:41:32 +0100
Message-ID: <2b441be4-4c20-66db-ab41-36870e5be43c@gmx.com>
Date:   Fri, 21 Jan 2022 07:41:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] btrfs: add back missing dirty page rate limiting to
 defrag
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <3fe2f747e0a9319064d59d051dc3f993fc41b172.1642698605.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <3fe2f747e0a9319064d59d051dc3f993fc41b172.1642698605.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iVp2rB3uCMnUShlqYThkeOeicaGAFg6u5n76UawduyZZBWQOZ3x
 fvqiKoKMQ93uBnXMP/cVmI9okenpa0n+ZBl/ik4XXijvcc6mgxA8hCRwH0Cq/YXthomd/mC
 gMvQhkbah6CfPGZ2pewS4FpOhsRJ0aFul1nuwLghv0ZfCqu4zcbT1TEY3KoVAKIZHqslvlH
 2DpiIGyH8g7Y6rd6IpQ6w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+8E6CvB2zXY=:G+x44dItIRCxEzESGYHoMJ
 z7NGMX5+/nEOK/P2p22Oy5Mzy2fmCEv5aB+jya1POkCcew+wtwvO5r9+JeesbHUCQZVqAnfYS
 eWz835gw2hIukWwMBuC+Y7SmyA8KZlQhqtIH/dzoY76NTfX4EKdnbsiDlZLxHPCXJeDHpFvL2
 ggyG6eXCdETp1OZSiTxBRgu+xPfZGCFe9ARTM0Sdy/hEMCr32fG4yi7DH6rFLZQKaD/2/8vaY
 vpRz2B20jaeWRaUtWuy0zmOir4mwWzHMIMgmKWmfLDqcPGzmwl312984pl0kAEnAulnfwjtHQ
 kn/sO71YVZLd6ZW6LY9kxkK8hm04SKsAsLP0GnCJBaoOJaHJvAvXZ3JIfambAFQSCMHOp5M3u
 u9FGow7ntSStHZ7efq7TCVj70SMZ4h0YDFp7RlIdMYX2NJyyx4S/kJ5m9I5fzfKeR9NIhpAnN
 BgJ6Q8jVyEBCAF9FFRo1YKFxPjCrYjLdQw0KkMr5zoVG07tHpaVQIUprbUCWiASbvHo0CfO+W
 4O56U1PrKfv3rerJACmfNkGm63xovDG4nw5OpIR+EGzY8jCGwr0PNcCOBB6qOiFqzduG5jRin
 hxMl6slfY9LzXR8zVAngWBctUMWQatXiDuYxUlBZfAlTQ6TP43PybAMyuqRuVr4Cz+3b9xBKe
 1KJOWf+iMtDtnT6hqGFzSA+T12qeRR8GBZZp95CS6DN//5g+yhw1SSo1yne1vqzf9yuY3A9CW
 QueeVvDjw1nAIQkHWq0NxD6nztvbA/wJUSiWT9yZGColIxBUpZ8Z0PqHScfOX6rDteUb+1Emc
 3PsG8WLS0K8g+IzgNfEPE+Rff3lEUlQyzF+nOSCSfksEJOwtIG8H5DA+CIXZtUNu+HYywqg6n
 E2tvOr+Yzpyi1wiYmuaSjVj076q5E0HNYn0v2Jm+k95tHRsyrQt/A3Gj8I//BQb0MvEkub2W2
 HpyhprguMg5MwZ5dW0jjQW7jsAcSv7X3AdocFK7z6YzhwkkbRjtJuZsm9TesrICmLDqVu5VzK
 lgTYHrpoMLSYMtf6tPiRPATcokHiuby9SuDbtRnWPpp8B+1Fl/1VloKXg0HGBMIRPAVNlyS8i
 UTiHTEy62TAiL0=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/21 01:11, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> A defrag operation can dirty a lot of pages, specially if operating on
> the entire file or a large file range. Any task dirtying pages should
> periodically call balance_dirty_pages_ratelimited(), as stated in that
> function's comments, otherwise they can leave too many dirty pages in
> the system. This is what we did before the refactoring in 5.16, and
> it should have remained, just like in the buffered write path and
> relocation. So restore that behaviour.
>
> Fixes: 7b508037d4cac3 ("btrfs: defrag: use defrag_one_cluster() to imple=
ment btrfs_defrag_file()")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/ioctl.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 0082e9a60bfc..bfe5ed65e92b 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1577,6 +1577,7 @@ int btrfs_defrag_file(struct inode *inode, struct =
file_ra_state *ra,
>   	}
>
>   	while (cur < last_byte) {
> +		const unsigned long prev_sectors_defragged =3D sectors_defragged;
>   		u64 cluster_end;
>
>   		/* The cluster size 256K should always be page aligned */
> @@ -1608,6 +1609,10 @@ int btrfs_defrag_file(struct inode *inode, struct=
 file_ra_state *ra,
>   				cluster_end + 1 - cur, extent_thresh,
>   				newer_than, do_compress,
>   				&sectors_defragged, max_to_defrag);
> +
> +		if (sectors_defragged > prev_sectors_defragged)
> +			balance_dirty_pages_ratelimited(inode->i_mapping);
> +
>   		btrfs_inode_unlock(inode, 0);
>   		if (ret < 0)
>   			break;
