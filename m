Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16474447ED
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2019 19:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbfFMRDJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jun 2019 13:03:09 -0400
Received: from dog.birch.relay.mailchannels.net ([23.83.209.48]:17862 "EHLO
        dog.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729450AbfFLXDZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jun 2019 19:03:25 -0400
X-Sender-Id: dreamhost|x-authsender|eric@ericmesa.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 327262C17BE;
        Wed, 12 Jun 2019 23:03:22 +0000 (UTC)
Received: from pdx1-sub0-mail-a7.g.dreamhost.com (100-96-88-48.trex.outbound.svc.cluster.local [100.96.88.48])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 9D6E02C15B0;
        Wed, 12 Jun 2019 23:03:21 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|eric@ericmesa.com
Received: from pdx1-sub0-mail-a7.g.dreamhost.com ([TEMPUNAVAIL].
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.17.2);
        Wed, 12 Jun 2019 23:03:22 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|eric@ericmesa.com
X-MailChannels-Auth-Id: dreamhost
X-Irritate-Interest: 19846d590e06efdc_1560380601998_1518344007
X-MC-Loop-Signature: 1560380601998:194998530
X-MC-Ingress-Time: 1560380601998
Received: from pdx1-sub0-mail-a7.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a7.g.dreamhost.com (Postfix) with ESMTP id 671448159B;
        Wed, 12 Jun 2019 16:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=ericmesa.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-type; s=ericmesa.com; bh=lxt0yWD/LCp7SJfQehxs3JXbu3w=; b=
        i7EAjnfpuKzzb6RD3TGLIYH9+Nm8tA18bUhEUmhVZxhEc0S/iwIvX04dVIxN69r+
        h3KQ7XCLqoySBJgSjaQKE0hEmvH2Zus9alXYB4LJ1N1bNFKqi6/n/AfSD8BqeAtN
        0B9N0xBG5iy98LDb/kq4Trgxwrf1LMYYok/rFEmqoQI=
Received: from supermario.mushroomkingdom (pool-68-134-39-132.bltmmd.fios.verizon.net [68.134.39.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: eric@ericmesa.com)
        by pdx1-sub0-mail-a7.g.dreamhost.com (Postfix) with ESMTPSA id 7B5358159F;
        Wed, 12 Jun 2019 16:03:15 -0700 (PDT)
X-DH-BACKEND: pdx1-sub0-mail-a7
From:   Eric Mesa <eric@ericmesa.com>
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Issues with btrfs send/receive with parents
Date:   Wed, 12 Jun 2019 19:03:04 -0400
Message-ID: <2331470.mWhmLaHhuV@supermario.mushroomkingdom>
In-Reply-To: <21ecc5c2-7e4c-803e-5299-7ee150d6af4f@gmail.com>
References: <3884539.zL6soEQT1V@supermario.mushroomkingdom> <2008850.MjMmxLcJHu@supermario.mushroomkingdom> <21ecc5c2-7e4c-803e-5299-7ee150d6af4f@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1608407.DF2yO8cWMC"; micalg="pgp-sha256"; protocol="application/pgp-signature"
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: -100
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudehkedgudeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuggftfghnshhusghstghrihgsvgdpffftgfetoffjqffuvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhggtgesghdtreertddtjeenucfhrhhomhepgfhrihgtucfovghsrgcuoegvrhhitgesvghrihgtmhgvshgrrdgtohhmqeenucffohhmrghinhepieegqdhlihhnuhigqdhgnhhurdhsohenucfkphepieekrddufeegrdefledrudefvdenucfrrghrrghmpehmohguvgepshhmthhppdhhvghlohepshhuphgvrhhmrghrihhordhmuhhshhhrohhomhhkihhnghguohhmpdhinhgvthepieekrddufeegrdefledrudefvddprhgvthhurhhnqdhprghthhepgfhrihgtucfovghsrgcuoegvrhhitgesvghrihgtmhgvshgrrdgtohhmqedpmhgrihhlfhhrohhmpegvrhhitgesvghrihgtmhgvshgrrdgtohhmpdhnrhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--nextPart1608407.DF2yO8cWMC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Wednesday, June 12, 2019 1:43:00 AM EDT Andrei Borzenkov wrote:
> 11.06.2019 7:19, Eric Mesa =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Monday, June 10, 2019 11:39:53 PM EDT Andrei Borzenkov wrote:
> >> 11.06.2019 4:10, Chris Murphy =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>> It's most useful if you show exact commands because actually it's not
> >>> always obvious to everyone what the logic should be and the error
> >>> handling doesn't always stop a user from doing something that doesn't
> >>> make a lot of sense. We need to know the name of the rw subvolume; the
> >>> command to snapshot it; the full send/receive command for that first
> >>> snapshot; the command for a subsequent snapshot; and the command to
> >>> incrementally send/receive it.
> >>=20
> >> And the actual output of each command, not description what user thinks
> >> has happened.
> >=20
> > Here is a new session where I'll capture everything - well, on the defr=
ag
> > I'll do a snip.
> >=20
> > #btrfs fi defrag -v -r /home/
> >=20
> > ...there follows a list of files that just scrolls infinitely....
> > /home/ermesa/.dropbox-dist/dropbox-lnx.x86_64-74.4.115/_bisect.cpython-=
37m
> > -
> > x86_64-linux-gnu.so
> > /home/ermesa/.dropbox-dist/dropbox-lnx.x86_64-74.4.115/
> > tornado.speedups.cpython-37m-x86_64-linux-gnu.so
> > /home/ermesa/.bash_history
> > total 1 failures
> >=20
> > # sync
> >=20
> > # btrfs sub snap -r /home/ /home/.snapshots/2019-06-10-2353
> > Create a readonly snapshot of '/home/' in
> > '/home/.snapshots/2019-06-10-2353'
> >=20
> > # btrfs send -vvv -p /home/.snapshots/2019-06-10-1718/ /home/.snapshots/
> > 2019-06-10-2353/ | ssh root@tanukimario btrfs receive
> > /media/backups/backups1/ supermario-home
> > At subvol /home/.snapshots/2019-06-10-2353/
> > ERROR: link ermesa/.mozilla/firefox/n35gu0fb.default/bookmarkbackups/
> > bookmarks-2019-06-10_679_I1bs5PtgsPwtyXvcvcRdSg=3D=3D.jsonlz4 ->
> > ermesa/.mozilla/ firefox/n35gu0fb.default/bookmarkbackups/
> > bookmarks-2019-06-09_679_I1bs5PtgsPwtyXvcvcRdSg=3D=3D.jsonlz4 failed: N=
o such
> > file or directory
>=20
> Does
> ermesa/.mozilla/firefox/n35gu0fb.default/bookmarkbackups/bookmarks-2019-0=
6-0
> 9_679_I1bs5PtgsPwtyXvcvcRdSg=3D=3D.jsonlz4 actually exist in snapshot
> /home/.snapshots/2019-06-10-1718/ on source?
>=20
> ls -lR
> /home/.snapshots/2019-06-10-1718/ermesa/.mozilla/n35gu0fb.default/bookmar=
kba
> ckups
>=20
> What is the content of the same directory in matching snapshot on
> destination?
>=20
> Please show "btrfs subvolume list -qRu /home" for source and "btrfs
> subvolume list -qRu /media/backups/backups1/supermario-home" for
> destination.


Sure thing. Thanks for your help.=20

This is source disk:

#  ls -lR /home/.snapshots/2019-06-10-1718/ermesa/.mozilla/n35gu0fb.default/
bookmarkbackups/
ls: cannot access '/home/.snapshots/2019-06-10-1718/ermesa/.mozilla/
n35gu0fb.default/bookmarkbackups/': No such file or directory

You didn't ask for the child, but I'm going to do it in that, too:

# ls -lR /home/.snapshots/2019-06-10-2353/ermesa/.mozilla/n35gu0fb.default/
bookmarkbackups/
ls: cannot access '/home/.snapshots/2019-06-10-2353/ermesa/.mozilla/
n35gu0fb.default/bookmarkbackups/': No such file or directory

One more thing you didn't ask for, but since this is the ancestor of all -p=
=20
snapshots that actually worked:

# ls -lR /home/.snapshots/2019-06-05-postdefrag/ermesa/.mozilla/
n35gu0fb.default/bookmarkbackups/
ls: cannot access '/home/.snapshots/2019-06-05-postdefrag/ermesa/.mozilla/
n35gu0fb.default/bookmarkbackups/': No such file or directory

On the destination disk:

# pwd                                                                      =
                                                                           =
                           =20
/media/backups/backups1/supermario-home

# ls -lR 2019-06-10-1718/ermesa/.mozilla/n35gu0fb.default/bookmarkbackups/ =
                                                                           =
                           =20
ls: cannot access '2019-06-10-1718/ermesa/.mozilla/n35gu0fb.default/
bookmarkbackups/': No such file or directory


On the source disk:

# btrfs subvolume list -qRu /home
ID 822 gen 3042780 top level 5 parent_uuid c6101e57-acd3-e54c-a957-
b2b6a033bc42 received_uuid ab1ea98a-b950-2047-802d-3b26568e2e14 uuid=20
7247f4a0-6ea2-0d49-b5c5-1ea2ecb8980a path home
ID 823 gen 3042727 top level 822 parent_uuid -                             =
      =20
received_uuid -                                    uuid f83e53b6-dc88-1a44-
a5e8-f220d5d21083 path .snapshots
ID 2515 gen 3008316 top level 823 parent_uuid 7247f4a0-6ea2-0d49-
b5c5-1ea2ecb8980a received_uuid ab1ea98a-b950-2047-802d-3b26568e2e14 uuid=20
8ef83478-86be-8a47-a425-1dc6957a0fbe path .snapshots/2019-06-05-postdefrag
ID 2516 gen 3021663 top level 823 parent_uuid 7247f4a0-6ea2-0d49-
b5c5-1ea2ecb8980a received_uuid ab1ea98a-b950-2047-802d-3b26568e2e14 uuid=20
cbb67aec-02ed-8247-afee-38ae94555471 path .snapshots/2019-06-08-1437
ID 2518 gen 3027353 top level 823 parent_uuid 7247f4a0-6ea2-0d49-
b5c5-1ea2ecb8980a received_uuid ab1ea98a-b950-2047-802d-3b26568e2e14 uuid=20
ca361150-1050-5844-bff7-de5c89b5cc05 path .snapshots/2019-06-09-1550
ID 2519 gen 3028168 top level 823 parent_uuid 7247f4a0-6ea2-0d49-
b5c5-1ea2ecb8980a received_uuid ab1ea98a-b950-2047-802d-3b26568e2e14 uuid=20
5fa82b5e-59e1-2549-a939-5dabc99c0f2a path .snapshots/2019-06-09-1944
ID 2520 gen 3032614 top level 823 parent_uuid 7247f4a0-6ea2-0d49-
b5c5-1ea2ecb8980a received_uuid ab1ea98a-b950-2047-802d-3b26568e2e14 uuid=20
df437aaf-0f40-344e-8302-932ea8e5f197 path .snapshots/2019-06-10-1718
ID 2521 gen 3034140 top level 823 parent_uuid 7247f4a0-6ea2-0d49-
b5c5-1ea2ecb8980a received_uuid ab1ea98a-b950-2047-802d-3b26568e2e14 uuid=20
2b985685-d88b-784a-b870-8f5f8fcdd08c path .snapshots/2019-06-10-2353


On the destination disk: (I deleted 2019-06-2353 since it wasn't a valid=20
backup and I didn't want to get confused when determining which backups I=20
could delete)

btrfs subvolume list -qRu /media/backups/backups1/supermario-home
ID 257 gen 15047 top level 5 parent_uuid -                                 =
  =20
received_uuid -                                    uuid 5d93ca75-
f423-9840-893e-6324f7e79e02 path backups
ID 258 gen 15049 top level 257 parent_uuid -                               =
    =20
received_uuid -                                    uuid 8b60359a-9525-4044-
ac04-4982f1f1fe3a path backups/supermario-home
ID 826 gen 14290 top level 257 parent_uuid -                               =
    =20
received_uuid -                                    uuid c7dc0373-7e2a-bb44-
b32c-172aac73b8a7 path backups/VG_ROMs
ID 827 gen 4313 top level 826 parent_uuid -                                =
   =20
received_uuid a85853e1-848f-ac46-93c6-da5035cc8042 uuid 0ef9b4f9-
f8b6-8943-8714-38e9376019bf path backups/VG_ROMs/2017-01-21-original
ID 1021 gen 4334 top level 826 parent_uuid 0ef9b4f9-
f8b6-8943-8714-38e9376019bf received_uuid c7356dd2-9fa3-1141-8433-4ba96e4cd=
cd6=20
uuid 8c46bc72-9738-d24e-bb9a-c1edcf7a4755 path backups/VG_ROMs/2019-05-30
ID 1024 gen 15048 top level 257 parent_uuid -                              =
     =20
received_uuid -                                    uuid bc92cd25-cf4b-
d24c-8cf5-ddb0df654e05 path backups/Comics
ID 1025 gen 9890 top level 1024 parent_uuid -                              =
     =20
received_uuid fd3e9edb-854a-4143-993e-e2a8bbd4cedb uuid=20
7a5bd7be-43aa-7f44-9443-ff96cf575175 path backups/Comics/2019-05-30
ID 1027 gen 4336 top level 826 parent_uuid 8c46bc72-9738-d24e-bb9a-
c1edcf7a4755 received_uuid -                                    uuid 85b557=
2b-
edc3-6d48-8b4d-3c956cae2da5 path backups/VG_ROMs/ROMs_NFS-orig
ID 1602 gen 15047 top level 257 parent_uuid -                              =
     =20
received_uuid -                                    uuid 13ab4679-
eccb-6544-8176-6f494236f1c9 path backups/Archive
ID 1603 gen 9964 top level 1602 parent_uuid -                              =
     =20
received_uuid 3c48ee45-4454-2f4a-86b7-5c498ffb784d uuid ab3efbd4-e78f-f745-
b401-b653e0ad6667 path backups/Archive/2019-06-01
ID 2726 gen 10165 top level 1024 parent_uuid 7a5bd7be-43aa-7f44-9443-
ff96cf575175 received_uuid 0df42045-b04a-5f43-924e-69b39e1b3ce6 uuid=20
f46a045c-41c4-c543-ba5f-948b97e43746 path backups/Comics/2019-06-03
ID 2728 gen 12315 top level 1602 parent_uuid ab3efbd4-e78f-f745-b401-
b653e0ad6667 received_uuid 649d6bec-9f54-2a44-8fed-8e6e9c054f8c uuid=20
255c8dc8-8d61-9342-9f3c-af06fe82daf6 path backups/Archive/2019-06-03
ID 2732 gen 10171 top level 1024 parent_uuid f46a045c-41c4-c543-
ba5f-948b97e43746 received_uuid a3a6b2d9-0b30-a342-bafb-6a3a70258994 uuid=20
0cb98f03-0152-494c-935f-d6af45cf23dd path backups/Comics/2019-06-03p2
ID 2977 gen 12337 top level 1602 parent_uuid 255c8dc8-8d61-9342-9f3c-
af06fe82daf6 received_uuid 1404041e-6456-2641-a35a-f30f08baf250 uuid=20
42eb5475-1b2f-8948-8333-b8a1267455e0 path backups/Archive/2019-06-05
ID 2983 gen 15033 top level 258 parent_uuid -                              =
     =20
received_uuid ab1ea98a-b950-2047-802d-3b26568e2e14 uuid 7685ff5c-0a72-
f94e-93d7-7736f68b3ec5 path 2019-06-05-postdefrag
ID 3545 gen 14310 top level 258 parent_uuid 7685ff5c-0a72-
f94e-93d7-7736f68b3ec5 received_uuid ab1ea98a-b950-2047-802d-3b26568e2e14 u=
uid=20
26791559-bd47-e44f-9e2f-0ea258615429 path 2019-06-08-1437
ID 3550 gen 14878 top level 258 parent_uuid 7685ff5c-0a72-
f94e-93d7-7736f68b3ec5 received_uuid ab1ea98a-b950-2047-802d-3b26568e2e14 u=
uid=20
7c9787bc-fbc4-c146-b88b-e5dd10918eaa path 2019-06-09-1944
ID 3582 gen 15012 top level 258 parent_uuid 7685ff5c-0a72-
f94e-93d7-7736f68b3ec5 received_uuid ab1ea98a-b950-2047-802d-3b26568e2e14 u=
uid=20
44963c1e-7bc7-f34a-9370-ce180ce05b69 path 2019-06-10-1718

=2D-
Eric Mesa
--nextPart1608407.DF2yO8cWMC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEBs24pwhCu/Z7g0Sb2bE1K6FAnEUFAl0BhKgACgkQ2bE1K6FA
nEV6JwgAw8g65Dg02bx8HDcwHrT7Mi/FCX08gd26u0m1JyaL4AHfcgSWnM1u2TvQ
Bkmznn5I3Kv0jFkZOrJtSuUBpFN/cb3aaxUmODM5P4ikazkBnJi6fYWxwmUe2yyL
68BdXnIvjLRw4UC6a5NYWu9HsuHeL87y/2zmfUvR7X9R3IpWlfov53jRl/Gh2vze
3Hk93BEZ6njd8wcu1wdOzvM8KWJ9nzBtF7Cj076vfQkDax3bDM3o05Ih/lT88TS5
uD+qBqCmS8ccv2Z8Dt2dADQFqkt3fNhh11PjcscmdU1OOTgbtrQWY9g9T1phbX+J
Je5yw0uj09pcel8DoBlUCX8+2pwyCw==
=7+qn
-----END PGP SIGNATURE-----

--nextPart1608407.DF2yO8cWMC--



