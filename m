Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 926E63D5966
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 14:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbhGZLos (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 07:44:48 -0400
Received: from mout.gmx.net ([212.227.15.15]:32857 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233819AbhGZLos (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 07:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627302315;
        bh=63QOWAjUHi2jfYYLo+Y5BChDRAE33w5OcvlPFN5lQ+Q=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=NbUoxqlhxbbebIIjOZ1kY6MDvxDnh1ObhOssxIoEFkr9pL4bvE/OZVF4Ufe3OsKFQ
         8wUQ9+GPj7pOXOSkzQNzZer7nYC4ik6e165HQIOLaeQOx19L7K2LSCC3NWHlNK9pQn
         K/jGZKIuB1DxwY/4Brb2FxpV3fn+0nXyQyB1b5Yk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N49lD-1l8ZHH29Jp-0107ig; Mon, 26
 Jul 2021 14:25:15 +0200
Subject: Re: [PATCH 03/10] btrfs: make btrfs_next_leaf static inline
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1627300614.git.dsterba@suse.com>
 <23099d2508b778b3169926538cb495213db327a9.1627300614.git.dsterba@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <664be774-b187-90d1-d17f-390332ebf8fa@gmx.com>
Date:   Mon, 26 Jul 2021 20:25:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <23099d2508b778b3169926538cb495213db327a9.1627300614.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3QI7bu0wLD1FSBv5Un3s0UeMhr2ma3YvjDkoWfNQ0Ih35EwV4JH
 lh9VeZcbsv6jl49AM8LjEAz563d1UFgukH56zSFm4QstMlXMHvl4MzFvYFjzGTgtPHMMUZj
 wx6T7nbhg9s7vs+Bz/y3s1feNgsCN+xP62TPBJmSyQahBv/8DUKt+ZBjg52Rff0SsreujSu
 Scv7JsaBAvsUFSoxg3CSQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fR5S2pbNW5w=:QZOt/ZCdv1897qDAIcDZJX
 mVPG5ZQpfJAiXpoTcM6lBAYakt2ydV9ODe/lnFy0LjbksgacJLz3zVyAy9kYzOG9rERW1lY1+
 88R9oqVtI6RCOn0H92lnfTSKdU1Rn5D43jIujiBDK+tKlFzyeb+lXUV9c1bnkmjQR6hGatdhk
 r+Zde5sCX0Ehu82Drpp5Hmwdt92wmfXBP7UUyhqsuZ0DicdEgOWbhz1qTGkZro8Q+oSTHus33
 2yZqtL+748yimx5KLwoagRTVixRNsA43xptQmTavAwWJg06/lFvmtw+KjpHwrExgR9+37ZLb+
 6IbwD5vMfo+VHqHtqGMB+++S45UawvP2AVVf5ZCf5LrUQml9HCrKb9vwszYY8cbAeZgRh/3Pv
 rxLgEYbIP7KxkrTgPAp+hBa3AJ33wrdPtEMIiKoilRF/WiGsRBHQav1D4L1peb29xpm2KnL+K
 Z5obsUQ8avGgE9TppnA7ZLBQWtKoaWirGRaZ39WWg/186Lf7IVPU+O8vYFVPKIU3gqQ2f5Wep
 ykImQxkVSHeHCOyY6GJ2qnjDH/RXKlRhwUktxddENmbvtiT/wCWED0WwHefRaXi0/LNjL6B7g
 RuLZVY3ILVxJBj+pX+2RQUbBAeLwEcEz8b31pu6tigFQAoJbzSNwVBzL1R/lueY87pq63x8lo
 QuWaIZGh6rQpWwN5c1bqfjaBOTSY0evO3BXddeHIUZjonEu4jeuaj98d76t1100Ld1DPixbhD
 0cqz4PCG8khc2XKAIFUW/gtZz4EXe6WB3nKmxMpmrchBT8EIex7c273+Lr9oDtOT43mVKY5uV
 xQEXU5EPRU/YU1RQ6HZTHNLKwIdQCVEKIVHNoLixo3Q03eL4lvnlcgzVVuehNfdqB/DOrmc1h
 cBul80uRYz3LkgenBtttNfQA3OPUJzC1NGyyNp/+7kLDx9T+P8KsUg0n4zJsvBHPQ8bn8zw5k
 ms4CBsMXVF3rkcbj6EhSrq2M8a/419OnotznvITQD2xO6FHj84MDcpPNAw4ZJRHBWqjpfkZhg
 J37eUaD7OHJ544I26VTucAMkkJprQYP2xodPq4hCsgRNwNCx7dPXpa7wzybtyr8gf4AaAo19A
 BbCqAczPOVP+X+1A3svyYPIyS2CQWnoxXRPJKLVdLRYJA7x/ExSJm/icw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/26 =E4=B8=8B=E5=8D=888:15, David Sterba wrote:
> btrfs_next_leaf is a simple wrapper for btrfs_next_old_leaf so move it
> to header to avoid the function call overhead.
>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/ctree.c | 10 ----------
>   fs/btrfs/ctree.h | 13 ++++++++++++-
>   2 files changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 63c026495193..99b33a5b33c8 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -4357,16 +4357,6 @@ int btrfs_find_next_key(struct btrfs_root *root, =
struct btrfs_path *path,
>   	return 1;
>   }
>
> -/*
> - * search the tree again to find a leaf with greater keys
> - * returns 0 if it found something or 1 if there are no greater leaves.
> - * returns < 0 on io errors.
> - */
> -int btrfs_next_leaf(struct btrfs_root *root, struct btrfs_path *path)
> -{
> -	return btrfs_next_old_leaf(root, path, 0);
> -}
> -
>   int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *pa=
th,
>   			u64 time_seq)
>   {
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index a822404eeaee..04779e3d3ab5 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -2899,7 +2899,6 @@ static inline int btrfs_insert_empty_item(struct b=
trfs_trans_handle *trans,
>   	return btrfs_insert_empty_items(trans, root, path, key, &data_size, 1=
);
>   }
>
> -int btrfs_next_leaf(struct btrfs_root *root, struct btrfs_path *path);
>   int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path);
>   int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *pa=
th,
>   			u64 time_seq);
> @@ -2911,6 +2910,18 @@ static inline int btrfs_next_old_item(struct btrf=
s_root *root,
>   		return btrfs_next_old_leaf(root, p, time_seq);
>   	return 0;
>   }
> +
> +/*
> + * Search the tree again to find a leaf with greater keys.
> + *
> + * Returns 0 if it found something or 1 if there are no greater leaves.
> + * Returns < 0 on error.
> + */
> +static inline int btrfs_next_leaf(struct btrfs_root *root, struct btrfs=
_path *path)
> +{
> +	return btrfs_next_old_leaf(root, path, 0);
> +}
> +
>   static inline int btrfs_next_item(struct btrfs_root *root, struct btrf=
s_path *p)
>   {
>   	return btrfs_next_old_item(root, p, 0);
>
