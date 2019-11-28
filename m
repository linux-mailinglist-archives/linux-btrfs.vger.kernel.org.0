Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A58010C0EA
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2019 01:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfK1ABk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Nov 2019 19:01:40 -0500
Received: from mout.gmx.net ([212.227.15.18]:45651 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbfK1ABk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Nov 2019 19:01:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574899298;
        bh=vAg86OpG68ViyXC8kJ112rpExZmpZQLBCoEgqF+UV4c=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=EsHsEEcYm/VO3AZziTZGmdAkktxig4pwUWKW8zrv9wGm1Fa8YU9JOGdMC3mY88nut
         1CKOherbkLxLJtHFMQEXAFriAj4hZP/lI1dSI1pqyEg2tv1GgcLFjjyUB5YXOqPbtC
         vwwk7EVlhvNyaHVgT3rCCATLzlln0mlSYjzfrUFU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MFbRs-1iahbz1hyI-00H8jg; Thu, 28
 Nov 2019 01:01:38 +0100
Subject: Re: RAID5 scrub performance
To:     Jorge Bastos <jorge.mrbastos@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAHzMYBTXvY1VgcoFDUvc2NFmVKq2HJRHuS0VXzoneUMh79cySA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <2b0e5191-740f-0530-4825-0b0b6b653efb@gmx.com>
Date:   Thu, 28 Nov 2019 08:01:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAHzMYBTXvY1VgcoFDUvc2NFmVKq2HJRHuS0VXzoneUMh79cySA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CciErR2xCHEusveGqdQMBgT9iFhBSywrH"
X-Provags-ID: V03:K1:MmZ3pmX2/l+C8xnSbuyrtfxzTtyQYoywIMj8cpE5s0tkNFSBHZL
 T9nwGwGZIMnO4sxqSoseMlovGtls86U10xztSk7XjA8DUjpM1CJy+lx+uFEDTFmMxM4b/d/
 Tt+xiG8DVJ4fDhM3Ywjiw6K/KTjppqk7dgPiyCB8EsZQNiMURHsRAtzA6xyjzE/XQrD+H9r
 9CKdPgX4S4WiuDQeAh56w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:CRpysEp6Dgs=:Jb53RQfPeXMYIBXUIkZ3eC
 q/gRPuq/mp7nvD0RTjkWGsenLzbnjDYlubpTk+/fwdJR3B7cqRKWplhkURJ+wZxxqVJgmizn0
 hP1p3E8jRXAEvoO7JGuOEvXdVGDLSiJfddawq/n6SUTAO4awMWJU4k2+OXBhNuML+1BLVQBf4
 7kkz171v3bgUBTrAVumHJ7OWND08wEDDcpPqfxqlus30eg+VRcbLUZqXhM864C5Ry0icICic4
 aQrxziZJ2/TJliwtxQ24piE3T8+bFSLX+yuXU/seHdhswwSbVLlEwonnGseDHdAJ8kb6iZCBE
 QHVl1pvT+vtvSj9asrBmn6MAeKXNEHslmL6sExlSARqbbMQPuzu8Q1btXt+3sGW2mBVyyN2PD
 jKgtQq6PYFJ3TsYuu2NAqe47p3U3oowZ2DeJjY53kHvmNAcYX42mQIh9+QnjpLIGc6eN6PYrx
 sDXD5ndsOswcLAHj3RrlWsOvNiUknwVZtWMhXR2n25XtT4WNAf4ScEEwq/uqVFF78xZqBj9IE
 pfBovX6ZcNsaocAJMAiDPu3ey5n/ElMnG5j1of0RB6+ODZHRvItRRnVzUjZ6szNiNkwnJGg83
 SbbX0WWq2deMc1HMCcn4/AmfEI7Dx2ffsVORg9HlrX/yIzGbDhfzJ24vi7yESQI5foiFVt5P2
 PJ9c78edSvcALtoy6wf23tVc/qqctOb+hd+8rT19wrdz58NqUUACa7HprMjU8bU6EKRyBVJUv
 GQkvCI1nXvdd0X4oeZ1y0eJ/M5Y/BAcA2HXnozQlWJiUPO43U7p79uvGEJbDN9Py5GOs4QpcQ
 VPu83EzYtKgdGwoKjHdCgdGaSFf/AR5/C04btdiWu03IJRo+LB1y48j0ck0Gc/9ASzzpHyOta
 I4ennJjlSBms8cDaOpPNEla38z79GEfaZ/ojDLUvEosMPzbSosSrcFZBuE7qVz4TRgElZqSct
 EtcvpkTCs3yPnEftNlRSlN8k++nXCuwS0pIZj/+MPICxaZAfM9Y7Cp78Nu9nW22wqmOOSIH63
 81d/qtnX8tQs2f3H5az2dMpFusAoLIAPX4r4uTxapSadg37ETfA+D65Fky0+c76RZ4gybKTQV
 dtHzvAydaxKOw7binndbD8NZMSf+Wal4u67s6tFvPg9tEekN2WBYlrRn0WB+1Sv1we8NAfvUu
 xK3EVTXPvpuan7Pm+edV6hm3XwtIvNd6Z9Gb2d0IbdbyqDGXZnyKL4mxJMISBQSx+xIrm1lgj
 KwX9dQHUGTmlatDh179TFVBMqcIQFzz75QWj7iKKi7x2RQViDA64uHuGKHqc=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CciErR2xCHEusveGqdQMBgT9iFhBSywrH
Content-Type: multipart/mixed; boundary="jf7xapDHyOnncS8rJJaGGtqOOQCYxF708"

--jf7xapDHyOnncS8rJJaGGtqOOQCYxF708
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/27 =E4=B8=8B=E5=8D=8811:11, Jorge Bastos wrote:
> I believe this is a known issue but wonder if there's something I can
> do do optimize raid5 scrub speed, or if anything is in the works to
> improve it.
>=20
> kernel 5.3.8
> btrfs-progs 5.3.1
>=20
>=20
> Single disk filesystem is performing as expected:
>=20
> UUID:             9c0ed213-d9c5-4e93-b9db-218b43533c15
> Scrub started:    Tue Nov 26 21:58:20 2019
> Status:           finished
> Duration:         2:24:32
> Total to scrub:   1.04TiB
> Rate:             125.17MiB/s
> Error summary:    no errors found
>=20
>=20
>=20
> 4 disk raid5 (raid1 metadata) on the same server using the same model
> disks as above:
>=20
> UUID:             b75ee8b5-ae1c-4395-aa39-bebf10993057
> Scrub started:    Wed Nov 27 07:32:46 2019
> Status:           running
> Duration:         7:34:50
> Time left:        1:52:37
> ETA:              Wed Nov 27 17:00:18 2019
> Total to scrub:   1.20TiB
> Bytes scrubbed:   982.05GiB
> Rate:             36.85MiB/s
> Error summary:    no errors found
>=20
>=20
>=20
> 6 SSD raid5 (raid1 metadata) also on the same server, still slow for
> SSDs but at least scrub performance is acceptable:
>=20
> UUID:             e072aa60-33e2-4756-8496-c58cd8ba6053
> Scrub started:    Wed Nov 27 15:08:31 2019
> Status:           running
> Duration:         0:01:40
> Time left:        1:40:11
> ETA:              Wed Nov 27 16:50:24 2019
> Total to scrub:   3.24TiB
> Bytes scrubbed:   54.37GiB
> Rate:             556.73MiB/s
> Error summary:    no errors found
>=20
> I still have some reservations about btrfs raid5/6, so use mostly for
> smaller filesystems for now, but this slow scrub performance will
> result in multi-day scrubs for a large filesystem, which isn't very
> practical.

Btrfs uses a not-so-optimal way for multi-disks scrub:
Queuing scrub for each disk at the same time.

So it's common to cause a lot of race and even conflicting seek requests.=


Have you tried to only scrub one disk for such case?

Thanks,
Qu

>=20
> Thanks,
> Jorge
>=20


--jf7xapDHyOnncS8rJJaGGtqOOQCYxF708--

--CciErR2xCHEusveGqdQMBgT9iFhBSywrH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3fDl4XHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qgUvAf/YysTIKHoOQ03s+HnTmmfN6gs
8HAUTMQGdAEwCvjyhEqU1+5i5ZLjVdLJjHLtoxnCSHOHaNb7Oyny+klblzy8H0yu
pTjFs8aJmRyTb+N7/McAKNjlmIhgO6El2SpntwEWB3qOPxEmvwMVg2yH90M6/x9/
UVu6uT/omV32ETqVjk2Ci4AY9HJ1x56zzgqeJKnjj56E1O0cQIpZsB8Ht0Rx880Y
E2YJ7UbaReZiLD3hSMGcPp8jjcmjkbAOl5WbGAAaRyXMjpQTTS9EsDuwOx9JlUCO
v7AXg8GqoOurRU7RCgyBCSJHgUioLb0/vVNW0HNnNG8Fqsh+SY4RcZW88MtiEw==
=4FqN
-----END PGP SIGNATURE-----

--CciErR2xCHEusveGqdQMBgT9iFhBSywrH--
