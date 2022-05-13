Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF8E5261B8
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 May 2022 14:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380196AbiEMMVt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 May 2022 08:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380195AbiEMMVs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 May 2022 08:21:48 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B24613FD56
        for <linux-btrfs@vger.kernel.org>; Fri, 13 May 2022 05:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652444504;
        bh=DUigy7GofD+05wjRQMnKHydjoAkwsp+KZa0rExxgO/E=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=ldiICV3XcyAp3Yp6GDnq9CpezrJw4TjDmXnc0/q3oUi95i1VyAp1PBMaLgLP652/N
         YSaMJP+bzcuaYbA0p8rxdia8dJ6LSazP08lVD2qXDXut8rbFhsdTX/c+w9gwvudDpz
         C+yLUZpAXqyeh2pi3ba4RvIdb0YREUmS44I3DSnY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWRVb-1nIBq82x6h-00Xwkt; Fri, 13
 May 2022 14:21:44 +0200
Message-ID: <f119b7c7-aa86-b8f9-b5eb-79a16cdd58a4@gmx.com>
Date:   Fri, 13 May 2022 20:21:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1652428644.git.wqu@suse.com>
 <20220513113826.GV18596@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 0/4] btrfs: cleanups and preparation for the incoming
 RAID56J features
In-Reply-To: <20220513113826.GV18596@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7iImGeHGZXfY63OVrNLgA9lc+j1ow0lfFhjgtY1YzZ1MNobOSUe
 pXmCiDl6rtieBR80mhpoMUO7M29LNRke2o9CW+cNj49gQZWle7jkoReLftssdTvuL6UprcQ
 EMQMAWrXeUA5Gr1lbThuNh0uH6oU+VgF1i4iSHbw4S+uHHKQQiqucG4dc3vztFrnhT6d6SJ
 g61ikVnItjwgbn3ULQHrw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:u5/NqW0QfSE=:jl1NE7Y2JmxeoLaDqzVEDa
 4uS3FEirOB/GmiiJeYxVuAvAHkyCfEK6w/VhOHcsp1vxnhRt3Y7M56lyb2mMDWKaRodpggauO
 hQFMnL2EheM9Q4Kdl29MCur/w2jJbwDWSsMGICmJV1UF4EpjgwHBaZnFjskPHQe8pjbbn1Iuz
 XUO6hS3vspqc+cf7hGpw2eEjnt2ljZVM5p3tfR5ftr5JLiVT4QW9e+ScrmGEEiqp3YeEsZkSp
 I4uKGOH2st+3zulEqRK1raKSfjzCt3FMqDkinrQEa3D1eCagQ1dxVONPxOJ+Zk5b1Ct57uIfL
 97TgwZD+7eiwEgLeCCKk1V4EqbEbV0P9V52R5SO5YovWUXjvw9Pa7x1oh8akoETNeOyIYQsVX
 n0aHaoH6BuIOL++EBm95oc3dihXZnKKYhF+bhdzqZ6mcP9iwsWbhLFJFf8sj1ssNP+bClglWr
 XjWUmTmb5CVl5JhqGewbnqtt4h1mgfpmpd3uRGsj2VXAZwtVeIIR3cTKPBXwwnlOswsk+dP+H
 s6HRyYDSRuLnmRKgQCizXRYK44NG5olJqGY1BnA/WZh5iTbAH99WVkKMcO/2mA4xC+QbSSQtY
 eYJxOArBef+9kaZKETlof7rwHSRxXBScDfcdEWBel5HGWMUhLJZsuCvD9+lICmAO0FDn+MYw5
 ckxOXvuO6JlXO4WWgpCXmQnK1j705R6m4qdIUJKidBh7uliVYCWwtOVJI4RZ9AwZmIqGBKT2+
 LScw0XAGx4UEyPZ5uKbdhA5ZES8PEO8hsNHtgLHfqe006shL+fkfhbgPvlhEGw5KkulW8aM2f
 dOzHfkkCsoDuikaog2eFzYhE+TMBEOMz1u4LbgowrvSMVrcbPwDzw/+dUi4tCLHYYdeebwSLp
 0IQ3hLkkIIW/sVlAReadZf7um0+cMvC0nn+KqF3JEwa0/o6rt3FSWx9FUC+S403KHVCEMdLzE
 tbFfpywkAp12YYkY9ygeRXuZiar7qaMI3yWHi72fs9fhYAyMepe5etymuJw99DbXIwyZWgsmh
 s1dwRlebs2YMyxe0EzrlprZhPK6VNIIA8LvfH5YuzAaBIdaZrb62Rx6R9+x2kw1zBu9QhY9HH
 9vyzZGvOzipau0kQiKA0XYLjOxW6vl3hVPdQT9a2ylAbMy1ekMtx5kZxw==
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/13 19:38, David Sterba wrote:
> On Fri, May 13, 2022 at 04:34:27PM +0800, Qu Wenruo wrote:
>> Since I'm going to introduce two new chunk profiles, RAID5J and RAID6J
>> (J for journal),
>
> Do you need to introduce completely new profiles? IIRC in my drafts I
> was more inclined to reuse a dedicated raid1c3 block group, of an
> arbitrary size and not used by anything else. A new profile would
> technically work too but it brings other issues.

