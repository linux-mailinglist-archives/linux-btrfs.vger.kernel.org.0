Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF2944DD6B
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jun 2019 00:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfFTW0L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jun 2019 18:26:11 -0400
Received: from mail.seblu.net ([212.129.28.29]:34136 "EHLO mail.seblu.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbfFTW0K (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jun 2019 18:26:10 -0400
Received: from localhost (localhost [IPv6:::1])
        by mail.seblu.net (Postfix) with ESMTP id 2D7DC5381914
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2019 00:26:08 +0200 (CEST)
Received: from mail.seblu.net ([IPv6:::1])
        by localhost (mail.seblu.net [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 5hKJntu0aSIo for <linux-btrfs@vger.kernel.org>;
        Fri, 21 Jun 2019 00:26:07 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
        by mail.seblu.net (Postfix) with ESMTP id 5AA17538190D
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2019 00:26:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.seblu.net 5AA17538190D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seblu.net; s=pipa;
        t=1561069567; bh=1RyvMlnfA0gQOaaupFyON2mMSE+uQZPXQPWB1okZVoI=;
        h=Message-ID:From:To:Date:MIME-Version;
        b=J+FsQvWwPwn78iVsjSk2UGJVdc16MXLjT2xbZHDCTwk/pBVMIXHIVWDDC1fvgDYxl
         lNN2qL/q7KwYmWblAOBGW41f/mzEOrMhCELGOMBEAzOFfrPXAHh1vnE5iqMObGqjsc
         rcKOR059YcGY2e0+ylwBethVqpH/GkNXjRGzmsfurfueHeU9LEvqOOJBZh1YClmC6m
         Hj78dSc8U1tzof4DqSQmkm0X/gf2ol84kpW+WscRtOHhI7qUUnhGaCjAiFCjsJXXbL
         zmuctTcf7arpSccGq7Gi+dpuy+wyGxKwy7aVCQuCr+z0uQSQbTqLd3Cj6XlKSpztAd
         CgZC9mvYQgwKw==
X-Virus-Scanned: amavisd-new at seblu.net
Received: from mail.seblu.net ([IPv6:::1])
        by localhost (mail.seblu.net [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id ka19Iq7n878u for <linux-btrfs@vger.kernel.org>;
        Fri, 21 Jun 2019 00:26:07 +0200 (CEST)
Received: from dolores (amontsouris-684-1-27-121.w90-87.abo.wanadoo.fr [90.87.178.121])
        by mail.seblu.net (Postfix) with ESMTPSA id 14334538190C
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2019 00:26:06 +0200 (CEST)
Message-ID: <d7d16c4f6433cde59e2df51e88e09cfaa2a35d63.camel@seblu.net>
Subject: Corrupted filesystem, best strategy to get back my data?
From:   =?ISO-8859-1?Q?S=E9bastien?= Luttringer <seblu@seblu.net>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Date:   Fri, 21 Jun 2019 00:26:06 +0200
Content-Type: multipart/signed; micalg="pgp-sha384";
        protocol="application/pgp-signature"; boundary="=-Y9DROcgmghIbc66UcVcE"
User-Agent: Evolution 3.32.3 
MIME-Version: 1.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--=-Y9DROcgmghIbc66UcVcE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I have a new corruption on another Arch Linux server with a simple root btr=
fs
filesystem on an SSD.
The SSD has no corruption. Looks like the server crashed and rebooted. But =
the
next reboot failed because there is error with filesytem check.

Here is some info about the FS:

# btrfs fi sh
Label: 'white.root'  uuid: 617dda69-ffea-4569-9399-c6892e66d83a
Total devices 1 FS bytes used 24.33GiB
devid    1 size 468.44GiB used 50.03GiB path /dev/sdh2

# btrfs fi us root
Overall:
    Device size:	 468.44GiB
    Device allocated:	  50.03GiB
    Device unallocated:	 418.41GiB
    Device missing:	     0.00B
    Used:	  24.33GiB
    Free (estimated):	 443.10GiB	(min: 443.10GiB)
    Data ratio:	      1.00
    Metadata ratio:	      1.00
    Global reserve:	  66.17MiB	(used: 0.00B)

Data,single: Size:48.00GiB, Used:23.31GiB
   /dev/sdh2	  48.00GiB

Metadata,single: Size:2.00GiB, Used:1.02GiB
   /dev/sdh2	   2.00GiB

System,single: Size:32.00MiB, Used:16.00KiB
   /dev/sdh2	  32.00MiB

Unallocated:
   /dev/sdh2	 418.41GiB

Here is the output of check:

# btrfs check /dev/sdh2
Opening filesystem to check...
Checking filesystem on /dev/sdh2
UUID: 617dda69-ffea-4569-9399-c6892e66d83a
[1/7] checking root items
parent transid verify failed on 343358210048 wanted 3064554 found 3060713
parent transid verify failed on 343358210048 wanted 3064554 found 3060713
Ignoring transid failure
parent transid verify failed on 343358226432 wanted 3064554 found 3060713
parent transid verify failed on 343358226432 wanted 3064554 found 3060713
Ignoring transid failure
parent transid verify failed on 343358341120 wanted 3064554 found 3060713
parent transid verify failed on 343358341120 wanted 3064554 found 3060713
Ignoring transid failure
parent transid verify failed on 343358308352 wanted 3064554 found 3060713
parent transid verify failed on 343358308352 wanted 3064554 found 3060713
Ignoring transid failure
parent transid verify failed on 343358357504 wanted 3064554 found 3060713
parent transid verify failed on 343358357504 wanted 3064554 found 3060713
Ignoring transid failure
parent transid verify failed on 343358324736 wanted 3064554 found 3060713
parent transid verify failed on 343358324736 wanted 3064554 found 3060713
Ignoring transid failure
checksum verify failed on 343355752448 found 9ACEB5DF wanted E062A401
checksum verify failed on 343355752448 found 9ACEB5DF wanted E062A401
Csum didn't match
ERROR: failed to repair root items: Input/output error

I can readonly mount the filesystem manually with a livecd.
I got this:

[  100.074774] BTRFS info (device sdh2): disk space caching is enabled
[  100.076621] BTRFS info (device sdh2): bdev /dev/sdh2 errs: wr 5, rd 0, f=
lush
0, corrupt 1536, gen 0
[  100.087027] BTRFS info (device sdh2): enabling ssd optimizations

After runing a find I got these too

[  102.175348] BTRFS warning (device sdh2): sdh2 checksum verify failed on
343356260352 wanted D4568D65 found EB1AC7D4 level 0
[  102.175505] BTRFS warning (device sdh2): sdh2 checksum verify failed on
343356260352 wanted D4568D65 found EB1AC7D4 level 0
[  102.176222] BTRFS warning (device sdh2): sdh2 checksum verify failed on
343356342272 wanted D62720B8 found A25C27B4 level 0
[  102.176367] BTRFS warning (device sdh2): sdh2 checksum verify failed on
343356342272 wanted D62720B8 found A25C27B4 level 0
[  102.176557] BTRFS warning (device sdh2): sdh2 checksum verify failed on
343356440576 wanted 5038C46D found 1E960B6E level 0
[  102.176701] BTRFS warning (device sdh2): sdh2 checksum verify failed on
343356440576 wanted 5038C46D found 1E960B6E level 0
[  102.176917] BTRFS error (device sdh2): parent transid verify failed on
343357227008 wanted 3064554 found 3060713
[  102.177140] BTRFS error (device sdh2): parent transid verify failed on
343357227008 wanted 3064554 found 3060713
[  102.177407] BTRFS error (device sdh2): parent transid verify failed on
343357358080 wanted 3064554 found 3060713
[  102.177633] BTRFS error (device sdh2): parent transid verify failed on
343357358080 wanted 3064554 found 3060713
[  102.177856] BTRFS warning (device sdh2): sdh2 checksum verify failed on
343357374464 wanted 86A838FF found 4C316BC7 level 0
[  102.178000] BTRFS warning (device sdh2): sdh2 checksum verify failed on
343357374464 wanted 86A838FF found 4C316BC7 level 0
[  102.178214] BTRFS error (device sdh2): parent transid verify failed on
343357456384 wanted 3064554 found 3060713
[  102.178433] BTRFS error (device sdh2): parent transid verify failed on
343357456384 wanted 3064554 found 3060713
[  102.178695] BTRFS error (device sdh2): parent transid verify failed on
343357521920 wanted 3064554 found 3060713
[  102.178922] BTRFS error (device sdh2): parent transid verify failed on
343357521920 wanted 3064554 found 3060713
[  111.849676] BTRFS warning (device sdh2): sdh2 checksum verify failed on
343355834368 wanted 5E58C9A found DBF228EE level 0
[  111.849730] BTRFS warning (device sdh2): sdh2 checksum verify failed on
343355883520 wanted E1BB9C8F found 69F2A569 level 0
[  111.849732] BTRFS warning (device sdh2): sdh2 checksum verify failed on
343355899904 wanted D6DE6F6F found 46976008 level 0
[  111.849846] BTRFS warning (device sdh2): sdh2 checksum verify failed on
343355834368 wanted 5E58C9A found DBF228EE level 0
[  112.088981] BTRFS warning (device sdh2): sdh2 checksum verify failed on
343356194816 wanted 761BD0D0 found 5C8CC96C level 0
[  112.089128] BTRFS warning (device sdh2): sdh2 checksum verify failed on
343356194816 wanted 761BD0D0 found 5C8CC96C level 0
[  112.173042] BTRFS warning (device sdh2): sdh2 checksum verify failed on
343355998208 wanted 6AB69B4F found 9EA49163 level 0
[  112.173181] BTRFS warning (device sdh2): sdh2 checksum verify failed on
343355998208 wanted 6AB69B4F found 9EA49163 level 0
[  112.223272] BTRFS error (device sdh2): parent transid verify failed on
343357521920 wanted 3064554 found 3060713
[  112.223478] BTRFS error (device sdh2): parent transid verify failed on
343357521920 wanted 3064554 found 3060713

I tried to backup my data with rsync but I have a lot of csum errors.

What's the best strategy to retrieve my data as they are, even if they have
some wrong bits ?
I guess --init-csum-tree is a bad idea ?

Regards,

--=20
S=C3=A9bastien "Seblu" Luttringer

--=-Y9DROcgmghIbc66UcVcE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIrBAABCQAdFiEEVyJOyaX8pvvJK7iqShr8NF6+GPgFAl0MB/4ACgkQShr8NF6+
GPhUpQ+/ZYurAJ/l4uJvHfRO6yEeXbsN5XCb7a0bQaLmg0PFu0nZOg2DGNW34bti
S6WJQvnlEQjf556sybfYhe7B4zxU4I1oF126FFA2kUsT7ANKneTvF/mmsneOyZn2
rxHY6jQLkWhBihaSW/LhJ8lxWGhrQ6FC9pr5LcrmM5UNoFT6AYEHNczugfdef17i
zwmtIQAzuSocy2WPtceXbS3bhICydVI7hiSViLiPrgcMJJ0aE1DTzuOE2G7NCBnL
G3mJK2YZ4HAcRDXF20ad7oWv4MOvbwjnEL8QFqcuxbZdxbkZZzNlkRHLLcCVg064
AxdnHRIrFIVRr6s3pN35bf3ET9Gcg4p+vfEAuIQeGZnIpjm9vSFTjn13tyAXN2p2
6x7lCPcCwL709YZPGwLxz5M7J+enUya3CTzSwuPANN2sQdHbCykqNAPh/S3qQnT8
sSz00ZglSnj24ZUH3QveAve/QnYFckHOmtpVl76sd9CjpjHkzIgWEHQYltY3HVkt
QIRbflnOm34ia5W4asxKDZ4I1p4dZ217X0QS5ocsuzJHlGrmKrxZ69sSLhMGDApa
JZ3UMu6HrAQDRbbTtU/1JIx31lIgvOHHT0lkLYsH/EYlHqtAu90ohONI11HEGKED
jiZSWw0Pd24BvP/3RNWC3NfsW0iX5Z7mDJghyeYy
=x4g7
-----END PGP SIGNATURE-----

--=-Y9DROcgmghIbc66UcVcE--

