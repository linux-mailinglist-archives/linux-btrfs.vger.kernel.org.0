Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8AC478893
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Dec 2021 11:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbhLQKOq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Dec 2021 05:14:46 -0500
Received: from mout.gmx.net ([212.227.15.15]:49661 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229608AbhLQKOp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Dec 2021 05:14:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1639736072;
        bh=VMjG6bovpLz2G78HsRtmB2+2FK8uKwPxs9hxlTIl/iI=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=fXmIvgVGez58dtp7BVu2vUVkc4qHWwuMOY5uBei99Yo2otkaHFxsFfEd2hOYVzWlE
         BEFdNzBPpRtP1weK7C4IRm+cthnhsLMejO0Z3vrfwtrJMin+REqvDr0WWZN38Ek/Xv
         PS/LMAZlYuRnV4Vq1hrFKfXMHJnI6J43QNfxfkr4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MWRRZ-1n16pY33ZD-00XurR; Fri, 17
 Dec 2021 11:14:32 +0100
Message-ID: <69c7ac46-a469-d4d2-d4a7-c45f722816a0@gmx.com>
Date:   Fri, 17 Dec 2021 18:14:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     cgel.zte@gmail.com, clm@fb.com
Cc:     josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20211217084522.452493-1-deng.changcheng@zte.com.cn>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs: remove unneeded variable
In-Reply-To: <20211217084522.452493-1-deng.changcheng@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JLmdbj5QbA/eFa3FJcz2IEBO1xZz/124hktQeRcZ2wF6wXnj2AN
 cyOy0JgCejNh+3MqRxyd+vVS909Psx0ln3UoKEm+r2jVlQYwXsSdoKyMFycZT7X0t2F6/CG
 7hr+IwtAQ7f8tJOpe5cJATFNuPWuPFSYP5lp1VAUYoVMqSuBdz/+mlAC8MUqZQsA3Uyo0IH
 s5V3xUIkc0ZU++0+W7m5Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:o2wU9QDusCE=:atdBoiJMCnAHjLz1TogJRd
 lrVY2cOOe8TboLetl/atg41MNU2Wnl8k/nGUPrVr3aCKwzJEZyZwqKZq+woYBKRqgO+XCWzd4
 UmBxQUEL6iK/MdVRlQTnlKQkiCcZ/qZl+o1ZNsOKhIhCIXnvDIf+X5irPdxxO8wADuK0YlUM7
 voXc3KrJfc8JPXl00WqrtVdlgqLVsE7zfJo/CBExYcNrqrG6+VOkoy0VZjKsG39Fgshg3jpyx
 NaUNJXjFRf2dw0Rll3GZb4CGyRQ6leELbH8DEl8c2FTyAtvOdVPwKvplv4Jvz5rpE/OnleWNn
 4MjmtsLEqYzmjr3yMHRb2AcEGUNrbyq1mQeQmfydutbHHbOwvzrpLC52X1m1Jo9sLJmCVTnRX
 X9zDJio5kXxAfl/fVtmR8WWHtrT86ERY0WoDdgIa7TbPddtLDUAPe20WCWTvCP7z9SQrFEk/3
 CRQPhSA1h3KNg7QMM4upBrinOlLxigfkOf7R7wqCAmFz0Tu1YrVUwrKmhin0ooKexL/T6M9o3
 4a/jgabE8EJw8TatH3QE/wHpOSazzXjQ01P85JIOWMiOC3j6OB0Rb+W5lN0i2iOpaG35/NkR1
 GT13cp1cKc2iPCuY3zkWY+a9+FOyFT2iAFF/k8sxlhvJYnpdNzOoACtbGM2zMTgrjHhru+feI
 BzTfyYkyY0FMbGZgSXpvczyTgJAGDTq4cwATYxojjU3RtQQWUt/zhqfIbIgZq5oSBgbnbTNq4
 RBt2slBYekHt4UOB9ynBZ4KdKnYh+6H20tDtcH4QN5zUuanqWvhrhK6+WWXDtYyn/D54+j8zU
 25uW/ovFF0CQ0nvZ9knMwIE6rMwgQ/eFdd9UDDRuI6IGeJt3HCBV0MWWznf9HvQX2K3u25tgM
 Jac642a/rldtJUNhvXdpRokWb4SGKrOVmSPwidnP0STosRC8VIEPa3/eNk+03+4TXBhU55bMN
 I+vFiOA+vfQqUaKo6VWyQrbZK+W0VcWoXD++FBo6q7s5jxGiWqKeFbmg1miGxUnAKwF8uOWmJ
 uJh0KQcFr7vXJRyG/bVfvk1L55KRJFJpSxXs5JUpM4u9ATPd76iH1W3A43EPPKAtazNF9hrEv
 jpfKIHIm+BXBTs=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/12/17 16:45, cgel.zte@gmail.com wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
>
> Remove unneeded variable used to store return value.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
> ---
>   fs/btrfs/disk-io.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index d94a1ca856aa..d33575e56da2 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -4658,7 +4658,6 @@ static int btrfs_destroy_delayed_refs(struct btrfs=
_transaction *trans,
>   	struct rb_node *node;
>   	struct btrfs_delayed_ref_root *delayed_refs;
>   	struct btrfs_delayed_ref_node *ref;
> -	int ret =3D 0;

If you're removing @ret, it's better to also change the return value to
void.

Normally I would suggest you to checker the caller and return proper
error number instead.

But in this particular case, this function is only called in transaction
cleanup code, which means we have already aborted a transaction, thus
there is not much meaning to further error out, and the cleanup is OK.


So it would be fine for you to delete @ret, change the function to
return void.
And even better, to remove the "btrfs_" prefix of the function, as the
function is not really exported.


And a final suggest for your future patches, there is no need to bother
btrfs maintainers at all, just sending the mail to btrfs mailing list is
enough.

Thanks,
Qu
>
>   	delayed_refs =3D &trans->delayed_refs;
>
> @@ -4666,7 +4665,7 @@ static int btrfs_destroy_delayed_refs(struct btrfs=
_transaction *trans,
>   	if (atomic_read(&delayed_refs->num_entries) =3D=3D 0) {
>   		spin_unlock(&delayed_refs->lock);
>   		btrfs_debug(fs_info, "delayed_refs has NO entry");
> -		return ret;
> +		return 0;
>   	}
>
>   	while ((node =3D rb_first_cached(&delayed_refs->href_root)) !=3D NULL=
) {
> @@ -4729,7 +4728,7 @@ static int btrfs_destroy_delayed_refs(struct btrfs=
_transaction *trans,
>
>   	spin_unlock(&delayed_refs->lock);
>
> -	return ret;
> +	return 0;
>   }
>
>   static void btrfs_destroy_delalloc_inodes(struct btrfs_root *root)
