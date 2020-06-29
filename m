Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098AF20E08C
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jun 2020 23:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389099AbgF2UrT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Jun 2020 16:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731541AbgF2TNw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:52 -0400
X-Greylist: delayed 406 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 29 Jun 2020 04:21:54 PDT
Received: from prometheus.amsuess.com (alt.prometheus.amsuess.com [IPv6:2a01:4f8:190:3064::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B9AC0076CB
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Jun 2020 04:21:54 -0700 (PDT)
Received: from poseidon-mailhub.amsuess.com (095129206250.cust.akis.net [95.129.206.250])
        by prometheus.amsuess.com (Postfix) with ESMTPS id 094D64000D
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Jun 2020 13:15:05 +0200 (CEST)
Received: from poseidon-mailbox.amsuess.com (poseidon-mailbox.amsuess.com [IPv6:2a02:b18:c13b:8010:a800:ff:fede:b1bf])
        by poseidon-mailhub.amsuess.com (Postfix) with ESMTP id 9903FD3
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Jun 2020 13:15:01 +0200 (CEST)
Received: from hephaistos.amsuess.com (unknown [IPv6:2a02:b18:c13b:8010:210d:6b92:9063:90f0])
        by poseidon-mailbox.amsuess.com (Postfix) with ESMTPSA id 43BE264
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Jun 2020 13:15:01 +0200 (CEST)
Received: (nullmailer pid 66765 invoked by uid 1000);
        Mon, 29 Jun 2020 11:15:00 -0000
Date:   Mon, 29 Jun 2020 13:15:00 +0200
From:   chrysn <chrysn@fsfe.org>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: doc: snapshot -r and -i can be used together
Message-ID: <20200629111500.GA65690@hephaistos.amsuess.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
X-Spam-Status: No, score=0.4 required=5.0 tests=KHOP_HELO_FCRDNS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
        prometheus.amsuess.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This aligns the man page with the usage output of the tool.

Signed-off-by: Christian Ams=FCss <chrysn@fsfe.org>
---

This confused me a bit when I first read the man page (why could a
read-only snapshot not be assigned to a qgroup), but experimentation and
looking at --help indicate that the mutual exclusivity of those options
in the man page was most likely due to an editing error when the option
was introduced.

 Documentation/btrfs-subvolume.asciidoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/btrfs-subvolume.asciidoc b/Documentation/btrfs-s=
ubvolume.asciidoc
index d8c414fd..89c3c263 100644
--- a/Documentation/btrfs-subvolume.asciidoc
+++ b/Documentation/btrfs-subvolume.asciidoc
@@ -207,7 +207,7 @@ rootid of the subvolume.
 -u|--uuid::::
 UUID of the subvolume.
=20
-*snapshot* [-r|-i <qgroupid>] <source> <dest>|[<dest>/]<name>::
+*snapshot* [-r] [-i <qgroupid>] <source> <dest>|[<dest>/]<name>::
 Create a snapshot of the subvolume <source> with the
 name <name> in the <dest> directory.
 +
--=20
2.27.0

--=20
We are dreamers, shapers, singers, and makers.
  -- Elric

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEECM1tElX6OodcH7CWOY0REtOkveEFAl75zTAACgkQOY0REtOk
veGd4RAAsOm+QaqFyryePdB+3j0yjtqYZFA73UcZJJKKAPEz7mrTA3tM8P76fLLb
z8Tcvp7UxNh38t44mXV0brqkTVugJWaSsq6J21BS+iGsE4+afzBjISHlBrzXo/RD
m5/Sf2oNOVx2+fd/tS4OvvXrphveTiRbpLk7swNUde5gLTwtNnUMXzfFtwRrqkM+
5iNBqxIMafl4sAkmRdjngi2XvxaaDHqiXIAGmMZ1UPOFGLGkZMe2e006gHT2wb1p
5ALygS9TiykYulevX4Tzr/ioQLilcxdGf5+D2gZdU1iepJuk/AKCDMY83hJ+ocz8
x/xy3jolWn5DN9aw3mSxmzBobSYTpjhWUoCOseFJK0h0cu7ZlsKUNBvMWinLk1ln
mHYdgwDJyzoPq+MpBIq7xy7GU3j3LrPCmmcZ3hn8ofoVCgVeyw2ACGLty08+TAQJ
hXmMAI9otT+aj5Yno2lHNvWu7wOyApcOu3n5S/Do5uxGMSrrbFB15tNi0UNhZ0wY
Ca4MKRvyt0LXdl/Fh7MaQE7I7+dv01wLg3Ajx+rNOK/EHgZYaIUouZrmRESYwxtz
+Q+RWMsY7KxDv79Z+ytfnQwMIfp5bEcywA1qyfgCjQC1NUaryn/aoFMSrUOVkPPq
feSYTUKafDETMCTUbH3wzO9atcsYnXwc/lfWL8+7ANP0fV0mCYI=
=vPRu
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
