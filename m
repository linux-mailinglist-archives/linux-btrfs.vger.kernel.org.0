Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4921CE9A4
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 May 2020 02:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbgELA0s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 May 2020 20:26:48 -0400
Received: from mout.gmx.net ([212.227.15.19]:40569 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbgELA0s (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 May 2020 20:26:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589243200;
        bh=SL8w+DzFZquHnB7BvusUYrVzvP810GWBOE8AeyMLGPM=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Vn0XSBZU+q3UFklk6Zwsydx6zAX1w/T0EMm9/m2+me5H9d68z54OQ1TLDbsuivcb3
         Y7Rj4IKAodJOrxwGwZ6mwQDURcay/z8WjixiAFWYajy3yNkQjhYIZQ0TEuEFTuWZDY
         epK0kw5aYYypiFrnJGRG49afc4D7C9VcbiTXOdG0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N5G9n-1j8Tyv0P25-011EBJ; Tue, 12
 May 2020 02:26:40 +0200
Subject: Re: [PATCH v4 00/11] btrfs-progs: Support for SKINNY_BG_TREE feature
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200505000230.4454-1-wqu@suse.com>
 <20200511185810.GX18421@twin.jikos.cz>
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
Message-ID: <5cc63e86-3b08-c9f7-4a1d-a78f48632c33@gmx.com>
Date:   Tue, 12 May 2020 08:26:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200511185810.GX18421@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sjmDELJywFrIBXuGL8oVu4nXqkOMqavBF"
X-Provags-ID: V03:K1:2q7GR+aeKE6OuEQn5r3LTXVSI+w4oFIb0cpI+IOVC2x0saPBC2T
 CeZ6qE0HirCExY8bvuPSvRFV2yKqLip9w7OvoFF8XiQw9OGzc75yfSqBjqF/q7BKSwaFu4L
 1V6k9ukyjGoM1aiAQpMSHlNJfhTBHqf5Vt/9jxidtb+FCgcVQQeHVOLB5XOWidfuOfn0uwp
 ZXoIJFV/Bt3mdjCIiptbw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nqyv2vgeVO0=:FuZk5z7+lqelhF31L8CLlo
 MxiR64bI9vQAHbsJyfNIvTCd2zMOygHndS4WQXy866tTWW7QsimKSX93AW4pqc7tsOhSsM75w
 +30Fj9QpzVpWpZ9117bjnV8XYi60XBWd9fpGoMnWj9/73jQag1XXQZFwu9p74cxPGxmW+Wqc/
 Fjoyi5mnkM1ZW4H9ti8qADNjLsI/KE/6jkUgHyQHNNUygm7bfmIWERahtJYWYW9wAPKZ2h2fP
 J01uc+qwYKeQoAlEn/CPmo8udU57PMbK4ukdMMNEqtLtPZJYKZL5eFfcn/Jt8w6I9CR4wv053
 5mFe2447vkqPVJJ9wBaZGLuVbkhDm2atZuCJxHLtTF3H4xVzS9V278ylSwg4Jvk+G79yhd+2h
 hE1v9MFbE84LPhPlQQ349C7wBB7uWrSeDc8qFhEzei8HQ310mAfRR3F+55uv+7N2fT9lC8hUU
 iCUYIUDlA/Yb2RjNfIrmvCRYiS4opkYeai6yEOLRMSIMqS2jf7qkCKGZ3C9zwKGNZSiy1MQP/
 n032gUDqDXsOh76ePYbEJ1lYl02ECv2FHWhXFp/TJ8i+eBDDLuln27BbDF+tpbWLXLohIKn0Z
 zXAP6O+S4PQwue7pBA0f73nmM0e5ciLZsrcr9eAo5GjaNRNfnmUjs/9eh2zU+/S7sgsWEe44H
 xEh1D6gGyX9CXl8/zweDpcEdC9BnPuRBYSgNA9Ns4MEZkVOxK/a/PN5o4mPlDdmmYIok8rT5w
 xibu8kDmGaeqKERfnU9gZqTDwvlwr2Bnx2tYY4znyPtVPRqoZSWdslpTIBzEbMZ3eYxtnSBfZ
 fEHPp8dl3YklzZE6IYdau8yiqCfT54IN+IJZLZkqXnbwRPQoXvioobX4U2aKRCE5kG+jYNr7W
 Jv5unZKmqWMQNVerLDWMezJLXIr6/tZL47Wyl/3+KgBPSY4Qod16M+zDWUfrM+xWiiT6BS1XZ
 6oJUVQKzzr9xOas9+RaN/eqyRw802B3Qy5hN8tRzAQrsYA/Mp6Z2Po6ZJhBzVCPsxqh6u+bLb
 lBFIWUUHD+7l9TNjQ3cGJrHxogtoGlDiuGiI7B7OSh4h64xv80Nb9k2ReTyyzlz8Gv7OL1pVp
 ZQRtmP2FJPBrnkRGT2njDVBJ+pdCEynG/Xc166LoUjeRon86aNmuqyczgf6EYmGjCxfDtTGVP
 A8h2ySRAtPhVOWNFY6ED8Hdz02It7PqmkI09WaF8LSsAcBIrSnHTXLsQCTyGwskShdpYkey4D
 evI6l/qSDFoXcFFbL
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sjmDELJywFrIBXuGL8oVu4nXqkOMqavBF
Content-Type: multipart/mixed; boundary="KzfcRdrVj4kLq0BNeZWssgnAgIfvo94Fw"

--KzfcRdrVj4kLq0BNeZWssgnAgIfvo94Fw
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/12 =E4=B8=8A=E5=8D=882:58, David Sterba wrote:
> On Tue, May 05, 2020 at 08:02:19AM +0800, Qu Wenruo wrote:
>> This patchset can be fetched from github:
>> https://github.com/adam900710/btrfs-progs/tree/skinny_bg_tree
>> Which is based on v5.6 tag, with extra cleanups (sent to mail list) ap=
plied.
>>
>> This patchset provides the needed user space infrastructure for SKINNY=
_BG_TREE
>> feature.
>>
>> Since it's an new incompatible feature, unlike SKINNY_METADATA, btrfs-=
progs
>> is needed to convert existing fs (unmounted) to new format, and
>> vice-verse.
>>
>> Now btrfstune can convert regular extent tree fs to bg tree fs to
>> improve mount time.
>>
>> For the performance improvement, please check the kernel patchset cove=
r
>> letter or the last patch.
>> (SPOILER ALERT: It's super fast)
>>
>> Changelog:
>> v2:
>> - Rebase to v5.2.2 tag
>> - Add btrfstune ability to convert existing fs to BG_TREE feature
>>
>> v3:
>> - Fix a bug that temp chunks are not cleaned up properly
>>   This is caused by wrong timing btrfs_convert_to_bg_tree() is called.=

>>   It should be called after temp chunks cleaned up.
>>
>> - Fix a bug that an extent buffer get leaked
>>   This is caused by newly created bg tree not added to dirty list.
>>
>> v4:
>> - Go with skinny bg tree other than regular block group item
>>   We're introducing a new incompatible feature anyway, why not go
>>   extreme?
>>
>> - Use the same refactor as kernel.
>>   To make code much cleaner and easier to read.
>>
>> - Add the ability to rollback to regular extent tree.
>>   So confident tester can try SKINNY_BG_TREE using their real world
>>   data, and rollback if they still want to mount it using older kernel=
s.
>>
>> Qu Wenruo (11):
>>   btrfs-progs: check/lowmem: Lookup block group item in a seperate
>>     function
>>   btrfs-progs: block-group: Refactor how we read one block group item
>>   btrfs-progs: Rename btrfs_remove_block_group() and
>>     free_block_group_item()
>>   btrfs-progs: block-group: Refactor how we insert a block group item
>>   btrfs-progs: block-group: Rename write_one_cahce_group()
>=20
> I'll add the above patches independently, for the rest I don't know. I
> still think the separate tree is somehow wrong so have to convince
> myself that it's not.

No problem.

Since the refactor would be the basis for whatever the final method we
choose, it should be pretty OK.
Even if we go something like (0, NEW_BLOCK_GROUP_ITEM, bytenr) in extent
tree, the refactor still makes a lot of sense.

BTW, if we merge the skip_bg mount option before this patchset, we could
even make the skinny_bg_tree feature RO compactable.

So it would be a good time reviewing that feature.

Thanks,
Qu


--KzfcRdrVj4kLq0BNeZWssgnAgIfvo94Fw--

--sjmDELJywFrIBXuGL8oVu4nXqkOMqavBF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl657TwACgkQwj2R86El
/qjOcQf+L2nMkO/P7wh2LPZzscR875P6E0tYz/glo1k/i3g6sEvPLGIWImUFpTs7
XrQhuAJVDZhrI9FGYda7qMA9VtAZF5i1hJl2sE9SLJCyJW1mQwUUXBlgrRlwJsIo
I1w/TfhYmjsrZUkgvzEJyI4t9samn3pZFWsAcbS27JnO1vRdna56wqbb1U3x+hLp
vghrpOdJzIjUuEwKcOnVE5I5B3nT0Hanya3jAYF6vKTVMsc60F3Fe8aTKZiX3PNL
pS48iR6VvoqfNlZN/DQJZZw0lMdEkSfIE+PYEHEhI8S4YuBHREiUi42Wo8Pj+nyF
kHWnP8uEfTUihV6ZJ1BvC/Aofv5RBA==
=3NK3
-----END PGP SIGNATURE-----

--sjmDELJywFrIBXuGL8oVu4nXqkOMqavBF--
