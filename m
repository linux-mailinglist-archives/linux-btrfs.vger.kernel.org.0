Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406B72EB36A
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Jan 2021 20:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbhAETUW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jan 2021 14:20:22 -0500
Received: from box5.speed47.net ([188.165.215.42]:60150 "EHLO mx.speed47.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726234AbhAETUV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 5 Jan 2021 14:20:21 -0500
Received: from rain.speed47.net (nginx [192.168.80.2])
        by box.speed47.net (Postfix) with ESMTPSA id 9BA7D35B;
        Tue,  5 Jan 2021 20:19:38 +0100 (CET)
Authentication-Results: box.speed47.net; dmarc=fail (p=none dis=none) header.from=lesimple.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lesimple.fr;
        s=mail01; t=1609874378;
        bh=Vihhu5cJoqA3BUVSKH1zMJ0Ehw+Q9rXYePw6FvSu/+E=;
        h=Date:From:Subject:To:Cc:In-Reply-To:References;
        b=Y8fYrzP+dzZepr4aOkRg8Vv9i5SQ21ZIQ7hTkSeGbvd0ESzzOjiaQDAP2qfetTM6E
         ErS+DsgfIDrScOIedFo9Rw0Plnk1cmVDIp4HuvpSkLIyOktdsIkeOwhEE39B6HEeYZ
         c3vyEgwgW/jipGTdePpWI6u1/LRYQWE29qlW2cSA=
MIME-Version: 1.0
Date:   Tue, 05 Jan 2021 19:19:38 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.12.1
From:   "=?utf-8?B?U3TDqXBoYW5lIExlc2ltcGxl?=" <stephane_btrfs2@lesimple.fr>
Message-ID: <ee715f644c3024a97efccbda2c8b22d2@lesimple.fr>
Subject: Re: Raid1 of a slow hdd and a fast(er) SSD, howto to prioritize
 the SSD?
To:     Cedric.dewijs@eclipso.eu, "Qu Wenruo" <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <8af92960a09701579b6bcbb9b51489cc@mail.eclipso.de>
References: <8af92960a09701579b6bcbb9b51489cc@mail.eclipso.de>
 <28232f6c03d8ae635d2ddffe29c82fac@mail.eclipso.de>
 <3c670816-35b9-4bb7-b555-1778d61685c7@gmx.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

January 5, 2021 7:20 PM, Cedric.dewijs@eclipso.eu wrote:=0A=0A>>> I was e=
xpecting btrfs to do almost all reads from the fast SSD, as both=0A> =0A>=
 the data and the metadata is on that drive, so the slow hdd is only real=
ly=0A> needed when there's a bitflip on the SSD, and the data has to be r=
econstructed.=0A> =0A>> IIRC there will be some read policy feature to do=
 that, but not yet=0A>> merged, and even merged, you still need to manual=
ly specify the=0A>> priority, as there is no way for btrfs to know which =
driver is faster=0A>> (except the non-rotational bit, which is not reliab=
le at all).=0A> =0A> Manually specifying the priority drive would be a bi=
g step in the right direction. Maybe btrfs=0A> could get a routine that b=
enchmarks the sequential and random read and write speed of the drives at=
=0A> (for instance) mount time, or triggered by an administrator? This co=
uld lead to misleading results=0A> if btrfs doesn't get the whole drive t=
o itself.=0A> =0A>>> Writing has to be done to both drives of course, but=
 I don't expect=0A> =0A> slowdowns from that, as the system RAM should ca=
che that.=0A> =0A>> Write can still slow down the system even you have to=
ns of memory.=0A>> Operations like fsync() or sync() will still wait for =
the writeback,=0A>> thus in your case, it will also be slowed by the HDD =
no matter what.=0A>> =0A>> In fact, in real world desktop, most of the wr=
ites are from sometimes=0A>> unnecessary fsync().=0A>> =0A>> To get rid o=
f such slow down, you have to go dangerous by disabling=0A>> barrier, whi=
ch is never a safe idea.=0A> =0A> I suggest a middle ground, where btrfs =
returns from fsync when one of the copies (instead of all=0A> the copies)=
 of the data has been written completely to disk. This poses a small data=
 risk, as this=0A> creates moments that there's only one copy of the data=
 on disk, while the software above btrfs=0A> thinks all data is written o=
n two disks. one problem I see if the server is told to shut down while=
=0A> there's a big backlog of data to be written to the slow drive, while=
 the big drive is already done.=0A> Then the server could cut the power w=
hile the slow drive is still being written.=0A> =0A> i think this setting=
 should be given to the system administrator, it's not a good idea to jus=
t=0A> blindly enable this behavior.=0A> =0A>>> Is there a way to tell btr=
fs to leave the slow hdd alone, and to prioritize=0A> =0A> the SSD?=0A> =
=0A>> Not in upstream kernel for now.=0A=0A=0AI happen to have written a =
custom patch for my own use for a similar use case:=0AI have a bunch of s=
low drives constituting a raid1 FS of dozens of terabytes,=0Aand just one=
 SSD, reserved only for metadata.=0A=0AMy patch adds an entry under sysfs=
 for each FS so that the admin can select the=0A"metadata_only" devid. Th=
is is optional, if it's not done, the usual btrfs behavior=0Aapplies. Whe=
n set, this device is:=0A- never considered for new data chunks allocatio=
n=0A- preferred for new metadata chunk allocations=0A- preferred for meta=
data reads=0A=0AThis way I still have raid1, but the metadata chunks on s=
low drives are only=0Athere for redundancy and never accessed for reads a=
s long as the SSD metadata=0Ais valid.=0A=0AThis *drastically* improved m=
y snapshots rotation, and even made qgroups usable=0Aagain. I think I've =
been running this for 1-2 years, but obviously I'd love seeing=0Asuch opt=
ion on the vanilla kernel so that I can get rid of hacky patch :)=0A=0A>>=
 =0A>> Thus I guess you need something like bcache to do this.=0A> =0A> A=
