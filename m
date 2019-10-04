Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA60CB56D
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2019 09:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbfJDHlU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Oct 2019 03:41:20 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:53639 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728841AbfJDHlU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Oct 2019 03:41:20 -0400
X-Originating-IP: 163.158.29.153
Received: from katrien.duckstad.net (153-029-158-163.dynamic.caiway.nl [163.158.29.153])
        (Authenticated sender: relay@duckstad.net)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 99CDA40003;
        Fri,  4 Oct 2019 07:41:17 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by katrien.duckstad.net (Postfix) with ESMTP id EC66638037;
        Fri,  4 Oct 2019 09:41:16 +0200 (CEST)
Received: from katrien.duckstad.net ([127.0.0.1])
        by localhost (katrien.duckstad.net [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id A_TK7uSZfYZ5; Fri,  4 Oct 2019 09:41:15 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by katrien.duckstad.net (Postfix) with ESMTP id 16A7338039;
        Fri,  4 Oct 2019 09:41:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 katrien.duckstad.net 16A7338039
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duckstad.net;
        s=EEE0E95C-ABE4-11E9-AA35-1FC771689572; t=1570174875;
        bh=s2cC/W2AMQPulfqRxVHQSH46akdKcFtbAiK9nfp2vuE=;
        h=Message-ID:From:To:Date:MIME-Version;
        b=ju7BqAsloPH3KmS4wZ/6B4ECyxCcSvSKF1S32jj0zRGTxuLJ6V3Pmwryp4lTo4+NY
         Wo+AtufSAM/yo18VQDsQolvc4ELO3soDtETGI1uM0ugLJueZ1hdb96tw4P5XRcgSh4
         yjlpyMuJevixHpXk8tK/o7i2U/cdwjvsOt9P7vVr5jl/+6FP89Zz2OHhMtuFzGG7Id
         VRWbn9qMBa9G3w1JT4cYU24xeUqYCrHOEiulaNvTEed0Gwu4iN6PgUDTM+kAVrR7bs
         PnpfrO0CVvDvBIMUym1BDKVV18pVhek8qE68G1tdh9sIImUP4FJs+t76vPZZjMsVUL
         HcLrugwFqMYAA==
X-Virus-Scanned: amavisd-new at katrien.duckstad.net
Received: from katrien.duckstad.net ([127.0.0.1])
        by localhost (katrien.duckstad.net [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id g2PC2f3Nf1D8; Fri,  4 Oct 2019 09:41:15 +0200 (CEST)
Received: from bolderbast (unknown [10.4.2.1])
        by katrien.duckstad.net (Postfix) with ESMTPSA id BA4F338037;
        Fri,  4 Oct 2019 09:41:14 +0200 (CEST)
Message-ID: <1a5483ba85372d02d898ae9650686e591f82a735.camel@duckstad.net>
Subject: Re: BTRFS errors, and won't mount
From:   Patrick Dijkgraaf <bolderbast@duckstad.net>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Date:   Fri, 04 Oct 2019 09:41:14 +0200
In-Reply-To: <293de2b3-506a-0fcc-f692-0fc03012941c@gmx.com>
References: <2649522a0283fc35ade2218755063f8ff0dc4aa4.camel@duckstad.net>
         <293de2b3-506a-0fcc-f692-0fc03012941c@gmx.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.0 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

I know about RAID5/6 risks, so I won't blame anyone but myself. I'm
currenlty working on another solution, but I was not quite there yet...

mount -o ro /dev/sdh2 /mnt/data gives me:

[Fri Oct  4 09:36:27 2019] BTRFS info (device sde2): disk space caching
is enabled
[Fri Oct  4 09:36:27 2019] BTRFS info (device sde2): has skinny extents
[Fri Oct  4 09:36:27 2019] BTRFS error (device sde2): parent transid
verify failed on 5483020828672 wanted 470169 found 470108
[Fri Oct  4 09:36:27 2019] btree_readpage_end_io_hook: 5 callbacks
suppressed
[Fri Oct  4 09:36:27 2019] BTRFS error (device sde2): bad tree block
start 2286352011705795888 5483020828672
[Fri Oct  4 09:36:27 2019] BTRFS error (device sde2): bad tree block
start 2286318771218040112 5483020828672
[Fri Oct  4 09:36:27 2019] BTRFS error (device sde2): bad tree block
start 2286363934109025584 5483020828672
[Fri Oct  4 09:36:27 2019] BTRFS error (device sde2): bad tree block
start 2286229742125204784 5483020828672
[Fri Oct  4 09:36:27 2019] BTRFS error (device sde2): bad tree block
start 2286353230849918256 5483020828672
[Fri Oct  4 09:36:27 2019] BTRFS error (device sde2): bad tree block
start 2286246155688035632 5483020828672
[Fri Oct  4 09:36:27 2019] BTRFS error (device sde2): bad tree block
start 2286321695890425136 5483020828672
[Fri Oct  4 09:36:27 2019] BTRFS error (device sde2): bad tree block
start 2286384677254874416 5483020828672
[Fri Oct  4 09:36:27 2019] BTRFS error (device sde2): bad tree block
start 2286386365024912688 5483020828672
[Fri Oct  4 09:36:27 2019] BTRFS error (device sde2): bad tree block
start 2286284400752608560 5483020828672
[Fri Oct  4 09:36:27 2019] BTRFS error (device sde2): failed to recover
balance: -5
[Fri Oct  4 09:36:27 2019] BTRFS error (device sde2): open_ctree failed

Do you think there is any chance to recover?

Thanks,
Patrick.


On Fri, 2019-10-04 at 15:22 +0800, Qu Wenruo wrote:
> On 2019/10/4 =E4=B8=8B=E5=8D=882:59, Patrick Dijkgraaf wrote:
> > Hi guys,
> >=20
> > During the night, I started getting the following errors and data
> > was
> > no longer accessible:
> >=20
> > [Fri Oct  4 08:04:26 2019] btree_readpage_end_io_hook: 2522
> > callbacks
> > suppressed
> > [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree
> > block
> > start 17686343003259060482 7808404996096
>=20
> Tree block at address 7808404996096 is completely broken.
>=20
> All the other messages with 7808404996096 shows btrfs is trying all
> possible device combinations to rebuild that tree block, but
> obviously
> all failed.
>=20
> Not sure why the tree block is corrupted, but it's pretty possible
> that
> RAID5/6 write hole ruined your possibility to recover.
>=20
> > [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree
> > block
> > start 254095834002432 7808404996096
> > [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree
> > block
> > start 2574563607252646368 7808404996096
> > [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree
> > block
> > start 17873260189421384017 7808404996096
> > [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree
> > block
> > start 9965805624054187110 7808404996096
> > [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree
> > block
> > start 15108378087789580224 7808404996096
> > [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree
> > block
> > start 7914705769619568652 7808404996096
> > [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree
> > block
> > start 16752645757091223687 7808404996096
> > [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree
> > block
> > start 9617669583708276649 7808404996096
> > [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree
> > block
> > start 3384408928046898608 7808404996096
>=20
> [...]
> > Decided to reboot (for another reason) and tried to mount
> > afterwards:
> >=20
> > [Fri Oct  4 08:29:42 2019] BTRFS info (device sde2): disk space
> > caching
> > is enabled
> > [Fri Oct  4 08:29:42 2019] BTRFS info (device sde2): has skinny
> > extents
> > [Fri Oct  4 08:29:44 2019] BTRFS error (device sde2): parent
> > transid
> > verify failed on 5483020828672 wanted 470169 found 470108
> > [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree
> > block
> > start 2286352011705795888 5483020828672
> > [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree
> > block
> > start 2286318771218040112 5483020828672
> > [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree
> > block
> > start 2286363934109025584 5483020828672
> > [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree
> > block
> > start 2286229742125204784 5483020828672
> > [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree
> > block
> > start 2286353230849918256 5483020828672
> > [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree
> > block
> > start 2286246155688035632 5483020828672
> > [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree
> > block
> > start 2286321695890425136 5483020828672
> > [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree
> > block
> > start 2286384677254874416 5483020828672
> > [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree
> > block
> > start 2286386365024912688 5483020828672
> > [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree
> > block
> > start 2286284400752608560 5483020828672
> > [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): failed to
> > recover
> > balance: -5
> > [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): open_ctree
> > failed
>=20
> You're lucky, as the problem is from balance recovery, thus you may
> have
> a chance to mount the RO.
> As your fs can progress to btrfs_recover_relocation(), most essential
> trees should be OK, thus you have a chance to mount it RO.
>=20
> > The FS info is shown below. It is a RAID6.
> >=20
> > Label: 'data'  uuid: 43472491-7bb3-418c-b476-874a52e8b2b0
> > 	Total devices 16 FS bytes used 36.73TiB
>=20
> You won't want to salvage data from a near 40T fs...
>=20
> > 	devid    1 size 7.28TiB used 2.66TiB path /dev/sde2
> > 	devid    2 size 3.64TiB used 2.66TiB path /dev/sdf2
> > 	devid    3 size 3.64TiB used 2.66TiB path /dev/sdg2
> > 	devid    4 size 7.28TiB used 2.66TiB path /dev/sdh2
> > 	devid    5 size 3.64TiB used 2.66TiB path /dev/sdi2
> > 	devid    6 size 7.28TiB used 2.66TiB path /dev/sdj2
> > 	devid    7 size 3.64TiB used 2.66TiB path /dev/sdk2
> > 	devid    8 size 3.64TiB used 2.66TiB path /dev/sdl2
> > 	devid    9 size 7.28TiB used 2.66TiB path /dev/sdm2
> > 	devid   10 size 3.64TiB used 2.66TiB path /dev/sdn2
> > 	devid   11 size 7.28TiB used 2.66TiB path /dev/sdo2
> > 	devid   12 size 3.64TiB used 2.66TiB path /dev/sdp2
> > 	devid   13 size 7.28TiB used 2.66TiB path /dev/sdq2
> > 	devid   14 size 7.28TiB used 2.66TiB path /dev/sdr2
> > 	devid   15 size 3.64TiB used 2.66TiB path /dev/sds2
> > 	devid   16 size 3.64TiB used 2.66TiB path /dev/sdt2
>=20
> And you won't want to use RAID6 if you're expecting RAID6 to tolerant
> 2
> disks malfunction.
>=20
> As btrfs RAID5/6 has write-hole problem, any unexpected power loss or
> disk error could reduce the error tolerance step by step, if you're
> not
> running scrub regularly.
>=20
> > The initial error refers to sdw, so possibly something happened
> > that
> > caused one or more disks in the external cabinet to disappear and
> > reappear.
> >=20
> > Kernel is 4.18.16-arch1-1-ARCH. Very hesitant to upgrade it,
> > because
> > previously I had to downgrade the kernel to get the volume mounted
> > again.
> >=20
> > Question: I know that running checks on BTRFS can be dangerous,
> > what
> > can you recommend me doing to get the volume back online?
>=20
> "btrfs check" is not dangerous at all. In fact it's pretty safe and
> it's
> the main tool we use to expose any problem.
>=20
> It's "btrfs check --repair" dangerous, but way less dangerous in
> recent
> years. (although in your case, --repair is completely unrelated and
> won't help at all)
>=20
> "btrfs check" output from latest btrfs-progs would help.
>=20
> Thanks,
> Qu



