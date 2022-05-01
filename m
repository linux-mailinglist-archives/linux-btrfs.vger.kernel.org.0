Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB1E5161D4
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 May 2022 06:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238826AbiEAE4g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 May 2022 00:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiEAE4f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 May 2022 00:56:35 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84C4424B7
        for <linux-btrfs@vger.kernel.org>; Sat, 30 Apr 2022 21:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651380785;
        bh=w5BIn7BYwoqVcVh6NbKNb672OGOJZjLrF0lgoVU2rHE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=krDiFw8Zzy4TtOVUWWsE1Zn/GqEkD9geBpEvd31h48ZroyNEVHTVEJIr5/mjQUADU
         nTuQ43wwYs3LHbeF5+wWfpjQBJ40IheDnx2i0Tk8A3S2aW/dKKV/5fz4LrFYLSkt7s
         pUpHzPKte2/1kCm1XbuHrkaRxdUpAZH8ssiVcXFU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MRmfi-1nHzCM1BHe-00TAry; Sun, 01
 May 2022 06:53:05 +0200
Message-ID: <6dba9162-c64d-2d27-12eb-d48ac6a4ac8a@gmx.com>
Date:   Sun, 1 May 2022 12:53:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 05/10] btrfs: defer I/O completion based on the
 btrfs_raid_bio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220429143040.106889-1-hch@lst.de>
 <20220429143040.106889-6-hch@lst.de>
 <4e93a857-43f2-9e67-9ef8-4db00edd2f6c@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <4e93a857-43f2-9e67-9ef8-4db00edd2f6c@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fILdEV2DUyxc+W5HU0bz3JSYV3PI6/D2mOMKePVFSgZkdbuq++G
 mhW/WeoDpUofhqunfkWHPmbwt9CBLnPWLXcH3DeR6/kP1V8fPkEBHQDyXgCe7JBv63qLn50
 /Fklp53tovURYUWOu48H9oP0ftKN06OA2A68RP8v1GFGTjnWIC+1UoqfPC3tHTv1nV2Apoz
 jr6NZ+EJkNtk0o7CU+YvA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JQeynLrjmoc=:DPiNEXuon8avLKHZTGZ30b
 6/vwP+RU/40wds0vrwg32v+AcnnokhIhozgc0WJEysIlvMrB6lreANpX1oG4wABhmFc0S2UDw
 s31El1FYpjw/dEAzz0XlSITkYUFM5Vzbkw2ESOmVs0RLX1vqnU2y00SeWtIcZtww+hU009LsZ
 guVKulUuEO4Q9OxMeb7NcozFSz8JWxruVhL/HMEN1AA8SKDXMuDhAZ42ZBdXB3TS4B4FMOZB7
 0Y6QXV4mq42OWHc7DK7lzeRM3KXPkWIn2AA1ZfZRxAt49MkbZd+SiKiqbBtu0Z+Nhy97FhhO0
 umzabqYxL606ieZn1GNPArqMbnhSfTYKil0Re5vu+FHPjTjrTq0qI2yUTl+vKIBnpgnbLz0kQ
 0BtjAepw2Qb8VZxxBx26DUkZPwVuVuqzFP5Py8Ewt036f8/YC9ZR3w0mVOONK8SgD1o1byeaV
 MB3W+DXioq09NT7wRh+QrqrJfNTboWCQ6/r67yrhq9uI9WvN6Q0q6Tiq29sH86X135tn6Hf2w
 O9ZifwBocenlM9EZrEOqmVSz3ex/Z8LL7JfOEoJJqQ1YYFNGmQrQ7itFH0r1NaYvQYBiaxZlX
 /No84NxFXv2SqIXEzplk0+OZumIkkUDP91Uj0PYWWaCDBp/OUPCM20tNGXtbt0E3/LojrIFVe
 ZOKlSFSL1xb55LC7LqhRlJiNahGe2Yp6LTb/F+/nU/qRK0CQJcYpCG/ue9Fwt/BUUVDo8Mqvc
 NfwAVgUEvB8jyBgeIrJkOJ46TrlnqQweHhfBPGM3odKX+8ZARMbLdoJf9CSOLOAkXW0MHvXGa
 oyzQN1fkzFfOWGHQot60Xg3Rmdq0SrljeeapuVzu6bb+RbDebLHfjABIAuLcj/87AK2TtVMfa
 YCjbBA3tOF9JymRjRRz8eKZkt/es6mGpQ4wavTI4jrGmDO/Sg+h67UN9QA8M4Th09jX3rolC4
 d0YpvQDsrD9PCC00Ckl21gonODBCHy1p3LlJUrV2YBaQxtF9BRkU2affTwBs55cjhfr6wf0Pp
 s4406NiTOQL+DDjyMn+sBfyhVFSxoAJsPN2SXiTnWqW+pRreFiquMGGmS5KOeWZXO/kYZ+qo7
 cMfT4dLnoGFySU=
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/1 12:40, Qu Wenruo wrote:
>
>
> On 2022/4/29 22:30, Christoph Hellwig wrote:
>> Instead of attaching a an extra allocation an indirect call to each
>> low-level bio issued by the RAID code, add a work_struct to struct
>> btrfs_raid_bio and only defer the per-rbio completion action.=C2=A0 The
>> per-bio action for all the I/Os are trivial and can be safely done
>> from interrupt context.
>>
>> As a nice side effect this also allows sharing the boilerplate code
>> for the per-bio completions
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>
> It looks like this patch is causing test failure in btrfs/027, at least
> for subapge (64K page size, 4K sectorsize) cases.

