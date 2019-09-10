Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8CDAE592
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2019 10:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbfIJIbd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Sep 2019 04:31:33 -0400
Received: from mout.gmx.net ([212.227.15.15]:50803 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726948AbfIJIbd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Sep 2019 04:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568104287;
        bh=aeegeEcJSR0X/Roe9/NPVxArdx4jgIRRB5/DwlOhJwM=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=b+OuUCQKsEHRJ3miggXMpfN+jRo2UdLXi4pMS35N6C8te/JyQRaZ3stEQtgTW6iaJ
         RlYppJX1yuLbzN546ksp6xF0Jywmct3VXb/S7KGFJnK3+AhGjYgYaxlbVoKBNadES6
         CRDUnPhrprUbFgjx+3t5hr4KgXEIrOqT4tieX78I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MU1MP-1hgtbj0fiL-00Qo55; Tue, 10
 Sep 2019 10:31:26 +0200
Subject: Re: [PATCH 1/3] btrfs: ctree: Reduce one indent level for
 btrfs_search_slot()
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190910074019.23158-1-wqu@suse.com>
 <20190910074019.23158-2-wqu@suse.com>
 <c5db2dfd-19df-685c-71fb-e7e0e59a0b85@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <cd8d32b6-77fa-6d7c-c610-00e126904375@gmx.com>
Date:   Tue, 10 Sep 2019 16:31:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <c5db2dfd-19df-685c-71fb-e7e0e59a0b85@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:f/o+7ysms2ssmwRDkIdXk0sd3X//v6qvAqA/3jCcSUR4GP02l2x
 2JCSqbgqAaRU2CA3dcOWqiITpOUBAJskskd1AMMz8pQYROyotrK/Ve0ubQD7nWds3f6UIqe
 4oEFUFoA/ZaOvZmg+GCmfxrX4yKDkls8d9UxhBZqUYu4PxDmWGVid6LCpvriS8TOhRYIiCc
 +REVxYIaRvKDn1xFAbW8g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FIrLImKUBuo=:u2qH1cUTM9cvHiPG0n/pVn
 nJCxQVxTqxnBqjdhJjMgGVSF9ND6tjdoQ3zaJ9rG8KZObxmcZGm2ew7QQihF4TSxoj1qXibsb
 QCctApQE1Qs5aT2ysmAZIm3bmQ4iXibPjgpcXg9btSs37B8jcNz0NcG8TxSLJd2eTpMvf6Z5O
 Dd9Tsk0JnHDZ9gdCc67dpvUSBVVYP9Fq7Wn0b63sKaze2pRe8AJcwK9h2JH8qXrXI9SOjBwbe
 FCg92rpyMG6rFzi1Ssn4MHf5gvQAFZPp7NCWB8W6Teu8HKRoeFEPRK4RSxuh+BzxPvqIw07VO
 43/XyY7EncmYciIt07Dwkwx/cCSojM4v3pgvYNMQkusl5lTDbuItzMxWWkD4B8WZL0m5h9I77
 IDECQWXnf7LOmY4octdBgCh8dIitZ1ggqA+nmZmyREBoo4Hj5fyWC7T14bP8fn1JOkGw1GOyb
 QBZKQC4XVa7yhXOCvBLkHuoBsroHabDYOhiy2glXnAlpuXo6E2d/xvHlNt53psG/N6wMe7d/V
 ldfwAYlP8rXJEHw1rovjesgS1TgbO5+sBW94v8EJLl7QHRb/SOpfnhLWwnriu5EtZihiULVHv
 xt09ECy3gCRqZUfeHVjD8pwR2YqlGiWPvAtzZWHIFbYsYOWtvIwSZ1Nk5Gz5Yil2vXj1Sk94x
 ikxVgKm+BagRwxCCDvF4qdIcqsgwJhXAzQ8J34ukWWiwhbNhpm1/TtzEmchaw1tzGNxyMSaQ8
 jvJwqFFWYW7R9yzvJFAlp6EUnqYsieooTVOsS/HPjj647yVZInrHOck1PVomcEzk3hMeDfR2S
 ihToaEe5PpkFmZVFIARr9XnGc6m3/Vdv9LV9CuEcoVna6YWWQh3vuCHjL6Driz+VCi8JZrUK0
 2GSSrAsh//qTc4Jck8fRBurrvw5rgBsDUiEvelpXTTYOyzKHJlnSShxiH+anX+kMqvNqYanOY
 1XhQkxYR/IHnO7Lg1i6GGXuFL5BmEoiGCufimzeSuKJH1TSjopZQpwuYQSmwDhoYKmAI4Im5g
 6k2NVWcN4LENLsCgwOFF4Xe0BybqmpDvqKGA7kJXZew2o3yKNzfbX5ObW4Ndhb8PhSW4SEshV
 +tSUROFGOty9t/K9SBisN2HSmIGFxZwL8rSU90iEOl938fYm/Jf23R2T0ys1RdQAecUlKcBr7
 S9EoFhpy87/y2w+qbWlLAr9J5TqTGzml70VTrs7Q317l7MyllePPRhE9CFBqhHlwhRkQ/Jt7p
 xs9HJ9S8Qdsurm7ei
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/9/10 =E4=B8=8B=E5=8D=884:24, Nikolay Borisov wrote:
>
>
> On 10.09.19 =D0=B3. 10:40 =D1=87., Qu Wenruo wrote:
>> In btrfs_search_slot(), we something like:
>>
>> 	if (level !=3D 0) {
>> 		/* Do search inside tree nodes*/
>> 	} else {
>> 		/* Do search inside tree leaves */
>> 		goto done;
>> 	}
>>
>> This caused extra indent for tree node search code.
>> Change it to something like:
>>
>> 	if (level =3D=3D 0) {
>> 		/* Do search inside tree leaves */
>> 		goto done'
>> 	}
>> 	/* Do search inside tree nodes */
>>
>> So we have more space to maneuver our code, this is especially useful a=
s
>> the tree nodes search code is more complex than the leaves search code.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> I actually thing this patch makes comprehending the function worse.

If the level =3D=3D 0 lines is over 50 lines, maybe.

But it's just 22 lines.
> Because the else is now somewhat implicit. E.g. one has to pay careful
> attention to the contents inside the first if and especially the
> unconditional 'goto done' to be able to understand the code after the
> 'if' construct.

That's the same for the original code, you need to go a level upper to
see we're in level > 0 branch.

Thanks,
Qu
>
