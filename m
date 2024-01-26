Return-Path: <linux-btrfs+bounces-1819-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 963B583D9C6
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jan 2024 12:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47E83299F74
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jan 2024 11:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3900E1B958;
	Fri, 26 Jan 2024 11:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMMYvoeZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675DE1B940
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jan 2024 11:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706270152; cv=none; b=ZB9K7bgVhfPSIIx5qDCaBaH9buTtmaz2UMitUV6uqT86fhmNee6ga08LmbSH5y+i8V+9ex2uITByhtdB3+Q6NT3QXQ5/4K+00WBUSqGBqXdvmfmFJQIjJIJEK/R0v5ZvzXH3hBKRuo93grBon3Yce3g1UOYXIgQCevX9Yy0tYkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706270152; c=relaxed/simple;
	bh=MkQIMC498XS/Q+GcDcy8XVMcJcPB/I6WSI7b7cMj490=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i8a9Cqoh6HD/lJIMHPDvTiMt0wGDnwt853fpmBPsonlppBx8+ByBaLINlK89+IcNrroQjQcWWaqX7wXOBH0kV6vNax8PE2fTe+aZmV0wWLbKwoIyLrzyTQXENE9NBrO2B6Hhh79L8WT1Ed8Gg3wXQoyFeaeXaVliEFA4dfePF7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMMYvoeZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6796C43399
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jan 2024 11:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706270151;
	bh=MkQIMC498XS/Q+GcDcy8XVMcJcPB/I6WSI7b7cMj490=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kMMYvoeZ+NoBHaAV9tM37jN5ARJE0c5ZrD6K84tokcxwCVrpptB3djog0ujFdIuJl
	 d3npg9YCPKXv66jndVAZrpZYQPCQnulFYRxDCFomxucUQkTvdI7OOtCQa8UO5QxMFt
	 WUSqD5Jd/V8vo/A5VaW3HG1efNEq/voZf1xXQiodR2gHFvex2QL/VxXu9dMKWz3vFd
	 +0tkNvgeTzhhKny0AoMdohv7Yi80zfKDcryQJ/1BZoIVmwf23fhD1F0rCqyxr1PP7D
	 7wVmINicCRQ7+7zplVP136cGYSjIYQ/znlmixuBsmZTmP3eQ73y/WYf1GGjtWlKECl
	 3+SRDPcCu1VRQ==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a2c179aa5c4so47211566b.0
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jan 2024 03:55:51 -0800 (PST)
X-Gm-Message-State: AOJu0YxHa5whjcZlc4PuoERp8087hNAk404G2c1IRNouf5szgsfrndtF
	1sZaf/6Dvlz8FhOivc8rgXHff19Ch26iloS/yHBSWTVugpzKjzzLzmWFbBkbc8cc70CxpnVihG9
	dMQreqNC+do/GJ7m3a2fL+76DX+0=
X-Google-Smtp-Source: AGHT+IE3K6K5no/oKwYl2tJH+BsmOY82nc2n80VDW36TqN6dxoftuD4dECPwVkkz9wdgD9juq6iTO+4cnm+agDFRgUA=
X-Received: by 2002:a17:906:ae99:b0:a30:420f:447b with SMTP id
 md25-20020a170906ae9900b00a30420f447bmr584691ejb.7.1706270149956; Fri, 26 Jan
 2024 03:55:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <72097c8f447b02fb4ed3cb6b898d73423ca52d09.camel@kernel.org>
 <8b24dc83-1506-b5cc-1441-5233d161f5d8@suse.com> <20230619175443.GE16168@twin.jikos.cz>
 <CAL3q7H6bmy-a7hk216HgbbZZfS-t59bV2HZa18TJ=qHXMHJfRw@mail.gmail.com> <e8651759-c364-424a-a2b7-ef7acd128974@gmx.com>
