Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BF45B1C9C
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Sep 2022 14:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiIHMSw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Sep 2022 08:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbiIHMSs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Sep 2022 08:18:48 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5419D8003F
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Sep 2022 05:18:47 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1279948d93dso23977972fac.10
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Sep 2022 05:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date;
        bh=W+NXDgN0IU1TPrseeSRmaJffUDQL1k13VXLidt8gDmE=;
        b=pLjRyC+zycwF9P7JqN14V/wdcOTFLrzOCY/qeyconpjpIKAZmAOO5XlZUQyS/v40XM
         /G89vZeSTcYBBsyUtaaPXJuReWLuV2hOMOXXFls6m6rWOLOxkbPdbgGC77SfNzxVyYNA
         qahlNGpdIQIVVOpke7+F2aanUy8tasKLitF5X6LWEFVXt+/hCEvtSYnpyoreaM66I1yw
         UXVfIc02kBcCkXtNotQXm9Ef7+XBbPmEFIK2YXx58jwHJwpOl4bxghBeqizgQ7Qy4PD1
         GYhTSPgpAJnZQOXYvG690Kd7Tg9UR23oyKMif/cWloF2cKgKpX/1nJ6dRsElobkT81SC
         Z5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=W+NXDgN0IU1TPrseeSRmaJffUDQL1k13VXLidt8gDmE=;
        b=ojtIXz0E5796glEUGOkAJrllU5tEbNiQoP+u6gUQ3DXTwUSFl61Ue4YX+XeahMSDEE
         Jchxxmv4gnWl5mdCg8TMUJ4hJGpNJe9wgaHSlEZNw+dBr+wJHjxSDpjSF+Dvhw4jPlYY
         nQRz01CLQBbLycin6Y1gySJtYU3eG7/C3H3jUUqfpV618KuQiO8BTsFjxpS9pHyyu6NH
         jqgAddk7zT//z+1ygHZ90so5q7HiNmsVF2WU/IMLffBczJACzHn5wyFey2giE+KX5Msa
         Dq8M6CWeM0pfvESC83NxbV+0ZV55w3H9DEHvES48eLELSyDKkahagbFa+Z8a8r9Kcwed
         mptw==
X-Gm-Message-State: ACgBeo1TVyUI2q3xtQEFZwL0DJLjVCptENoB2Hp3w7bjaO1g+RHa/8w7
        CiT2SOB7WYZ77Yfw1iXhKu/bjcaNeo8yJCCkaJc=
X-Google-Smtp-Source: AA6agR46rl4WqaUz1MSc3puaMsxbtfBvpGbzqZKmGH6guZjHz3tteqR+BPcELhGxrCAp4pnltiZUGg3cf3i4c+Jgmoo=
X-Received: by 2002:a05:6870:538c:b0:11b:e64f:ee1b with SMTP id
 h12-20020a056870538c00b0011be64fee1bmr1641093oan.92.1662639526607; Thu, 08
 Sep 2022 05:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <bf157be545a0ad97897b33be983284a4f63a5e0f.1662618779.git.wqu@suse.com>
 <CAL3q7H5d1mkMwfR-mfT8DydHbfys7_2kMg_xxS5yyrnTPvRHyA@mail.gmail.com> <d5c982b6-b89e-dae0-2aee-dbc7a4e43c1a@gmx.com>
