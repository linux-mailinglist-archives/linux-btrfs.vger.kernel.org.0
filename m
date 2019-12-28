Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68F5F12BD70
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Dec 2019 12:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfL1L0k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 28 Dec 2019 06:26:40 -0500
Received: from mars1.mruiz.dev ([167.71.125.59]:53098 "EHLO mars1.mruiz.dev"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfL1L0k (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 28 Dec 2019 06:26:40 -0500
Received: from archlinux.localnet (unknown [66.115.176.23])
        by mars1.mruiz.dev (Postfix) with ESMTPSA id 0B97040728;
        Sat, 28 Dec 2019 11:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mruiz.dev; s=201908;
        t=1577532399; bh=tv1AQDWozwxhVuD4oIq3VPMXiVy5++5tnWcWBgoJMUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UifjZWT9jxVWZKtomHN92EsDTvpN3nUXpHB6ZlRzYrir7Rga1pMiUGwbc/ceU7Rgg
         ZH4eCloygovyMt8Zt8dkOLJm+PPiu+s04fyfE932Kqw8dJaamgECOE1B3U7DtOMS3P
         EewOpw+mz/bJHelvkCt3GFcf2d4n0L3YXbXuSQvUcvAFpKfrlRROAD+5b/jdK0NaWV
         SEBbbn/J91ShjsrfImur+OKQ1PFJlKfZII2GvgVkIO+Zgnm+gQLxAdxbYmoH8pxhDt
         hZIzUoYgGlyqxG6PSBMWGY5FPs/sN7wpCrW+n2KEv74MVS2q3sbSNVl8OKWS5dKZcC
         pEtraf2TRm8SQ==
From:   Michael Ruiz <michael@mruiz.dev>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Error during balancing '/': Input/output error
Date:   Sat, 28 Dec 2019 03:26:36 -0800
Message-ID: <9620299.nUPlyArG6x@archlinux>
Organization: mruiz.dev
In-Reply-To: <f8696732-09f3-315f-3f66-6a318782bbbe@gmx.com>
References: <4196932.LvFx2qVVIh@archlinux> <5555870.lOV4Wx5bFT@archlinux> <f8696732-09f3-315f-3f66-6a318782bbbe@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2082377.iZASKD2KPV"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--nextPart2082377.iZASKD2KPV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Qu,
Thanks for the quick reply. This is what I could find. 

[michael@linux /]$ sudo btrfs ins dump-tree -t data_reloc /dev/dm-1
btrfs-progs v5.4 
data reloc tree key (DATA_RELOC_TREE ROOT_ITEM 2) 
leaf 286941609984 items 2 free space 16061 generation 1186381 owner 
DATA_RELOC_TREE
leaf 286941609984 flags 0x1(WRITTEN) backref revision 1
fs uuid <redacted>
chunk uuid <redacted>
        item 0 key (256 INODE_ITEM 0) itemoff 16123 itemsize 160
                generation 2 transid 0 size 0 nbytes 16384
                block group 0 mode 40755 links 1 uid 0 gid 0 rdev 0
                sequence 0 flags 0x0(none)
                atime 1577186710.0 (2019-12-24 03:25:10)
                ctime 1577186710.0 (2019-12-24 03:25:10)
                mtime 1577186710.0 (2019-12-24 03:25:10)
                otime 1577186710.0 (2019-12-24 03:25:10)
        item 1 key (256 INODE_REF 256) itemoff 16111 itemsize 12
                index 0 namelen 2 name: ..
total bytes 255307284480
bytes used 94295339008
uuid <redacted>

[michael@archlinux /]$ sudo btrfs ins logical-resolve 253563502592 /
//home/michael/.mozilla/firefox/default/storage/default/https++
+www.pinterest.com/cache/morgue/16/{b696bf53-d26a-48eb-9688-
ab3c5fd49010}.final



``` BTRFS SCRUB ```
sudo btrfs scrub status /
UUID:             <redacted>
Scrub started:    Sat Dec 28 03:17:49 2019
Status:           finished
Duration:         0:05:09
Total to scrub:   87.82GiB
Rate:             291.04MiB/s
Error summary:    csum=16
  Corrected:      0
  Uncorrectable:  16
  Unverified:     0
```

--nextPart2082377.iZASKD2KPV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5lRECE0UfhBqjDUbhv/EZtxrWIFAl4HO+MACgkQbhv/EZtx
rWKMUAf/eYpwq6/xUxodB/CBX9wQJcJxcxeseDoh8H0Oh8hxMLVKzfy1Qu7pBX8j
FXHcEhszo8DtQTi0FD3xKJaF+dma8PHRtEEspfwiwNXBGCEvbbYuz2UVCwsDdNG1
IQGa0fjkF65Zy7jD8Ljq/ESyFafM7v1GzNc0sxUXR0X6JYyXWJwD6mK6CYVlIEZ9
ulFyESiDWutxk0cJGYJmp/hXHEQAOLMJxwic0IQcCjbGm8B6AqEmeZRtDl8Dcdf7
68pzZHdDAArVc2/h0BPP1keC+7po8zoXjuZzUeupLEB1Lgas4PoPxsBFMuvO1HvW
iX1OolLe2n78ioXkvUxXJsh/M1e22Q==
=QzMM
-----END PGP SIGNATURE-----

--nextPart2082377.iZASKD2KPV--