In-Reply-To: <e8651759-c364-424a-a2b7-ef7acd128974@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 26 Jan 2024 11:55:12 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7pBvYdNoG=Twm2unnY+-Z8d03wvfT8fy1bRbQYp_gT1A@mail.gmail.com>
Message-ID: <CAL3q7H7pBvYdNoG=Twm2unnY+-Z8d03wvfT8fy1bRbQYp_gT1A@mail.gmail.com>
Subject: Re: BUG in raid6_pq while running fstest btrfs/286
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, Jeff Layton <jlayton@kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Song Liu <song@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Giulio Benetti <giulio.benetti@benettiengineering.com>, 
	linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 11:04=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com>=
 wrote:
>
>
>
> On 2024/1/25 20:43, Filipe Manana wrote:
> > On Mon, Jun 19, 2023 at 7:36=E2=80=AFPM David Sterba <dsterba@suse.cz> =
wrote:
> >>
> >> On Fri, Jun 16, 2023 at 09:57:47AM +0800, Qu Wenruo wrote:
> >>> On 2023/6/16 01:58, Jeff Layton wrote:
> >>>> I hit this today, while doing some testing with kdevops. Test btrfs/=
286
> >>>> was running when it failed:
> >>>>
> >>>> [ 4759.230216] run fstests btrfs/286 at 2023-06-15 16:11:41
> >>>> [ 4759.636322] BTRFS: device fsid 8d197804-9964-4b3f-bbea-3ef33869b5=
64 devid 1 transid 484 /dev/loop16 scanned by mount (893879)
> >>>> [ 4759.641190] BTRFS info (device loop16): using crc32c (crc32c-inte=
l) checksum algorithm
> >>>> [ 4759.644817] BTRFS info (device loop16): using free space tree
> >>>> [ 4759.650706] BTRFS info (device loop16): enabling ssd optimization=
s
> >>>> [ 4759.652720] BTRFS info (device loop16): auto enabling async disca=
rd
> >>>> [ 4760.484561] BTRFS: device fsid 2a451aed-b7b6-4498-ba17-0e28a2e1a2=
6b devid 1 transid 6 /dev/loop5 scanned by (udev-worker) (894101)
> >>>> [ 4760.494221] BTRFS: device fsid 2a451aed-b7b6-4498-ba17-0e28a2e1a2=
6b devid 2 transid 6 /dev/loop6 scanned by (udev-worker) (892207)
> >>>> [ 4760.497373] BTRFS: device fsid 2a451aed-b7b6-4498-ba17-0e28a2e1a2=
6b devid 3 transid 6 /dev/loop7 scanned by (udev-worker) (892535)
> >>>> [ 4760.502687] BTRFS: device fsid 2a451aed-b7b6-4498-ba17-0e28a2e1a2=
6b devid 4 transid 6 /dev/loop8 scanned by mkfs.btrfs (894095)
> >>>> [ 4760.515672] BTRFS info (device loop5): using crc32c (crc32c-intel=
) checksum algorithm
> >>>> [ 4760.519412] BTRFS info (device loop5): setting nodatasum
> >>>> [ 4760.521777] BTRFS info (device loop5): using free space tree
> >>>> [ 4760.527120] BTRFS info (device loop5): enabling ssd optimizations
> >>>> [ 4760.528861] BTRFS info (device loop5): auto enabling async discar=
d
> >>>> [ 4760.532184] BTRFS info (device loop5): checking UUID tree
> >>>> [ 4762.658754] BTRFS info (device loop5): using crc32c (crc32c-intel=
) checksum algorithm
> >>>> [ 4762.662098] BTRFS info (device loop5): allowing degraded mounts
> >>>> [ 4762.664749] BTRFS info (device loop5): setting nodatasum
> >>>> [ 4762.667347] BTRFS info (device loop5): using free space tree
> >>>> [ 4762.672306] BTRFS warning (device loop5): devid 2 uuid de8712ab-c=
a85-4414-93a7-213060d1831d is missing
> >>>> [ 4762.676977] BTRFS info (device loop5): enabling ssd optimizations
> >>>> [ 4762.679852] BTRFS info (device loop5): auto enabling async discar=
d
> >>>> [ 4763.355404] BTRFS info (device loop5): dev_replace from <missing =
disk> (devid 2) to /dev/loop9 started
> >>>> [ 4763.595633] BTRFS info (device loop5): dev_replace from <missing =
disk> (devid 2) to /dev/loop9 finished
> >>>> [ 4764.044660] 286 (893750): drop_caches: 3
> >>>> [ 4765.384814] BTRFS: device fsid 7acce38c-63c2-4365-a338-e1f6c0fd48=
4b devid 1 transid 6 /dev/loop5 scanned by (udev-worker) (894101)
> >>>> [ 4765.392235] BTRFS: device fsid 7acce38c-63c2-4365-a338-e1f6c0fd48=
4b devid 2 transid 6 /dev/loop6 scanned by (udev-worker) (892207)
> >>>> [ 4765.404469] BTRFS: device fsid 7acce38c-63c2-4365-a338-e1f6c0fd48=
4b devid 3 transid 6 /dev/loop7 scanned by (udev-worker) (894101)
> >>>> [ 4765.412107] BTRFS: device fsid 7acce38c-63c2-4365-a338-e1f6c0fd48=
4b devid 4 transid 6 /dev/loop8 scanned by mkfs.btrfs (894169)
> >>>> [ 4765.429084] BTRFS info (device loop5): using crc32c (crc32c-intel=
) checksum algorithm
> >>>> [ 4765.433332] BTRFS info (device loop5): setting nodatasum
> >>>> [ 4765.435506] BTRFS info (device loop5): using free space tree
> >>>> [ 4765.440808] BTRFS info (device loop5): enabling ssd optimizations
> >>>> [ 4765.442402] BTRFS info (device loop5): auto enabling async discar=
d
> >>>> [ 4765.444752] BTRFS info (device loop5): checking UUID tree
> >>>> [ 4767.634901] BTRFS info (device loop5): using crc32c (crc32c-intel=
) checksum algorithm
> >>>> [ 4767.637985] BTRFS info (device loop5): allowing degraded mounts
> >>>> [ 4767.640216] BTRFS info (device loop5): setting nodatasum
> >>>> [ 4767.642221] BTRFS info (device loop5): using free space tree
> >>>> [ 4767.646646] BTRFS warning (device loop5): devid 2 uuid 6240c286-8=
93c-4d19-bbf5-f1d2fecc6b96 is missing
> >>>> [ 4767.650311] BTRFS warning (device loop5): devid 2 uuid 6240c286-8=
93c-4d19-bbf5-f1d2fecc6b96 is missing
> >>>> [ 4767.655256] BTRFS info (device loop5): enabling ssd optimizations
> >>>> [ 4767.658073] BTRFS info (device loop5): auto enabling async discar=
d
> >>>> [ 4768.343633] BTRFS info (device loop5): dev_replace from <missing =
disk> (devid 2) to /dev/loop9 started
> >>>> [ 4768.608799] BTRFS info (device loop5): dev_replace from <missing =
disk> (devid 2) to /dev/loop9 finished
> >>>> [ 4768.750345] 286 (893750): drop_caches: 3
> >>>> [ 4769.993871] BTRFS: device fsid 965cdb50-095a-4fd9-bcda-2c17bd80c3=
ad devid 1 transid 6 /dev/loop5 scanned by (udev-worker) (894101)
> >>>> [ 4770.002879] BTRFS: device fsid 965cdb50-095a-4fd9-bcda-2c17bd80c3=
ad devid 2 transid 6 /dev/loop6 scanned by (udev-worker) (892207)
> >>>> [ 4770.015617] BTRFS: device fsid 965cdb50-095a-4fd9-bcda-2c17bd80c3=
ad devid 3 transid 6 /dev/loop7 scanned by (udev-worker) (894101)
> >>>> [ 4770.021936] BTRFS: device fsid 965cdb50-095a-4fd9-bcda-2c17bd80c3=
ad devid 4 transid 6 /dev/loop8 scanned by mkfs.btrfs (894243)
> >>>> [ 4770.041357] BTRFS info (device loop5): using crc32c (crc32c-intel=
) checksum algorithm
> >>>> [ 4770.043426] BTRFS info (device loop5): setting nodatasum
> >>>> [ 4770.045340] BTRFS info (device loop5): using free space tree
> >>>> [ 4770.050615] BTRFS info (device loop5): enabling ssd optimizations
> >>>> [ 4770.053473] BTRFS info (device loop5): auto enabling async discar=
d
> >>>> [ 4770.056311] BTRFS info (device loop5): checking UUID tree
> >>>> [ 4772.692223] BTRFS info (device loop5): using crc32c (crc32c-intel=
) checksum algorithm
> >>>> [ 4772.695043] BTRFS info (device loop5): allowing degraded mounts
> >>>> [ 4772.697901] BTRFS info (device loop5): setting nodatasum
> >>>> [ 4772.700355] BTRFS info (device loop5): using free space tree
> >>>> [ 4772.704900] BTRFS warning (device loop5): devid 2 uuid 5fa35bdf-8=
f54-4652-ba28-7c302a265f8d is missing
> >>>> [ 4772.708151] BTRFS warning (device loop5): devid 2 uuid 5fa35bdf-8=
f54-4652-ba28-7c302a265f8d is missing
> >>>> [ 4772.713703] BTRFS info (device loop5): enabling ssd optimizations
> >>>> [ 4772.716270] BTRFS info (device loop5): auto enabling async discar=
d
> >>>> [ 4773.735253] BTRFS info (device loop5): dev_replace from <missing =
disk> (devid 2) to /dev/loop9 started
> >>>> [ 4774.089640] BTRFS info (device loop5): dev_replace from <missing =
disk> (devid 2) to /dev/loop9 finished
> >>>> [ 4774.269606] 286 (893750): drop_caches: 3
> >>>> [ 4775.897236] BTRFS: device fsid 0552fbf6-2877-4ab3-b5a2-da5db268e1=
c3 devid 1 transid 6 /dev/loop5 scanned by (udev-worker) (894101)
> >>>> [ 4775.905939] BTRFS: device fsid 0552fbf6-2877-4ab3-b5a2-da5db268e1=
c3 devid 2 transid 6 /dev/loop6 scanned by mkfs.btrfs (894317)
> >>>> [ 4775.909603] BTRFS: device fsid 0552fbf6-2877-4ab3-b5a2-da5db268e1=
c3 devid 3 transid 6 /dev/loop7 scanned by mkfs.btrfs (894317)
> >>>> [ 4775.913080] BTRFS: device fsid 0552fbf6-2877-4ab3-b5a2-da5db268e1=
c3 devid 4 transid 6 /dev/loop8 scanned by mkfs.btrfs (894317)
> >>>> [ 4775.928177] BTRFS info (device loop5): using crc32c (crc32c-intel=
) checksum algorithm
> >>>> [ 4775.930566] BTRFS info (device loop5): setting nodatasum
> >>>> [ 4775.932930] BTRFS info (device loop5): using free space tree
> >>>> [ 4775.937296] BTRFS info (device loop5): enabling ssd optimizations
> >>>> [ 4775.938306] BTRFS info (device loop5): auto enabling async discar=
d
> >>>> [ 4775.940084] BTRFS info (device loop5): checking UUID tree
> >>>> [ 4779.204728] BTRFS info (device loop5): using crc32c (crc32c-intel=
) checksum algorithm
> >>>> [ 4779.207351] BTRFS info (device loop5): allowing degraded mounts
> >>>> [ 4779.210284] BTRFS info (device loop5): setting nodatasum
> >>>> [ 4779.212740] BTRFS info (device loop5): using free space tree
> >>>> [ 4779.218547] BTRFS warning (device loop5): devid 2 uuid 9a9f7178-0=
caa-4c5f-8f92-034e72257005 is missing
> >>>> [ 4779.221982] BTRFS warning (device loop5): devid 2 uuid 9a9f7178-0=
caa-4c5f-8f92-034e72257005 is missing
> >>>> [ 4779.227912] BTRFS info (device loop5): enabling ssd optimizations
> >>>> [ 4779.230483] BTRFS info (device loop5): auto enabling async discar=
d
> >>>> [ 4780.128223] BTRFS info (device loop5): dev_replace from <missing =
disk> (devid 2) to /dev/loop9 started
> >>>> [ 4780.422390] BUG: kernel NULL pointer dereference, address: 000000=
0000000000
> >>>> [ 4780.423934] #PF: supervisor read access in kernel mode
> >>>> [ 4780.425584] #PF: error_code(0x0000) - not-present page
> >>>> [ 4780.427234] PGD 0 P4D 0
> >>>> [ 4780.428293] Oops: 0000 [#1] PREEMPT SMP PTI
> >>>> [ 4780.429722] CPU: 3 PID: 761699 Comm: kworker/u16:4 Not tainted 6.=
4.0-rc6+ #6
> >>>> [ 4780.431582] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), B=
IOS 1.16.2-1.fc38 04/01/2014
> >>>> [ 4780.433897] Workqueue: btrfs-rmw rmw_rbio_work [btrfs]
> >>>> [ 4780.435655] RIP: 0010:raid6_sse21_gen_syndrome+0x9e/0x130 [raid6_=
pq]
> >>>> [ 4780.437518] Code: 4d 8d 54 05 00 44 89 c0 48 c1 e0 03 48 29 c6 49=
 8b 03 48 01 d0 0f 18 00 66 0f 6f 10 49 8b 01 0f 18 04 10 66 0f 6f e2 49 8b=
 01 <66> 0f 6f 34 10 4c 89 d0 45 85 c0 78 34 48 8b 08 0f 18 04 11 66 0f
