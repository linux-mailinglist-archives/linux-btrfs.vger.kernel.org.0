Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3166210723D
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Nov 2019 13:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbfKVMfC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Nov 2019 07:35:02 -0500
Received: from mout.gmx.net ([212.227.15.19]:43601 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbfKVMfC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Nov 2019 07:35:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574426099;
        bh=MsyhrDc5juCA/PJVNt/vufw90DWNYn4tQQTGlRycy8A=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=kPg+QheFbK9fuhspXTQ0yROwkyTRmfJlvxC34Mcgc9C1M/7+OcSu35YhxufFwzTQY
         PyRZwfBYrpvmhUvxnLNzB1mjdunYwcnJJUyKjER14y2mY38zlcYeB9ujYLHzRutnPb
         /M+KNIS52sa6/lfM03ivemCcrRxk5wZ48put6hQE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MfHEP-1hvlKD2sWJ-00gt3L; Fri, 22
 Nov 2019 13:34:59 +0100
Subject: Re: freezes during snapshot creation/deletion -- to be expected?
 (Was: Re: btrfs based backup?)
To:     Christian Pernegger <pernegger@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20191112183425.GA1257@tik.uni-stuttgart.de>
 <7f628741-b32e-24dc-629f-97338fde3d16@googlemail.com>
 <CAKbQEqGOXNhHUSdHQyjQDijh3ezVK-QZgg7dK5LJJNUNqRiHpg@mail.gmail.com>
 <3e5cd446-3527-17ef-9ab8-d6ad01d740d0@gmx.com>
 <CAKbQEqFCAYq7Cy6D-x3C8qWvf6SusjkTbLi531AMY3QAakrn6w@mail.gmail.com>
 <4544ecff-b70e-09fb-6fd3-e2c03d848c1c@googlemail.com>
 <CAKbQEqFELp0TWzM+K9TqAwywYBxX_3jXy0rz6tx9mNXyKEF02A@mail.gmail.com>
 <2b0f68d6-6d27-2f14-0b44-8a40abad6542@googlemail.com>
 <CAKbQEqFYhQBLK83uxp1gS9WNbTVkr535LvKyBbc=6ZCstmGP3Q@mail.gmail.com>
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
Message-ID: <d362cbc6-2138-2efc-00d2-729549a03886@gmx.com>
Date:   Fri, 22 Nov 2019 20:34:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAKbQEqFYhQBLK83uxp1gS9WNbTVkr535LvKyBbc=6ZCstmGP3Q@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="f68w20e5xWRTxY4xNJ8iloVFPGBsxBYVe"
X-Provags-ID: V03:K1:YdHWiY2iANCUeqJ7NbhxmfFSlDOplSZXZ6gTyzB7FWEyoX93hdA
 OmJjzVyF0BJE9oTbuxjeSX6lcigmjOFBH1rdpPeHXfbnkL73yINlrpnLFMn/y3KNJe0Dz3y
 zMEipzfWgEunp5QbbVSG0hbdTZYcbWWYttwSvQPtH7kVSqEYEbzxX/991ke8KK9izZdPMWj
 ABRm5B7uURWJcKeiWBDcQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BPpAV8lRwyU=:gaHr2bZWEtYi6xmn5rkxgl
 0leCJmu8N1U2wbBiT+0+lxtWKHLI1D+GWGIXP6dmf8EVtt02LTI9WexOYy0j5IGne1l5ClsFM
 uoPhnHBD/Ze4SLm9BQ0KiS0Uv9Q1sl/J7kyMd/gf0C63/A/6GOabYYkpftvQQM1d+SFu0D237
 Rqe/suP9hT1wh4dM93PIEDaXIJZuPytCOUuRNF6kdKkXlk1RZIXxfh74FVMy8+U31M3S2RROc
 Kd6zxUEL+lZnUEm9P86auLAqkbL4TGqDpGc721RLRhCALx6FxklldmNzUtRIx66FpsPbZU+HH
 JR9FEZ6TmCXjzWQRToyLkdUm3McRIpanhXqnxjV/TXsUz+NxOfqhO4t3DM0vOOX4ZZNyUMuQk
 Y/iBUJQkC3j+33jd14mAyvfn7KpngyjNzcXE+6Bc5JHPr80oSY1RiRMH7cRkHlquZV3A2dvuK
 qnYprCI6kFjTdj8eXbNjR8RBJ5VDn6E+fzXEFzK4gj55nxg+FxL4if77CBtfRfsKNMrzAgtJK
 7JySmnV8lePFWGsbRxA8aIBNAbTxFuNl8b7PyQNblAOYS364DS2e6lb7Yl3632iEDss3kBqpq
 3Nr7n78LaFkT70DVXSHiOSHu+A2aO08D2zQj44JzzdnjzBb9OjP+oxQF0yaOkstQCof1nt2JF
 ohwYSQ48KUgq+OqUKWaYnmXLeKhcBmAhPIVX8I7CCREou67dtyP8IQsQBSMXMVhSx/j90vC73
 JJ8vKqUB7gq6qPFpM+Na6AeCX6jElmnavZIIMhYereHLiv+f+GjGG81jF/hKwpRT3lMRA/JF2
 pRAGIQDx32uYJEAHNiYKPLATNjQLPbHbFDpcvJtu9dKQckKCgrkCN8FOdzahOhGSomWQCyL5d
 8JnTIWAQxvShEHJyQ8LvSYY3hJDSpojd0gEhdaq3yOONbhVnEEJXZigT2eJudRl4J1LdnVtxw
 qiSU2yzAdGY6c2Gztfma+WDIdOJqpD0KzWgpdaDtSdY9srJclTAeEBgd6TThdjqyi8lv4AQ2C
 3hOY+AkY2uAu8SrnFijXyRVV6AvM2hkP11aNAxO5Dg3RZfOaR7Hu7Nltou6CgJtFQBkZtQ8eL
 Ch7Rbhl72WW54Qhs8YtG/Q17daBk8nKnOT2sUX30V9zSft0f8Jn/dZ5P5WQWjJOC7zGmzDCiH
 uI6ZLdvO+reYqlSwT4efR4SLMrVAP9bHSbkRO1Kq3TzLZSWv01Mtj5TZlNU3xdv5gwOwjKWYG
 EbOWx9RQCRsi/qiEspS7DFbmBZ5dL6Z1dL16MWz55C/l7fMptaG6s4RqSSk4=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--f68w20e5xWRTxY4xNJ8iloVFPGBsxBYVe
Content-Type: multipart/mixed; boundary="5nyhGZzh3nkf4oV6hkxrewjlvEESdAW8Z"

--5nyhGZzh3nkf4oV6hkxrewjlvEESdAW8Z
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/22 =E4=B8=8B=E5=8D=888:30, Christian Pernegger wrote:
> Am Fr., 22. Nov. 2019 um 00:57 Uhr schrieb Oliver Freyermuth
> <o.freyermuth@googlemail.com>:
>>> 2) I'm wondering if this couldn't be improved. [...]
>>
>> You can check e.g. the man page btrfs-quota(8) for a short discussion =
on why doing quota correctly
>> with btrfs is not as easy as it may seem.
>=20
> I've read that and I appreciate the difficulties in getting accurate
> usage information (or even defining what that means) from a COW
> filesystem. IMHO, performance, and the trade-off between performance
> and up-to-the-minute accuracy are separate issues.
>=20
> FWIW, running btrfs quota disable, enable, and rescan got rid of the
> orphan qgroups. The full rescan ran for all of 3 seconds and didn't
> block.

