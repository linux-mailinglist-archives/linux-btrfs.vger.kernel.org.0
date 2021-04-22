Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1661367F6D
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Apr 2021 13:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbhDVLSb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Apr 2021 07:18:31 -0400
Received: from mout.gmx.net ([212.227.17.21]:45339 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229972AbhDVLSa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Apr 2021 07:18:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1619090272;
        bh=N0RV1Blc1V6d+d3ORHVLDnV+tFtM6v7s93Rgyuzf8/I=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=BAaQPrBa1o2gYnveBHE1sJDRC9oR5gj2ktTEJ2BiIGJt/mNePgGxzm9OoGE8cZkq3
         PJUfZqjToXGyI+mLVOldWhbMFEUWJx7E41IHCoBamNXXHzyFg7kDz38DbCo+/9ZFcL
         ourqaGZEKl53syWp1+To+V74/SUURq5yZ0+eJW9o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MF3HU-1lowcB3NKS-00FWrL; Thu, 22
 Apr 2021 13:17:52 +0200
Subject: Re: [PATCH] btrfs: do not consider send context as valid when trying
 to flush qgroups
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <1020602e269415d91c713afdfb9a11921a3ceda6.1619087848.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <cc3056ba-bad5-3e7b-62d4-42fdd93a5828@gmx.com>
Date:   Thu, 22 Apr 2021 19:17:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <1020602e269415d91c713afdfb9a11921a3ceda6.1619087848.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:r7Ph91e+IA1lhIGocOCg8oOdUcI5wG5isN3sL2a2deFtLjAFJUC
 ypstFYrpbtKHJohNbJ08CdFnCxBuYAdtAob1rGe/NjIUA3JWvWfwah29RPAk32AVILJ9IN8
 jhwI3hPfQ1xFVLj9Nj6vtgcSAmt22YK9xPJSqq69aUG0LrPM6+/2iUYbqzY3d3R8jMVxQfr
 W5PqrApCA4ev6lRs0U14w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wN+ovwTPZoE=:RxC3BzDD0UO2b50tWvu3/t
 LQTFk0KD58E1/C/LqwItOCSEU/icOMCt5Fpv2ehaxY0K3lmzh5TrUfG95za/CLjgUDmro7mfC
 xedqVLno6KztBQAVPRfIiTl7z/ySqQjlCKnOygSWwQnTtgoZGEpxswhn0JOaTFOAsQOhhMpqq
 YuL5jPiYLjoaSAPMnkjHykB2V2WvH2zuv2vV4b6VlGuGihE/BbaTlNigC7gdwPhkvp7bGFUUY
 nQAjbYMtaxqz1ZC3lIc6uV4PD3HTo/g17olUGihYuSf6u/6bqkZz5Z/WANhI28/zmcBUwXyA0
 4KNKlkDy8Fqt121Apsstn9u0JWRRyRHfF4p12W/D+s6KAvCRw5IYIlJMreYOJXGkDoDZIwpPe
 1AelrZApplcQt28/Wd3zklN2epQVnjyYgu2YIku6F0+nMKHqzs8KiVQh8aC4VwSXjV2BiKgL3
 2Ty/xcYqSVoCevEi/CpHQyg6VaMYpghJelYx7uKMpW+YOn8Nd3aE96GaHJsxsuddSqMK+ZCvo
 iPZVae3u3Qi3kidSpl+FTXPezhYWWMRf3jncQG6WcKRXHzDCxRl687r0B0eMmBCzzEzp6YTG0
 HXO2z1qLPxz4069qa991OAc5F3Aq9L1d5JsHZtrLybWciHfusmTi5Yil0oaZcg6sRiOJqZbHG
 lYJ6AKQ+MqYOvCeL48sIPLZOy58AmZ+os+BEZBgJO4kK3oX1futcsr+zBVbrrYU1wMPFqOnAC
 qUX0TMgiw1g8DkuDOdYKi4vgPNk+oxpMyAzaUPPNZ0nRY0o/+gYduB1fdhoyO5y6zI6BykA/J
 /Q7UOTPWP5a3WdoesmpPkCYsC2fFti9W+FKnDXbc2bOm8OSNKRDpFMZ2Na4/BJKW8gwqC/03z
 /j67LeLBbjgShzRu7K6xzS9Fo3ah+hsug4SwOzhhGV229Iu6sZVPt0C8j0ykz7c4ZiaCsqUNu
 2KtnvaQa+b17Zyg+5GBJsSRopxziLDoTW9w4qmXvmcqUuZDe1Zjqeu/zxlt3Y/Xrkr/KgAIqt
 vthieUPoyKHnO/vQ0CFQoxqnGVJSXTvlNvNk/ECo44cbB1pMREcZsuoANWt1DAgGiHEG8muja
 XV7U90Gk14k3szYN8zQKSnDNZ4UjdjURyWu7EnW+fxawi7yZveO8IjswKhcuNG8VSheZxc5cf
 km8fPkSHEWVmEQ8qCh25jKHp2og1PrfZWK+3sQdsRYjOf9CUCbbYPMSbwyePpDJm/cxiTU/Pp
 uHkzxpfdHOe61S8qX
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/4/22 =E4=B8=8B=E5=8D=887:09, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> At qgroup.c:try_flush_qgroup() we are asserting that current->journal_in=
fo
> is either NULL or has the value BTRFS_SEND_TRANS_STUB.
>
> However allowing for BTRFS_SEND_TRANS_STUB makes no sense because:
>
> 1) It is misleading, because send operations are read-only and do not
>     ever need to reserve qgroup space;
>
> 2) We already assert that current->journal_info !=3D BTRFS_SEND_TRANS_ST=
UB
>     at transaction.c:start_transaction();
>
> 3) On a kernel without CONFIG_BTRFS_ASSERT=3Dy set, it would result in
>     a crash if try_flush_qgroup() is ever called in a send context, beca=
use
>     at transaction.c:start_transaction we cast current->journal_info int=
o
>     a struct btrfs_trans_handle pointer and then dereference it.
>
> So just do allow a send context at try_flush_qgroup() and update the
> comment about it.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/qgroup.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 366a6a289796..3ded812f522c 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -3545,11 +3545,15 @@ static int try_flush_qgroup(struct btrfs_root *r=
oot)
>   	struct btrfs_trans_handle *trans;
>   	int ret;
>
> -	/* Can't hold an open transaction or we run the risk of deadlocking */
> -	ASSERT(current->journal_info =3D=3D NULL ||
> -	       current->journal_info =3D=3D BTRFS_SEND_TRANS_STUB);
> -	if (WARN_ON(current->journal_info &&
> -		    current->journal_info !=3D BTRFS_SEND_TRANS_STUB))
> +	/*
> +	 * Can't hold an open transaction or we run the risk of deadlocking,
> +	 * and can't either be under the context of a send operation (where
> +	 * current->journal_info is set to BTRFS_SEND_TRANS_STUB), as that
> +	 * would result in a crash when starting a transaction and does not
> +	 * make sense either (send is a read-only operation).
> +	 */
> +	ASSERT(current->journal_info =3D=3D NULL);
> +	if (WARN_ON(current->journal_info))
>   		return 0;
>
>   	/*
>
