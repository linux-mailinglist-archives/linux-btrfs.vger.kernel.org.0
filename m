Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2B6211A4D9
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2019 08:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbfLKHIt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Dec 2019 02:08:49 -0500
Received: from mout.gmx.net ([212.227.15.15]:35597 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbfLKHIs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Dec 2019 02:08:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576048118;
        bh=dVAtjXq2Pcl2RA9ouPFARMTTFkNvluQcz7Q2TKpoXx4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Qm4EgFuzPxE+ssHg21Wpgv11Azm7PAUTjGgq4ro+eTrmFELiruF2LVsWe+Xy9CBL1
         3swcon3ZT5HuCckkgcXlSlBYigpjMvLxrSrYXvqhtTd4urrRISG9kqLzF9E096lVvq
         JtR0VyGvEypv6s5lFCxdcVBmzn2g/IDvoaP41jWU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MmUHj-1hx6pj0M5J-00iWvv; Wed, 11
 Dec 2019 08:08:38 +0100
Subject: Re: [PATCHi RFC] fstest: btrfs/158 fix miss-aligned stripe and device
To:     Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, wqu@suse.com
References: <010f5b0e-939a-b2be-70a2-d8670d1696ab@suse.com>
 <1576044519-28313-1-git-send-email-anand.jain@oracle.com>
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
Message-ID: <b89463c5-9f0d-b262-0198-2750e0b2aabc@gmx.com>
Date:   Wed, 11 Dec 2019 15:08:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1576044519-28313-1-git-send-email-anand.jain@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rryJTXK4NPnixavoaoxCeUCq0eChcoHAX"
X-Provags-ID: V03:K1:qqTqOTiMFSKxDbBRX58H881m7SyA0E55f5/vyUQt+vpEMVazbX7
 hpiuCsIHvzVdbJC+zh2KEXfRRsoWNWwuzxCPZd03MUUcQQHuPJXHWB3g+wF7GpUOqb85Ygx
 DgDFXcgUxFdwOxV4vL6XC6VurlzKeW9k3+jPOLcCqpYkuSzxGBMiRi3QgK8zm+6gQDX4x63
 hpeycqvxnrTbk3g9TG47A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GR7KlmE/UX0=:8mIs1Xii7bzSxvtH5xBGay
 g6c4Mzh4jTtypmKjNFGnOn4FHVBDINUBt5OMsf8GHQheEPCo++/kduq5r4fKIwvp+3tLBza0a
 Mzjnb0t5q0yPhVwWhSRiOhLin8adkIUXhSWdDrObVCZZspgKqNj5jQwrmqN6NLaK7ExvS0v4v
 6kmI1iwI4lF9gkeqgb2PDrQv881gVzSpiraRbDoyl0C2gSb3+fKPqrymm1PydrdrGPYOj1oyU
 YjMlTDmT8utd8OdVoCoAVGnwUJbxijp55s7NUD+GEjCVjY/iKasHY5NRm//cxidT3R5qLvY40
 YniKMKQfX4ynaHZcNXgTQSrufK2H0ujfLdHfIAuWK/vBWST9RIdc3f1DSub+Z83VKHZRzuFSk
 v5EVBeVx35Mi6/4aWiOXi9CM5BdJEXo8lRd7jggwADIL1u/FAlDKPDsKCqlDcRWg0ONnDcbf1
 q0pJ5g76pOpUuVXt8FdxNZ9QolalwQPjZeaIFV2X3rCZJ3G7lcOgYpEqf20LqYGzIyl8RgbtN
 vMd01R+uOIGcyOzOYbMLBJKz8YFIQRqfIwyNw3s46Y/oWoZ5uZv9QpSsj1oS43Sju/I5HxB06
 PftlyYpifqC3fX8M86mx3zYqKJQW33yuKqU24EM/awBupKl4qLC7FkdeQ05oVsz1pyy1xiGSz
 k4ePPD+r0gfAxxnoM+uhPJ3Uqoe5hSLOLuBNV5dIQsGEC0Alwgs5TmkKk9J7gk5ppkFq8UZim
 sUKIreqJT3SxtZ2A3uTevLrM69pVy+dGw+VbdBjTAkYyrywygZj3ZXo0DvySrB+zfdmuk4CFS
 5/WXKkpETtLHfSfrKT8lTwdYTSNWkzaTKmv6hkOWRfnOZTklGYFfc9yWqLjxZEWUp0vPANo/T
 ang0OlMsVCWryUNHzCmB4/5QntYtv3VpaD86pQbIG6wijDjbie86ehbLJaBHftJ4MEpD/3j0k
 RbZLhlNRU5kTwjvMeCBDG1h4bv38ZLLmPPndEIFN0aG19UoL767X2y2IC2pOVg191q4+JHSoC
 SGUH/9mWPflEDNqdG+ou0l02nWw0G3Kb/sXpnNjRcnSga8LCIC+uBc+GWKn1QNZaloZizVqTW
 phHdPmX9WN//5nI/fEeyySzRVkgdLlC+POBUOl6w1RgkV0Q7gM1QYKCVW4BqcZPF6fxVWL8EX
 TEql2kVf3XXZQRiyHrxJRkerINCvuhcyriqGtC+pVm4jXb3IPCTGGHTFXxeHSjdqYD6VduKrE
 73FyoK/+MfTkced2jfp6zQZph2UszcfreVyW+12U88/uTlf5m9W7cMvnenCE=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rryJTXK4NPnixavoaoxCeUCq0eChcoHAX
Content-Type: multipart/mixed; boundary="Q1cT1AS0JjY2MCX7VTImyGJV6MZFWGUzh"

--Q1cT1AS0JjY2MCX7VTImyGJV6MZFWGUzh
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/11 =E4=B8=8B=E5=8D=882:08, Anand Jain wrote:
> We changed the order of the allocation on the devices, and
> so the test cases which are hard coded to find specific stripe
> on the specific device gets failed. So fix it with the new layout.
>=20
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> Qu, Right we need to fix the dev in the test case as well.
>     I saw your patches bit late. Here is what I had.. you may
>     use it. So I am marking this patch as RFC.

I am crafting a better solution, to handle both behavior (and even
future behavior), by getting both devid and physical offset.

And I tend to remove the fail_make_request requirement from some tests,
and direct read with multiple try should be enough to trigger repair for
test btrfs/142 and btrfs/143.


In fact, I don't believe your current fix is good enough to handle both
old and new mkfs.btrfs.

So we need to investigate more for raid repair test cases to make them
future proof.

Thanks,
Qu
> Thanks.
>=20
>  tests/btrfs/158     | 10 +++++-----
>  tests/btrfs/158.out |  4 ++--
>  2 files changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/tests/btrfs/158 b/tests/btrfs/158
> index 603e8bea9b7e..7f2066384f55 100755
> --- a/tests/btrfs/158
> +++ b/tests/btrfs/158
> @@ -76,14 +76,14 @@ _scratch_unmount
> =20
>  stripe_0=3D`get_physical_stripe0`
>  stripe_1=3D`get_physical_stripe1`
> -dev4=3D`echo $SCRATCH_DEV_POOL | awk '{print $4}'`
> -dev3=3D`echo $SCRATCH_DEV_POOL | awk '{print $3}'`
> +dev1=3D`echo $SCRATCH_DEV_POOL | awk '{print $1}'`
> +dev2=3D`echo $SCRATCH_DEV_POOL | awk '{print $2}'`
> =20
>  # step 2: corrupt the 1st and 2nd stripe (stripe 0 and 1)
> -echo "step 2......simulate bitrot at offset $stripe_0 of device_4($dev=
4) and offset $stripe_1 of device_3($dev3)" >>$seqres.full
> +echo "step 2......simulate bitrot at offset $stripe_0 of device_1($dev=
1) and offset $stripe_1 of device_2($dev2)" >>$seqres.full
> =20
> -$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $stripe_0 64K" $dev4 | _filter_x=
fs_io
> -$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $stripe_1 64K" $dev3 | _filter_x=
fs_io
> +$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $stripe_0 64K" $dev1 | _filter_x=
fs_io
> +$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $stripe_1 64K" $dev2 | _filter_x=
fs_io
> =20
>  # step 3: scrub filesystem to repair the bitrot
>  echo "step 3......repair the bitrot" >> $seqres.full
> diff --git a/tests/btrfs/158.out b/tests/btrfs/158.out
> index 1f5ad3f76917..5cdaeb238c62 100644
> --- a/tests/btrfs/158.out
> +++ b/tests/btrfs/158.out
> @@ -1,9 +1,9 @@
>  QA output created by 158
>  wrote 131072/131072 bytes at offset 0
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -wrote 65536/65536 bytes at offset 9437184
> +wrote 65536/65536 bytes at offset 22020096
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -wrote 65536/65536 bytes at offset 9437184
> +wrote 65536/65536 bytes at offset 1048576
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  0000000 aaaa aaaa aaaa aaaa aaaa aaaa aaaa aaaa
>  *
>=20


--Q1cT1AS0JjY2MCX7VTImyGJV6MZFWGUzh--

--rryJTXK4NPnixavoaoxCeUCq0eChcoHAX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3wlewACgkQwj2R86El
/qgr8wgAisBkKoLBt30rJkUXeMmq35m80FhDxtoNTKMLsk3mgQby6K4dels8Kzhw
419lmr4v1iHoWE0LNQ7YscSzj5RCbXuXmUVKvK23WGAG1jwj+hmmWZ1y40M8nKLQ
uQT5oJ9gdCe0E3ovAppFRAl/BzBHDhjy+8JlZG5OhieKHhU1G43uxJjg4GIBOtzn
OQy2uGdsLNszHn8gwihKhV44VnXQ6YQnCXiNy4S77FIF+TjVmTVHMVsLWlr2tPaP
mKS6Ht2GnDhdY2bdZ7pIL+rFeA8fCoVBnO/cztkPJedCURqhBKquuDlHgmVcVmB9
3COskjhBgJRHPgZOOaDp7v25Y6X1tw==
=Is6n
-----END PGP SIGNATURE-----

--rryJTXK4NPnixavoaoxCeUCq0eChcoHAX--