The point here is, I want to reserve some space for each data stripe of
a RAID56 chunk.

Unfortunately, we need some on-disk format change anyway, for reusing
btrfs_chunk::io_align to represent how many bytes are reserved for each
dev extent, before where the data really starts.

So new RAID56 types are needed anyway.

Sure, this will make dev_extent mismatch from pure calculated extent
length from a chunk map.

But all the involved change are not that huge, still reviewable.

 From my latest version, already under fstests (with new RAID56J
profiles added to related test cases), but without real journal code
yet, the patch looks like this:

  fs/btrfs/block-group.c          |  23 ++++++-
  fs/btrfs/ctree.h                |   7 +-
  fs/btrfs/scrub.c                |  15 ++--
  fs/btrfs/tree-checker.c         |   4 ++
  fs/btrfs/volumes.c              | 118 +++++++++++++++++++++++++++++---
  fs/btrfs/volumes.h              |   7 +-
  fs/btrfs/zoned.c                |   2 +
  include/uapi/linux/btrfs.h      |   1 +
  include/uapi/linux/btrfs_tree.h |  30 +++++++-
  9 files changed, 185 insertions(+), 22 deletions(-)

Most changes are involved in dev extent handling, and some sites can not
use btrfs_raid_array[] directly.

I guess you'll see that kernel patch soon, along with needed progs patch
in next week.

Thanks,
Qu
>
> As a related feature to the raid56, I was working on the striped
> raid10c34 profiles but was not able to make it work. In a sense this is
> easier as it reuses existing code, but if you make the journal work we
> won't need that.
>
>> if we're relying on ad-hoc if () else if () branches to
>> calculate thing like number of p/q stripes, it will cause a lot of
>> problems.
>>
>> In fact, during my development, I have hit tons of bugs related to this=
.
>>
>> One example is alloc_rbio(), it will assign rbio->nr_data, if we forgot
>> to update the check for RAID5 and RAID6 profiles, we will got a bad
>> nr_data =3D=3D num_stripes, and screw up later writeback.
>>
>> 90% of my suffering comes from such ad-hoc usage doing manual checks on
>> RAID56.
>>
>> Another example is, scrub_stripe() which due to the extra per-device
>> reservation, @dev_extent_len is no longer the same the data stripe
>> length calculated from extent_map.
>>
>> So this patchset will do the following cleanups preparing for the
>> incoming RAID56J (already finished coding, functionality and on-disk
>> format are fine, although no journal yet):
>>
>> - Calculate device stripe length in-house inside scrub_stripe()
>>    This removes one of the nasty mismatch which is less obvious.
>>
>> - Use btrfs_raid_array[] based calculation instead of ad-hoc check
>>    The only exception is scrub_nr_raid_mirrors(), which has several
>>    difference against btrfs_num_copies():
>>
>>    * No iteration on all RAID6 combinations
>>      No sure if it's planned or not.
>>
>>    * Use bioc->num_stripes directly
>>      In that context, bioc is already all the mirrors for the same
>>      stripe, thus no need to lookup using btrfs_raid_array[].
>>
>> With all these cleanups, the RAID56J will be much easier to implement.
>>
>> Qu Wenruo (4):
>>    btrfs: remove @dev_extent_len argument from scrub_stripe() function
>>    btrfs: use btrfs_chunk_max_errors() to replace weird tolerance
>>      calculation
>>    btrfs: use btrfs_raid_array[] to calculate the number of parity
>>      stripes
>>    btrfs: use btrfs_raid_array[].ncopies in btrfs_num_copies()
>
> The preparatory patches look good to me.
