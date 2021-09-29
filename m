Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B11241BCB9
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Sep 2021 04:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243718AbhI2C3z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Sep 2021 22:29:55 -0400
Received: from relay.wolfram.com ([140.177.205.37]:52620 "EHLO
        relay-ext.wolfram.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243793AbhI2C3x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Sep 2021 22:29:53 -0400
X-Greylist: delayed 308 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Sep 2021 22:29:53 EDT
Received: from relay-10-128.wolfram.com (relay.wolfram.com [10.128.2.101])
        by relay-ext.wolfram.com (Postfix) with ESMTPS id 33FDE15D8
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Sep 2021 21:23:02 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay-ext.wolfram.com 33FDE15D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wolfram.com; s=relay;
        t=1632882182; bh=wMe3AUjmRcDANqBjDP9mhW0Y0NmCBOusH8ATA0MPtt8=;
        h=Date:From:Reply-To:To:From;
        b=irvrwIFxM7Ip5e7ElIcwIBDGIN462Z3UqYID0PXniKvJteRU0rGujAX9+9uH7Z3tH
         31xJ7J0y3PTxwTIXZh+J8vAQSfe3rxSwgX+FYK2OdqnnMjw41ayCx6cXordWvO/Wv2
         1Gi/+/rSkeqXKQNJMq1LMi7xy6cOGXXiJkwg2/kY=
Received: from wrimail05.wolfram.com (wrimail05.wolfram.com [10.128.1.216])
        by relay-10-128.wolfram.com (Postfix) with ESMTPS id 26AB2300053
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Sep 2021 21:23:02 -0500 (CDT)
Received: from wrimail05.wolfram.com (localhost [127.0.0.1])
        by wrimail05.wolfram.com (Postfix) with ESMTPS id 16F661A0AB6
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Sep 2021 21:23:02 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
        by wrimail05.wolfram.com (Postfix) with ESMTP id E75161A0B0F
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Sep 2021 21:23:01 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 wrimail05.wolfram.com E75161A0B0F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfram.com;
        s=E3ED0494-3FFA-11EB-8895-C5FFDA13CE33; t=1632882181;
        bh=zq/eh1t3HNZb6Le5X9oaHTfu+b7Qh3X2OZ+nAXX5Ag0=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=nJrcTUOnyyC3ZKrS4luUQEfD+kTpxCP7eoMlYs8NNPv+uE1fYOEFbhyuMLdlZcNjt
         n6qCu+wmS99W//MZnqbYfLjwP+YCuoSwxczCq+N/BzfI9e9sVPhXnnvN3XW5Mhy/F6
         Cw5bOP8TQp6jTFJxtJnz0/Fll6bOghVELIUmp0eBW9/TI1QsJIcKEBm7ZidHa+r+ZX
         XFAjZuNlrgknTw8w9Cdm49nDC0RTXwTcx4e4Q4SEuA457gUY/inoH6w4m71d9dMx71
         CVWl5oC3kV51AfLVrMjLWMbB3FrdvY6pUjY9EFsHdP1QhgcGrkah4SLjYiNTo2/VTc
         E3GmlXSFZDclQ==
Received: from wrimail05.wolfram.com ([127.0.0.1])
        by localhost (wrimail05.wolfram.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id psgdqwzF-u3W for <linux-btrfs@vger.kernel.org>;
        Tue, 28 Sep 2021 21:23:01 -0500 (CDT)
Received: from wrimail05.wolfram.com (wrimail05.wolfram.com [10.128.1.216])
        by wrimail05.wolfram.com (Postfix) with ESMTP id D3B331A0AB6
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Sep 2021 21:23:01 -0500 (CDT)
Date:   Tue, 28 Sep 2021 21:23:01 -0500 (CDT)
From:   Brandon Heisner <brandonh@wolfram.com>
Reply-To: brandonh@wolfram.com
To:     linux-btrfs@vger.kernel.org
Message-ID: <70668781.1658599.1632882181840.JavaMail.zimbra@wolfram.com>
Subject: btrfs metadata has reserved 1T of extra space and balances don't
 reclaim it
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.99.100.5]
X-Mailer: Zimbra 8.8.15_GA_4125 (ZimbraWebClient - GC94 (Win)/8.8.15_GA_4059)
Thread-Index: 8d6NZnAtCHL+Yph8ICQG0AJ1YSa8/g==
Thread-Topic: btrfs metadata has reserved 1T of extra space and balances don't reclaim it
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I have a server running CentOS 7 on 4.9.5-1.el7.elrepo.x86_64 #1 SMP Fri Ja=
n 20 11:34:13 EST 2017 x86_64 x86_64 x86_64 GNU/Linux.  It is version locke=
d to that kernel.  The metadata has reserved a full 1T of disk space, while=
 only using ~38G.  I've tried to balance the metadata to reclaim that so it=
 can be used for data, but it doesn't work and gives no errors.  It just sa=
ys it balanced the chunks but the size doesn't change.  The metadata total =
is still growing as well, as it used to be 1.04 and now it is 1.08 with onl=
y about 10G more of metadata used.  I've tried doing balances up to 70 or 8=
0 musage I think, and the total metadata does not decrease.  I've done so m=
any attempts at balancing, I've probably tried to move 300 chunks or more. =
 None have resulted in any change to the metadata total like they do on oth=
er servers running btrfs.  I first started with very low musage, like 10 an=
d then increased it by 10 to try to see if that would balance any chunks ou=
t, but with no success.

# /sbin/btrfs balance start -musage=3D60 -mlimit=3D30 /opt/zimbra
Done, had to relocate 30 out of 2127 chunks

I can do that command over and over again, or increase the mlimit, and it d=
oesn't change the metadata total ever.


# btrfs fi show /opt/zimbra/
Label: 'Data'  uuid: ece150db-5817-4704-9e84-80f7d8a3b1da
        Total devices 4 FS bytes used 1.48TiB
        devid    1 size 1.46TiB used 1.38TiB path /dev/sde
        devid    2 size 1.46TiB used 1.38TiB path /dev/sdf
        devid    3 size 1.46TiB used 1.38TiB path /dev/sdg
        devid    4 size 1.46TiB used 1.38TiB path /dev/sdh

# btrfs fi df /opt/zimbra/
Data, RAID10: total=3D1.69TiB, used=3D1.45TiB
System, RAID10: total=3D64.00MiB, used=3D640.00KiB
Metadata, RAID10: total=3D1.08TiB, used=3D37.69GiB
GlobalReserve, single: total=3D512.00MiB, used=3D0.00B


# btrfs fi us /opt/zimbra/ -T
Overall:
    Device size:                   5.82TiB
    Device allocated:              5.54TiB
    Device unallocated:          291.54GiB
    Device missing:                  0.00B
    Used:                          2.96TiB
    Free (estimated):            396.36GiB      (min: 396.36GiB)
    Data ratio:                       2.00
    Metadata ratio:                   2.00
    Global reserve:              512.00MiB      (used: 0.00B)

            Data      Metadata  System
Id Path     RAID10    RAID10    RAID10    Unallocated
-- -------- --------- --------- --------- -----------
 1 /dev/sde 432.75GiB 276.00GiB  16.00MiB   781.65GiB
 2 /dev/sdf 432.75GiB 276.00GiB  16.00MiB   781.65GiB
 3 /dev/sdg 432.75GiB 276.00GiB  16.00MiB   781.65GiB
 4 /dev/sdh 432.75GiB 276.00GiB  16.00MiB   781.65GiB
-- -------- --------- --------- --------- -----------
   Total      1.69TiB   1.08TiB  64.00MiB     3.05TiB
   Used       1.45TiB  37.69GiB 640.00KiB






--=20
Brandon Heisner
System Administrator
Wolfram Research
