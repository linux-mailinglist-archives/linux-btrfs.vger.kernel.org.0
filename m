Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4B713A12C
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2020 07:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbgANG6N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jan 2020 01:58:13 -0500
Received: from mout.gmx.net ([212.227.15.18]:59807 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728680AbgANG6N (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jan 2020 01:58:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578985088;
        bh=T5abS0iqyMdbt/lL451aTGduWL3Z7kc95vxwCr1LoPs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=QsONTY3n6vLPrlpb5AMNbInbbGQoJwbWl147gICsPkCfIhSymYXtv5Cg+FPEOSzgk
         eIw/xUpOGdMnFca22oPS2W1HyflHT64VS2yVhODkuX714oU8pdM4Lc2wlyd3GrX3up
         5MrMxGhpmzgfgq2rgJEy4VXtuXDnhz2hAL7ITGnY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MRmfo-1jFuWz1giY-00TG4f; Tue, 14
 Jan 2020 07:58:08 +0100
Subject: Re: [PATCH 2/4] btrfs: stop using uninitiazlised fs_info in
 device_list_add()
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.cz
References: <20200114060920.4527-1-anand.jain@oracle.com>
 <20200114060920.4527-2-anand.jain@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <9c548a6f-dc44-72f5-0d92-855af2e22b68@gmx.com>
Date:   Tue, 14 Jan 2020 14:58:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200114060920.4527-2-anand.jain@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CwcwkZRJFmrNuBFH818WVn3SWrdcEmYiJ"
X-Provags-ID: V03:K1:DdOUxpGYDg2/q9YwAorsTwuIwzUjk2By4uNqKfTyEeH7kuFrZCT
 B6Q2pemhVKuWALMHTEuSWIYmdg6ppKbrO4pz++UdETofdroeXmZvTsSaMaEtiaDHEjwT4JQ
 C1HfmwUI/+94PxQ1qy6SVdfwJEpPucmtAQCgy0zXsNnt8QLkam3uLs5w4cclSTbntqNd3kQ
 8W5iuKiCvz3lrbCKYATtw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rgr2BypU5a0=:aOurksH0in1BMhSdyFOupT
 A7UHpvAxMgGcbEf7R6aULIFBWFjsXfrW4i1ee6JdYDEySx4hJ9FG6gM1wCw/9Ns7fve+P9v9z
 g691K7f5alhFvutgOWHE60RoN1LEfWwHRqWnLDzZ6fTxO9EXmEwS9d+IN7v3Q/hm1DJVI9bYt
 ZPGNN4Q+hEfBnZ1VaweQfjfWm1i22PXrWwl6Kt3A+HEz3IOrRIBM0nUwYUNQxuSL0a6cFhc6W
 2vo9kmiyv9xu8xcE5XNMlgpoORzpozEGfX+LQ9uiudP1M29kTvDKCKaCaP+WzeFvicIjMJWTO
 mct7E8fey36wNPZUn2kQpUeJRjSFKD/PuDc95UQ2U7xXV6k5CpaadVoas7UQgFVt4oby2u5RJ
 jQJ8MTJncXTaIEltH9YLAG9ut/EOrHbUovFtxQraDfu5DpwR6/6rGKy8dFVCdpXHOwwTWkxln
 0jcUt3ZEBE0kRPLCISFhXeOwiTsplCuls6MPJ2Tb1qWzCQPG34So+OBXtswVCKVyB+mPotJmx
 XzRaC3QEn/WMNUb0Z3hBjAhmmuIVyscx21sXl4+GQGxUvKYn0lr1Ytk0u7Qnhuj8JNTm60KhF
 zvnvdD4ITJfe68LMKJUCxxkLszcHCO+JPrtrg6mevuRS+gEUigoYohS0N6XCGhORIxkfctI+z
 5ZM1VDz+d9r16goKQ3GkHcNEyS9N/KqVaI4XMnsSXaDw0zAkUq28D4kAR5J9hc8YyAtRKFwLx
 QwTlgWWPqJdERrFOkplzAUlt5OTLsKsYkDjUFlJ0YhPtXZgtTWIKZZRm8wgTKWVGlv47jnCoB
 YzyIKqN56tuL0e10wuRjcHFAdZ+WqC1wTFw8L4iI3L6Z9sb82oWulQ15nlhQaYGvKPPX/TThR
 hWxU9Fj82Pvtat6tP+CgbiIWkSpNISYIW5BhbOLlPnYaVrQ1e9Df1HGFuOWTJ/HPvs/xwt0Jz
 WSM+DcTpoITb2ctUy4C0bFwMceJEmcCLDyljKbsJFrptFUGcq0gcR51N+eLiHVt/+MlA/AtKl
 bq2nQKl9uoaIU2rPhSaKTHnwG5FI+GsvqreEVVIdYQ9vX+/IBhBh3JHpcDtMpXIwkn5pbeAX2
 XBqxAlYomz0d0C33JI4/VnusGOfPGk6QdQ7KoCfedmZ3hxKr5GQkTaI3lWBxdquEbIB+Wrsn6
 4hZQVW11rgC8RSKCCsb5C66zJptYjZj2ulCB6dfgzCJn7BPjm/rc1NSVJKUoYIz888GG946kc
 mD4r3clrwuEMti0VdkF9bDONulRyNtOz2f7sCL5yHh97vYvj0ffkNWEwQ+8U=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CwcwkZRJFmrNuBFH818WVn3SWrdcEmYiJ
Content-Type: multipart/mixed; boundary="XpmSfhPLUeTxnFNYecN8JEHsfPm4KtoVZ"

--XpmSfhPLUeTxnFNYecN8JEHsfPm4KtoVZ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/14 =E4=B8=8B=E5=8D=882:09, Anand Jain wrote:
> fs_info is born during mount, and operations before the mount such as
> scanning and assembling of the device volume should happen without any
> reference to fs_info.
>=20
> However the patch commit a9261d4125c9 (btrfs: harden agaist duplicate
> fsid on scanned devices) used fs_info to call btrfs_warn_in_rcu() and
> btrfs_info_in_rcu(), so if fs_info is NULL, the stacked functions which=

> leads to btrfs_printk() which shall print "unknown" instead of sb->s_id=
=2E
> Or even might UAF as reported in [1].

With your previous patch, which already checked NULL pointer, I didn't
see the need for NO_FS_INFO.

Or do you believe this calling site is a special?
If so, I still didn't get the point of NO_FS_INFO, just extra lines
using __func__ or "during scan: xxxxx" looks enough to me.

Thanks,
Qu

>=20
> So do the right thing, don't use fs_info instead use NO_FS_INFO in
> btrfs_warn_in_rcu() and btrfs_info_in_rcu() for the btrfs_printk()
> to take care of it properly.
>=20
> Link:
>  [1] https://www.spinics.net/lists/linux-btrfs/msg96524.html
> Fixes: a9261d4125c9 (btrfs: harden agaist duplicate fsid on scanned dev=
ices)
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/volumes.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 6fd90270e2c7..0301c3d693d8 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -889,14 +889,14 @@ static noinline struct btrfs_device *device_list_=
add(const char *path,
>  			if (device->bdev !=3D path_bdev) {
>  				bdput(path_bdev);
>  				mutex_unlock(&fs_devices->device_list_mutex);
> -				btrfs_warn_in_rcu(device->fs_info,
> +				btrfs_warn_in_rcu(NO_FS_INFO,
>  			"duplicate device fsid:devid for %pU:%llu old:%s new:%s",
>  					disk_super->fsid, devid,
>  					rcu_str_deref(device->name), path);
>  				return ERR_PTR(-EEXIST);
>  			}
>  			bdput(path_bdev);
> -			btrfs_info_in_rcu(device->fs_info,
> +			btrfs_info_in_rcu(NO_FS_INFO,
>  				"device fsid %pU devid %llu moved old:%s new:%s",
>  				disk_super->fsid, devid,
>  				rcu_str_deref(device->name), path);
>=20


--XpmSfhPLUeTxnFNYecN8JEHsfPm4KtoVZ--

--CwcwkZRJFmrNuBFH818WVn3SWrdcEmYiJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4dZnwXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qh/cwf/Wim10nKRkjOi8cq8izE2RX6l
Yyc7qAhZQCBcsvlj+UHkJQh+mldOFyabwZ8ZuF9qfyyC+pVIiLJCpdQdPDy6P6nl
N3EPftRsqNP33G2fKmNNOPHffA/1dXuJqZaG3LLsPGUIfT9Kq+866OVbX4jwu4BZ
Kew7gAuNr3ciFGs/4RjT+VKQkxa2RcCAAaPPottBZFt0+dTKUoff7rXlQ520V+y6
7qYCuXdnn5j0tTtK6RjmhRAUTCD/sM5xsLs1FnlhfohGV+xa6ET1kho+1b9HEMoe
NgoVqJ7FWbhtxONmtSbczeZCsM3EI42rh0B8S/pS2vFTtUvBBtcbnnQ8fHX1QA==
=DvcO
-----END PGP SIGNATURE-----

--CwcwkZRJFmrNuBFH818WVn3SWrdcEmYiJ--
