Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2E9715577E
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 13:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgBGMPy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Feb 2020 07:15:54 -0500
Received: from mout.gmx.net ([212.227.17.20]:49621 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbgBGMPx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 7 Feb 2020 07:15:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581077744;
        bh=hzJPiNmmgOlCnaCAifmu57x8TeAO0up2l9aV31o60l0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=GXDowQ1kEQj/JF9r4zC9vhADzP8wksTk89GbGJcJquad8g9reJbil65ZMktt3UwgU
         gtf0MyY3wqPvWr1ZYGhrc3h1iMHFI8AJupi/0fJfyrGi04pEDQj8eMjRGO9FEwVZ8h
         7OxcNhmBUy8SS+PqV5u98nwFb6/vYna2X0N2u0Ig=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mw9QC-1jpngZ12Jg-00s76O; Fri, 07
 Feb 2020 13:15:43 +0100
Subject: Re: [PATCH] fstests: btrfs/179 call quota rescan
To:     Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <1581076895-6688-1-git-send-email-anand.jain@oracle.com>
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
Message-ID: <1fae4e42-e8ce-d16d-8b2f-cada33ee67bf@gmx.com>
Date:   Fri, 7 Feb 2020 20:15:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <1581076895-6688-1-git-send-email-anand.jain@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZBGe3yk0OmwAoKJcuytTc6uyFL39D4rAx"
X-Provags-ID: V03:K1:kfAg1O1v+ijBqZoPPwrZHqqFbJiu1BDaQMJ1TsYXBbk/r4/eM4Y
 0ZPPJHmlktN9lUybPsST3ocJfNCLqqK4peapHAWXgHCra5VtTtyOuwXOFLHMsmYxZmRjBY0
 1sf8Lccx5cYGB2eOK/flIFe7K3NlqEmtFEpd51fEoYEO/5OvgnP6L6SussD7PqK8kxzkhC3
 PSfpLN6XLVAEbIwIzTn/A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ydzLoMc7uS4=:tPQ2jKzG1PuF/HNJBKOIjU
 JYVaA4VeP/6lbfy6C3OAjwoC+qFytMwMJa0eU9b2zQ7ItuR//ZlkCSbl5dgGfHFhboWWMkpdu
 Y1qZNrv0ryKlyDjVH7HyeCHqzZQBOTAOj+zVzh53cffhqjCo/njTN/kBEmRYZEgA3Kdtm5Yya
 62SzmNYG8txuBSpSzkWT7Wpt+tHMxOknia3n9exp+fbbxf6M+etMPzM0nLOEr3RKxTgIItPOZ
 stL2Jmy8a+PkFiXgCIDSlTxTlnkEhCwFETDvfrC5Bpc/UWziBT44JOLfKDKARGt5lsWvfqEF0
 /x2QJyp52RIbQ6JwT3VvFQNfdb3U6j6vc+QDiOs9gt7Na3n6O5L2eIxr4HJhmo0nHsemhYYyn
 GZl/a1h0r1cYXsyypbMGKyl6TdWAukQlqTKKmYERGqTeslGiddRnqhY20zL+pg5tNX9VgwEJI
 YoXPSNtxfsBeirBe+SwQfdxhCvDdMDoQfeJJAnid/fh2LmKUa7FtJI39ZD+XvUPQHp3v2Qras
 uqqZ8t/BtNr5x7CKQafT38mTsJPPcpuRfCCfi35h5QpWB30bkkY9f3miEMAex43c2TluTnggE
 NwM9eCVukByDbSOBVb6jrLBLunY2m0KvbvJlZSlPS/Fuy+wxJ5XPVNPRTmHk9qX724EQwbPny
 r+WSO7p8bfhGG1wTpIxaX2TXx+I2CunqMiEcpkadUMlhAM73LyQUVC3f//0MlwlKVSgDWfhgN
 ES+udYyjSDxE/Gkg/9h74vKsfD9KBxDQ1RlGOfpXrxIaVUWydGi6+PTiq2IlbXZg8dhMYGp4X
 N8cwmXlDnyDAJEeIzSqkqHFaApueXIukTEHToM62SroMbCV+x+ArJe4kxMbJOnvyoJ+Ng7iu/
 9AI11/YYXzVNZfN53rBeiwtkGzq0dy3qqHFJ3D3EBMwNTPb4zA9l7reDVkynRCIPZZDU+BBrT
 0i/jSth4EO+9ijqGlDG4ASxDfDDWrze7UBypx8TF5dWUBdMVC5BJiKOoXw/nB2k3HrBZMJnOQ
 CL5hQLLCkBNneRb0Yw1I2n7PWvdFSQuZgXtLP5HL4XkJCxiue4TKYPiKbtFJySicTQMPx1rbv
 e5RmvaBMA9bORAMKG8Yhxjk2mAaTj4kxG7wwmo2VWKJ5Oop5GheNQooVSxH/Me0RcDQ6inej0
 pm2lTzaJwhGXVRE46iW+gyhMrgFdJ2g60JyGD2V1Q49WvTebfnZU4deUtORqGfDIDZCdBQiIm
 5oY6VtufsxIobmbaW
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZBGe3yk0OmwAoKJcuytTc6uyFL39D4rAx
Content-Type: multipart/mixed; boundary="jWRYzSkahiaysplPhFVWp9XdRoC7JtF6x"

--jWRYzSkahiaysplPhFVWp9XdRoC7JtF6x
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/7 =E4=B8=8B=E5=8D=888:01, Anand Jain wrote:
> On some systems btrfs/179 fails as the check finds that there is
> difference in the qgroup counts.
>=20
> By the async nature of qgroup tree scan, the latest qgroup counts at th=
e
> time of umount might not be upto date,

Yes, so far so good.

> if it isn't then the check will
> report the difference in count. The difference in qgroup counts are any=
way
> updated in the following mount, so it is not a real issue that this tes=
t
> case is trying to verify.

No problem either.

> So make sure the qgroup counts are updated
> before unmount happens and make the check happy.

But the solution doesn't look correct to me.

We should either make btrfs-check to handle such half-dropped case
better, or find a way to wait for all subvolume drop to be finished in
test case.

Papering the test by rescan is not a good idea at all.
If one day we really hit some qgroup accounting problem, this papering
way could hugely reduce the coverage.

Thanks,
Qu

>=20
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  tests/btrfs/179 | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/tests/btrfs/179 b/tests/btrfs/179
> index 4a24ea419a7e..74e91841eaa6 100755
> --- a/tests/btrfs/179
> +++ b/tests/btrfs/179
> @@ -109,6 +109,14 @@ wait $snapshot_pid
>  kill $delete_pid
>  wait $delete_pid
> =20
> +# By the async nature of qgroup tree scan, the latest qgroup counts at=
 the time
> +# of umount might not be upto date, if it isn't then the check will re=
port the
> +# difference in count. The difference in qgroup counts are anyway upda=
ted in the
> +# following mount, so it is not a real issue that this test case is tr=
ying to
> +# verify. So make sure the qgroup counts are updated before unmount ha=
ppens.
> +
> +$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full
> +
>  # success, all done
>  echo "Silence is golden"
> =20
>=20


--jWRYzSkahiaysplPhFVWp9XdRoC7JtF6x--

--ZBGe3yk0OmwAoKJcuytTc6uyFL39D4rAx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl49VOwACgkQwj2R86El
/qjAQwf/VReNtrdbWSwUv0JgF0whsbY92lnFkCuS2gNP61iS3QmeJx1vKahpPK/m
9rEFfcvfayBi2Yujd6IuCXGuVjDOGS1EAvv2dCWrCQSj1SKyrGUWslIer0+D49Kl
Qkit2OUTSTjFpqSfbzazsAhca3aCDbU993Ta2VrTqqg1CewTeogvZ8cQHewxnZAJ
76IlYGob+6MCwZxhhSJikt0IkYvXIa0C5kf2/oK6JcAunGoReO73jG10eIYueMCW
VEDvRnjUTdsJR7hUXGKVN8RIbzYdwYn/sNepwzDhGLOZ3LBgs7ZjPwTC/fZcsatB
cwQ2ul86JK8wFOtKSLq5XSAhJQfbSg==
=iw2s
-----END PGP SIGNATURE-----

--ZBGe3yk0OmwAoKJcuytTc6uyFL39D4rAx--
