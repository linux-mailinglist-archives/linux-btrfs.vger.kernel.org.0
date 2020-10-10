Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F351E289D2B
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Oct 2020 03:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbgJJBor (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Oct 2020 21:44:47 -0400
Received: from mout.gmx.net ([212.227.15.19]:54403 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729402AbgJJBHX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 9 Oct 2020 21:07:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602292042;
        bh=xdHddA7WT9HQDj5cWPudtEW2Hp0H6ZsO+GtZ8RVcReY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=HEbDOti8M3qHWwkAH/jxLcgzJblCiwVZh88sRo5EAr0sEANAT5mNCsZJ5Y2TGDLq1
         dnDqd+dC2ct3WL+v/uFSxrPHyJd7bl8lAW/VURvmO1e3vyn44rXMkKmcpNio9gxKbq
         6Un1jcT/8UUu96qvwMTAEwa7Im9OTwB5Z28wvbh4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MPog5-1knPCq3fut-00Mwdv; Sat, 10
 Oct 2020 02:35:56 +0200
Subject: Re: [PATCH v3 5/8] btrfs: show rescue=usebackuproot in /proc/mounts
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1602273837.git.josef@toxicpanda.com>
 <64b9c0fc1b1bdf7bbf8630ffa31f3f296e63ccf3.1602273837.git.josef@toxicpanda.com>
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
Message-ID: <61e88e1e-482e-7774-5d2a-97f3a8489d57@gmx.com>
Date:   Sat, 10 Oct 2020 08:35:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <64b9c0fc1b1bdf7bbf8630ffa31f3f296e63ccf3.1602273837.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nGgU3E3D9v42RWs5RLOXyZfFybRKWh9Oz"
X-Provags-ID: V03:K1:Cmc81GbXdINn6G85N1AKSGAhLYNADl5cE6iIvsgSpEmg1i7FGHX
 rPsq5w7AOfkChfnJ6WINsUaFr54AjuGu+FK/9oiCfswZ99WlT4Jta1hQMfuhkupw9kYgQLf
 DpUMOLF8vjBfPnmZsAwVrs1s9KNC9GC0FgFkMpTMR7TGrtBJhlzyijK6LcYdxAr+sP1EnNM
 LjJ1zR21HVRaIcVtCGSnw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TUeGsQm8UK0=:sZAb39epDKgKhIuTcrXzov
 O9KBcS83nIuViOMqZBGQzYIHfbdPpDAeNR6od1EJTBK4ot01czbzqlwoq4RJ6yMVrYyBOWK0E
 Blo7s5hGerHinvCjn9a8X9/eCo7Lt9xthKouutFsDX/AF74cGaN7yEnVuegwBX1m68ufZimDu
 OEji/XPzjs25YcoEuFjcGTTMAK4wmP2pxLkciMPGTagIEpv/ADrVxXw6wgMoDwjUA4UEpPPcD
 LAb/dou7UYF5vCpQYn9SQAjjLG1IYrNYDOkU/6Q7aZjo5vL12Jp5bv7dzYwiAveK7w2LH+6pS
 5Oo+Drx9o6d8fJlh5XiLw2+m58XGBlCzNWKTRd7d7VsXjU5f9n8lt4ujamtFSeB4AIF9qMKoo
 J0e9tWer7cfABLgdme17RvfzWIC2Uk/+wDU97lM1rKOm9zvwcq0EplfP8cOLvJocgCz9lMaqB
 hN9s2A/QLpuTe9D9/fF0EZ4NKyV+teN2yrwTOZdq2Cmz6bdZxGNXOsi8l41QUm9pmKvdI2kxY
 1XNzDtd14Hu9aHdIc9z/OQyQ1ix1vRyA733FfKJe7vVvWD9ltbMGJz5jQ22IZyCvOlGU3SgGQ
 acdPPZWYDu++lilthNcu0M7DmWl+MEgaFN+Aho5ETodXzqYmwIMep35gv2TDR9ubUPMd00hDn
 45XTHrJzqVHZXpfpVCTHbaDGwVaUF9yZRRV4cTPAODjW3Q8C6IyoDZ1Xp2inj+nWgxXV4kSPU
 I0c1rKT0ytwkp4u6lP/skeKgG8Xoj8v21D1W/gRwm+Vk1Spw0VDkmGw0L69kTtkHIYrcR1IJA
 LQmUI5uqaoTNZi9h6/Q61dvHV4IXO+k/D22R2nx9i3h0IUL8AlFLb1jrD38ArgI1oYj62P3Wm
 BmJOkXHdWvXbzLA6OAicuGrfc86rKvcl27M4XR7p/pgwlx/FBuf/AHTWlwg6EVR6kRWcXF48y
 rH0GLs25a3JAmr4JjiI8c9CU5eFzEM7plrY7Zr1hO2neH0w9UwYnh9WpmuaeZ205kpLeiSDyh
 x8Tl5QoyBmZCC1q0HElrQYqe0a4629SxTkWXifX/J4nxtGgHQ8Tp9YMpILjf9Akxg0owDuL/J
 rhN8R0sTf2QeeSlEVfCwxjvUWo4w7e6WPGs2rD94p4l511mVxF3wUsz4GCuIgJCn8OMMQ7A84
 fepxPMAW1yoFqLtiCJ+VXpMTiD4JVhXVwBPWX6ZjV3aAGqdBnrFOK9SqMWfC4PrTY7CsKfEap
 8zzhir9E32NFvlpW3a1Bt32LCKsTwa3WLXPjwJg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nGgU3E3D9v42RWs5RLOXyZfFybRKWh9Oz
Content-Type: multipart/mixed; boundary="sZbdMykO3oxpNkuVsznrPqRrQR9BObaFo"

--sZbdMykO3oxpNkuVsznrPqRrQR9BObaFo
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/10/10 =E4=B8=8A=E5=8D=884:07, Josef Bacik wrote:
> This got missed somehow, so add it in.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

It would be better to fold this commit into previous one.

Thanks,
Qu

> ---
>  fs/btrfs/super.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index be56fe15cd74..833b7eb91536 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -1436,6 +1436,7 @@ static int btrfs_show_options(struct seq_file *se=
q, struct dentry *dentry)
>  	if (btrfs_test_opt(info, NOTREELOG))
>  		seq_puts(seq, ",notreelog");
>  	print_rescue_option(NOLOGREPLAY, "nologreplay");
> +	print_rescue_option(USEBACKUPROOT, "usebackuproot");
>  	if (btrfs_test_opt(info, FLUSHONCOMMIT))
>  		seq_puts(seq, ",flushoncommit");
>  	if (btrfs_test_opt(info, DISCARD_SYNC))
>=20


--sZbdMykO3oxpNkuVsznrPqRrQR9BObaFo--

--nGgU3E3D9v42RWs5RLOXyZfFybRKWh9Oz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+BAegACgkQwj2R86El
/qhvJAf7BkyIcHR6rPCgIZ25RiJXUxJGIDom+JxfgVJ+ainp/OcdqZwJTOAyYSbp
XxytO42a0EpNz6Kgba7Hnz9COUOgP1qc9HM37yEyfYuTjamTjD9i0Rp/3vH4iShU
aWJRa4vccrfwhAh1luLMSXPOOtCUCp8d78Y4qNvREN7d5H7mFaKowsmNsms+bUBb
mNuyYVC3HuT4FVd+9pwyb3Lnjx/KPtUtQ7vY6x6u4EcKOP/ZemK+QvWizi+/KbP0
GoquG1Ao1ezJ0w8xBXaNj4SnxZ3Cl9e1J34Yjlq6tSZalk7Ym+OnagVX9Cumj8LD
RlZJ9EfeNa6wUV+bEEbLtMcGDhQrSw==
=Gk/G
-----END PGP SIGNATURE-----

--nGgU3E3D9v42RWs5RLOXyZfFybRKWh9Oz--