BTW, for the empty qgroup auto delete, we have pending patch for that
already.
Just not merged yet.

https://patchwork.kernel.org/patch/11195067/


But still, for snapshot deletion part, there is still a performance impac=
t.
(For completely independent subvolume, IIRC there is a quick path for
it, thus no performance penalty then)

Thanks,
Qu
>=20
> Cheers,
> C.
>=20


--5nyhGZzh3nkf4oV6hkxrewjlvEESdAW8Z--

--f68w20e5xWRTxY4xNJ8iloVFPGBsxBYVe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3X1e8ACgkQwj2R86El
/qj0jwf/QiNta2DWLhR78A/f16yqLvah7NpJ29d9R9TFaQI+s3fhZP3HZH3+8jP2
SKItvrv8ucY9tqIWRkBneto+sk9spWSWEg/glXE5D0PKmoNbZNsdzM7DEPezjD/Z
6QYSZdlK2L5vs7AWNR/PT9nBWGOu175lEpHXbhnAD5wd5N3K6sg1+Niy6E7jQX8X
Z8F3cq0KWqqYrdarRY12nCWY3jPo0jWK2+e/BmPkJFqc26Od+NdW9g0GtSr+B3G9
D+1nRXWrVNSgxMqpsYkKyA18kAG9KDN05L3FSQWricccEn/Fs2Zz7z6CjCodWlgT
9C3WpAcR6SxyDBuEHhH5jNa1K87Sdw==
=3Au/
-----END PGP SIGNATURE-----

--f68w20e5xWRTxY4xNJ8iloVFPGBsxBYVe--
