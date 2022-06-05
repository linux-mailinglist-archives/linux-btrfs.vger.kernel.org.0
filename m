Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64F153DC77
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jun 2022 17:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345446AbiFEPMI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Jun 2022 11:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235016AbiFEPME (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Jun 2022 11:12:04 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A127F26E0;
        Sun,  5 Jun 2022 08:11:57 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 67-20020a1c1946000000b00397382b44f4so6682183wmz.2;
        Sun, 05 Jun 2022 08:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yTy1bLeJKe7VGaTgEpLf7zUNReM0QnaA/VcPziHJJuA=;
        b=GdqywLhUims7cEB81o1xxAQyNFC12JWQsb53OcPBrK9lYibMACDqApbmR/9Qv1KSig
         c4r+SO1G6sxeoepNLy3bjT7pAdwpqTJK+U9GC79Q7D/DxtzQC4OjvxI2i6+FgWEX6SPA
         ss7mwuJyi/pVEHsSPiIwRv8s0RXbhkMfpdt0+0SmocmwTC1+r4JJm6isHRq62R0o66T2
         WGCRgSoVRH10iynH98qeCzpSH54p75JuaTBNlA2E39aFFJWF85f4FduOaQCmwgymKUra
         cfDPdqn2NsAOjnxPccrV7MzWjPYcO8jJql75YC+z4UyeyHZA6LwJfPQcfwvgmFaW8jXk
         8FRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yTy1bLeJKe7VGaTgEpLf7zUNReM0QnaA/VcPziHJJuA=;
        b=49951rPT1UJbcbisGlp4NC39rQZ73xDlHlrmRHI6nYNtem0dUIgwGLlDCkwBYv4Nwo
         fKrZT5WFH4d8VTBIdsxtbDD2lvyom2WcwNcCJHK6N6DyJGrEcVhnKojLXM4TOl4NfXsL
         ocCalaP9HPTkU1pO+mJgLPe3IYa9gnW+MOTdxi6UOi1FQQ9Y99Hm1ShhY1nq0/UkDjHw
         NCyVNPo3W0L2tRyblGqZPxMJCfHcvBUFRL5lgqEDClYtMO1DzidtEs3dl2tQBroANY3+
         vqF8WG5Grm9xX3TgpWE5BwWKyj8jZDkY8xvtG41ULq2iCAi8uNa+UWCsNWbq3ntW8yyy
         x63Q==
X-Gm-Message-State: AOAM533M+VqktjqmWcbrYumJu8hLFSdDgC2h/R4NU74nPHjbqzU8gZmE
        gr3EAlE/JBeMLOuhbKYALMdhmjTOAFc=
X-Google-Smtp-Source: ABdhPJx3cXT1H4N+AkN0ix4HKUj3qNeucskHAuEgdQUatoKoxcNLcbKYC/yPPUGIrVCHUdbTlM3e7A==
X-Received: by 2002:a7b:c413:0:b0:39c:37cc:b0fe with SMTP id k19-20020a7bc413000000b0039c37ccb0femr14306050wmi.11.1654441915696;
        Sun, 05 Jun 2022 08:11:55 -0700 (PDT)
Received: from opensuse.localnet (host-79-13-108-3.retail.telecomitalia.it. [79.13.108.3])
        by smtp.gmail.com with ESMTPSA id b11-20020a5d4d8b000000b0020c7ec0fdf4sm14871335wru.117.2022.06.05.08.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 08:11:54 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     dsterba@suse.cz, Christoph Hellwig <hch@infradead.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: Replace kmap() with kmap_local_page()
Date:   Sun, 05 Jun 2022 17:11:48 +0200
Message-ID: <1793713.atdPhlSkOF@opensuse>
In-Reply-To: <20220602162840.GV20633@twin.jikos.cz>
References: <20220531145335.13954-1-fmdefrancesco@gmail.com> <YpjVKAGz+GuI4GB0@infradead.org> <20220602162840.GV20633@twin.jikos.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On gioved=C3=AC 2 giugno 2022 18:28:40 CEST David Sterba wrote:
> On Thu, Jun 02, 2022 at 08:20:08AM -0700, Christoph Hellwig wrote:
> > Turns out that while this looks good, it actually crashes when
> > running xfstests.  I think this is due to the fact that kmap sets
> > the page address, which kmap_local_page does not.
> >=20
> > btrfs/150 1s ... [  168.252943] run fstests btrfs/150 at 2022-06-02=20
15:17:11
> > [  169.462292] BTRFS info (device vdb): flagging fs with big metadata=20
feature
> > [  169.463728] BTRFS info (device vdb): disk space caching is enabled
> > [  169.464953] BTRFS info (device vdb): has skinny extents
> > [  170.596218] BTRFS: device fsid 37c6bae1-d3e5-47f8-87d5-87cd7240a1b4
> > devid 1 transid 5 /dev)
> > [  170.599471] BTRFS: device fsid 37c6bae1-d3e5-47f8-87d5-87cd7240a1b4=
=20
devid 2 transid 5 /dev)
> > [  170.657170] BTRFS info (device vdc): flagging fs with big metadata=20
feature
> > [  170.659509] BTRFS info (device vdc): use zlib compression, level 3
> > [  170.661190] BTRFS info (device vdc): disk space caching is enabled
> > [  170.670706] BTRFS info (device vdc): has skinny extents
> > [  170.714181] BTRFS info (device vdc): checking UUID tree
> > [  170.735058] BUG: kernel NULL pointer dereference, address:=20
0000000000000008
> > [  170.736478] #PF: supervisor read access in kernel mode
> > [  170.737457] #PF: error_code(0x0000) - not-present page
> > [  170.738529] PGD 0 P4D 0=20
> > [  170.739211] Oops: 0000 [#1] PREEMPT SMP PTI
> > [  170.740101] CPU: 0 PID: 43 Comm: kworker/u4:3 Not tainted 5.18.0-
rc7+ #1539
> > [  170.741478] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),=20
BIOS 1.14.0-2 04/01/2014
> > [  170.743246] Workqueue: btrfs-delalloc btrfs_work_helper
> > [  170.744282] RIP: 0010:zlib_compress_pages+0x128/0x670
>=20
> I've just hit the crash too, so I've removed the patches from misc-next
> until there's fixed version.
>=20
=46inally I've been able to run xfstests on a QEMU + KVM 32 bits VM. Since =
I=20
have very little experience with filesystems it was a bit hard to setup and=
=20
run.

