Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E90263C82
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Sep 2020 07:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbgIJFgu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Sep 2020 01:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgIJFgn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Sep 2020 01:36:43 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905DCC061573
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Sep 2020 22:36:42 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id c10so5007881edk.6
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Sep 2020 22:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=DtY1HBelo13GA6F7pH1151n3BpH0f5vQRhoh7ZJdNZ0=;
        b=kw6goERjeHYDfG8cKmhtAH4Z1mGVJEqUhRS65GnWSmhlE4P4sYZzswhBm/2XnFFVhb
         vU5ww1o6OO+2+3YDlxfYqZ89+ZGmXiImfpiEXPYpMBldQXZuydMB+NzuWRBWlIwEux14
         nhw2iNMqa7K5n5XGqdm7VHEcyVmrFRJsGDYlOgaFkOcK9cr0lq/UBSXfO1M8p0M+Ntj5
         DkOXINxUMPfleGv5tdrRoP1NdQ9vFSWU52oAgVQJO0bIUYW1HHKJ2Oo+mD5m97f/So1Z
         DSrXPvwraDBgwyaRWnfiFuDc5IekhaBZZZO17E7giElavlT3TiuA6mNPfzXiMf0jevTz
         QKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=DtY1HBelo13GA6F7pH1151n3BpH0f5vQRhoh7ZJdNZ0=;
        b=SKso9JPhI9m/eqcuVej9ImNVE4m65/g1effa+fFAgTKaWRu5duZe1yYkyaMD8NQbYT
         ihMvqB1XUWAS8sAeDZDlTMa16jrILfiYWvF2n6+lUmUX6qG8jMuJ38BEm5/LGsjYMYP9
         jVLXift7dCvJtGg6zvliNxY5aE18kEJZQyMCHhwEtSHCcdORokYUQ5p7LbiknfdpI0nF
         AbKvPgBjjcmlwAJlgSPuNCbhGUDH1Ie2YvFjeXEJLfmEqlr1dS0U8aTaLgrYr5BT+gJl
         nPBvSiw3pAZVOsYHnsIG38gaDszUDt5ZQEY/U3fLwSRYoRCbW0qenQZ7GVWaQ6fdk8R7
         yMZg==
X-Gm-Message-State: AOAM533Gddx8Fq52jD9Rusp5fqbTAzWQ+YypFRr6khDtkL1P1AjLaRD7
        WmfrV4gnKJJACaKE+yrybfM80vTBP1FfTg==
X-Google-Smtp-Source: ABdhPJxaUrmfNp12spgcUlGmsZDlVPYG+uDY3Iqf6WjFomPpIu3A2OowLWvDjZ8LiKJH86fnihRk9g==
X-Received: by 2002:a05:6402:1bc2:: with SMTP id ch2mr7409816edb.60.1599716200674;
        Wed, 09 Sep 2020 22:36:40 -0700 (PDT)
Received: from ?IPv6:2003:d3:c72d:9a00:9265:f4f1:4fa5:f9a3? (p200300d3c72d9a009265f4f14fa5f9a3.dip0.t-ipconnect.de. [2003:d3:c72d:9a00:9265:f4f1:4fa5:f9a3])
        by smtp.gmail.com with ESMTPSA id p11sm5462307edu.93.2020.09.09.22.36.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 22:36:39 -0700 (PDT)
Subject: Re: backref mismatch / backpointer mismatch
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <0219bbee-9ca3-135a-8a2f-5d616000c1e0@gmail.com>
 <f4317021-89e4-904b-6032-10bdfe455450@gmx.com>