Also confirmed the same hang on the same commit on x86_64 (4K page size
4K sectorsize).

Also 100% reproducible.

Thanks,
Qu

>
> Reproducibility is 100% (4/4 tried).
>
> The hanging sub-test case is the repalcing of a missing device in raid5.
>
> The involved dmesg (including the hanging thread dump) is:
>
> [=C2=A0 276.672541] BTRFS warning (device dm-1): read-write for sector s=
ize
> 4096 with page size 65536 is experimental
> [=C2=A0 276.744316] BTRFS info (device dm-1): checking UUID tree
> [=C2=A0 277.387701] BTRFS info (device dm-1): allowing degraded mounts
> [=C2=A0 277.390314] BTRFS info (device dm-1): using free space tree
> [=C2=A0 277.392108] BTRFS info (device dm-1): has skinny extents
> [=C2=A0 277.393890] BTRFS warning (device dm-1): read-write for sector s=
ize
> 4096 with page size 65536 is experimental
> [=C2=A0 277.420922] BTRFS warning (device dm-1): devid 2 uuid
> 4b67464d-e851-4a88-8765-67b043d4680f is missing
> [=C2=A0 277.432694] BTRFS warning (device dm-1): devid 2 uuid
> 4b67464d-e851-4a88-8765-67b043d4680f is missing
> [=C2=A0 277.648326] BTRFS info (device dm-1): dev_replace from <missing =
disk>
> (devid 2) to /dev/mapper/test-scratch5 started
> [=C2=A0 297.264371] task:btrfs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 state:D stack:=C2=A0=C2=A0=C2=A0 0 pid: 7158 ppid:
>  =C2=A06493 flags:0x0000000c
> [=C2=A0 297.280744] Call trace:
> [=C2=A0 297.282351]=C2=A0 __switch_to+0xfc/0x160
> [=C2=A0 297.284525]=C2=A0 __schedule+0x260/0x61c
> [=C2=A0 297.286959]=C2=A0 schedule+0x54/0xc4
> [=C2=A0 297.288980]=C2=A0 scrub_enumerate_chunks+0x610/0x760 [btrfs]
> [=C2=A0 297.292504]=C2=A0 btrfs_scrub_dev+0x1a0/0x530 [btrfs]
> [=C2=A0 297.306738]=C2=A0 btrfs_dev_replace_start+0x2a4/0x2d0 [btrfs]
> [=C2=A0 297.310418]=C2=A0 btrfs_dev_replace_by_ioctl+0x48/0x84 [btrfs]
> [=C2=A0 297.314026]=C2=A0 btrfs_ioctl_dev_replace+0x1b8/0x210 [btrfs]
> [=C2=A0 297.328014]=C2=A0 btrfs_ioctl+0xa48/0x1a70 [btrfs]
> [=C2=A0 297.330705]=C2=A0 __arm64_sys_ioctl+0xb4/0x100
> [=C2=A0 297.333037]=C2=A0 invoke_syscall+0x50/0x120
> [=C2=A0 297.343237]=C2=A0 el0_svc_common.constprop.0+0x4c/0x100
> [=C2=A0 297.345716]=C2=A0 do_el0_svc+0x34/0xa0
> [=C2=A0 297.347242]=C2=A0 el0_svc+0x34/0xb0
> [=C2=A0 297.348763]=C2=A0 el0t_64_sync_handler+0xa8/0x130
> [=C2=A0 297.350870]=C2=A0 el0t_64_sync+0x18c/0x190
>
> Mind to take a look on that hang?
>
> Thanks,
> Qu
>
>> ---
>> =C2=A0 fs/btrfs/ctree.h=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
>> =C2=A0 fs/btrfs/disk-io.c |=C2=A0 12 ++---
>> =C2=A0 fs/btrfs/disk-io.h |=C2=A0=C2=A0 1 -
>> =C2=A0 fs/btrfs/raid56.c=C2=A0 | 111 ++++++++++++++++++----------------=
-----------
>> =C2=A0 4 files changed, 49 insertions(+), 77 deletions(-)
>>
>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>> index 40a6f61559348..4dd0d4a2e7757 100644
>> --- a/fs/btrfs/ctree.h
>> +++ b/fs/btrfs/ctree.h
>> @@ -853,7 +853,7 @@ struct btrfs_fs_info {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_workqueue *flush_workers;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_workqueue *endio_workers;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_workqueue *endio_meta_worke=
rs;
>> -=C2=A0=C2=A0=C2=A0 struct btrfs_workqueue *endio_raid56_workers;
>> +=C2=A0=C2=A0=C2=A0 struct workqueue_struct *endio_raid56_workers;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct workqueue_struct *rmw_workers;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_workqueue *endio_meta_write=
_workers;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_workqueue *endio_write_work=
ers;
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index 73e12ecc81be1..3c6137734d28c 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -753,14 +753,10 @@ static void end_workqueue_bio(struct bio *bio)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 wq =3D fs_info->endio_meta_write_workers;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else if (end_io_=
wq->metadata =3D=3D BTRFS_WQ_ENDIO_FREE_SPACE)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 wq =3D fs_info->endio_freespace_worker;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else if (end_io_wq->metadat=
a =3D=3D BTRFS_WQ_ENDIO_RAID56)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wq =
=3D fs_info->endio_raid56_workers;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 wq =3D fs_info->endio_write_workers;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (end_io_wq->metadata =3D=
=3D BTRFS_WQ_ENDIO_RAID56)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wq =
=3D fs_info->endio_raid56_workers;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else if (end_io_wq->metadat=
a)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (end_io_wq->metadata)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 wq =3D fs_info->endio_meta_workers;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 wq =3D fs_info->endio_workers;
>> @@ -2274,7 +2270,8 @@ static void btrfs_stop_all_workers(struct
>> btrfs_fs_info *fs_info)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_destroy_workqueue(fs_info->hipri_w=
orkers);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_destroy_workqueue(fs_info->workers=
);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_destroy_workqueue(fs_info->endio_w=
orkers);
>> -=C2=A0=C2=A0=C2=A0 btrfs_destroy_workqueue(fs_info->endio_raid56_worke=
rs);
>> +=C2=A0=C2=A0=C2=A0 if (fs_info->endio_raid56_workers)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 destroy_workqueue(fs_info->=
endio_raid56_workers);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (fs_info->rmw_workers)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 destroy_workqueu=
e(fs_info->rmw_workers);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_destroy_workqueue(fs_info->endio_w=
rite_workers);
>> @@ -2477,8 +2474,7 @@ static int btrfs_init_workqueues(struct
>> btrfs_fs_info *fs_info)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_alloc_work=
queue(fs_info, "endio-meta-write", flags,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max_=
active, 2);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_info->endio_raid56_workers =3D
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_alloc_workqueue(fs_in=
fo, "endio-raid56", flags,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max_active, 4);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 alloc_workqueue("btrfs-endi=
o-raid56", flags, max_active);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_info->rmw_workers =3D alloc_workqueue=
("btrfs-rmw", flags,
>> max_active);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_info->endio_write_workers =3D
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_alloc_work=
queue(fs_info, "endio-write", flags,
>> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
>> index 9340e3266e0ac..97255e3d7e524 100644
>> --- a/fs/btrfs/disk-io.h
>> +++ b/fs/btrfs/disk-io.h
>> @@ -21,7 +21,6 @@ enum btrfs_wq_endio_type {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BTRFS_WQ_ENDIO_DATA,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BTRFS_WQ_ENDIO_METADATA,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BTRFS_WQ_ENDIO_FREE_SPACE,
>> -=C2=A0=C2=A0=C2=A0 BTRFS_WQ_ENDIO_RAID56,
>> =C2=A0 };
>>
>> =C2=A0 static inline u64 btrfs_sb_offset(int mirror)
>> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
>> index a5b623ee6facd..1a3c1a9b10d0b 100644
>> --- a/fs/btrfs/raid56.c
>> +++ b/fs/btrfs/raid56.c
>> @@ -164,6 +164,9 @@ struct btrfs_raid_bio {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_t stripes_pending;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_t error;
>> +
>> +=C2=A0=C2=A0=C2=A0 struct work_struct end_io_work;
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * these are two arrays of pointers=
.=C2=A0 We allocate the
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * rbio big enough to hold them bot=
h and setup their
>> @@ -1552,15 +1555,7 @@ static void set_bio_pages_uptodate(struct
>> btrfs_raid_bio *rbio, struct bio *bio)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 }
>>
>> -/*
>> - * end io for the read phase of the rmw cycle.=C2=A0 All the bios here=
 are
>> physical
>> - * stripe bios we've read from the disk so we can recalculate the
>> parity of the
>> - * stripe.
>> - *
>> - * This will usually kick off finish_rmw once all the bios are read
>> in, but it
>> - * may trigger parity reconstruction if we had any errors along the wa=
y
>> - */
>> -static void raid_rmw_end_io(struct bio *bio)
>> +static void raid56_bio_end_io(struct bio *bio)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_raid_bio *rbio =3D bio->bi_=
private;
>>
>> @@ -1571,23 +1566,34 @@ static void raid_rmw_end_io(struct bio *bio)
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bio_put(bio);
>>
>> -=C2=A0=C2=A0=C2=A0 if (!atomic_dec_and_test(&rbio->stripes_pending))
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0 if (atomic_dec_and_test(&rbio->stripes_pending))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 queue_work(rbio->bioc->fs_i=
nfo->endio_raid56_workers,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 &rbio->end_io_work);
>> +}
>>
>> -=C2=A0=C2=A0=C2=A0 if (atomic_read(&rbio->error) > rbio->bioc->max_err=
ors)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto cleanup;
>> +/*
>> + * End io handler for the read phase of the rmw cycle.=C2=A0 All the b=
ios
>> here are
>> + * physical stripe bios we've read from the disk so we can
>> recalculate the
>> + * parity of the stripe.
>> + *
>> + * This will usually kick off finish_rmw once all the bios are read
>> in, but it
>> + * may trigger parity reconstruction if we had any errors along the wa=
y
>> + */
>> +static void raid56_rmw_end_io_work(struct work_struct *work)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct btrfs_raid_bio *rbio =3D
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 container_of(work, struct b=
trfs_raid_bio, end_io_work);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (atomic_read(&rbio->error) > rbio->bioc->max_err=
ors) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rbio_orig_end_io(rbio, BLK_=
STS_IOERR);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0 }
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * this will normally call finish_rmw to start=
 our write
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * but if there are any failed stripes we'll r=
econstruct
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * from parity first
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * This will normally call finish_rmw to start=
 our write but if
>> there
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * are any failed stripes we'll reconstruct fr=
om parity first.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 validate_rbio_for_rmw(rbio);
>> -=C2=A0=C2=A0=C2=A0 return;
>> -
>> -cleanup:
>> -
>> -=C2=A0=C2=A0=C2=A0 rbio_orig_end_io(rbio, BLK_STS_IOERR);
>> =C2=A0 }
>>
>> =C2=A0 /*
>> @@ -1662,11 +1668,9 @@ static int raid56_rmw_stripe(struct
>> btrfs_raid_bio *rbio)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * touch it after that.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_set(&rbio->stripes_pending, bios_=
to_read);
>> +=C2=A0=C2=A0=C2=A0 INIT_WORK(&rbio->end_io_work, raid56_rmw_end_io_wor=
k);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while ((bio =3D bio_list_pop(&bio_list))=
) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bio->bi_end_io =3D raid_rmw=
_end_io;
>> -
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_bio_wq_end_io(rbio->b=
ioc->fs_info, bio,
>> BTRFS_WQ_ENDIO_RAID56);
>> -
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bio->bi_end_io =3D raid56_b=
io_end_io;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 submit_bio(bio);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* the actual write will happen once the=
 reads are done */
