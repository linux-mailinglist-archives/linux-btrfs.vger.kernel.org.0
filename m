Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22201DEF9A
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 16:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbfJUObV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 10:31:21 -0400
Received: from mout.gmx.net ([212.227.15.15]:57677 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729250AbfJUObV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 10:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571668244;
        bh=EePPw+wrh+Gc/zgy4MR8TD7Xy4I5/BpREhRywY2t4fs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=a2nc2y1Oc4PwOayL0dw0svpA7MPfwTFJR8hqHF2Wf4AkRRv8+kdFYnieR9qkl1jOK
         zAOQI5nsV+yoPeE3dBopf6tEmsJewO096gZaMiQxni28mgqlCw98bjozOAKQQqmQ7a
         R6WQuHkEXkS7+JyHEmyQWdQLyoucqgo7aWqOaRuQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MTzay-1iVsOX3sNG-00R08p; Mon, 21
 Oct 2019 16:30:44 +0200
Subject: Re: [PATCH v3] tools/lib/traceevent, perf tools: Handle %pU format
 correctly
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
References: <20191021094730.57332-1-wqu@suse.com>
 <20191021095625.2dfe3359@gandalf.local.home>
 <3830b0c5-5b76-36c1-5e3a-64dad62f76fb@gmx.com>
 <20191021102408.3bb4aa8b@gandalf.local.home>
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
Message-ID: <6bc13ae1-9f26-afaa-ddfa-f1dd1cdcf6df@gmx.com>
Date:   Mon, 21 Oct 2019 22:30:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191021102408.3bb4aa8b@gandalf.local.home>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kRK75qY8XO0KPvDdga5YiYwU861NrlrYq"
X-Provags-ID: V03:K1:hU8tYSnAS7/A+mZdizc8L2PLkMa9cCBUtY4BOSl7sLhuL3lQ/IL
 MQkVBhZxvpqQzoE790JDBkXWuSKvFr1DIVQCR9ya3p3Y4XdaxlF/f6UZmpMOKjlzC8+An86
 LnLXZtqWIs49EuBJlnwXwWswB5ThSpJJ51GNoGQSQqEvOcNHCN9mBd4yTtF0TJNqf5s+oc5
 3FNpaAg3/u6E/YxVV08Fg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JPH7HyLhsSk=:v5VhWjh6oBSMew2wHp898j
 I1xwW1zFVgoYPrEe1/eLyJNuecF+sPAKEGKqNQYlb9JrK7Rm8sQs0bmJhgCoZ90nSiCRw1fB1
 BkmbFosFAsUGNfxaNxUTwSqEzQ9gUWyUg1ZJDXzI5Lj47uXCKYtIYYWx+qbIMLeUfSuXP66Fq
 9JDo1NpWU/3xdOID6XjBcoat/CjPWvS77AszLzHhadfYZnjzLCtovDcZsEkVnYVIaO/wxtftW
 KeOP1s2oj/lNapDdxKM/ANiZ6ARoS0RW/Kk6Zq6Z+1h4bp2KSxDWpTqF7Y1P0nF5jpjcuEEUo
 lMAc8hyXnG/PuqYFl3Kl2o6FXcW2UACy1YL8hCvVIP/p+Suv/ACWLl7U55qDWOdjFcfxhtu1B
 79ubMZK0lIAdJud5J3GugFLqvQO5xG/sgQBYLfdaWt2PAM0ipuF6Ify72lNb3VMsngkNnEqp7
 qqctG/v3WzIUOaIRBgOPyhrm8CDpxb6QDw3jgU5mMt61pI+Tr2ApV0k1M9Y6jk9sTpDi3lRjn
 Q8463l4RtZzQH62obsYrL3pIQqNaZorr2AM1raJzuDiqUoK3Upz4QQYPlG3lpRUzeGwdgHy8z
 /kd9Pa+O3QPD/6sQsgrD+IHW8XZbgxAq5ttgnEeZ3TgZzHDkE1OIcMgHHmo6mHofQHjNyhGTr
 3d7sTmq3Stb+i7PtCUfrBBer2E69BY7oWqS9wFciDoNprznyTrmAAdB7nTS2328g9K+poaqIT
 nfAhcmWVQP9eIF3xHgs8rX5ZIYO/BR+yeNSg+cQf/Fk8mXYfOJ7pw9Z451TmKOBfG7PlJMGR/
 oaKKmWTzzgIaZLCS87MJGMZhtoI52ZSS1PSO5qP+WkNZ8d48TE5Crh+INIJPx7NpLNplGb1Cn
 zsatHbeBDKiK2ashRay1TUdPYQg20I0a1Aw6vcKrkvXsyWdZM4ocBsc9nNulDfaE7/TAy03uy
 Jk+9wxbYznPVE80ciW59+S13PRABf3H08xNZn2cVnL6arKNYuwFj4m1s8iqtgGXVB71ZrvmvX
 E2syIVFw9Vqzthj/v2rsJnOgjdQLi3PKZAy6VgNGfS4/6GXDwFnVzZDRauLAty84LKVKzaS5e
 j8bAyFv7XOj7RNTGu4k10tsXGd2V0eWoN8WMqoJrCtcvYQvSRUQuqu113+nE9Cp0S/ZW1/pU1
 4CO1E8JKkOiwbmkoujPyyafg2/yW+fa98zw3A/kE51vLhH8hPIbweXmTxDRNKG8A8udev14sY
 Vxz9CsjrrTgwPPy1EyuUevv+h8WjNV9G7O/jwFXVsRapXqzs+7cjqsBrU/wc=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kRK75qY8XO0KPvDdga5YiYwU861NrlrYq
Content-Type: multipart/mixed; boundary="0UORsGsGef7r8Jf3kZC5RSapt5z05VLV0"

--0UORsGsGef7r8Jf3kZC5RSapt5z05VLV0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/21 =E4=B8=8B=E5=8D=8810:24, Steven Rostedt wrote:
> On Mon, 21 Oct 2019 22:03:21 +0800
> Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>=20
>> On 2019/10/21 =E4=B8=8B=E5=8D=889:56, Steven Rostedt wrote:
>>> On Mon, 21 Oct 2019 17:47:30 +0800
>>> Qu Wenruo <wqu@suse.com> wrote:
>>>  =20
>>>> +static void print_uuid_arg(struct trace_seq *s, void *data, int siz=
e,
>>>> +			   struct tep_event *event, struct tep_print_arg *arg)
>>>> +{
>>>> +	unsigned char *buf;
>>>> +	int i;
>>>> +
>>>> +	if (arg->type !=3D TEP_PRINT_FIELD) {
>>>> +		trace_seq_printf(s, "ARG TYPE NOT FIELID but %d", arg->type);
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	if (!arg->field.field) {
>>>> +		arg->field.field =3D tep_find_any_field(event, arg->field.name);
>>>> +		if (!arg->field.field) {
>>>> +			do_warning("%s: field %s not found",
>>>> +				   __func__, arg->field.name);
>>>> +			return;
>>>> +		}
>>>> +	}
>>>> +	if (arg->field.field->size < 16) {
>>>> +		trace_seq_printf(s, "INVALID UUID: size have %u expect 16",
>>>> +				arg->field.field->size);
>>>> +		return;
>>>> +	}
>>>> +	buf =3D data + arg->field.field->offset;
>>>> +
>>>> +	for (i =3D 0; i < 8; i++) {
>>>> +		trace_seq_printf(s, "%02x", buf[2 * i]);
>>>> +		trace_seq_printf(s, "%02x", buf[2 * i + 1]);
>>>> +		if (1 <=3D i && i <=3D 4) =20
>>>
>>> I'm fine with this patch except for one nit. The above is hard to rea=
d
>>> (in my opinion), and I absolutely hate the "constant" compare to
>>> "variable" notation. Please change the above to:
>>>
>>> 		if (i >=3D 1 && i <=3D 4) =20
>>
>> Isn't this ( 1 <=3D i && i <=3D 4 ) easier to find out the lower and u=
pper
>> boundary? only two numbers, both at the end of the expression.
>=20
> I don't read it like that.
>=20
>>
>> I feel that ( i >=3D 1 && i <=3D 4 ) easier to write, but takes me ext=
ra
>> half second to read, thus I changed to the current one.
>=20
> How do you read it in English?

How about mathematics interval?

i in [1, 4].

It looks way easier and simpler no matter what language you speak.

Thanks,
Qu
>=20
>   "If one is less than or equal to i and i is less than or equal to
>   four."
>=20
> Or
>=20
>   "If i is greater than or equal to one and i is less than or equal to
>    four."
>=20
> ?
>=20
> I read it the second way, and I believe most English speakers read it
> that way too.
>=20
> It took me a minute or two to understand the original method, because
> my mind likes to take a variable and keep it on the same side of the
> comparison, and the variable should always be first.
>=20
> -- Steve
>=20
>=20


--0UORsGsGef7r8Jf3kZC5RSapt5z05VLV0--

--kRK75qY8XO0KPvDdga5YiYwU861NrlrYq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2twQ0ACgkQwj2R86El
/qhFVggAniuiBCKU6wwng1t05Zuu0KgcKKLyevm5nnlJ0CyjnD2Mr+CSrWW7sBPS
40XB6VK0hAuanH3CYSCEiChk0SeTbgfmV5J6tW5R5IlmeeWU/3jJPWI84x6GSOV3
Ey/UilmJt3kf1MvG2Cxh0looif1H1NMSBRlg9dOkzx7xuopxWTa+bTZlYqPKZSz8
ZY4l3LnHJ/OMZn1arg+KqEdUnaKLz0oFDZ3d7uB+oe3eScr4qajC4nxXtMRVL0Pk
Lhz/GxlyXwpZds7WjUXtntts45/asZAUPlgUJfA/DG5dt9s+lVgwWvNi7pab1Lzy
rr90lgsqXD6kFp61ncXaVSHMdk5ZMg==
=rqfk
-----END PGP SIGNATURE-----

--kRK75qY8XO0KPvDdga5YiYwU861NrlrYq--
