Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B874E56403
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2019 10:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbfFZIKw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jun 2019 04:10:52 -0400
Received: from mout.gmx.net ([212.227.17.20]:52699 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbfFZIKw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jun 2019 04:10:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561536649;
        bh=eFVwkxyBNt2Ghbe9jg2UoeazBz5cCG7Ack+ITspq6qs=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=HD8HlXp4eaUSZKNnKvyHVl0owZbioh4kAObjwVvfV6/ApBeyTOZUxGR/fDM3AQRwX
         j2xl/SukAkPXkNR7Uy8mA9PO/7JRMWiRlV5I3oMIttp5dgsaB9kJrQMEFPxn4sFS92
         L6OHHmHbRoaVGoYtwsOmJFldKwoVzbM2NRDgRv4w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M1Ygt-1hhPvP1k1T-0031wG; Wed, 26
 Jun 2019 10:10:49 +0200
Subject: Re: "bad tree block start" when trying to mount on ARM
To:     Erik Jensen <erikjensen@rkjnsn.net>,
        Hugo Mills <hugo@carfax.org.uk>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAMj6ewO7PGBoN565WYz_bqL6nGszweNouP-Fphok9+GGpGn8gg@mail.gmail.com>
 <20190521091842.GS1667@carfax.org.uk>
 <CAMj6ewPKbRA_eT7JYA9ob9Qk9ZROoshOqaJE=4N_X9bPaskLUw@mail.gmail.com>
 <CAMj6ewOHrJVdwfKrgXZxwfwE=eoTaB9MS57zha33yb1_iOLWiw@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <8aa09a61-aa1c-5dcd-093f-ec096a38a7b5@gmx.com>
Date:   Wed, 26 Jun 2019 16:10:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <CAMj6ewOHrJVdwfKrgXZxwfwE=eoTaB9MS57zha33yb1_iOLWiw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="A9N8cIjYTWR7Dk3CzRRdxWMhZeSWFGiv8"
X-Provags-ID: V03:K1:yuH6RQplNsCCDkgopXEJoDkhddiTMIDj+kb7Wbvb1xEkWwvigOs
 cqtRQd/c8LV5tcX7JV9umryu8o2RhTuGKvsLfEUY3XK72gqaQ/00pCDKnaFAIXhGvI+Bd2l
 nFhIejcTLXJCbhhBlZcu1+xtzokrNAxieKuXa/CdsyqVkpMTWZimykion/6+UQbPtQxHMZW
 VrhjvrtGBTWoTQTQsCCPQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:m50kSt7Oouk=:uDaLQiWoEXxmVhVehlgJMU
 1JYVcJbPn0+r+0Y4ANzvLJjaFgIq6J4NOSsDf2u2VvrlCMZ6gSrud7nwNyGgLNqGs+qC5yxVQ
 ZgsWFgGCDkFHSHefcHup+FUiK4DgEiV6ux3OTBCfybWO2ldPRuC0RL1kkDFDOnbbJBHTf2JIh
 SmjnnOliIkXUUzc4ROn9LcRsDjIchI7f5fEI2EpRtsjDysjb2B3Vv5FWjdLrRkeyyA0nIKcUN
 0excF/0D9Rip9EJSYCxxRFHoPbxCoKDlKUej+V0OcP4SyZcZEhdAFoTRwcyKnWUjpN1hv6RVD
 +uNR2B9SkZ8WWL5mSiBpzpCB5LUyZ/ZAnFT3hCu10jt4QdBno2zSlvbjQVKiiOCiEJ4uLk0dh
 nEfX6CIWXT/qGXBOuh5lJy2o97w+1HvZ4g3hWyBkIKqEhAWUKSujc2YwqucM3N7+TAQCkWMiv
 MTLpM1fSGY02q4xsQX5FWP7nF/Kh0Xf7v9ZC1M18t7Cwkj1Btr/RDRPd1zSfWq0RXAyGSHrrO
 0MgobUYE1/NA/z5s5nKn4O1MTSrn6AgjWQSPSeOl5PYdFImlgssM/KE2cI/FQJbyW/aF2RfVz
 R1UjvxvvjECTiXAQrGFoHxxi9esEV64hZ0AQB3jJ2pIgIiNkXQzMp1F6c7i2k2STT1y0sUe3Q
 c3DXPovpIeeF3hWsh+FjbvxaRbgJdzsqX8UmKSXSaWGMoDvzXRYej3uRC/SFX7wgdpTSi6NVx
 4AQHTUWlJFhKAwaa53Dgi4/b9z8/QqyArsPxJFSCX+sfwjIZmaHAr4bpiiIcCMp65EvfoyBGF
 K3RDUYm2Q9m6KCl3SwtEwFE0d6PsRQvTFM39TBG7iVoBI+o21alX9nB8d70XEQAADT0cRTxaS
 oDo8dGVddNRUrngmFZGDaWOZ0i62vZYBco/AER83A+5eWv6baSBv8TL+hsUjBikkUNeYYdRjq
 VPcCYgBICgOjOS8uFeWICf6GXJC2ljAPVKdYvWox+PECbfeIf62n8astDSUJxFdodpsslWOU5
 pPt+G0aY6oDx1seGzdL88mEponQ6g3RF+0n0u1jimzT/63obf0kjGv+vBjV5fNJByQ4Fka6Zx
 AMyT0YkRM5v+Io=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--A9N8cIjYTWR7Dk3CzRRdxWMhZeSWFGiv8
Content-Type: multipart/mixed; boundary="MumAJvShtYQjJkyow1yIi10G3KzQo6JoE";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Erik Jensen <erikjensen@rkjnsn.net>, Hugo Mills <hugo@carfax.org.uk>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <8aa09a61-aa1c-5dcd-093f-ec096a38a7b5@gmx.com>
Subject: Re: "bad tree block start" when trying to mount on ARM
References: <CAMj6ewO7PGBoN565WYz_bqL6nGszweNouP-Fphok9+GGpGn8gg@mail.gmail.com>
 <20190521091842.GS1667@carfax.org.uk>
 <CAMj6ewPKbRA_eT7JYA9ob9Qk9ZROoshOqaJE=4N_X9bPaskLUw@mail.gmail.com>
 <CAMj6ewOHrJVdwfKrgXZxwfwE=eoTaB9MS57zha33yb1_iOLWiw@mail.gmail.com>
In-Reply-To: <CAMj6ewOHrJVdwfKrgXZxwfwE=eoTaB9MS57zha33yb1_iOLWiw@mail.gmail.com>

--MumAJvShtYQjJkyow1yIi10G3KzQo6JoE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/6/26 =E4=B8=8B=E5=8D=883:04, Erik Jensen wrote:
> I'm still seeing this. Anything else I can try?
[...]
>>>>
>>>> [   83.066301] BTRFS info (device dm-3): disk space caching is enabl=
ed
>>>> [   83.072817] BTRFS info (device dm-3): has skinny extents
>>>> [   83.553973] BTRFS error (device dm-3): bad tree block start, want=

>>>> 17628726968320 have 396461950000496896
>>>> [   83.554089] BTRFS error (device dm-3): bad tree block start, want=

>>>> 17628727001088 have 5606876608493751477
>>>> [   83.601176] BTRFS error (device dm-3): bad tree block start, want=

>>>> 17628727001088 have 5606876608493751477
>>>> [   83.610811] BTRFS error (device dm-3): failed to verify dev exten=
ts
>>>> against chunks: -5
>>>> [   83.639058] BTRFS error (device dm-3): open_ctree failed

Since your fsck reports no error, I'd say your on-disk data is
completely fine.

So it's either the block layer reading some wrong from the disk or btrfs
layer doesn't do correct endian convert.

Would you dump the following data (X86 and ARM should output the same
content, thus one output is enough).
# btrfs ins dump-tree -b 17628726968320 /dev/dm-3
# btrfs ins dump-tree -b 17628727001088 /dev/dm-3

And then, for the ARM system, please apply the following diff, and try
mount again.
The diff adds extra debug info, to exam the vital members of a tree block=
=2E

Correct fs should output something like:
  BTRFS error (device dm-4): bad tree block start, want 30408704 have 0
  tree block gen=3D4 owner=3D5 nritems=3D2 level=3D0
  csum:
a304e483-0000-0000-0000-00000000000000000000-0000-0000-0000-000000000000

The csum one is the most important one, if there aren't so many zeros,
it means at that timing, btrfs just got a bunch of garbage, thus we
could do further debug.

Thanks,
Qu


diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index deb74a8c191a..e9d11d501b7b 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -618,8 +618,16 @@ static int btree_readpage_end_io_hook(struct
btrfs_io_bio *io_bio,

        found_start =3D btrfs_header_bytenr(eb);
        if (found_start !=3D eb->start) {
+               u8 csum[BTRFS_CSUM_SIZE];
+
                btrfs_err_rl(fs_info, "bad tree block start, want %llu
have %llu",
                             eb->start, found_start);
+               pr_info("tree block gen=3D%llu owner=3D%llu nritems=3D%u
level=3D%u\n",
+                       btrfs_header_generation(eb), btrfs_header_owner(e=
b),
+                       btrfs_header_nritems(eb), btrfs_header_level(eb))=
;
+               read_extent_buffer(eb, csum, 0, BTRFS_CSUM_SIZE);
+               pr_info("csum: %pU%-pU\n", csum, csum + 16);
+
                ret =3D -EIO;
                goto err;
        }


--MumAJvShtYQjJkyow1yIi10G3KzQo6JoE--

--A9N8cIjYTWR7Dk3CzRRdxWMhZeSWFGiv8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0TKIQACgkQwj2R86El
/qjD0wf/WVD+EIfGN6lKQki4ELV/FRqa3WHn/VCrgMATXwk0ddQUAl6FUR0/UCw+
6yqiHrV6Ok6MWotVYh5ObtDw992udbwyXUfWoIH43VPUtvhKKthm0jS20kmKnnoT
3P9AKt8Fkidpytdw+KD3xzo2yj+z6GIjPmey8vJwtleTauNUA8JFf+4ZTY1cFofR
D3xEZ/CTHvfrpHTOQtPA0YvRGVD0i1AfCz2EWAh/2mRlIJ6rCg6LayCUtyf3u3Ln
hF3AZD/oZmXOntNiVThd7k0bIGvHUAf8EpAcAOboe/duYN7IM5Kb0I/mhjVYSJyD
QjrrvU28nDtWeHeWXzohc9qNhYVfug==
=kpI6
-----END PGP SIGNATURE-----

--A9N8cIjYTWR7Dk3CzRRdxWMhZeSWFGiv8--
