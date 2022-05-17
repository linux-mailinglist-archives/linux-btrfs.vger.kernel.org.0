Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC083529AD4
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 09:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235285AbiEQHc3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 03:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiEQHc2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 03:32:28 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE60CB16
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 00:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652772739;
        bh=GfuQnAIizt8IE5u9j5aRB98Uarm3v440Ge/iTWFtd9o=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=ZLptL7uv6x+2LCwIlwtl3pz61i1En6MNFhPPBumNQPBdQdBCcGd+TzUm5Oz1TbrsL
         NAh7IhrqGSoOWjltefYiLBns3Mp/w+/Wyqi5dmAANUJE3DoeG+Ap3TZTOR9xJtc+sU
         Y9HTQRpvqXUy/NNuSbsOHO6L23Npwy0ZeZUvzBko=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MLi8m-1o8OZd0SO0-00HedY; Tue, 17
 May 2022 09:32:19 +0200
Message-ID: <27870f8d-0b6d-f2a4-2b69-c2d001dd0855@gmx.com>
Date:   Tue, 17 May 2022 15:31:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC ONLY 0/8] btrfs: introduce raid-stripe-tree
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <64227525-4507-9a04-942c-e081c6550f69@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <64227525-4507-9a04-942c-e081c6550f69@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7doI14vXxcEOPyQKBPrT3/KlPvHkZywonJLIFWqchzW2p5ChZbh
 e7kkfkXiggZaJoYYZ2qNtuxBXikTG56cvE6j4QSZNL9GtmchmtI43UrANwteNZ51gm23+It
 qBvJNr84D0cOka884lnBqSCW7iRSrDM4u6rDd0hJTuZ5uJ6EnIjBW0LNaiGDrXx0+MyI60I
 b4udPldDi0qez5LNVnbgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pf7o310oFFc=:raXpiDKlul8cZKK3ZnLmCF
 24d3c/0VQQPBUk+1E0pT8pC2qObqBE5BbVsQoYQXJ+qm7NTk5ls+WwjMbCAtN1Mv8UDhba0Mf
 RBJINWnVCEx7JKsW4zmbn4Lkb6A/OEN6ab2C0cihzAwWNoQJfUkBgoGzm8+lqo7r4ho+N7Url
 mK1pYcDGVqR4a/Ombtni9DPi9TkMqHlluLRsbkPG3PrwoI2nLlLm2CkjbOM4JNSEi3DKrLDr2
 On/+jWVxKGHmuVFLrW+icmavlWTFvOulgRGX9gW0+OK0SQNupJkd7jAXpPWv0BpOrE5fTy7h0
 iRWnKKHlHmKWgE0HLx9owmTSJrdN3FZIeYuVvQvfUDvYX2fVi4DL3wN8/6rh1HwvaEfn5ICFt
 ft30lWcNUJ8LDP39iQUMJK6iLHxmJZF2PpiLpbKs00svGJ/Le1XwqggZGBnH8SwbbO0uXkzi6
 lbNYqpAxD8etaEAUO3e92vLJbkMiBL5d7qIKDQfE7G7LOQ2dIuyTexFR93ophxxFoz4VQM2td
 hY07rJkaiWMfP9pfGnLkpYKSFd3cmF75VVj/RfLpYpeDCFCO6znkCc8GOTx1J3LU5bnXxRSI8
 fWW+aWocTZ/CKZBWgNAF+K75iMEgwTHcR+ArZf2e58dL0q9PTWnx3pqfA8TeGLVfBInAXS8KJ
 zLWTC/+7530U/5TnAKyQK1m85TyN6Khkq79lSqn/hLCr3EzfT5w/sMjw2P4r1OrQI7D6hKAWU
 eWmjomE8lq1nqonlljGQzWhUGDqBMXu3GLvrXd26lH2T1b2YX2MFNBddAhvc7be7OYhGJdWcz
 8S3hpPGZIZVIgUKnHIKKaSlIqPQj9DWndC45qt05ARnjD8Mh9fS88yvjlxPuk/PNO8d9qEQrZ
 uRSAhmQJkfOhp9MU5NbDBzAQG4sEdYFpFbJbqxO3k5bwxErKHPg/xZvj0R0VsOfxo8qoITZXJ
 /mkQuFVxkqDTjip84kMHAxtN0gHgvlVCgf3AfPRFVt3j00sBcVYKnTQyYqT/e8dEevKPucf5D
 3GRMZ+WyYbgT/JhcCFDY647ASlkpngs7M5Qmkq9+N8ujmtHZGiZ/21cvegttzIFJx1e2nrFkx
 DuaciMt4Qjpzzs34rRiU6bUmT+vNUqtCmkPsmbIn8EIotbYNU4GXvXrzQ==
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/17 15:23, Nikolay Borisov wrote:
>
>
> On 16.05.22 =D0=B3. 17:31 =D1=87., Johannes Thumshirn wrote:
>> Introduce a raid-stripe-tree to record writes in a RAID environment.
>>
>> In essence this adds another address translation layer between the
>> logical
>> and the physical addresses in btrfs and is designed to close two gaps.
>> The
>> first is the ominous RAID-write-hole we suffer from with RAID5/6 and th=
e
>> second one is the inability of doing RAID with zoned block devices due
>> to the
>> constraints we have with REQ_OP_ZONE_APPEND writes.
>>
>> Thsi is an RFC/PoC only which just shows how the code will look like
>> for a
>> zoned RAID1. Its sole purpose is to facilitate design reviews and is no=
t
>> intended to be merged yet. Or if merged to be used on an actual
>> file-system.
>>
>> Johannes Thumshirn (8):
>> =C2=A0=C2=A0 btrfs: add raid stripe tree definitions
>> =C2=A0=C2=A0 btrfs: move btrfs_io_context to volumes.h
>> =C2=A0=C2=A0 btrfs: read raid-stripe-tree from disk
>> =C2=A0=C2=A0 btrfs: add boilerplate code to insert raid extent
>> =C2=A0=C2=A0 btrfs: add code to delete raid extent
>> =C2=A0=C2=A0 btrfs: add code to read raid extent
>> =C2=A0=C2=A0 btrfs: zoned: allow zoned RAID1
>> =C2=A0=C2=A0 btrfs: add raid stripe tree pretty printer
>>
>> =C2=A0 fs/btrfs/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
>> =C2=A0 fs/btrfs/ctree.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0 fs/btrfs/ctree.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 29 ++++
>> =C2=A0 fs/btrfs/disk-io.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 12 ++
>> =C2=A0 fs/btrfs/extent-tree.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 9 ++
>> =C2=A0 fs/btrfs/file.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 -
>> =C2=A0 fs/btrfs/print-tree.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 21 +++
>> =C2=A0 fs/btrfs/raid-stripe-tree.c=C2=A0=C2=A0=C2=A0=C2=A0 | 251 ++++++=
++++++++++++++++++++++++++
>> =C2=A0 fs/btrfs/raid-stripe-tree.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 39 +=
++++
>> =C2=A0 fs/btrfs/volumes.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 44 +++++-
>> =C2=A0 fs/btrfs/volumes.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 93 ++++++------
>> =C2=A0 fs/btrfs/zoned.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 39 +++++
>> =C2=A0 include/uapi/linux/btrfs.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 1 +
>> =C2=A0 include/uapi/linux/btrfs_tree.h |=C2=A0 17 +++
>> =C2=A0 14 files changed, 509 insertions(+), 50 deletions(-)
>> =C2=A0 create mode 100644 fs/btrfs/raid-stripe-tree.c
>> =C2=A0 create mode 100644 fs/btrfs/raid-stripe-tree.h
>>
>
>
> So if we choose to go with raid stripe tree this means we won't need the
> raid56j code that Qu is working on ? So it's important that these two
> work streams are synced so we don't duplicate effort, right?

I believe the stripe tree is going to change the definition of RAID56.

It's no longer strict RAID56, as it doesn't contain the fixed device
rotation, thus it's kinda between RAID4 and RAID5.

Personally speaking, I think both features can co-exist, especially the
raid56 stripe tree may need extra development and review, since the
extra translation layer is a completely different monster when comes to
RAID56.

Don't get me wrong, I like stripe-tree too, the only problem is it's
just too new, thus we may want a backup plan.

Thanks,
Qu

