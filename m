Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B999850EC34
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Apr 2022 00:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbiDYWlt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Apr 2022 18:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234711AbiDYWlr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Apr 2022 18:41:47 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA89641FA9
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Apr 2022 15:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650926315;
        bh=z04m16JU1eiR2Q2n03yxPFwuKoPS7yPFvfZafam9BvE=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=SNkUh/dImtJ8f5oV/Ym3ETgLvLE3dacYfrK/T9PpkcLSEAfb83n5396yrhCmJfCmC
         9ygzWEjylrmtAEnwtKwBoNF8Y2xckYNsOjdyHy30qaQbstHI+Nkvfhp41DLt9UMvZR
         8bXD0artFfdf4X/F2MXO1K/Mkf3Qx82EHgfxfviQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MAwbp-1ncDaN0Zdh-00BHAX; Tue, 26
 Apr 2022 00:38:35 +0200
Message-ID: <e0739e20-c693-7bd8-4a09-343a215c044d@gmx.com>
Date:   Tue, 26 Apr 2022 06:38:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 0/8] btrfs-progs: add RAID56 rebuild ability at read time
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1649162174.git.wqu@suse.com>
 <20220411150149.GP15609@twin.jikos.cz> <20220425162913.GP18596@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220425162913.GP18596@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GisdZ1/T1ajWQbbuhTWKvOsPoiInsixZ7ajYZNyM8QPvGz+eH9+
 ZAdom4UYj1CvAV1rURP632eAP8GSkU5GGqAiRUITWHIXHeRGhLGFvrBR8U9URjzQsITEYdm
 larFdtiOPuy9UMjvu260ZOa4HHy5HCbTMLb7vjCDkPSOS+0/IG6dWL61mgPa02hPWAlKS8S
 O3pk/t0vjBgDHBIMtaZEg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UMEMn4li+ZQ=:gI1ZzbuvgFWbm6hs1qgD1S
 n1EGKU7mDVUazbuRcyxgZrh2vU/UeO9HUtXsIcwYX7jztVONK3MP4kmMJ2vYv8UR2ZqL+hKqa
 X/GdOJ8YOEjTFDeUZmXtKGzWt8U2IU1VqpYuFZc0ttV9BnBAyrAooqJZV1uNDeQNqothmPn96
 5FKvzccvP+28XJPoZZ6NFNYDo2WPU78WiqVtIq+7dmbu3qX4LxQ7AWXHa+7gxHfd1EVM/Oid3
 L74M62Dl5dKbiaCdgNw7i/pBgEkdwXVm0EhCnvh+McWO5l5jsYCISaiR77tdlnEFDBSMg4l1G
 2gOu7LR173cNDVDP0ad/Lf38/L34viwuhVTKE/LEj7oHQpEE4EViUfRGDFP66F9dYQg2ROH3T
 mymgwyanYZ58I7z1HA2YbOD+AzGGtPd1xzYWQw6PebYmQJ30XgcVEjWGmrr0l27ZOXghh3A1j
 5uV//T9L29Cfzcov0tw6gM+MFXZV6e32ulH60t/rx14ZzznwIlGvxgJ7iJRLwxCSaK5jw8LDj
 V3/55txpghasqv3AXKv7xrPnx/tHBlfZvthxcXrq81WCWK/xJrWfiT1BXtTb3r2nl6eIjhcrA
 RV/HoEd1ITOxXhIg6ic4xJ5D96B0dikHeP9nmGD7ZRth6RDLmorMKqnOYFtM1J9IbZyfioxLK
 M2LfTdkxrClblg5Zvg90epA4rS78HKSWDo7i7tPVQBAGrMOzW2jOhkTiQc9fVb97m5d05vEIZ
 IiOzzUINDqFeBFmk0KS0uB50RqvVBfogSfZYORoRBTnPyp7MGVf0oVx2K9o3A6TDR/hFWW6mP
 3Z6SEJvKV/IZZ96YIdMPIAo9OC1WAg8IIPf6RqQGOZhhvCKAfDpWmlUVtn64SKpHZ43H3B1Kj
 XIe5fCzWNbq9JhRGUKgCrSfcnLYsQ3cR86kws+SkHHbtmf+8FvlIEWWZuupSvb2iCRsXDh9tQ
 krGeBxEWqVidKMzlH2yHJWJeBLpg1OTXzbzw9PTgNV4zx3pDb/t0hoFB2UbaIFp819yxCDa8p
 US0pWd3xXvZ/vgfDish70WisrYVXfso0qpdOkkAD5w9q1WMTUMmTVoGIJiBJFntuvFsI8R//0
 JOlbJvN/dn2GFM=
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/26 00:29, David Sterba wrote:
> On Mon, Apr 11, 2022 at 05:01:49PM +0200, David Sterba wrote:
>> On Tue, Apr 05, 2022 at 08:48:22PM +0800, Qu Wenruo wrote:
>>> This branch can be fetched from github:
>>> https://github.com/adam900710/btrfs-progs/tree/raid56_rebuild
>>
>> The mkfs tests fail in 001 with the following last command:
>>
>> =3D=3D=3D=3D=3D=3D RUN CHECK root_helper .../mkfs.btrfs -f -d raid5 -m =
raid5 /dev/loop0 /dev/loop1 /dev/loop2 /dev/loop3
>> WARNING: RAID5/6 support has known problems is strongly discouraged
>>           to be used besides testing or evaluation.
>>
>> kernel-shared/transaction.c:155: __commit_transaction: BUG_ON `ret` tri=
ggered, value 65536
>> .../mkfs.btrfs(__commit_transaction+0x197)[0x43a107]
>> /...mkfs.btrfs(btrfs_commit_transaction+0x13b)[0x43a26b]
>> /...mkfs.btrfs(main+0x174b)[0x40f68d]
>> /lib64/libc.so.6(+0x2d540)[0x7f969b5ea540]
>> /lib64/libc.so.6(__libc_start_main+0x7c)[0x7f969b5ea5ec]
>> /...mkfs.btrfs(_start+0x25)[0x40d965]
>> /...tests/common: line 540: 29172 Aborted                 sudo -n "$@"
>> failed: root_helper .../mkfs.btrfs -f -d raid5 -m raid5 /dev/loop0 /dev=
/loop1 /dev/loop2 /dev/loop3
>> test failed for case 001-basic-profiles
>
> It's caused by patch [PATCH 4/8] btrfs-progs: use write_data_to_disk()
> to replace write_extent_to_disk()

That's a known one, I forgot to change the return value back to 0 for
write_extent_to_disk().

Do I need to update the whole series or just send an update based on this?

Thanks,
Qu
