Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37C9D123BB3
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 01:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfLRAi3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 19:38:29 -0500
Received: from mout.gmx.net ([212.227.17.20]:38517 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbfLRAi2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 19:38:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576629497;
        bh=8wxV/ycpQWURe9pQGJEDA717gSBDlBhk18OqCwCYoyo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=CIlY3VIJ5CSSpzTli+MLh42mN2/Ytn5EJRk81F8fwdvYJ8BpQFnDN5y80PP5sKpDK
         obOfVlkzy6CoRQx6Wm5Zk61ZeLguciTGFHpXJmk4DraqPEedjcxV0wmDugBAc0Brzk
         vg1pfTTC4R4lWDlG3XlU9ec6FVcUshb5qunA4K44=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MGhyc-1iUg1q1yHi-00DowV; Wed, 18
 Dec 2019 01:38:17 +0100
Subject: Re: [PATCH] btrfs: super: Make btrfs_statfs() work with metadata
 over-commiting
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     Tomasz Chmielewski <mangoo@wpkg.org>,
        Martin Raiber <martin@urbackup.org>
References: <20191216061226.40454-1-wqu@suse.com>
 <488111c4-03e3-2211-a8fe-5bab7c0f030b@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <556d6c05-9b6f-632b-561e-114b277d64ad@gmx.com>
Date:   Wed, 18 Dec 2019 08:38:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <488111c4-03e3-2211-a8fe-5bab7c0f030b@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GMfSyuPaXikOivscWhu2WFIxDgsnDGeNP"
X-Provags-ID: V03:K1:7z1Bs9QucJQH3LpOYIkGI/uThkChRCa87vExpaMbCMpsPb7hHOF
 vkMb4DxWn6KyFyhULv46UJu2MrQVuM8qLzn/vSRK94+oK+xNyvAlAn0PdGuvacv5CYo4w5E
 g3+CaHoV3/kYf0Ouom1oL31VAY9O6WkF1Yx9kgHCfri8o15z4eU67XseeHWhz47Eg9mZvKz
 4nB7DBLth7RnQUlOaSvwA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UsurJNEtC74=:nI/XsppuPsHEqWAWjETUBx
 3CjIYO68lHbu/f5eJJeam58spfvSN54Vpy88iVB0FTm+XnOwLpDEuZmFvFhLuAghZbxhIcfrU
 ngO3PNfN4MWgymSYb6i6WWzH4QgXWQRC9wHdJO+cWvqRlPDwSzvJHnUfBc49TfC5gODiKacI+
 8XpS0JJ7n7WQAf/R50nKPdoDKN3ced9zGyjZe2Kr2DhXzEgaIztWVkaqm0/XRkkIaPpgRYRdf
 zcJ2xIg7EBOxomRQUYSWRvp1DyvSaQ5O07gja87h3WRGyhRjy6VzCcNQUS+ZnzjCA4pZxU5WI
 HsdWXz7i1kThl4KCpNQQSSYhkhvWue4fXjl0X69laQu2aEHys5xzgv1FC2Sp5b9fVqtaO6dzr
 ar8FuV4yi7oKLV/N39QYJYNKyUX0BPx0H4bwcYq6wTHM+usnu8LdiyXVeQXUjbig0eNV6Qofn
 ewjR+59Pd3qJ9Td4OHf/9cxYgTdkPHn4ufq1qONHjgpPCfW2vVGAfhcVGeRX05Jiy9fTzxFb9
 ofRhiQkxl5E0qpqV/sDEsRszttMJQbChOfaCQmGeG0evBGrs4uiAclSubjgIxOlIav7/d/NBE
 3MBpr+nQf8EV1z/UhR0rMmiZ7+agOIEZbrTO3GFUsfu+7fL1gPYX0X1rAQQ48AnwzEV8mSTev
 IgJE944u6ZFVtl/Agl4AGeIyxLgFqg7+yYnThgwxzXXaDQSxTuyZPbHGpxDgSCtVWGgjI4WT1
 5Wgb7D/ZXmnqljsutDVG7lHiPB8zxLBwuSDutW+V+YRyInCERX687xUiKz3ThTX7s0UCYX5GQ
 V/DGDHDwcbsZGuum/nz/EhAN6nMd1l2ehAI093C7U0MtkRKhCydlMthaflA/LUFMNBurn1yh+
 TZKB5VSutg0w4vkp7oTxQh3DRk3pQ4sdw+cMyId9q0uKlRGs71C4uvvkK5IIgZlsusOXLV6UM
 2TXhhtjwIK+4ekRxbwDiSSQGEmFZgPVNUSAQM/YEISKY/YxsKDqTaLxUiCVTn69+oLrWIO5T6
 3Tws83KXFkskcEB4lF4YHRMP05xQpICZzRzN9CnvFmITTBQLuRUz8fDBLK1o7Yfgo0RfuEGYp
 DiKMT+3ixMAjBi9ON1hOMnCCII1V6xUxpigdYD3KmlHubOjzLSd4OimFoDjgSRwInagqLorv6
 RsmtRBKxnbAERehqexSUAf70sYHR4q8F3P217MvpFwG/Rrd+cL+8xAhjhJzxRLnyHAyLjy+To
 fuBWj939nQ+slHDAfRDISTs+aOYYKZZqvRgxE0QSoFSCiQGRaiTDD8yERlcM=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GMfSyuPaXikOivscWhu2WFIxDgsnDGeNP
Content-Type: multipart/mixed; boundary="NhJZ840DOoDKd8zsRr47uz3c54OPmsMQP"

--NhJZ840DOoDKd8zsRr47uz3c54OPmsMQP
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/18 =E4=B8=8A=E5=8D=8812:05, Josef Bacik wrote:
> On 12/16/19 1:12 AM, Qu Wenruo wrote:
>> [BUG]
>> There are several reports about vanilla `df` reports no available spac=
e,
>> while `btrfs filesystem df` is still reporting tons of unallocated
>> space.
>>
>> https://lore.kernel.org/linux-btrfs/CAJCQCtQEu_+nL_HByAWK2zKfg2Zhpm3Ez=
to+sA12wwV0iq8Ghg@mail.gmail.com/T/#t
>>
>> https://lore.kernel.org/linux-btrfs/CAJCQCtSWW4ageK56PdHtSmgrFrDf_Qy0P=
bxZ5LSYYCbr3Z10ug@mail.gmail.com/T/#t
>>
>>
>> The example output from vanilla `df` would look like:
>> Filesystem=C2=A0 Size=C2=A0 Used Avail Use% Mounted on
>> /dev/loop0=C2=A0 7.4T=C2=A0 623G=C2=A0=C2=A0=C2=A0=C2=A0 0 100% /media=
/backup
>>
>> [CAUSE]
>> There is a special check in btrfs_statfs(), which reset f_bavail:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0if (!mixed && total_free_meta - SZ_4M < block_=
rsv->size)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 buf->f_bavail =3D 0;
>=20
> Why not just read fs_info->free_chunk_space and take that into account?=
=C2=A0
> The point is we want to tell the user there's no room left if we can't
> allocate a new chunk and we only have the global reserve space left.=C2=
=A0 So
> just subtract the global reserve size from the total f_bavail as long a=
s
> free_chunk_space is sufficient, otherwise fall back to the original
> calculation.=C2=A0 Thanks,

Because not all unallocated space can be utilized by all profiles,
that's why we have complex calculation in btrfs_calc_avail_data_space(),
which tries to emulate chunk allocator to get how many space we can
really use.

And we also need to take space usage factor into consideration.

Thanks,
Qu
>=20
> Josef


--NhJZ840DOoDKd8zsRr47uz3c54OPmsMQP--

--GMfSyuPaXikOivscWhu2WFIxDgsnDGeNP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl35dPMXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qjRngf+LsXez4UBh+zKDzHRNnvJVLba
ltJZwHLpvgFGKmpqIM9cPKhDe6awVoGQsVz8fhSSq0QDqjaoc5QKsfMKOlDISvGr
xRvuvqP4cNMEUwkDtcunLjzwLqYaTGtgsSsHRtv1Qhyb/PM13d5nAzCOHqHYqU30
VSQUHLcZk8NWJuN/anModSH2NQKTtpGx7PCnJvOtD8/CtqFUYRE2VX7dUsMakNSg
Td4udUrTaoSLUf4VdRgHHH6qPej/xdGpDGPdtjDSU0NoIFHCAKp4iX2RVxXi4oIM
9ZtTrlhSQ+esqO8kYKOSeJdPDwCaa4b/Wa3yYGk45BtP3HgHjowSg0EqOCIBpQ==
=QUzE
-----END PGP SIGNATURE-----

--GMfSyuPaXikOivscWhu2WFIxDgsnDGeNP--
