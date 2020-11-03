Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB1E2A3C9B
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 07:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgKCGHl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 01:07:41 -0500
Received: from mout.gmx.net ([212.227.15.19]:49463 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbgKCGHk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Nov 2020 01:07:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604383655;
        bh=TDzW8mS2d8SnJhFFiirIny5ypXLPQmqDmSWOPBeri3Q=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=LomChlHi0JlzKIGaetFfth3p/DLPeLlXSN6jE+lQZrT0BwTVehhgdmu3auqUOL6Wm
         9TVtesR2O8fnzuDttE6igmPxa/YQOTkT9XrVh7VxHLvXmYWQ37PiGwfpUxDBSm0Gil
         6y3Mrsx1h79dDYc29pYZv5G+sbbsB1CIvfKqep4g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N9Mta-1kEg1R2oDM-015Gg1; Tue, 03
 Nov 2020 07:07:35 +0100
Subject: Re: [PATCH v4 01/68] btrfs: extent-io-tests: remove invalid tests
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201021062554.68132-1-wqu@suse.com>
 <20201021062554.68132-2-wqu@suse.com> <20201026232602.GV6756@twin.jikos.cz>
 <96747194-25f9-d774-3a54-a5d49c108919@gmx.com>
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
Message-ID: <2d32dcd4-7dea-b9b3-173c-202045590e85@gmx.com>
Date:   Tue, 3 Nov 2020 14:07:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <96747194-25f9-d774-3a54-a5d49c108919@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BwQRrgZUGAyRzZqdvHyCduMy6Wvm6o5al"
X-Provags-ID: V03:K1:hjcEy+OCtss+8FxTRSAj+XWb9CXXjaphRvJ81bbpsw3R90UYWWL
 p4HMaVKL3BwzQk30d5fjHrvsxTaeFBUehZ/6ATqDFcIqGcZ7cd4o8GcAOUSWHwnV+yDqCks
 lBStBEJ4bi4c6qvFTndhYUjO5AIpkbtjZIIr0LY5bBv2upgslIZtCcUaaBgpPWHmy7Iz3Zl
 kayqXS0EjC9PNeXz/rldQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1XaiI+gaDQ8=:DXvzjIx/mNp7cc5zw66GJU
 UpnOrHGuhNNaYdwvOWUnhq0sia5OjgC6zLOAu3GT5ETR5ri+zegcqR+llFqqWDaVXbnWmY+PX
 eimPaFnLfv02f1o/9rHXLZ24cdpuhizIknArvsCNSrzZ5GnJDDrvp9xkmMfwgcHqV8akxlrCO
 Y5OI3u9sYGsnMWahruYnlibNuXzcL/RgdNUwX7pDXnRk8/IOj1pNEs10Xu1w3SLIWZo+mAQnV
 8dQ5lyC7TOGyoj2rvpy35T9s0KVJBb9B7ipxgHjokVta4Ep/0uWucnnSM3K4Q5xa0Kimf5LED
 9wuaFOwyLoo8R1I57V24tGRgXsOgQ9YhciP7P73kjCaVDHIGyHOnpw3wrJrmIyVGYn22g1u03
 sjAK5J/j7hd3NRfNFXM43djTFDVDhhioQobYO2SG/cEEHm3uvrk7DkH1+1Wd4kbDPyWfuDuQk
 eVoxdZbjBDeGO+YtVCDzb5F4e/+HcwvhHUpsrif3LZSd3PmbDJF8yoSgYrKNW1HSfdwvuEbSK
 Hl2//THK6MZkt48btWtFUdYwl9PnZpIdMUqZ85+u0FQEhWF3jrhbP9hgz9SIka+M9NfHpclGa
 JMtKGj3uBBj1023Vn8elRzPVObt7RJ3u3wbbZvrA9hWp0XG16eImBZdd4g6gOqHvih/7rap/o
 nGr7Nxe0ITuuqA1EJFDB42hhsETwsR9tSYnveaL9RZ/ItrCfjxk1mQmrl2bjaKmSxVkcHi4x0
 UTMPY+7URkpu3CdXnIkNDZqTQlyQzNGCnHjMhiDyRUnP/Q9a/BgEyCKi7vJtvz6C83VURm0+m
 hKZ0/sPJbyLICiJOojshM+YBwq3MpZJeflaVvcIutpLZ1g4AsKK6vLQ5mbgVa5HDhYscWhmCs
 HtVsDYP5QY57xFlAUtFw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BwQRrgZUGAyRzZqdvHyCduMy6Wvm6o5al
Content-Type: multipart/mixed; boundary="bFNq34AkS6JMnWxlJQjUOPX0KHG2bVFnD"

--bFNq34AkS6JMnWxlJQjUOPX0KHG2bVFnD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/10/27 =E4=B8=8A=E5=8D=888:44, Qu Wenruo wrote:
>=20
>=20
> On 2020/10/27 =E4=B8=8A=E5=8D=887:26, David Sterba wrote:
>> On Wed, Oct 21, 2020 at 02:24:47PM +0800, Qu Wenruo wrote:
>>> In extent-io-test, there are two invalid tests:
>>> - Invalid nodesize for test_eb_bitmaps()
>>>   Instead of the sectorsize and nodesize combination passed in, we're=

>>>   always using hand-crafted nodesize.
>>>   Although it has some extra check for 64K page size, we can still hi=
t
>>>   a case where PAGE_SIZE =3D=3D 32K, then we got 128K nodesize which =
is
>>>   larger than max valid node size.
>>>
>>>   Thankfully most machines are either 4K or 64K page size, thus we
>>>   haven't yet hit such case.
>>>
>>> - Invalid extent buffer bytenr
>>>   For 64K page size, the only combination we're going to test is
>>>   sectorsize =3D nodesize =3D 64K.
>>>   In that case, we'll try to create an extent buffer with 32K bytenr,=

>>>   which is not aligned to sectorsize thus invalid.
>>>
>>> This patch will fix both problems by:
>>> - Honor the sectorsize/nodesize combination
>>>   Now we won't bother to hand-craft a strange length and use it as
>>>   nodesize.
>>>
>>> - Use sectorsize as the 2nd run extent buffer start
>>>   This would test the case where extent buffer is aligned to sectorsi=
ze
>>>   but not always aligned to nodesize.
>>
>> The code has evolved since it was added in 0f3312295d3ce1d823 ("Btrfs:=

>> add extent buffer bitmap sanity tests") and "page * 4" is intentional =
to
>> provide buffer where the shifted bitmap is tested. The logic has not
>> changed, only the ppc64 case was added.
>>
>> And I remember that tweaking this code tended to break on a real machi=
ne
>> so there are a few things that bother me:
>>
>> - the test does something and I'm not sure it's invalid (I think it's
>>   not)
>=20
> Sector is the minimal unit that every tree block/data should follow (th=
e
> only exception is superblock).
> Thus a sector starts in half of the sector size is definitely invalid.
>=20
>> - test on a real 64k page machine is needed
>=20
> Every time I inserted the btrfs kernel for my RK3399 board with 64K pag=
e
> size it's tested already.
>=20
>> - you reduce the scope of the test to fewer combinations
>=20
> Well, removing invalid cases would definitely lead to fewer combination=
s
> anyway.
>=20
>>
>> If there are combinations that would make it hard for the subpage then=

>> it would be better to add it as an exception but otherwise the main
>> usecase is for 4K page and this allows more combinations to test.
>>
> No, there isn't anything special related to subpage.
>=20
> Just the things related to "sector" are broken in this test cases.

Since all later subpage refactor code will require this patch as the
basestone, I just want to re-iterate here again:

Any extent buffer whose bytenr is not sector aligned is invalid.

This does not apply to subpage, but also regular sector size.

E.g. for 4K sector size, 4K node size, an eb starting at bytenr 1M + 2K
is definitely corrupted.

This is patch essential, especially when later patch "btrfs: extent_io:
calculate inline extent buffer page size based on page size" will change
extent_buffer::pages[] to bare minimal.

Anyway, I will add extra comment to explain the importance of this patch.=


Thanks,
Qu

>=20
> Thanks,
> Qu
>=20


--bFNq34AkS6JMnWxlJQjUOPX0KHG2bVFnD--

--BwQRrgZUGAyRzZqdvHyCduMy6Wvm6o5al
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+g86IACgkQwj2R86El
/qj3DQgAsEcHJ6qtT83c9xLmLkv64/oB7OrAevK9PO7ceP68s+aOEy7ePNCek03Q
IDqZt9bL6LAEQA5xS0DKkP47fUIp02/SPGcL3yg8x9gRzPnou5wrmxTfdT28z/rO
HpHzKu5PE336LQZWfxcRhu2qGu6nVb6RchSxPEgaK4/m8bQXRE6/DJe5gO+eVo25
rX3+pu5AngjzvjiuSOPgGK3gA/gmAncswhwC1RR8dl7dD9Qi/nOBC4g45Wx+hzfu
kBihs5ZNp7YxJF/C8F0oJ/b/K0gIEFsfgERDOWXEsQ/ZP++qvMbIOe6X9Ina1/K/
bIi8CW/6vfGAw/dAKivdl8NYjGI1RQ==
=w49+
-----END PGP SIGNATURE-----

--BwQRrgZUGAyRzZqdvHyCduMy6Wvm6o5al--
