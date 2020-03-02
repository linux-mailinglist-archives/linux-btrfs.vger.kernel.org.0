Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8E01753DD
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2020 07:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgCBGjY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Mar 2020 01:39:24 -0500
Received: from mout.gmx.net ([212.227.15.18]:34557 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbgCBGjX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Mar 2020 01:39:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583131158;
        bh=w8umxVxuFgH8otnCWY/HRTVKvM25KU2HqftwTQ66KfQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:References:In-reply-to:Date;
        b=Iln78JqxCppMRIZjoMdgUctvuWIWoStOtK/bzCbyTnHzsbvHH4MHRxc89uvWm8kaC
         OS04lnWf8ztS2NrCEXJUL0G2XJjoof8t12xtniKZsTif71dprS/POBV5Inq77Laaxh
         y8spj+errKYHtzfIqT+2RLamH4pUbmnTjkrHlEVk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from p ([129.146.208.210]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N4QwW-1jYP7y3ekw-011Q9h; Mon, 02
 Mar 2020 07:39:18 +0100
From:   Su Yue <Damenly_Su@gmx.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs-progs: disk-io: Kill the BUG_ON()s in write_and_map_eb()
References: <20200302045509.38573-1-wqu@suse.com>
User-agent: mu4e 1.2.0; emacs 26.3
In-reply-to: <20200302045509.38573-1-wqu@suse.com>
Date:   Mon, 02 Mar 2020 14:38:54 +0800
Message-ID: <m2blpf5kht.fsf@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Provags-ID: V03:K1:m5e8DMVZoXExGErBb3ixMggu4k9UGgQsTPNdpVVSUDpO+e97Eip
 UsJD3zA95YRRMlgQDgw5KurkisR24BPhBq+AmsiwiKxlx+NLNhUUeBo6dJYvs8CQTCqH4Cn
 88BYMQ/kBS4WJefDHOmPEIMMUZ0lEaE74g7shGNvM2rL6UlRuC+Ybi+urS1QA/qKBbuMqB7
 3LMG1Yk+gsFBCfd51fLQw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jemH9YRzHBM=:a9o8WY6+leuELhILun/9dY
 dY2TXBnYzDO9Mr/NXVVUD6H+6FOJVbHhwDr7aWiP/UNL1S06B2Ule5U1hYyg9+PHY/SW7IYEr
 /XRTUKFbhcwtJ2MXQn5VtOltvvbzm7HwweBJuxH5ULBxPb/GcuusPe+3e/8v3FfGPXwiAR7hd
 Ikr8xCzi8pXcn13eyczkIrdjaNzX9hNA3bADCn/67vxnJfS7V1rClVWvCxoleGsYZr/pyDfTw
 b+AuKwI2vmDIPaDHobGfVACWYjyEEhnXxc3vmO1yrsPaKRDYzKbwN0K2jm1vloO8PUBVLlazO
 ASvDa384wV1+LGKr9FpXYzSKJOXznncm3M+/OF8I4wWgfILBak/KsFEohoucWcur9iOYkg7xv
 TU42XDCIUUy2INQFt22ufwmcwKA/ruoV/7f+7sNMNmC8ez5neikenamiuDw/4I4L3jxDqM4Y6
 IeYR+Y+uJytwG5dbin5U+XTi3K1ToEDMpiQ+ws4o6wy1y7kwkDlyuHE5IRLRplRNONwR2h9Po
 r4fDq2o6xCAS61FsSIsEcJQBsOevfjMSp5YVGovldh0CR9vZPa83KjVLLSqy0ZRtCWVEHWEy1
 UiGadNzD5D4ZAM7HOcom6cooDoRsswTGB7PXHA59u9nyko3nUwnN9aVJcIs9pjhMilLZOmzJd
 Z8OAcfO7BCYKNBW8h7gNFCd+3EAY3lkgmDud92Ple262LP4vBGzuFFGN390H6bteOVMGSZUOp
 054o/vZIu8i9VSTczCPKzD8GKbmZj1GLb5omvjE0o6C+VS7yEhVDuyvwHcISvICSzLlWsnxlr
 4ylnWkVb0D/m7BbX1wIhsCEmju04iWKdrgq1ZrCtpYEzBShQy4wy6GVQnYCEOrj1Co5FOFaGs
 YgbahnZW0Fz/DB8zQufKXX7UmtcZaS2f0VzESF00p8HO6YsaCqU0Dp2G6npBr//F8FEk88WiB
 MPfzgsNKcpuOMgfrP5HXy87PY13RjwIkNHP1AFk/mgS0yA965Gbipi4fQAHU0CSAaQNiFOfMy
 Y2lhk2Rizd4ZtqsYKYmiJ6QIN8mU3F2+VumBjZ0c+YQbTF7bgzAkCI4QWWV+Ua7L/xZxWGfvt
 pEFaUybKUksJr1DQLjgrT1f8L7LYvvc4I1xxpSIcT6nl15pxhvWGpTaB8zQ41i0G5wgRhDd0A
 suAgBMEgS2bpqZye7geY7ywRvtVh3DE9RNRRSEWPVcI+GjmxLavTkDVaUXb6vVYjBWNvuxO/x
 Cb4qiFpNIywlQ/2fu
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Mon 02 Mar 2020 at 12:55, Qu Wenruo <wqu@suse.com> wrote:

> All callers of write_and_map_eb(), except btrfs-corrupt-block,
> have handled error, but inside write_and_map_eb() itself, the
> only error handling is BUG_ON().
>
> This patch will kill all the BUG_ON()s inside
> write_and_map_eb(), and enhance the the caller in
> btrfs-corrupt-block() to handle the error.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Su Yue <Damenly_Su@gmx.com>

> ---
> Changelog:
> v2:
> - Remove one unrelated test hunk
> - Fix the patch prefix
> ---
>  btrfs-corrupt-block.c |  9 ++++++++-
>  disk-io.c             | 26 +++++++++++++++++++++++---
>  2 files changed, 31 insertions(+), 4 deletions(-)
>
> diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
> index 95df871a7822..3c236e146176 100644
> --- a/btrfs-corrupt-block.c
> +++ b/btrfs-corrupt-block.c
> @@ -771,8 +771,15 @@ static int corrupt_metadata_block(struct btrfs_fs_i=
nfo *fs_info, u64 block,
>  		u64 bogus =3D generate_u64(orig);
>
>  		btrfs_set_header_generation(eb, bogus);
> -		write_and_map_eb(fs_info, eb);
> +		ret =3D write_and_map_eb(fs_info, eb);
>  		free_extent_buffer(eb);
> +		if (ret < 0) {
> +			errno =3D -ret;
> +			fprintf(stderr,
> +				"failed to write extent buffer at %llu: %m",
> +				eb->start);
> +			return ret;
> +		}
>  		break;
>  		}
>  	case BTRFS_METADATA_BLOCK_SHIFT_ITEMS:
> diff --git a/disk-io.c b/disk-io.c
> index e8a2e4afa93a..9ff62fcd54d1 100644
> --- a/disk-io.c
> +++ b/disk-io.c
> @@ -487,20 +487,40 @@ int write_and_map_eb(struct btrfs_fs_info *fs_info=
, struct extent_buffer *eb)
>  	length =3D eb->len;
>  	ret =3D btrfs_map_block(fs_info, WRITE, eb->start, &length,
>  			      &multi, 0, &raid_map);
> +	if (ret < 0) {
> +		errno =3D -ret;
> +		error("failed to map bytenr %llu length %u: %m",
> +			eb->start, eb->len);
> +		goto out;
> +	}
>
>  	if (raid_map) {
>  		ret =3D write_raid56_with_parity(fs_info, eb, multi,
>  					       length, raid_map);
> -		BUG_ON(ret);
> +		if (ret < 0) {
> +			errno =3D -ret;
> +			error(
> +		"failed to write raid56 stripe for bytenr %llu length %llu: %m",
> +				eb->start, length);
> +			goto out;
> +		}
>  	} else while (dev_nr < multi->num_stripes) {
> -		BUG_ON(ret);
>  		eb->fd =3D multi->stripes[dev_nr].dev->fd;
>  		eb->dev_bytenr =3D multi->stripes[dev_nr].physical;
>  		multi->stripes[dev_nr].dev->total_ios++;
>  		dev_nr++;
>  		ret =3D write_extent_to_disk(eb);
> -		BUG_ON(ret);
> +		if (ret < 0) {
> +			errno =3D -ret;
> +			error(
> +"failed to write bytenr %llu length %u devid %llu dev_bytenr %llu: %m",
> +				eb->start, eb->len,
> +				multi->stripes[dev_nr].dev->devid,
> +				eb->dev_bytenr);
> +			goto out;
> +		}
>  	}
> +out:
>  	kfree(raid_map);
>  	kfree(multi);
>  	return 0;

