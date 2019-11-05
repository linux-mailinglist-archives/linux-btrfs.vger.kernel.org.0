Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABB2EF237
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Nov 2019 01:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbfKEArk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Nov 2019 19:47:40 -0500
Received: from mout.gmx.net ([212.227.15.15]:54237 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729443AbfKEArk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 Nov 2019 19:47:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572914847;
        bh=8xsDFP/vIqESNfhji1MSkuQqsX/J3MSXcVBoY3LGPTs=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=SqktIl0Aux3vCzxRtC0QNhXSEMbObRRyv3CUGFmXvoFD1ZL29BAtEm5athnUBbv7U
         ME4qJUnSqo1r7pOjWbILqUnURF0fECFM4KbbyqkT4lwxXiQAvA7wO2fQYxrv2gcqFo
         TRHDkBD5Mg5vz2HHLbIQ5tUMjmam9WsFAvOLjSBE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mkpf3-1i5Pov2coB-00mOOl; Tue, 05
 Nov 2019 01:47:27 +0100
Subject: Re: [PATCH v3 2/3] btrfs: block-group: Refactor
 btrfs_read_block_groups()
To:     dsterba@suse.cz, Qu WenRuo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Anand Jain <anand.jain@oracle.com>
References: <20191010023928.24586-1-wqu@suse.com>
 <20191010023928.24586-3-wqu@suse.com>
 <c1f08098-5f90-70c5-6554-9a9cf33e87be@suse.com>
 <20191104195352.GE3001@twin.jikos.cz> <20191104214424.GH3001@twin.jikos.cz>
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
Message-ID: <ac77ff93-f1bc-e58a-12ab-9623d2b3a33a@gmx.com>
Date:   Tue, 5 Nov 2019 08:47:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191104214424.GH3001@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="h5mMNXLyXgrILeCxeEKgM94DgutMcuhOO"
X-Provags-ID: V03:K1:Z9uj0tpYI448rtLE8yvBIiLWF0hiBZXbGV5nZln4fdU5ETQbdO7
 c0t4uzscWoElGMmhzE/I8yp5d57HtYoq2nyq4FVKyER2A33NY/eI30f277gqCCpJcWL80Kc
 xz1OuCm+cDawJnAnnhfSa6Ps3oPhshQaqifmROQZ2zTzqAiEYXVeormTNP6x2jEn6kDITpx
 uVY6pOv49hkvLxI7MKWZg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:uUwsFNVkmms=:kD7xQot5lOL0hqN9aD8nO/
 TbbkqC2n8o8IMXjbCk1AMgiRfV7TJq61IIJXHYpaqVpNihkAtJ1X0knRq/h09uGtXdG6B4bqB
 9XL/0WG9oLVDLnWqjYqYDshTG3iSRdPaTorR9be0TYCNwU8t+PRkAYdpyc6xS+u3ZJW653dtn
 772vFruc3rUbBBYzeefHmjpOsypgvp1xSmhJNrfvRpxI9O5ygwbOM6UNEvqWt98myk5wzKhY9
 YQTkTo0oA0HidwbsMPCxBA3MFJkVwjE9mbIXw0RE49bsdgGyC09LYNnKFeKryKdSKo+uX5G40
 Z5xYzQElaurg2n92Ksy2HenQwfP5AB7l2tkfWofRJaV8VT8Ae3GYRzKEoYcWB7J2jgaSwzP1y
 FdhONlM6H9I9zjlcM1zWjZu0tl/ZoHINpjpO0qsSMtPy6ekNeLGyJlAjuP056fqFHMpSV7iuM
 bUr+KcGl9lILNFBC3NCoWcA6daU9Aw5CseBAx/zyWCvVzKGgEH7TRsccToKPtK2VOIoo5J+3V
 oKwK3wEFYhyGiK2jpl6vGKHvsjAYN+9tNqHKb7kyIgd5i+sMBrPCCanvl8VPkRgTM3wWDCVel
 oSzduZMs24NDs/APx2xBAvApIpdcGRtRIDn9DVWLtzyCTrfEM+xvsE1quYuvvBD+vUuoA6Jl+
 84hw/XbaeK0oHPojo7qqIq5A5d0/zu1sE2SwhHBOjlu1Vl1KgTs5BYuMuTxUu2Dw65rnZWdv8
 ex+XyhSRHAk+KgTEd4VJbBo07DoQaj4N01VOEUm4QNhM2YOdAnfMSzYl6ycnX9JR85C5p3pFz
 3dHVS5HFtqfTtEPYYq1sOgNn3+ylRnRxUHgH//A/5RHpWUz6IjIgquqOp3Yl3jlfjgI/Zs/fk
 l4OTl927zZeuHA+jlSMCTH0wN0JuiZ0SqdL9RKaUg5kPGyp4F8WplnM+1YxBoCf685tJ244VC
 xmPUi2FuXtHqDDi3cOt+PKm0oODwIcXafCcbQZ0LTR9oT26IIdiEjssqaHENvGYL3WAJ+m0kO
 Yub38/H4CMtVlq+Ph5tsttGacNqPDS1T2SHzhIXVy8Ua+i5ICP58XrqWjJiJX7QABXN8J8At3
 JZMvXlqfwOs//6aufJCPCt79AdGXdU99I1gaDyg3Y9if+V5wv6jK4GfWlyKEUg6G0V8SFeZFH
 dqp9u0pj4j2vP+1fJrjzolIHWLn4TixrLCdGI0VFL89Qb+LxvsKfO4dky+Y66Mbwhk+F2iL5c
 e8YdtkrOjqGRFFhWjCsvZPf15xewkAZqqm5uhnyIjYV6tSKl641+5kqZr7Ho=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--h5mMNXLyXgrILeCxeEKgM94DgutMcuhOO
Content-Type: multipart/mixed; boundary="IhJjjreAU93YVgXXALNIG9lXCZ3DjhI44"

--IhJjjreAU93YVgXXALNIG9lXCZ3DjhI44
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/5 =E4=B8=8A=E5=8D=885:44, David Sterba wrote:
> On Mon, Nov 04, 2019 at 08:53:52PM +0100, David Sterba wrote:
>> On Wed, Oct 30, 2019 at 04:59:17AM +0000, Qu WenRuo wrote:
>>>
>>>
>>> On 2019/10/10 =E4=B8=8A=E5=8D=8810:39, Qu Wenruo wrote:
>>>> Refactor the work inside the loop of btrfs_read_block_groups() into =
one
>>>> separate function, read_one_block_group().
>>>>
>>>> This allows read_one_block_group to be reused for later BG_TREE feat=
ure.
>>>>
>>>> The refactor does the following extra fix:
>>>> - Use btrfs_fs_incompat() to replace open-coded feature check
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
>>>> Reviewed-by: Anand Jain <anand.jain@oracle.com>
>>>
>>> Hi David,
>>>
>>> Mind to add this patch to for-next branch?
>>>
>>> Considering the recent changes to struct btrfs_block_group_cache, the=
re
>>> is some considerable conflicts.
>>
>> I see, as the patch is idependent I'll add it.
>>
>>> It would be much easier to solve them sooner than later.
>>> If needed I could send a newer version based on latest for-next branc=
h.
>>
>> I've fixed the conflicts, but please have a look anyway. The change wa=
s
>> cache->item to local block group item and rename of found_key to key i=
n
>> read_one_block_group.
>=20
> And it crashes during the self-tests, the patch is in branch
> misc-next-with-bg-refactoring in my github tree, please have a look.
> I've removed it from misc-next for now as I need to test for-next, but
> it's probably going to be some trivial typo so the patch will be added
> once it's found. Thanks.
>

Found the cause.

It's missing cache->flags assignment.
There is a line in the original patch:

cache->flags =3D btrfs_block_group_flags(&cache->item);

But not in the rebased one.

Exactly the same bug I hit when developing the skinny-bg-tree feature.

I'll send out the fix for it, with the removal of unneeded
btrfs_item_key_to_cpu() call.

Thanks,
Qu


--IhJjjreAU93YVgXXALNIG9lXCZ3DjhI44--

--h5mMNXLyXgrILeCxeEKgM94DgutMcuhOO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3AxpgACgkQwj2R86El
/qiViwf9G1eMVs5p0YI/g6UhFu1px75Uw/7FQ9o9Jp2iOkkY/+jb81+hASaPXR6O
dc7W60ITvmQXWLoKRtu+Y81OVEOttgRHCU8hB/hVA6OpTIcddxY3bTiy3iVzUrM7
SMu10kgIgM8l5zOT5ckgYNgHD+lAl9vn2mRth9rvH0nmA07aGDPl8E+v2IB8Rq08
z17+Bnla3HRdwSkQJeckBEFcO1HoIcjv+e65PLb/XYBA0a0Nsf7T5C76K1/IxxJ1
/FdWX7i/i/VtF/AhILNZDNKnTbmLiK+UQWtF1081OUYQXMHBt4pEMfQTaBsE6Tfg
bO3KbphPE4HOv0YFcJcrJonq6gMuTw==
=Brz0
-----END PGP SIGNATURE-----

--h5mMNXLyXgrILeCxeEKgM94DgutMcuhOO--