I can confirm that the problems are only from conversions in patch 3/3.=20

Since I've been spending long time to setup xfstests and make it run, I=20
haven't yet had time to address the issued in patch 3/3 and making the=20
further changes I've been asked for.

Can you please start with taking only patches 1/3 and 2/3 and dropping 3/3?
I'd really appreciate it because, if you can, I'll see that part of my work=
=20
has already been helpful somewhat and have no need to carry those patches=20
on to the next series :-)=20

The next series will contain everything it has been left out, so that it=20
will complete the conversions to local mappings in fs/btrfs. However I will=
 =20
need some days more to be done with this task.

I'd like to share the output of xfstests on "compress" group + test 150=20
(which is not in that group, although it is the test that both you and=20
Christoph ran and which seems to be the only one failing).
=20
tweed32:/usr/lib/xfstests # ./check -g compress
=46STYP         -- btrfs
PLATFORM      -- Linux/i686 tweed32 5.18.0-torvalds-debug-x86_32+ #7 SMP=20
PREEMPT_DYNAMIC Sat Jun 4 23:47:27 CEST 2022
MKFS_OPTIONS  -- /dev/loop1
MOUNT_OPTIONS -- /dev/loop1 /mnt/scratch

btrfs/024 2s ...  6s
btrfs/026 5s ...  8s
btrfs/037 3s ...  5s
btrfs/038 3s ...  6s
btrfs/041 3s ...  5s
btrfs/062        39s
btrfs/063        21s
btrfs/067        34s
btrfs/068        12s
btrfs/070       [not run] btrfs and this test needs 5 or more disks in=20
SCRATCH_DEV_POOL
btrfs/071       [not run] btrfs and this test needs 5 or more disks in=20
SCRATCH_DEV_POOL
btrfs/072        37s
btrfs/073        22s
btrfs/074        39s
btrfs/076 2s ...  2s
btrfs/103 3s ...  3s
btrfs/106 3s ...  3s
btrfs/109 2s ...  3s
btrfs/113 3s ...  3s
btrfs/138 47s ...  48s
btrfs/149 3s ...  3s
btrfs/183 3s ...  3s
btrfs/205 3s ...  4s
btrfs/234 4s ...  5s
btrfs/246 3s ...  2s
btrfs/251 2s ...  3s
Ran: btrfs/024 btrfs/026 btrfs/037 btrfs/038 btrfs/041 btrfs/062 btrfs/063=
=20
btrfs/067 btrfs/068 btrfs/070 btrfs/071 btrfs/072 btrfs/073 btrfs/074=20
btrfs/076 btrfs/103 btrfs/106 btrfs/109 btrfs/113 btrfs/138 btrfs/149=20
btrfs/183 btrfs/205 btrfs/234 btrfs/246 btrfs/251
Not run: btrfs/070 btrfs/071
Passed all 26 tests

