Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDF2159E68
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2020 01:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgBLA56 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Feb 2020 19:57:58 -0500
Received: from mout.gmx.net ([212.227.15.19]:54569 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728103AbgBLA56 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Feb 2020 19:57:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581469072;
        bh=wx/4cpdNuWt2VzE9Uq7/qGSXJ3hctMRrZTZBNNOAOVU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=HqqRh3TNM48TLOwnHxkPttqCasjhyHpeVZWZv7swTZtZ/SHpzLX08gLhgyS9+MkjG
         GtcqhtCfFKaQ+DoMxHFYfvX0vL3q5V7na4tk4dIWg6fuuzy4IEsqmKPKVs1VHD4kLQ
         ABJuDTyzo844zSzR0fEkRWTeqwPtFA/77Dto0hPQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N7i8O-1jW3Jd2alG-014oNP; Wed, 12
 Feb 2020 01:57:52 +0100
Subject: Re: [PATCH 2/4] btrfs: do not check delayed items are empty for
 single trans cleanup
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200211214042.4645-1-josef@toxicpanda.com>
 <20200211214042.4645-3-josef@toxicpanda.com>
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
Message-ID: <cc635031-9a6f-9e60-2a98-5f47bc3dcc02@gmx.com>
Date:   Wed, 12 Feb 2020 08:57:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200211214042.4645-3-josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XvdN3m9hmEYm4ydVd6L69Jb8JscQJYRxj"
X-Provags-ID: V03:K1:due0AerI0ijIMzQe5pWfGVS60Bd2b0SCbIRA25ZFl3Lab8S95XL
 mrDlGgUb7yDlITkx/uyIijICuvNjFw8QJ5aNbNAOWka5PAe1JKzSFvXVuhBseq8Bb7HhYl6
 7CqEynf/GbjLijnIKOdzQIJGI+bG3teAQgXvCbp0YzMABj24PPE0/RevRWG955fVhJmmr5m
 EU5Xl+dxFgechAfti/fTg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:C1YktKihkwo=:Cz7jQ0OcF2iQeRgal+cC4A
 6MapIVn6iDsxNdMjuQGS1rOBXv/weCV6QfZsylr/L76l15uexXdFqesLopv63v+QeUtmVKJvl
 8mbsJ/+J0Jaa2pLmkGUXNpO2FpJqfLkxRezA7KV5t7YDKqJ/zHhST7nsjorPwyPUlHH8un11j
 WMNaVaC2zqaGce6qd+VW8q9PadLJKNHj8bLDhgCDSDCaJBcs2GrzIPqAsyZ7YANksv6PYthuH
 tPajS03+NSYOsg1JYj2wsqU8DeRdUekMOZGHrS+xhGLO0CpSfFVzP5uBy72Ly5z5n+667DXLl
 MCLU3O2HAbDyNjkQDKyB/cgnVfTX2X1P7Y/2qtv+5x0Gjp9gZV8JlId3QHLy0m8dUSFRFcaOf
 EuyxqoQvEufPokbHqe1+uFf69zyZOk350+ulTTeJdWpOX/WiWPjSt+g0jgU8sb8dtihKsejRA
 r4pObQIN6laKDqnKPFEsgtUBkfY9fnTZGG73tmH+0vweNDJG1d5XaOM+QTHjgLuE9nxYS9SNj
 KK3TsFWjpEt87NsZnOsBIItD7vQwdw9aUC5On5qj5YzqxakqSo3g46rEBijBygncGm7vng1dV
 47O8ft8wiaET821v0bUPIRVsWAlUP1tsLINMfzbosk2OCD2otmgBrt/dgvW4QG9+IEVZkrcD0
 iDSoHkjL+If/QFexWdirff1niNydLmlmM1HOEfiqg2p1Ia2ZaUWCSb4AoVu0HBJ0WOoxinsH/
 Si/bZV+G8QwRDs2BPXeW7g1txnqB//jFdC5qidOEhWMMrhyR2wdzb7mCkK+T4MsNbxjiI1Rwa
 8vkCxEcbpSJ3zVd88IhUmLJ9X9jQs/MnwRzxr9mtr1CiUrAieGAOkwztd8Y9412/T55JXNWM5
 waae7b2POI6Zg/QRSfZBgEsrZziSeAkyop5VQpdlHgMI9cusKINZmPxq6bmCqz4UUpALGttZs
 FwFJHOcnnFEdpGKbIYkN7QHQ/I48In6kWTPjD6LUY915n4kmPcwOu3hNwHNSczZTGB44CjYBN
 3vYwCTer+++hBa8+IhRpJrVtXlEhFfHq7BAprFgDCvVaZ0iUC4P8oxWqVTmvL/H7stfx+P7md
 Tcew72WBpzqECcb2zsSeiJvlLuHl2LvjaLEoxOy1LQ1oead6SvXBTyOOADc1sLzlX0izQ5LWB
 j7cKTr+fUHNtNKT7BDeWrYogAz8A8rk8iByN1mcoa1KzUWkbAMDqqzvvVEtmypRqL/bpBnC9b
 F/I+0kGjdbDG3lE2S
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XvdN3m9hmEYm4ydVd6L69Jb8JscQJYRxj
Content-Type: multipart/mixed; boundary="MvttGA5jTA2wU9hqqZirzhl5xq2jAFraQ"

--MvttGA5jTA2wU9hqqZirzhl5xq2jAFraQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/12 =E4=B8=8A=E5=8D=885:40, Josef Bacik wrote:
> btrfs_assert_delayed_root_empty() will check if the delayed root is
> completely empty, but this is a fs wide check.  On cleanup we may have
> allowed other transactions to begin, for whatever reason, and thus the
> delayed root is not empty.  So remove this check from
> cleanup_one_transation().  This however can stay in
> btrfs_cleanup_transaction(), because it checks only after all of the
> transactions have been properly cleaned up, and thus is valid.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Just a nitpick, to allow other user to verify the fix, would you mind to
provide a specific reproducer?
Like the error injection (I guess it's still memory allocation failure),
the call chain.

Thanks,
Qu
> ---
>  fs/btrfs/disk-io.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 5b6140482cef..601ed3335cf6 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -4543,7 +4543,6 @@ void btrfs_cleanup_one_transaction(struct btrfs_t=
ransaction *cur_trans,
>  	wake_up(&fs_info->transaction_wait);
> =20
>  	btrfs_destroy_delayed_inodes(fs_info);
> -	btrfs_assert_delayed_root_empty(fs_info);
> =20
>  	btrfs_destroy_marked_extents(fs_info, &cur_trans->dirty_pages,
>  				     EXTENT_DIRTY);
>=20


--MvttGA5jTA2wU9hqqZirzhl5xq2jAFraQ--

--XvdN3m9hmEYm4ydVd6L69Jb8JscQJYRxj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5DTYwACgkQwj2R86El
/qh9/QgAhg7rfPpA+NaAYRj6BXFatBpTHD48NHj42iso/9O6DQL13M/40kA8y0sB
PwXkGF9ENxibxstRK5SgSkkFrmzPniQZYA8nYtVWGnbeilKpNohYZIFB4hpbGsEA
fENtWpvmONLz+4NnkI699RK5Y4/y9S82VCm/sO69OZgHrFIdN+2ml/106ac4kssu
xuMajFkjEUQpX4stUp/nNlb6hID7rgUi6jGodVrUfoncXglhvNV7iBNpWFtsFM07
q1kV4uEt6acTiKJyYSwF+m70SKTFE25QxW4QbqU7+ZvzG4itboAdQwUhekWdBTaK
UQ5gchdbY2lcOoZ313D1nBGXAbBpaw==
=3Pv2
-----END PGP SIGNATURE-----

--XvdN3m9hmEYm4ydVd6L69Jb8JscQJYRxj--
