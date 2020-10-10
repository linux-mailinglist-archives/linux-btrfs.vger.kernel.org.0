Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97298289CD2
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Oct 2020 02:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbgJJAyn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Oct 2020 20:54:43 -0400
Received: from mout.gmx.net ([212.227.17.22]:60391 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729082AbgJJAfs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 9 Oct 2020 20:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602290092;
        bh=ey+L/r99umsX7aY3OXaPct1ijObG1XE1Ur3EKyFIts8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=io7zy2vjPUIE7qQ3RqDIOj2k0znUnGFRVYBEvgDBFlpiKMeKEY57HNuWP+XmgAV8B
         u568+brzhN7QENU2Nv2HQEYrRVieqwCzL4MgfQs59xLVoY+8E0Ym/UecWCwor2afk4
         b+1/nizrTu/ZFFhZjZ5VztE+aSR9M5gtwoU06sis=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M89Gt-1kVjoW17rf-005FWe; Sat, 10
 Oct 2020 02:34:51 +0200
Subject: Re: [PATCH v3 3/8] btrfs: add a supported_rescue_options file to
 sysfs
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1602273837.git.josef@toxicpanda.com>
 <8ac207c64e2917d7980570e6c9f696e234baf070.1602273837.git.josef@toxicpanda.com>
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
Message-ID: <4483b815-3482-2857-a8e7-b0d0991da7d1@gmx.com>
Date:   Sat, 10 Oct 2020 08:34:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <8ac207c64e2917d7980570e6c9f696e234baf070.1602273837.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="uYfnpr6pbdWvc3XxVt4Ok9cSpMP4CeBi0"
X-Provags-ID: V03:K1:0qrzWS6wZDZP2SYQH6RrRxR8Hjo+yK2aZyYfFAAIG1dLNbA/FK4
 ISFYm1syyOYVePT6gTWvYzsQ8p/iPxF2fOWxdFrkEXTqlbXfcozdbAmqB9WAMqyfqueuRNg
 65R2NW0s/pOkBQotYHrPZnm5C4RI1OV+ChJplBOTcBJrkOsiyOnnPfoQTc55yEq2gfHhrhU
 +6GQU71GG76+jU7winkZw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TUziTEHIius=:Kz3BBHI7nAHdthJqCH8/3G
 HlUo8ZwESVrP9OkKCj2m+vFXdagXiABhINK64TV8u7Z7GG3m93doxYpe+BvF4UxVQJB89sccc
 KrNgLYLIs/pOujFT8Uo87/KpN9lD3JFFh6bjeOqQJJ/1HcFhHlX7GlQ7ICWlrLxo/9GOJFboQ
 dSTy+BGyn/mDbAJdcZ6OWRAdPm2hSxyPMB7JjLc6aIIHypuQBXRK+ISg7r4hR55n3FpclQjnd
 YUU2o+m6ZaGHkCB8gQkuRZh7hOHfjAfgNshAfL08wW2pMILRIoAOSbZbrX09aSihUDtlBT2dt
 I6pHXVMehj/WMhkYhtptwg6r31CfwpFun+TWiIW57gEtxjBp5oebE42XAr2JktSfE2Y8yo9Uw
 BY4RUp6WB1ipi+qLZmU6jubWely/wN01QaOaPj941DnaIlUShFfDRUhUFWfc98Mk4CBIV+n0Q
 hbe9KCojzAnZBtT+mvgMGA8R6fjaxA/7y8W5psmbNTMS5cZMkfqooP19LoW8a3L000bjnYhnL
 Urg8ozoj0SA3L/v0Fp3mP4oCMsR13vnmVLYqRNvVW3bq8rkwCczzJjmWNUkHHBoiMc6d/DKw7
 SGhtYqa0f58/PZgmSb4Y2qLwqXxDBqg0Ja+BNuZrOMn0q5t+/YfBTAB4sgmCMODyvXFwQXJdZ
 kdvuvfGbTlbMoMLadWl1P5cZXxT4ED+/Ox3/O8SyVwa4IwswN5nsqztK4k+X8HnbmbKFMqQfe
 4OXTOuxb+cB7PXlUdRsDFso8SBjUksrmugp47CjBwtt7XecItq8mai7wMEPW+8mECeemZPdCp
 7OnMCEVgYrJ6musI4YzD9pCw4mREMp99B1h7QM3GzfOP/VLTa/S3W5jbAbzVBd+OshJn+8SJK
 nxe35EfvpYhXQZmczPXor33xeTP1EivVrUvTJEYWkj38EofCDWkg+x/35t7EIPLRTGwi8+mdJ
 c/4DQXZERU0bVQqkjCtBQbcM+jZNdq5uXJ9Wr9Tn2aTekjvYtDtFACF5FeZGFVd1OqZWbqi+s
 EhzYIJogfdS1J9yQpRFQsPSOCgcnVqBmCot74Rhd/LEUdbkNQbqu9ay/8aZl/U6GWo1nC6sDl
 m131kLojH4IE3K5kESVj1/79GqU+iIY6k9M8slYDn4PYzjWGBt3lqdXTi9QYcyMOnCdKyp/c+
 rqMOPLuK+Y6ko211zBswE1j+zhem5UQ573JDn2eW7VYHr/CC1WEScABhyYboK4phu9/AlyGdr
 f9qiSVTsap6al6lISoD5S68sanNBQ/uwbOqVrbw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uYfnpr6pbdWvc3XxVt4Ok9cSpMP4CeBi0
Content-Type: multipart/mixed; boundary="cMgnpXVJvH9bpkl8Wv1Wq0yrMJsiXZWAW"

--cMgnpXVJvH9bpkl8Wv1Wq0yrMJsiXZWAW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/10/10 =E4=B8=8A=E5=8D=884:07, Josef Bacik wrote:
> We're going to be adding a variety of different rescue options, we
> should advertise which ones we support to make user spaces life easier
> in the future.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reveiwed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>  fs/btrfs/sysfs.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>=20
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 279d9262b676..5c558e65c1ba 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -329,10 +329,32 @@ static ssize_t send_stream_version_show(struct ko=
bject *kobj,
>  }
>  BTRFS_ATTR(static_feature, send_stream_version, send_stream_version_sh=
ow);
> =20
> +static const char *rescue_opts[] =3D {
> +	"usebackuproot",
> +	"nologreplay",
> +};
> +
> +static ssize_t supported_rescue_options_show(struct kobject *kobj,
> +					     struct kobj_attribute *a,
> +					     char *buf)
> +{
> +	ssize_t ret =3D 0;
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(rescue_opts); i++)
> +		ret +=3D scnprintf(buf + ret, PAGE_SIZE - ret, "%s%s",
> +				 (i ? " " : ""), rescue_opts[i]);
> +	ret +=3D scnprintf(buf + ret, PAGE_SIZE - ret, "\n");
> +	return ret;
> +}
> +BTRFS_ATTR(static_feature, supported_rescue_options,
> +	   supported_rescue_options_show);
> +
>  static struct attribute *btrfs_supported_static_feature_attrs[] =3D {
>  	BTRFS_ATTR_PTR(static_feature, rmdir_subvol),
>  	BTRFS_ATTR_PTR(static_feature, supported_checksums),
>  	BTRFS_ATTR_PTR(static_feature, send_stream_version),
> +	BTRFS_ATTR_PTR(static_feature, supported_rescue_options),
>  	NULL
>  };
> =20
>=20


--cMgnpXVJvH9bpkl8Wv1Wq0yrMJsiXZWAW--

--uYfnpr6pbdWvc3XxVt4Ok9cSpMP4CeBi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+BAagACgkQwj2R86El
/qjOyAf9HsK8XFWCzdqnO51UEFzFanNCdaJlxx2zEki8cTUkT8TXwVXaINkCoE8i
9mzOF7qtffm6FzIspTEp5pwHqj8dM391dnj7D30Cs0r71w1WzUPQCFnGKn+GEynS
OVcjIvgI7Y3+LvClapi6/0z7kdRJycQNAF1CMWHb3UfahKky0KF5RVOLY+FJt+Hs
ixbA+68k/o6Hb5oIGHSzBe7eHUuIdAMKirMB3x5AlVSezoAmAghll98dyde5AzcM
wIyO8RTSLMSJfh8VTIoSVnfPT9J8OqV0RrSZMFUN5Rt5yLb1iQlDF21v7Pr1NCOO
o9+Ql35xU9CpeBXauNUUj6fjbMwflg==
=9CUk
-----END PGP SIGNATURE-----

--uYfnpr6pbdWvc3XxVt4Ok9cSpMP4CeBi0--
