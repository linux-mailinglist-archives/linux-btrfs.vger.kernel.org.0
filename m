Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA80277D32
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Sep 2020 02:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgIYAvu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Sep 2020 20:51:50 -0400
Received: from mout.gmx.net ([212.227.17.21]:34769 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbgIYAvu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Sep 2020 20:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600995104;
        bh=nRGgfz/RAdwyLGlYCATn84Qq+Mbx3nrtCkLxD+s7SSU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=dLyJ5XaSR/EkUjaf236aSs6MGjatPJtFS8zKiEY1cwF/gj/+N0tPm5rXyxcAzaoQs
         xMtc3Fdudza36EXkUDksTT9h2/OCrY1WvC0zCNE/Xpq74OufJ7xpIzpxsHo6PfwE4+
         GhztOzzey77YrW3/ovqXO6eXXcVTx4W9IxogL0cQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mplbx-1kmuIc2ljh-00qA5x; Fri, 25
 Sep 2020 02:51:44 +0200
Subject: Re: [PATCH 5/5] btrfs: introduce rescue=all
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1600961206.git.josef@toxicpanda.com>
 <2377349868151ecd4be5f7077d22220793492f58.1600961206.git.josef@toxicpanda.com>
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
Message-ID: <abceb261-14c0-1726-a0bf-c6821ea34c3a@gmx.com>
Date:   Fri, 25 Sep 2020 08:51:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <2377349868151ecd4be5f7077d22220793492f58.1600961206.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UkfAXseT3j2Rf6IXftgTw7g5PWxu1ujxQ"
X-Provags-ID: V03:K1:4BEVn0zccP3xHPXbD9ML+keGb62G6Hl115CNWM+Uw41Aj24268l
 HF2Q24U/6hKUDp/7tX8sGtvxgPhEYD2AUV8HrKExyF557nelsX4CytxPgsROEuNjXbuyPWt
 6QyjzT6t8FM7PwoIIp6YB3ObBvJNFiHhC0cXiRKkbVOch3mV1yeDuSUnr1/xdiNinAWeF/r
 lUOe4kl6oa9tkS6hQXEyw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sMwMuqaPJKY=:kvLeCQQu+YKeRulnHLK6hd
 6rMi/dlzbg9WJoPMnwNqIO9n6MZ1Doz8pabrCwLnIHJFxX8bTIWDRW4ErVETWrE9J6cFmUsEd
 CZ/1kJbqJmkXXEtFE0WFSQuZuTX7plCrk80wYKzWDZ8qM9yHOslB/bGY5YqLtHMHH4s6Vmxl7
 PbVGTEKJ3UztcP2PdsIunXtRi0aOZnoPFw8bp85vBubsxLs42u0SBReO+Jc0NqdzZg8ZrCGXA
 8Uw52tkovZIHfFc62k87tNR0wLdSw7Hfndy6TsTiolIGEMpe76AwcuWae1phQOhSKX7baaLYP
 7elsqE8DTE2GRMk85FhtN5wNjVjPrjWeNrcmQvSZA4qJ2aAGMXGK6dtqnWMpOuJLIjlYcChk5
 y/CHHNT0T87GE8x60v4/kXARZfCn7reh2DZMcZbLikx4JNHT8XJgeirDeFsdwV019zlzQyStT
 RHCAqQu1JM3jKVxpVcw3tJ1mj296DroZ8xemzTFAp9OsSNCgh78DFlo1mz6hwHzrqR/eogl72
 QU8G4thblyR+C2J5oQnOzoJDgDY1G7zdJl0WvNwepaAz4YEUt8Q69/ueHoZeWLIEQJPBFz2re
 bU3lo8rk+THA7S54Vncept/8MZ2DTetFa27a+0+pKaJ7PkIS0KeSNYVoUkPF8c6pH47y0cREI
 /ZboKkPl2bnF/HxK1VZXW+xSI3wnQeuU6qsi8udPodh/KPN3PfnIU/NVuaKLFufxZ976bqf16
 yFd0NT7SV6XhRm11pbaG7bYtCr1o7jENKmo/nLI9VTiIrk/USRDPZMjRq2t7JJHMTwBHZOv3z
 HoK4PEwM7vlyJPb98daSR8HHCVzkDkYcNbmBZ/JoZmNvlMyb4wCDqGZXS0yNeYcEmwVSkZbNP
 SDiHVD4l/JLLg3w0bPmPh0QWFDmEGkH+yAiJTc42gH7c2E7jkBP+q8i8UfKmvGD2yT9UoQK0G
 rFMGMM/eIgaRgY9OsXgXMQUmpZZy9+UTDvnlKasO3td5/3wGSsvgTI3dkazEQCFcLQReAojNq
 EA+W0PnXf3YDysllAS2RvcSoiTQ0R3NfRmM4O5cXM/EKsjL7l1b1XGpMtSVODnaDJu+AoVQVw
 IyVsGdQ59S7e+AFcnnT1nocHDM+pto343SFFXHVrjTT4+qfTE3Ho7MlAHG5F2774iAD4DG+s5
 7jsroUU8COydYIGsC7opBZTSfLJzOUY08kZNVfeunH9yFtmiLV6z9CuK/rbOaBPkzF/o4eKSI
 z1wmdQZhdjLcbPWH/KezYszOfRkwq5LQwqho6zg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UkfAXseT3j2Rf6IXftgTw7g5PWxu1ujxQ
Content-Type: multipart/mixed; boundary="FSznY1funhmYBuP9TYhAd1m00safoKtCs"

--FSznY1funhmYBuP9TYhAd1m00safoKtCs
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/9/24 =E4=B8=8B=E5=8D=8811:32, Josef Bacik wrote:
> Now that we have the building blocks for some better recovery options
> with corrupted file systems, add a rescue=3Dall option to enable all of=

> the relevant rescue options.  This will allow distro's to simply defaul=
t
> to rescue=3Dall for the "oh dear lord the world's on fire" recovery
> without needing to know all the different options that we have and may
> add in the future.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>  fs/btrfs/super.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 2282f0240c1d..3412763a9a0d 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -362,6 +362,7 @@ enum {
>  	Opt_nologreplay,
>  	Opt_ignorebadroots,
>  	Opt_ignoredatacsums,
> +	Opt_all,
> =20
>  	/* Deprecated options */
>  	Opt_recovery,
> @@ -459,6 +460,7 @@ static const match_table_t rescue_tokens =3D {
>  	{Opt_nologreplay, "nologreplay"},
>  	{Opt_ignorebadroots, "ignorebadroots"},
>  	{Opt_ignoredatacsums, "ignoredatacsums"},
> +	{Opt_all, "all"},
>  	{Opt_err, NULL},
>  };
> =20
> @@ -510,6 +512,12 @@ static int parse_rescue_options(struct btrfs_fs_in=
fo *info, const char *options)
>  			btrfs_set_and_info(info, IGNOREDATACSUMS,
>  					   "ignoring data csums");
>  			break;
> +		case Opt_all:
> +			btrfs_set_opt(info->mount_opt, IGNOREDATACSUMS);
> +			btrfs_set_opt(info->mount_opt, IGNOREBADROOTS);
> +			btrfs_set_opt(info->mount_opt, NOLOGREPLAY);
> +			btrfs_info(info, "enabling all of the rescue options");
> +			break;
>  		case Opt_err:
>  			btrfs_info(info, "unrecognized rescue option '%s'", p);
>  			ret =3D -EINVAL;
>=20


--FSznY1funhmYBuP9TYhAd1m00safoKtCs--

--UkfAXseT3j2Rf6IXftgTw7g5PWxu1ujxQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9tPxwACgkQwj2R86El
/qgrvAf/d5kSC8P9y0oUQ3D0mGpJRcGSxsWyOtFDyS6FI10n3rdQCRTJD2GkmlSu
cuGNEQUOnghJkfyZDYu5lkl6nhbqq4aMWNG8H4v0qiVx+F6SEowPL0NEM2txuPPn
gkHDx/jWKjgHJgEex/rNGLJel9mn9slN15iNYrE9kQv3L/ZbaSrc1sjxMpZHXAN9
i7DpC7NrMA/18y3KOMuHgvIyFjPh5s4S2PUTyZNdSheX9k27Cf7hC74bsvzD4GCW
psKynqPkXlDpJEsQ4+5fsf5sGgrFvXhbt6nGPFY1VvzR0MlETd9q0yQ3BMVhU972
yvHNEGZc2mbfdHaGgCBnt+9gESO93g==
=WLfE
-----END PGP SIGNATURE-----

--UkfAXseT3j2Rf6IXftgTw7g5PWxu1ujxQ--
