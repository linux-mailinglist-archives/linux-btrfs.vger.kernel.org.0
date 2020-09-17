Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAD926DCBA
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Sep 2020 15:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgIQNWl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Sep 2020 09:22:41 -0400
Received: from mout.gmx.net ([212.227.17.22]:50715 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726959AbgIQNVQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Sep 2020 09:21:16 -0400
X-Greylist: delayed 321 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 09:21:14 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600348869;
        bh=7zQ3A/mjqg172vnGerIjHdgthydpzp/9l1rDxgp6syw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=UO7CQP6j1ZHQpcz/rx2ziOo/5olWRWSa2/o9+uDOhrZJGkcR4BN3Ndga0MD66qPlZ
         QxfOsbDKmesiHA+c9RPZrT1qsqHVFbxZxj7JMetSjzJv68DDLgZw2DjaR6xHOXIWyQ
         kTWYtOmaRvTlPLCMGvSxTX+19GNc8I4a+lcEWKVE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MIx3C-1k2tJC3fiM-00KQIj; Thu, 17
 Sep 2020 15:15:37 +0200
Subject: Re: [PATCH v2 04/19] btrfs: remove the open-code to read disk-key
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200915053532.63279-1-wqu@suse.com>
 <20200915053532.63279-5-wqu@suse.com> <20200916160115.GN1791@twin.jikos.cz>
 <e5a6d6a4-93b7-9845-5448-ac56ecf97075@gmx.com>
 <20200917123738.GR1791@twin.jikos.cz>
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
Message-ID: <b6f59a13-0572-01dc-656f-09f1b5eb7935@gmx.com>
Date:   Thu, 17 Sep 2020 21:15:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200917123738.GR1791@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BSmv4mlT98aU1LrjBPKT6Z9gMZE8aXgX2"
X-Provags-ID: V03:K1:zaiQG45fmBDaL1TOvfJlmk1f8i7Lin4xosNz4QkEKxg/vGxyZgs
 cRW4/Nc2ipPXWLqp7H6H77ydhVa8oWjc6alSCszClecfoRVrazsz4YUdn7XNSt2cKbhcPDI
 /k4cMIPEjSI9Xxx6bMimiU4N618BjBIkExuke9yupJdvIHpBVFe92XM5qB6WCNglHcOoMw0
 8j6XrdVATN2YUw7CvxbTw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:F0bT9fIJfys=:iQ+gk5MnoIiwyMUEPWJ8K1
 9ReXksno2xZhwAv8paURU6+Dg8bYISiWbNx/FCmW1tPPi092L2oQoqmhLBV4+xy3UMgQVB5Y6
 n+E/ESlwKEo7KeNP9wmEd09H2rzyQRCwOVyo9RXJemAKR73b3CAD4bLjOFbQcuZRLEsPcQMOj
 MYXeIt05Uk1twcGPMePxrFIB0T+g6uQI2wpwQd7tG1vjlAHezKPMmpwd5CP5jGjkY2xeFqDDo
 PE5OVyipwdkWA1EN+SOIHsfeWVnvKfBWRLik3b6nsbwRrgDA8etNEKsalZ2fSKM1Qd335tIAo
 zbH5g9LpBt0JTw0yqRZ46Ej0CTPzP8ypFYwqwel/CzM0sZTE5nGSFkpH+2sUR8V40YYtqqG5g
 mF1XNVC1jpJN+1NydPLu8jgOpwYbTqy5MAb1pNk7nJVkTNSvpunfICeUnbAA850HtqWWRdQEU
 cJDV+LpaiiMUwpM6C4RkXz5fIMMVTBjYKievVqUCn3+t5YtorXZvph4sI8c878clVH0JThhIT
 1/OWs5CtLGGH91ZLU1Mcu+euntSS0ffyGCNZod7GjhuayUFwpYBfJnJ4qV3JDbuV4du6NwkAh
 PEfTIviCb6OWjelb+5VtF/lKzBVAig73zIvzLPlSBoLCP4J0jFR1La9+lstikN4Ohi+WczK7I
 sjkT/3ELIe/DjjJN638thaH10VyQMAdidwFyRvMu3BYxwQlIOo6hpx9F2eFM1meCq3q7QP2BC
 5a2wEn9VWRTMVHMnHYv44jZZYQjb7XorIPiXXja35zX8P6gBbXpn2+m3zYnzonmrC5FtgXuDh
 QJaeN3AbhF++SIB2AszYA63dOpDi4VWONBX6jtRF2/yvRnFMmHOOdG1DFCsYjuvx2lkCkQsti
 fTaGm2QX0Yq6Av6VUycV6quGYCT+uFXS4XK1t2mNBgjP8desJJQHba8hgljlo/AeWrkWfSedu
 KHWR/Y7++i8y7u6rGvZG7H7qHCEvCDwq+HhSQ3xc5bTc8uZTqFVZMSxPbkPXNQJXCkQnPdjhi
 25sj/YDHVa5Y0Cz0BrCpP3/pFzFfntrjomdJ7NTumk5ZY6BFzJ1kWo+Xg95NTTCq7rSWdX5F7
 036tRMY6VSYnp51uu7xknAI/BwD7k59t9atwWTK9HKLsyKk+MCWqQsOmxUYyesON9LoQ/seGk
 Cv3r9n+KdxJ5TaTJi//blNNf9fJGRuekrLxWnKk8iMq3qBmkLS10T0NbHhVjY/f3C8DlWTpnd
 9RUO8Fh2yAJLqsh241Ps4bJ6IlHg9kgMErnaILg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BSmv4mlT98aU1LrjBPKT6Z9gMZE8aXgX2
Content-Type: multipart/mixed; boundary="t9PXDwdTVwDFH72sF59tnsvnVyD5UyHKC"

--t9PXDwdTVwDFH72sF59tnsvnVyD5UyHKC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/9/17 =E4=B8=8B=E5=8D=888:37, David Sterba wrote:
> On Thu, Sep 17, 2020 at 04:02:37PM +0800, Qu Wenruo wrote:
>> On 2020/9/17 =E4=B8=8A=E5=8D=8812:01, David Sterba wrote:
>>> On Tue, Sep 15, 2020 at 01:35:17PM +0800, Qu Wenruo wrote:
>>>> generic_bin_search() distinguishes between reading a key which doesn=
't
>>>> cross a page and one which does. However this distinction is not
>>>> necessary since read_extent_buffer handles both cases transparently.=

>>>>
>>>> Just use read_extent_buffer to streamline the code.
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>>  fs/btrfs/ctree.c | 13 ++-----------
>>>>  1 file changed, 2 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
>>>> index cd1cd673bc0b..e204e1320745 100644
>>>> --- a/fs/btrfs/ctree.c
>>>> +++ b/fs/btrfs/ctree.c
>>>> @@ -1697,7 +1697,6 @@ static noinline int generic_bin_search(struct =
extent_buffer *eb,
>>>>  	}
>>>> =20
>>>>  	while (low < high) {
>>>> -		unsigned long oip;
>>>>  		unsigned long offset;
>>>>  		struct btrfs_disk_key *tmp;
>>>>  		struct btrfs_disk_key unaligned;
>>>> @@ -1705,17 +1704,9 @@ static noinline int generic_bin_search(struct=
 extent_buffer *eb,
>>>> =20
>>>>  		mid =3D (low + high) / 2;
>>>>  		offset =3D p + mid * item_size;
>>>> -		oip =3D offset_in_page(offset);
>>>> =20
>>>> -		if (oip + key_size <=3D PAGE_SIZE) {
>>>> -			const unsigned long idx =3D offset >> PAGE_SHIFT;
>>>> -			char *kaddr =3D page_address(eb->pages[idx]);
>>>> -
>>>> -			tmp =3D (struct btrfs_disk_key *)(kaddr + oip);
>>>> -		} else {
>>>> -			read_extent_buffer(eb, &unaligned, offset, key_size);
>>>> -			tmp =3D &unaligned;
>>>> -		}
>>>> +		read_extent_buffer(eb, &unaligned, offset, key_size);
>>>> +		tmp =3D &unaligned;
>>>
>>> Reading from the first page is a performance optimization on systems
>>> with 4K pages, ie. the majority. I'm not in favor removing it just to=

>>> make the code look nicer.
>>
>> For 4K system, with the optimization it only saves one
>> read_extent_buffer() call cost.
>=20
> This evaluation is wrong, you missed several things that
> generic_bin_search and read_extent_buffer do.
>=20
> generic_bin_search is called very often, each search slot so
> optimization is worth here
>=20
> read_extent_buffer is used _only_ for keys that cross page boundary, so=

> we need to read the bytes in two steps and this is wrapped into a
> function that we call in a limited number of cases

Then to me, the better solution is to make read_extent_buffer() to be
split into two part.

Part 1 to handle the same page read, which should be made inline.
The part 1 should be small enough, as it only involves the in-page
offset calculation, which is also already done in current
generic_bin_search.

Then part 2 to handle the cross page case, and that part can be a
function call.

Personally speaking, even generic_bin_search() is a hot-path, I still
don't believe it's worthy, as read_extent_buffer() itself is also
frequently called in other locations, and I never see a special handling
for it in any other location.

Anyway, I will use the get_eb_page_offset()/get_eb_page_index() macros
here first, or subpage will be completely screwed.

And then try to use that two-part solution for read_extent_buffer().

Thanks,
Qu

>=20
> In all other cases, when the whole key is contained in the page the cal=
l
> is inline in generic_bin_search, ie. no function call overhead
>=20
>> Or we will need to manually call get_eb_page_offset() here to make it
>> work for subpage.
>=20
> For nodesize that is smaller than PAGE_SIZE there's no page crossing at=

> all so using read_extent_buffer would be making things worse.
>=20


--t9PXDwdTVwDFH72sF59tnsvnVyD5UyHKC--

--BSmv4mlT98aU1LrjBPKT6Z9gMZE8aXgX2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9jYXMACgkQwj2R86El
/qg/uggAsX75I1de2+wjuSB1oz1DXs4t372vKstVms8PYz3TtjHf+OzcKiP0afyY
iw3TkYZy0zbbyNkdAzjU+icONgzxPst32NG1/2PniBqenj+D4oJfGw1NAyllh1jv
o3UPSIGZEJ9yEocN+FTXFpU7WKSI9/TmMl9U50Lcy9uTBCc657ngKT9kQzggVu4h
4jvcrOH26b0Syg5uv558eyt+rDvQwpHz0EKFtFOabsb1scmkXCru7t3CtGwc1Ff7
pVa1AdoZWJipbd6KPFF1c+6TeVtbDkJ1PgfLLIt6cxUkWxOO3rCsl1BzjuGYt4J2
B1d9LNQmrAHJ0mAK7uKxM6f5aKW9oQ==
=iUi5
-----END PGP SIGNATURE-----

--BSmv4mlT98aU1LrjBPKT6Z9gMZE8aXgX2--
