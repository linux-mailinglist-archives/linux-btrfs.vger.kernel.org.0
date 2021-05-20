Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49572389AC0
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 May 2021 03:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhETBI4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 May 2021 21:08:56 -0400
Received: from mout.gmx.net ([212.227.15.19]:38823 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229498AbhETBIz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 May 2021 21:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1621472850;
        bh=5x9/dzjFwTzzqhjcbmC6rviNdZEMkD67F2K/e9wsSqE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Sc3WkzI3oIS9luEPfF3v7XUgT/P7efxh1QzLMr6b10yYqtoGbmC7qCc4eUVYMqC90
         rmm9hgBHRu7PE6X4gLhswB/9GnAderfgkXa3Eh/P0sznoaOt8zrCQPvdK58IDZfLAU
         H75nrvOHRyg5iwtlir62bM+gAoHbsNYJVcp9eB7I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MgvvT-1lFPbQ1H5h-00hNyH; Thu, 20
 May 2021 03:07:29 +0200
Subject: Re: [PATCH] btrfs: check error value from btrfs_update_inode in tree
 log
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <2661a4cc24936c9cc24836999c479e39f0db2402.1621437971.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <c82160a4-03bd-783d-009b-5ab5e25424f9@gmx.com>
Date:   Thu, 20 May 2021 09:07:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <2661a4cc24936c9cc24836999c479e39f0db2402.1621437971.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3pgr4xJFj+dXgg70krkoV4pYcOIBYRxagZclGG4qVnbRRg+M6Dy
 xtvtzQzU+0AgWmYzWVhdkbVhklWOVI7WOqYXtJdpapFYzv/2lrSJ0JIT9CfNYuPuSzw38e7
 YVEYHA6IWtFVcHHmCKfHSw/K7ipFAlS3LJLoK8uuGas/Kgtpw5yhSvnKQ7hEerzaOcyyaOs
 AFn/vUy4p32YYWJQx8MHg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fND8FsE2AFs=:ClBkniFUMOEUMOjmRh4VYP
 J0bhdh2zm6/aTSrF9BZJEt1f+VEHc4nwGiz02XSraeUgik5Kl89HibvdN8FonmpqMLS+bYdkB
 CkLZSvodAz68gyNWKzVfadNSsR2Xt4qOH+DA7qQ46kkJ5GyXEhU1yqJkmupbrEe/D1Mx0TWpw
 ERQ/y1GaAOZfPCoRohqZAyAm7UTjgsiMlcbrWVMictMf/1RijxIS7rEUVr2FCCAQXMGqjBAHm
 wHXaGVc+b706GOPhjuP1UTvSAJRRMFe3yKiNvUuR1UDAF3GDalP46YZ89KDCwnSkR42qiFauD
 NREwmtHX1G5KwKUuUb2E8FxOykk5br6pgs2Pu5rXQpH7F/ivnyvxc1X+NBI7ACNyuudHL1vqq
 d5tzve0rDK/3tSx/2uhDtDBQrBnD9irBgFwuRddANYiIxcAvmYSU+rTFJ5JnUT5nHoYodYlcA
 85kHRbx5klpRbd0ijJb1Obpu9/0RsfOivO7Nv2EsRn1z2TdoMaj6XsFUIGkdf11QGxkFl+Pa0
 NgWp9dqiZjEHeUF4WSqDOyYVs7C/Oy3fZzX0ls9R+t8LImqtzErhDfBuE3ATDXx4q+9LFYO2X
 uIGcopr6knBgRQxI9D6subysftZNAPBiNQxWtr/FiUhCxhtjzmJkMBnhGMmaIJfczyq3mZn1b
 nwjB5a6v+IgEB8UIDboCIt3yV8WQQ7vLw0IlJ0XzKCM/VYQQpcdavMc9q85gDj5OnhTOvDrEw
 Zm2iGKIxAUQP2nTisLoTxcjArE4SuHrvzxVrHbh61TF3Py50wTgsCX9XtockZ5c/FSDF1UJe+
 z4c9FrwV5ReuxtWnlsa6tI4i1dx/hhJcmmJE0vJzxtfZV7PJKQOv1xcE76G55pBeWipS1+H1v
 RLcrAurcdx2ww9qppdLwo0UW0q9fa9HCDft/TiNebUbdU6npULaiz1snC//LkdZ4HqUPKiYEy
 fJY5HHoc0LlYp68v+Y5eLspRfgxqL3Pbq3GF17hwvMZSC3X+C0mnqwCR80A31ItVb83pE58J3
 +Ur8HuAkfymShgZOE1YxpX0gqUZtVKJMjz04deo0xmn+AblQ7H00CgkVUZfrSPbn8wmPul5uL
 b8bUvIUZFAG12LZS8nuYS0brUg67AleShdcVZ2c+3P/QijFVeTH5enEUD+DtUxYTsfPdtImhG
 0DUa3I2uv3Ddpvb38BOArTylt2l7NG6fKlz5Inufv7dTL4ykp4OJ5zbdk8bSvuJ2iDtSg8hcB
 44hqXzjI+OYqJRuta
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/19 =E4=B8=8B=E5=8D=8811:26, Josef Bacik wrote:
> Error injection testing uncovered a case where we ended up with invalid
> link counts on an inode.  This happened because we failed to notice an
> error when updating the inode while replaying the tree log, and
> committed the transaction with an invalid file system.  Fix this by
> checking the return value of btrfs_update_inode.  This resolved the link
> count errors I was seeing, and we already properly handle passing up the
> error values in these paths.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

But one thing unrelated to notice, inlined below.

> ---
>   fs/btrfs/tree-log.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 326be57f2828..4dc74949040d 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -1574,7 +1574,9 @@ static noinline int add_inode_ref(struct btrfs_tra=
ns_handle *trans,
>   			if (ret)
>   				goto out;
>
> -			btrfs_update_inode(trans, root, BTRFS_I(inode));

I did a quick grep and found that we have other locations where we call
btrfs_uppdate_inode() without catching the return value:

$ grep -IRe "^\s\+btrfs_update_inode(" fs/btrfs/
fs/btrfs/free-space-cache.c:    btrfs_update_inode(trans, root,
BTRFS_I(inode));
fs/btrfs/free-space-cache.c:    btrfs_update_inode(trans, root,
BTRFS_I(inode));
fs/btrfs/inode.c:               btrfs_update_inode(trans, root, inode);
fs/btrfs/inode.c:       btrfs_update_inode(trans, root, BTRFS_I(inode));

Maybe it's better to make btrfs_update_inode() to have __must_check prefix=
?

Thanks,
Qu


> +			ret =3D btrfs_update_inode(trans, root, BTRFS_I(inode));
> +			if (ret)
> +				goto out;
>   		}
>
>   		ref_ptr =3D (unsigned long)(ref_ptr + ref_struct_size) + namelen;
> @@ -1749,7 +1751,9 @@ static noinline int fixup_inode_link_count(struct =
btrfs_trans_handle *trans,
>
>   	if (nlink !=3D inode->i_nlink) {
>   		set_nlink(inode, nlink);
> -		btrfs_update_inode(trans, root, BTRFS_I(inode));
> +		ret =3D btrfs_update_inode(trans, root, BTRFS_I(inode));
> +		if (ret)
> +			goto out;
>   	}
>   	BTRFS_I(inode)->index_cnt =3D (u64)-1;
>
>
