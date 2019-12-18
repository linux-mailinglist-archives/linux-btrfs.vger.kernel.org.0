Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3BC2123B84
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 01:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfLRA0W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 19:26:22 -0500
Received: from mout.gmx.net ([212.227.15.19]:39677 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfLRA0W (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 19:26:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576628774;
        bh=H8qRhBNRjDIdSDObz36hgjO/4Q7zJyJLAaBVp2qwiz8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=XvExb+jTMExC/J4ivRobev9SYg4UetJpciap6mRezuPJJUncdZ0CuD8o2vbuL717Y
         Fn33ENGJh6hsuLoHmF7Nsx8Dvc+CyRYcDbV8KJFJ0z0YzRLLcSn66ZRtTR+ita5Jxw
         3NqHFAlz5QvthTcynamvTYdKi++kA6b1gyOrdTo4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MryT9-1hvtOS2pSn-00nyx2; Wed, 18
 Dec 2019 01:26:14 +0100
Subject: Re: [btrfs-progs PATCH 1/4] tests: common: Add
 check_dm_target_support helper
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>, wqu@suse.com
References: <20191217203155.24206-1-marcos.souza.org@gmail.com>
 <20191217203155.24206-2-marcos.souza.org@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <076b3709-c702-b7bf-cd03-276115aa5263@gmx.com>
Date:   Wed, 18 Dec 2019 08:26:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191217203155.24206-2-marcos.souza.org@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="adp2fkiPWKQ92ezQyfS2WnkAwJMJF22TJ"
X-Provags-ID: V03:K1:S1rQigW7n/j9piMRcI+K0fCwxBDA5+kPe7sWRQt5e8q0itdbDcO
 mlRQze0aZwblrgBst76mS5v9+CXHGmV/RrQGvtLa8pBeEzTVuclwHjHsvOeMfj5w9hnA9U0
 E3xuYRTylzqSyZ72Zeu77mC8/xUr8nINZlUrO+eqMwWJcYA3CLUDuoQQ3SLGQr/IMxio6LB
 ChdyRAUpnB0JC50bw9E3g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:w9mLGsHlD4M=:QU4AIs6wbeaG1Zm6xmi43E
 MsJ0ZWwa+OE378AVBzrOUxz1n3pQ3tNtVVXWqHcIU+FRXMsE720CxvZl9cVdUUDRRBLDTxziv
 thVGkEBJ/8kvcEUDFa4PDKjt1vzlkA7ak7DyylZdLmAK6UPqH16nhppyY4MtAviBQV12hzj7V
 +3AVQJ9eKb7TrrkuTHPEHoAY4fsWvl2Z1KVD+0T0xn5dzVcg1tTsoaSI9nvtTHwZHaaq9mtct
 lkVhvw2Khkddq4JaQV+XiwBhx3CFeaYwG1qosGn4gJ2+HmuasIwCK6pztEnYKpouZP7T2QjIL
 pGAr6bF+GRqigKaZPl/7r9MeMvLmJfOWV682y7ytJcHtv/1TnELgxcnMkkY1LnP5kyMF+AC7V
 /Q2ozSGTQgTdK0GzfLQQxGW/p6jDA73IJPSwciYX+nXTuDaZhZ9WDPXvhbGJ+AgyXYEpE0u6M
 hOhQWKC62hktKyEpcka2Hlpk0B3lu7HohzzwtvUtckxLHvBaPcmsNT84vS17eGaf2SrqRYTDD
 nJ+J8jzlkDiX27ISwn6ZrmIUq0/bjS7K6bAMHOSObRfYhzZhRFftYK8nJUf9hB3eQj34pruT1
 EJsvnJ8TzjkRXa1wCKXTQBl9Fs6yxv5dEnS+Uy+6RFLCviDYxZYzxSzfke9Pc792V8LP+gqi2
 N32p5hIZeb3OgmWG82m88h6lPWMMHPUlhl7oamANG79i6Go0yDGOaa1MoRM6tPWhVHAGTTohV
 bMFwlSBbf/VOAm57/vcNBrU9zWTGL0tgqJqa8L5fXSTpEAqseSIR2m+nQo1Wy/aOY5Zsix31q
 r/yMsNDT3hXN0xIipgIeTp0SrB8/Zijls9ZMOLnFNeawhvD1s990r7oFC9GhtkgyIMy59wPJ+
 GQFhiEzW6U0yyXbIgd1H15PPMFqy30lZoL6xK1Gw45wKs57MeoGhTN24fRAfbLH4LYAmdbXQ4
 FY+TPRlGkrkaWDWmXmwz3P7Ht5YhE/0+fISf1HS8MiCucMqK2AuEKN8aofYi3y8EBneyd7jTk
 6qJEQDJTKJZh4wwQmYNdfltyt94pc284K8o0n1dW0Xv5vgJs2RgqVT8uPCyzGzn+wd1akrXcd
 WDmYcLBWUJkOWu63mZ67zzCiSeggka7MbaY/0OFjtHxBfqI3uqMZFW7M+8xlSL5axoyzMUxxY
 BCWzQ/qquhSXfI70SWLFFZ8LvE8dZg/6/Ubm4/TpCkVyXjudyCjBMz7tF64gVYMM8i9+ohVMy
 ZI8eDCTG2u1ZVtk44E4ptK8Qcx85uzZklVZgLAvGyytYV0J9XphqTWRALDh4=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--adp2fkiPWKQ92ezQyfS2WnkAwJMJF22TJ
Content-Type: multipart/mixed; boundary="w8ug5Fx9Pz6oBmG2PXiCXjMqPjX6ELJ4L"

--w8ug5Fx9Pz6oBmG2PXiCXjMqPjX6ELJ4L
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/18 =E4=B8=8A=E5=8D=884:31, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
>=20
> This function will be used later to test if dm-thin is supported.
> Inspired by fstests.
>=20
> Suggested-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Looks mostly fine, but a small nitpick for the SUDO_HELPER usage.

> ---
>  tests/common | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/tests/common b/tests/common
> index ca098444..f138b17e 100644
> --- a/tests/common
> +++ b/tests/common
> @@ -322,6 +322,19 @@ check_global_prereq()
>  	fi
>  }
> =20
> +# check if the targets passed as arguments are available, and if not j=
ust skip
> +# the test
> +check_dm_target_support()
> +{
> +	for target in "$@"; do
> +		$SUDO_HELPER modprobe dm-$target >/dev/null 2>&1

To utilize $SUDO_HELPER, we need to call setup_root_helper() in the
first place, just like all the other $SUDO_HELPER users in `tests/common`=
=2E

Although nowadays it feels a little unnecessary, since the functionality
is introduced because I'm a lazybone who doesn't bother to startup a VM
to do proper test, but uses current unprivileged user to utilize self tes=
ts.

Maybe it's time to get rid of SUDO_HELPER ?

Thanks,
Qu

> +		$SUDO_HELPER dmsetup targets 2>&1 | grep -q ^$target
> +		if [ $? -ne 0 ]; then
> +			_not_run "This test requires dm $target support."
> +		fi
> +	done
> +}
> +
>  check_image()
>  {
>  	local image
>=20


--w8ug5Fx9Pz6oBmG2PXiCXjMqPjX6ELJ4L--

--adp2fkiPWKQ92ezQyfS2WnkAwJMJF22TJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl35ciEXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qjkewf+OvMX2GPq4tcbC4Hw7193kMv0
/KXEOUxz+TQCJFa2BX7w2mAVsLMVqiDAthhKhMx56pG04CXdDpVfX5hWydJqJTyl
WFu7eb+qOHIDKvnSdCA47zZoAwHJuvJF5PSqbnrdOU9iZqbXb48rNQWgYUtNgGAm
UcwqPBMf3uK+n7YTfXamAmWaPBxayNUebMyxs4l06UMpoJqQmNJ0M3yX+pCGftvT
/qwpt1m9wKWyj6Mc4knqF5L4m0c9goRC+OdRtQB3v+pFeCo97cSi/1QiFo1LVCYe
juiYI+jHLuDaaYm310l+ZBNy+lBDCEmlWiqxGjT2GikCBshsiawvT2f5q+asiA==
=fX4X
-----END PGP SIGNATURE-----

--adp2fkiPWKQ92ezQyfS2WnkAwJMJF22TJ--