In-Reply-To: <d5c982b6-b89e-dae0-2aee-dbc7a4e43c1a@gmx.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 8 Sep 2022 13:18:10 +0100
Message-ID: <CAL3q7H56iPaXtH0V6SfUGsTvtken5jj_Md54iWwwDXTsq-aREQ@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: don't update the block group item if used bytes
 are the same
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 8, 2022 at 12:41 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2022/9/8 18:31, Filipe Manana wrote:
> > On Thu, Sep 8, 2022 at 7:40 AM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >> [BACKGROUND]
> >>
> >> When committing a transaction, we will update block group items for al=
l
> >> dirty block groups.
> >>
> >> But in fact, dirty block groups don't always need to update their bloc=
k
> >> group items.
> >> It's pretty common to have a metadata block group which experienced
> >> several CoW operations, but still have the same amount of used bytes.
> >>
> >> In that case, we may unnecessarily CoW a tree block doing nothing.
> >>
> >> [ENHANCEMENT]
> >>
> >> This patch will introduce btrfs_block_group::commit_used member to
> >> remember the last used bytes, and use that new member to skip
> >> unnecessary block group item update.
> >>
> >> This would be more common for large fs, which metadata block group can
> >> be as large as 1GiB, containing at most 64K metadata items.
> >>
> >> In that case, if CoW added and the deleted one metadata item near the =
end
> >> of the block group, then it's completely possible we don't need to tou=
ch
> >> the block group item at all.
> >>
> >> [BENCHMARK]
> >>
> >> To properly benchmark how many block group items we skipped the update=
,
> >> I added some members into btrfs_tranaction to record how many times
> >> update_block_group_item() is called, and how many of them are skipped.
> >>
> >> Then with a single line fio to trigger the workload on a newly created
> >> btrfs:
> >>
> >>    fio --filename=3D$mnt/file --size=3D4G --rw=3Drandrw --bs=3D32k --i=
oengine=3Dlibaio \
> >>        --direct=3D1 --iodepth=3D64 --runtime=3D120 --numjobs=3D4 --nam=
e=3Drandom_rw \
> >>        --fallocate=3Dposix
> >
> > And did this improve fio's numbers? Throughput, latency?
> > It's odd to paste a test here and not mention its results. I suppose
> > it didn't make
> > a difference, but even if not, it should be explicitly stated.
>
> Unfortunately that test is run with my extra debugging patch (to show if
> the patch works).
> Thus I didn't take the fio numbers too seriously.
>
> And if I'm going to do a real tests, I'd remove the fallocate, decrease
> the blocksize, and do more loops, and other VM tunings to get a more
> performance orient tests.
>
> Just for reference, here is the script I slightly modified:
>
> fio --filename=3D$mnt/file --size=3D2G --rw=3Drandwrite --bs=3D4k
> --ioengine=3Dlibaio --iodepth=3D64 --runtime=3D300 --numjobs=3D4
> --name=3Drandom_write --fallocate=3Dnone
>
> And with my VM tuned for perf tests (no heavy debug config, dedicated
> SATA SSD, none cache mode, less memory, larger file size).
>
> [BEFORE]
>    WRITE: bw=3D32.3MiB/s (33.9MB/s), 8269KiB/s-8315KiB/s
> (8468kB/s-8515kB/s), io=3D8192MiB (8590MB), run=3D252210-253603msec
>
> [AFTER]
> WRITE: bw=3D31.7MiB/s (33.3MB/s), 8124KiB/s-8184KiB/s (8319kB/s-8380kB/s)=
,
> io=3D8192MiB (8590MB), run=3D256257-258135msec
>
> So in fact it's even worse performance, which I can not explain at all...

That's probably just noise.
Small variations like those are not unusual, especially with multiple jobs.

The idea seems fine to me.
Thanks.

