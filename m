Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D9F1DB8BD
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 May 2020 17:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgETPyc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 May 2020 11:54:32 -0400
Received: from mout.gmx.net ([212.227.17.20]:59711 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbgETPyc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 May 2020 11:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589990070;
        bh=j3rEwSq16wHeElxBGAqwEc+VfNduOpoLAAtcKENbHMM=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=gNzhp3/L6chSuAaPZChieBbLkdJA4QT4bs+nLzZDYjSscvq1E80B98saAJVF31D0l
         nl8d8cLP0fJ2T2jihP1cassWGDz6kPQHc+T5fBhTjkFIj5LHvY9z2zeQTYlaYh7aZ4
         k9qDDciRBDwy9GHeqO0G2QMnyqDuGORzaC3rpQmI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from mail.gomer.local ([77.182.86.119]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2V0B-1iuvZS3Y6B-013vBG for
 <linux-btrfs@vger.kernel.org>; Wed, 20 May 2020 17:54:29 +0200
Received: by mail.gomer.local (Postfix, from userid 1000)
        id D40844537272; Wed, 20 May 2020 17:54:28 +0200 (CEST)
Date:   Wed, 20 May 2020 17:54:28 +0200
From:   joerg.ebertz@gmx.net
To:     linux-btrfs@vger.kernel.org
Subject: Tree-Checker-Error on vServer-Directory
Message-ID: <20200520155428.GA1810@ehud.gomer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:do1ncINARPaR55cZeGMdFc1C3/FMIGfUccIIIkBzBwE/Wm+EvEH
 M9xXCS5gjilma/2XKl/2Z+LwuZf57Y09A8roGVeU0cuGknqhaguG9jp/ACsMl5mYDbuFDWG
 jQOY0Kuv2BEWAMfspuSyqxGzsI2fSvjRWXJgt0Y8P3xFDaZDQ3tQF9odZg2wGNTBAE5cMUV
 kdEru7kHIr3ULj7YqYt3w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/ZS6CaXlNzY=:t135KB+bVdRCfcSWEj80yP
 swrIUfWUGbZ603y7n1iFPyV8nDULe+8dipi6XETFvf/uv//aJP81YTpXLnw1bdlTD5/j32Gpc
 YNqUQsJPrqV3iIdByDf84IEFN1to/xh3+rY1EvLEfkmpop3lKcDgZee1XsmL770VhdTSi/yU7
 S/b+E7ZPedfAchoj1NI/ektwusP5HpztRS/l763gkZdTPHV+RaY12Ad5+eDLJex0x3PI+NGSt
 JnlsF9W/xvBGVgwn4+mcdZoou3ezmFJx9pYckyRbdKSlRD7KbghE1t+G+EvKNvlgBAQuaEhB8
 3sW0e9YNK988zbXWnpvqxOKnA3OrCXCC8ljel4UW/613g0zze2pF0KUB9jHOWNzBAdqhY4hJV
 9HDKfHQSxvX8Db9iiEMMzUPvRt37lEy7P+GO1/Z39K4wyI5uv5/9V2RlBRLQlD2PXK+CtKMOu
 hOKzMDgukhIFYDvlhS9tRofiBBfXBP5GiUGe7nMDMKhoWrt6U/jjN1PI4QEfqvY2f6GQYx2/G
 nlvObQgfQbcpVorVvZlJihdSNkMTwOm9ig9CYfYDukjynr5uMZ/Kn4FIuYyp6wRVFKSXyRgGH
 IKro5fbI1IffBO0enb7OGPGNuWbgW/wVboqYR+QldzSy471ZQFK4xe2kalc+SYDpQjc95niSA
 rCbxAL92WKcNIptXN7BuicI1gJ1fBwMp2UeUMsNidFknoo6LoHnHtiWx74JSLx7jInnNLmqXn
 T4TSpPZEnZq8C+sT9aD1JtxKeVc6AosYdvyp93ASPD1MFOBAsUDzbwWRDxEQmk8hv8D339tEl
 cFSNFjKYZ1J6GFIW155LCLfsCj44zQL6AwL61etb2mzB/jb5HKi2pn947KVibR7vMKzFdhFnd
 J8VTJ05rkGURQglT8CvQojwvFXbV6qMVtuf4xqZ6VdSeoJ74s7i9jvytKr+kx/Db5h9Iln7bx
 RVOYMAVdvM8C4DOgV4rVCrBc81Ob9X+3sVGM/m3pLwTHqzCapDAvQ0k0H7tjyNXm81p5p8qQa
 LhW+Fmb/cFUPIhldB+IOy72PiObE1Hcxq9Fhr+d6tc5S7VwCCGjg1eEDOXWupYcimgYjC5n2A
 k89izDaJUMXTggviZaC75FZWsdilDDz5FHPa7nUSAU/jKCZ/zdiE0Dhcd352hkxl6T0hmmQr5
 xa1h8mOE++njIx+q/Kdz08hUJedSQnY4ou+JIzVS3aeGiv8ppXlY7Gwx8fW1V0i3xiYeamnf9
 yJoWTDvyEEpHdDowB
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hallo,

https://btrfs.wiki.kernel.org/index.php/Tree-checker suggested that I
ask here for help.

When I run a Linux-Kernel 5.7.0-rc2, compiled with pretty much
default configuration, and try to run

  ls /vservers

I get the error message:

  ls: cannot access '/vservers': Input/output error

=46rom dmesg I get:

  [912737.466820] BTRFS critical (device dm-2): corrupt leaf: root=3D5 blo=
ck=3D350945280 slot=3D85 ino=3D55495, unknown flags detected: 0x2000000
  [912737.466825] BTRFS error (device dm-2): block=3D350945280 read time t=
ree block corruption detected
  [912737.467190] BTRFS critical (device dm-2): corrupt leaf: root=3D5 blo=
ck=3D350945280 slot=3D85 ino=3D55495, unknown flags detected: 0x2000000
  [912737.467194] BTRFS error (device dm-2): block=3D350945280 read time t=
ree block corruption detected

With kernel 5.6.9 I get:

  [  520.285953] BTRFS critical (device dm-2): corrupt leaf: root=3D5 bloc=
k=3D350945280 slot=3D85 ino=3D55495, unknown flags detected: 0x2000000
  [  520.285958] BTRFS error (device dm-2): block=3D350945280 read time tr=
ee block corruption detected
  [  520.286234] BTRFS critical (device dm-2): corrupt leaf: root=3D5 bloc=
k=3D350945280 slot=3D85 ino=3D55495, unknown flags detected: 0x2000000
  [  520.286238] BTRFS error (device dm-2): block=3D350945280 read time tr=
ee block corruption detected
  [  520.771733] BTRFS critical (device dm-2): corrupt leaf: root=3D5 bloc=
k=3D350945280 slot=3D85 ino=3D55495, unknown flags detected: 0x2000000
  [  520.771746] BTRFS error (device dm-2): block=3D350945280 read time tr=
ee block corruption detected
  [  520.772075] BTRFS critical (device dm-2): corrupt leaf: root=3D5 bloc=
k=3D350945280 slot=3D85 ino=3D55495, unknown flags detected: 0x2000000
  [  520.772079] BTRFS error (device dm-2): block=3D350945280 read time tr=
ee block corruption detected
  [  520.778309] BTRFS critical (device dm-2): corrupt leaf: root=3D5 bloc=
k=3D350945280 slot=3D85 ino=3D55495, unknown flags detected: 0x2000000
  [  520.778314] BTRFS error (device dm-2): block=3D350945280 read time tr=
ee block corruption detected
  [  520.778656] BTRFS critical (device dm-2): corrupt leaf: root=3D5 bloc=
k=3D350945280 slot=3D85 ino=3D55495, unknown flags detected: 0x2000000
  [  520.778661] BTRFS error (device dm-2): block=3D350945280 read time tr=
ee block corruption detected
  [  520.783287] BTRFS critical (device dm-2): corrupt leaf: root=3D5 bloc=
k=3D350945280 slot=3D85 ino=3D55495, unknown flags detected: 0x2000000
  [  520.783292] BTRFS error (device dm-2): block=3D350945280 read time tr=
ee block corruption detected
  [  520.783655] BTRFS critical (device dm-2): corrupt leaf: root=3D5 bloc=
k=3D350945280 slot=3D85 ino=3D55495, unknown flags detected: 0x2000000
  [  520.783659] BTRFS error (device dm-2): block=3D350945280 read time tr=
ee block corruption detected
  [  520.788400] BTRFS critical (device dm-2): corrupt leaf: root=3D5 bloc=
k=3D350945280 slot=3D85 ino=3D55495, unknown flags detected: 0x2000000
  [  520.788404] BTRFS error (device dm-2): block=3D350945280 read time tr=
ee block corruption detected
  [  520.788745] BTRFS critical (device dm-2): corrupt leaf: root=3D5 bloc=
k=3D350945280 slot=3D85 ino=3D55495, unknown flags detected: 0x2000000
  [  520.788749] BTRFS error (device dm-2): block=3D350945280 read time tr=
ee block corruption detected
  [  520.791619] BTRFS critical (device dm-2): corrupt leaf: root=3D5 bloc=
k=3D350945280 slot=3D85 ino=3D55495, unknown flags detected: 0x2000000
  [  520.791624] BTRFS error (device dm-2): block=3D350945280 read time tr=
ee block corruption detected

With the default kernel of Debian =E2=80=9CStable=E2=80=9D =3D =E2=80=9C10=
=E2=80=9D =3D =E2=80=9CBuster=E2=80=9D, which is
presently 4.19.0-9 this works flawlessly.  When I booted my computer
with grml 2018.12 ( https://grml.org/ ) with a 4.19.8 kernel, I didn_t
have any problems either, =E2=80=9Cbtrfs check=E2=80=9D and =E2=80=9Cbtrfs=
 scrub=E2=80=9D didn't find
any errors.

Has there been a change to tree-checker, that has a problem with
something vServer ( http://linux-vserver.org ) does?  I don't use
vServer any more, since Debian stopped supporting it, I only keep those
files for reference.

I don't think that matters, but I have three SSDs in a RAID0 Array,
on top of which there is a LUKS container which contains a LVM2
which in turn has the BTRFS file system in one of it's LVs.

Is there any other information You need?

Greeting,
Joerg
