Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAE94D9389
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2019 16:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393902AbfJPOSv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Oct 2019 10:18:51 -0400
Received: from mout.gmx.net ([212.227.17.21]:55877 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393873AbfJPOSu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Oct 2019 10:18:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571235522;
        bh=9ke3fxs+GipSOXrqULujCNcXSf7oMXsvhH4XBUW7xVE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=FmzWaA5t2qfOo022jfIsszivnbtoKyGxTyOKeho91riEKqSHsCpkUW2m7+J7gxL4g
         leL/i6BMrMccEJuiPV2oPBM+XKYBi8ndxcHeRu/76qZWlp+cmS2qNAYm208E+lLSUV
         x7Fn6m0j7rTPlD1UrZ1KLrTYR/wxDlvMzgcSrMW0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M8hZJ-1iOt0K1rof-004loN; Wed, 16
 Oct 2019 16:18:42 +0200
Subject: Re: [PATCH] btrfs-progs: warn users about the possible dangers of
 check --repair
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        rbrown@suse.de
References: <20191016140533.10583-1-jthumshirn@suse.de>
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
Message-ID: <7914adef-b771-694f-af62-e5c4679d8203@gmx.com>
Date:   Wed, 16 Oct 2019 22:18:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191016140533.10583-1-jthumshirn@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Q8QRPoUkJY6kSEWcwjcb0xcuZJIR2LhbF"
X-Provags-ID: V03:K1:ZjXHSTfRu+wNfOTQ7sBLHgrt2woDG1PGEBZIkpft722Tp7mB7zj
 pfP20gU+iawHv0F2hpGC4SV6YLlZ0SiMCAbn4/y+oSwZq/DHtqdX8dFTpzINwWYZrvDTCOY
 sT3YRaFzVUm+17ZEqlhlqSWterfHJOFzhoJv92fEuo+SOmhjGl1Q0U9DwW8Z+pF4cT6rFSo
 8QlRTkkp13ZQuT9I2aKGA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HAOeK5D3ASg=:RWbBfUN8QNOmlUj3Ox5piN
 kXfugeOb8JGDmzkpgtr081t7pPjqBLm8ohroCx2XPWvK/fqFc99PtIVbgEB7l3hBbMtMZ3QDb
 OJ/2bmQ0AhMWsMeQyqBM9T4bJJOXZrliK3NHTabF4Yr8Tns/IcHMYrK/L+PK7saXwpQbAZWqh
 UDnzTHm5l8Qfo3Y3POR1hxiOsHwv3c3nvMI66tba/ba284K+HqjY2Y9R115j9q/IhDsuzbUSG
 MUIe+Rgw/BFbv8G6aoBgjq97EcBEBdg/RZYDffRjBTAoOi8BdcDX8IKlDWfXEVomyErxRLXCl
 pgvzLVa+JNGguen9rYeiCn2gkAO9InmE6ZlbxMUzQDPBDIzWHL9HjAsEFqdq1qfDRCzJ/tvSF
 wVj1/P5ZnB7E+PnZBdaEH4N7/c6FTyBPiGbveAtWoNgX1jY4i2mIr9qIUxLZeRc4Evy1r7QUg
 VF+oWM2AuvOYyWNQp0IeksmVsJ7R+XSoPoAQmP7PkMQd2u6OCyuPiw4vPIxAQviatXoZoVDjy
 U+jtNE/rl/e9NKFBk3GfxcXUbso6nESS6yEe5pjlC8cvHH8f/imkXgGmDWXs4AkkYlj2pgsaj
 OgtonPTlNCa5EdCn8JiKbVCFiaXztPbl9nulSGomMHvfJP4WLQexhVQ0IxJvrnB78wB2GBOjL
 ClA17VgGli97NiolafcTGbBPKjMmGM0qI9LWldNOjsnjMO5o3f/5Fw8pZNR4EvBXOExdAEw/b
 zUaxcUNuSq9FiACo39HANWdROYH9b2cyNF1Y0TinsfQ5AjEW8XNpV/0ezbOYac10IjaQ/UebC
 RIzcaGGRPv1YGMasFgzWq7SugLY1djtFXcfj6EORdkRRrkdXRHL7ynZc/dYEfmjV1P9qDWNXh
 CW3m8lpgKiiL6tkourgNTXX43zNxVzvEHioYSOkl5JIC9Y07+GFZZe0OBj6PLikaV0zXhYdEC
 M99cK4KBUXWJsvPa/LjhLef+40SJ4WhBq0TzKXatZwJvPmfseRtevg2B5mAgDxtjNtGUCWr1q
 gx1XB3b3iJSeHg7IFNLF/xCxHL8uYCLZ39URsC6pnw0TMJVcivM23uK3DwdmMJ5H3GuKh7G1O
 WCKOaAq6qYPqmjFu4AJMKeDeun3hUF30AJssMFo4N2BplTZGEq0tyDZ5ZDIC2NuSHaw8tU2j+
 W/Ny2fDwrjYDPxp6KzzKDaXIowFSZGGlI3k8347GOAbYzkgkVS7NeNMq3IZbD1UoMZtuDa0Qe
 o4prANR28BIyz/aZkNJ9Q3bZsrT81K4TmEJE1RIMSgVeaChqy8hdgcdybBOk=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Q8QRPoUkJY6kSEWcwjcb0xcuZJIR2LhbF
Content-Type: multipart/mixed; boundary="wpxQ0M8dCziO0bSNUYwPOhsLXqQR8nQIQ"

--wpxQ0M8dCziO0bSNUYwPOhsLXqQR8nQIQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/16 =E4=B8=8B=E5=8D=8810:05, Johannes Thumshirn wrote:
> The manual page of btrfsck clearly states 'btrfs check --repair' is a
> dangerous operation.
>=20
> Although this warning is in place users do not read the manual page and=
/or
> are used to the behaviour of fsck utilities which repair the filesystem=
,
> and thus potentially cause harm.
>=20
> Similar to 'btrfs balance' without any filters, add a warning and a
> countdown, so users can bail out before eventual corrupting the filesys=
tem
> more than it already is.
>=20
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  check/main.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/check/main.c b/check/main.c
> index fd05430c1f51..acded927281a 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -9970,6 +9970,23 @@ static int cmd_check(const struct cmd_struct *cm=
d, int argc, char **argv)
>  		exit(1);
>  	}
> =20
> +	if (repair) {
> +		int delay =3D 10;

Any delay would make the selftest miserably slow.

And in fact, recent btrfs check --repair is no longer that dangerous.
Sure, it still can't handle everything yet, but at least it's not making
things (that) worse.

Deadly bugs like the lack of flush/fua is already solved, so I'm not
100% sure if we still need such a big warning.

Thanks,
Qu

> +		printf("WARNING:\n\n");
> +		printf("\tDo not use --repair unless you are advised to do so by a d=
eveloper\n");
> +		printf("\tor an experienced user, and then only after having accepte=
d that no\n");
> +		printf("\tfsck successfully repair all types of filesystem corruptio=
n. Eg.\n");
> +		printf("\tsome other software or hardware bugs can fatally damage a =
volume.\n");
> +		printf("\tThe operation will start in %d seconds.\n", delay);
> +		printf("\tUse Ctrl-C to stop it.\n");
> +		while (delay) {
> +			printf("%2d", delay--);
> +			fflush(stdout);
> +			sleep(1);
> +		}
> +		printf("\nStarting repair.\n");
> +	}
> +
>  	/*
>  	 * experimental and dangerous
>  	 */
>=20


--wpxQ0M8dCziO0bSNUYwPOhsLXqQR8nQIQ--

--Q8QRPoUkJY6kSEWcwjcb0xcuZJIR2LhbF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2nJrsACgkQwj2R86El
/qgnpAgAmJzMMe6bhvgAfIpQ8IzbgBnQ+sOfs6JfGuR0+1+QyARBvfwM+amglWVo
wwz73o9SB4SAsctrsBC5h/Dv3htMcxIUZJWYmRovXUZdv53A0ko7g03rut4LmKSs
XCJoHoZfF6z9TE4P04w055yBdbtN+yO76Nyrc24zew5/MJQc0WZHk1+pFoBeMfWL
1azNne54OuW1Usok0Y1iUN1ys6qYlFBYbmIlpGLzu9W5XFCRrDNXwuIPeYKz0zUt
J95FKPaIfuFmV9CTIkSfI6ano0QAbC5hFOb1wVL3yrIpkdOO9fFwWyJcmQIh0fZA
GX8J+VsuEH5UTu+fAlYh8y+fROOQqA==
=Pk9i
-----END PGP SIGNATURE-----

--Q8QRPoUkJY6kSEWcwjcb0xcuZJIR2LhbF--
