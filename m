Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F445142976
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jan 2020 12:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgATLaF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jan 2020 06:30:05 -0500
Received: from a4-15.smtp-out.eu-west-1.amazonses.com ([54.240.4.15]:41832
        "EHLO a4-15.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726451AbgATLaF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jan 2020 06:30:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ob2ngmaigrjtzxgmrxn2h6b3gszyqty3; d=urbackup.org; t=1579519802;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=sg3myTo5twJ86fk6euWzeAnPRWtwdZ4ErLfH0lQXzGo=;
        b=GIAh5EwU1OXgZwsDxf0QoBiAA1XiBAsQXAhdnYNe7ezN+TqbzwIsp3duXQXT31xq
        f+32sKRNFpnMa5jIi2T/1INLU+21X2rMqAvrmxqPf800WPXK2AKCz+oqTfWV4Pobx3/
        u2mIdt/YpHKkLIlj+makJNBRr1zaJnkA5u/sLd4A=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1579519802;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=sg3myTo5twJ86fk6euWzeAnPRWtwdZ4ErLfH0lQXzGo=;
        b=DYLdSZAXrQsbD/8C5aOU1Vvg/aVZW6eYGUGDxsKmyE3Mu+bk/YjIRH06cTwv9yta
        cdhtKGadpFckxRVHvdGgH9ihXKUSbQ0mWKw8G80XP3GlorHESU6XSe2I8g89ytxU59P
        EqeSxj2BKqwOAhueX2n/KexMzlYxEfJNBFdd1PdU=
Subject: Re: [PATCH] Btrfs: send, skip backreference walking for extents with
 many references
To:     fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20191030122301.25270-1-fdmanana@kernel.org>
 <0102016ea8d7cba9-e4f3d553-317c-4a83-9ad6-c161fcdd0e7f-000000@eu-west-1.amazonses.com>
 <0102016fb9f6179a-a6770a1b-f02c-4f6c-8b14-50ad749ccb1f-000000@eu-west-1.amazonses.com>
 <CAL3q7H61cVR7ivb-yhca-AcuQhs6peeKQvv5=S9rRtFP-Re94A@mail.gmail.com>
From:   Martin Raiber <martin@urbackup.org>
Message-ID: <0102016fc2b77ca2-584598d4-6a6d-4a0b-a8f4-5d6dc14aec1d-000000@eu-west-1.amazonses.com>
Date:   Mon, 20 Jan 2020 11:30:02 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CAL3q7H61cVR7ivb-yhca-AcuQhs6peeKQvv5=S9rRtFP-Re94A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-SES-Outgoing: 2020.01.20-54.240.4.15
Feedback-ID: 1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 20.01.2020 11:57 Filipe Manana wrote:
> On Sat, Jan 18, 2020 at 6:42 PM Martin Raiber <martin@urbackup.org> wrote:
>> On 26.11.2019 18:52 Martin Raiber wrote:
>>> On 30.10.2019 13:23 fdmanana@kernel.org wrote:
>>>> From: Filipe Manana <fdmanana@suse.com>
>>>>
>>>> Backreference walking, which is used by send to figure if it can issue
>>>> clone operations instead of write operations, can be very slow and use too
>>>> much memory when extents have many references. This change simply skips
>>>> backreference walking when an extent has more than 64 references, in which
>>>> case we fallback to a write operation instead of a clone operation. This
>>>> limit is conservative and in practice I observed no signicant slowdown
>>>> with up to 100 references and still low memory usage up to that limit.
>>>>
>>>> This is a temporary workaround until there are speedups in the backref
>>>> walking code, and as such it does not attempt to add extra interfaces or
>>>> knobs to tweak the threshold.
>>> Thanks for the patch!
>>>
>>> Did some further deliberation on  the problem, and for me the best short
>>> term solution (apart from your patch) for the send clone source
>>> detection would be to offload it to userspace.
>>> I.e. a flag like "--no-data"/BTRFS_SEND_FLAG_NO_FILE_DATA that disables
>>> clone source detection.
>>> Userspace can then take each BTRFS_SEND_C_UPDATE_EXTENT and look if it
>>> is in the clone sources/on the send target. If it is a dedup tool it can
>>> use its dedup database, it can use a cache or it can use
>>> BTRFS_IOC_LOGICAL_INO. Another advantage is that user space can do this
>>> in multiple threads.
>>>
>>> Only problem I can think of is that send prevents subvol removal and
>>> dedup during send, but user space may not be finished with the actual
>>> send stream once send has finished outputting the metadata. So there may
>>> be some issues there, but not if one has control over when removal/dedup
>>> happens.
>> I was still having performance issues even with this patch. Shouldn't be
>> too hard to reproduce. E.g., I have a ~10GB sqlite db with 1236459
>> extents (as dbs tend to have on btrfs). Sending that (even with only two
>> snapshots) causes it to be cpu limited.
>>
>> So I went ahead and continued to use the patch that disables backref
>> walking in send (for the db above the backref walking doesn't do
>> anything anyway), but use it in combination with "--no-data" to read
>> file data and then dedup in user space (only whole file dedup for now).
>> This is all a bit application specific. Is anyone interested in the code?
> You should only see performance improvement if you have extents that
> have more than 64 references.
> You mention two snapshots, but you don't mention if there are extents
> that are shared through reflinks (cloning and deduplication).
> Also, is compression enabled? That can have a very significant impact,
> specially for zstd.
>
> Thanks.

Yeah, sure. It's a database file. I can't see how there would be
reflinks in it (initially during creation, but afterwards not). I back
it up by creating a read-only snapshot and sending/receiving that to a
separate backup volume. That snapshot and the last snapshot for
incremental send are the only ones.

There is another volume with a lot of files that are reflinked on the
same machine and those get send/received as well, and it should work for
both volumes.

Compression on the database file is enabled (lzo). I would guess that
zstd should have the fastest decompression, though (lzo seems to have a
little bit better compression speed, but not decompression speed)? The
sqlite page size is 4096 bytes. That might be too low and cause too much
fragmentation...

>
>
>> Regards,
>> Martin Raiber
>>
>>>> Reported-by: Atemu <atemu.main@gmail.com>
>>>> Link: https://lore.kernel.org/linux-btrfs/CAE4GHgkvqVADtS4AzcQJxo0Q1jKQgKaW3JGp3SGdoinVo=C9eQ@mail.gmail.com/T/#me55dc0987f9cc2acaa54372ce0492c65782be3fa
>>>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>>>> ---
>>>>  fs/btrfs/send.c | 25 ++++++++++++++++++++++++-
>>>>  1 file changed, 24 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
>>>> index 123ac54af071..518ec1265a0c 100644
>>>> --- a/fs/btrfs/send.c
>>>> +++ b/fs/btrfs/send.c
>>>> @@ -25,6 +25,14 @@
>>>>  #include "compression.h"
>>>>
>>>>  /*
>>>> + * Maximum number of references an extent can have in order for us to attempt to
>>>> + * issue clone operations instead of write operations. This currently exists to
>>>> + * avoid hitting limitations of the backreference walking code (taking a lot of
>>>> + * time and using too much memory for extents with large number of references).
>>>> + */
>>>> +#define SEND_MAX_EXTENT_REFS        64
>>>> +
>>>> +/*
>>>>   * A fs_path is a helper to dynamically build path names with unknown size.
>>>>   * It reallocates the internal buffer on demand.
>>>>   * It allows fast adding of path elements on the right side (normal path) and
>>>> @@ -1302,6 +1310,7 @@ static int find_extent_clone(struct send_ctx *sctx,
>>>>      struct clone_root *cur_clone_root;
>>>>      struct btrfs_key found_key;
>>>>      struct btrfs_path *tmp_path;
>>>> +    struct btrfs_extent_item *ei;
>>>>      int compressed;
>>>>      u32 i;
>>>>
>>>> @@ -1349,7 +1358,6 @@ static int find_extent_clone(struct send_ctx *sctx,
>>>>      ret = extent_from_logical(fs_info, disk_byte, tmp_path,
>>>>                                &found_key, &flags);
>>>>      up_read(&fs_info->commit_root_sem);
>>>> -    btrfs_release_path(tmp_path);
>>>>
>>>>      if (ret < 0)
>>>>              goto out;
>>>> @@ -1358,6 +1366,21 @@ static int find_extent_clone(struct send_ctx *sctx,
>>>>              goto out;
>>>>      }
>>>>
>>>> +    ei = btrfs_item_ptr(tmp_path->nodes[0], tmp_path->slots[0],
>>>> +                        struct btrfs_extent_item);
>>>> +    /*
>>>> +     * Backreference walking (iterate_extent_inodes() below) is currently
>>>> +     * too expensive when an extent has a large number of references, both
>>>> +     * in time spent and used memory. So for now just fallback to write
>>>> +     * operations instead of clone operations when an extent has more than
>>>> +     * a certain amount of references.
>>>> +     */
>>>> +    if (btrfs_extent_refs(tmp_path->nodes[0], ei) > SEND_MAX_EXTENT_REFS) {
>>>> +            ret = -ENOENT;
>>>> +            goto out;
>>>> +    }
>>>> +    btrfs_release_path(tmp_path);
>>>> +
>>>>      /*
>>>>       * Setup the clone roots.
>>>>       */
>

