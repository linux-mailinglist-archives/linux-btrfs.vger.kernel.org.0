Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45396DEEAF
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 16:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbfJUOEB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 10:04:01 -0400
Received: from mout.gmx.net ([212.227.15.18]:47453 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728263AbfJUOEB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 10:04:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571666610;
        bh=Gh62ZRWrEQfpttK1cQfv1fPmjIgcir97g+Gjh7991rk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=EHb4o8abw0e+tdBXJSHO5SKyui8CHIexPXm7oVlIs8bVCz2Jr5qwqBuHZMF7G1rY4
         yXaf64n7q5PhQZREoYdcfaKUKYKv5TGPcr4PLQb9NWB+CPUqUEG3bR8qeuLPnQFTrQ
         C2j3Szj0TdB3GlBfDIgGGcxY7R7NDpkonur5VZl0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M6lpM-1iOB6l0ZR8-008NHF; Mon, 21
 Oct 2019 16:03:30 +0200
Subject: Re: [PATCH v3] tools/lib/traceevent, perf tools: Handle %pU format
 correctly
To:     Steven Rostedt <rostedt@goodmis.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
References: <20191021094730.57332-1-wqu@suse.com>
 <20191021095625.2dfe3359@gandalf.local.home>
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
Message-ID: <3830b0c5-5b76-36c1-5e3a-64dad62f76fb@gmx.com>
Date:   Mon, 21 Oct 2019 22:03:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191021095625.2dfe3359@gandalf.local.home>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="moQDoizBtB5wH5BlrzdoB0yVAZIndH9Fk"
X-Provags-ID: V03:K1:50EZ4CVkH+Rzv6Ny9bi6FXCnae8tq4uDOwgingpD5gG3eXf/O1A
 zzcS3AaO8lCcRXehb5cyGwCsr2lzeBtZzk4yjcC68+Yf29Lej9R5hW40SYKnRN2CFAhIaSq
 a/DdSESssW8P7Xg3ZUgQpKwhHrcG4EJSRH4qUepO94drzCGGvtHlt9L41lvM2QLo39f8mxV
 X4D/jAav5toXppcvHEgdg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Su6TNY/CNuc=:91SOV2C4AkvylX2bbOUp8q
 W0RuLWp71NrXMLkp/F5dcYgJ3Fiq/kloAKvJsyWYqPxQ4YJv9caKFDDIJ9FoX6RCuFIw5mpZM
 fze/xvBi1zgfhLPAS7/J03NDDheThtrh/n0g6lVKEapjUAI0oT/V0dMbxksnf0oXGW/XuXlpr
 LQD+pqMyD4MagE5cwnYPaWIPvce3kEsgfTCWGSVX4ICNVTAE4HUZEqMDeQCp4tY9tcbBZ5wF6
 jchFMbCxfZimid35lybWEUJT5uYtghAEHEGJtsuoU4X6z4og8+Y+SlbbKAeDDEzEM8ljeJbFT
 IRXol/I6p1YqvLLFWIdeyZb/i+IDlxq0bTFZUrarGPz8V28McNWW2TJbr+nC7VcjXkLSxtWcu
 nIfdukp0PnetOJBnpdYnR+1c4s6sTeJO07on4JgwV67g6eHr0cS0OhkxPFM0HfdXE3k08NpCV
 u5uvUlsdibXvVA+vvV5v6efb4lcM4fyh6Txt9C7a2zyPAdWs/1SbM7Z3/tybaslX5rdWXW+gu
 qMz1QlwFpCDunqYzQ9zheixi8TZH/i+9UpeBsWnauCWhX3ZqCVWoRgTmvn6BSgGN82fwFaNku
 NaDdX9joHp+EeTlUTGILExLrLlbGjOPjsSJy3VoBttXS+N1vZjS8uEhhmfIb05mqmnfe9SfM0
 /5sLtxOAgzpkiwD35IMRAsn3Ko/7f+RCx+8hx0odBpKAuKDWDAKKEnQDleiMOaCbM+bTeXCbo
 p2WiZJqcMOcgWbYPPziuENcJRp+h9lKTldB6xAlxzh0Ae1rce/X8FbiKLNz713uLUgRTzcqqw
 JN55qgfYawU5n9+NZLpEIpPfz8+/SlmmSKOXihREj22/Fb3HkanPqBB86IvzC9gIV08FXizkj
 Jc7HYlkpY1bACG3sN/vnio7g4Gqh5+QenDpxHsBZxL9caix7zJYQ2GKS1hPmVBOYevOc0LbYK
 UTCxCPrPl8BTS/e8JhcWjhhcOQV3pg50njdYcaehfqKmwEXXn/70qjD8WTrdNeEpmfq6KOZJ+
 INvF5qg73zR3yzq6RNx5/ggUSs2LggfvvZQdy3mXwpIMHItjRkokxvx9LnhHztykc22/MF9c5
 mXxcYatgNHPpNrQNRZMvi8i46n9YiSQs3WCSZCrk92mo1rcb5UsxNPSoARZcLFtrhQZG73KR/
 0f1PtvokeGsd+r+/FoXryHWPNUy4FRLZk58f35Z03+QucRxkduEgSJeo8A++eETgGuQNoLU7u
 4glvCtDa78hSw/KYEafPsbhNIadU2MUgiisj4wolDt/JwaHZB7qz9ywlY9M4=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--moQDoizBtB5wH5BlrzdoB0yVAZIndH9Fk
Content-Type: multipart/mixed; boundary="plhOcTcctBzatdu5pLGvwzI4er56u2kIn"

--plhOcTcctBzatdu5pLGvwzI4er56u2kIn
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/21 =E4=B8=8B=E5=8D=889:56, Steven Rostedt wrote:
> On Mon, 21 Oct 2019 17:47:30 +0800
> Qu Wenruo <wqu@suse.com> wrote:
>=20
>> +static void print_uuid_arg(struct trace_seq *s, void *data, int size,=

>> +			   struct tep_event *event, struct tep_print_arg *arg)
>> +{
>> +	unsigned char *buf;
>> +	int i;
>> +
>> +	if (arg->type !=3D TEP_PRINT_FIELD) {
>> +		trace_seq_printf(s, "ARG TYPE NOT FIELID but %d", arg->type);
>> +		return;
>> +	}
>> +
>> +	if (!arg->field.field) {
>> +		arg->field.field =3D tep_find_any_field(event, arg->field.name);
>> +		if (!arg->field.field) {
>> +			do_warning("%s: field %s not found",
>> +				   __func__, arg->field.name);
>> +			return;
>> +		}
>> +	}
>> +	if (arg->field.field->size < 16) {
>> +		trace_seq_printf(s, "INVALID UUID: size have %u expect 16",
>> +				arg->field.field->size);
>> +		return;
>> +	}
>> +	buf =3D data + arg->field.field->offset;
>> +
>> +	for (i =3D 0; i < 8; i++) {
>> +		trace_seq_printf(s, "%02x", buf[2 * i]);
>> +		trace_seq_printf(s, "%02x", buf[2 * i + 1]);
>> +		if (1 <=3D i && i <=3D 4)
>=20
> I'm fine with this patch except for one nit. The above is hard to read
> (in my opinion), and I absolutely hate the "constant" compare to
> "variable" notation. Please change the above to:
>=20
> 		if (i >=3D 1 && i <=3D 4)

Isn't this ( 1 <=3D i && i <=3D 4 ) easier to find out the lower and uppe=
r
boundary? only two numbers, both at the end of the expression.

I feel that ( i >=3D 1 && i <=3D 4 ) easier to write, but takes me extra
half second to read, thus I changed to the current one.

Thanks,
Qu

>=20
> Thanks,
>=20
> -- Steve
>=20
>> +			trace_seq_putc(s, '-');
>> +	}
>> +}
>> +


--plhOcTcctBzatdu5pLGvwzI4er56u2kIn--

--moQDoizBtB5wH5BlrzdoB0yVAZIndH9Fk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2tuqkACgkQwj2R86El
/qif8ggAmG8rkUoHgXK75G9Pc+nBRSDF6dFfKfaskRR4ccKDxF80qLzF/QQgk5yg
0/2ZabXrEnrvwNEFBWsjpj9RAnoBpuasWyQkoGucauvWj/8KtWTlAbKxJ291N3Sw
m6Z7AZrrjZaUfhTCk6KQncMggvAR/gdKMrHvj3ic9+sjCracEMxiF4FkeoRUVXw3
ePUWyAHnF+pyEj+wyZaXohf1K5kghUjz9XYsdA4qtIQEMpKznSq/MM7azdu/hIzz
3fwWa10FShy6R/hyjY8UV1zjen5gVAjrw7qWX+MM15BYZknefS6CpkmGmU6TnT9W
asphoDGOHasn/X5oryh8981KpI3w3Q==
=lAZZ
-----END PGP SIGNATURE-----

--moQDoizBtB5wH5BlrzdoB0yVAZIndH9Fk--
