Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE2D9DA26B
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2019 01:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404017AbfJPXqn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Oct 2019 19:46:43 -0400
Received: from mout.gmx.net ([212.227.15.15]:38711 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbfJPXqn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Oct 2019 19:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571269569;
        bh=93G9wbBHFqT5bB6MRGtMK6AKOE9vkugUE8Rd6tycPZ0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Z+QlkOYhDsCjzvy9aajX5sVLoRGwGewJQ0xIJOA3W5LI/elYg5xAf/O7Vf6Wh5XnF
         LwRKe5Uufa8asB6wFm54R8rckCPxtk01SIhJyI4peSk7IHMbxO7b482JXsqf0oyXG5
         OkvLJBPldjsaW2CfrZn7qSH7KPG+yB5BQENaOjBU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MF3He-1iIf1615sO-00FUGT; Thu, 17
 Oct 2019 01:46:09 +0200
Subject: Re: [PATCH] tools/lib/traceevent, perf tools: Handle %pU format
 correctly
To:     Steven Rostedt <rostedt@goodmis.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
References: <20191016063920.20791-1-wqu@suse.com>
 <20191016105456.0b8d2310@gandalf.local.home>
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
Message-ID: <ee81fc11-30ea-34d7-a19f-ce1811529ab4@gmx.com>
Date:   Thu, 17 Oct 2019 07:46:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191016105456.0b8d2310@gandalf.local.home>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WL9qWQqq5vhv0VgPsnoe6cmgmbzboSFhB"
X-Provags-ID: V03:K1:kAdkrtlk6X+MpclUHi+DAR3n7l9kFitcf56GYEmAjuXvN+8KVbE
 08heK5VUwYWQqMVV546b+BaIC0yGh05c4ebXfWNVjRhFO07ChLXkLSKFKu9ZIbY8iI6QRpZ
 BbTWt4gtVkbGOV5siGVDqC2CHdKDAU2+LizVlWEVy0UmRCvE5j48MFWfTN4SiYinWe71XCw
 AF+YXGdah+nvmksmrnJHw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5NpGs8YPGO4=:BEu1lXv1SUsmmOSbScsjXo
 nfKyXxYr8Eq9kNDQV57uSd/j8D3LERBO6gt7eV3c3HYTQr/DNGjRPsIWJaudCPkqVuswqtCKJ
 cJQeYMa3Q28+JT0gRnc/t+WQQYSfwO3gjyTuRD/tkLorWdCwqb/gWcobHqAAjRYKo/yM3IN0a
 Cja7IwOT6mYcn3DMW0ZNIAOP1pb/yWREEaxymL4aR90kFheQFEdl47Y4IIZRDGbvf6NAJntMa
 M5Ej1CTlZxhlYXT0goLR0FD1IWGEarl/AvQRR9KGfa0y7sMLPzl/+JxeqYgddbs1kGJlkmtsD
 SqLTtqFyUORwQojy5NZybCQd9jQCcEMgZzLdf+v2LWw5/dElpkbd14eW85RSUogWLX6zGqVSw
 6ScjCqfQq8GvUHGPlR5Xg1gmaD9gobewPNy01ScE0GYqwkbAInP7aFZZyFRlGwCnIFIzB/pEk
 moHs3nOw0li+sKvThKxdoa0OV2Nh/s2837h0nso7xI72HLIj6IiMca8iyMx6Icz1eaFDdhDK+
 v2TJBkCSOxy+tATn/KEWGGZA/l7MX7SBLGMpTVcTxu6xqQcCTJ4tQxrnjERWk9ahhVHaJEI1a
 gA8GuOxdqBy6jyLUHtlcl/FsFvevAtbIoTwzQQsfz3ouR3bzE0Yen2OqTOoY99RgJGuOcN4X8
 eRuiSZgNoGf61vqniU9w+g979HBCbPL2+TAXPtpcQui6mqjWA7KYOWxqfE9W+zDcB6f9fcCVs
 u76lKW6fCqECOQ+KoFNMsuwVRpH0FXPSJ+gEBKJi8l52JNif+9f0IiwU/lOOmXlWiSUUNrqsd
 s2KHcf6SsWrurJWj9dFChbnFmWCeQHmX79CBWHiVdJD0WRl/bhH49hFmGX+VDsQOlh6+rtFZO
 Adhm3dV6FOZDFz0P1H17j6xwJfoVp6OTQcykRwsq5cwOLHdiZ4NGwYzkK01W0bbfGXXVHdJCk
 cRVjOGfQtnQuWlgaK/k+rxRFkV6Xhz9fTqS6WKmqcxIZOfnO7Dl1Lxfnb/Sf5GaPi4XywSQzp
 WR40ujn+YlG61e/h5CEwyByaFcTgGoPOtAQWIOOEKLANZBMS0GlsbP8kAVejrpDIVhIrz383E
 RtsDCeCLswbLrQYTQPN1C2hQDIqdJwHxymjFXKo34eg2bwhVgu0hXBbiLdJnT2lhkEDQtQPeX
 1ysvTFXu2nVdvGZWTBODvd8xlvIlxfwMqfgulTjqguy2kRuTrHn4ImNNuXbiIKt3FPMlvNXG8
 fWL9/uvE3Ex4GYQ0SiUpMcLQ6lgmPRox8Lk4uKiAuyR1TGeIsnb29HGGmqjs=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WL9qWQqq5vhv0VgPsnoe6cmgmbzboSFhB
Content-Type: multipart/mixed; boundary="nHr6UoFpZqrBaoUwDmVjER6khOxAVyDoG"

--nHr6UoFpZqrBaoUwDmVjER6khOxAVyDoG
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/16 =E4=B8=8B=E5=8D=8810:54, Steven Rostedt wrote:
> On Wed, 16 Oct 2019 14:39:20 +0800
> Qu Wenruo <wqu@suse.com> wrote:
>=20
>> +static void print_uuid_arg(struct trace_seq *s, void *data, int size,=

>> +			   struct tep_event *event, struct tep_print_arg *arg)
>> +{
>> +	const char *fmt;
>> +	unsigned char *buf;
>> +
>> +	fmt =3D "%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x-%02x%02x%02x%02=
x%02x%02x";
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
>> +	buf =3D data + arg->field.field->offset;
>=20
> You also need to make sure the data field is not smaller than 16 bytes.=

>=20
> 	if (arg->field.field->size < 16) {
> 		trace_seq_puts(s, "INVALIDUUID");
> 		return;
> 	}
>=20

Oh, forgot that sanity check.

>> +
>> +	trace_seq_printf(s, fmt, buf[0], buf[1], buf[2], buf[3], buf[4], buf=
[5],
>> +		         buf[6], buf[7], buf[8], buf[9], buf[10], buf[11], buf[12],=

>> +			 buf[13], buf[14], buf[15]);
>> +}
>> +
>=20
> Hmm, I know print_mac_addr() does something similar as this, but this
> is getting a bit extreme (too many arguments!). What about doing:
>=20
> 	for (i =3D 0; i < 4; i++)
> 		trace_seq_printf(s, "%02x", buf++);
>=20
> 	for (i =3D 0; i < 3; i++)
> 		trace_seq_printf(s, "-%02x%02x", buf[i * 2], buf[i * 2 + 1]);
>=20
> 	buf +=3D 6;
>=20
> 	trace_seq_putc(s, '-');
>=20
> 	for (i =3D 0; i < 6; i++)
> 		trace_seq_printf(s, "%02x", buf++);
>=20
>=20
>=20
> Hmm, not sure the above is better, but having that many arguments just
> looks ugly to me.

Indeed, I'll update the patchset to make it more sane.

Thanks,
Qu
>=20
> -- Steve
>=20


--nHr6UoFpZqrBaoUwDmVjER6khOxAVyDoG--

--WL9qWQqq5vhv0VgPsnoe6cmgmbzboSFhB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2nq7sACgkQwj2R86El
/qhJuAgAnUBgOGrj6ehXZlifq7TuGi/vOwNp6IS3UbzqWa42UShPm4wDrv2CeBOz
8FBolLQ/NJYRNotWs91l76JivRLsfmNT2gxgkSImVJFsrLsZU3/nFhmyKqpkG2EY
uN6UiYLAzFjGwBQOaaAjhFNSjlcfn68NSD8A2T1wLTColdIPQnWg2F1U3mJoYCBU
iIi0AG4t6kSNvVhwKYx63clJUbrfo75rQFPtmdOzj4+9hoySg/aAtPzUOV0csLY5
v41+PuHuVCFWMF+rJVAwzTnwWBJxundD+773IBR+6lhHI7RcpIWoXfGNeuB/Bj2/
o90uGZZ0a5Fg4i/QcisTotEzy4p4Qg==
=3R/y
-----END PGP SIGNATURE-----

--WL9qWQqq5vhv0VgPsnoe6cmgmbzboSFhB--
