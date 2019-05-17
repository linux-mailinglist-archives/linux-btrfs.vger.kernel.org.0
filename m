Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6C5221970
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2019 15:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbfEQN6E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 May 2019 09:58:04 -0400
Received: from tty0.vserver.softronics.ch ([91.214.169.36]:40316 "EHLO
        fe1.digint.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728260AbfEQN6E (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 May 2019 09:58:04 -0400
Received: from [10.0.1.10] (unknown [81.6.39.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by fe1.digint.ch (Postfix) with ESMTPSA id 8C1F630C23;
        Fri, 17 May 2019 15:57:59 +0200 (CEST)
Subject: Re: Used disk size of a received subvolume?
To:     Hugo Mills <hugo@carfax.org.uk>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <c79df692-cc5d-5a3a-1123-e376e8c94eb3@tty0.ch>
 <20190516171225.GH1667@carfax.org.uk>
From:   Axel Burri <axel@tty0.ch>
Openpgp: preference=signencrypt
Autocrypt: addr=axel@tty0.ch; prefer-encrypt=mutual; keydata=
 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
Message-ID: <27af7824-f3e9-47a5-7760-d3e30827a081@tty0.ch>
Date:   Fri, 17 May 2019 15:57:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516171225.GH1667@carfax.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BptmbzLXvYGMKcG4Dku3KxI7eAT33FWg1"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BptmbzLXvYGMKcG4Dku3KxI7eAT33FWg1
Content-Type: multipart/mixed; boundary="j4unD7mhKHOszMdJ1JyGTogLgNIYSzfXO";
 protected-headers="v1"
From: Axel Burri <axel@tty0.ch>
To: Hugo Mills <hugo@carfax.org.uk>, linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <27af7824-f3e9-47a5-7760-d3e30827a081@tty0.ch>
Subject: Re: Used disk size of a received subvolume?
References: <c79df692-cc5d-5a3a-1123-e376e8c94eb3@tty0.ch>
 <20190516171225.GH1667@carfax.org.uk>
In-Reply-To: <20190516171225.GH1667@carfax.org.uk>

--j4unD7mhKHOszMdJ1JyGTogLgNIYSzfXO
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 16/05/2019 19.12, Hugo Mills wrote:
> On Thu, May 16, 2019 at 04:54:42PM +0200, Axel Burri wrote:
>> Trying to get the size of a subvolume created using "btrfs receive",
>> I've come with a cute little script:
>>
>>    SUBVOL=3D/path/to/subvolume
>>    CGEN=3D$(btrfs subvolume show "$SUBVOL" \
>>      | sed -n 's/\s*Gen at creation:\s*//p')
>>    btrfs subvolume find-new "$SUBVOL" $((CGEN+1)) \
>>      | cut -d' ' -f7 \
>>      | tr '\n' '+' \
>>      | sed 's/\+\+$/\n/' \
>>      | bc
>>
>> This simply sums up the "len" field from all modified files since the
>> creation of the subvolume. Works fine, as btrfs-receive first makes a
>> snapshot of the parent subvolume, then adds the files according to the=

>> send-stream.
>>
>> Now this rises some questions:
>>
>> 1. How accurate is this? AFAIK "btrfs find-new" prints real length, no=
t
>> compressed length.
>>
>> 2. If there are clone-sources in the send-stream, the cloned files
>> probably also appear in the list.
>>
>> 3. Is there a better way? It would be nice to have a btrfs command for=

>> this. It would be straight-forward to have a "--summary" option in
>> "btrfs find-new", another approach would be to calculate and dump the
>> size in either "btrfs send" or "btrfs receive".
>=20
>    btrfs find-new also doesn't tell you about deleted files (fairly
> obviously), so if anything's been removed, you'll be overestimating
> the overall change in size.

True, making it not very useful, especially for backups where it is
also important to see what has been deleted.

>> Any thoughts? I'm willing to implement such a feature in btrfs-progs i=
f
>> this sounds reasonable to you.
>=20
>    If you're looking for the incremental usage of the subvolume, why
> not just use the "exclusive" value from btrfs fi du? That's exactly
> that information. (And note that it changes over time, as other
> subvols it shares with are deleted).

btrfs fi du shows me the information wanted, but only for the last
received subvolume (as you said it changes over time, and any later
child will share data with it). For all others, it merely shows "this
is what gets freed if you delete this subvolume".

And it is pretty slow: on my backup disk (spinning rust, ~2000
subvolumes, ~100 sharing data), btrfs fi du takes around 5min for a
subvolume of 20GB, while btrfs find-new takes only seconds.


Summing up, what I'm looking for would be something like:

  btrfs fi du -s --exclusive-relative-to=3D<other-subvol> <subvol>

Which is probably not easily doable.


Thanks,

- Axel


PS:

To get an idea on how this looks like on real data, here's the
combined output of "btrfs fi du -s" (Total, Exclusive),
"find-new-sum.sh", "find-new-prev.sh" for btrbk backups of a
webservice with low traffic.

Large values on find-new-prev column shows me when I updated the
software, probably overestimated by a factor of 2 (new package
installed, old package deleted).

     Total   Exclusive   find-new-sum  find-new-prev Filename
 319.59MiB    32.00KiB   345917734                   data.20151130
 320.24MiB    13.41MiB   630784        2453504       data.20151206
 321.44MiB    16.82MiB   135168        3699477       data.20160103
 325.77MiB   126.65MiB   258048        128418159     data.20160207
 326.92MiB   127.69MiB   262144        128242483     data.20160306
 467.85MiB   101.53MiB   585728        307220876     data.20160403
 475.99MiB   101.17MiB   544768        107036454     data.20160501
 515.12MiB    21.70MiB   450703        138940051     data.20160605
 736.80MiB    22.46MiB   573440        246238002     data.20160703
 743.39MiB   107.00MiB   540672        105290810     data.20160807
   1.15GiB   149.94MiB   651264        613553890     data.20160904
   1.23GiB    25.52MiB   111188246     238660114     data.20161002
   1.24GiB    24.70MiB   491520        10912303      data.20161106
   1.24GiB    25.66MiB   1834183       8197625       data.20161204
   1.24GiB   115.76MiB   573440        160281830     data.20170101
   1.25GiB   114.73MiB   610304        113867698     data.20170205
   1.82GiB    25.48MiB   618496        726426846     data.20170305
   1.82GiB    26.71MiB   507904        6691050       data.20170402
   1.85GiB    26.59MiB   733184        112139682     data.20170507
   1.85GiB    26.83MiB   24576         6841378       data.20170604
   1.85GiB    27.92MiB   1874740       7671216       data.20170702
   1.85GiB    28.73MiB   2441216       13105243      data.20170806
   1.86GiB    27.94MiB   491520        12743292      data.20170903
   1.90GiB    27.57MiB   634880        196836664     data.20171001
   1.90GiB    28.38MiB   503808        8083183       data.20171105
   1.90GiB    28.83MiB   425984        6748887       data.20171203
   1.90GiB   129.11MiB   708751        174442102     data.20180107
   1.87GiB   195.24MiB   1232896       249746997     data.20180204
   2.33GiB    29.74MiB   1183744       731504273     data.20180304
   2.33GiB    30.76MiB   1093632       7414396       data.20180401
   2.35GiB    29.20MiB   1048576       205278308     data.20180506
   2.35GiB    28.88MiB   1191936       2736128       data.20180513
   2.35GiB    28.79MiB   901120        179189757     data.20180520
   2.35GiB    28.82MiB   1179648       3047567       data.20180527
   2.35GiB    29.00MiB   1040384       3502223       data.20180603
   2.35GiB    29.21MiB   1183744       3093116       data.20180610
   2.46GiB    28.66MiB   1093632       366863945     data.20180617
   2.46GiB    29.24MiB   495616        3283388       data.20180624
   2.46GiB    29.39MiB   1290240       3207311       data.20180701
   2.47GiB    29.55MiB   1351680       3269245       data.20180708
   2.50GiB    29.40MiB   995328        39091775      data.20180715
   2.50GiB    29.46MiB   1236992       3411968       data.20180722
   2.50GiB    29.79MiB   1015951       3823244       data.20180729
   2.50GiB    30.11MiB   1359872       4673536       data.20180805
   2.50GiB    30.25MiB   638976        4542464       data.20180812
   2.50GiB    29.62MiB   1421312       183075636     data.20180819
   2.50GiB    29.48MiB   1114112       3473408       data.20180826
   2.50GiB    29.71MiB   1253376       3158016       data.20180902
   2.50GiB    29.74MiB   1126400       2945167       data.20180909
   2.50GiB    29.89MiB   1191936       2874597       data.20180916
   2.50GiB    30.32MiB   720896        3408015       data.20180923
   2.52GiB    30.94MiB   2097152       223821428     data.20180930
   2.52GiB    30.51MiB   1187840       6980297       data.20181007
   2.52GiB    30.45MiB   1090181       3455803       data.20181014
   2.52GiB    30.52MiB   1196814       2983306       data.20181021
   2.53GiB    30.78MiB   2231973       5325153       data.20181028
   2.52GiB    30.93MiB   1789697       239439411     data.20181104
   2.53GiB    30.92MiB   2453157       7016043       data.20181111
   2.53GiB    31.09MiB   1666725       3402269       data.20181118
   2.53GiB    30.68MiB   1060517       4639629       data.20181125
   2.53GiB    30.76MiB   1051174       4370574       data.20181202
   2.53GiB    30.68MiB   964673        3893313       data.20181209
   2.53GiB    30.65MiB   1064960       2727936       data.20181216
   2.54GiB    30.07MiB   1717236       212719260     data.20181223
   2.54GiB    30.39MiB   1231330       4679530       data.20181230
   2.54GiB    30.62MiB   1244308       3761492       data.20190106
   2.54GiB    31.58MiB   1146533       7047447       data.20190113
   2.55GiB    31.28MiB   1371905       6896944       data.20190120
   2.55GiB    31.27MiB   1941203       6495347       data.20190127
   2.55GiB    31.17MiB   1605262       5266478       data.20190203
   2.55GiB    31.54MiB   1105596       2847971       data.20190210
   2.56GiB    31.37MiB   1221804       201645985     data.20190217
   2.56GiB    31.58MiB   1360378       2971929       data.20190224
   2.56GiB    32.07MiB   2174675       5535980       data.20190303
   2.56GiB    32.02MiB   1743836       6429621       data.20190310
   2.56GiB    31.43MiB   1466368       3834494       data.20190317
   2.56GiB    31.26MiB   1544192       1544192       data.20190318
   2.56GiB    31.34MiB   1995373       1995373       data.20190319
   2.56GiB    31.37MiB   1509559       1509559       data.20190320
   2.56GiB    31.37MiB   1597093       1597093       data.20190321
   2.56GiB    30.51MiB   1552037       1552037       data.20190322
   2.57GiB    30.47MiB   2694989       2694989       data.20190323
   2.57GiB    30.57MiB   2612947       2612947       data.20190324
   2.58GiB    30.10MiB   208643677     208643677     data.20190325
   2.58GiB    31.27MiB   1580732       1580732       data.20190326
   2.58GiB    31.34MiB   1552083       1552083       data.20190327
   2.58GiB    31.48MiB   1605331       1605331       data.20190328
   2.58GiB    30.55MiB   17353623      17353623      data.20190329
   2.58GiB    30.63MiB   2715094       2715094       data.20190330
   2.58GiB    31.55MiB   1646130       1646130       data.20190331
   2.58GiB    31.51MiB   1478263       1478263       data.20190401
   2.58GiB    31.61MiB   5478839       5478839       data.20190402
   2.58GiB    31.52MiB   1711712       1711712       data.20190403
   2.58GiB    31.53MiB   1535538       1535538       data.20190404
   2.58GiB    31.57MiB   1592820       1592820       data.20190405
   2.58GiB    31.50MiB   1887794       1887794       data.20190406
   2.58GiB    31.58MiB   1531442       1531442       data.20190407
   2.58GiB    31.54MiB   1679082       1679082       data.20190408
   2.58GiB    31.55MiB   1580732       1580732       data.20190409
   2.58GiB    31.53MiB   1679036       1679036       data.20190410
   2.58GiB    31.46MiB   1748668       1748668       data.20190411
   2.58GiB    31.62MiB   1704319       1704319       data.20190412
   2.58GiB    30.16MiB   215955743     215955743     data.20190413
   2.58GiB    31.40MiB   1500930       1500930       data.20190414
   2.58GiB    31.36MiB   1357708       1357708       data.20190415
   2.58GiB    31.45MiB   1498789       1498789       data.20190416
   2.58GiB    31.75MiB   2137765       2137765       data.20190417
   2.58GiB    31.81MiB   1601212       1601212       data.20190418
   2.58GiB    31.82MiB   1730505       1730505       data.20190419
   2.58GiB    31.82MiB   1572586       1572586       data.20190420
   2.58GiB    31.87MiB   1490620       1490620       data.20190421
   2.58GiB    31.88MiB   1523457       1523457       data.20190422
   2.58GiB    31.86MiB   1924865       1924865       data.20190423
   2.58GiB    31.89MiB   1654482       1654482       data.20190424
   2.58GiB    31.84MiB   1588970       1588970       data.20190425
   2.58GiB    31.84MiB   1576613       1576613       data.20190426
   2.58GiB    31.81MiB   1756929       1756929       data.20190427
   2.58GiB    31.89MiB   1658625       1658625       data.20190428
   2.58GiB    31.84MiB   1584805       1584805       data.20190429
   2.58GiB    31.82MiB   1605377       1605377       data.20190430
   2.58GiB    31.85MiB   1588947       1588947       data.20190501
   2.58GiB    31.89MiB   1765121       1765121       data.20190502
   2.58GiB    31.88MiB   1760933       1760933       data.20190503
   2.58GiB    31.83MiB   1810154       1810154       data.20190504
   2.58GiB    32.20MiB   1609473       1609473       data.20190505
   2.61GiB     2.68MiB   149129730     149129730     data.20190506
   2.61GiB    17.41MiB   3137281       3137281       data.20190507
   2.61GiB    23.75MiB   2625258       2625258       data.20190508
   2.61GiB    27.62MiB   2404074       2404074       data.20190509
   2.61GiB    29.87MiB   1904224       1904224       data.20190510
   2.61GiB    31.22MiB   2080513       2080513       data.20190511
   2.61GiB    35.84MiB   2744042       2744042       data.20190512
   2.61GiB    37.33MiB   2019073       2019073       data.20190513
   2.61GiB    37.79MiB   2035388       2035388       data.20190514
   2.61GiB    38.17MiB   1785578       1785578       data.20190515
   2.61GiB    39.63MiB   1982163       1982163       data.20190516


$ cat find-new-sum.sh
#!/bin/bash
# Data size added on received subvolume.
subvol=3D$1
cgen=3D$(btrfs subvolume show "$subvol" \
  | sed -n 's/\s*Gen at creation:\s*//p')
sum=3D$(btrfs subvolume find-new "$subvol" $((cgen+1)) \
  | cut -d' ' -f7 \
  | tr '\n' '+' \
  | sed 's/\+\+$/\n/' \
  | bc)
echo "$subvol $sum"


$ cat find-new-prev.sh
#!/bin/bash
# Data size added since last backup.
# (works only if backups are received linear in time)
lastgen=3D999999999
for subvol in $@ ; do
    cgen=3D$(btrfs subvolume show "$subvol" \
      | sed -n 's/\s*Gen at creation:\s*//p')
    if [[ $lastgen -gt $cgen ]]; then
       echo "$subvol older, skipping"
    else
        sum=3D$(btrfs subvolume find-new "$subvol" $((lastgen+1)) \
          | cut -d' ' -f7 \
          | tr '\n' '+' \
          | sed 's/\+\+$/\n/' \
          | bc)
        echo "$subvol $sum"
    fi
    lastgen=3D$(btrfs subvolume show "$subvol" \
      | sed -n 's/\s*Generation:\s*//p')
done


--j4unD7mhKHOszMdJ1JyGTogLgNIYSzfXO--

--BptmbzLXvYGMKcG4Dku3KxI7eAT33FWg1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEGhZyjCOMCiVqHcFZjQOnykvjzX0FAlzevd4ACgkQjQOnykvj
zX1LohAAhxtEHXn6oikOulhi82mAQ+YRmjPvTR8zHvgsXqFSpiWALvc8/6NcvZNI
D53GPdj6F5U/fw5v5y7wdSOJnFeXnEM0QztkU3T7SPhiLjVSZjXm+Rj8BPOe1VM4
RgqhTOsBT41ki2KrLHPNSYSYYTOr3uD/sB9MyLsAYPZoWgyHIVStH6+CQrhdx6NO
DW6J5QYNy4zzX2ojxowc/MKoemJnkgFBMeck9ms85ZyI4/Bs9luBonxVCsXdRzQU
I56hqchM4oY1drkgQhVvNRir0uXJBrgxh0ymgP2IZis1dN4YBMv36HHDz7FIL1/V
cWtgFNqNPMhGZFBIxmpEpLtsit8uQe2F1Xsim1a6VdpYjjI9KsTfXUFtIY4VgD/E
Mqkhi299vE/XKRCQR+z46hBlOzBgYM0aVjhDgLgVtNhZqDqBrS9CnGeiO/gUVqoi
x45k4f3HgrtJoqs41dGNQU4pm7XBYMLmKmL3RqNdNk16kBLuVd284p0oM3pADvX7
s6y4XRzHD6dWRtcPD1jdfKZMsTnRfZeD7Ukhvj+1H7zhK8TIBYnX2CzSo65uzOnS
VciirCFD/WbmhM9/CvhYTIbQcl4yG+i5o46TKXaMjDcvw8krrcHB0Lbvq0CNkHWO
06r6sroFbreQRqPGfrnnx4CUV/AmXpBF4pIO4eE8/7D/c53Ejjs=
=sbns
-----END PGP SIGNATURE-----

--BptmbzLXvYGMKcG4Dku3KxI7eAT33FWg1--