From:   Johannes Rohr <jorohr@gmail.com>
Autocrypt: addr=jorohr@gmail.com; prefer-encrypt=mutual; keydata=
 mQENBFT1gLABCADcwcj45ysOenaLb8+pkjeb+6oC5IZQ5rgf42l8tCfU6mwwTyaHI/OE9f1f
 pClmX+dkEFp9HjFK6e33St+HgcXsmarEpVkGVB1oLwhnECuBngqJLbopXL8QfgVkjaNq2aF9
 QfR0W2F8BlNDllnJ8q3MToY3RQ2BSkYvsekCS9zJ+8cFrZohpTa9hvtD2tDdHk48A8GaxA7Q
 CZm3FSbzXEFuGH4TZ4P407b6prXfU8LidTCrkluuM44LhqTGRXmtuVg6jU9vOrkcz8fflGtq
 Orziu8O32iiL9HU1Oo2wX/vXq9wANj9PAp+cOknXVAH/MeYSIPqo+0pc6ObZxufYyUehABEB
 AAG0IEpvaGFubmVzIFJvaHIgPGpvcm9ockBnbWFpbC5jb20+iQFOBBMBCAA4FiEEQGpo2KXp
 zZlAiCX9BQuNsh71kW8FAliYN80CGwMFCwkIBwIGFQgJCgsCBBYCAwECHgECF4AACgkQBQuN
 sh71kW8GRgf9GKnsiEasxb/0/ngspsDBFCT2GROrA+Qqz7cp14hZVtOkm6nJ7wshAYy+UGfl
 ovPRi3D3JG/RJvBQHi+rYIBrROOOVbj704AC5oFCUwsFs6pKcnwlRaodIo9u4ZgiYOkNln12
 UJxuPL1v7J1ccgypP3ufFZaH9gJGssZtajyQkeCRCKNbBPIbXMSnsTWBqyB4AulnyAwVFJAc
 4yga8FaJtiDV334tt2TBNw80yqtDczjbjq/tJkcR5VlzVLpPXpbJ8FCL7K945MmN2fpWgWvj
 WtqEfnsSW/y1x7OfDWQ8CG1szKc6HVsqkRNQwksJapIdresC2dNe7oT+m9bn0+RWIrkBDQRU
 9YCwAQgAu86uORuwnEMOhc1poBRsvWns7G0eMd0vdSaiSAPaP8pQrgTC16wBXJXPxPIhIzfs
 PnGvHgv21BhGcBRcQ7Ybh56dXnWBuKMNnIz2PcMEdHfjd/NG0SDRZdEl/Eztk143kXxsjMTo
 10sGHPVJOFIVG1L9K2XcZ/M4SvvR5rSYW2obRbCtT3EkNAcyynA/xKtOhsAFkCVjO4twytQv
 Og9rpn02bBrjZqaTCHPzVl7ZpjVD6oykY8uJrgKc4EGMouH3WitZppkWSqaB1hgJp78CjwkB
 12mT+YcIoM6xzAIklBzKK4qaV1elHhd5clhbDuSpGor/KJcyolx5hbMFwrT+jQARAQABiQEf
 BBgBAgAJBQJU9YCwAhsMAAoJEAULjbIe9ZFvhS8H/3hMmBhanQeDumAndrJI14228G9QUSW2
 SO92Uzlek/mQwRbIg/+nkLn2aC4RkEYqox+AuQA7TqX+OS7JjFVS9vtsn2ZM+kgvMpzUaKO5
 aCjqiyXB4Q3pvg2t46SeuiV1Y3cbyhAH6gzCOei/IMguhYIqNAsf7bf2drN5e1uMHpzJHrBK
 KugcR5bTfAVQzwnOMPQtPH4mRe7cALp04t4rxSZUiC9Xw9s38oK+Ewk/TtjBEFg4VTDMHdcE
 B65jlCq15bGxaOSwZbDzx/exLNq41HM3xygY7XFgAdyE6FJLvUc5ehqTjiwsIx3BioRMOTzd
 5n0x4xeJ5v4w63j4mSxbZu4=
Message-ID: <895dd934-8159-e14b-de7a-10fba881d96f@gmail.com>
Date:   Thu, 10 Sep 2020 07:36:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <f4317021-89e4-904b-6032-10bdfe455450@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="ECUhmYzSmMi6uimsoz3EQnAs5CuTSNlLr"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ECUhmYzSmMi6uimsoz3EQnAs5CuTSNlLr
Content-Type: multipart/mixed; boundary="iPYZRDi8JyoLqkO0mLTeTnb7XZCwosvXE"

--iPYZRDi8JyoLqkO0mLTeTnb7XZCwosvXE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

Am 10.09.20 um 04:16 schrieb Qu Wenruo:
>
> On 2020/9/9 =E4=B8=8B=E5=8D=8810:51, Johannes Rohr wrote:

> What about `btrfs check --mode=3Dlowmem` result?

Too late already. After getting the green light in #btrfs, I ran the
--repair and it fixed the issue.

>
> If your btrfs-progs is not uptodate, it may be a false alert.

The reason why I did the offline check in the first place was that there
were issues, namely, that btrfs balance start -musage=3D70 / resulted in =
a
segfault and also my attempts to remove a faulty sdd from the RAID
reproducibly led to a kernel oops and a hung filesystem. I had asked
about this two times on the list [1] also reported the issue to the
kernel bugzilla [2]. Also,=C2=A0 upgraded btrfs-progs to 5.7 before runni=
ng
the test.

Fortunately --repair has fixed these issues.

Cheers,

Johannes


[1] https://www.mail-archive.com/linux-btrfs@vger.kernel.org/msg88916.htm=
l

[2] , https://bugzilla.kernel.org/show_bug.cgi?id=3D209143




>
> Thanks,
> Qu



>> Thanks so much in advance for your advice,
>>
>> Johannes
>>
>>
>>



--iPYZRDi8JyoLqkO0mLTeTnb7XZCwosvXE--

--ECUhmYzSmMi6uimsoz3EQnAs5CuTSNlLr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEQGpo2KXpzZlAiCX9BQuNsh71kW8FAl9Zu2YACgkQBQuNsh71
kW/wKgf/X8JBR1O3i+2M1IGwbVzh9SYhm23vVY3iWjvDBRpM/Zfu3qhI9xubu36O
YiwZvfMOhQLjY4Lfvhy/tH8C7uuRbWMe7aroDOlIAvNPhePihPR/Mpl0UF7Fcbd9
nfriWUkesooKfsOsworIqa/84Gp1oSyaoI4/lHnplL+HAFIfGPsjX7kOgekvwDaN
AnrVqWUH4yc8zGioaWoxP5i3q/RRNQ49t9O7R34WHEouP5QCuuGkzpwvYRXzW20h
sad6u1bbzwUTF9o7wS63/akGkWZMdwcFHLCv5YsUz+02Ar1hCH/Jb4YMMFarXPTz
jOoHRSoqRhMioXckbTH60ePUbqoZUw==
=Bl65
-----END PGP SIGNATURE-----

--ECUhmYzSmMi6uimsoz3EQnAs5CuTSNlLr--
