Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129A97B74DA
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Oct 2023 01:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbjJCX1S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Oct 2023 19:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjJCX1S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Oct 2023 19:27:18 -0400
X-Greylist: delayed 583 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 Oct 2023 16:27:14 PDT
Received: from mail.sweevo.net (unknown [185.193.158.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FBEAF
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Oct 2023 16:27:14 -0700 (PDT)
Received: from authenticated-user (mail.sweevo.net [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
        (No client certificate requested)
        by mail.sweevo.net (Postfix) with ESMTPSA id 2AA3F2B3E811
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Oct 2023 23:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sweevo.net; s=mail;
        t=1696375050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=3LSJuz91h3qA2saNzBTd9Vprs2/a+xgZX+FYqPn1dCQ=;
        b=b3N6TimP2dSDAeCVCJC9Equ0rA8+D9gMopF/vYPBdUjDRN3H+Efyo+oqjJxMHRzZSVRvFF
        64EdhAekqQhaS5NmKIgbaviy+9Gt4z1NrpQKPoRAd7Uann1QkWi5RNYLRVrr+beFcjdJor
        VdOoIXXJHqQutSHOXDctV7a3qvmo24M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=sweevo.net;
        s=mail; t=1696375050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=3LSJuz91h3qA2saNzBTd9Vprs2/a+xgZX+FYqPn1dCQ=;
        b=p+XAx8X25Ayn3x2b2iybXfu4CaifC1AG7Dtu/QV1vgT7mcQVG7qqx6aeXclAW4fEMJYKJ1
        LVoZWBpds0w2HYjD0lcGysRO3OcalBIQG/sH0gzbKnr7gQ8+qKYUcRaIliEkwlsZoZi2nv
        eQkleni83kDgMQ1aOIvA3zHoW+tqVIc=
ARC-Authentication-Results: i=1;
        mail.sweevo.net;
        auth=pass smtp.mailfrom=alexander.duscheleit@sweevo.net
ARC-Seal: i=1; s=mail; d=sweevo.net; t=1696375050; a=rsa-sha256; cv=none;
        b=LC31IG2JX1MB7vFFxFshI2WfnnA7DLJ6ptmypYB7nKvn3zXCJmi3bK9SO67xdA7tbD5I6N
        UPgG6UKNHyuruUAg3/iEG6wixvCvkHiafokRedDi/pEUuNkiYybFV54VfS//VW+QTFVJBV
        Uj9YQ6M5HRpyt5jCwGxeoSsV8PzemY8=
MIME-Version: 1.0
Date:   Tue, 03 Oct 2023 23:17:30 +0000
Content-Type: multipart/mixed;
 boundary="0db4ef7b-84d4-42d3-97d8-aef567c9cb2c-1"
From:   "Alexander Duscheleit" <alexander.duscheleit@sweevo.net>
Message-ID: <49144585162c9dc5a403c442154ecf54f5446aca@sweevo.net>
TLS-Required: No
Subject: Filesystem corruption after convert-to-block-group-tree
To:     linux-btrfs@vger.kernel.org
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--0db4ef7b-84d4-42d3-97d8-aef567c9cb2c-1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi all,
earlier today I tried to convert my BTRFS filesystem to block-group-tree =
and the operation seemed successful at first glance.
(I unmounted, converted and mounted the fs without any error.)
Some time later I tried to access a file and got an I/O error.

after some updates, reboots and troubleshooting I ended up in the followi=
ng situation:

The fs cannot be mounted normally, but it mounts (consistently) with
-o rescue=3Dall,ro (see attached dmesg.log).

No data _appears_ to be missing or corrupt.

btrfs-find-root throws many errors concerning corrupt leaf blocks but doe=
s find the curren tree root. (Again, see attached log.)

Is there any way to bring this fs back to a useable state without startin=
g over from scratch?


System Data:
# uname -a
Linux hera 6.5.5-arch1-1 #1 SMP PREEMPT_DYNAMIC Sat, 23 Sep 2023 22:55:13=
 +0000 x86_64 GNU/Linux

# btrfs --version=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20
btrfs-progs=20v6.5.1

(Note: The conversion to block group tree was done with btrfs-progs 6.3.3=
 and Kernel 6.4.12.arch1-1)

# btrfs fi show=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
Label:=20'hera-storage'  uuid: a71011f9-d79c-40e8-85fb-60b6f2af0637
	Total devices 4 FS bytes used 8.36TiB
	devid    1 size 4.55TiB used 4.19TiB path /dev/sdb1
	devid    2 size 4.55TiB used 4.19TiB path /dev/sdd1
	devid    3 size 4.55TiB used 4.19TiB path /dev/sdc1
	devid    4 size 4.55TiB used 4.19TiB path /dev/sde1

# btrfs fi df /mnt/btrfs_storage=20
Data,=20RAID10: total=3D8.34TiB, used=3D8.34TiB
System, RAID1C4: total=3D8.00MiB, used=3D912.00KiB
Metadata, RAID1C4: total=3D24.00GiB, used=3D23.93GiB
GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
--0db4ef7b-84d4-42d3-97d8-aef567c9cb2c-1
Content-Type: text/x-log; name="dmesg.log"
Content-Disposition: attachment; filename="dmesg.log"
Content-Transfer-Encoding: base64

ClsgICAgMy4zMDEwNTJdIEJ0cmZzIGxvYWRlZCwgem9uZWQ9eWVzLCBmc3Zlcml0eT15ZXMK
WyAgICAzLjMwMjMxNV0gQlRSRlM6IGRldmljZSBsYWJlbCBoZXJhLXN5c3RlbSBkZXZpZCAx
IHRyYW5zaWQgMjU4NTU5MCAvZGV2L3NkYTMgc2Nhbm5lZCBieSAodWRldi13b3JrZXIpICgx
NDMpClsgICAgMy4zMTMxMjJdIEJUUkZTOiBkZXZpY2UgbGFiZWwgaGVyYS1zdG9yYWdlIGRl
dmlkIDMgdHJhbnNpZCA0MTMwMiAvZGV2L3NkYzEgc2Nhbm5lZCBieSAodWRldi13b3JrZXIp
ICgxNDUpClsgICAgMy4zMzU2NzVdIEJUUkZTOiBkZXZpY2UgbGFiZWwgaGVyYS1zdG9yYWdl
IGRldmlkIDEgdHJhbnNpZCA0MTMwMiAvZGV2L3NkYjEgc2Nhbm5lZCBieSAodWRldi13b3Jr
ZXIpICgxNDIpClsgICAgMy4zODgyMjRdIEJUUkZTOiBkZXZpY2UgbGFiZWwgaGVyYS1zdG9y
YWdlIGRldmlkIDQgdHJhbnNpZCA0MTMwMiAvZGV2L3NkZTEgc2Nhbm5lZCBieSAodWRldi13
b3JrZXIpICgxMzEpClsgICAgMy4zOTQyNTldIEJUUkZTOiBkZXZpY2UgbGFiZWwgaGVyYS1z
dG9yYWdlIGRldmlkIDIgdHJhbnNpZCA0MTMwMiAvZGV2L3NkZDEgc2Nhbm5lZCBieSAodWRl
di13b3JrZXIpICgxNDUpCgpbICAgIDMuNTM2NjU4XSBCVFJGUyBpbmZvIChkZXZpY2Ugc2Rh
Myk6IHVzaW5nIGNyYzMyYyAoY3JjMzJjLWludGVsKSBjaGVja3N1bSBhbGdvcml0aG0KWyAg
ICAzLjUzNjY3MF0gQlRSRlMgaW5mbyAoZGV2aWNlIHNkYTMpOiB1c2luZyBmcmVlIHNwYWNl
IHRyZWUKWyAgICAzLjU1NDg2NV0gQlRSRlMgaW5mbyAoZGV2aWNlIHNkYTMpOiBlbmFibGlu
ZyBzc2Qgb3B0aW1pemF0aW9ucwpbICAgIDMuNTU0ODY4XSBCVFJGUyBpbmZvIChkZXZpY2Ug
c2RhMyk6IGF1dG8gZW5hYmxpbmcgYXN5bmMgZGlzY2FyZAoKWyAgICA0LjIxNjMwMl0gQlRS
RlMgaW5mbyAoZGV2aWNlIHNkYTM6IHN0YXRlIE0pOiBmb3JjZSB6c3RkIGNvbXByZXNzaW9u
LCBsZXZlbCAzCgpbICA2NzguOTA5NjAyXSBCVFJGUyBpbmZvIChkZXZpY2Ugc2RiMSk6IHVz
aW5nIHh4aGFzaDY0ICh4eGhhc2g2NC1nZW5lcmljKSBjaGVja3N1bSBhbGdvcml0aG0KWyAg
Njc4LjkwOTYxMV0gQlRSRlMgaW5mbyAoZGV2aWNlIHNkYjEpOiBmb3JjZSB6c3RkIGNvbXBy
ZXNzaW9uLCBsZXZlbCAzClsgIDY3OC45MDk2MTRdIEJUUkZTIGluZm8gKGRldmljZSBzZGIx
KTogdXNpbmcgZnJlZSBzcGFjZSB0cmVlClsgIDY3OS43MzQ2NThdIEJUUkZTIGVycm9yIChk
ZXZpY2Ugc2RiMSk6IGxldmVsIHZlcmlmeSBmYWlsZWQgb24gbG9naWNhbCA3ODY4NDExMzE0
MTc2IG1pcnJvciAyIHdhbnRlZCAwIGZvdW5kIDEKWyAgNjc5Ljc1NDU2OV0gQlRSRlMgZXJy
b3IgKGRldmljZSBzZGIxKTogbGV2ZWwgdmVyaWZ5IGZhaWxlZCBvbiBsb2dpY2FsIDc4Njg0
MTEzMTQxNzYgbWlycm9yIDEgd2FudGVkIDAgZm91bmQgMQpbICA2NzkuNzcwNzY2XSBCVFJG
UyBlcnJvciAoZGV2aWNlIHNkYjEpOiBsZXZlbCB2ZXJpZnkgZmFpbGVkIG9uIGxvZ2ljYWwg
Nzg2ODQxMTMxNDE3NiBtaXJyb3IgMyB3YW50ZWQgMCBmb3VuZCAxClsgIDY3OS44NDM5NjZd
IEJUUkZTIGVycm9yIChkZXZpY2Ugc2RiMSk6IGxldmVsIHZlcmlmeSBmYWlsZWQgb24gbG9n
aWNhbCA3ODY4NDExMzE0MTc2IG1pcnJvciA0IHdhbnRlZCAwIGZvdW5kIDEKWyAgNjc5Ljg0
NDAyMl0gQlRSRlMgZXJyb3IgKGRldmljZSBzZGIxKTogZmFpbGVkIHRvIHJlYWQgYmxvY2sg
Z3JvdXBzOiAtNQpbICA2NzkuODQ3NjY3XSBCVFJGUyBlcnJvciAoZGV2aWNlIHNkYjEpOiBv
cGVuX2N0cmVlIGZhaWxlZApbICA2OTYuMDI3Mzg5XSBCVFJGUyBpbmZvIChkZXZpY2Ugc2Ri
MSk6IHVzaW5nIHh4aGFzaDY0ICh4eGhhc2g2NC1nZW5lcmljKSBjaGVja3N1bSBhbGdvcml0
aG0KWyAgNjk2LjAyNzM5OV0gQlRSRlMgaW5mbyAoZGV2aWNlIHNkYjEpOiBmb3JjZSB6c3Rk
IGNvbXByZXNzaW9uLCBsZXZlbCAzClsgIDY5Ni4wMjc0MDVdIEJUUkZTIGluZm8gKGRldmlj
ZSBzZGIxKTogZW5hYmxpbmcgYWxsIG9mIHRoZSByZXNjdWUgb3B0aW9ucwpbICA2OTYuMDI3
NDA2XSBCVFJGUyBpbmZvIChkZXZpY2Ugc2RiMSk6IGlnbm9yaW5nIGRhdGEgY3N1bXMKWyAg
Njk2LjAyNzQwN10gQlRSRlMgaW5mbyAoZGV2aWNlIHNkYjEpOiBpZ25vcmluZyBiYWQgcm9v
dHMKWyAgNjk2LjAyNzQwOV0gQlRSRlMgaW5mbyAoZGV2aWNlIHNkYjEpOiBkaXNhYmxpbmcg
bG9nIHJlcGxheSBhdCBtb3VudCB0aW1lClsgIDY5Ni4wMjc0MTBdIEJUUkZTIGluZm8gKGRl
dmljZSBzZGIxKTogdXNpbmcgZnJlZSBzcGFjZSB0cmVlClsgIDY5Ni4zNDUwMDhdIEJUUkZT
IGVycm9yIChkZXZpY2Ugc2RiMTogc3RhdGUgQyk6IGxldmVsIHZlcmlmeSBmYWlsZWQgb24g
bG9naWNhbCA3ODY4NDExMzE0MTc2IG1pcnJvciAzIHdhbnRlZCAwIGZvdW5kIDEKWyAgNjk2
LjM0NTczMV0gQlRSRlMgZXJyb3IgKGRldmljZSBzZGIxOiBzdGF0ZSBDKTogbGV2ZWwgdmVy
aWZ5IGZhaWxlZCBvbiBsb2dpY2FsIDc4Njg0MTEzMTQxNzYgbWlycm9yIDEgd2FudGVkIDAg
Zm91bmQgMQpbICA2OTYuMzQ1OTY0XSBCVFJGUyBlcnJvciAoZGV2aWNlIHNkYjE6IHN0YXRl
IEMpOiBsZXZlbCB2ZXJpZnkgZmFpbGVkIG9uIGxvZ2ljYWwgNzg2ODQxMTMxNDE3NiBtaXJy
b3IgMiB3YW50ZWQgMCBmb3VuZCAxClsgIDY5Ni4zNDY2MTZdIEJUUkZTIGVycm9yIChkZXZp
Y2Ugc2RiMTogc3RhdGUgQyk6IGxldmVsIHZlcmlmeSBmYWlsZWQgb24gbG9naWNhbCA3ODY4
NDExMzE0MTc2IG1pcnJvciA0IHdhbnRlZCAwIGZvdW5kIDEK
--0db4ef7b-84d4-42d3-97d8-aef567c9cb2c-1
Content-Type: text/plain; name="find-root.log"
Content-Disposition: attachment; filename="find-root.log"
Content-Transfer-Encoding: base64

cGFyZW50IHRyYW5zaWQgdmVyaWZ5IGZhaWxlZCBvbiA3ODY4NDExMzE0MTc2IHdhbnRlZCA0
MTI5MyBmb3VuZCA0MTM3MApwYXJlbnQgdHJhbnNpZCB2ZXJpZnkgZmFpbGVkIG9uIDc4Njg0
MTEzMTQxNzYgd2FudGVkIDQxMjkzIGZvdW5kIDQxMzcwCnBhcmVudCB0cmFuc2lkIHZlcmlm
eSBmYWlsZWQgb24gNzg2ODQxMTMxNDE3NiB3YW50ZWQgNDEyOTMgZm91bmQgNDEzNzAKcGFy
ZW50IHRyYW5zaWQgdmVyaWZ5IGZhaWxlZCBvbiA3ODY4NDExMzE0MTc2IHdhbnRlZCA0MTI5
MyBmb3VuZCA0MTM3MApFUlJPUjogZmFpbGVkIHRvIHJlYWQgYmxvY2sgZ3JvdXBzOiBJbnB1
dC9vdXRwdXQgZXJyb3IKY29ycnVwdCBsZWFmOiBibG9jaz0yMzA5MTE2ODg3MDQgc2xvdD05
IGV4dGVudCBieXRlbnI9NTgxNjgzMzU3Mjg2NCBsZW49MTYzODQgaW52YWxpZCBnZW5lcmF0
aW9uLCBoYXZlIDQxMzQxIGV4cGVjdCAoMCwgNDEzMDNdCmNvcnJ1cHQgbGVhZjogYmxvY2s9
MjMwOTExNjg4NzA0IHNsb3Q9OSBleHRlbnQgYnl0ZW5yPTU4MTY4MzM1NzI4NjQgbGVuPTE2
Mzg0IGludmFsaWQgZ2VuZXJhdGlvbiwgaGF2ZSA0MTM0MSBleHBlY3QgKDAsIDQxMzAzXQoK
WyAuLi5tYW55IG1vcmUgb2YgdGhlc2UgXQoKY29ycnVwdCBsZWFmOiBibG9jaz03ODY4NTY3
NzY0OTkyIHNsb3Q9MSBleHRlbnQgYnl0ZW5yPTkzOTYzNjI1MTAzMzYgbGVuPTE2Mzg0IGlu
dmFsaWQgZ2VuZXJhdGlvbiwgaGF2ZSA0MTM1NSBleHBlY3QgKDAsIDQxMzAzXQpjb3JydXB0
IGxlYWY6IHJvb3Q9MSBibG9jaz03ODY4NTY4NDAzOTY4IHNsb3Q9MCwgaW52YWxpZCByb290
IGdlbmVyYXRpb24sIGhhdmUgNDEzNjggZXhwZWN0ICgwLCA0MTMwM10KY29ycnVwdCBsZWFm
OiByb290PTEgYmxvY2s9Nzg2ODU2ODQwMzk2OCBzbG90PTAsIGludmFsaWQgcm9vdCBnZW5l
cmF0aW9uLCBoYXZlIDQxMzY4IGV4cGVjdCAoMCwgNDEzMDNdCmNvcnJ1cHQgbGVhZjogcm9v
dD0xIGJsb2NrPTc4Njg1Njg0MDM5Njggc2xvdD0wLCBpbnZhbGlkIHJvb3QgZ2VuZXJhdGlv
biwgaGF2ZSA0MTM2OCBleHBlY3QgKDAsIDQxMzAzXQpjb3JydXB0IGxlYWY6IHJvb3Q9MSBi
bG9jaz03ODY4NTY4NDAzOTY4IHNsb3Q9MCwgaW52YWxpZCByb290IGdlbmVyYXRpb24sIGhh
dmUgNDEzNjggZXhwZWN0ICgwLCA0MTMwM10KY29ycnVwdCBsZWFmOiBibG9jaz03ODY4NTY4
NDY5NTA0IHNsb3Q9NjUgZXh0ZW50IGJ5dGVucj0zMDUwNzAwOCBsZW49MTYzODQgaW52YWxp
ZCBnZW5lcmF0aW9uLCBoYXZlIDQxMzA4IGV4cGVjdCAoMCwgNDEzMDNdCgpbIC4uLm1vcmUg
b2YgdGhlc2UgXQoKY29ycnVwdCBsZWFmOiBibG9jaz03ODY4NTcwNDUxOTY4IHNsb3Q9MTEg
ZXh0ZW50IGJ5dGVucj03ODY4NDI0NjgzNTIwIGxlbj0xNjM4NCBpbnZhbGlkIGdlbmVyYXRp
b24sIGhhdmUgNDEzMzYgZXhwZWN0ICgwLCA0MTMwM10KY29ycnVwdCBsZWFmOiByb290PTEg
YmxvY2s9Nzg2ODU3MDQ2ODM1MiBzbG90PTAsIGludmFsaWQgcm9vdCBnZW5lcmF0aW9uLCBo
YXZlIDQxMzY5IGV4cGVjdCAoMCwgNDEzMDNdCmNvcnJ1cHQgbGVhZjogcm9vdD0xIGJsb2Nr
PTc4Njg1NzA0NjgzNTIgc2xvdD0wLCBpbnZhbGlkIHJvb3QgZ2VuZXJhdGlvbiwgaGF2ZSA0
MTM2OSBleHBlY3QgKDAsIDQxMzAzXQpjb3JydXB0IGxlYWY6IHJvb3Q9MSBibG9jaz03ODY4
NTcwNDY4MzUyIHNsb3Q9MCwgaW52YWxpZCByb290IGdlbmVyYXRpb24sIGhhdmUgNDEzNjkg
ZXhwZWN0ICgwLCA0MTMwM10KY29ycnVwdCBsZWFmOiByb290PTEgYmxvY2s9Nzg2ODU3MDQ2
ODM1MiBzbG90PTAsIGludmFsaWQgcm9vdCBnZW5lcmF0aW9uLCBoYXZlIDQxMzY5IGV4cGVj
dCAoMCwgNDEzMDNdCmNvcnJ1cHQgbGVhZjogYmxvY2s9Nzg2ODU3MDQ4NDczNiBzbG90PTY1
IGV4dGVudCBieXRlbnI9MzA1MDcwMDggbGVuPTE2Mzg0IGludmFsaWQgZ2VuZXJhdGlvbiwg
aGF2ZSA0MTMwOCBleHBlY3QgKDAsIDQxMzAzXQpjb3JydXB0IGxlYWY6IGJsb2NrPTc4Njg1
NzA0ODQ3MzYgc2xvdD02NSBleHRlbnQgYnl0ZW5yPTMwNTA3MDA4IGxlbj0xNjM4NCBpbnZh
bGlkIGdlbmVyYXRpb24sIGhhdmUgNDEzMDggZXhwZWN0ICgwLCA0MTMwM10KY29ycnVwdCBs
ZWFmOiBibG9jaz03ODY4NTcwNDg0NzM2IHNsb3Q9NjUgZXh0ZW50IGJ5dGVucj0zMDUwNzAw
OCBsZW49MTYzODQgaW52YWxpZCBnZW5lcmF0aW9uLCBoYXZlIDQxMzA4IGV4cGVjdCAoMCwg
NDEzMDNdCmNvcnJ1cHQgbGVhZjogYmxvY2s9Nzg2ODU3MDQ4NDczNiBzbG90PTY1IGV4dGVu
dCBieXRlbnI9MzA1MDcwMDggbGVuPTE2Mzg0IGludmFsaWQgZ2VuZXJhdGlvbiwgaGF2ZSA0
MTMwOCBleHBlY3QgKDAsIDQxMzAzXQpTdXBlcmJsb2NrIHRoaW5rcyB0aGUgZ2VuZXJhdGlv
biBpcyA0MTMwMgpTdXBlcmJsb2NrIHRoaW5rcyB0aGUgbGV2ZWwgaXMgMApGb3VuZCB0cmVl
IHJvb3QgYXQgNzg2ODk4NjY1NDcyMCBnZW4gNDEzMDIgbGV2ZWwgMApXZWxsIGJsb2NrIDc4
Njg4ODExNDE3NjAoZ2VuOiA0MTI5NSBsZXZlbDogMCkgc2VlbXMgZ29vZCwgYnV0IGdlbmVy
YXRpb24vbGV2ZWwgZG9lc24ndCBtYXRjaCwgd2FudCBnZW46IDQxMzAyIGxldmVsOiAwCgpb
IC4uLm1vcmUgXQoKV2VsbCBibG9jayAyMzA5OTg2ODc3NDQoZ2VuOiA0MTIzNSBsZXZlbDog
MCkgc2VlbXMgZ29vZCwgYnV0IGdlbmVyYXRpb24vbGV2ZWwgZG9lc24ndCBtYXRjaCwgd2Fu
dCBnZW46IDQxMzAyIGxldmVsOiAwCldlbGwgYmxvY2sgNDg2ODAxNDA4KGdlbjogNDEyMzMg
bGV2ZWw6IDApIHNlZW1zIGdvb2QsIGJ1dCBnZW5lcmF0aW9uL2xldmVsIGRvZXNuJ3QgbWF0
Y2gsIHdhbnQgZ2VuOiA0MTMwMiBsZXZlbDogMApXZWxsIGJsb2NrIDQwMzM0MTMxMihnZW46
IDQxMjMyIGxldmVsOiAwKSBzZWVtcyBnb29kLCBidXQgZ2VuZXJhdGlvbi9sZXZlbCBkb2Vz
bid0IG1hdGNoLCB3YW50IGdlbjogNDEzMDIgbGV2ZWw6IDAKV2VsbCBibG9jayAzNzc2MDM1
NzE3MTIwKGdlbjogNDA3OTEgbGV2ZWw6IDApIHNlZW1zIGdvb2QsIGJ1dCBnZW5lcmF0aW9u
L2xldmVsIGRvZXNuJ3QgbWF0Y2gsIHdhbnQgZ2VuOiA0MTMwMiBsZXZlbDogMAo=
--0db4ef7b-84d4-42d3-97d8-aef567c9cb2c-1--
