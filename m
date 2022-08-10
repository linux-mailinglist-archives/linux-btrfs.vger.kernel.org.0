Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23F558F0AF
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Aug 2022 18:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbiHJQqL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Aug 2022 12:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233075AbiHJQp6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Aug 2022 12:45:58 -0400
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4254D18E04;
        Wed, 10 Aug 2022 09:45:48 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 5AA815808B4;
        Wed, 10 Aug 2022 12:35:55 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Wed, 10 Aug 2022 12:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1660149355; x=1660152955; bh=a5G2IQ23cL
        Cu11/Dp61pjDw8jpOTjVuQZnVVwZuO120=; b=E5rcuw1Lzya7Hd9QgncERZJ+DM
        3erv7Qs5pOlJ3aUk2u5R1Drx14Ej4xg9OFUX7RDcCfNpYFT/me+V7Ihsez/rdFfB
        +56KLWTrqZBZcsPoDnfBY8reNZ+iyqRghhF7py4WzVd5FHuRo/O+nOH0ZM7uInAs
        79QkukhEk6Ny3ntzeYWXr7f2B2+h1o0h/SiFTN5ubuJ6yshvbpm3mAA1368E8GLB
        xEEGHdGJDiL+yfTJ64cNKY7TXY9jWUfGNJYymA5wNTJdMtf58p2Jmp32dclTOSzR
        igoVEauuJ1Vp8M4cHOlVB19/ThpVOgog8r4iRdsdaHV/JSrby2HfJsjMN9/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1660149355; x=
        1660152955; bh=a5G2IQ23cLCu11/Dp61pjDw8jpOTjVuQZnVVwZuO120=; b=i
        QAlnvmltaI0+qqHZDEFRzJWpwhuxxw7oRyzuJbZUTBNRthP/6TGX5EtwfuZp0nFp
        KLvyN2iz8RWxhBe6hLittmTZXZL2cKVFyQKVgItsCQYXl/dOytlP7qTebCIQP3v8
        j18DXXOY9Sa9EZGKh/8dd41dPZPMNUDYzhpRVoZwgdfvXLjL6sUgm9mKqEzpUEtU
        +NWZfGeM+UmLOHUYtRVHhA6jW/G9kvIu/MAyWU/YsUmGHQU4AMF+ruR8lbeeyH5N
        6ohQGDpy0yjJlZWdBXkHNydNje37EwzzYgkBId7tOlHxt9saKkHo4u2szgHz5ivR
        xEb22wBUL6ybtSGiGwjkQ==
X-ME-Sender: <xms:at7zYihx_unb8Y37UslQb4rHWqNmFqyKW6Xqie9-5BQ9TdhFf6BIXQ>
    <xme:at7zYjA61oOTOvUCq0Ik4EkLyFhQ0Oiqf-im02yPtZcw78osMtmD2Um4Et1SJbTRW
    wbHLfMmxYt7p6dcyLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegvddguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpefofgggkfffhffvvefu
    tgesthdtredtreertdenucfhrhhomhepfdevhhhrihhsucfouhhrphhhhidfuceolhhish
    htshestgholhhorhhrvghmvgguihgvshdrtghomheqnecuggftrfgrthhtvghrnhepffei
    gfefgeefleejfedtudelieetfefhtefhteejkefhtdevtdeufeffffdvteelnecuffhomh
    grihhnpehhthhtphgujhhouhhrnhgrlhgurghuughithgurghnughpohhsthhgrhgvshhq
    lhdrihhopdhgohhoghhlvgdrtghomhdpkhgvrhhnvghlrdhorhhgpdhkvghrnhgvlhdrug
    hknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhi
    shhtshestgholhhorhhrvghmvgguihgvshdrtghomh
X-ME-Proxy: <xmx:at7zYqE-HtauFBCyQ9yJuM4ehPc1mXFdvQWtu1wf5fF_im_u0VIj4A>
    <xmx:at7zYrS8dPYG12zhatdeHSkEgAYfo36uF9UmvRoWZ6qLARhaicMLWQ>
    <xmx:at7zYvzUcRunktnbi1VaVsyMdbCty0n-7JoscqAxHhEsWhTVZNbSkQ>
    <xmx:a97zYq8FLEaBP3xE5IHCoY-YAJ7q5K6Ngc_M9zmPRtT9l2DrIw77-w>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C62691700082; Wed, 10 Aug 2022 12:35:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-811-gb808317eab-fm-20220801.001-gb808317e
Mime-Version: 1.0
Message-Id: <e38aa76d-6034-4dde-8624-df1745bb17fc@www.fastmail.com>
Date:   Wed, 10 Aug 2022 12:35:34 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>,
        Linux-RAID <linux-raid@vger.kernel.org>,
        linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     "Josef Bacik" <josef@toxicpanda.com>
Subject: stalling IO regression in linux 5.12
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

CPU: Intel E5-2680 v3
RAM: 128 G
02:00.0 RAID bus controller [0104]: Broadcom / LSI MegaRAID SAS-3 3108 [Invader] [1000:005d] (rev 02), using megaraid_sas driver
8 Disks: TOSHIBA AL13SEB600


The problem exhibits as increasing load, increasing IO pressure (PSI), and actual IO goes to zero. It never happens on kernel 5.11 series, and always happens after 5.12-rc1 and persists through 5.18.0. There's a new mix of behaviors with 5.19, I suspect the mm improvements in this series might be masking the problem.

