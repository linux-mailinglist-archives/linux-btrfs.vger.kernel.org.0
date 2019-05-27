Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A91C92BBC5
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 May 2019 23:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfE0VdZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 May 2019 17:33:25 -0400
Received: from mout.gmx.net ([212.227.15.18]:40301 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726772AbfE0VdZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 May 2019 17:33:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558992804;
        bh=3aNDVsO9ZmI09TjozsspeS1VIT65hPFn9HfclRRuXHE=;
        h=X-UI-Sender-Class:From:To:Subject:Date;
        b=LSP9Ypa8Ude32/taFc96cjy8Nd+OxnslYv/MzESLZ7MzEB8PwJ7mVgKD7px7i1ShL
         6YiCwngZxZ3orBz87Yn0XgtY2PAzrEj5wj12Nj9/mncxOVliZem8MHNLoMY4+lneLA
         hfh4NDY6uLZTxu8KP8PMR/R9G+4MpL1A+4t7xj1w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from monk.localnet ([149.172.254.164]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLQxN-1hEWoa3kNH-00IVVN for
 <linux-btrfs@vger.kernel.org>; Mon, 27 May 2019 23:33:23 +0200
From:   Dennis Schridde <devurandom@gmx.net>
To:     linux-btrfs@vger.kernel.org
Subject: parent transid verify failed on 604602368 wanted 840641 found 840639
Date:   Mon, 27 May 2019 23:33:19 +0200
Message-ID: <5406386.pfifcJONdE@monk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2107368.RUAUMbZgvL"; micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Provags-ID: V03:K1:2cvovtdPUaJtK3JARp4g1VQn/cnk/QKxxmcP29xVOxCgi7G7YDv
 Lms4/p3lVl1tYD48cr03iM7YRpNiQ7wQ6oUa8jpz43NXFaeaYlaG6193mqq9uaFBhIlNQ4u
 GXX6cbEpdrJWrI22NX5sx/vQQkw9R/vW2NyxrtFHEZ/aNrw8ly/p50Xk1OBjQENqJe08uHT
 tnJktkXeUzEVyK1RdmAoA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sYWieKPuQKc=:/6WUS2qfjyHmMbxzXyUkK/
 dGA3wcfg3To1VpE15SehRMx8YvjnMX3ymaEUzoftGveI3A5mmUZTzb8wR0X0DCmbFTIveHHOP
 sY+JxZDy345TgPMYG542sQxATIN1xUsaT6EuzPgMq/DZqp85Ciw/Cz34xbrB8UiGw2DvKuQ2P
 T6C6OgctuQpTSbeWHHMR+EeBxTktRJudVfR5GfH6iNBOqHrqWBw1kweJJD7/j0WuvZhBwzrtY
 ycIuN9HGOOUTaYBi7yj7kTYrkmTQyz+bW2vW1kb0dcMZn8+6YHkZUq0tJevfvC3qEJ6nlOhfQ
 1n8xv2zud5evXCAJLWPC/E2R0KZ/9+F0+4/gq9LmHEy2d9/7WZn9d/pUSbSJ6xAj8HxPiHGdR
 P8rAmb9+byMqe6sD1ZuiM3x/IZAd9GkpGRn742aVC5gsgX9Ic5WLaHTWLycBd/tcog9QZq7Tw
 kGnJCMjXkAZ5jaQKS3k9mXsmv5uZuxhggqkGEm1pP4Vq+N1INQnJqPqbjtOtjvJLbIcJ9blpF
 7oB3JSxqO4MMw9ZCX0+H9k7euJ919qeWiXO6McTe79Ilvh0/cQzjFoDaeL/p4fbxZI7tK6Jjg
 5PM0MCPAeZqYd98ut5F9Ej0y8MEq1Ek5RdNMs5GDz0OGxmS0KOGsVtPWAV8m0+Bfc/fORNBye
 9wf8tmBdBWHLqNa2QlYi64nd8jCGLPnH5dFQqtlAq1Ty6Q4DSSxZXzlw21yCJjcTkzR3qOTAJ
 yfh8yzp0N3VtWiIbu2hm2KF8XboMB8sTttiMTfVpwwtnP7WtNvEUd1bj71hq/7ckX+cpFxMKp
 CHC8JAs/ObLBHoy0XM01Vb7ozgNgu9NYIB7Jfe/t9W+7EuPrrnRicFTHVm7klxPCwtsyDoXAb
 RwTA7ztwDVaAvmY+1ffsVTb7pbtWYCA4GTaf4xlAnU3hiI9+gpQirFEwnk3gbc7QSy/sqXLPJ
 QpBUY4bw62mSqyHl0+arIgW3IOPmgbBo=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--nextPart2107368.RUAUMbZgvL
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Hi!

Yesterday I upgraded from Linux 5.1.1 (built with GCC 8.3.0) to Linux 5.1.=
4
(built with GCC 9.1.0).  The next boot was extremely slow and the desktop
environment (KDE Plasma) never really started, but got kind of stuck in th=
e
startup screen.  So I switched to a VT and pressed ctrl+alt+del.  The next
boot stopped early with following message:

[T445] BTRFS: device label <...> devid 1 transid 840641 /dev/bcache0
[T599] BTRFS info (device bcache0): disk space caching is enabled
[T599] BTRFS info (device bcache0): has skinny extents
[T599] BTRFS error (device bcache0): parent transid verify failed on 60460=
2368
wanted 840641 found 840639
[T599] BTRFS error (device bcache0): open_ctree failed

How can I recover from this?

The filesystem should have several snapshots (created by snapper [1], on e=
very
boot and hourly).  Will they be of any help recovering my data?

Best regards,
Dennis

[1]: http://snapper.io/

--nextPart2107368.RUAUMbZgvL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQGzBAABCAAdFiEE0Ngi/nirHnbsz3NFz+h/M161qdwFAlzsV58ACgkQz+h/M161
qdxvtQwAjb24L/bcvSTCSZuIN6Ntp2jihyVwzTkdEMPKz4uxN9mocBqUVzuFVku3
mF2swoFItzIr2lvwFQXtry/Oce9AhKpfOYbCVKMBtw6976cy4RsvdiB/wtIaM4pF
nz4XxIHyRKZQfH6j4gZgpX/OqUqI0kQeGx9xnBzM1+yqrq25vRDvN7KiaW7FITRK
OL2ZKtSMur5LTwmQUBqVejgGBhgCXYoQjXsMSL9Amv4HagCH30cA4iOwteqESlHJ
rvgWU7Foa8IFYBKdVVVvhTJyKkVMpdnMnvy7+++4vfFCtrKt17gPOO058CKhMFbv
t0Xm/irlRXCUn3Sxi1XUinEvP3RohCyfkUgeTlC26rXQbnhOLKliCHvnVzGTaO2d
W87mjacMP24nWffXXVOn17ICVSrUD4tGpI+zqdrUSG2e9HNnm40tusNpz4Nxc1uI
stiWWGIcJLZzF1tvT0TKiFLix1IT6ms2HBSz2/RqRJUROFQh8SDwhUUeAi4zusg+
k3UbCDAV
=0vD0
-----END PGP SIGNATURE-----

--nextPart2107368.RUAUMbZgvL--