> >>>> [ 4780.442488] RSP: 0018:ffffb66f0296fdc8 EFLAGS: 00010286
> >>>> [ 4780.444147] RAX: 0000000000000000 RBX: 0000000000001000 RCX: ffff=
a0ff4cfa3248
> >>>> [ 4780.446192] RDX: 0000000000000000 RSI: ffffa0f74cfa3238 RDI: 0000=
000000000000
> >>>> [ 4780.448278] RBP: ffffa0ff4e72a000 R08: 00000000fffffffe R09: ffff=
a0ff4cfa3238
> >>>> [ 4780.450387] R10: ffffa0ff4cfa3230 R11: ffffa0ff4cfa3240 R12: ffff=
a0fe8bdf3000
> >>>> [ 4780.452515] R13: ffffa0ff4cfa3240 R14: 0000000000000003 R15: 0000=
000000000000
> >>>> [ 4780.454638] FS:  0000000000000000(0000) GS:ffffa0ff77cc0000(0000)=
 knlGS:0000000000000000
> >>>> [ 4780.456956] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>>> [ 4780.458778] CR2: 0000000000000000 CR3: 000000015eb0a001 CR4: 0000=
000000060ee0
> >>>> [ 4780.460789] Call Trace:
> >>>> [ 4780.461832]  <TASK>
> >>>> [ 4780.462804]  ? __die+0x1f/0x70
> >>>> [ 4780.463915]  ? page_fault_oops+0x159/0x450
> >>>> [ 4780.465207]  ? fixup_exception+0x22/0x310
> >>>> [ 4780.466484]  ? exc_page_fault+0x7a/0x180
> >>>> [ 4780.467666]  ? asm_exc_page_fault+0x22/0x30
> >>>> [ 4780.468879]  ? raid6_sse21_gen_syndrome+0x9e/0x130 [raid6_pq]
> >>>> [ 4780.470372]  ? raid6_sse21_gen_syndrome+0x38/0x130 [raid6_pq]
> >>>> [ 4780.471801]  rmw_rbio+0x5c8/0xa80 [btrfs]
> >>>> [ 4780.472987]  ? preempt_count_add+0x6a/0xa0
> >>>> [ 4780.474061]  ? lock_stripe_add+0xe1/0x290 [btrfs]
> >>>> [ 4780.475288]  process_one_work+0x1c7/0x3d0
> >>>> [ 4780.476304]  worker_thread+0x4d/0x380
> >>>> [ 4780.477232]  ? __pfx_worker_thread+0x10/0x10
> >>>> [ 4780.478241]  kthread+0xf3/0x120
> >>>> [ 4780.479071]  ? __pfx_kthread+0x10/0x10
> >>>> [ 4780.479982]  ret_from_fork+0x2c/0x50
> >>>> [ 4780.480843]  </TASK>
> >>>> [ 4780.481488] Modules linked in: dm_thin_pool dm_persistent_data dm=
_bio_prison dm_bufio dm_log_writes dm_flakey nls_iso8859_1 nls_cp437 vfat f=
at ext4 9p crc16 joydev kvm_intel netfs virtio_net mbcache cirrus kvm psmou=
se pcspkr net_failover failover xfs irqbypass drm_shmem_helper virtio_ballo=
on jbd2 evdev button 9pnet_virtio drm_kms_helper loop drm dm_mod zram zsmal=
loc crct10dif_pclmul crc32_pclmul ghash_clmulni_intel sha512_ssse3 sha512_g=
eneric aesni_intel nvme virtio_blk crypto_simd nvme_core virtio_pci cryptd =
t10_pi virtio i6300esb virtio_pci_legacy_dev crc64_rocksoft_generic virtio_=
pci_modern_dev crc64_rocksoft crc64 virtio_ring serio_raw btrfs blake2b_gen=
eric libcrc32c crc32c_generic crc32c_intel xor raid6_pq autofs4
> >>>> [ 4780.492421] CR2: 0000000000000000
> >>>> [ 4780.493185] ---[ end trace 0000000000000000 ]---
> >>>> [ 4780.494099] RIP: 0010:raid6_sse21_gen_syndrome+0x9e/0x130 [raid6_=
pq]
> >>>> [ 4780.495217] Code: 4d 8d 54 05 00 44 89 c0 48 c1 e0 03 48 29 c6 49=
 8b 03 48 01 d0 0f 18 00 66 0f 6f 10 49 8b 01 0f 18 04 10 66 0f 6f e2 49 8b=
 01 <66> 0f 6f 34 10 4c 89 d0 45 85 c0 78 34 48 8b 08 0f 18 04 11 66 0f