greed. However, one of the problems of bcache, it that it can't use 2 SSD=
's in mirrored mode to=0A> form a writeback cache in front of many spindl=
es, so this structure is impossible:=0A> +-------------------------------=
----------------------------+--------------+--------------+=0A> | btrfs r=
aid 1 (2 copies) /mnt |=0A> +--------------+--------------+--------------=
+--------------+--------------+--------------+=0A> | /dev/bcache0 | /dev/=
bcache1 | /dev/bcache2 | /dev/bcache3 | /dev/bcache4 | /dev/bcache5 |=0A>=
 +--------------+--------------+--------------+--------------+-----------=
---+--------------+=0A> | Write Cache (2xSSD in raid 1, mirrored) |=0A> |=
 /dev/sda2 and /dev/sda3 |=0A> +--------------+--------------+-----------=
---+--------------+--------------+--------------+=0A> | Data | Data | Dat=
a | Data | Data | Data |=0A> | /dev/sda9 | /dev/sda10 | /dev/sda11 | /dev=
/sda12 | /dev/sda13 | /dev/sda14 |=0A> +--------------+--------------+---=
-----------+--------------+--------------+--------------+=0A> =0A> In ord=
er to get a system that has no data loss if a drive fails, the user eithe=
r has to live with=0A> only a read cache, or the user has to put a separa=
te writeback cache in front of each spindle like=0A> this:=0A> +---------=
--------------------------------------------------+=0A> | btrfs raid 1 (2=
 copies) /mnt |=0A> +--------------+--------------+--------------+-------=
-------+=0A> | /dev/bcache0 | /dev/bcache1 | /dev/bcache2 | /dev/bcache3 =
|=0A> +--------------+--------------+--------------+--------------+=0A> |=
 Write Cache | Write Cache | Write Cache | Write Cache |=0A> |(Flash Driv=
e) |(Flash Drive) |(Flash Drive) |(Flash Drive) |=0A> | /dev/sda5 | /dev/=
sda6 | /dev/sda7 | /dev/sda8 |=0A> +--------------+--------------+-------=
-------+--------------+=0A> | Data | Data | Data | Data |=0A> | /dev/sda9=
 | /dev/sda10 | /dev/sda11 | /dev/sda12 |=0A> +--------------+-----------=
---+--------------+--------------+=0A> =0A> In the mainline kernel is's i=
mpossible to put a bcache on top of a bcache, so a user does not have=0A>=
 the option to have 4 small write caches below one fast, big read cache l=
ike this:=0A> +----------------------------------------------------------=
-+=0A> | btrfs raid 1 (2 copies) /mnt |=0A> +--------------+-------------=
-+--------------+--------------+=0A> | /dev/bcache4 | /dev/bcache5 | /dev=
/bcache6 | /dev/bcache7 |=0A> +--------------+--------------+------------=
--++-------------+=0A> | Read Cache (SSD) |=0A> | /dev/sda4 |=0A> +------=
--------+--------------+--------------+--------------+=0A> | /dev/bcache0=
 | /dev/bcache1 | /dev/bcache2 | /dev/bcache3 |=0A> +--------------+-----=
---------+--------------+--------------+=0A> | Write Cache | Write Cache =
| Write Cache | Write Cache |=0A> |(Flash Drive) |(Flash Drive) |(Flash D=
rive) |(Flash Drive) |=0A> | /dev/sda5 | /dev/sda6 | /dev/sda7 | /dev/sda=
8 |=0A> +--------------+--------------+--------------+--------------+=0A>=
 | Data | Data | Data | Data |=0A> | /dev/sda9 | /dev/sda10 | /dev/sda11 =
| /dev/sda12 |=0A> +--------------+--------------+--------------+--------=
------+=0A> =0A>> Thanks,=0A>> Qu=0A> =0A> Thank you,=0A> Cedric=0A> =0A>=
 ---=0A> =0A> Take your mailboxes with you. Free, fast and secure Mail & =
Cloud: https://www.eclipso.eu - Time to=0A> change!
