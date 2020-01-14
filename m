Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC8CA13A22E
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2020 08:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgANHdd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jan 2020 02:33:33 -0500
Received: from mout.gmx.net ([212.227.15.19]:35749 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728801AbgANHdd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jan 2020 02:33:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578987206;
        bh=TmxfkZDPOueL9M+NWzFpyuAPruwbLZXOGsCxYV5oOws=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=VzRmEclc3F+PmjyH3aJ4p6X1luZpkZgyvVOdh6lMYuRttGvIiUqgmcEUFTZlZyerb
         0iJ4FU4t9GxlR+U7aRdYmIx05IQVpRAObHrvVTNVcG3ggJSdiUpQPp4ZQ27JXGPUyx
         Vsttc3QDf8owJ3JN6ufDLbwn6+9KZAoHHbzanjho=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MHXFr-1ivNRs2N3h-00DXTu; Tue, 14
 Jan 2020 08:33:26 +0100
Subject: Re: [PATCH 1/4] btrfs: add NO_FS_INFO to btrfs_printk
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.cz
References: <20200114060920.4527-1-anand.jain@oracle.com>
 <cfd79de2-fa25-c112-0540-3c3058379275@gmx.com>
 <6f0db474-905e-02f3-41e4-6cb842d776e3@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <f9e199b3-5ad6-de28-c22a-ba018cbdb238@gmx.com>
Date:   Tue, 14 Jan 2020 15:33:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <6f0db474-905e-02f3-41e4-6cb842d776e3@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Wo2OxDyWq7vmgyEf4KnrixuMcoc3yID11"
X-Provags-ID: V03:K1:fZbgiZkoOYpNl+hQtSVFiQ38EGRNQ7fiYzgmhDxnOt7EdHahqIK
 Tw7/E6bP25S+imjzTmSGXJSKgqSCjaGbvJEgaNGmY+eC1lZakCs0dpWaeGZTWJDLOo8/Ie2
 RWjcX5dTMfwxDqVnJH+TNB2yCznwdLIWKfcKQDVKhO0AQhR+DTb57am9azh+LpxXmSmWKZK
 TdF6bdSuNUdzX6Zpdm3Yg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DSVuftg99qg=:lgEMIZM1I23trBB+OKEdkQ
 TVbMP6HGPIpTYESwgG0rTMqQRvYbVyoBLP8/PHbWTTYXhwjqdy4ek7vJe6SrMqpvuy0UDLa+6
 VUFM7tUOC5/IFwIwCtaDgciAPvAkHhq7HiByfIEPAjJjym0dsQwawVERkKwYOtW5b68J2zYwC
 ysCD0V5oDWSx+ZU5BRVGTMf+mqFeK3jXoNbqTW2NQYU+DRElJgnv8uouPaauZK+vYmGY0OIx9
 I98JPvgGFPJZRyoiR+EevPAVPDvKqux+6sGq08s4+CIDH8KzuUqfYjSBA8FkNRzmZzTEUIqpf
 S4VBTOji1uFoa14Xqq3oOvht1KmzIO3X7Vu35WlawORO6Tab9nnI229Va1FOvwkCa3NNUucxV
 uDd1JyRb+uD2v99DQCoJOi89VAHHg03eXtJtH01AFG0uvoZB+bgPtS7EIzLZUroQpJk6I5THi
 7KmFZjVanEdnjtaV8rWUnvZYj2okiAMwakq7fmKsSXYyLGb6qiD4F6FHNR9EIxKTA65mncgM0
 DlyHMcSWcns43Jynl2xkP1pYrTQP3xm7sxssdT2gOlh9mhytkBm8xKwfDmiy2RIxnK1Z51XsI
 9tp0TYRiHvnUm5nkOYXAqRVZakA3K8da8U2WXyBny5KC/hQCbG3y2HykZSo58/GLE5jrcy4KX
 0iOnQmxc0VXRTb3WgvvkVPQeH/Rfm/e1FiSRdtnHUzCvOTsBV2grOiYj5DNPO9c0EHlNkxyhI
 BX4J5O2137yhjen0baPNlVa+2CLzyucABkIeimw9rSt+Hb/VWa9z5sJgUrT7Yx+xt3pxE5KlE
 wWIT2Gscwf0g96Ko+6BmhjPPJBcEH18yHl8hgDT0op3E3duwWcQPId2DgiV4kczgrRnG5NL32
 +f6B8ZURXYRUIAFkgQacTYTu9YD0hL8qiS8JK2aAexTty2Dd3TyuzU/WX46are5eGElR6mXxd
 XjfhoncZctvwjx8MgJveSTJaa7wH9BLIpuZLZY8cHW5n+nM2IPgZSP/V7WV/6fcRPm5IZbhvM
 Fe68PMtKwOYoJTc9BN+97/ETGhoGnwtwj0dbP59NnwxCg0hetYyjpq3XqYXiJTK6MAzzFIAqW
 CZWpSF8tqOheQnfbINK+QxSSU1Py7wgUGdGL+K+irS6QTSHNkvTu7zz2PZKyNbyG7pfL54ZO4
 S3envqfiRFjpT19PLAjU8e39ICd3KqE4kzOLmsuXaFJzl78DiEfi28OAAlEQkzlhdtTR3BxgS
 5sKc5QwWut/CC8DV175aLN+2dpf3U3ZNCJ/IPAQPkqqrd5xEzqS9cChdly0o=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Wo2OxDyWq7vmgyEf4KnrixuMcoc3yID11
Content-Type: multipart/mixed; boundary="iSGvVdRSHKeRUiBmLsEIsgx0yeWv0o7AG"

--iSGvVdRSHKeRUiBmLsEIsgx0yeWv0o7AG
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/14 =E4=B8=8B=E5=8D=883:21, Anand Jain wrote:
>=20
>=20
> On 14/1/20 2:54 PM, Qu Wenruo wrote:
>>
>>
>> On 2020/1/14 =E4=B8=8B=E5=8D=882:09, Anand Jain wrote:
>>> The first argument to btrfs_printk() wrappers such as
>>> btrfs_warn_in_rcu(), btrfs_info_in_rcu(), etc.. is fs_info, but in so=
me
>>> context like scan and assembling of the volumes there isn't fs_info y=
et,
>>> so those code generally don't use the btrfs_printk() wrappers and it
>>> could could still use NULL but then it would become hard to distingui=
sh
>>> whether fs_info is NULL for genuine reason or a bug.
>>>
>>> So introduce a define NO_FS_INFO to be used instead of NULL so that w=
e
>>> know the code where fs_info isn't initialized and also we have a
>>> consistent logging functions. Thanks.
>>
>> I'm not sure why this is needed.
>>
>> Could you give me an example in which NULL is not clear enough?
>>
>=20
> The first argument in btrfs_info_in_rcu() can be NULL like for example.=
=2E
> btrfs_info_in_rcu(NULL, ..) which then it shall print the prefix..
>=20
> =C2=A0=C2=A0 BTRFS info (device <unknown>):
>=20
> =C2=A0Lets say due to some bug local copy of the variable fs_info wasn'=
t
> initialized then we end up printing the same unknown <unknown>.

Then that's a bug to fix.

>=20
> =C2=A0 So in the context of device_list_add() as there is no fs_info
> genuinely and be different from unknown we use
> btrfs_info_in_rcu(NO_FS_INFO, ..) to get prefix something like..
>=20
> =C2=A0BTRFS info (device ...):

But that's the only context we don't have an initialized fs_info.

I don't like the idea to use some random pointer as a special indicator
only for 1 or 2 call sites.

And if you don't like the "<unknown>" string, unifing them to "..."
looks better to me.

Thanks,
Qu

>=20
> Thanks, Anand
>=20
>=20
>> Thanks,
>> Qu
>>
>>>
>>> Suggested-by: David Sterba <dsterba@suse.com>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>> ---
>>> =C2=A0 fs/btrfs/ctree.h |=C2=A0 5 +++++
>>> =C2=A0 fs/btrfs/super.c | 14 +++++++++++---
>>> =C2=A0 2 files changed, 16 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>>> index 569931dd0ce5..625c7eee3d0f 100644
>>> --- a/fs/btrfs/ctree.h
>>> +++ b/fs/btrfs/ctree.h
>>> @@ -110,6 +110,11 @@ struct btrfs_ref;
>>> =C2=A0 #define BTRFS_STAT_CURR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0
>>> =C2=A0 #define BTRFS_STAT_PREV=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 1
>>> =C2=A0 +/*
>>> + * Used when we know that fs_info is not yet initialized.
>>> + */
>>> +#define=C2=A0=C2=A0=C2=A0 NO_FS_INFO=C2=A0=C2=A0=C2=A0 ((void *)0x1)=

>>> +
>>> =C2=A0 /*
>>> =C2=A0=C2=A0 * Count how many BTRFS_MAX_EXTENT_SIZE cover the @size
>>> =C2=A0=C2=A0 */
>>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>>> index a906315efd19..5bd8a889fed0 100644
>>> --- a/fs/btrfs/super.c
>>> +++ b/fs/btrfs/super.c
>>> @@ -216,9 +216,17 @@ void __cold btrfs_printk(const struct
>>> btrfs_fs_info *fs_info, const char *fmt, .
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vaf.fmt =3D fmt;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vaf.va =3D &args;
>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 if (__ratelimit(ratelimit))
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printk("%sBTRFS %s (devic=
e %s): %pV\n", lvl, type,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f=
s_info ? fs_info->sb->s_id : "<unknown>", &vaf);
>>> +=C2=A0=C2=A0=C2=A0 if (__ratelimit(ratelimit)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (fs_info =3D=3D NULL)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
rintk("%sBTRFS %s (device %s): %pV\n", lvl, type,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 "<unknown>", &vaf);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else if (fs_info =3D=3D N=
O_FS_INFO)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
rintk("%sBTRFS %s (device %s): %pV\n", lvl, type,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 "...", &vaf);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
rintk("%sBTRFS %s (device %s): %pV\n", lvl, type,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 fs_info->sb->s_id, &vaf);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 va_end(args);
>>> =C2=A0 }
>>>
>>


--iSGvVdRSHKeRUiBmLsEIsgx0yeWv0o7AG--

--Wo2OxDyWq7vmgyEf4KnrixuMcoc3yID11
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4dbsIXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qhroggAjq6odHmvrn/DkNRRAUEQGy4I
K/gx3dqu1DVX9E42uVqRC0utrb+5qKqDplqjySsO/Qcl2IqmveUTvVEN18uaUvGI
pPZI3fVE2CmDNhxF0+hIm8lR8lkmR6wbytNnzZMB+F8Ywo4JD/niJ2GfdI3iciM5
ZtoMRztQS8Ip+RNyZldDYRjWvCL73hD5zqiaEZLZfwfYHif7IQKleZnZytVWQIiY
nhf63tVlMeEJBSg4CD+hO8+HPSpC18xL6NVjeUx5VtZBCkdpphrLnAFxFOIbgu5f
4DxDkI7e4VTrR/rnvkGwwo43GiJbzqJylrOjbbNB1nkFvuwPVfy0evp6psJydw==
=7E0s
-----END PGP SIGNATURE-----

--Wo2OxDyWq7vmgyEf4KnrixuMcoc3yID11--
