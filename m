Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E75D592E2B
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Aug 2022 13:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbiHOLZ6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Aug 2022 07:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiHOLZ4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Aug 2022 07:25:56 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC41023BEE;
        Mon, 15 Aug 2022 04:25:54 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oNYEC-0003gE-T4; Mon, 15 Aug 2022 13:25:52 +0200
Message-ID: <2004c259-6ec7-76d9-cad6-7c381dbfcf0c@leemhuis.info>
Date:   Mon, 15 Aug 2022 13:25:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: stalling IO regression in linux 5.12
Content-Language: en-US
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux-RAID <linux-raid@vger.kernel.org>,
        linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <e38aa76d-6034-4dde-8624-df1745bb17fc@www.fastmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <e38aa76d-6034-4dde-8624-df1745bb17fc@www.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1660562754;e5363ca9;
X-HE-SMSGID: 1oNYEC-0003gE-T4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[TLDR: I'm adding this regression report to the list of tracked
regressions; all text from me you find below is based on a few templates
paragraphs you might have encountered already already in similar form.]

Hi, this is your Linux kernel regression tracker.

On 10.08.22 18:35, Chris Murphy wrote:
> CPU: Intel E5-2680 v3
> RAM: 128 G
> 02:00.0 RAID bus controller [0104]: Broadcom / LSI MegaRAID SAS-3 3108 [Invader] [1000:005d] (rev 02), using megaraid_sas driver
> 8 Disks: TOSHIBA AL13SEB600
> 
> 
> The problem exhibits as increasing load, increasing IO pressure (PSI), and actual IO goes to zero. It never happens on kernel 5.11 series, and always happens after 5.12-rc1 and persists through 5.18.0. There's a new mix of behaviors with 5.19, I suspect the mm improvements in this series might be masking the problem.
> 
> The workload involves openqa, which spins up 30 qemu-kvm instances, and does a bunch of tests, generating quite a lot of writes: qcow2 files, and video in the form of many screenshots, and various log files, for each VM. These VMs are each in their own cgroup. As the problem begins, I see increasing IO pressure, and decreasing IO, for each qemu instance's cgroup, and the cgroups for httpd, journald, auditd, and postgresql. IO pressure goes to nearly ~99% and IO is literally 0.
> 
> The problem left unattended to progress will eventually result in a completely unresponsive system, with no kernel messages. It reproduces in the following configurations, the first two I provide links to full dmesg with sysrq+w:
> 
> btrfs raid10 (native) on plain partitions [1]
> btrfs single/dup on dmcrypt on mdadm raid 10 and parity raid [2]
> XFS on dmcrypt on mdadm raid10 or parity raid
> 
> I've started a bisect, but for some reason I haven't figured out I've started getting compiled kernels that don't boot the hardware. The failure is very early on such that the UUID for the root file system isn't found, but not much to go on as to why.[3] I have tested the first and last skipped commits in the bisect log below, they successfully boot a VM but not the hardware.
> 
> Anyway, I'm kinda stuck at this point trying to narrow it down further. Any suggestions? Thanks.
> 
> [1] btrfs raid10, plain partitions
> https://drive.google.com/file/d/1-oT3MX-hHYtQqI0F3SpgPjCIDXXTysLU/view?usp=sharing
> 
> [2] btrfs single/dup, dmcrypt, mdadm raid10
> https://drive.google.com/file/d/1m_T3YYaEjBKUROz6dHt5_h92ZVRji9FM/view?usp=sharing
> 
> [3] 
> $ git bisect log
> git bisect start
> # status: waiting for both good and bad commits
> # bad: [c03c21ba6f4e95e406a1a7b4c34ef334b977c194] Merge tag 'keys-misc-20210126' of git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs
> git bisect bad c03c21ba6f4e95e406a1a7b4c34ef334b977c194
> # status: waiting for good commit(s), bad commit known
> # good: [f40ddce88593482919761f74910f42f4b84c004b] Linux 5.11
> git bisect good f40ddce88593482919761f74910f42f4b84c004b
> # bad: [df24212a493afda0d4de42176bea10d45825e9a0] Merge tag 's390-5.12-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
> git bisect bad df24212a493afda0d4de42176bea10d45825e9a0
> # good: [82851fce6107d5a3e66d95aee2ae68860a732703] Merge tag 'arm-dt-v5.12' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> git bisect good 82851fce6107d5a3e66d95aee2ae68860a732703
> # good: [99f1a5872b706094ece117368170a92c66b2e242] Merge tag 'nfsd-5.12' of git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
> git bisect good 99f1a5872b706094ece117368170a92c66b2e242
> # bad: [9eef02334505411667a7b51a8f349f8c6c4f3b66] Merge tag 'locking-core-2021-02-17' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect bad 9eef02334505411667a7b51a8f349f8c6c4f3b66
> # bad: [9820b4dca0f9c6b7ab8b4307286cdace171b724d] Merge tag 'for-5.12/drivers-2021-02-17' of git://git.kernel.dk/linux-block
> git bisect bad 9820b4dca0f9c6b7ab8b4307286cdace171b724d
> # good: [bd018bbaa58640da786d4289563e71c5ef3938c7] Merge tag 'for-5.12/libata-2021-02-17' of git://git.kernel.dk/linux-block
> git bisect good bd018bbaa58640da786d4289563e71c5ef3938c7
> # skip: [203c018079e13510f913fd0fd426370f4de0fd05] Merge branch 'md-next' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-5.12/drivers
> git bisect skip 203c018079e13510f913fd0fd426370f4de0fd05
> # skip: [49d1ec8573f74ff1e23df1d5092211de46baa236] block: manage bio slab cache by xarray
> git bisect skip 49d1ec8573f74ff1e23df1d5092211de46baa236
> # bad: [73d90386b559d6f4c3c5db5e6bb1b68aae8fd3e7] nvme: cleanup zone information initialization
> git bisect bad 73d90386b559d6f4c3c5db5e6bb1b68aae8fd3e7
> # skip: [71217df39dc67a0aeed83352b0d712b7892036a2] block, bfq: make waker-queue detection more robust
> git bisect skip 71217df39dc67a0aeed83352b0d712b7892036a2
> # bad: [8358c28a5d44bf0223a55a2334086c3707bb4185] block: fix memory leak of bvec
> git bisect bad 8358c28a5d44bf0223a55a2334086c3707bb4185
> # skip: [3a905c37c3510ea6d7cfcdfd0f272ba731286560] block: skip bio_check_eod for partition-remapped bios
> git bisect skip 3a905c37c3510ea6d7cfcdfd0f272ba731286560
> # skip: [3c337690d2ebb7a01fa13bfa59ce4911f358df42] block, bfq: avoid spurious switches to soft_rt of interactive queues
> git bisect skip 3c337690d2ebb7a01fa13bfa59ce4911f358df42
> # skip: [3e1a88ec96259282b9a8b45c3f1fda7a3ff4f6ea] bio: add a helper calculating nr segments to alloc
> git bisect skip 3e1a88ec96259282b9a8b45c3f1fda7a3ff4f6ea
> # skip: [4eb1d689045552eb966ebf25efbc3ce648797d96] blk-crypto: use bio_kmalloc in blk_crypto_clone_bio
> git bisect skip 4eb1d689045552eb966ebf25efbc3ce648797d96

Thanks for the report. To be sure below issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
tracking bot:

#regzbot ^introduced v5.11..v5.12-rc1
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply -- ideally with also
telling regzbot about it, as explained here:
https://linux-regtracking.leemhuis.info/tracked-regression/

Reminder for developers: When fixing the issue, add 'Link:' tags
pointing to the report (the mail this one replies to), as explained for
in the Linux kernel's documentation; above webpage explains why this is
important for tracked regressions.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