> >>>> [ 4780.498186] RSP: 0018:ffffb66f0296fdc8 EFLAGS: 00010286
> >>>> [ 4780.499138] RAX: 0000000000000000 RBX: 0000000000001000 RCX: ffff=
a0ff4cfa3248
> >>>> [ 4780.500327] RDX: 0000000000000000 RSI: ffffa0f74cfa3238 RDI: 0000=
000000000000
> >>>> [ 4780.501533] RBP: ffffa0ff4e72a000 R08: 00000000fffffffe R09: ffff=
a0ff4cfa3238
> >>>> [ 4780.502683] R10: ffffa0ff4cfa3230 R11: ffffa0ff4cfa3240 R12: ffff=
a0fe8bdf3000
> >>>> [ 4780.503827] R13: ffffa0ff4cfa3240 R14: 0000000000000003 R15: 0000=
000000000000
> >>>> [ 4780.504971] FS:  0000000000000000(0000) GS:ffffa0ff77cc0000(0000)=
 knlGS:0000000000000000
> >>>> [ 4780.506207] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>>> [ 4780.507143] CR2: 0000000000000000 CR3: 000000015eb0a001 CR4: 0000=
000000060ee0
> >>>> [ 4780.508242] note: kworker/u16:4[761699] exited with irqs disabled
> >>>> [ 4780.509242] note: kworker/u16:4[761699] exited with preempt_count=
 1
