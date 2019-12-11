Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF79E11A0AD
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2019 02:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfLKBpX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Dec 2019 20:45:23 -0500
Received: from mout.gmx.net ([212.227.15.19]:58533 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbfLKBpX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Dec 2019 20:45:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576028715;
        bh=v2OCm99T7xGWMqK2jVE2mw6wplKdfpBpb2mKlquuwiA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=c5JWPiQVNDfSWau725vF462f8hQu9zWvppdEdD2DHbUktVLN471Q9I+shAlcm3SgV
         +ZAPvz+VYOTscXEM4tHYj41qjUMJMBshOrEI2n5qG0TUMnW8Y3YIg36RWDtz6yQadQ
         3lzs2+L3NC0NYWcWK80aQlBzLPSxg8Q0eJy+YaHg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MZTmO-1iBgxY2V0A-00WTBI; Wed, 11
 Dec 2019 02:45:15 +0100
Subject: Re: [PATCH] btrfs_progs: mkfs: match devid order to the stripe index
To:     fdmanana@gmail.com, dsterba@suse.cz,
        Anand Jain <anand.jain@oracle.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20190628022611.2844-1-anand.jain@oracle.com>
 <20190703132158.GV20977@twin.jikos.cz>
 <e2ab1be9-8b83-987f-0d88-c1f5547060d4@oracle.com>
 <51c42306-b4ae-a243-ac96-fb3acb1a317c@oracle.com>
 <20190902162230.GY2752@twin.jikos.cz> <20190903120603.GB2752@twin.jikos.cz>
 <20190912175402.GM2850@twin.jikos.cz>
 <CAL3q7H7nbp_kmeEZpRL7KpwhXSA6=QCcwzXT-f0szrwRmW-ohw@mail.gmail.com>
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
Message-ID: <3a3acd6a-ed5b-bc35-58aa-f76f7704a240@gmx.com>
Date:   Wed, 11 Dec 2019 09:45:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAL3q7H7nbp_kmeEZpRL7KpwhXSA6=QCcwzXT-f0szrwRmW-ohw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kc9ITjOIGHVRKk0aFlGhZfTxQzY6H7H0g"
X-Provags-ID: V03:K1:8kjK9zdu69/2two/ES+EMTxPsBLawpgV9JERjm1+ZSUZMAXB08t
 9L6FqvttCdtS70id9LD+R0I0BKtTArnnF0G77cWP+Gbd4GHA7OlyKjrd8HVbpB0nZ5ZX/FQ
 IRjod732fb2vsop+qjsTS0iM1VLo9sDsnWlbJn+gB930OI7x7VEKEIT1dPPqJSxdxU6LDSw
 mHOZWxd6LbZctk/j4aFCA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:phPpZw89WW8=:ilz7v8WWpLoognvQ5xOZLv
 f7z5LiCfjclpExCT3yMVQ4lADm6in9Pwj+haHcGsokqSlDq7xclFIJ6G6t0qXLL/xkJfvIrTF
 QNiPe8kPtFAUk8uW7+/658R6fhK5GGsR1AVFC2Oo0oFE0gNBDVcAqa45MrYQY2GFV4vedvLkA
 DnoBEBUcMJwiHsQKTKEuBaCE2HfIrEQ8AYzakPu6565SzqNmjFDWy7Y5BIeWqDgdQsl+/xK8u
 nNDLeEvndbvvGUn2U3XKwgZIl5KVeDRIFGD9KZFehr7n7CDOUUPBoeJV7GM16me1YeETSXk0C
 mgO82spWK4WezQyBdhJgYNxthujBDnQHlZ9zkMp/bmsPFk0W4YZp6IUq9iElcAYmW9VsWOpPO
 1ij/JW322M4SuAq9UokapEJ+6I0UB2ZtvmYrBnArJalhKa/Qt2F96T1MaO3KeL3HR0sW80tGA
 oX+M9940zTcJK15Pn0+3hmzkv3Sq27d57tZfIbPZyK+qa58LjRJa5A6TIqqcxL8zGByZa/aGE
 heHX0T8LfI4VX9g238/ceAQN9hGo6vJ9A19xlA5H44Mhnh/tXzRiF+Gh4soSp9cDMAvRi9NeO
 fUCt44y8QMGnh4YfJPCTEHK0x1VJRaL+HmFnLcrjp2yY4aQdAR4PcxX83Wt9pAgjIW0UqC78t
 CdIEjHHY+XxEHHG7A5wEutplMkpN7sGfd4fv1LViIHx8+c6PthfEjhcaGlpRdef5XggqZ4Ir/
 C8puROzMhPV0RSjZU0dOF6ZPmrQn6ppwsvb9COtVNwwmSWj6I3Z4FEtkkkP9aiIDa/4xRbR6W
 F0DUTDQyi303ZKn5h6iRb9XLproTcejVN+oeEqEO2snvVqkZGP15hIllcr0IYn+RizVc97IBo
 WS7JPDUnboa6ZHoQIRVKMkMjbDyx628mEcTNzOrJtH1fpNwixDEE6T7dlbXKKtI/r0cB0uDQf
 liCokcEXU8UmdtFzOWaNPhhlSChKropp76WGx2f1f6H15reF9O5VibmPHZf7rBtHaWm/Di2+Y
 7voWK6JrQcHaL+o5y7KWGj8exwElNPdagNcYNPWfxu9vXYayfQ8GlTVzexMD5/896UTRfKxUo
 8hvATsen6j2aw5uR1eXgepxIsOX0+12euckMf3xks/g2zhIaiYBmIGvapgy3zdnyBDnazIPGZ
 NqhN6z4O9auIYcU2+ePYySWJFbu37biVcYmOhb8kZPlUVN3M5bGh0gvPfsnW3srQXJtW1PuSp
 EP04LV81RQE1Si1KDxb2JEwkaEcPETW3pUmpBPohYWTn9LP32/DfCENAdjmM=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kc9ITjOIGHVRKk0aFlGhZfTxQzY6H7H0g
Content-Type: multipart/mixed; boundary="Gfbe4uEoEZg0WfmDy8MNUHr3JiZEXWD4H"

--Gfbe4uEoEZg0WfmDy8MNUHr3JiZEXWD4H
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/10 =E4=B8=8B=E5=8D=8811:42, Filipe Manana wrote:
> On Thu, Sep 12, 2019 at 10:39 PM David Sterba <dsterba@suse.cz> wrote:
>>
>> On Tue, Sep 03, 2019 at 02:06:03PM +0200, David Sterba wrote:
>>> On Mon, Sep 02, 2019 at 06:22:30PM +0200, David Sterba wrote:
>>>> On Mon, Sep 02, 2019 at 04:01:56PM +0800, Anand Jain wrote:
>>>>>
>>>>> David,
>>>>>
>>>>>   I don't see this patch is integrated. Can you please integrated t=
his
>>>>> patch thanks.
>>>>
>>>> I don't know why but the patch got lost somewhere, adding to devel
>>>> again.
>>>
>>> Not lost, but dropped, misc-tests/021 fails. So dropped again, please=

>>> fix it and test before posting again. Thanks.
>>
>> With the test misc/021 updated, this patch has been added to devel.
>> Thanks.
>=20
> So having updated my local btrfs-progs from v5.2.2 to 5.4, I started
> getting 4 test cases from fstests failing:

Was running with btrfs-progs v5.3.1 before, so not hit the bug...
(And some notrun due to missing make_fail_request config)

>=20
> Am I the only one getting this? It's been a while and I can't have
> been the only one running fstests with progs 5.3+.
> Is there any fix around for btrfs-progs I missed in mailing list (with
> devel branch the tests fail as well), or a plan to update the tests?

I'll look into the test case to fix them, since most of them are just
bad golden output, not a big deal to handle.

Thanks for the report,
Qu

>=20
> thanks
>=20
>=20


--Gfbe4uEoEZg0WfmDy8MNUHr3JiZEXWD4H--

--kc9ITjOIGHVRKk0aFlGhZfTxQzY6H7H0g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3wSiUACgkQwj2R86El
/qhlVwf8CibVTzkDkXn1RyVVl5wYxq8gvwC5UcN7lUJBdN2Vs1BBbyy/IHyz/F/w
O+qfVGFmTUuqkgMcjAbpP8qAwshJIO4D4+Er5zsUT/Z8AVEdqj01xb6zk2vtkweh
Nc1SClgChg6gFU+pN9pqeWsWpiqviw76os7YaS3GbAviet7ZzyKuMvM0go3T0cFp
Wl51V5ObslPh2IHerTjZzWXavMsWxpAqqci4+7eP0/BWBrmj1cPcFLsYdkkGYd9l
3zf1W3vGjZL39YxaLeYsnL+oEzNbsfpC21uC4u01xr+i0m56qgGtjAqwN5LVxwug
7Ig6ddZsm0DPUT4v0efVz7Cq5cQfdA==
=6e+/
-----END PGP SIGNATURE-----

--kc9ITjOIGHVRKk0aFlGhZfTxQzY6H7H0g--
