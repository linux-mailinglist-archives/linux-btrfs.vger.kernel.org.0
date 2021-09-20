Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10824112E6
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Sep 2021 12:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbhITKew (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Sep 2021 06:34:52 -0400
Received: from mout.gmx.net ([212.227.17.21]:46509 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230510AbhITKev (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Sep 2021 06:34:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1632133999;
        bh=OqwkgAJhv/4RZW6nxiO3E9PXgLIgU8DhSRqTQBpPxmk=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=U+x4TuVJP3+btISMmuckqzbsKrk0+fZtlesSXOQIEeVBbM+3LgXIvkL1AQEUcf4Sy
         POZv2ARZBJxHA1ga9t1YsxRyrdmiMVpm9ub4ZWnNM4tXkbKLxwC6cVyzlUHxyTOrvQ
         xXXTruRKmd7S8vCzqyb1VmAVTH5EaONYP4nvgaqc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N7QxB-1mwIsd28Wj-017iZV; Mon, 20
 Sep 2021 12:33:19 +0200
Message-ID: <ce7b5672-9aa4-607f-f21a-594f1f9d3262@gmx.com>
Date:   Mon, 20 Sep 2021 18:33:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v3 2/3] btrfs: remove btrfs_bio_alloc() helper
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, dsterba@suse.cz,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
References: <20210915071718.59418-1-wqu@suse.com>
 <20210915071718.59418-3-wqu@suse.com>
 <a4380e7b-b728-fd85-b6c1-175a53f6a1ce@suse.com>
 <20210917124341.GS9286@twin.jikos.cz>
 <6d4ee72e-1f3c-0d06-7ce4-6e17d296c390@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <6d4ee72e-1f3c-0d06-7ce4-6e17d296c390@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gC2bgOE4/HFVti+ZBFyrUfmfiMv2gbtMMPd5aZgkVhGm+lgP0fO
 f0eR+D3m5HFEGcCmrs4i5J0Yp7rajh512ssJDEJ2b3RuJwFz+g5c0dGpR/sbmm6Lw/Azjnt
 enF7v51nM2hjCnuul0xp2zkOlGmoPq59F80QNVtcQAxrscuwrhF8Xgs3Vpv15gRuf6ew5dm
 ZA5QBuPddGGvXsgMsF1pw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fva29qLXltg=:JUDHPhM+wcRSZjbvR8WJ7d
 QMsY15pN+FBne5+O4EsdzQ8ZDD9giU9xY9zcEqRieeVzwMdKE9flxk3atn8yKz9A+Bu/cLZJ8
 wLqHaE8Nvjhjuhapuxhi5cLN/kQWfjK9wTfCRRS+zFkBwovQwNWaE5fGHPZoaYJTkJ26kDa+R
 Qgi9dGCyEsLb0y1zrW7TXvAWeqXzWrYPVP5JSEnNL830smg35wassNm6Znux3O448UyJy9h+w
 VpaQs911Y4woug2F+651MMObrfvuB8F1fXvV0zXhRjes7hKC9aSRXngzSfBfHBHnKs/B6taW6
 noLjdv91mpn80kIYZkKaAKyOm6OD9PuYQwI68ZUNIiYoklJA32qDVVccrpUrw+lYtleAKG6zh
 /PlZp3shrkVgCPyHZHdPJ7SiaEaTUIqruONQRq1kclSu2YWcai4zh6jYJxIEpjSLj4KR7knsU
 /mGLxqVwx7Kz+IfTgEK5IjbFfivrPA+8IxyQqBZ+DXdoodHuxygjYANvu+SV+4E5yctS8KSPG
 Uuz98KYW/+H7qlBJjcRrERCT1y/e0be/plg9sdncOYMEDTKA7+jdr5pE+hTcsYmLHZVVVWeML
 tH49diBihwYTt3vcaQW20k1qSRY7V6Ue3gZF2/SqgTUcoJ+eu4OYm2M8fiEkq54RIbvG0TEnk
 KZzL4aXD4+1HZefg01wyFKHMrVKDrOdfsXMoj5p+QGs+qsVr35HPP4HA2KcuvBhJLlLFfZhTk
 RxCEyA7RiW9vMvdMDO/ssYWmxuSlwK1lE2Ho749x9yV0P9GL7GzRPabp5nXkcJgklKVOOdcTx
 YvRcEZNln0xD2azrMK/6HhHmXtWG/JwqlvScSv6Ov1B65Iog3+MnYa3Z2MacQxJBFnIEAG45t
 5ddCzO7q9OXll3+IYCPLIYcezmjF8bjfVOkIHkULlro0HPPWREKZPyidLmh9QwGrQln/uM/NI
 hPo5IShcfHvmBzFK7dkp9OYD/V3ob50FRyomDjbHK0yguM/vDKNgyqOnFenhFz+cVKPCPxCKY
 d3ufBDbP0RX3ZOlOQXUIhqeW9nYU3w15QStkUBnb3pxIz+A6PQnLPirE3EccINuCVQaQSO01N
 ux0T7JcwoIatDU=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/17 20:49, Nikolay Borisov wrote:
>
>
> On 17.09.21 =D0=B3. 15:43, David Sterba wrote:
>> So should we add another helper that takes the exact number and drop th=
e
>> parameter everwhere is 0 so it's just btrfs_io_bio_alloc() with the
>> fallback?
>
> But by adding another helper we just introduce more indirection.
>
> Actually I'd argue that if 0 is a sane default then BIO_MAX_VECS cannot
> be any worse because:
>
> a) It's a number which is as good as 0
> b) It's even named. So this is technically better than a plain 0
>

Any final call on this?

I hope this could be an example for future optional parameters.

We have some existing codes using two different inline functions, and
both of them call a internal but exported function with "__" prefix.

We also have call sites passing all needed parameters just like Nikolay
suggested.


Despite that, I have some further optimization for the btrfs_logical_bio
structure, thus I hope this helper situation can be solved soon.

Thanks,
Qu
