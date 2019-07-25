Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02C0F746F9
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jul 2019 08:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbfGYGPV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Jul 2019 02:15:21 -0400
Received: from mout.gmx.net ([212.227.17.20]:38307 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfGYGPV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Jul 2019 02:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564035313;
        bh=udH+N6+nBH1qfsHVfB1U/Rg0JncJQ1M9OGmgtokLV8Y=;
        h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
        b=X30M5jXBRs9LqrBQlxYhOnkssBnolxBgN0nfby7UBXVdg0AMHn3u3PeYXQDNxmY4E
         ZOwWkf8sLfs5INZlWlA43RQIObm4aZSPSf1IZLWS7d/LT1YVcUnapi9qkXGVGXaOQL
         kjR1cqsCTRPrJw6WBeifdOAPTW0c8Ttzp+kPMoos=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx103
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0LjquD-1iNNsE3BMX-00box5; Thu, 25
 Jul 2019 08:15:13 +0200
Subject: Re: [PATCH v3 2/3] btrfs: Introduce "rescue=" mount option
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190612063657.21063-1-wqu@suse.com>
 <20190612063657.21063-3-wqu@suse.com> <20190612150910.GP3563@twin.jikos.cz>
 <4c6ed328-1fc6-610f-e63e-4ce45a605f99@gmx.com>
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
Message-ID: <90e13081-0f75-37ac-bc57-4bfea24e6482@gmx.com>
Date:   Thu, 25 Jul 2019 14:15:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4c6ed328-1fc6-610f-e63e-4ce45a605f99@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="R37Q8RuYkVKfroFsezIrcuFxwg3XtYs6p"
X-Provags-ID: V03:K1:Qx+kkCvj++MDUOGvQnUiCTD6Uaw99NAXlIBaYK7BehMShqtr/19
 57iDYLfbn3q3J5w7Ky/MK/dQsQRjjmHv9EOqOsN8tBqF8bkIZYEctemGlVJlI1BcLIJvok8
 rXsCpwbXb+h9TIf4icFBzTcEjRer2mB4J/pwlZIPY5+AoDPwwlurwhIgwTvnBitw865vjeR
 ftagg00qF8FaAie/bAqaA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hzI4CjUqFe4=:lPgBO1L0b/wIPfjuPknXda
 gKKWAPM51cHkSz5RAsbj0oFGFnEOj4MQm3vWeT/TaSGux4mJQu1ufs7Q/ygFfjwwcny8cO23+
 9L+dzR8VsmkP3YDx1okb0TbdcwJxsHnwwOXaDoJ2ad9WxbcwSHzHnkaXVArSJpipURjvEcI4O
 cFmkdwASjNt6+7GmsNAE04QQUAxi8Pt3sB9niEmC49JQsy6xBYhK+g6zadZAs/ORIOQGd8mCv
 4Pm12JtvjT4FXzcP8San+iFfD7zBkh9USqd+BSBgoWC5lmUJbl0qboxD5VmF/jdpiMSoVn5BY
 k1YgMEFm9Nwa7ORMUYBineT8KonGGTbmLxWMRsU8LIWgrjB3aG97fE21tep8kq5sezkjWoY1g
 Re+H3rtcbSBGmwtBgXRmX+pziql+QQtCzm3bwnHJSQb57FcWyYF4io3SlDWWWuRRemMyQbqRZ
 gpsiJy845OCLdVzWgRVExyhWJOmZZKcajbcKUKy7DXZ9cRvAUQPzj6D84s0ZN9cJWf0R4zkfu
 0XsczNvMCdF52hE94IqN8e7i/VAPCMKYTQV+s4zezJ0eg7AOwrX4hFmJcQP9ex9vQja7f3XN2
 mniJDYnrRqGHnCiR1MFWA+TfUyLe2tW1zfIl9RAFrWxy4XcEk9EeHPJFRw7DgPqFUMDMHVekx
 aZEcxKiRJnI4POAEN3WjbTlD9+F80uWmRROkUzqQF3AVSo0Mo2OWOi03MMgSJvuCPZwYN6gQe
 p1sYyGs5salLZ3sFzyq5b2DoNu7Z/9HE6am8jQO7/0PbUeNRLKZLILVYRN8q1JsdgFN7CJ5Sa
 qiViBOO6Rs8LdH2spd3ipsJJ22ruR+LtbRyARz2VRsWjF8a5ngEet4KMcS+yqI8qYTCK0i96k
 Jz9fzQhJeMQn7e6Vzi4NrAQJP9Bl4+hc9teYVlvkbsMTrIAnZbw6B1xFUzg/H483jRX2qX/JR
 s5Y0fLmV3H6Z5yvaHUKNrfe98H6BtSruusCvJKbseTPDj+6EJfATab7rUKxIeypBJjDWzRdq3
 r5FOwc9ZAkbETYEWA8ZhOPIg5oS8kc9sl6OjbosM8ymwI1tsDt74JLrPNmVAP8c8Qgy6k3/yV
 vzEespScs7azos=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--R37Q8RuYkVKfroFsezIrcuFxwg3XtYs6p
Content-Type: multipart/mixed; boundary="NjzrrrF7sWbSjpyw4Ry7wCumqfvSVDuYm";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Message-ID: <90e13081-0f75-37ac-bc57-4bfea24e6482@gmx.com>
Subject: Re: [PATCH v3 2/3] btrfs: Introduce "rescue=" mount option
References: <20190612063657.21063-1-wqu@suse.com>
 <20190612063657.21063-3-wqu@suse.com> <20190612150910.GP3563@twin.jikos.cz>
 <4c6ed328-1fc6-610f-e63e-4ce45a605f99@gmx.com>
In-Reply-To: <4c6ed328-1fc6-610f-e63e-4ce45a605f99@gmx.com>

--NjzrrrF7sWbSjpyw4Ry7wCumqfvSVDuYm
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/6/13 =E4=B8=8A=E5=8D=889:30, Qu Wenruo wrote:
>=20
>=20
> On 2019/6/12 =E4=B8=8B=E5=8D=8811:09, David Sterba wrote:
>> On Wed, Jun 12, 2019 at 02:36:56PM +0800, Qu Wenruo wrote:
>>> This patch introduces a new "rescue=3D" mount option for all those mo=
unt
>>> options for data recovery.
>>>
>>> Different rescue sub options are seperated by ':'. E.g
>>> "ro,rescue=3Dno_log_replay:use_backup_root".
>>> (The original plan is to use ';', but ';' needs to be escaped/quoted,=

>>> or it will be interpreted by bash)
>>
>> ':' as separator is fine
>>
>>> The following mount options are converted to "rescue=3D", old mount
>>> options are deprecated but still available for compatibility purpose:=

>>>
>>> - usebackuproot
>>>   Now it's "rescue=3Duse_backup_root"
>>>
>>> - nologreplay
>>>   Now it's "rescue=3Dno_log_replay"
>>>
>>> The new underscore is here to make the option more readable and make
>>> spell check happier.
>>
>> Who uses spell checker on mount options, really? I'd expect that the n=
ew
>> syntax would build on top of the old so the exact same names of the
>> options are now shifted to the value of 'rescue=3D'.
>>
>> The usability is better with switching
>>
>>   -o usebackuproot
>>
>> to
>>
>>   -o rescue=3Dusebackuproot
>=20
> The problem is, every time I see things like usebackuproot or
> nologreplay, it's not that easy to understand them just by a quick glan=
ce.
> Further more, they are already rescue options, not something we would
> need to use in a daily basis.
>=20
> A little longer but easier to read looks valid to me in such use case.

Gentle ping here.

Do we still need to follow the hard to read mount options?
If so, I can go ahead with old names, but I really want to know if
others are OK with the existing naming.

Thanks,
Qu
>=20
> Thanks,
> Qu
>=20
>>
>> ie. just prepending 'rescue=3D'.
>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>>  fs/btrfs/super.c | 65 +++++++++++++++++++++++++++++++++++++++++++++-=
--
>>>  1 file changed, 62 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>>> index 64f20725615a..4512f25dcf69 100644
>>> --- a/fs/btrfs/super.c
>>> +++ b/fs/btrfs/super.c
>>> @@ -310,7 +310,6 @@ enum {
>>>  	Opt_datasum, Opt_nodatasum,
>>>  	Opt_defrag, Opt_nodefrag,
>>>  	Opt_discard, Opt_nodiscard,
>>> -	Opt_nologreplay,
>>>  	Opt_ratio,
>>>  	Opt_rescan_uuid_tree,
>>>  	Opt_skip_balance,
>>> @@ -323,7 +322,6 @@ enum {
>>>  	Opt_subvolid,
>>>  	Opt_thread_pool,
>>>  	Opt_treelog, Opt_notreelog,
>>> -	Opt_usebackuproot,
>>>  	Opt_user_subvol_rm_allowed,
>>> =20
>>>  	/* Deprecated options */
>>> @@ -341,6 +339,8 @@ enum {
>>>  #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>>>  	Opt_ref_verify,
>>>  #endif
>>> +	/* Rescue options */
>>> +	Opt_rescue, Opt_usebackuproot, Opt_nologreplay,
>>
>> The options have been sorted and grouped, don't mess it up again pleas=
e.
>> Check the list and find a better place than after the deprecated and
>> debugging options.
>>
>=20


--NjzrrrF7sWbSjpyw4Ry7wCumqfvSVDuYm--

--R37Q8RuYkVKfroFsezIrcuFxwg3XtYs6p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl05SOoACgkQwj2R86El
/qh8Pwf/UvoOIxlkjB/ppMLZOx7MIQDdn2DIAqiGDRhlYUcm9GF6Bxte5lsIkwjA
p/m4AenjQhtGMD0QfcvadxBaaVovP1un3oSycjKCuqyYRHY8B9HVMfAynrsdQasu
2pXxokXI0obBKWCWTXKzuXcvcRuu2XRf8pQTzoRXZoUVFKCEZGq3ZgHXG+lJQS8+
QKbYI0/qnZ/MWLRC3UnFDvKRkcNz3qbMcwznKMAtaoAR7iZv2Pp/nVloHtfG5Ftf
j23SrPLh/vYT0Zb4YcWl0fj87WQ2RhnnUy6M8Pkzo6aYvfPGTNFAI6CNJKv67CR8
S2zShuEYo1ry8nr4jXMf1rEDAgzo0w==
=PTl2
-----END PGP SIGNATURE-----

--R37Q8RuYkVKfroFsezIrcuFxwg3XtYs6p--
