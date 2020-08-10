Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D4E2411A7
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Aug 2020 22:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgHJUXZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Aug 2020 16:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgHJUXZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Aug 2020 16:23:25 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B77C061756
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 13:23:24 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id df16so7351241edb.9
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 13:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=9d03L3RiYPCTJZ5xUd0rVbhV/fH7YczmYqXpsOJjEfk=;
        b=NLDDR6FgRE0kCZ56xUoghwnb9h0oyX+wrUw5LBz9PRw4Fl/OUgripcY79kg5/fioox
         bLbHKSTGXJ74k6XrT0vWjyMPdRzdhM5Vc5+YyjwwHRt2N6sC7whblO8MngOlrnD6f00k
         qn5AHUFI1St4pkuHk+ktDKLDjw+jf8wUhfaJnI5Zp6gzs3Q47t6bS5ZjdJhnwMr4/3Q0
         3kR1oHm8Ln8lWyF/7gZAQKLDxFDTdUYUjq3vnCiP88y80ZzOhEFSZOq6UMaTD3Pvkz2R
         /Ic7aBX1n+OZVO1ds0FzWim3QKgqPppiDjQ9R+vaEDbfZSutvSzoawqwdMrij9ugmZW/
         6Kqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=9d03L3RiYPCTJZ5xUd0rVbhV/fH7YczmYqXpsOJjEfk=;
        b=M5WVceVCMdGdfNva2ihnfmQbPYNXL7dJcAbIyjj0gj+ENprE+pD3BNwQwxaggGhWy+
         wQm6zqed/6I0ejVu43l2XYVzhlAYobL6yXIIoXZ5UVmDm3LNNSf2RDjJzyAzHLro28Nf
         lx4zi0+TX7vf8NVBuYuG8bNHY0tgncxWTUqGcHDFnS8ovSo3r0Mbnr5NcF/Q1WMQ7xs2
         sqkWkX0WQxlXnlXrGGPPlR5Br2XW+Xs/BhKlAvByfUb2sBlzIJvPA18w9+mcNNMcdDdA
         7hKPNQ2lzLkSfHFIPDxgQ5DiNIugbDAtlQe/M5c8by2LAQxJi4dt8+YXdhW+9v7y25Yc
         mdDw==
X-Gm-Message-State: AOAM531bOZMXgq/aKnmIppb1SgaJC8Jc7tUJlN2wN2zeyQjYRWal/KQS
        mRI1aYRVNUA35W+H85YiACp+GFmTZAg=
X-Google-Smtp-Source: ABdhPJzry0pmziRVu5Jbj6r/IVAjR7xqrVg8wIVwweA0vyE9+PXV4ODMwn2SGCZfQ0FeJ7P6ezHeEg==
X-Received: by 2002:a50:d791:: with SMTP id w17mr7727008edi.373.1597091003011;
        Mon, 10 Aug 2020 13:23:23 -0700 (PDT)
Received: from ?IPv6:2003:d3:c706:f400:2677:3ff:fe19:a7a4? (p200300d3c706f400267703fffe19a7a4.dip0.t-ipconnect.de. [2003:d3:c706:f400:2677:3ff:fe19:a7a4])
        by smtp.gmail.com with ESMTPSA id t19sm13021721edw.63.2020.08.10.13.23.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 13:23:21 -0700 (PDT)
Subject: Re: system hangs when running btrfs balance
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <c684e9ac-f28b-7056-0a46-6c6450ac4c1f@gmail.com>
 <8a3370fd-7cda-78d2-b036-8350c5a3e964@gmx.com>
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
Message-ID: <feffe90f-de6b-0f53-c54d-0df135c49868@gmail.com>
Date:   Mon, 10 Aug 2020 22:23:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <8a3370fd-7cda-78d2-b036-8350c5a3e964@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XPrfnRXLBF8sBnZZay6LI28M85VmWgZTL"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XPrfnRXLBF8sBnZZay6LI28M85VmWgZTL
Content-Type: multipart/mixed; boundary="FnNgGGmVoze8lrXQgIblMqFQDdxECy3rE"

--FnNgGGmVoze8lrXQgIblMqFQDdxECy3rE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

Thanks so much, Qu, for your advice and the background