>> @@ -2108,25 +2112,13 @@ static void __raid_recover_end_io(struct
>> btrfs_raid_bio *rbio)
>> =C2=A0 }
>>
>> =C2=A0 /*
>> - * This is called only for stripes we've read from disk to
>> - * reconstruct the parity.
>> + * This is called only for stripes we've read from disk to
>> reconstruct the
>> + * parity.
>> =C2=A0=C2=A0 */
>> -static void raid_recover_end_io(struct bio *bio)
>> +static void raid_recover_end_io_work(struct work_struct *work)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 struct btrfs_raid_bio *rbio =3D bio->bi_private;
>> -
>> -=C2=A0=C2=A0=C2=A0 /*
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * we only read stripe pages off the disk, set=
 them
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * up to date if there were no errors
>> -=C2=A0=C2=A0=C2=A0=C2=A0 */
>> -=C2=A0=C2=A0=C2=A0 if (bio->bi_status)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fail_bio_stripe(rbio, bio);
>> -=C2=A0=C2=A0=C2=A0 else
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_bio_pages_uptodate(rbio=
, bio);
>> -=C2=A0=C2=A0=C2=A0 bio_put(bio);
>> -
>> -=C2=A0=C2=A0=C2=A0 if (!atomic_dec_and_test(&rbio->stripes_pending))
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0 struct btrfs_raid_bio *rbio =3D
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 container_of(work, struct b=
trfs_raid_bio, end_io_work);
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (atomic_read(&rbio->error) > rbio->bi=
oc->max_errors)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rbio_orig_end_io=
(rbio, BLK_STS_IOERR);
>> @@ -2209,11 +2201,9 @@ static int __raid56_parity_recover(struct
>> btrfs_raid_bio *rbio)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * touch it after that.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_set(&rbio->stripes_pending, bios_=
to_read);
>> +=C2=A0=C2=A0=C2=A0 INIT_WORK(&rbio->end_io_work, raid_recover_end_io_w=
ork);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while ((bio =3D bio_list_pop(&bio_list))=
) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bio->bi_end_io =3D raid_rec=
over_end_io;
>> -
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_bio_wq_end_io(rbio->b=
ioc->fs_info, bio,
>> BTRFS_WQ_ENDIO_RAID56);
>> -
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bio->bi_end_io =3D raid56_b=
io_end_io;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 submit_bio(bio);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> @@ -2582,8 +2572,7 @@ static noinline void finish_parity_scrub(struct
>> btrfs_raid_bio *rbio,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_set(&rbio->stripes_pending, nr_da=
ta);
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while ((bio =3D bio_list_pop(&bio_list))=
) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bio->bi_end_io =3D raid_wri=
te_end_io;
>> -
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bio->bi_end_io =3D raid56_b=
io_end_io;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 submit_bio(bio);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> @@ -2671,24 +2660,14 @@ static void
>> validate_rbio_for_parity_scrub(struct btrfs_raid_bio *rbio)
>> =C2=A0=C2=A0 * This will usually kick off finish_rmw once all the bios =
are read
>> in, but it
>> =C2=A0=C2=A0 * may trigger parity reconstruction if we had any errors a=
long the way
>> =C2=A0=C2=A0 */
>> -static void raid56_parity_scrub_end_io(struct bio *bio)
>> +static void raid56_parity_scrub_end_io_work(struct work_struct *work)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 struct btrfs_raid_bio *rbio =3D bio->bi_private;
>> -
>> -=C2=A0=C2=A0=C2=A0 if (bio->bi_status)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fail_bio_stripe(rbio, bio);
>> -=C2=A0=C2=A0=C2=A0 else
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_bio_pages_uptodate(rbio=
, bio);
>> -
>> -=C2=A0=C2=A0=C2=A0 bio_put(bio);
>> -
>> -=C2=A0=C2=A0=C2=A0 if (!atomic_dec_and_test(&rbio->stripes_pending))
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0 struct btrfs_raid_bio *rbio =3D
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 container_of(work, struct b=
trfs_raid_bio, end_io_work);
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * this will normally call finish_rmw to start=
 our write
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * but if there are any failed stripes we'll r=
econstruct
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * from parity first
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * This will normally call finish_rmw to start=
 our write, but if
>> there
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * are any failed stripes we'll reconstruct fr=
om parity first
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 validate_rbio_for_parity_scrub(rbio);
>> =C2=A0 }
>> @@ -2758,11 +2737,9 @@ static void raid56_parity_scrub_stripe(struct
>> btrfs_raid_bio *rbio)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * touch it after that.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_set(&rbio->stripes_pending, bios_=
to_read);
>> +=C2=A0=C2=A0=C2=A0 INIT_WORK(&rbio->end_io_work, raid56_parity_scrub_e=
nd_io_work);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while ((bio =3D bio_list_pop(&bio_list))=
) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bio->bi_end_io =3D raid56_p=
arity_scrub_end_io;
>> -
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_bio_wq_end_io(rbio->b=
ioc->fs_info, bio,
>> BTRFS_WQ_ENDIO_RAID56);
>> -
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bio->bi_end_io =3D raid56_b=
io_end_io;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 submit_bio(bio);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* the actual write will happen once the=
 reads are done */
