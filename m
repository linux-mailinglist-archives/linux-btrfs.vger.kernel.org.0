Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5E6CB590
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2019 09:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbfJDH7S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Oct 2019 03:59:18 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:56313 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729906AbfJDH7R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Oct 2019 03:59:17 -0400
X-Originating-IP: 163.158.29.153
Received: from katrien.duckstad.net (153-029-158-163.dynamic.caiway.nl [163.158.29.153])
        (Authenticated sender: relay@duckstad.net)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id E5E2DE000A;
        Fri,  4 Oct 2019 07:59:15 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by katrien.duckstad.net (Postfix) with ESMTP id EED4B38037;
        Fri,  4 Oct 2019 09:59:14 +0200 (CEST)
Received: from katrien.duckstad.net ([127.0.0.1])
        by localhost (katrien.duckstad.net [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id hZXrjEcR03BW; Fri,  4 Oct 2019 09:59:13 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by katrien.duckstad.net (Postfix) with ESMTP id 033D638039;
        Fri,  4 Oct 2019 09:59:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 katrien.duckstad.net 033D638039
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duckstad.net;
        s=EEE0E95C-ABE4-11E9-AA35-1FC771689572; t=1570175953;
        bh=FJl8N3qrPqec3lAcO8e9q8vvuYUZdNs+xmrzNrNchKQ=;
        h=Message-ID:From:To:Date:MIME-Version;
        b=tFCr90UUrnHXts9CBTwPNcjfAzFgNP02Vs+8fj85h95TWXXhwK0AyU53vfik3lRRt
         5nKJ5fowiFb2dQlWPCezz8VH0bwc0VvgiQLiUCjdtMwwdfl305a7ZhNpyRIgVQUhnV
         lfoab2YAFsDG8+Km1/hgBWR8O+6SCprq7mtChpFYgqKsCj5hcBP6dDk+8ov90sZaE4
         tq1bs5MXqCSr+2QfIbCJdwHK8eU0Z47BYbuBc4Pa4T9kD7u9wMr18lkq+knCDiLF4K
         XhkTq50hbX8ZdRi4svLOVHQx9E+xah1/h8SMOgoKvAQjNGebQM+m0Iykc5uL2UYMXN
         N5AzcFhCtzEPg==
X-Virus-Scanned: amavisd-new at katrien.duckstad.net
Received: from katrien.duckstad.net ([127.0.0.1])
        by localhost (katrien.duckstad.net [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NICqaekSERiP; Fri,  4 Oct 2019 09:59:12 +0200 (CEST)
Received: from bolderbast (unknown [10.4.2.1])
        by katrien.duckstad.net (Postfix) with ESMTPSA id BF21B38037;
        Fri,  4 Oct 2019 09:59:11 +0200 (CEST)
Message-ID: <2923c00a7460329a673b9b0669480cb568b2848f.camel@duckstad.net>
Subject: Re: BTRFS errors, and won't mount
From:   Patrick Dijkgraaf <bolderbast@duckstad.net>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Date:   Fri, 04 Oct 2019 09:59:11 +0200
In-Reply-To: <1a5483ba85372d02d898ae9650686e591f82a735.camel@duckstad.net>
References: <2649522a0283fc35ade2218755063f8ff0dc4aa4.camel@duckstad.net>
         <293de2b3-506a-0fcc-f692-0fc03012941c@gmx.com>
         <1a5483ba85372d02d898ae9650686e591f82a735.camel@duckstad.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.0 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Decided to upgrade my system to the latest and give it a shot:

# btrfs check /dev/sde2
Opening filesystem to check...
parent transid verify failed on 4314780106752 wanted 470169 found
470107
checksum verify failed on 4314780106752 found 7077566E wanted 9494EBD8
checksum verify failed on 4314780106752 found 489FC179 wanted 73D057EA
checksum verify failed on 4314780106752 found 489FC179 wanted 73D057EA
bad tree block 4314780106752, bytenr mismatch, want=3D4314780106752,
have=3D20212047631104
ERROR: cannot open file system

# uname -r
5.3.1-arch1-1-ARCH

# btrfs --version
btrfs-progs v5.2.2

Does that help anything?

--=20
Groet / Cheers,
Patrick Dijkgraaf


On Fri, 2019-10-04 at 09:41 +0200, Patrick Dijkgraaf wrote:
> Hi Qu,
>=20
> I know about RAID5/6 risks, so I won't blame anyone but myself. I'm
> currenlty working on another solution, but I was not quite there
> yet...
>=20
> mount -o ro /dev/sdh2 /mnt/data gives me:
>=20
> [Fri Oct  4 09:36:27 2019] BTRFS info (device sde2): disk space
> caching
> is enabled
> [Fri Oct  4 09:36:27 2019] BTRFS info (device sde2): has skinny
> extents
> [Fri Oct  4 09:36:27 2019] BTRFS error (device sde2): parent transid
> verify failed on 5483020828672 wanted 470169 found 470108
> [Fri Oct  4 09:36:27 2019] btree_readpage_end_io_hook: 5 callbacks
> suppressed
> [Fri Oct  4 09:36:27 2019] BTRFS error (device sde2): bad tree block
> start 2286352011705795888 5483020828672
> [Fri Oct  4 09:36:27 2019] BTRFS error (device sde2): bad tree block
> start 2286318771218040112 5483020828672
> [Fri Oct  4 09:36:27 2019] BTRFS error (device sde2): bad tree block
> start 2286363934109025584 5483020828672
> [Fri Oct  4 09:36:27 2019] BTRFS error (device sde2): bad tree block
> start 2286229742125204784 5483020828672
> [Fri Oct  4 09:36:27 2019] BTRFS error (device sde2): bad tree block
> start 2286353230849918256 5483020828672
> [Fri Oct  4 09:36:27 2019] BTRFS error (device sde2): bad tree block
> start 2286246155688035632 5483020828672
> [Fri Oct  4 09:36:27 2019] BTRFS error (device sde2): bad tree block
> start 2286321695890425136 5483020828672
> [Fri Oct  4 09:36:27 2019] BTRFS error (device sde2): bad tree block
> start 2286384677254874416 5483020828672
> [Fri Oct  4 09:36:27 2019] BTRFS error (device sde2): bad tree block
> start 2286386365024912688 5483020828672
> [Fri Oct  4 09:36:27 2019] BTRFS error (device sde2): bad tree block
> start 2286284400752608560 5483020828672
> [Fri Oct  4 09:36:27 2019] BTRFS error (device sde2): failed to
> recover
> balance: -5
> [Fri Oct  4 09:36:27 2019] BTRFS error (device sde2): open_ctree
> failed
>=20
> Do you think there is any chance to recover?
>=20
> Thanks,
> Patrick.
>=20
>=20
> On Fri, 2019-10-04 at 15:22 +0800, Qu Wenruo wrote:
> > On 2019/10/4 =E4=B8=8B=E5=8D=882:59, Patrick Dijkgraaf wrote:
> > > Hi guys,
> > >=20
> > > During the night, I started getting the following errors and data
> > > was
> > > no longer accessible:
> > >=20
> > > [Fri Oct  4 08:04:26 2019] btree_readpage_end_io_hook: 2522
> > > callbacks
> > > suppressed
> > > [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree
> > > block
> > > start 17686343003259060482 7808404996096
> >=20
> > Tree block at address 7808404996096 is completely broken.
> >=20
> > All the other messages with 7808404996096 shows btrfs is trying all
> > possible device combinations to rebuild that tree block, but
> > obviously
> > all failed.
> >=20
> > Not sure why the tree block is corrupted, but it's pretty possible
> > that
> > RAID5/6 write hole ruined your possibility to recover.
> >=20
> > > [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree
> > > block
> > > start 254095834002432 7808404996096
> > > [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree
> > > block
> > > start 2574563607252646368 7808404996096
> > > [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree
> > > block
> > > start 17873260189421384017 7808404996096
> > > [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree
> > > block
> > > start 9965805624054187110 7808404996096
> > > [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree
> > > block
> > > start 15108378087789580224 7808404996096
> > > [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree
> > > block
> > > start 7914705769619568652 7808404996096
> > > [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree
> > > block
> > > start 16752645757091223687 7808404996096
> > > [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree
> > > block
> > > start 9617669583708276649 7808404996096
> > > [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree
> > > block
> > > start 3384408928046898608 7808404996096
> >=20
> > [...]
> > > Decided to reboot (for another reason) and tried to mount
> > > afterwards:
> > >=20
> > > [Fri Oct  4 08:29:42 2019] BTRFS info (device sde2): disk space
> > > caching
> > > is enabled
> > > [Fri Oct  4 08:29:42 2019] BTRFS info (device sde2): has skinny
> > > extents
> > > [Fri Oct  4 08:29:44 2019] BTRFS error (device sde2): parent
> > > transid
> > > verify failed on 5483020828672 wanted 470169 found 470108
> > > [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree
> > > block
> > > start 2286352011705795888 5483020828672
> > > [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree
> > > block
> > > start 2286318771218040112 5483020828672
> > > [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree
> > > block
> > > start 2286363934109025584 5483020828672
> > > [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree
> > > block
> > > start 2286229742125204784 5483020828672
> > > [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree
> > > block
> > > start 2286353230849918256 5483020828672
> > > [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree
> > > block
> > > start 2286246155688035632 5483020828672
> > > [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree
> > > block
> > > start 2286321695890425136 5483020828672
> > > [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree
> > > block
> > > start 2286384677254874416 5483020828672
> > > [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree
> > > block
> > > start 2286386365024912688 5483020828672
> > > [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree
> > > block
> > > start 2286284400752608560 5483020828672
> > > [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): failed to
> > > recover
> > > balance: -5
> > > [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): open_ctree
> > > failed
> >=20
> > You're lucky, as the problem is from balance recovery, thus you may
> > have
> > a chance to mount the RO.
> > As your fs can progress to btrfs_recover_relocation(), most
> > essential
> > trees should be OK, thus you have a chance to mount it RO.
> >=20
> > > The FS info is shown below. It is a RAID6.
> > >=20
> > > Label: 'data'  uuid: 43472491-7bb3-418c-b476-874a52e8b2b0
> > > 	Total devices 16 FS bytes used 36.73TiB
> >=20
> > You won't want to salvage data from a near 40T fs...
> >=20
> > > 	devid    1 size 7.28TiB used 2.66TiB path /dev/sde2
> > > 	devid    2 size 3.64TiB used 2.66TiB path /dev/sdf2
> > > 	devid    3 size 3.64TiB used 2.66TiB path /dev/sdg2
> > > 	devid    4 size 7.28TiB used 2.66TiB path /dev/sdh2
> > > 	devid    5 size 3.64TiB used 2.66TiB path /dev/sdi2
> > > 	devid    6 size 7.28TiB used 2.66TiB path /dev/sdj2
> > > 	devid    7 size 3.64TiB used 2.66TiB path /dev/sdk2
> > > 	devid    8 size 3.64TiB used 2.66TiB path /dev/sdl2
> > > 	devid    9 size 7.28TiB used 2.66TiB path /dev/sdm2
> > > 	devid   10 size 3.64TiB used 2.66TiB path /dev/sdn2
> > > 	devid   11 size 7.28TiB used 2.66TiB path /dev/sdo2
> > > 	devid   12 size 3.64TiB used 2.66TiB path /dev/sdp2
> > > 	devid   13 size 7.28TiB used 2.66TiB path /dev/sdq2
> > > 	devid   14 size 7.28TiB used 2.66TiB path /dev/sdr2
> > > 	devid   15 size 3.64TiB used 2.66TiB path /dev/sds2
> > > 	devid   16 size 3.64TiB used 2.66TiB path /dev/sdt2
> >=20
> > And you won't want to use RAID6 if you're expecting RAID6 to
> > tolerant
> > 2
> > disks malfunction.
> >=20
> > As btrfs RAID5/6 has write-hole problem, any unexpected power loss
> > or
> > disk error could reduce the error tolerance step by step, if you're
> > not
> > running scrub regularly.
> >=20
> > > The initial error refers to sdw, so possibly something happened
> > > that
> > > caused one or more disks in the external cabinet to disappear and
> > > reappear.
> > >=20
> > > Kernel is 4.18.16-arch1-1-ARCH. Very hesitant to upgrade it,
> > > because
> > > previously I had to downgrade the kernel to get the volume
> > > mounted
> > > again.
> > >=20
> > > Question: I know that running checks on BTRFS can be dangerous,
> > > what
> > > can you recommend me doing to get the volume back online?
> >=20
> > "btrfs check" is not dangerous at all. In fact it's pretty safe and
> > it's
> > the main tool we use to expose any problem.
> >=20
> > It's "btrfs check --repair" dangerous, but way less dangerous in
> > recent
> > years. (although in your case, --repair is completely unrelated and
> > won't help at all)
> >=20
> > "btrfs check" output from latest btrfs-progs would help.
> >=20
> > Thanks,
> > Qu
>=20
>=20
>=20


