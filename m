Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 806BA8C5AA
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2019 03:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfHNBvk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Aug 2019 21:51:40 -0400
Received: from mout.gmx.net ([212.227.17.21]:35453 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbfHNBvk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Aug 2019 21:51:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565747473;
        bh=obISN4I+r6aNSC+AL+6O3rwYcCsjQWpghyoS7nbegNE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=IKunhuJuZNiGg1gKr0G6tfpKv65X2KB7ikpamG4NZ/BeXswengl8f6pbM+O+UwNea
         RPV++jYsCjQqKHWJg1NmueLHWtsJh/s8WvD3iBgEsgX76R5ZkPWP8Ob64QJ5zd78N/
         MaKdLNbCRQn4hLM2bOKg30eMw9j6JNtXBu6pAeKU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx103
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0MUYiV-1hnzQh2ztj-00RKIz; Wed, 14
 Aug 2019 03:51:13 +0200
Subject: Re: [PATCH 3/5] btrfs-progs: qgroups: use parse_size instead of open
 coding it
To:     Jeff Mahoney <jeffm@suse.com>, linux-btrfs@vger.kernel.org
References: <20190814010402.22546-1-jeffm@suse.com>
 <20190814010402.22546-3-jeffm@suse.com>
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
Message-ID: <698f8ba6-d00f-b9d5-41e3-620d821a0f1e@gmx.com>
Date:   Wed, 14 Aug 2019 09:51:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814010402.22546-3-jeffm@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="OgjtVNFw2APjv9YRn9oCopVrMEjfrObK5"
X-Provags-ID: V03:K1:tX7IkyB9jHNrI+qAamjxvcsJPb5IS9ywLHr7uDpidjai/xioSOq
 KVoj3DYUJv608tEcGFvIB34520NoHn4gcDtYmWthYoHABtH1dO/aSoFOkdk2xvooqCJEPO7
 ZnMonS2NjiMqZ3y2+mi7brUvRRx04YtM75crrupqysiaArZet1FSOfNiDTPy+RDrKNzQI4S
 SUGdmsAoL1oi6ng45o82A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Xa53cJqGO5U=:n9CYZvvRqyp1CiL26DrnfK
 hrmsleInIUQEo/APCIPugoVe+BTL0dbnWk7nvNhiUyhEXFJANn2S4qGErh9nirSiLf/2IaZNp
 Ja8S442c7QQWnEvPqD+HH9KZTIX9I2XOpw1W1CR6fFrrJ+xH04XIp3pG60hijF/Zu7dGdpzl+
 z4dCGwkPLIq2gkx2yrZnMWzDgAGiRaLhdHpCGjx0TQ+fGaTEhZaQhizZM5L44yf3mV51+tNWd
 WT09Yg97z6iXqCXzjhPiiYLoZJRLXLa/AP7n+Z+W1f6WWy3r/WUHLC91CKkdoWXJ0LgVvjmOb
 ZfiK1bnpn8eyL7UPitDUjeCtdIaQXfB/cZgTgrpC11euXC1+m+siAzyxqameiqSlg7ItBHHc+
 4YuxM4UXs9F4k8UnJVIbD/JgTuhxkEOzzgmwQekwcqn+s5V7xU22Cy/+d0wK2K6wBkDt6wDSB
 gu4Pa9DAr2/QfgmKR4837Nyuq2zgUX6R8h27oisVGQetzNz/7z7cgXPC1TIT/yhpuesYHhbEU
 o+Rd5Q/KZBzdvZzrrGiexrN499H9Qf2P7hUdPBQKO2GNRGG++bSixKzK21H80wn/gRG9mOm1B
 8WT6g9/g9RtxVvDZbzhLOGizBIUNzdfxzVAaiOt0SIAddalDceig1Noq8+8KdEaVWfgQ68LHs
 jumUBNgd5Eu5oxDUphWlR8P1Lzc03Uushm08m41ep/xqBJ9lMAwr9MFBcsXlmMh5zAXNLWrUY
 1GFvxAM4suXXMdP6cvG1i8V938j0hC0n/Dzx7F4twMayBtrZPHwrBmwbdRa23jteMo1BqvIXT
 UPD4+ZPM+F/ppm6T/1eR84t2OgXBns2NTLzjXCdJBImh6TU3gC9makM7r79czTHVlERVNiuZP
 6VbC0kWf/6taKnsRR4K0B2w8N1iSg6RqvxQYMuZuOw2PgNCD+IE2Mypu/r09JB+hr/NBdQjkm
 y54s1gRp5qa+lN9jJMzzD1kZkFi2S+y5GnBaoUpAqObOgwChyZ1bxCEuFq29ggJzD3egSCJQ2
 NN8xBPDl2xoq0nITk6KQeybM5NZCgDRM3moYxV7OThdwQ/Sa4xinqNuZs5SYtK9xSD4X8ExWi
 ZgbqW/+k+LP5qTEhzGuC6PEPAew5qpjy+ULJN3OH3mM10DP6x/jaXfCoQ==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OgjtVNFw2APjv9YRn9oCopVrMEjfrObK5
Content-Type: multipart/mixed; boundary="ctQ1oeBXNoXSLKAIgD1Ss6rDvCMaEWdCj";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Jeff Mahoney <jeffm@suse.com>, linux-btrfs@vger.kernel.org
Message-ID: <698f8ba6-d00f-b9d5-41e3-620d821a0f1e@gmx.com>
Subject: Re: [PATCH 3/5] btrfs-progs: qgroups: use parse_size instead of open
 coding it
References: <20190814010402.22546-1-jeffm@suse.com>
 <20190814010402.22546-3-jeffm@suse.com>
In-Reply-To: <20190814010402.22546-3-jeffm@suse.com>

--ctQ1oeBXNoXSLKAIgD1Ss6rDvCMaEWdCj
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/14 =E4=B8=8A=E5=8D=889:04, Jeff Mahoney wrote:
> The only difference between parse_limit and parse_size is that
> parse_limit accepts "none" as a valid input.  That's easy enough
> to handle as a special case and lets us drop the duplicate code.
>=20
> Signed-off-by: Jeff Mahoney <jeffm@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>  cmds/qgroup.c | 58 ++++-----------------------------------------------=
-------
>  1 file changed, 4 insertions(+), 54 deletions(-)
>=20
> diff --git a/cmds/qgroup.c b/cmds/qgroup.c
> index 59b43c98..ba81052a 100644
> --- a/cmds/qgroup.c
> +++ b/cmds/qgroup.c
> @@ -159,56 +159,6 @@ static int _cmd_qgroup_create(int create, int argc=
, char **argv)
>  	return 0;
>  }
> =20
> -static int parse_limit(const char *p, unsigned long long *s)
> -{
> -	char *endptr;
> -	unsigned long long size;
> -	unsigned long long CLEAR_VALUE =3D -1;
> -
> -	if (strcasecmp(p, "none") =3D=3D 0) {
> -		*s =3D CLEAR_VALUE;
> -		return 1;
> -	}
> -
> -	if (p[0] =3D=3D '-')
> -		return 0;
> -
> -	size =3D strtoull(p, &endptr, 10);
> -	if (p =3D=3D endptr)
> -		return 0;
> -
> -	switch (*endptr) {
> -	case 'T':
> -	case 't':
> -		size *=3D 1024;
> -		/* fallthrough */
> -	case 'G':
> -	case 'g':
> -		size *=3D 1024;
> -		/* fallthrough */
> -	case 'M':
> -	case 'm':
> -		size *=3D 1024;
> -		/* fallthrough */
> -	case 'K':
> -	case 'k':
> -		size *=3D 1024;
> -		++endptr;
> -		break;
> -	case 0:
> -		break;
> -	default:
> -		return 0;
> -	}
> -
> -	if (*endptr)
> -		return 0;
> -
> -	*s =3D size;
> -
> -	return 1;
> -}
> -
>  static const char * const cmd_qgroup_assign_usage[] =3D {
>  	"btrfs qgroup assign [options] <src> <dst> <path>",
>  	"Assign SRC as the child qgroup of DST",
> @@ -455,10 +405,10 @@ static int cmd_qgroup_limit(const struct cmd_stru=
ct *cmd, int argc, char **argv)
>  	if (check_argc_min(argc - optind, 2))
>  		return 1;
> =20
> -	if (!parse_limit(argv[optind], &size)) {
> -		error("invalid size argument: %s", argv[optind]);
> -		return 1;
> -	}
> +	if (!strcasecmp(argv[optind], "none"))
> +		size =3D -1ULL;
> +	else
> +		size =3D parse_size(argv[optind]);
> =20
>  	memset(&args, 0, sizeof(args));
>  	if (compressed)
>=20


--ctQ1oeBXNoXSLKAIgD1Ss6rDvCMaEWdCj--

--OgjtVNFw2APjv9YRn9oCopVrMEjfrObK5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1TaQ0ACgkQwj2R86El
/qi3BQf9H1HSehch1RLbayCNQe7l8HuAwB9qKK4qNa8ONOaaoSbotky3HZOfL6t7
DEbrmvUcJk2Pn2uGj6NwL7QGY9XuIIG8ndOxJcoLY8bkdJDLYAg3bPUKF7xrL672
MgSRno7c9E68EEfkmH9OV7mzAdNJe1R7Ph897A1/1kvpfQ6GuwCVaUqAmsIyY1uB
HD0Ad6UCSDQzL6vLt+2PoXEtxzjvl+FusXhi0nb+wU/krqV5oK3oMwex7Mdto+/p
nYXd16NcuoW4uu3MOFws6hCU+vwwcMYlu8ATUgj5xsvTtQYR/+8Hqg31Yn1Trn/D
qU+G6khteAq0OEldboFsncY4WiRDkQ==
=akUW
-----END PGP SIGNATURE-----

--OgjtVNFw2APjv9YRn9oCopVrMEjfrObK5--
