Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2B333C20A
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2019 06:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbfFKETe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jun 2019 00:19:34 -0400
Received: from dog.birch.relay.mailchannels.net ([23.83.209.48]:55857 "EHLO
        dog.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726199AbfFKETe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jun 2019 00:19:34 -0400
X-Sender-Id: dreamhost|x-authsender|eric@ericmesa.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 1E2CE6A10ED;
        Tue, 11 Jun 2019 04:19:32 +0000 (UTC)
Received: from pdx1-sub0-mail-a21.g.dreamhost.com (100-96-89-88.trex.outbound.svc.cluster.local [100.96.89.88])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 8B5FF6A0DDE;
        Tue, 11 Jun 2019 04:19:31 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|eric@ericmesa.com
Received: from pdx1-sub0-mail-a21.g.dreamhost.com ([TEMPUNAVAIL].
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.17.2);
        Tue, 11 Jun 2019 04:19:32 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|eric@ericmesa.com
X-MailChannels-Auth-Id: dreamhost
X-Cooperative-Plucky: 3cd0a07d15617a0a_1560226771954_756055862
X-MC-Loop-Signature: 1560226771954:239427049
X-MC-Ingress-Time: 1560226771954
Received: from pdx1-sub0-mail-a21.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a21.g.dreamhost.com (Postfix) with ESMTP id 07E2881C78;
        Mon, 10 Jun 2019 21:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=ericmesa.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-type; s=ericmesa.com; bh=HCG+/jJmL2fUn2F2Z/x2DNYPSOI=; b=
        HAPc14qlXsFtVlbhdaWtzDFVboqMabMyut6B72eqi3jZAw3gRi9qw0xTyShP7jMm
        YrxtRSMjYDXLiH4KGsPU/dmC5mJfX3/iNC35eL800uG4KHy0gYSMowzPtbt/zjaS
        3pvI521xBG3Kgido5OpeW6KYt1lmUmFX9B1s2EsFeSk=
Received: from supermario.mushroomkingdom (pool-68-134-39-132.bltmmd.fios.verizon.net [68.134.39.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: eric@ericmesa.com)
        by pdx1-sub0-mail-a21.g.dreamhost.com (Postfix) with ESMTPSA id 51E8B81C8D;
        Mon, 10 Jun 2019 21:19:27 -0700 (PDT)
X-DH-BACKEND: pdx1-sub0-mail-a21
From:   Eric Mesa <eric@ericmesa.com>
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Issues with btrfs send/receive with parents
Date:   Tue, 11 Jun 2019 00:19:18 -0400
Message-ID: <2008850.MjMmxLcJHu@supermario.mushroomkingdom>
In-Reply-To: <9d9f4b67-57c1-2003-8e15-52e8460c3c9d@gmail.com>
References: <3884539.zL6soEQT1V@supermario.mushroomkingdom> <CAJCQCtSLVxVtArLHrx0XD6J1oWOowqAnOPzeWVx3J25O7vxFQw@mail.gmail.com> <9d9f4b67-57c1-2003-8e15-52e8460c3c9d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart17733267.UCKWHnz3sf"; micalg="pgp-sha256"; protocol="application/pgp-signature"
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: -100
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudehfedgjeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuggftfghnshhusghstghrihgsvgdpffftgfetoffjqffuvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhggtgesghdtreertddtjeenucfhrhhomhepgfhrihgtucfovghsrgcuoegvrhhitgesvghrihgtmhgvshgrrdgtohhmqeenucffohhmrghinhepieegqdhlihhnuhigqdhgnhhurdhsohenucfkphepieekrddufeegrdefledrudefvdenucfrrghrrghmpehmohguvgepshhmthhppdhhvghlohepshhuphgvrhhmrghrihhordhmuhhshhhrohhomhhkihhnghguohhmpdhinhgvthepieekrddufeegrdefledrudefvddprhgvthhurhhnqdhprghthhepgfhrihgtucfovghsrgcuoegvrhhitgesvghrihgtmhgvshgrrdgtohhmqedpmhgrihhlfhhrohhmpegvrhhitgesvghrihgtmhgvshgrrdgtohhmpdhnrhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--nextPart17733267.UCKWHnz3sf
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Monday, June 10, 2019 11:39:53 PM EDT Andrei Borzenkov wrote:
> 11.06.2019 4:10, Chris Murphy =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > It's most useful if you show exact commands because actually it's not
> > always obvious to everyone what the logic should be and the error
> > handling doesn't always stop a user from doing something that doesn't
> > make a lot of sense. We need to know the name of the rw subvolume; the
> > command to snapshot it; the full send/receive command for that first
> > snapshot; the command for a subsequent snapshot; and the command to
> > incrementally send/receive it.
>=20
> And the actual output of each command, not description what user thinks
> has happened.

Here is a new session where I'll capture everything - well, on the defrag I=
'll=20
do a snip.

#btrfs fi defrag -v -r /home/

=2E..there follows a list of files that just scrolls infinitely....
/home/ermesa/.dropbox-dist/dropbox-lnx.x86_64-74.4.115/_bisect.cpython-37m-
x86_64-linux-gnu.so
/home/ermesa/.dropbox-dist/dropbox-lnx.x86_64-74.4.115/
tornado.speedups.cpython-37m-x86_64-linux-gnu.so
/home/ermesa/.bash_history
total 1 failures

# sync

# btrfs sub snap -r /home/ /home/.snapshots/2019-06-10-2353
Create a readonly snapshot of '/home/' in '/home/.snapshots/2019-06-10-2353'

# btrfs send -vvv -p /home/.snapshots/2019-06-10-1718/ /home/.snapshots/
2019-06-10-2353/ | ssh root@tanukimario btrfs receive /media/backups/backup=
s1/
supermario-home
At subvol /home/.snapshots/2019-06-10-2353/
ERROR: link ermesa/.mozilla/firefox/n35gu0fb.default/bookmarkbackups/
bookmarks-2019-06-10_679_I1bs5PtgsPwtyXvcvcRdSg=3D=3D.jsonlz4 -> ermesa/.mo=
zilla/
firefox/n35gu0fb.default/bookmarkbackups/
bookmarks-2019-06-09_679_I1bs5PtgsPwtyXvcvcRdSg=3D=3D.jsonlz4 failed: No su=
ch file=20
or directory

Same error as before. So I go to tanukimario and del the errored subvol. Le=
t=20
me try with -vvv on the receive as well. Well, that produces a ridiculous=20
scrolling list that I can't possible capture. Perhaps just -v? No, that's t=
he=20
same. So then I tried this command:

# btrfs send -vvv -p /home/.snapshots/2019-06-10-1718/ /home/.snapshots/
2019-06-10-2353/ | ssh root@tanukimario btrfs receive -vvv /media/backups/
backups1/supermario-home > receive.log

But my bash-fu was bad and it didn't put anything into the log other than "=
At=20
snapshot..." So yeah....

What scrolled on my screen ended like this:


write ermesa/.cache/mozilla/firefox/n35gu0fb.default/cache2/entries/
32C1CAC72D7CACC3630A470C6622283DA500617A - offset=3D540672 length=3D49152
write ermesa/.cache/mozilla/firefox/n35gu0fb.default/cache2/entries/
32C1CAC72D7CACC3630A470C6622283DA500617A - offset=3D589824 length=3D49152
write ermesa/.cache/mozilla/firefox/n35gu0fb.default/cache2/entries/
32C1CAC72D7CACC3630A470C6622283DA500617A - offset=3D638976 length=3D49152
write ermesa/.cache/mozilla/firefox/n35gu0fb.default/cache2/entries/
32C1CAC72D7CACC3630A470C6622283DA500617A - offset=3D688128 length=3D34158
utimes ermesa/.cache/mozilla/firefox/n35gu0fb.default/cache2/entries/
32C1CAC72D7CACC3630A470C6622283DA500617A
write ermesa/.cache/mozilla/firefox/n35gu0fb.default/cache2/entries/
DC0F9B96CE8C66CE51826341395D9B8805053D05 - offset=3D0 length=3D49152
write ermesa/.cache/mozilla/firefox/n35gu0fb.default/cache2/entries/
DC0F9B96CE8C66CE51826341395D9B8805053D05 - offset=3D49152 length=3D49152
write ermesa/.cache/mozilla/firefox/n35gu0fb.default/cache2/entries/
DC0F9B96CE8C66CE51826341395D9B8805053D05 - offset=3D98304 length=3D49152
write ermesa/.cache/mozilla/firefox/n35gu0fb.default/cache2/entries/
DC0F9B96CE8C66CE51826341395D9B8805053D05 - offset=3D147456 length=3D49152
write ermesa/.cache/mozilla/firefox/n35gu0fb.default/cache2/entries/
DC0F9B96CE8C66CE51826341395D9B8805053D05 - offset=3D196608 length=3D11390
utimes ermesa/.cache/mozilla/firefox/n35gu0fb.default/cache2/entries/
DC0F9B96CE8C66CE51826341395D9B8805053D05
unlink ermesa/.cache/mozilla/firefox/n35gu0fb.default/cache2/entries/
=46EFC32BF08374B9F91B5B002FF51DF3DFB21B667
utimes ermesa/.cache/mozilla/firefox/n35gu0fb.default/cache2/entries
write ermesa/.cache/mozilla/firefox/n35gu0fb.default/cache2/entries/
177BF2896EEBDB17A538A6ACB13C62925D0E84CA - offset=3D0 length=3D12280
utimes ermesa/.cache/mozilla/firefox/n35gu0fb.default/cache2/entries/
177BF2896EEBDB17A538A6ACB13C62925D0E84CA
write ermesa/.cache/mozilla/firefox/n35gu0fb.default/cache2/entries/
A0BC2B69D3EACA6005AFF72A4EC168ECC4DFC764 - offset=3D0 length=3D220
utimes ermesa/.cache/mozilla/firefox/n35gu0fb.default/cache2/entries/
A0BC2B69D3EACA6005AFF72A4EC168ECC4DFC764
unlink ermesa/.cache/ksycoca5_en_cJ+y22ar1ZzIcHsefGXiujDwk34=3D
unlink ermesa/.cache/ksycoca5
utimes ermesa/.cache
utimes ermesa/.cache
link ermesa/.mozilla/firefox/n35gu0fb.default/bookmarkbackups/
bookmarks-2019-06-10_679_I1bs5PtgsPwtyXvcvcRdSg=3D=3D.jsonlz4 -> ermesa/.mo=
zilla/
firefox/n35gu0fb.default/bookmarkbackups/
bookmarks-2019-06-09_679_I1bs5PtgsPwtyXvcvcRdSg=3D=3D.jsonlz4
ERROR: link ermesa/.mozilla/firefox/n35gu0fb.default/bookmarkbackups/
bookmarks-2019-06-10_679_I1bs5PtgsPwtyXvcvcRdSg=3D=3D.jsonlz4 -> ermesa/.mo=
zilla/
firefox/n35gu0fb.default/bookmarkbackups/
bookmarks-2019-06-09_679_I1bs5PtgsPwtyXvcvcRdSg=3D=3D.jsonlz4 failed: No su=
ch file=20
or directory

=2D-
Eric Mesa
--nextPart17733267.UCKWHnz3sf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEBs24pwhCu/Z7g0Sb2bE1K6FAnEUFAlz/K8YACgkQ2bE1K6FA
nEX87QgA0AMPhT6bUHgWJphZFD0X0LLA9VO93E6hCy36tUlkHuU7bs9+1rn98LLP
TU4t3SNL7yk5S48J//uHyhPlPZgBoNb6Wox/TfKaIKu5QsZ7lxXU4iCEouzY517+
cUMXAgyNEOFq45AyymWJugu5QjVtvbx7xR+XEQXuqaLaGZwHOYzG3Y3VaK0pCFq+
XalqHuyICIjQAgesY2oRahDfp+FPsjmCsspAsQhMzicEdeuRwfTxy8So3aZvl8R/
MHdqyPaoYw4x2JZDOR0uSaVOYAZ20wbxNq6TyJDU0mOpprsEtP4nfG4Pf4ahxWCx
ogaY8IXmxXyHUOi4QFq9QmJW+uKTJQ==
=5QHE
-----END PGP SIGNATURE-----

--nextPart17733267.UCKWHnz3sf--



