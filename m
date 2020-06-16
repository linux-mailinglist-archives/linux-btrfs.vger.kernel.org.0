Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5681FC278
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jun 2020 01:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgFPXzh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jun 2020 19:55:37 -0400
Received: from mout.gmx.net ([212.227.17.20]:33141 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgFPXzg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jun 2020 19:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592351732;
        bh=nFTyX8ybhfn4daHGpQcDju2AkW+HvHto/crksCCNrwI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Zbsy44aQ1/BFWEorznjCmtCnlD2BDjBfzcsG8H0pZlNm9kwfEJ3sVBtiekZygsOD6
         IcBZkZgBSlYuYtTZx198WafDpUPSs67cGmtKNp2ZN8DqFlhE73aIWO26r1/B3xT+YS
         a3yOQfXYRN/f7srIWQm5NkY7nkun9VfNlsROzifo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MbzyJ-1jBS2t0JLj-00da1Q; Wed, 17
 Jun 2020 01:55:32 +0200
Subject: Re: [PATCH v3 4/5] btrfs: change the timing for qgroup reserved space
 for ordered extents to fix reserved space leak
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <20200610010444.13583-1-wqu@suse.com>
 <20200610010444.13583-5-wqu@suse.com> <20200616151720.GF27795@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <930ad4d2-46a6-424a-689d-3e8fcbd15916@gmx.com>
Date:   Wed, 17 Jun 2020 07:55:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200616151720.GF27795@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hqHfn3XavcpFjhbUlY1XqD3QsNfXVsStT"
X-Provags-ID: V03:K1:aUa0onQ3sym0JwTHSDwlzHBmw7OayBIKC7hX2LE3H8gs4y4pMvJ
 eU3rGPcMeJoEleQBI/dSV5khiULVtPAwUfNvxF7DHmSp4FlUo7zNvXCehllMydIWs00j+oS
 YW9CIg7KQqlXDSaf6shw8la76Jy44sl1bIUU95UgeQOpeUJsr2W6bY4HEI8g8ffUbHdL+SK
 GI9V94K3qUwEyaeqdPWow==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:aArXw6Iw0Pw=:vcBat88oxq+FUpeV5BxOmK
 bsZOl0d5dlixwQ7e5jQBnc2ATLUNZoGMLpZ9SWWES2O773ks8Gaeqjfza1WhWwWtW9feNHaKy
 GfobISmJSerVXEzJOLZobmqfgBplej1uamWd1W6kPfUprEIBZXWvZ+I00i89+0v/XKaFxSbTT
 U42uNgDJR+kC56xVvZVMjLrYhS2Q9EbWlE6EJFvjW9wLpphfGZtnYzNyZDqDMKTllmPTnVV7A
 wpyPnsKnHqzvPzOjZlHUB4bdnyPhR0EBO0/BKEDEVkZ+7YSE52umWZGDtKFPypYsLBrsB7gqN
 HlNyucnrkRw97+J0ddFALZOwLkvnF7hdeM8lFAEFEhw/9pl5Hze7wL31Bc9YFWTwUezvldbBv
 X4JdqeNPxv5/I/662NTP9ewpuBjyp2da4R+HkTmc+Ojqx5aWtoNMPuHpm9qMrmMcXJ1wU6wqp
 OdxVET7qQWoTT4Ml1eiTKot5FUGmPm0sD0UQudoHj+keTf7XUCXhqH5TY+eUKoFGGtNILuR3/
 q28XFoqOKc+ZFKbjQXeUQoS+V6OriEoeKeCfkaXuYTFnmPfurjG2Tz3pHa7icJY2LOX2LKovO
 uio1Vh+S1Q6clGmT3om5uqdpwcgRr381N+pUkgCkYt/p8FJ1EqPdNtECn5cVHjwTMtuDFmZJ5
 m5IhNLicmeGj+q4CUpCuLz97LF1uPxdEqsqezyZR/ducdhbTKotZ/jQgFrtrSPWPiDgeN7hPC
 Rpsf/2s9FCxDXqvBIIXabVvLr+3KmEelscMNz757E7VR6TPCr+5wsq1i2miWjSDpEDUxaOvSr
 kO07RWOCgrGqT4SzVsqvXC82r1PfPuVteQ4t4rhpSKbb2c8P9JoiO+DFSUXo1tg8MJkr1gnJz
 s94JE3VyuasZq5ECVuntSTRmYsiF1eUwiHMYdPhfww3u2Lr0qNDzlpzJyIwmjAdBDuDeNIGxh
 S1Ob1DEICSvpGrDJtdwmKsjBpLTUwFVpeFQJ7hsRgjRpxOc6RYzcvVRMk8AWUhvJAfb5wosrz
 3qeTJ15lWJMK9wIlKKnDjG4aMPlNZOOP0I36fFnZHfMb0inJVprG44vjlyQYkNAbd00V9rROm
 1Izaqs+/FqaKxMl/1V0XtqoCA/iMlOsgakEBCHbp0dA3ht1FsAZ4jEm8zKL05IDgH1/ApVWTM
 3it8enghxwOfECYP0R0Pqr3NUCxHA7qMPwktITX86cV04ZJ39JOf0W9sVmzwqyk2hBX5ePlUr
 BKJuRp3SQXfeqhGcf
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hqHfn3XavcpFjhbUlY1XqD3QsNfXVsStT
Content-Type: multipart/mixed; boundary="izcXrtcU0s6NYb7OfqZp8u9ByYRIj0wOj"

--izcXrtcU0s6NYb7OfqZp8u9ByYRIj0wOj
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/6/16 =E4=B8=8B=E5=8D=8811:17, David Sterba wrote:
> On Wed, Jun 10, 2020 at 09:04:43AM +0800, Qu Wenruo wrote:
>> [BUG]
>> The following simple workload from fsstress can lead to qgroup reserve=
d
>> data space leakage:
>>   0/0: creat f0 x:0 0 0
>>   0/0: creat add id=3D0,parent=3D-1
>>   0/1: write f0[259 1 0 0 0 0] [600030,27288] 0
>>   0/4: dwrite - xfsctl(XFS_IOC_DIOINFO) f0[259 1 0 0 64 627318] return=
 25, fallback to stat()
>>   0/4: dwrite f0[259 1 0 0 64 627318] [610304,106496] 0
>>
>> This would cause btrfs qgroup to leak 20480 bytes for data reserved
>> space.
>> If btrfs qgroup limit is enabled, such leakage can lead to unexpected
>> early EDQUOT and unusable space.
>>
>> [CAUSE]
>> When doing direct IO, kernel will try to writeback existing buffered
>> page cache, then invalidate them:
>>   iomap_dio_rw()
>>   |- filemap_write_and_wait_range();
>>   |- invalidate_inode_pages2_range();
>=20
> As the dio-iomap got reverted, can you please update the changelog and
> review if the changes are still valid? The whole patchset is in
> misc-next so I'll update the changelog in place if needed, or replace
> the whole patchset. Thanks.
>=20
After reviewing the reverted code, the change is still valid here.
As the filemap_write_and_wait_range() and
invalidate_inode_pages2_range() are still in generic_file_direct_write()
call.

And without the timing change patches, the safenet can still detect the
leakage, and my existing seeds reproduce the same problem.
So we still need the series.

For the changelog update, I'll send out the v4 patches, but the
changelog modification is pretty small.
I guess only the first and this patch needs some small modification.
(the first for some words change, while for this, only the function name
needs to be modified)

Thanks,
Qu


--izcXrtcU0s6NYb7OfqZp8u9ByYRIj0wOj--

--hqHfn3XavcpFjhbUlY1XqD3QsNfXVsStT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7pW/AACgkQwj2R86El
/qiFqQf/SngWen5mmfMd12MshJxHyBhP83WvIAZbUzo7Rd5KL1/knuHFnmsTFUEj
JYtgX1fWb3rPAyLgNM3Nn2Kcxjz+DG5dfHqnxJgs2veGBxHDTmLmUHwF6v5SIapF
wpOEbO6itQTP9HHN89Gobl7it02RGtipLosGLB9DUlIaLsTObEsvKHKJwr9tAMBI
gozUT3uch4G58HJkGwO9cIiP1osfL9bsYyDCNUvCjFIJOOlPYrQyJXWhmj6EbvjR
yHbb7MKJYMZHML2qJNHE5yRdAzaBL+yytV1Ql1IJBF8GbWi+Em3At16cPqRCQCUi
iAaA8nG0AAHIBcyAVXhzwJIrSsVEZw==
=6uP/
-----END PGP SIGNATURE-----

--hqHfn3XavcpFjhbUlY1XqD3QsNfXVsStT--
