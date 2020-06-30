Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8300320FD1F
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jun 2020 21:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgF3Tzx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jun 2020 15:55:53 -0400
Received: from mout.web.de ([212.227.17.12]:52041 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728327AbgF3Tzw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jun 2020 15:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1593546950;
        bh=EwzMAkxojBFAkoI0z4m92OMprKKbUoOto5/lHq91Dd8=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To;
        b=HnXkbjJh8p2z8i+k7BdMcFh9ahbEaYikNKxGcCpJXtErvGlm7BBh7N8Y93CctUmnG
         HxlbsjELri2hG54+wZ8vxHZsOm5Ib5fBv5ltY8q+ojq0GRe7+QOIYLracRBiFj0pUY
         hrhtEyN75sizATCNVkI5mbGfvAN1ZBlL9jWZezD4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.143]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M3jwL-1izDfj0NE1-00rEjg; Tue, 30
 Jun 2020 21:55:50 +0200
Date:   Tue, 30 Jun 2020 21:55:41 +0200
From:   Lukas Straub <lukasstraub2@web.de>
To:     illia.bobyr@gmail.com
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: "parent transid verify failed" and mount usebackuproot does not
 seem to work
Message-ID: <20200630215541.5fc71893@luklap>
In-Reply-To: <c49e3370-c2b9-59a2-b578-9b5750951f25@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/I_a3ADLoTNLWGM=xV4US2Ua";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:k3UeJnCoGRjOmModYA2sxq2pLyZMIznHEWPDP8moHErVtIVX5HO
 CoySfWM/ni7+r5jm5qyBFPDmTi1S6rbWWN771HpuE+R8eC2mbqeLUhVOoGqkny1JqANU68K
 o6DcCg1uadtTM7ANP56j5zE2i8NWC7yu76028KmviTXm+Ry0/6ggGCnYVvrmxCzjtTe6fIa
 P/TIPFy4e1KbprsO4uDbQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0Rgq+wlypXM=:NvKNaebYEeZ7eoOL19k9S2
 wSg+r/c6IXCxtepgTyp5o1YkDYSFIKDbKdEv3OXIKRN/HzoGZ/bLYX4cUawOHP+4Je6itJM3P
 o+winotxfW0J85Cw0iFw6+9IrYDHrbLiRUeSMpcVhXdsfjAlFlXY/jWwfk1FFQE7gCV6valOe
 yL4MzmQuxLlksfP34inB0qFCYlcptzskeavUUPyPcHE3w5h1Pjk0MD0KWFF3IvnJT/VdIqxm9
 SgPMPNtUc/qd/QpvMDHMx+pNdwHGPV0HInBgOW8Y4/lBCLrcy1Weyk1lUPaLSItEJKZCeIdJc
 R/LALYyoIEni0wBRIw3EDI5mREz3dGccrj1/cL7SCYR7O6zNSeTaq0tS+WLycQ+8o1JU1wFd/
 RVx5RNYbqaBRUvYMUdwZSR9THKD9wPUD4s6i6pXw7LToH6r70qlrcHr86PPHV+kNdDjZZ3vSu
 8XWI6m6WfBZq/weqnhyP0vYOt4Q1jJCmTt4ZPZ5N2j0PkihH6eGx4sUe5/KVHEHdlNokT0QhX
 Ud/248F+PmgKQ9+HK91VCv30DWeJThHugRlAnprcUAwbn/gxDohUcOtyvUyy+IhsluIwVXqzq
 i+b9Ue1gO3B5+6vUfJa3dVuLxDSzjXIFFbCbfgCPJy2Ob7gW2HzLVJzIM/evgxla5g2D//TrB
 ic5p1H+SQoYojY52NLTBy6yq1TK8+mW5K7q4+NxoLjZqwy+dXzmwQpx6ZLH1rpuuHRlVlZHKL
 f5GOO4A0+i022hfxOM+T7OsjsnQxwrI8xBrnqu0vf5CVB359IQGFiChuTav2d1l+GkPDH06s5
 2pzDuneHCILge9HPHuUydqg65ZT8tUt10D8CWVNmlREwd8F1/Ul9Lon9xHmcf64tJPoQzoBk5
 +LqUWobvoHzrYCChkdMycJh/D8YZZrPfqGzRAq4pwaW1xfNlrhxkojbNBMV9S4CEYJTXOkzS4
 ZoNis7/t2qGt/Ew7JDSZoD+BGsqaev7ytZzaVCtSf0srTUxDcHQ7/QR6OFl4aPs+wROJ6H8s5
 cWlLwh1SohAi9BJRoA77jq0gbOhDYpV4NjcjIowFCiNK2XCkigfSwEZ89EjW7botxplw2r6+Y
 mpgD7kIIJ/fEIdncSKMMNkkHxBz9SrwaDsAc2Iz6z6aWAPvTrhlvu3oBDyc8omHT7DhaHxYaP
 Ek2/7jkplXmy+3KU8w7ZTUc/ttZ1OZKGcMS8uIoDTeW3bqLDB64oDJMcz/hcN0hhPZQ1PUPpM
 qLxFkd3JNdvREgGUCLHE15bLQdjWxQ/Z2R0QGbw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--Sig_/I_a3ADLoTNLWGM=xV4US2Ua
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,
The developers will need the output of "btrfs check <disk>" to debug the pr=
oblem further. Also you can use "btrfs restore <disk> <target>" to rescue d=
ata off your disks.

Regards,
Lukas Straub

--Sig_/I_a3ADLoTNLWGM=xV4US2Ua
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl77mL0ACgkQNasLKJxd
slgKExAAtZlbAMQnElMYTU9vM+XIAgWovnq3f9N70NDXiw0hPDeipdeUeBkznBKu
gEpt4opjBfEGYiBoCpUu/arucEC9JzEONEOFjD4kal/QT1It2R7TWnZ8MqVb4jxO
/zvWrurkVsERXb+q5aCaYslzqiGIDtvj7bN1XMO/lJrzFimEwtICwAUtvNRCwZjb
0j16pmfrxaIRYRjmafhGo3IcTma8e9d1oJIb372LjpYqsRjn4ZRfmfocaUjq5obc
uCuLbbBAwEnSdvYps26TF72nC61bpoSjXeCA06mQxrwD3VTpaqZZUhQ0/aPb9J10
8OGCtSIyUjR5BGzYXwwUpvk0/OYksDIEJQydh/Wa8WR531T0ZKKZ2jluCWSK/U2T
KOAd1ddhZtnsihNjVxYv/pyyujFLzhadUxQugbUVS2mvzQuJ2grpO3PJvCYE8vk5
b0mW9a/Yf492T+3JvTha9Swv6UtZyCEpQqgIg4rHtxnovHR+sFuO4NZVD3SWnn69
15HhiSaHqvnhAJbZuMf3VEL+Iqr1pRfK7fKQdUPYx3eRgUqG2p2KDfFPPW+XR6lk
E7KbdSgRHjo3Dvw8ZfQXQACQZ27EOHlrWrYHP4aDN/6WQZug/UWSt0kmq/SReMMP
CZQcqOqzbGO78fFdm5HkosBCEcDg8F/Xfd3tjKfbnxceX+htTbM=
=gqTN
-----END PGP SIGNATURE-----

--Sig_/I_a3ADLoTNLWGM=xV4US2Ua--
