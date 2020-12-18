Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C2C2DDF0E
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Dec 2020 08:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732963AbgLRH1L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Dec 2020 02:27:11 -0500
Received: from mout.gmx.net ([212.227.15.15]:50541 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732954AbgLRH1K (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Dec 2020 02:27:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608276337;
        bh=bsSscjtn/RSQzrg1V+Fe63oonTYbU8QRnTaYIKhXOdc=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:In-Reply-To:References:Date;
        b=eUv97m0ol3r/UMgg4gKcVXYlPMoa4+O4UQp21SmGgJfP78cWxb1XavQTTTWfp2pip
         KSh0nARQd2YoUS6zHWfpZ58XYoCD91BoqiQpsIvv6AEJOzQTgbxf/pEx94gnGAaFmM
         HUNcPjwlw3lJwbJBzXR9SBg93mLgdQ+68tcy3chQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from mobalindesk.lan.lan ([77.3.51.210]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJmGZ-1kWYnI1fRZ-00KCp8; Fri, 18
 Dec 2020 08:25:37 +0100
Message-ID: <cd8e521bcf1e8d999d39ddae61b61fc45492e2c8.camel@gmx.net>
Subject: Re: btrfs send -p failing: chown o257-1571-0 failed: No such file
 or directory
From:   "Massimo B." <massimo.b@gmx.net>
To:     fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
In-Reply-To: <CAL3q7H7LCaRE_28RRY0zfHiJo5G1EkDHKCuue3-052AeuXmG4w@mail.gmail.com>
References: <6ae34776e85912960a253a8327068a892998e685.camel@gmx.net>
         <CAL3q7H72N5q6ROhfvuaNNfUvQTe-mtHJVvZaS25oTycJ=3Um3w@mail.gmail.com>
         <d4891e0c7aa79895d8f85601954c7eb379b733fc.camel@gmx.net>
         <CAL3q7H5AOeFit_kz4X9Q2hXqeHXxamQ+pm04yA5BqkYr3-5e+g@mail.gmail.com>
         <40b352dfa84e0f22d76e9b4f47111117549fa3bb.camel@gmx.net>
         <CAL3q7H7oLWGWJcg0Gfa+RKRGNf+d4mv0R9FQi2j=xLL1RNPTGA@mail.gmail.com>
         <1f78cd5d635b360e03468740608f3b02aea76b5d.camel@gmx.net>
         <CAL3q7H4r-EtnMc=VD2EP01HsLCqg-z8LfMnFseHrNEv=rjPT_g@mail.gmail.com>
         <c0aa48c7db8c00efe8dd9a2c72c425ffe57df49c.camel@gmx.net>
         <CAL3q7H7LCaRE_28RRY0zfHiJo5G1EkDHKCuue3-052AeuXmG4w@mail.gmail.com>
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwAQMAAABtzGvEAAAAA3NCSVQICAjb4U/gAAAABlBMVEX///8AAABVwtN+AAAACXBIWXMAAA7EAAAOxAGVKw4bAAABGUlEQVQYlUWQsUoDQRCGv71LjB7KSSBwwZCTgFhY2EYIHmJnZRMLo5AXUMRCBMHcE6iPoGBlINpoZXGVeQTFKqSxMgYtTBFcZw7EKfZn2Z2Z7//hr2ysZ+5tqFLmWKVaKKs0vWd9TJx2AibmoQcupj6CCZirqTgzA5hmsdtQWe5/xAREX7uJ3MLP9x4lyieNO5mcOxyM8HH79y/4Cdn9R3JDsts/uGO82yOMJf/ah1Y8tfQEIQt7Z7rCawtNiUpHFgYUdgTxgI1NAW6SvxoqWabbw0Bd5jpQibTNBC1F4nIMk2TWhTqIs+fSVpzfCsVR9eaiJf5W6mtWXK7O+vKR4nWkSYSuFbP4No3Ht6dpSN9pSMYmaXI1/usXT0FM3SoTKAAAAAAASUVORK5CYII=
Content-Type: text/plain; charset="UTF-8"
Date:   Fri, 18 Dec 2020 08:20:36 +0100
MIME-Version: 1.0
User-Agent: Evolution 3.36.5 
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IqJBbzMt37doJPxmfskEXvw86ZPOzqH9bt/eR/iVs8zFFlXNg2W
 LvPR9PTYkVRKPhlnnqXtS/Uis7/3zLnp6vi6Osv+h46EMl0yrSycbIs6/mh9ewHlGV8e9C2
 5ILeGvZ0VMs/3EDtTRIIHi/zTuiuPCM6sQP9Pu+RbsaUCLN4PvtDzt2TUbiaJf7Muw1cfm8
 3TPpYVdICbUSPSBa95zdA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Sr5Jw/n46G4=:GAmlgSKkKKEvKLV+Nv6DZ8
 95BiLmo8PvLHATV63LGeDOX24tWvcR3ZQIkTAxRk9cfEZWSAUlCZQF6Q4RYUW9e/w7YB4al0g
 bAWdVS8691bhhx2cb+kHrM9kJC2tOED9WHCw/yfiVD2J6Vkh4tB+ccqdTPaB7N8PBdpcoblsF
 UQ2KxXU4lYz1W2TP2zDR6RR22G7kTChTDEfJrt1GA1+UBoTn7rYu5ozdWEOuAZnWfe7VqirIB
 +1VQUONv/nBEjt+JseTBNsOeXLuBpRPW/udkfDEtQmUreTT+TXcB95K/VgWbQqJi2ToIGCwYp
 vlM5RyYzk+IgS6sg0DNzCmYZgIkmn71WVHwwr3vujPJ7FgYRqtq6q8sisw8Sfcx/CLSz1mU2L
 DtZ5c7DXBs4z2n+ef91cWMipVj+Qhhg8uG/UZzBKJtYDI1tK+JWfuDfsgG6R4qyRlwMeyOL2k
 LtHAeJLEWDLQC/lRadQCXAQHZdWY80ee1nx/8WClZFQTGV3WK9TGsKb5lQUYy2TF5Psswqz83
 xG1p7iOyHERCkvMvJYhJ9GjHxdWERyvnB1GZ6dDuMhgT36msTRfiP+01sEbB+Y2F41G866oEp
 2q76mEs64L+QDHo2Lq5iciMlvLzozWuLGRhCJIEYpbDkMgM+XWnMUUYo+LTxA97uhFjybiER/
 SRrV/8XaidVgPIyD3rfhE4vnqfHmLP8OH3wZvOYfDfS5+t1MwsmBCFxlKcUx/JjLdLpl4+HIY
 uAeSsjBUNM7VXEpmIlr6SU4t/s0sbfKzBXW7OH9c52gHYRx3DEmtue6A9VnpjSVgHLq9bh/rA
 5dsvKgSt2xuTdW0E6UBCMUBRTPN0cZ2HjUjJBmQQQ16ullzANu8BoFPNS9Ysd2Ycehoav2AwA
 e6Nobc6SL69XHsinRwvQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 2020-12-14 at 09:46 +0000, Filipe Manana wrote:

> clone mb/Documents.AZ/0.SYNC/....pdf - source=3Dmb/Documents.AZ/0.SYNC/.=
...pdf
> > source offset=3D20705280 offset=3D20709376 length=3D4096
> > clone mb/Documents.AZ/0.SYNC/....pdf - source=3Dmb/Documents.AZ/0.SYNC=
/....pdf
> > source offset=3D20713472 offset=3D20713472 length=3D4096
> > ERROR: failed to clone extents to mb/Documents.AZ/0.SYNC/....pdf: Inva=
lid
> > argument
>
> It's a different problem. This one because the kernel is sending an
> invalid clone operation - the source and destination offsets are the
> same, which makes the receiver fail.
> Can you tell what's the size (in bytes) of "mb/Documents.AZ/0.SYNC"
> after the receive fails? Both in the destination and source.

Hi Filipe,

I already deleted the failing subvolume, now I got the issue again. Here a=
re the
detailed information about the file:


# btrfs send /mnt/usb/mobiledata/snapshots/mobalindesk/vm/VirtualMachines.=
20190621T140904+0200 | mbuffer -v 1 -m 2% | btrfs receive /mnt/local/data/=
snapshots/vm/
...
write IE8 - Win7/IE8 - Win7-disk1.vmdk - offset=3D4742344704 length=3D4096
clone IE8 - Win7/IE8 - Win7-disk1.vmdk - source=3DIE8 - Win7/IE8 - Win7-di=
sk1.vmdk source offset=3D4742184960 offset=3D4742348800 length=3D16384
clone IE8 - Win7/IE8 - Win7-disk1.vmdk - source=3DIE8 - Win7/IE8 - Win7-di=
sk1.vmdk source offset=3D4742184960 offset=3D4742365184 length=3D28672
clone IE8 - Win7/IE8 - Win7-disk1.vmdk - source=3DIE8 - Win7/IE8 - Win7-di=
sk1.vmdk source offset=3D4742246400 offset=3D4742393856 length=3D8192
write IE8 - Win7/IE8 - Win7-disk1.vmdk - offset=3D4742402048 length=3D1228=
8
clone IE8 - Win7/IE8 - Win7-disk1.vmdk - source=3DIE8 - Win7/IE8 - Win7-di=
sk1.vmdk source offset=3D4742410240 offset=3D4742414336 length=3D4096
clone IE8 - Win7/IE8 - Win7-disk1.vmdk - source=3DIE8 - Win7/IE8 - Win7-di=
sk1.vmdk source offset=3D4742418432 offset=3D4742418432 length=3D4096
ERROR: failed to clone extents to IE8 - Win7/IE8 - Win7-disk1.vmdk: Invali=
d argument

summary: 4226 MiByte in 21min 11.4sec - average of 3404 kiB/s


# ls -al "/mnt/usb/mobiledata/snapshots/mobalindesk/vm/VirtualMachines.201=
90621T140904+0200/IE8 - Win7/IE8 - Win7-disk1.vmdk"
-rw------- 1 massimo massimo 17932222464 18. Dez 2018  '/mnt/usb/mobiledat=
a/snapshots/mobalindesk/vm/VirtualMachines.20190621T140904+0200/IE8 - Win7=
/IE8 - Win7-disk1.vmdk'

# ls -al "/mnt/local/data/snapshots/vm/VirtualMachines.20190621T140904+020=
0/IE8 - Win7/IE8 - Win7-disk1.vmdk"
-rw------- 1 root root 4742418432 18. Dez 07:37 '/mnt/local/data/snapshots=
/vm/VirtualMachines.20190621T140904+0200/IE8 - Win7/IE8 - Win7-disk1.vmdk'

# compsize "/mnt/usb/mobiledata/snapshots/mobalindesk/vm/VirtualMachines.2=
0190621T140904+0200/IE8 - Win7/IE8 - Win7-disk1.vmdk"
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL       45%      7.3G          16G          16G
none       100%      1.9G         1.9G         2.3G
zlib        38%      4.8G          12G          13G
zstd        34%      536M         1.5G         727M

# compsize "/mnt/local/data/snapshots/vm/VirtualMachines.20190621T140904+0=
200/IE8 - Win7/IE8 - Win7-disk1.vmdk"
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL       92%      4.1G         4.4G         4.3G
none       100%      3.8G         3.8G         3.8G
zlib        32%      7.3M          22M          22M
zstd        45%      264M         583M         560M

Does that help you?

Best regards,
Massimo

