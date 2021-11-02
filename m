Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4A0442B58
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Nov 2021 11:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhKBKIg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Nov 2021 06:08:36 -0400
Received: from mout.gmx.net ([212.227.17.22]:46005 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229924AbhKBKIf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 2 Nov 2021 06:08:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635847556;
        bh=2JKK5p+n78C0oJdATvq2q15kfzuAivWfd23c9zMK+JE=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=cOPt3jVdnSNpZNF+NItFO468A5nY51Wl8P4KORPCQNElLbjS/oaDxucSxZ0hsRKJo
         fDE0AtRb4NoPhGDI0vDM7t4KX99D/PuXJkBk0yiXs4swaBnk9RhmBsm+n6vR7egp0A
         eE94vFYgvsIy5u/i0Q+eMjqwIrTaEw4VfU5eznns=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MFKGP-1mx0yg0VJZ-00FnUw; Tue, 02
 Nov 2021 11:05:55 +0100
Message-ID: <2423e01c-6db8-4d45-e35c-37a10364c811@gmx.com>
Date:   Tue, 2 Nov 2021 18:05:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] btrfs-progs: fix XX_flags_to_str() to always end with
 '\0'
Content-Language: en-US
To:     Wang Yugui <wangyugui@e16-tech.com>, linux-btrfs@vger.kernel.org
References: <20211102100316.20256-1-wangyugui@e16-tech.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20211102100316.20256-1-wangyugui@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CLH5clFjG8algoIpVUxHEHb15NzL5Nvw9ylBOCOZ24SDEKPKevl
 E7hI3hUt0wqAzHt7TRCkzJrHI4W1NDBzERj5MZCeyGMWy4IX+go7k8ZrxWBzY47o1ERXN1j
 p8sQ1LpJck0rxgX5Ejx26VSGT81Vig8RsvYUGkf4myTCVGzQF6VL/X6ocPnZRPqM5BOY5Y6
 BZn9TFvk4LAsGS2CON/Ew==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:th93GOF5v4g=:LM4lqZwyFdBs508iQOOxN3
 7Iw6e/JJll1+5hHTDL0x/echQ5n3iV8yBZqsFsx/+ryGCojOjVgdESCzr9RaY/+nC3fqfpyAU
 UrLagEn/TwKm0bUY1r6uKRzPzAQQT6o6SOAnbuyX4lfFEJ+mjWkzkLVqVd8KQSc7lBQt7Jyvu
 RfKxEs9b1tJKjziBnPshZyrKDjZiho+ieFUYeIv8TszCmHXsDuHomYFLRZE8sw/hSXPIrvY1H
 jJja4JUzj3DoYQXFMNaVGBZ55CbZUtmjBFHHLp0O+q9neaCz8Gf+AgP4FLHlpDf5HNNYWZe74
 61KCmMeZwI1FVxBc4zNEGieTtlSuyFKNJJhZB6jn90AXDJSmZOSONbnejycceq7k5fXS5r9p0
 sCe6IMHCQ7yX7zkqXfhsFv+Hb0rjMQkVUiMiDgQWGLHQkjGk01cEDevrlAauCMLwlKtctgoF8
 iK6k9ao/uRWQSR7rsMep9BmmgT7pdQPl9cEnCUQckcORbA3jqxsfVMKHJHGmj0n+NUsBgWBTc
 tcOri91POWES+vFvP7BLumTDSnL/zG6mfaXhxbL0oKDy8mqQZqI8YkgB9RBsaUaVxEa0Qbo5A
 bwKxp2CzAW3wDKU3+6KUYQ8dIybHgfNqIvamfOMot1Dx/75xmZAoUOCVlTub9qIY4u3+uJNPD
 QYeKNPAeElMRx7BaPxZAZcKGU7vXnjWPsR0i3NGdJh6RtwoU5uZSKEt7LPCL/U04reUrk0tza
 0WOFVqhucE64Tf4bLidqH/Y9ChYjRaMLfEJvwGofFNQ2kqepHSBQukS0QVdqL6Fi+F438pyF5
 Cdty0K7jAADgAVCVnqXxnpUVufQWGm3xcLriatGRvxOm/eCwtBP+WavxzgKpV8Bslvkf0YSqw
 GWXV8L8V8x71xZfOTsAOaeyzA2YsGXUs5aNcx5IVWbI+A3XwVDyPrKqKrKwF7eO3fg8sJnE57
 ysna4m6fif/mLVzEh4dgaThBxQcxkDy7B6vlJbcGdu5ENu7eUv+zcL397zyOWT5DwcQHcfU8/
 oqb/cFPwwzFUE+6agw6WQjCib0qhaE29WtPH6o4PZ4gqvbukXfIkL8OY/WLAvP03ZDabbisyM
 XDOHL4DwBu1szc=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/2 18:03, Wang Yugui wrote:
> [BUG]
> We noticed 'btrfs check' output something like
>    leaf 30408704 flags 0x0(P1=E9=80=85?) backref revision 1
> but we expected
>    leaf 30408704 flags 0x0() backref revision 1
>
> [CAUSE]
> some XX_flags_to_str() failed to make sure the result string always end
> with '\0' in some case.
>
> [FIX]
> add 'ret[0] =3D 0;' at the begining.
>
> Signed-off-by: Wang Yugui (wangyugui@e16-tech.com)

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   kernel-shared/print-tree.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
> index 39655590..1b6e4a02 100644
> --- a/kernel-shared/print-tree.c
> +++ b/kernel-shared/print-tree.c
> @@ -210,6 +210,7 @@ static void bg_flags_to_str(u64 flags, char *ret)
>   /* Caller should ensure sizeof(*ret)>=3D 26 "OFF|SCANNING|INCONSISTENT=
" */
>   static void qgroup_flags_to_str(u64 flags, char *ret)
>   {
> +	ret[0] =3D '\0';
>   	if (flags & BTRFS_QGROUP_STATUS_FLAG_ON)
>   		strcpy(ret, "ON");
>   	else
> @@ -417,6 +418,7 @@ static void extent_flags_to_str(u64 flags, char *ret=
)
>   {
>   	int empty =3D 1;
>
> +	ret[0] =3D '\0';
>   	if (flags & BTRFS_EXTENT_FLAG_DATA) {
>   		empty =3D 0;
>   		strcpy(ret, "DATA");
> @@ -1201,6 +1203,7 @@ static void header_flags_to_str(u64 flags, char *r=
et)
>   {
>   	int empty =3D 1;
>
> +	ret[0] =3D '\0';
>   	if (flags & BTRFS_HEADER_FLAG_WRITTEN) {
>   		empty =3D 0;
>   		strcpy(ret, "WRITTEN");
>
