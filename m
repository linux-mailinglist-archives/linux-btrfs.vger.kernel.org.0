Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312E1389AB5
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 May 2021 03:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhETBDl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 May 2021 21:03:41 -0400
Received: from mout.gmx.net ([212.227.15.15]:45687 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229525AbhETBDj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 May 2021 21:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1621472534;
        bh=VwgWge8mQqJsnwC5GIk6Oiyi71uCDhOzrvAPuKMuX+g=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=jdY6TLF8UEZL39+Xy39aR2G5qIQWf/GzHFd5NF/YhBlvHwDTQEebKXJxJg2DYF4gr
         wisLyRdw2Qhv8IE1JVFsjdrANdEDRSzKke0LA43HIdOIbybOJu+3qKk9lt6vfREWyk
         bfLna/ZbJYkXkeOi3f+I2hFcDZvho9cDOeCkxpDY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MF3He-1lhI1l1rxY-00FQ5e; Thu, 20
 May 2021 03:02:14 +0200
Subject: Re: [PATCH 1/2] btrfs: fix error handling in btrfs_del_csums
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1621435862.git.josef@toxicpanda.com>
 <dbb1747494ad6ea6e66fbe27c37ea3730a7ac615.1621435862.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <f73effea-f4b8-cc44-a7c3-bd4942fb46c6@gmx.com>
Date:   Thu, 20 May 2021 09:02:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <dbb1747494ad6ea6e66fbe27c37ea3730a7ac615.1621435862.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0rkOly/XCCx3Bgf0XE/Zo/I53v55nPJGCUv7YfAYF3O62RfucXW
 bHYy75EK9VeweiAamHMnh0RuR7Z21Hz0GKsl49iRODdkvJOpo9mEIP5eD694Fyoa8tlW7KT
 TNBLR8wTUSV6atDunvNwAKiCdaplmvrbvGVbCo/vNKoQj1JRBsMqs3JQKnvL46J/1N7Kfn0
 7lB8UX8vcZ+AkQa4N1ltw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6bbNmsyJFx4=:aLSIcS8XqA7LNE/6wiWiiY
 GAP2I+8TjGYjfB5JeW+u8qGe71qfhTJALsBCLImO/7lO0sVwBP7BfcWrGmaLQf7dL8GT4ZdQU
 wkBXBrLfA+78vWu6JH5j9PvsOYSQVkDqqgbiV4aX1aHzxH0bZTVaUjp1h23QVgFJBevSRuI/B
 FUpQV8zkZ13PJEzZpHf1B6Pah07gmDaPLyUFiuahwcvli0RoV/lsDmCF8oU6KlAi8AaevSkpp
 8ozFgAK5YTDJtg4mPsz1pYjCiN4RBVhCH+NsHc5c+fVq579jUONH0FDgLltNBH3kd/rpc0a32
 8x9wl8ZbzzhQHcw/QlU7PDeHaVxqZCwitImwek+Qv3Y3ekjJiff5iWajOnJpD5ajg7SSOTQBK
 7TaScObDe8jfAQpxSzTqI0pR2tERLzsqz7k7bkoTBZn7RIIb2GRQ1gus+qW4kMgfXLj5WX1O0
 5ViS0hJsLns9JDwAZMeJnPH3+ItAhw/e4KABCeIp/qqJLVTpjCaKVhJajHi85jfU2IU7JGJ7m
 o3qCDPLcnEKLUpGdfsPC/+k4eDKJeEUVe3iKQXaqtJSSuQlZQhCwrycDuYpBUZEEIqZaU7Ib+
 ZqpYA6mNgs3RIMaGU+cO0z6e58cKkrc3CsVAIh1LzMACuZn/gv/6P9KuANPxAaWgzMzLSCTqI
 3XQENj1eLwErrJ6pFEL2pr8lSqZnsB/aykWYQjw8t9DDRMNtz9R5vz0OLOXNsgrADSaTus2pu
 NvLgDfwI4/uX/5dw7wXpx/hTpxu/HjsFpfZhEzi9IjC2WWi4UKInvWji8wGpCdwv5PGrL7Dov
 E3FUVo9yTDbqfaOpU/Y0KD6iPXX0OpcoUkpaF9H+4XsSRCd7uRxjqXm5VT64hp4k7A7VqvfkD
 jGOjFRVRfZ5sdFf6fzcU5w4lnoskVaauC/GkOpBO7Q7BfK+/oa/XF64i9yRs+BeoQTyIMm9yj
 YliVRm2YHC4HSV7hkcgHEuglO59krDgbHr5kRjPABfo1+C4Ts2NXvJL6Ez/3p5PrpaORyCsgc
 bNmbTLtAbM2lHc0spCpZfj5/QlrUnrLzd/9orj/yxFULZ8zA2bLSf/JJ21G376VTslc8t+k76
 RzUbXSaetehz/Gms2DpPx0hQuEPK1CTowOp/YaU1Rx1+6NMxAgHmjCfiG1WJwAJq1uOWgu4S1
 /M8kRno+R2zb7dNhTkpZINX/1sHsjgl4SO5f2z3El2AxZOJiXzWetrzbNeGzaMZZp2SeKaw4h
 SRD6KfR7h9Y2bnwba
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/19 =E4=B8=8B=E5=8D=8810:52, Josef Bacik wrote:
> Error injection stress would sometimes fail with checksums on disk that
> did not have a corresponding extent.  This occurred because the pattern
> in btrfs_del_csums was
>
> 	while (1) {
> 		ret =3D btrfs_search_slot();
> 		if (ret < 0)
> 			break;
> 	}
> 	ret =3D 0;
> out:

Such "ret =3D 0;" is definitely causing problem when break is used.

> 	btrfs_free_path(path);
> 	return ret;
>
> If we got an error from btrfs_search_slot we'd clear the error because
> we were breaking instead of goto out.  Instead of using goto out, simply
> handle the cases where we may leave a random value in ret, and get rid
> of the
>
> 	ret =3D 0;
> out:
>
> pattern and simply allow break to have the proper error reporting.  With
> this fix we properly abort the transaction and do not commit thinking we
> successfully deleted the csum.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/file-item.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index 294602f139ef..a5a8dac334e8 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -788,7 +788,7 @@ int btrfs_del_csums(struct btrfs_trans_handle *trans=
,
>   	u64 end_byte =3D bytenr + len;
>   	u64 csum_end;
>   	struct extent_buffer *leaf;
> -	int ret;
> +	int ret =3D 0;
>   	const u32 csum_size =3D fs_info->csum_size;
>   	u32 blocksize_bits =3D fs_info->sectorsize_bits;
>
> @@ -806,6 +806,7 @@ int btrfs_del_csums(struct btrfs_trans_handle *trans=
,
>
>   		ret =3D btrfs_search_slot(trans, root, &key, path, -1, 1);
>   		if (ret > 0) {
> +			ret =3D 0;
>   			if (path->slots[0] =3D=3D 0)
>   				break;
>   			path->slots[0]--;
> @@ -862,7 +863,7 @@ int btrfs_del_csums(struct btrfs_trans_handle *trans=
,
>   			ret =3D btrfs_del_items(trans, root, path,
>   					      path->slots[0], del_nr);
>   			if (ret)
> -				goto out;
> +				break;
>   			if (key.offset =3D=3D bytenr)
>   				break;
>   		} else if (key.offset < bytenr && csum_end > end_byte) {
> @@ -906,8 +907,9 @@ int btrfs_del_csums(struct btrfs_trans_handle *trans=
,
>   			ret =3D btrfs_split_item(trans, root, path, &key, offset);
>   			if (ret && ret !=3D -EAGAIN) {
>   				btrfs_abort_transaction(trans, ret);
> -				goto out;
> +				break;
>   			}
> +			ret =3D 0;
>
>   			key.offset =3D end_byte - 1;
>   		} else {
> @@ -917,8 +919,6 @@ int btrfs_del_csums(struct btrfs_trans_handle *trans=
,
>   		}
>   		btrfs_release_path(path);
>   	}
> -	ret =3D 0;
> -out:
>   	btrfs_free_path(path);
>   	return ret;
>   }
>
