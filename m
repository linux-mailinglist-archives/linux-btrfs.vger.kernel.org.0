Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A88A19C258
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Aug 2019 08:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbfHYGlb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 25 Aug 2019 02:41:31 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:50811 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbfHYGlb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 25 Aug 2019 02:41:31 -0400
Received: from katrien.duckstad.net (153-029-158-163.dynamic.caiway.nl [163.158.29.153])
        (Authenticated sender: relay@duckstad.net)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id E9BFF200003;
        Sun, 25 Aug 2019 06:41:28 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by katrien.duckstad.net (Postfix) with ESMTP id 630C03802F;
        Sun, 25 Aug 2019 08:41:28 +0200 (CEST)
Received: from katrien.duckstad.net ([127.0.0.1])
        by localhost (katrien.duckstad.net [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id k4mxjp_XblvK; Sun, 25 Aug 2019 08:41:26 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by katrien.duckstad.net (Postfix) with ESMTP id 2FCB438030;
        Sun, 25 Aug 2019 08:41:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 katrien.duckstad.net 2FCB438030
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duckstad.net;
        s=EEE0E95C-ABE4-11E9-AA35-1FC771689572; t=1566715286;
        bh=A3nXaXnyEF5H9jwuwUzWzKTzjvf8GcnXr95iSM58QPo=;
        h=Message-ID:From:To:Date:MIME-Version;
        b=oo9ZoyhaIXYuOTsQRgMn3P5GemG/HL1N0L10aM3V+JAIC+KbbMhKtfmWHjRsDhMQV
         NPksPKDzPEa0AkIhW7kuCN6SijIuP/mg/JjsJguBAEIUNOCyXDNDLoPbnkkCMsXFfG
         1J6z1CXM3M90EwtiCmfkcxfcae4oHrTLzKcvyJ3Cncwt9pmAXEMEwKpPDMeRIYAFvw
         l1gb4Pi+TEaWaXjXIyvo8YGn6sygqg8MLa8uLQMQar8ax68gZ5HSPWv6s9r+kFuX78
         mNRcdGicnGEbxae8UkZeL7OYu5rglzgQRy08FvZmEEvdiqKY7AkmfkVbnK5filaUbq
         7XFv/sCD35HJQ==
X-Virus-Scanned: amavisd-new at katrien.duckstad.net
Received: from katrien.duckstad.net ([127.0.0.1])
        by localhost (katrien.duckstad.net [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gLrcqI3pElRz; Sun, 25 Aug 2019 08:41:24 +0200 (CEST)
Received: from bolderbast (unknown [10.4.2.1])
        by katrien.duckstad.net (Postfix) with ESMTPSA id CC05F3802F;
        Sun, 25 Aug 2019 08:41:23 +0200 (CEST)
Message-ID: <2c681f5fd6ea3d8bc764416bad7da1f6f0665347.camel@duckstad.net>
Subject: Re: Need help: super_total_bytes mismatch with fs_devices
 total_rw_bytes
From:   Patrick Dijkgraaf <bolderbast@duckstad.net>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Date:   Sun, 25 Aug 2019 08:41:23 +0200
In-Reply-To: <2e471646-7201-f33d-a9c7-ecbe19b73a58@gmx.com>
References: <42e408bdd5b38305358c961e06c0afe250a00a90.camel@duckstad.net>
         <211fbb73-6a16-a8a6-e2b3-a0799216fe9c@gmx.com>
         <579f07cdb257e15e9f79f501600ce8033353db91.camel@duckstad.net>
         <2e471646-7201-f33d-a9c7-ecbe19b73a58@gmx.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

At the end of my first initial post, I mentioned that I finally was
able to mount the volume using:

mount -o usebackuproot,ro /dev/sdh2 /mnt/data

The chunk tree and super blocks dumps were taken after that.

Now I noticed that I was able to mount the volume without special
options (same kernel version). YAY! =E2=98=BA
Could it be that the "usebackuproot,ro" mount options already fixed the
issue?

Cheers,
Patrick


On Sat, 2019-08-24 at 21:24 +0800, Qu Wenruo wrote:
> On 2019/8/24 =E4=B8=8B=E5=8D=888:05, Patrick Dijkgraaf wrote:
> > Thanks for the quick reply!
> > See responses inline.
> >=20
> > On Sat, 2019-08-24 at 19:01 +0800, Qu Wenruo wrote:
> > > On 2019/8/24 =E4=B8=8B=E5=8D=882:48, Patrick Dijkgraaf wrote:
> > > > Hi all,
> > > >=20
> > > > My server hung this morning, and I had to hard-reset is. I did
> > > > not
> > > > apply any updates. After the reboot, my FS won't mount:
> > > >=20
> > > > [Sat Aug 24 08:16:31 2019] BTRFS error (device sde2):
> > > > super_total_bytes
> > > > 92017957797888 mismatch with fs_devices total_rw_bytes
> > > > 184035915595776
> > > > [Sat Aug 24 08:16:31 2019] BTRFS error (device sde2): failed to
> > > > read
> > > > chunk tree: -22
> > > > [Sat Aug 24 08:16:31 2019] BTRFS error (device sde2):
> > > > open_ctree
> > > > failed
> > > >=20
> > > > However, running btrfs rescue shows:
> > > > root@cornelis ~]# btrfs rescue fix-device-size /dev/sdh2
> > > > No device size related problem found
> > >=20
> > > That's strange.
> > >=20
> > > Would you please dump the chunk tree and super blocks?
> > > # btrfs ins dump-super -fFa /dev/sdh2
> >=20
> > See:=20
> > https://pastebin.com/f5Wn15sx
> >=20
>=20
> Did a quick calculation, from your fi show result, it's 83.72TiB,
> thus
> the super total_bytes is correct.
>=20
> It's the kernel doing incorrect calculation for its
> fs_devices->total_rw_bytes.
>=20
> This matches the output of dump-super. No wonder why btrfs-progs
> refuse
> to fix.
> > > # btrfs ins dump-tree -t chunk /dev/sdh2
> >=20
> > This output is too large for pastebin. The output is
> > viewable/downloadable here:=20
> > https://kwek.duckstad.net/tree.txt
> >=20
>=20
> This also proves your chunk tree is CORRECT!
> The sum of all devices is 92017957797888, which matches with super
> block.
> [...]
> > > The simplest way to fix it is to just update the
> >=20
> > Nice teaser! =F0=9F=98=89 What should I update?
>=20
> Sorry, I meant to say just update the "superblock", but it turns out,
> it's something wrong with your kernel. Probably some old bug we fixed
> before.
>=20
> Would you try to use latest ARCH kernel from an Archiso to try to
> mount
> it RO (just to be safe)?
>=20
> I checked latest v5.3-rc kernels, haven't found an obvious problem
> with
> the fs_devices->total_rw_bytes update routines.
>=20
> So it may be an old bug which is already fixed.
>=20
> Thanks,
> Qu
>=20
> > > Thanks,
> > > Qu
> > > > Other info:
> > > > [root@cornelis ~]# uname -r
> > > > 4.18.16-arch1-1-ARCH
> > > >=20
> > > > I was able to mount is using:
> > > > [root@cornelis ~]# mount -o usebackuproot,ro /dev/sdh2
> > > > /mnt/data
> > > >=20
> > > > Now updating my backup, but I REALLY hope to get this fixed on
> > > > the
> > > > production server!
> > > >=20
> >=20
> >=20


