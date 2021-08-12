Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284BF3E9E2F
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Aug 2021 07:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234487AbhHLF5s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Aug 2021 01:57:48 -0400
Received: from mout.gmx.net ([212.227.15.15]:35891 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233072AbhHLF5q (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Aug 2021 01:57:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628747838;
        bh=Xfa15CCQoJDmZJDYPBVV7SosU7hM+KgHXTKEdYFilN4=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=F824ucGJud+Rn7b6E5xCq4UhOKxeMAHZURg58mtTNGq577B3u32Sla3QGLiX/9Xun
         Jt+pC63NmlFqGM40A4P/rThfhCLOk0IVfydsFfX8uQyxxOan3VMliBCBQrmh9pcvvl
         zuhCtjPtNrboDp3tdEkc+3ZPHJWerMVgwiuII+hs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MTRR0-1mfaTZ3YSq-00TlvB; Thu, 12
 Aug 2021 07:57:18 +0200
To:     Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     dsterba@suse.com, guaneryu@gmail.com, wqu@suse.com
References: <20210811144903.1425-1-mpdesouza@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v3] btrfs/177: Add filesystem resize filter
Message-ID: <dae3d33f-c588-9a79-35c0-01cd433f630b@gmx.com>
Date:   Thu, 12 Aug 2021 13:57:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210811144903.1425-1-mpdesouza@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qOt3e4Kzu176hRd3+oQAtW4bGTfeKAwAC0RADdnwgYbxteA1o6P
 M80du6SjRCPcc3GfSOohIrbOmjSVXHyCOeWKYVccmWkXp4eOJS0J1kcyMvG0vbU9cDLUB8N
 Cw4xkLTQnBbGa9iwAa8SE7ISFN2EqyuhrqjtfGewtqX7RJE/YRT3+98z6smu9i8y/H7uPRo
 +A49DGXPxfBRt9CM8NX+Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4Uil7cAFbaM=:ZAJ2Si9uoNROhTpOgU0bgh
 E6GDDldvBIf+ZpVxI2CnWzxV0f6OBEOYXFLSc6aVFMJHHIP2FXL5FMAMrcWoue5C9kXNDApCI
 nr0Kzh1Yr5nDC+B0ET6ZKMvfqFB4fs0jtHWRJeup/KdQj6fcLLN0K4SzjmpjgTiD8EzxlV5e2
 bQimCdh9w3OWUjX1SepYqrKxNeR2g1t3then8fWIZEQRVE9zhlMfgleBG1BNcTwdx5pEirjGi
 fHOdMi0aY5AihBM0jHsqbZ3H+EKL3AmlxnIcMVO4xgeGrBhmUHybn407diKsi08jp1aDAhb/V
 KuGgqraEDGF+UxVtp6qX+snMdtdaBf4OPwV8y1IBac7dB/HwMMgbGpNPm9d2LwHP9ZO6V3gux
 kZ5yQdndEDIfsiNYiaq5AmfdXXsaqPXC0s2IlIZnW5NrBAqB5eaOB82PqX83rJFdoMMcbEtla
 2cSysBzElxkUUbFKTFbxQZjhTYTaPC1WdEOz1Nr0Wi/cmdsvmeZ/RNTlhFZTzjVtdyLaBCxdj
 4b0Xmfr56BDpT1BB09Gu2tuYappdYP27vEt61eyQ5+OcQYwqxU2NYKv1IJwO1LIEiMiSfOt1V
 GOIRLORs4yvrHNEODw3C3MCV6KFIWAWeNmx31NtKctdM1l8wb3VyY6BkTIxhghlNrkq9T2zwq
 RUeJMuuvyMyVGJ+xQzWAgkDhJO7C75na4/bvUQJ4FrTMHG7FUnsJSIoHOuhcMInTLEA801QJx
 /+NnxckmC5J+zRLufZk+fnihLKxl2STVXmeWI/Fdow275os8pDq4lXgJIKBMfjVH/Y9zHviHW
 LPJUMqmHZjxxQOM/fvPXcgKQ74Kq1h3Jt3NojFLZNn5d9WOJoznbl7fkhLqZttZDStp6bfqaM
 nx6W+OeUD8C+Q95V3YS3uSu78iYmYUcuXqF6N/CshQGu2wjB8riiQV/bjQy9PO1caqhYYsRvg
 7BoDoo28rkthJIwwAFFGEDCnPEUIJQwWkhqjXPztjufXvqNph19uwZIPvCoN89HsFNck8voEV
 pxLX+8thLV6Nn7Z9P0uOU2qZE93ykqVgnkEHygLAxqfdd0+m6bbMq2QhJQcFUHtWTCA6nct32
 6KEhu8DzmYVi+GEfMMmvhvWMKrEhHG8vdV5A00i/8TUgR9/Bhpb/25dog==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/11 =E4=B8=8B=E5=8D=8810:49, Marcos Paulo de Souza wrote:
> Commit 78aa1d95dd99 ("btrfs-progs: fi resize: make output more
> readable") added the device id of the resized fs along with a pretty
> printed size. Create a new filter to simplify the output message using
> size in bytes.

Finally we can get rid of the false alert!

>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>
>   Changes since v2:
>   * Check the output to verify if the resize really happened (Qu)
>
>   Changes since v1:
>   * Do not adapt the output message to the newer format (Qu)
>
>   common/filter.btrfs | 24 ++++++++++++++++++++++++
>   tests/btrfs/177     |  8 +++++---
>   tests/btrfs/177.out |  4 ++--
>   3 files changed, 31 insertions(+), 5 deletions(-)
>
> diff --git a/common/filter.btrfs b/common/filter.btrfs
> index d4169cc6..fd422e08 100644
> --- a/common/filter.btrfs
> +++ b/common/filter.btrfs
> @@ -72,6 +72,30 @@ _filter_btrfs_compress_property()
>   	sed -e "s/compression=3D\(lzo\|zlib\|zstd\)/COMPRESSION=3DXXX/g"
>   }
>
> +# Eliminate the differences between the old and new output formats
> +# Old format:
> +# 	Resize 'SCRATCH_MNT' of '1073741824'
> +# New format:
> +# 	Resize device id 1 (SCRATCH_DEV) from 3.00GiB to 1.00GiB
> +# Convert both outputs to:
> +# 	Resized to 1073741824

Great comments on the old and new outputs.

It's fine for the existing 177 usage, as its size is always fixed and
always GiB aligned.


But if the helper is going to be used by other test cases, we need to
take the accuracy loss into consideration.

For the new output, we only have two digits accuracy, if we convert the
output to binary, it will cause some inaccuracy.

E.g. if some tests is utilize device size like 4,000,000,000 bytes, the
pretty output will be 3.72 GiB, and if you convert it back to bytes, it
will be 3994319585.28 bytes.

Not to mention you also deleted the trailing zeros, which further damage
the accuracy.

I don't have any better idea to solve it though, thus I guess we'd
better just add some comment about this problem and call it a day.

Thanks,
Qu

> +_filter_btrfs_filesystem_resize()
> +{
> +        local _field
> +        local _val
> +        local _suffix
> +        _field=3D`$AWK_PROG '{print $NF}' | tr -d "'"`
> +        # remove trailing zeroes
> +        _val=3D`echo $_field | $AWK_PROG '{print $1 * 1}'`
> +        # get the first unit char, for example return G in case we have=
 GiB
> +        _suffix=3D`echo $_field | grep -o "[GMB]"`
> +        if [ -z "$_suffix" ]; then
> +                _suffix=3D"B"
> +        fi
> +        _val=3D`echo "$_val$_suffix" | _filter_size_to_bytes`
> +	echo "Resized to $_val"
> +}
> +
>   # filter error messages from btrfs prop, optionally verify against $1
>   # recognized message(s):
>   #  "object is not compatible with property: label"
> diff --git a/tests/btrfs/177 b/tests/btrfs/177
> index 966d29d7..ff241bed 100755
> --- a/tests/btrfs/177
> +++ b/tests/btrfs/177
> @@ -10,6 +10,7 @@
>   _begin_fstest auto quick swap balance
>
>   . ./common/filter
> +. ./common/filter.btrfs
>   . ./common/btrfs
>
>   # Modify as appropriate.
> @@ -36,8 +37,8 @@ dd if=3D/dev/zero of=3D"$SCRATCH_MNT/refill" bs=3D4096=
 >> $seqres.full 2>&1
>   # Now add more space and create a swap file. We know that the first $f=
ssize
>   # of the filesystem was used, so the swap file must be in the new part=
 of the
>   # filesystem.
> -$BTRFS_UTIL_PROG filesystem resize $((3 * fssize)) "$SCRATCH_MNT" | \
> -							_filter_scratch
> +$BTRFS_UTIL_PROG filesystem resize $((3 * fssize)) "$SCRATCH_MNT" |
> +						_filter_btrfs_filesystem_resize
>   _format_swapfile "$swapfile" $((32 * 1024 * 1024))
>   swapon "$swapfile"
>
> @@ -55,7 +56,8 @@ $BTRFS_UTIL_PROG filesystem resize 1G "$SCRATCH_MNT" 2=
>&1 | grep -o "Text file b
>   swapoff "$swapfile"
>
>   # It should work again after swapoff.
> -$BTRFS_UTIL_PROG filesystem resize $fssize "$SCRATCH_MNT" | _filter_scr=
atch
> +$BTRFS_UTIL_PROG filesystem resize $fssize "$SCRATCH_MNT" |
> +						_filter_btrfs_filesystem_resize
>
>   status=3D0
>   exit
> diff --git a/tests/btrfs/177.out b/tests/btrfs/177.out
> index 63aca0e5..eb374d34 100644
> --- a/tests/btrfs/177.out
> +++ b/tests/btrfs/177.out
> @@ -1,4 +1,4 @@
>   QA output created by 177
> -Resize 'SCRATCH_MNT' of '3221225472'
> +Resized to 3221225472
>   Text file busy
> -Resize 'SCRATCH_MNT' of '1073741824'
> +Resized to 1073741824
>