The workload involves openqa, which spins up 30 qemu-kvm instances, and does a bunch of tests, generating quite a lot of writes: qcow2 files, and video in the form of many screenshots, and various log files, for each VM. These VMs are each in their own cgroup. As the problem begins, I see increasing IO pressure, and decreasing IO, for each qemu instance's cgroup, and the cgroups for httpd, journald, auditd, and postgresql. IO pressure goes to nearly ~99% and IO is literally 0.

The problem left unattended to progress will eventually result in a completely unresponsive system, with no kernel messages. It reproduces in the following configurations, the first two I provide links to full dmesg with sysrq+w:

btrfs raid10 (native) on plain partitions [1]
btrfs single/dup on dmcrypt on mdadm raid 10 and parity raid [2]
XFS on dmcrypt on mdadm raid10 or parity raid

I've started a bisect, but for some reason I haven't figured out I've started getting compiled kernels that don't boot the hardware. The failure is very early on such that the UUID for the root file system isn't found, but not much to go on as to why.[3] I have tested the first and last skipped commits in the bisect log below, they successfully boot a VM but not the hardware.

Anyway, I'm kinda stuck at this point trying to narrow it down further. Any suggestions? Thanks.

[1] btrfs raid10, plain partitions
https://drive.google.com/file/d/1-oT3MX-hHYtQqI0F3SpgPjCIDXXTysLU/view?usp=sharing

[2] btrfs single/dup, dmcrypt, mdadm raid10
https://drive.google.com/file/d/1m_T3YYaEjBKUROz6dHt5_h92ZVRji9FM/view?usp=sharing

[3] 
$ git bisect log
git bisect start
# status: waiting for both good and bad commits
# bad: [c03c21ba6f4e95e406a1a7b4c34ef334b977c194] Merge tag 'keys-misc-20210126' of git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs
git bisect bad c03c21ba6f4e95e406a1a7b4c34ef334b977c194
# status: waiting for good commit(s), bad commit known
# good: [f40ddce88593482919761f74910f42f4b84c004b] Linux 5.11
git bisect good f40ddce88593482919761f74910f42f4b84c004b
# bad: [df24212a493afda0d4de42176bea10d45825e9a0] Merge tag 's390-5.12-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
git bisect bad df24212a493afda0d4de42176bea10d45825e9a0
# good: [82851fce6107d5a3e66d95aee2ae68860a732703] Merge tag 'arm-dt-v5.12' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect good 82851fce6107d5a3e66d95aee2ae68860a732703
# good: [99f1a5872b706094ece117368170a92c66b2e242] Merge tag 'nfsd-5.12' of git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
git bisect good 99f1a5872b706094ece117368170a92c66b2e242
# bad: [9eef02334505411667a7b51a8f349f8c6c4f3b66] Merge tag 'locking-core-2021-02-17' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad 9eef02334505411667a7b51a8f349f8c6c4f3b66
# bad: [9820b4dca0f9c6b7ab8b4307286cdace171b724d] Merge tag 'for-5.12/drivers-2021-02-17' of git://git.kernel.dk/linux-block
git bisect bad 9820b4dca0f9c6b7ab8b4307286cdace171b724d
# good: [bd018bbaa58640da786d4289563e71c5ef3938c7] Merge tag 'for-5.12/libata-2021-02-17' of git://git.kernel.dk/linux-block
git bisect good bd018bbaa58640da786d4289563e71c5ef3938c7
# skip: [203c018079e13510f913fd0fd426370f4de0fd05] Merge branch 'md-next' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-5.12/drivers
git bisect skip 203c018079e13510f913fd0fd426370f4de0fd05
# skip: [49d1ec8573f74ff1e23df1d5092211de46baa236] block: manage bio slab cache by xarray
git bisect skip 49d1ec8573f74ff1e23df1d5092211de46baa236
# bad: [73d90386b559d6f4c3c5db5e6bb1b68aae8fd3e7] nvme: cleanup zone information initialization
git bisect bad 73d90386b559d6f4c3c5db5e6bb1b68aae8fd3e7
# skip: [71217df39dc67a0aeed83352b0d712b7892036a2] block, bfq: make waker-queue detection more robust
git bisect skip 71217df39dc67a0aeed83352b0d712b7892036a2
# bad: [8358c28a5d44bf0223a55a2334086c3707bb4185] block: fix memory leak of bvec
git bisect bad 8358c28a5d44bf0223a55a2334086c3707bb4185
# skip: [3a905c37c3510ea6d7cfcdfd0f272ba731286560] block: skip bio_check_eod for partition-remapped bios
git bisect skip 3a905c37c3510ea6d7cfcdfd0f272ba731286560
# skip: [3c337690d2ebb7a01fa13bfa59ce4911f358df42] block, bfq: avoid spurious switches to soft_rt of interactive queues
git bisect skip 3c337690d2ebb7a01fa13bfa59ce4911f358df42
# skip: [3e1a88ec96259282b9a8b45c3f1fda7a3ff4f6ea] bio: add a helper calculating nr segments to alloc
git bisect skip 3e1a88ec96259282b9a8b45c3f1fda7a3ff4f6ea
# skip: [4eb1d689045552eb966ebf25efbc3ce648797d96] blk-crypto: use bio_kmalloc in blk_crypto_clone_bio
git bisect skip 4eb1d689045552eb966ebf25efbc3ce648797d96


--
Chris Murphy