We had some issues with btrfs, but I definitely want to continue using
it. So the incredible responsiveness of btrfs devs like you is
definitely on the plus side..

Apparently, Ubuntu is preparing a kernel update to v 5.4.54
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1889669 so our
problem should be solved soon!

Cheers,

Johannes


Am 10.08.20 um 11:59 schrieb Qu Wenruo:
>
> On 2020/8/10 =E4=B8=8B=E5=8D=885:22, Johannes Rohr wrote:
>> Dear devs,
>>
>> since I upgraded our system from Ubuntu 18.04 LTS to 20.04 LTS, the fi=
le
>> system completely freezes when I run a btrfs balance on it. The only w=
ay
>> to get a usable system for the time being is with the mount option
>> "skip_balance".
>>
>> The server has a raid1 with 4 SSDs with 500 GB each.=20
>> [Sun Aug  9 12:21:35 2020] CPU: 1 PID: 4537 Comm: btrfs-balance Tainte=
d: G           O      5.4.47 #1
> A quick git log glance shows that, some reloc tree related fixes haven'=
t
> landed in v5.4.47.
>
> E.g. (commits are upstream commits, not stable tree commits)\
>
> 1dae7e0e58b484eaa43d530f211098fdeeb0f404 btrfs: reloc: clear
> DEAD_RELOC_TREE bit for orphan roots to prevent runaway balance
> 51415b6c1b117e223bc083e30af675cb5c5498f3 btrfs: reloc: fix reloc root
> leak and NULL pointer dereference.
>
> And above fixes only landed in v5.4.54, so I guess you have to update
> your kernel anyway.
>
>> There has been a related bug report at kernel.org for a year,
>> https://bugzilla.kernel.org/show_bug.cgi?id=3D203405 and I have found
>> similar reports here and there, some pertaining to quite old kernel
>> versions, but we have only been hit with kernel 5.4. After this first
>> occurred, I had no better luck though, with older kernels (4 something=

>> from Debian buster, also 4 something from Ubuntu 18.04).
> Nope, the mentioned one is another bug, we had some clue on this, but
> need some time to solve it.
> (It's mostly related to some special timing in canceling, leading to
> parted dropped trees).
>
>> Apart from fixing the underlying issue, would there be any wordaround
>> for it?
> Update your kernel to at least v5.4.54, then mount with skip_balance an=
d
> finally  "btrfs balance cancel <mnt>".
> After that, doing whatever you like should be fine.
>
> I prefer to do a btrfs check on the unmounted or at least ro mounted fs=

> to ensure your fs is sane in the first place.
>
> Thanks,
> Qu
>
>> Currently the balance for the fs is in suspended status. Since
>> there is quite a few people who depend on this server, I can't just pl=
ay
>> around with it at random. That's why I am asking for advice here...
>>
>> Thanks so much for any suggestions you might have!
>>
>> Johannes
>>



--FnNgGGmVoze8lrXQgIblMqFQDdxECy3rE--

--XPrfnRXLBF8sBnZZay6LI28M85VmWgZTL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEQGpo2KXpzZlAiCX9BQuNsh71kW8FAl8xrKYACgkQBQuNsh71
kW/dzwgAxVdt8gJ0ZEicgghj/yftOJu+iqPYeM7EuQVzvrQ/mBRHYM19t5NYHIy0
sDoTNpgfkHT8y7+qAQKK1aScd34nE6ZH6qjluo9m3Y1YEXcv84bQTs5YAIryi2wv
PFjZiHs8NDWQ6Hcn5T/i3PEyNco3OcYk6RYDK83Fc/wCOvh0n0Y1yGVpavgKyoWM
NuKCP1lou6ox4gbkDymU+sPXAlthXG3+u4I9JtXm/jBIwuTE5aAMEmu4S6MvF01o
+9g/7JV0WivaTFnWfXUb6+eC6UcSFsc4Be//LMNZAf3xM3wrCwjRB46n1L3j1hUe
mAdXQZuzLg/PT0MjRdIV/S5ZH9DjMg==
=lfw5
-----END PGP SIGNATURE-----

--XPrfnRXLBF8sBnZZay6LI28M85VmWgZTL--
