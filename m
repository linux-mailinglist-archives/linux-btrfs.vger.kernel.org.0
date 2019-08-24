Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFE99BD87
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Aug 2019 14:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbfHXMF5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Aug 2019 08:05:57 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:35953 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727779AbfHXMF5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Aug 2019 08:05:57 -0400
X-Originating-IP: 163.158.29.153
Received: from katrien.duckstad.net (153-029-158-163.dynamic.caiway.nl [163.158.29.153])
        (Authenticated sender: relay@duckstad.net)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id CB8D840002;
        Sat, 24 Aug 2019 12:05:54 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by katrien.duckstad.net (Postfix) with ESMTP id 458CA3802F;
        Sat, 24 Aug 2019 14:05:54 +0200 (CEST)
Received: from katrien.duckstad.net ([127.0.0.1])
        by localhost (katrien.duckstad.net [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id sf94Q5OUmMhv; Sat, 24 Aug 2019 14:05:52 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by katrien.duckstad.net (Postfix) with ESMTP id 075DF38030;
        Sat, 24 Aug 2019 14:05:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 katrien.duckstad.net 075DF38030
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duckstad.net;
        s=EEE0E95C-ABE4-11E9-AA35-1FC771689572; t=1566648352;
        bh=Vwyjvq0rzhQEKtHTv98e73YpWM/BeBs3s8o0dXaJN6o=;
        h=Message-ID:From:To:Date:MIME-Version;
        b=n53rhWJvZbJdfrO+NGLQPsKKVjvq0L3BdWL5pBBLuvEp+OmgXD4Io9KaCpZ7Y5TC4
         zvxv7RgbyRhbZ7cYOWcVR00TN7VNAPCmZy1/6pJMrurWK+TDy5CXKiciA2RJ7z8dOu
         UpFWaL14ZyAss7I+Q5BunbTbrJKdeMlUl9LWsvZTUj0hfr0pEeVK2VhpXHSicSplUe
         hLir1m0llKHWOFj0ZUKDi3HTg56eI+O1P8aiT22M8+Ve2BVCqq2JuQGH+UnNx72Qpp
         KPAt60lJlRL4xHtfs3tRG7LqQCSIXW2A+SmSPfiFskhD6KYRjjz7b6Gv7FSOpqrZiU
         84pOr9VV1AhBQ==
X-Virus-Scanned: amavisd-new at katrien.duckstad.net
Received: from katrien.duckstad.net ([127.0.0.1])
        by localhost (katrien.duckstad.net [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RQ6OnaofgvDM; Sat, 24 Aug 2019 14:05:51 +0200 (CEST)
Received: from bolderbast (unknown [10.4.2.1])
        by katrien.duckstad.net (Postfix) with ESMTPSA id B1C533802F;
        Sat, 24 Aug 2019 14:05:51 +0200 (CEST)
Message-ID: <579f07cdb257e15e9f79f501600ce8033353db91.camel@duckstad.net>
Subject: Re: Need help: super_total_bytes mismatch with fs_devices
 total_rw_bytes
From:   Patrick Dijkgraaf <bolderbast@duckstad.net>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Date:   Sat, 24 Aug 2019 14:05:51 +0200
In-Reply-To: <211fbb73-6a16-a8a6-e2b3-a0799216fe9c@gmx.com>
References: <42e408bdd5b38305358c961e06c0afe250a00a90.camel@duckstad.net>
         <211fbb73-6a16-a8a6-e2b3-a0799216fe9c@gmx.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks for the quick reply!
See responses inline.

On Sat, 2019-08-24 at 19:01 +0800, Qu Wenruo wrote:
> On 2019/8/24 =E4=B8=8B=E5=8D=882:48, Patrick Dijkgraaf wrote:
> > Hi all,
> >=20
> > My server hung this morning, and I had to hard-reset is. I did not
> > apply any updates. After the reboot, my FS won't mount:
> >=20
> > [Sat Aug 24 08:16:31 2019] BTRFS error (device sde2):
> > super_total_bytes
> > 92017957797888 mismatch with fs_devices total_rw_bytes
> > 184035915595776
> > [Sat Aug 24 08:16:31 2019] BTRFS error (device sde2): failed to
> > read
> > chunk tree: -22
> > [Sat Aug 24 08:16:31 2019] BTRFS error (device sde2): open_ctree
> > failed
> >=20
> > However, running btrfs rescue shows:
> > root@cornelis ~]# btrfs rescue fix-device-size /dev/sdh2
> > No device size related problem found
>=20
> That's strange.
>=20
> Would you please dump the chunk tree and super blocks?
> # btrfs ins dump-super -fFa /dev/sdh2

See: https://pastebin.com/f5Wn15sx

> # btrfs ins dump-tree -t chunk /dev/sdh2

This output is too large for pastebin. The output is
viewable/downloadable here: https://kwek.duckstad.net/tree.txt

> And, have you tried to mount using different devices? If it's some
> super
> blocks get corrupted, using a different device to mount may help.
> (With that said, it's better to call that dump-super for each device)

Tried it with sde and sdh. Both give the same error.

> > FS config is shown below:
> > [root@cornelis ~]# btrfs fi show
> > Label: 'cornelis-btrfs'  uuid: ac643516-670e-40f3-aa4c-f329fc3795fd
> > Total devices 1 FS bytes used 536.05GiB
> > devid    1 size 800.00GiB used 630.02GiB path /dev/mapper/cornelis-
> > cornelis--btrfs
> >=20
> > Label: 'data'  uuid: 43472491-7bb3-418c-b476-874a52e8b2b0
> > Total devices 16 FS bytes used 36.61TiB
> > devid    1 size 7.28TiB used 2.65TiB path /dev/sde2
> > devid    2 size 3.64TiB used 2.65TiB path /dev/sdf2
> > devid    3 size 3.64TiB used 2.65TiB path /dev/sdg2
> > devid    4 size 7.28TiB used 2.65TiB path /dev/sdh2
> > devid    5 size 3.64TiB used 2.65TiB path /dev/sdi2
> > devid    6 size 7.28TiB used 2.65TiB path /dev/sdj2
> > devid    7 size 3.64TiB used 2.65TiB path /dev/sdk2
> > devid    8 size 3.64TiB used 2.65TiB path /dev/sdl2
> > devid    9 size 7.28TiB used 2.65TiB path /dev/sdm2
> > devid   10 size 3.64TiB used 2.65TiB path /dev/sdn2
> > devid   11 size 7.28TiB used 2.65TiB path /dev/sdo2
> > devid   12 size 3.64TiB used 2.65TiB path /dev/sdp2
> > devid   13 size 7.28TiB used 2.65TiB path /dev/sdq2
> > devid   14 size 7.28TiB used 2.65TiB path /dev/sdr2
> > devid   15 size 3.64TiB used 2.65TiB path /dev/sds2
> > devid   16 size 3.64TiB used 2.65TiB path /dev/sdt2
>=20
> What's the profile used on so many devices?
> RAID10?

It's RAID6. I know the risk, although I believe that should be minimal
nowadays.

> The simplest way to fix it is to just update the

Nice teaser! =F0=9F=98=89 What should I update?

> Thanks,
> Qu
> > Other info:
> > [root@cornelis ~]# uname -r
> > 4.18.16-arch1-1-ARCH
> >=20
> > I was able to mount is using:
> > [root@cornelis ~]# mount -o usebackuproot,ro /dev/sdh2 /mnt/data
> >=20
> > Now updating my backup, but I REALLY hope to get this fixed on the
> > production server!
> >=20