>
> >
> > In this case, less extent tree updates can result in better
> > concurrency for the nocow checks,
> > which need to check the extent tree.
> >
> >>
> >> Then I got 101 transaction committed during that fio command, and a
> >> total of 2062 update_block_group_item() calls, in which 1241 can be
> >> skipped.
> >>
> >> This is already a good 60% got skipped.
> >>
> >> The full analyse can be found here:
> >> https://docs.google.com/spreadsheets/d/e/2PACX-1vTbjhqqqxoebnQM_ZJzSM1=
rF7EY7I1IRbAzZjv19imcDHsVDA7qeA_-MzXxltFZ0kHBjxMA15s2CSH8/pubhtml
> >
> > Not sure if keeping an url to an external source that is not
> > guaranteed to be available "forever" is a good practice.
> > It also doesn't seem to provide any substantial value, as you have
> > already mentioned above some numbers.
> >
> >>
> >> Furthermore, since I have per-trans accounting, it shows that initiall=
y
> >> we have a very low percentage of skipped block group item update.
> >>
> >> This is expected since we're inserting a lot of new file extents
> >> initially, thus the metadata usage is going to increase.
> >>
> >> But after the initial 3 transactions, all later transactions are have =
a
> >
> > "are have" -> "have"
> >
> >> very stable 40~80% skip rate, mostly proving the patch is working.
> >>
> >> Although such high skip rate is not always a huge win, as for
> >> our later block group tree feature, we will have a much higher chance =
to
> >> have a block group item already COWed, thus can skip some COW work.
> >>
> >> But still, skipping a full COW search on extent tree is always a good
> >> thing, especially when the benefit almost comes from thin-air.
> >
> > Agreed, it's a good thing.
> >
> > Were there other benefits observed, like for example less IO due to les=
s COW?
> > Or transaction commits taking less time?
>
> I can definitely do that, but just from fio numbers, it doesn't seem to
> help at all?
>
> Thanks,
> Qu
> >
> > Thanks.
> >
> >
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> [Josef pinned down the race and provided a fix]
> >> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> >> ---
> >>   fs/btrfs/block-group.c | 20 +++++++++++++++++++-
> >>   fs/btrfs/block-group.h |  6 ++++++
> >>   2 files changed, 25 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> >> index e7b5a54c8258..0df4d98df278 100644
> >> --- a/fs/btrfs/block-group.c
> >> +++ b/fs/btrfs/block-group.c
> >> @@ -2002,6 +2002,7 @@ static int read_one_block_group(struct btrfs_fs_=
info *info,
> >>
> >>          cache->length =3D key->offset;
> >>          cache->used =3D btrfs_stack_block_group_used(bgi);
> >> +       cache->commit_used =3D cache->used;
> >>          cache->flags =3D btrfs_stack_block_group_flags(bgi);
> >>          cache->global_root_id =3D btrfs_stack_block_group_chunk_objec=
tid(bgi);
> >>
> >> @@ -2693,6 +2694,22 @@ static int update_block_group_item(struct btrfs=
_trans_handle *trans,
> >>          struct extent_buffer *leaf;
> >>          struct btrfs_block_group_item bgi;
> >>          struct btrfs_key key;
> >> +       u64 used;
> >> +
> >> +       /*
> >> +        * Block group items update can be triggered out of commit tra=
nsaction
> >> +        * critical section, thus we need a consistent view of used by=
tes.
> >> +        * We can not direct use cache->used out of the spin lock, as =
it
> >> +        * may be changed.
> >> +        */
> >> +       spin_lock(&cache->lock);
> >> +       used =3D cache->used;
> >> +       /* No change in used bytes, can safely skip it. */
> >> +       if (cache->commit_used =3D=3D used) {
> >> +               spin_unlock(&cache->lock);
> >> +               return 0;
> >> +       }
> >> +       spin_unlock(&cache->lock);
> >>
> >>          key.objectid =3D cache->start;
> >>          key.type =3D BTRFS_BLOCK_GROUP_ITEM_KEY;
> >> @@ -2707,12 +2724,13 @@ static int update_block_group_item(struct btrf=
s_trans_handle *trans,
> >>
> >>          leaf =3D path->nodes[0];
> >>          bi =3D btrfs_item_ptr_offset(leaf, path->slots[0]);
> >> -       btrfs_set_stack_block_group_used(&bgi, cache->used);
> >> +       btrfs_set_stack_block_group_used(&bgi, used);
> >>          btrfs_set_stack_block_group_chunk_objectid(&bgi,
> >>                                                     cache->global_root=
_id);
> >>          btrfs_set_stack_block_group_flags(&bgi, cache->flags);
> >>          write_extent_buffer(leaf, &bgi, bi, sizeof(bgi));
> >>          btrfs_mark_buffer_dirty(leaf);
> >> +       cache->commit_used =3D used;
> >>   fail:
> >>          btrfs_release_path(path);
> >>          return ret;
> >> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> >> index f48db81d1d56..b57718020104 100644
> >> --- a/fs/btrfs/block-group.h
> >> +++ b/fs/btrfs/block-group.h
> >> @@ -84,6 +84,12 @@ struct btrfs_block_group {
> >>          u64 cache_generation;
> >>          u64 global_root_id;
> >>
> >> +       /*
> >> +        * The last committed used bytes of this block group, if above=
 @used
> >> +        * is still the same as @commit_used, we don't need to update =
block
> >> +        * group item of this block group.
> >> +        */
> >> +       u64 commit_used;
> >>          /*
> >>           * If the free space extent count exceeds this number, conver=
t the block
> >>           * group to bitmaps.
> >> --
> >> 2.37.3
> >>
> >
> >



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
