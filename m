Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48C1244708
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2019 18:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbfFMQ4g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jun 2019 12:56:36 -0400
Received: from mout.gmx.net ([212.227.17.22]:38243 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729965AbfFMBaP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jun 2019 21:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560389406;
        bh=/EzTOQNt8qb0S7EvELM/ZDzVY1i80WjW/UfsobyTNr0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ZcgKYew+ZztEBouefjz+lN4DXLBo6jC1pQeoLzGLygPlzCwY7XHJWOEi9AEKd2gEP
         N+Sw8+eO3IyRUHTJ7LRcBkO45NDa7HcuqNycQ2iHqWcgUBQ3xoXZRe0iWNUXqC71Dw
         +Vdg4lpj/bRJbN1pd7TnQ59R935VB2ycRPiQwbdk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx102
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0MTeVY-1i1fPp3shs-00QQhM; Thu, 13
 Jun 2019 03:30:06 +0200
Subject: Re: [PATCH v3 2/3] btrfs: Introduce "rescue=" mount option
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190612063657.21063-1-wqu@suse.com>
 <20190612063657.21063-3-wqu@suse.com> <20190612150910.GP3563@twin.jikos.cz>
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
Message-ID: <4c6ed328-1fc6-610f-e63e-4ce45a605f99@gmx.com>
Date:   Thu, 13 Jun 2019 09:30:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612150910.GP3563@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KrKLGgDrgleIWdhRL0vomZuiPhiRBcmz0"
X-Provags-ID: V03:K1:fttOGTh9RQ1W1Lzgn2eFQ9+Bh5rly7FdksccZg/K/hmVsy7xddR
 VaE3fSRXJu/wJQeJlZreeCytBWrsI3w6nXGC39m2YtNBQwEihlf2E3UdSh8pSI80UiN/+VY
 qSRmF/ykXX6Ta4pVof/AJEn3sMwVwtejFSieiBfUEn4EHWd4HoqbaW8gKsSJSd7mAs3WAuQ
 2Uc0NzuoEQ7hLs2yG780g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rKV32TvfUSk=:nHD93I8RUHpZvNd7R0L7QM
 gids/+nySbH6jeLqOMq0ujGN1ShbotaXo/lcMykF16vOE+diJrIU7D7snOIXYx4TFqoEqDCXr
 H/d76iLbUqJ4OI3wmVh4fWKe44UKCIcWi5SL+51A6I6/vEWorrAMYfI0XeVPNqxPuoyRkaIKS
 nKZqO9ELK6YPvsHnaKFnm0w7kbxGiOV1pwYJsUjhUEEHyZkWhJ604Dqi3ry/gh3AmZcZg36dw
 jJxZPSHPP7lpIH09gQjFzXHra+kztUqCuRuWDCgicC6cLUyEMQzlYSHLyv2CR7Py7KwW/VKDh
 sMCy/uINI/72ny2pxtLLEQrJnd61eJVUKDvhHSyGFO5kiN74g2cdkMcAHn8dVPKhz309q4TGy
 AiQ7a2ACBD+YIa2g/zB3keaM00QRcBwzs58ec60qtXMPEY6ZyueibC7ysqdU2/03VH71MTuS9
 JmCUKmWsXZ0XAfnrffaHO8+mWpuA9WbJF4HUY31P1TqQGoaArBpZl2y8q9CgkW/n4FmHMt7Ww
 8ZZ6IqWIkkwMwZ8At5/XTf2e+zwiLzp5BTZngp+Tsqcy2vQ+TrCUTezTkSHwnxW+Vp80VZ/Zl
 J8zJ6YwPOtJ4p94sTtzHh1RueTWc1pMtDKIO56SbyDxrkjpzmfSCP777lo+iyFVyzgivdfNCs
 xSvrjn3iSIJAbqM6c898DfSrBnFYNa8Tp8jcEWBtI37Xnxszp3xz0t32kf0dm6yjOmyATAajS
 6kMwdJfojVEScFXFrtV2+KA7guNcsYMUqU4yH+D5TfQr06BICp5Dggz18TnEiJgEAsxL+QoRt
 tkD6eRrBphns+cF4Yk/vrXl4aEvzKXQWxOeyNL9N4gi9aZ4V52vkccoXajf5eoGtWu1IxPXxk
 IiA8PKoTQ3kEFVS/eQuJoeJlmZFCCsXr1K7NcBi9U8OGtkujgLybAB76CJ0GBOYWsAon9laIF
 +UU60PsWzwNR188cWP7XfL/XxTVMJaCU=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KrKLGgDrgleIWdhRL0vomZuiPhiRBcmz0
Content-Type: multipart/mixed; boundary="4xP0OR4bZCtvzJctDKKUksAF211yAN7EH";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Message-ID: <4c6ed328-1fc6-610f-e63e-4ce45a605f99@gmx.com>
Subject: Re: [PATCH v3 2/3] btrfs: Introduce "rescue=" mount option
References: <20190612063657.21063-1-wqu@suse.com>
 <20190612063657.21063-3-wqu@suse.com> <20190612150910.GP3563@twin.jikos.cz>
In-Reply-To: <20190612150910.GP3563@twin.jikos.cz>

--4xP0OR4bZCtvzJctDKKUksAF211yAN7EH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/6/12 =E4=B8=8B=E5=8D=8811:09, David Sterba wrote:
> On Wed, Jun 12, 2019 at 02:36:56PM +0800, Qu Wenruo wrote:
>> This patch introduces a new "rescue=3D" mount option for all those mou=
nt
>> options for data recovery.
>>
>> Different rescue sub options are seperated by ':'. E.g
>> "ro,rescue=3Dno_log_replay:use_backup_root".
>> (The original plan is to use ';', but ';' needs to be escaped/quoted,
>> or it will be interpreted by bash)
>=20
> ':' as separator is fine
>=20
>> The following mount options are converted to "rescue=3D", old mount
>> options are deprecated but still available for compatibility purpose:
>>
>> - usebackuproot
>>   Now it's "rescue=3Duse_backup_root"
>>
>> - nologreplay
>>   Now it's "rescue=3Dno_log_replay"
>>
>> The new underscore is here to make the option more readable and make
>> spell check happier.
>=20
> Who uses spell checker on mount options, really? I'd expect that the ne=
w
> syntax would build on top of the old so the exact same names of the
> options are now shifted to the value of 'rescue=3D'.
>=20
> The usability is better with switching
>=20
>   -o usebackuproot
>=20
> to
>=20
>   -o rescue=3Dusebackuproot

The problem is, every time I see things like usebackuproot or
nologreplay, it's not that easy to understand them just by a quick glance=
=2E
Further more, they are already rescue options, not something we would
need to use in a daily basis.

A little longer but easier to read looks valid to me in such use case.

Thanks,
Qu

>=20
> ie. just prepending 'rescue=3D'.
>=20
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/super.c | 65 +++++++++++++++++++++++++++++++++++++++++++++--=
-
>>  1 file changed, 62 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>> index 64f20725615a..4512f25dcf69 100644
>> --- a/fs/btrfs/super.c
>> +++ b/fs/btrfs/super.c
>> @@ -310,7 +310,6 @@ enum {
>>  	Opt_datasum, Opt_nodatasum,
>>  	Opt_defrag, Opt_nodefrag,
>>  	Opt_discard, Opt_nodiscard,
>> -	Opt_nologreplay,
>>  	Opt_ratio,
>>  	Opt_rescan_uuid_tree,
>>  	Opt_skip_balance,
>> @@ -323,7 +322,6 @@ enum {
>>  	Opt_subvolid,
>>  	Opt_thread_pool,
>>  	Opt_treelog, Opt_notreelog,
>> -	Opt_usebackuproot,
>>  	Opt_user_subvol_rm_allowed,
>> =20
>>  	/* Deprecated options */
>> @@ -341,6 +339,8 @@ enum {
>>  #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>>  	Opt_ref_verify,
>>  #endif
>> +	/* Rescue options */
>> +	Opt_rescue, Opt_usebackuproot, Opt_nologreplay,
>=20
> The options have been sorted and grouped, don't mess it up again please=
=2E
> Check the list and find a better place than after the deprecated and
> debugging options.
>=20


--4xP0OR4bZCtvzJctDKKUksAF211yAN7EH--

--KrKLGgDrgleIWdhRL0vomZuiPhiRBcmz0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0BpxkACgkQwj2R86El
/qgeQAf/avAx0DyGoYu4zl8U0d/cuD3DjYIj39zjx3aJj3a1UUVJPUNuPlPcZ/lO
xAs8sVH+CW1BsMZXgpDTUsglaBwEJNdbwq7pv4NcB8d0nsZ8Y11AR8EaCL9DLBnj
oZBmh6WZIDtE/rsVSiGKUoYx1egcy+LU19Hx3vChY4oU6BaulL3Fg6LZEGNTtaAP
FAIYUInp69XAjpOI5PoGbyVAVVuzbfaCedNrFnKrMYF32HLYMydcauytut/nYc7S
mFM1r6irWDgK5kGJVKVZCqzCiK6Fp7dlx1/fV6JQ9NUG6iT4Q+gYryDzbHaJnx52
RlMOvol9qT2VrINfOrezFQdBqcAFBw==
=QwYK
-----END PGP SIGNATURE-----

--KrKLGgDrgleIWdhRL0vomZuiPhiRBcmz0--
