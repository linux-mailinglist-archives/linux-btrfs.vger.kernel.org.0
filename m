Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6B239EA35
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 15:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbfH0N46 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 09:56:58 -0400
Received: from mout.gmx.net ([212.227.15.15]:47229 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbfH0N46 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 09:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566914207;
        bh=/Cq9lpCdnkSPMYI9vBW5aT7mUR8a6a2+tUDEWqtMgRg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=NexDAjZkTwxbM0QQRTxqjrpwzfnsdBKeUQnHoyK3usehTn8YnYv25MC9vlhD7H0+h
         9iFMfLTQ42G9RxS1VqzaePaHDRSAGfPoBD6XbyQa7AjzNqyyrHvOkRvSKzzgt01jSm
         A9IN00QmEgrEeJkUGIYMmff0Whcd+N8fTh5vcYuY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx001
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0McDl1-1hkFdC2rId-00JZiJ; Tue, 27
 Aug 2019 15:56:47 +0200
Subject: Re: [PATCH] btrfs: tree-checker: Fix wrong check on max devid
To:     Jeff Mahoney <jeffm@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
References: <20190827132206.1483-1-wqu@suse.com>
 <dc3f2017-8d49-d6fc-9198-f2d641ec1096@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <f08ecd39-352e-2b12-f0f5-eed15d2e7fdf@gmx.com>
Date:   Tue, 27 Aug 2019 21:56:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <dc3f2017-8d49-d6fc-9198-f2d641ec1096@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IjSGTKqupfwj7J4nzeT7ysnL8u5TZ013R"
X-Provags-ID: V03:K1:3WoSZp8GtNXbGrL4wv+cqmPkpogJzaLbsZ2CpAq49mob8n4akkR
 6UrzU5+4BT5uxN6Yo3V5FXq4sGMLrOdimVd9kxmdYPPKhUZBX2bnv/juTKAP2+2bnN6IXya
 SR0axlE0Bcrdru/8v46I/+gcvoHE3u598KEWYXoLM2shBWVCG1ef+CQbcsfbYzqKqD8Vcm6
 Iia69Gqc6zofeVeWmzzSw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:CtdSUeRzvAI=:iIiDC6vxbPL27chbYzOudN
 UrMKMCZfoap/1rzPnbvGPfNmru7/ofyNW6AlWD6wGPRWMJ08jkFq/8iY4sucCQu7H+jHB7yyY
 iAS3sOzjJpELGvP+XFvfL9YXHfMgHq97oypmaxboEUyIGqow6PcOuVDnfSooZFyYjTFa97Sn+
 GeLtVAFBTE6mdEGFtUu7E5OJp/ZxUGDTiV6ndj7EVHoHztu0reNj4cjcCL8kQe32j5WOk3PaY
 DhYPvN8qsRazLx6uYCFP119EF54OyxVqCp1A77Lr2LRXUAOsEBYOoDu4pfgBmyaY2oIbJX6lQ
 zkw0RpFCwBxFw73hQ/JHYkONvwFwk1qR1VS+XJvI186aWVXfeHBmNaylbiKFE1kSXTj7NGbXU
 H/Rg7JeSEsLQT0PHND3L7/t3gaO6dTPahZnRIY5Z7FCUAsvs0p/HlYqDiQ41Wleb6t8Do+12t
 RsY6LA/KOUIZMwc6aBytLUHSqrWfTN5fsj03hZt1fTFGJE/uPGhHvgxuWJ4lOjO7jMfXFTTxP
 qprx+GmkmplxgUF50w6dOuCv4q+fZxVACp3jm3zXVO7HM2rM03XfIz8Ir7+Df5oVcqCA3kBQm
 sCZGFwSft38WmtoVUm9x0lB9E37+RTEe8V02f5dDK+maoC7oVyKun8I4NBk7IKYbbk+A9YwtC
 /xgWY3VIgbt9faHyvWZcfDXX01dH2Yp+OhyiCZJatBhb1zbb5LN50JFgr4DU/5+n05L072kdU
 WzOCbjiltHbk9Fir92rqavb+YoG36laRAPNeclO0Ak9KzWPJwXpQq7xwkGE4LXEqUbsec6jji
 cW3L82sDUR1aUL1ytA6ZcOR7RCCQZ+yb+GKAlu/7mhq3YMCpyKnBlCacz/Ny7MJVl2XP9ZNjM
 GkjXyQiJLCoMysR5eqYBoxL4ZACkaFv4ioEUJl+y35+Y6XlpUvUDiBDxbJU/TXNDUsQbpnPJ/
 ojaIibNg5mBm4gwSfT6XOzLgMFkMfKbSr156inL4eMYCnIMrApNynN8fcZSU7VLShbVVIWKV2
 hWdoApT6o9khj3k/VTdf7nAnobabSJd6a4dnc65gMhjEJFZnVcaXLKM9UHRkvpWJ12DC67pp7
 iXSVuE/jSEoQuqoyWMFkcOH4njSR0fe2D+Is5GyH+dB0EVecfy0riVRSw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IjSGTKqupfwj7J4nzeT7ysnL8u5TZ013R
Content-Type: multipart/mixed; boundary="PWzFjK4mgg4g40OUEQrCtuApL4AP4ydZu";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Jeff Mahoney <jeffm@suse.com>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Message-ID: <f08ecd39-352e-2b12-f0f5-eed15d2e7fdf@gmx.com>
Subject: Re: [PATCH] btrfs: tree-checker: Fix wrong check on max devid
References: <20190827132206.1483-1-wqu@suse.com>
 <dc3f2017-8d49-d6fc-9198-f2d641ec1096@suse.com>
In-Reply-To: <dc3f2017-8d49-d6fc-9198-f2d641ec1096@suse.com>

--PWzFjK4mgg4g40OUEQrCtuApL4AP4ydZu
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/27 =E4=B8=8B=E5=8D=889:37, Jeff Mahoney wrote:
> On 8/27/19 9:22 AM, Qu Wenruo wrote:
>> Btrfs doesn't reuse devid, thus if we add and delete device in a loop,=

>> we can increase devid to higher value, triggering tree checker to give=
 a
>> false alert.
>>
>> But we still don't want to give up the devid check, so here we
>> compromise by setting a larger devid upper limit, 1<<32.
>=20
> Is this really a useful check?  There's no actual definition of what a
> devid can be, only what the kernel/tools does right now when it adds ne=
w
> devices.  There's nothing in the format that requires it to be monotoni=
c
> increments, which makes any check on read unreliable.

Right, that check makes no sense.

>  Once we do read
> all the dev items, we can check for corruption on write, though.

That could be too time consuming (we need to lookup each devid in
fs_devices list) to be done at write time.

So I'd prefer just to remove the devid check.

We already have dev_extent verification, so even we have corrupted
devid, we can detect it at mount time.
Thus even we have a devid corrupted by bitflip, we can still detect it,
although not by tree-checker.

Thanks,
Qu

>=20
> -Jeff
>=20
>> So crazy scripts can't bump devid to that high value easily, while we =
can
>> still detect obviously wrong devid.
>>
>> Reported-by: Anand Jain <anand.jain@oracle.com>
>> Fixes: ab4ba2e13346 ("btrfs: tree-checker: Verify dev item")
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/tree-checker.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
>> index 43e488f5d063..f9d24f01801e 100644
>> --- a/fs/btrfs/tree-checker.c
>> +++ b/fs/btrfs/tree-checker.c
>> @@ -686,9 +686,14 @@ static void dev_item_err(const struct extent_buff=
er *eb, int slot,
>>  static int check_dev_item(struct extent_buffer *leaf,
>>  			  struct btrfs_key *key, int slot)
>>  {
>> -	struct btrfs_fs_info *fs_info =3D leaf->fs_info;
>>  	struct btrfs_dev_item *ditem;
>> -	u64 max_devid =3D max(BTRFS_MAX_DEVS(fs_info), BTRFS_MAX_DEVS_SYS_CH=
UNK);
>> +	/*
>> +	 * Btrfs doesn't really reuse devid, thus devid can increase to any
>> +	 * value, but we don't believe a devid higher than (1<<32) is really=

>> +	 * valid. This could at least detect bitflip at the higher
>> +	 * 32 bits while still consider high devid valid.
>> +	 */
>> +	u64 max_devid =3D (1ULL << 32);
>> =20
>>  	if (key->objectid !=3D BTRFS_DEV_ITEMS_OBJECTID) {
>>  		dev_item_err(leaf, slot,
>>
>=20
>=20


--PWzFjK4mgg4g40OUEQrCtuApL4AP4ydZu--

--IjSGTKqupfwj7J4nzeT7ysnL8u5TZ013R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1lNpgACgkQwj2R86El
/qgt4wf/a7g0PmcTBdRWTjb0JhKsEF+vc7q/LphUuMEbYX1mqiTlJAmUpZfXyyr4
isifaHmUQoTgTJ9b+++0i1d406sX1eg1c6Z6YvyHw1AdFdqA/ZUMJL7cT2nqYMQl
Zzcprr3JgrH3oY8BV9Xoo8U1+dj1Ez1eolvWpxtTtzKi6Ib9SybCVa3byEuEEqZF
d1fBYw9wBQx7mg/ar/lQKX5AttAz7Df+m7RdlY7gBIs6SqDhMUHVc2/+7B5NIoHP
7Pplj5TlDMmQ0sMU9WIEQzOQ9KNGtUxZAiAfchOP5FfMsi4LGFJTXTPZS+aHWwQ1
7DOC70+b7TSvBSnO1Gy8ipRL8Xdd3A==
=DPnw
-----END PGP SIGNATURE-----

--IjSGTKqupfwj7J4nzeT7ysnL8u5TZ013R--