tweed32:/usr/lib/xfstests # ./check tests/btrfs/150
=46STYP         -- btrfs
PLATFORM      -- Linux/i686 tweed32 5.18.0-torvalds-debug-x86_32+ #7 SMP=20
PREEMPT_DYNAMIC Sat Jun 4 23:47:27 CEST 2022
MKFS_OPTIONS  -- /dev/loop1
MOUNT_OPTIONS -- /dev/loop1 /mnt/scratch

btrfs/150 2s ...  2s
Ran: btrfs/150
Passed all 1 tests

tweed32:/usr/lib/xfstests # cat results/btrfs/150.dmesg
[ 2461.321352] run fstests btrfs/150 at 2022-06-05 16:11:18
[ 2461.718527] BTRFS: device fsid 9337d043-0ca4-4890-b294-7e9505ee13b9=20
devid 1 transid 6 /dev/loop1 scanned by systemd-udevd (31060)
[ 2461.721721] BTRFS: device fsid 9337d043-0ca4-4890-b294-7e9505ee13b9=20
devid 2 transid 6 /dev/loop2 scanned by mkfs.btrfs (31508)
[ 2461.730540] BTRFS info (device loop1): flagging fs with big metadata=20
feature
[ 2461.730543] BTRFS info (device loop1): use zlib compression, level 3
[ 2461.730544] BTRFS info (device loop1): using free space tree
[ 2461.730545] BTRFS info (device loop1): has skinny extents
[ 2461.739677] BTRFS info (device loop1): checking UUID tree
[ 2461.916511] BTRFS info (device loop1): flagging fs with big metadata=20
feature
[ 2461.916515] BTRFS info (device loop1): using free space tree
[ 2461.916516] BTRFS info (device loop1): has skinny extents

Please let me know if you require further tests on patches 1/3 and 2/3 and=
=20
on the next series.

Thanks,

=46abio

P.S.: The rest of this message has some details about the kernel and the=20
CPU and memory of the VM these tests have been run on. I suppose these=20
stats are not so much interesting, so feel free to skip them :-)

tweed32:/usr/lib/xfstests # uname -a
Linux tweed32 5.18.0-torvalds-debug-x86_32+ #7 SMP PREEMPT_DYNAMIC Sat Jun=
=20
4 23:47:27 CEST 2022 i686 athlon i386 GNU/Linux

tweed32:/usr/lib/xfstests # cat /proc/cpuinfo=20
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : QEMU Virtual CPU version 2.5+
stepping        : 3
microcode       : 0x1000065
cpu MHz         : 3699.978
physical id     : 0
siblings        : 1
core id         : 0
cpu cores       : 1
apicid          : 0
initial apicid  : 0
fdiv_bug        : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 4
wp              : yes
flags           : fpu de pse tsc msr pae mce cx8 apic sep pge cmov pat mmx=
=20
fxsr sse sse2 cpuid tsc_known_freq pni x2apic hypervisor vmmcall
bugs            : fxsave_leak sysret_ss_attrs spectre_v1 spectre_v2=20
spec_store_bypass
bogomips        : 7402.28
clflush size    : 32
cache_alignment : 32
address sizes   : 36 bits physical, 32 bits virtual
power management:

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : QEMU Virtual CPU version 2.5+

OK, no need to go on with the other CPUs.=20
The total amount of virtual CPU is 4.=20

tweed32:/usr/lib/xfstests # cat /proc/meminfo=20
MemTotal:        4011272 kB
MemFree:         2949956 kB
MemAvailable:    3148368 kB
Buffers:           15700 kB
Cached:           298640 kB
SwapCached:            0 kB
Active:           115992 kB
Inactive:         727008 kB
Active(anon):      21300 kB
Inactive(anon):   538392 kB
Active(file):      94692 kB
Inactive(file):   188616 kB
Unevictable:        3088 kB
Mlocked:               0 kB
HighTotal:       3286900 kB <- Highmem looks enabled properly
HighFree:        2436812 kB
LowTotal:         724372 kB
LowFree:          513144 kB
SwapTotal:       2098152 kB
SwapFree:        2094536 kB
Dirty:               188 kB
Writeback:             0 kB
AnonPages:        531784 kB
Mapped:           218340 kB
Shmem:             31032 kB
KReclaimable:      63896 kB
Slab:             181828 kB
SReclaimable:      63896 kB
SUnreclaim:       117932 kB
KernelStack:        4280 kB
PageTables:        15992 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:     4103788 kB
Committed_AS:    4012104 kB
VmallocTotal:     122880 kB
VmallocUsed:        1468 kB
VmallocChunk:          0 kB
Percpu:             6304 kB
HugePages_Total:       0
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB
Hugetlb:               0 kB
DirectMap4k:      907256 kB
DirectMap2M:           0 kB


