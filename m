Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04EB213417D
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2020 13:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbgAHMQy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jan 2020 07:16:54 -0500
Received: from mout.gmx.net ([212.227.15.18]:40965 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727212AbgAHMQx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Jan 2020 07:16:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578485790;
        bh=onoRxisb8of4jxCg8Q2LAsyDdXPP+pKXYErasDfgrFY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=RSiPH1ei8R1nXFEOSL2BZuIToPvjGAF/agGloB62TnG0l2CCOtUf8QqkW8FoOAYgd
         NYR4ogqpoxjcSTIHzvD03Ge03r21ptw6tL/WWus5EwVmcyXbctHkjxJu2vSEBkmVL+
         ikVHsyT6u/0YdXvMZf+E7ojnR3Thx3oBgrpMPgEc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MnakR-1jVgoy1Dxl-00jaYH; Wed, 08
 Jan 2020 13:16:29 +0100
Subject: Re: [PATCH] btrfs: fix memory leak in qgroup accounting
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200108120732.30451-1-johannes.thumshirn@wdc.com>
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
Message-ID: <af99596c-c11d-932a-5a79-be71d2857c8e@gmx.com>
Date:   Wed, 8 Jan 2020 20:16:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200108120732.30451-1-johannes.thumshirn@wdc.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="X4ztt3F0FiDr1gZHyX4Vov3o24vxjNv8L"
X-Provags-ID: V03:K1:EfsDQ3L3Cfn9eX2/QGdrBDJbp5C454RsLh9EpFfH13yu4EQZzeL
 XC+l5Y2oZ+u/IZ2llENduK/Jp793UZjiPXTif8qWyoYH1cgyiDUIoXC/b91A1QhVI4Dqtnj
 gznbTg87fLzv9FiV61vrGJf52i8dDfWwEjrmcCTqsFUoSMHSMsU/aMRfuxEVDqGRHHsxmF1
 O0tww9Lw3e6Er2iglC2wQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hrJfg+7E4h8=:u+b0QOHB0++yiKQEk1Hi/b
 /WRECXsDSTJyorygjlg79AyRpBP/0jlM4NdFY/2tzozWpKieGh9/iocwmBgKRZWzH3itsstC0
 F/2K0TKzk17wiEfoBtyHmEgRRBxIqf8Xbeh44JfRzgz2swclb+PF2hB64wu35edniU8mxqvPY
 FzTyuD9Go+lo8qII2eChA3AmTv7tWGYYRu4u5JRN6xU62/T5w+UZ6a0ls4whTXZ7usaMD+6ms
 q8ghPZyxuMS/uO7w7zQyBYju7YTz6rxjivLfepHckKf/kjvguKYbFeDdpnBSbmdoM13cl2Awa
 PFzqnerY/L8RR5nZZ89w3q9lk6iLqKqv5ItxXmj07wZZrrSRUXUZbWXG+PaAAITp9Lzd7sYFI
 aAvXjqihaawc1qQmEll8raywSuIVzKCxDLMgmt92ESuUo0mJuSWLrY7V6o6JAsJt/o3Kv/tTT
 6peUx1sGTwpw3OLZlrOi9Wgw0wrta3DHEQd2qywTkaukViOYlTlPNJ9+Es9dVv7GqXUvhCh2s
 NxtzVrFTNg76smWwHaF8+lpp3Niu2uqFLjAl1eq7QQCWjPpZa5ck4VAhuv22n1xkmeqW0m7Q9
 SbHWLNNvVaDQIcxA6PR/7IxENxtGwoa8OIokqkNhOUN1Pw3zEd4XTHgG656lefDw+4ElrZiOZ
 6UT7+aBmnjnYLKsPUC1BUN+M1v/0nlJRHlQ+NBzCw3XQx1KmljxclVasvLaM3H9kI/soz1U1n
 9gBYUc+qEpxmSq0FnMkwtFxJ6nwO1ks1leU0vCtfTIFKeqUsUf3pTyH4AaO617rPuE/IaD3Lw
 rWYsjVg5FmNw+Ke0bRp6eUxML0rTTMoIBpqmkwVIIHIoi0r5+fB8IKQHj/Ty93c8TA8V5/RCJ
 DXuv0ddptmgenpRxfygAsVhGoHjVHd1PAKAYIEPnrbOc2+rfyk9vbzmEg0u5TH3xfVK51oNrA
 HlmYbs1WJbC5fa10JF5kJNcR7I6jwDUzHoEXBU/Ncad2SkulVRrKdu2a50EEJWHOIqpcwlOiX
 RNku32jXOP4CcBn+TI8gcGPtmpG6Iz+hTTWQhqsAfepfpR3LrnUVvMM9FNSDjS+WYUFcHPzyL
 Ml+m7P+6Et10vv2ru75Ogt2wJp442qludkF4IXhAycZgTDmWB1AloapjpfmRkKaZnxxRrDp6U
 HWpt9MPTtBWiXRiDGdTvrI22jMTh5nqi1nLWX+GJRaClbaNZMQqjeDqJRfMYftYsmpGbTZFV9
 W5NDPs1ZObDsyMmDXfMXEnThfX95EyJH594y6Bcoc0Fy9gD1E5sJmwusb918=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--X4ztt3F0FiDr1gZHyX4Vov3o24vxjNv8L
Content-Type: multipart/mixed; boundary="Ku5dXtlQCb4S2BPjylFtNc7KoUqoyrwzm"

--Ku5dXtlQCb4S2BPjylFtNc7KoUqoyrwzm
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/8 =E4=B8=8B=E5=8D=888:07, Johannes Thumshirn wrote:
> When running xfstests on the current btrfs I get the following splat fr=
om
> kmemleak:
> unreferenced object 0xffff88821b2404e0 (size 32):
>   comm "kworker/u4:7", pid 26663, jiffies 4295283698 (age 8.776s)
>   hex dump (first 32 bytes):
>     01 00 00 00 00 00 00 00 10 ff fd 26 82 88 ff ff  ...........&....
>     10 ff fd 26 82 88 ff ff 20 ff fd 26 82 88 ff ff  ...&.... ..&....
>   backtrace:
>     [<00000000f94fd43f>] ulist_alloc+0x25/0x60 [btrfs]
>     [<00000000fd023d99>] btrfs_find_all_roots_safe+0x41/0x100 [btrfs]
>     [<000000008f17bd32>] btrfs_find_all_roots+0x52/0x70 [btrfs]
>     [<00000000b7660afb>] btrfs_qgroup_rescan_worker+0x343/0x680 [btrfs]=

>     [<0000000058e66778>] btrfs_work_helper+0xac/0x1e0 [btrfs]
>     [<00000000f0188930>] process_one_work+0x1cf/0x350
>     [<00000000af5f2f8e>] worker_thread+0x28/0x3c0
>     [<00000000b55a1add>] kthread+0x109/0x120
>     [<00000000f88cbd17>] ret_from_fork+0x35/0x40
>=20
> This corresponds to:
> (gdb) l *(btrfs_find_all_roots_safe+0x41)
> 0x8d7e1 is in btrfs_find_all_roots_safe (fs/btrfs/backref.c:1413).
> 1408
> 1409            tmp =3D ulist_alloc(GFP_NOFS);
> 1410            if (!tmp)
> 1411                    return -ENOMEM;
> 1412            *roots =3D ulist_alloc(GFP_NOFS);
> 1413            if (!*roots) {
> 1414                    ulist_free(tmp);
> 1415                    return -ENOMEM;
> 1416            }
> 1417
>=20
> Following the lifetime of the allocated 'roots' ulist, it get's freed
> again in btrfs_qgroup_account_extent().
>=20
> But this does not happen if the function is called with the
> 'BTRFS_FS_QUOTA_ENABLED' flag cleared, then btrfs_qgroup_account_extent=
()
> does a short leave and directly returns.
>=20
> Instead of directly returning we should jump to the 'out_free' in order=
 to
> free all resources as expected.
>=20
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

The patch itself is OK.

Reviewed-by: Qu Wenruo <wqu@suse.com>


This means the qgroup get disabled when rescan is still running.
So I'm a little curious, could we just cancel the running rescan and
wait for it before disabling qgroup?

Thanks,
Qu

> ---
>  fs/btrfs/qgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index b046b04d7cce..7ebcdd201eed 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -2416,7 +2416,7 @@ int btrfs_qgroup_account_extent(struct btrfs_tran=
s_handle *trans, u64 bytenr,
>  	int ret =3D 0;
> =20
>  	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
> -		return 0;
> +		goto out_free;
> =20
>  	if (new_roots) {
>  		if (!maybe_fs_roots(new_roots))
>=20


--Ku5dXtlQCb4S2BPjylFtNc7KoUqoyrwzm--

--X4ztt3F0FiDr1gZHyX4Vov3o24vxjNv8L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4VyBkACgkQwj2R86El
/qhiGwf/dxisQZs5ZkctQS30RMUz7mFvx6/Co4Q9Q/T8mZlyuMMjZhaPN1VbxZIp
w5jpqj9aoJJGMrc8HzlUQ9uP15D+aHztbXiimaG74hdvoxkORF11NIF135eujNKe
Ld0RiGrxfk9TjREdvSH+hslqb1Wwm4X3OoNLY3/2stbvQu8OTjnOR3K0hr7+1MyQ
HXAJfd78O0cC12A1XD8b0OMUjSv+fQ0Bmr4zrhns7kboxXWBzOh28t7kRZVfONG8
SmVH7lEjTPxgH+uN6r6wIK2sAOd7Y748jL35upc6agGN1UgJ9MbhYG0Zchba+9/N
NgWkayybjFQkC7E2aZA7lXGvTgZpYQ==
=J1sZ
-----END PGP SIGNATURE-----

--X4ztt3F0FiDr1gZHyX4Vov3o24vxjNv8L--