> >>>>
> >>>>
> >>>> Looks like a quadword move failed? I'm not well-versed in SSE asm, I=
'm afraid:
> >>>>
> >>>> $ ./scripts/faddr2line --list ./lib/raid6/raid6_pq.ko raid6_sse21_ge=
n_syndrome+0x9e/0x130
> >>>> raid6_sse21_gen_syndrome+0x9e/0x130:
> >>>>
> >>>> raid6_sse21_gen_syndrome at /home/jlayton/git/kdevops/linux/lib/raid=
6/sse2.c:56
> >>>>    51                for ( d =3D 0 ; d < bytes ; d +=3D 16 ) {
> >>>>    52                        asm volatile("prefetchnta %0" : : "m" (=
dptr[z0][d]));
> >>>>    53                        asm volatile("movdqa %0,%%xmm2" : : "m"=
 (dptr[z0][d])); /* P[0] */
> >>>>    54                        asm volatile("prefetchnta %0" : : "m" (=
dptr[z0-1][d]));
> >>>>    55                        asm volatile("movdqa %xmm2,%xmm4"); /* =
Q[0] */
> >>>>> 56<                        asm volatile("movdqa %0,%%xmm6" : : "m" =
(dptr[z0-1][d]));
> >>>>    57                        for ( z =3D z0-2 ; z >=3D 0 ; z-- ) {
> >>>>    58                                asm volatile("prefetchnta %0" :=
 : "m" (dptr[z][d]));
> >>>>    59                                asm volatile("pcmpgtb %xmm4,%xm=
m5");
> >>>>    60                                asm volatile("paddb %xmm4,%xmm4=
");
> >>>>    61                                asm volatile("pand %xmm0,%xmm5"=
);
> >>>>
> >>>>
> >>>> This machine is running v6.4.0-rc5 with some ctime handling patches =
on
> >>>> top (nothing that should affect anything at this level). The Kconfig=
 is
> >>>> config-next-20230530 from the kdevops tree:
> >>>>
> >>>> https://github.com/linux-kdevops/kdevops/blob/master/playbooks/roles=
/bootlinux/templates/config-next-20230530)
> >>>>
> >>>> Let me know if you need other info!
> >>>
> >>> Unfortunately there are similar reports but I failed to reproduce any=
where.
> >>>
> >>> In the past, I have added extra debugging for the reporter, and the
> >>> result is, at least every pointer is valid, until the control is pass=
ed
> >>> to the optimization routine...
> >>>
> >>> You can try to disable SSE for the vCPU, or even pass AVX feature to =
the
> >>> vCPU, and normally you would see the error gone.
> >>>
> >>> The last time I see such problem is from David, but we did not got an=
y
> >>> progress any further.
> >>
> >> I haven't seen the crash for a long time, IIRC it's related to SSE2,
> >> no acceleration or anything AVX+ works.
> >
> > Well, I don't think it's related to SSE2 at all.
> >
> > I sporadically get the same crash with AVX2, for raid56 tests, so I
> > would say it's very likely btrfs' fault.
> > For example this crash on 6.2 when running btrfs/027:
> >
> > [10425.262835] general protection fault, probably for non-canonical
> > address 0xcccccccccccccccc: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC PTI
> > [10425.265179] CPU: 0 PID: 11267 Comm: kworker/u16:2 Not tainted
> > 6.2.0-rc7-btrfs-next-145+ #1
> > [10425.266196] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> > [10425.267570] Workqueue: btrfs-rmw rmw_rbio_work [btrfs]
> > [10425.268247] RIP: 0010:raid6_avx21_gen_syndrome+0x9e/0x130 [raid6_pq]
>
> In fact, my previous run of that 5.15 backport also hit a crash, but for
> avx512 path.
> (And 5.15 is even before my RAID56 rework)
>
> Although in my case, it may be related to the special big/little cores
> of intel CPUs. (I assigned 8 vCPU to the VM, while there are only 6 big
> cores, 8 small cores may not support AVX512)
> Furthermore, on my AMD cpus powered VMs, they never hit such crash.
> (Both AMD and Intel machines are using host-passingthrough for vCPU
> features)
>
> Furthermore, my crash is very random, it crashed in btrfs/297, with all
> previous RAID56 test cases passed.
>
> So I'm still not sure what's really going on here.
>
> > [10425.268986] Code: 4d 8d 54 05 00 44 89 c0 48 c1 e0 03 48 29 c6 49
> > 8b 03 48 01 d0 0f 18 00 c5 fd 6f 10 49 8b 01 0f 18 04 10 c5 fd 6f e2
> > 49 8b 01 <c5> fd 6f 34 10 4c 89 d0 45 85 c0 78 30 48 8b 08 0f 18 04 11
> > c>
> > [10425.271183] RSP: 0018:ffffb370c722fd80 EFLAGS: 00010286
> > [10425.271892] RAX: cccccccccccccccc RBX: 0000000000001000 RCX: ffff9b0=
8a87e9800
>
> The RAX is the first parameter, aka rbio->real_stripes, while RBX is
> sectorsize (0x1000 =3D 4K).
>
> So there is definitely something wrong here.
>
> Can you reproduce the problem reliably?

No, I can't.
As I said, it happens very sporadically, and it's been like that for
many years, ever since I remember... Like maybe once every 3 months or
less than that.
It happens on any test that exercises raid56, and the last records I
have, it's been always on tests that exercise device replace, so
there's probably a connection.

>
> Thanks,
> Qu
>
> > [10425.273176] RDX: 0000000000000000 RSI: ffff9b00a87e98d8 RDI: 0000000=
000000000
> > [10425.274074] RBP: ffff9b08e7e31000 R08: 00000000fffffffe R09: ffff9b0=
8a87e98d8
> > [10425.274886] R10: ffff9b08a87e98d0 R11: ffff9b08a87e98e0 R12: ffff9b0=
8e5c00000
> > [10425.275742] R13: ffff9b08a87e98e0 R14: 0000000000000003 R15: 0000000=
000000000
> > [10425.276562] FS:  0000000000000000(0000) GS:ffff9b0bace00000(0000)
> > knlGS:0000000000000000
> > [10425.277515] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [10425.278172] CR2: 00007f7e1a04f421 CR3: 000000017b9b8001 CR4: 0000000=
000370ef0
> > [10425.278982] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
> > [10425.279809] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000=
000000400
> > [10425.280574] Call Trace:
> > [10425.280849]  <TASK>
> > [10425.281064]  rmw_rbio.part.0+0x384/0x890 [btrfs]
> > [10425.281709]  rmw_rbio_work+0x64/0x80 [btrfs]
> > [10425.282245]  process_one_work+0x24f/0x5a0
> > [10425.282672]  worker_thread+0x52/0x3b0
> > [10425.283059]  ? __pfx_worker_thread+0x10/0x10
> > [10425.283573]  kthread+0xf0/0x120
> > [10425.283906]  ? __pfx_kthread+0x10/0x10
> > [10425.284308]  ret_from_fork+0x29/0x50
> > [10425.284696]  </TASK>
> > [10425.284989] Modules linked in: loop btrfs blake2b_generic xor
> > raid6_pq libcrc32c overlay intel_rapl_msr intel_rapl_common
> > crct10dif_pclmul ghash_clmulni_intel sha512_ssse3 sha512_generic bochs
> > aesni_intel dr>
> > [10425.295936] ---[ end trace 0000000000000000 ]---
> >
> > Qu also got the same crash on AVX recently.
> >

