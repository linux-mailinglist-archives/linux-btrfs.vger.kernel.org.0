Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46BA88FF66
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2019 11:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfHPJrr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Aug 2019 05:47:47 -0400
Received: from mout.gmx.net ([212.227.17.22]:43919 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726993AbfHPJrr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Aug 2019 05:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565948859;
        bh=aykzezuu8tdKMXLYMYNMVLirF3DKpYsmWHCQPzKlWd8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=I6QUHnsIBc2xcxZd6QSj1eACmyFxQk8C67/Zs6sMK5pGGmZA82f2u/hAOLyDW9FQt
         wHmidnqueqw6aI4qWmfXIRluv40eWiGr5BwQUWoFApsJ7dNBV1NBIfnbzeXw3MVbLa
         mEk+cxeH48VLvTbrcTIwH2O9Y+l65WnB8K5SYx5U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx102
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0LtDpH-1iQuEz3F3D-012qaI; Fri, 16
 Aug 2019 11:47:39 +0200
Subject: Re: [PATCH] fstests: btrfs: Check snapshot creation and deletion with
 dm-logwrites
To:     fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20190814105544.18318-1-wqu@suse.com>
 <CAL3q7H5v6jrFcKupRBZ9EnaQDKM2UooK3iwOgJ01wTvqMtizcw@mail.gmail.com>
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
Message-ID: <21a7b532-c16d-c014-e714-e280d0a1850a@gmx.com>
Date:   Fri, 16 Aug 2019 17:47:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H5v6jrFcKupRBZ9EnaQDKM2UooK3iwOgJ01wTvqMtizcw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BhuUxfTa8gfxtpb5hCOgRvwKzuTMJiCzI"
X-Provags-ID: V03:K1:YYyTdamXsR2Vcq2jn9wfVYQVL6PSUghRscaKfwgye+NTeo3wokf
 43yW6yKLrLfBX9rfFNLN/4JkwVz8C4A4TiRybFnk3jGaPfV6ERS2bYkthjwa9SmrpGS9Ivn
 2xwc7CCEyKpVPiUrcCJXlmRrXXi0ZIOP/YWdzY3t3qxu6d/qyoeEP8SB2Fq6kndfLBmTkOG
 ODfABdhXV2Tk+lRxeCrkA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:uKBhQJT5s6o=:ZKnWutkB8vBqPmvZwMfNmS
 IhpfL9OreNCyUyivSlaE+BG/aa33/kiaU0FwN6PZk6wCOVIp7pZGy5RyEW6Jr4DZGRtjkIl/B
 MeydxsAqglvp2nufzPnS3DAXs4P8jtopi0MMXVxKWVvGXND9JVQojy8PMOcVLQjcEuqa740+T
 61WTZSW62Gi8wPLoiEq6fUR1ce+j6a/DB4ct9z9CDhKpPfYofOo1X9nes+MILTEzvIYAaR6BQ
 U5Ci7ldfoDJRVaDgAevOqtpOWkhPWVCvuISPt0B5phyifActeNMC1IKhoKQmWmK4Mb4Hf30YQ
 KLds4IXLc/A+QZ+K2rZFXL8A4LW7fnOaQl6Vrdd82Z/6OjYTwgOYrlmY4NUmRZ5sK5Q2Tcrnw
 +/JmiIpMMrv7B3EBuTzVoAwDDn7SeRtIHZaHIEl1U6YYk5MaijtgZvJFRA+e8rXQLMYmC/N5Z
 WnSkYgvogHo24pgwQdncl279k25X1wd0XoxOYCwIKxhY/KeVf+hT/AnrviKn4ECghPIO3EsKp
 hnnrKlAoPd3AHZNBbmsJdvQTkQY9AfgzKzWoPKq8d6/cvgZe10O/WvLKUyl4tgatSyxsXwsAH
 p8C8oK4kVeNMKhPqPXWEBemLyNi4nG4o7N0ecJLOMcaEBQwKHqNUzKnOLXuAkcMVAdQVs3wVC
 w4kgZR7ur+2oNdHpdAukuQyn0giMGuXeTiUfBSKXhZNPfhyUNWB/1CaBVZG48a840JPI6ez4M
 9xHR88BPRgyaMBku2yXOVfBom0gvydkMwWMjqpOg+QIfe8C3G49Qn0gTQsIJPuWgwMOV5lx0a
 3mzkoNnXd3s9FAKLrcPBr+M0VttaZPjiVNQ3LM892Aas+Do1NarU/Es92FHA4EP0jLkzafSnA
 dVxpWizfNuqzX2lcx5YEL5sqlDnp8hD2Gm7QUdaBH00CZFkSewr/NhnCLOIj2y4bNSUQNkSlh
 wfX2JE6lGFqqeQw9mZTEU6jH5Uuv8LdyIbUHoGGwiopVKOmhAWxmZe61X0QP4hqXhJMTn2DDX
 YT5AWBrIgLPS97YfcpYTCuxT35PFugVCRnxFoJXEqqVyVYcmVoHdotvNBq5qk+9QY0cF1lnXb
 7p0vMYgwwzIzmQ3OfaC6bFYfFR36JirdjTRTUXCVVYpoHmlVB7hiGyykA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BhuUxfTa8gfxtpb5hCOgRvwKzuTMJiCzI
Content-Type: multipart/mixed; boundary="VIPhlhsz7li3u8YOEPvPQOMLat8dSTSvH";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc: fstests <fstests@vger.kernel.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <21a7b532-c16d-c014-e714-e280d0a1850a@gmx.com>
Subject: Re: [PATCH] fstests: btrfs: Check snapshot creation and deletion with
 dm-logwrites
References: <20190814105544.18318-1-wqu@suse.com>
 <CAL3q7H5v6jrFcKupRBZ9EnaQDKM2UooK3iwOgJ01wTvqMtizcw@mail.gmail.com>
In-Reply-To: <CAL3q7H5v6jrFcKupRBZ9EnaQDKM2UooK3iwOgJ01wTvqMtizcw@mail.gmail.com>

--VIPhlhsz7li3u8YOEPvPQOMLat8dSTSvH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/16 =E4=B8=8B=E5=8D=885:25, Filipe Manana wrote:
[...]
>=20
> That will also make the test fail on systems with a page size > 4Kb.
> So either make it "_notrun" for systems with a page size !=3D 4Kb or,
> preferably make the test independent of the page size.
> If you want to increase the tree height easily, you can set large
> xattrs for files, like I did in btrfs/187, where even if with a 64Kb
> page size, I get a 3 levels fs tree.
>=20
>> +
>> +# We need inline extents to quickly bump the tree height
>> +_log_writes_mount -o max_inline=3D2048
>=20
> Again, setting large xatts (3800 bytes so that it works for any page
> size) is even faster then inline extents.

Greater advice for that!

>=20
>> +
>> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/src > /dev/null 2>&1
>=20
> We should catch failures here. Just remove the redirection, pass the
> _filter_scratch filter and update the golden output.
>=20
>> +mkdir -p $SCRATCH_MNT/snapshots
>> +mkdir -p $SCRATCH_MNT/src/padding
>> +
>> +random_file() {
>=20
> The coding style is "{" on the beginning of the next line.
> Like the _cleanup() function, and the _log_writes_fast_replay_check()
> function you added previously.
>=20
>> +       local basedir=3D$1
>> +       echo "$basedir/$(ls $basedir | sort -R | tail -1)"
>> +}
>> +
>> +snapshot_workload() {
>=20
> Same comment as above.
>=20
>> +       while true; do
>> +               $BTRFS_UTIL_PROG subvolume snapshot \
>> +                       $SCRATCH_MNT/src $SCRATCH_MNT/snapshots/$i \
>> +                       > /dev/null 2>&1
>> +               # Remove two random padding so each snapshot is differ=
ent
>> +               rm "$(random_file $SCRATCH_MNT/src/padding)"
>=20
> I would pass -f to rm. Having an alias "alias rm=3D'rm -i'" is not very=

> uncommon (I have such alias for my accounts).
>=20
>> +               rm "$(random_file $SCRATCH_MNT/src/padding)"
>=20
> Might be interesting to add a few files to each snapshot too (modify
> existing ones, etc).

No problem.

>=20
>> +               sleep 1
>> +       done
>> +}
>> +
>> +delete_workload() {
>=20
> Same comment as above.
>=20
>> +       while true; do
>> +               sleep 2
>> +               $BTRFS_UTIL_PROG subvolume delete \
>> +                       "$(random_file $SCRATCH_MNT/snapshots)" \
>> +                       > /dev/null 2>&1
>> +       done
>> +}
>> +
>> +# Bump the tree height to 2 at least
>> +for ((i =3D 0; i < 256; i++)); do
>> +       _pwrite_byte 0xcd 0 2k "$SCRATCH_MNT/src/padding/inline_$i" > =
/dev/null 2>&1
>> +       _pwrite_byte 0xcd 0 4k "$SCRATCH_MNT/src/padding/regular_$i" >=
 /dev/null 2>&1
>> +done
>> +sync
>=20
> Why the call to 'sync'?
> Not needed, snapshot creation flushes delalloc and commits a transactio=
n.
>=20
>> +
>> +_log_writes_mark prepare
>> +
>> +snapshot_workload &
>> +pid1=3D$!
>> +delete_workload &
>> +pid2=3D$!
>> +
>> +$FSSTRESS_PROG $fsstress_args > /dev/null 2>&1 &
>> +sleep $runtime
>> +
>> +$KILLALL_PROG -q $FSSTRESS_PROG &> /dev/null
>=20
> You're very inconsistent within the same test :) Using both ">
> /dev/null 2>&1" and "&> /dev/null".

My bad, I mean 2>&1 > /dev/null.
What I mean is output stderr while skip stdout in previous calls.

Thanks,
Qu

>=20
>> +kill $pid1 &> /dev/null
>> +kill $pid2 &> /dev/null
>> +wait
>> +_log_writes_unmount
>> +_log_writes_remove
>> +
>> +# Since we have a lot of work to replay, and relay-log will search
>> +# from the first record to the needed entry, we need to use --fsck op=
tion
>> +# to reduce unnecessary search, or it will be too slow
>> +$here/src/log-writes/replay-log --log $LOGWRITES_DEV --replay $SCRATC=
H_DEV \
>> +       --fsck "btrfs check $SCRATCH_DEV" --check fua >> $seqres.full =
2>&1
>> +
>> +echo "Silence is golden"
>> +
>> +# success, all done
>> +status=3D0
>> +exit
>> diff --git a/tests/btrfs/192.out b/tests/btrfs/192.out
>> new file mode 100644
>> index 00000000..6779aa77
>> --- /dev/null
>> +++ b/tests/btrfs/192.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 192
>> +Silence is golden
>> diff --git a/tests/btrfs/group b/tests/btrfs/group
>> index 2474d43e..24723bf1 100644
>> --- a/tests/btrfs/group
>> +++ b/tests/btrfs/group
>> @@ -194,3 +194,4 @@
>>  189 auto quick send clone
>>  190 auto quick replay balance qgroup
>>  191 auto quick send dedupe
>> +192 auto replay
>=20
> Missing "snapshot" group.
>=20
> Thanks.
>=20
>> --
>> 2.22.0
>>
>=20
>=20


--VIPhlhsz7li3u8YOEPvPQOMLat8dSTSvH--

--BhuUxfTa8gfxtpb5hCOgRvwKzuTMJiCzI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1We7UACgkQwj2R86El
/qjIZAgAsEB8diZhj4xdMLUExpMUtpIUudwrBZ4B/gYDu3+uBP3BfP8O+bseZVy5
brhISoDQ0jnHPYZrYeFfcajYUo+FpR2cf+YEoKUspITc+cKpJCKF/RV20HosgPPI
xL+YZUfGLIiWkgyE9KvH2hDlkzEQncbOFj7Hf8YXFjS07pZ/4GRxUemeXuGKHXxR
+w4IwJ0kxBWxUV8eXd4qoncyvct8tpkzSqp35oo1XpNcHEV1ssBeDA6PSAibkS3e
iC1QV73IxEeANm11ZeVnRNmP8vWRFUWruVjmRZvmWgA1EC/E732W73SqX2EAvrfx
7X7n8z2Kle9BWoOldLW0nHbNIcl5AA==
=W9cu
-----END PGP SIGNATURE-----

--BhuUxfTa8gfxtpb5hCOgRvwKzuTMJiCzI--
