Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B791BE757
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Apr 2020 21:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgD2T2Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Apr 2020 15:28:16 -0400
Received: from mout.gmx.net ([212.227.17.21]:40075 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbgD2T2Q (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Apr 2020 15:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588188494;
        bh=nzPXnWyw/AlOn+UH1LTgPn1BiCQmsUBJzWvS5Reazp4=;
        h=X-UI-Sender-Class:From:To:Subject:Date;
        b=hhM03LRbNuMNz7NDDrChRCa+M/TdvjMOLxUuCONiTsclyit5Xh95o7qjO/Xejnzxb
         pVoMrt4nZpM45vdu/Y4tazRdp1GUsJe6FZBjU1Z+dmNL+g8WcwpwL/uow7pirrA/rp
         SxLLMvPLjBRTlWIsqDw1RqzrfcQTAlkIsmd3gmbY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [89.15.237.249] ([89.15.237.249]) by web-mail.gmx.net
 (3c-app-gmx-bs35.server.lan [172.19.170.87]) (via HTTP); Wed, 29 Apr 2020
 21:28:14 +0200
MIME-Version: 1.0
Message-ID: <trinity-0c1fb57e-51b6-46ae-b8a3-b420c56db240-1588188494837@3c-app-gmx-bs35>
From:   rollojobs@partyheld.de
To:     linux-btrfs@vger.kernel.org
Subject: balance pause and resume seems not to work properly
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 29 Apr 2020 21:28:14 +0200
Importance: normal
Sensitivity: Normal
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
X-Provags-ID: V03:K1:rWl2ODwJ0vX1sILhsvwllCvVTpyvNcpi3chaN57WWafKZYbaABqKZy1s/zEfGZCoyWZCt
 MDgobJe+dS1BpXl3yex0QG+87FglpVyJAbWCpt+XCuTOvPgAt4DddPL2NZuGllcyxEyDEciDOi+K
 H07AXKnlmodel9nD5499raZXOdMA2MdlKHDzj1SMmnzVDNiCruR3wcjfPidKvyjpFg43qIW8L/89
 sqvlcIrLJ9MBM1prDAMql0rs2sA1cO53OCwsxAz9IliBEkKBZxO+pumJAZb9gyg64dkBYuYJ4EV8
 60=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0pZB+QjUEGI=:6+K0ZJvDyc+ao6jhXrgVVD
 nglTdvEsoS3yIttxhiFUNoVHfMUdqjSCHxArWubCaASQTDHGB93+MuFkLO9OsF7SWAZ1JT26Z
 UTFE9FJm7CvahZPXvhm+jCjCw6SV4WuOVrvbNRN3RhWy0KI43Nxl9AMJbElNHvPBGSWxcjBdv
 TLLyMMC9gNiXJVWRed//0cEj8rh5x+B62QtjCjpqMbgSUmt4DHMFcIZudKDYAHdfggsIkkUlb
 l2Z0Bqoc0WPg891sF7R9r/Jb+2T+felQgUNmfPmOd5q/Nt5he/U4/DtmfvIU7plVtA6m1UfKv
 GsCsxi0BA37mNSvcYrxACVaU2000+LA4I9aKL9MaidkGfBpUIChWZmCGWiEtumfdfp2x5bkes
 GzaGRkFkplSH1GCgkPWrQRbB+bev+/iRcMzj2rWzvgGHfkNX0Uc0hGddIRp3E5jLi07wIion4
 iEzvQgQpGNB/jKNT6bPzvGwfb1kf1LcaQcDagohNg1YD1i9ECeF+tNzAo+C1SXifOM8qjNIPW
 6dR/QigwNI/TIHqTxq87+ERldMKbynWTvgaLJhqnkjtJ2qqeLBW4Xbz/6wBkbz6GXXFp8FVla
 1iP5Q0RZd1HfvUcEqFzye0JzI7eotOXVaGsiuOQLCCJjwv91jv07x7M783de3ZEI9XstTAZXc
 LHf+kyc4yAgTSq9gsV39jOKfQtMnXsdQKcS3iFKKmG0g0vZPpFdcRpk+w2w3k/1YEJb8=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,
I created a filesystem of two drives (6TB and 750GB) with both data and me=
tadata raid 1=2E Then I put a couple of gigs on it and added a 2TB drive=2E=
 After balancing, the small drive should be empty and the two large drives =
should have all the data=2E But this doesn't work if balance is paused and =
resumed=2E

I startet balance with:
btrfs balance start --bg /srv/dev-disk-by-label-BTRFS1/

and then watched status:
Balance on '/srv/dev-disk-by-label-BTRFS1/' is running
3 out of about 14 chunks balanced (4 considered), =C2=A079% left =C2=A0

At this point I paused and then resumed=2E

btrfs balance pause /srv/dev-disk-by-label-BTRFS1/
btrfs balance resume /srv/dev-disk-by-label-BTRFS1/

And then I get this balance status:
0 out of about 3 chunks balanced (1 considered), 100% left
Balance on '/srv/dev-disk-by-label-BTRFS1/' is running

Why it's not 11 chunks but 3? It finished with:

Done, had to relocate 3 out of 14 chunks

and I've got this distribution:

Label: 'BTRFS1' =C2=A0uuid: 61e5aba9-6811-46ae-9396-35a72d3b1117
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Total devices 3 FS bytes used 11=2E13GiB
=C2=A0 =C2=A0 =C2=A0 =C2=A0 devid =C2=A0 =C2=A01 size 5=2E46TiB used 13=2E=
03GiB path /dev/sdc1
=C2=A0 =C2=A0 =C2=A0 =C2=A0 devid =C2=A0 =C2=A03 size 698=2E64GiB used 4=
=2E00GiB path /dev/sdf
=C2=A0 =C2=A0 =C2=A0 =C2=A0 devid =C2=A0 =C2=A04 size 1=2E82TiB used 9=2E0=
3GiB path /dev/sde


As it's raid 1, device 3 should be empty after finishing balance=2E Runnin=
g balance without pause comfirms that:

Label: 'BTRFS1' =C2=A0uuid: 61e5aba9-6811-46ae-9396-35a72d3b1117
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Total devices 3 FS bytes used 11=2E13GiB
=C2=A0 =C2=A0 =C2=A0 =C2=A0 devid =C2=A0 =C2=A01 size 5=2E46TiB used 13=2E=
03GiB path /dev/sdc1
=C2=A0 =C2=A0 =C2=A0 =C2=A0 devid =C2=A0 =C2=A03 size 698=2E64GiB used 0=
=2E00B path /dev/sdf
=C2=A0 =C2=A0 =C2=A0 =C2=A0 devid =C2=A0 =C2=A04 size 1=2E82TiB used 13=2E=
03GiB path /dev/sde =C2=A0

That means, balance doesn't work properly after pause and resume?

I'm running
btrfs-progs v4=2E20=2E1
5=2E4=2E0-0=2Ebpo=2E4-amd64

Best Regards
