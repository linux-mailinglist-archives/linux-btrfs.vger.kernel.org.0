Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A3D390D32
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 May 2021 02:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbhEZAIr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 May 2021 20:08:47 -0400
Received: from mout.gmx.net ([212.227.15.15]:34547 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229595AbhEZAIr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 May 2021 20:08:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1621987634;
        bh=bRvaJtfzAzzQAeg5de9bp4MQmnc6woYpwV3Z4Bfcsz0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=DWCicEXWnYeeSOZUcHmMwbRVefbnYidT6FDiSNkTQtHY1/508qFSb3AmJlM7VDfD2
         44XOZplS09RR9YIdrAxU5Ouk1uCnpFOC9boY0Jf1kEinPV42WXW3G/T0MMQM4V5ird
         PiI0RIFoEl0+jfiyTqqGiGT4POLpcN017LoNOAWM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MoO6M-1l5mjy08q0-00okyL; Wed, 26
 May 2021 02:07:14 +0200
Subject: Re: [PATCH 9/9] btrfs: clean up header members offsets in write
 helpers
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1621961965.git.dsterba@suse.com>
 <3a6ce6b310ecb2021a1ffea01fb08f48663d1a00.1621961965.git.dsterba@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <40b121e1-6459-8c1b-e99e-665ac1627840@gmx.com>
Date:   Wed, 26 May 2021 08:07:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <3a6ce6b310ecb2021a1ffea01fb08f48663d1a00.1621961965.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6sYQKgq1nuJoDQGSDuwI5mKCmPhJkAuL6RNBJlHIQ9nI3U9VSaj
 jynQ2NzqTwReq1vnsAgurgfSYxgwO6qEdEc1BPZG4LqvY2uQmbCmvywniUvuS4zG/EtXoGY
 /D4rEpqN//2E38eeYX9sNw6AutznGH5dXcgEreFz30GM/jCaenlrStCfUXGW6EZ30JaW75Q
 7j9kUqEolvBPcOSZ+1zug==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:pUAwZO4YNUs=:cA1qp12klEMLE7d02y8NWk
 VXzlZrJpm/iREb8SV6xRT4qR/KnYhkKN6yjGiPE7S/1GgbJHcLccLShgDVEpH9BUpmFTrtd7n
 B9GP+NI3NPEVBbXxJ3b6QosOTaPOvksOS5fPQISX3SI2eJ3gppMrgbskkvzXTFc/2GxjmQ82I
 9j0tuBa8CqzN3vGg73guUyRZ7Z3hQJIBcfGIIK8zyX4FrG5GquosK53r0KRCQuGHO9aeCdwSR
 48QE97jMQbpMw1UN1szP148ZuUtmSgshCAJg3AApMd+9M2BORbbnUPJBmFTryEwVwjut992mK
 DK2/ZyhqSp8QVJ6ckk41gRcmFU80MGNhPZzRjGXjX9FyMZ3yst5SQZbKXJpISlvt9fXucJhWO
 lSCahAfSiT3z45DKfE+KcR1K/chd+p7IiOTuq7LopYmUTnMCA3AVhWNieUEE1bTEcm8idLDMP
 GyDQO8/H+1cvsRwQIRHnl+R5RWNyRXe8P7Wo602AXhialK74A75ifjBTm7WJN6saltgLGqLb7
 allbMmgp9+k/HUwPSgE/qy5kS88ZZ/EB2DtTbLZC37wTn4jBtoe496i3QSuJk8XTq1O+Fa3EV
 b8fdpbgiH/BQ9e06mAfO9opqUYvRKt1345Y7rLtv5ehra4jl4wvqNckFIUH4Sp//KAij87DSP
 ghRAPyCZH0xHr6J59610bfBs8pnvMat47SCNK1QZGX9ahfbpDhrbBi/d6aC8EVJ5Zta2KKNEc
 Q8Qtbj1bAdMGe2j/coVxsruicaZiVoqgF4uyj4CzxKIfPGreXABvY9P0qRYEY2V4eWSMRx5Db
 q89jF4iqDdkaIMrVOWWDCGceFjH9FSy/o6z0jPxKx10AD6e7id0hzma42UnkJd+zuc4qcpWlU
 nDiDRKBnzMXbYFUcZSsxQAxalr05O6PuoLwBiZu/jGGtsoeNQ+kT00BXcI/SkRFfLrquyC7D0
 x5isdIbKh9L2nDb7LCZmfPKVy6nFYyQWYTkGtiFO2qoKaIZcEHqlvxM8rMeIIYRRmcEoRvNVc
 t+zNK+Nmw+D8xIwB6Q6ZqIzA1fhM0JkjfquD5ohaJNQC2KAJvL7lUOHBkb+MOiBBizoIhcU1W
 NGuN1t8xy9Tp3ermiP9lmLQDu1Flj3WMTQSnLCtzg1bIdqIrIn62+vrkyPgD92FgoOddHvY9S
 xFqViXcbWiBYTs6XkzZvKKZn3OZhXO5wrtlC7yl/PIHQG/v1WpHM4uHGEl9bXPKWfB4cq9YtZ
 cbraqhgnqbynXz0Et
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/26 =E4=B8=8A=E5=8D=881:08, David Sterba wrote:
> Move header offsetof() to the expression that calculates the address so
> it's part of get_eb_offset_in_page where the 2nd parameter is the member
> offset.
>
> Signed-off-by: David Sterba <dsterba@suse.com>

Indeed better than the original expression.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/extent_io.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 2b250c610562..2e924f60ea6f 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -6519,9 +6519,10 @@ void write_extent_buffer_chunk_tree_uuid(const st=
ruct extent_buffer *eb,
>   	char *kaddr;
>
>   	assert_eb_page_uptodate(eb, eb->pages[0]);
> -	kaddr =3D page_address(eb->pages[0]) + get_eb_offset_in_page(eb, 0);
> -	memcpy(kaddr + offsetof(struct btrfs_header, chunk_tree_uuid), srcv,
> -			BTRFS_FSID_SIZE);
> +	kaddr =3D page_address(eb->pages[0]) +
> +		get_eb_offset_in_page(eb, offsetof(struct btrfs_header,
> +						   chunk_tree_uuid));
> +	memcpy(kaddr, srcv, BTRFS_FSID_SIZE);
>   }
>
>   void write_extent_buffer_fsid(const struct extent_buffer *eb, const vo=
id *srcv)
> @@ -6529,9 +6530,9 @@ void write_extent_buffer_fsid(const struct extent_=
buffer *eb, const void *srcv)
>   	char *kaddr;
>
>   	assert_eb_page_uptodate(eb, eb->pages[0]);
> -	kaddr =3D page_address(eb->pages[0]) + get_eb_offset_in_page(eb, 0);
> -	memcpy(kaddr + offsetof(struct btrfs_header, fsid), srcv,
> -			BTRFS_FSID_SIZE);
> +	kaddr =3D page_address(eb->pages[0]) +
> +		get_eb_offset_in_page(eb, offsetof(struct btrfs_header, fsid));
> +	memcpy(kaddr, srcv, BTRFS_FSID_SIZE);
>   }
>
>   void write_extent_buffer(const struct extent_buffer *eb, const void *s=
rcv,
>
