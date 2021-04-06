Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9155A3556D7
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Apr 2021 16:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345262AbhDFOmL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Apr 2021 10:42:11 -0400
Received: from eu-shark2.inbox.eu ([195.216.236.82]:33276 "EHLO
        eu-shark2.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbhDFOmK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Apr 2021 10:42:10 -0400
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id 27C3346AB2E;
        Tue,  6 Apr 2021 17:42:01 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1617720121; bh=c9tW5+z2haOdpV9/5gMoD0yh61dAqsn5IbtJCmcjbNE=;
        h=References:From:To:Cc:Subject:Date:In-reply-to;
        b=dNZ2ibuhTvyad1KhIa6G1h5aUDTYtT5gcZiuaqcPI9hZiN/MN3oBly1OiHnf4gYKa
         MH6HKnp6y7D9kv1fjylljIB5aidkewJN+gqox2QOky+RB2OKeCD8YQ2TYaPJdd9Fqb
         w/1ZecEwP2ZROAnhiY0/KTN7tt325i7onFWX+UkI=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id E9EDE46AB1A;
        Tue,  6 Apr 2021 17:42:00 +0300 (EEST)
Received: from eu-shark2.inbox.eu ([127.0.0.1])
        by localhost (eu-shark2.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id n5qGdq-L1_dS; Tue,  6 Apr 2021 17:41:59 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id A3EAB46A991;
        Tue,  6 Apr 2021 17:41:59 +0300 (EEST)
Received: from nas (unknown [45.87.95.33])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 5D7801BE227E;
        Tue,  6 Apr 2021 17:41:56 +0300 (EEST)
References: <cover.1617694997.git.naohiro.aota@wdc.com>
 <35w3d6gz.fsf@damenly.su> <20210406132429.y4ew2n3yanrm6ayn@naota-xeon>
User-agent: mu4e 1.5.8; emacs 27.1
From:   Su Yue <l@damenly.su>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/12] btrfs-progs: refactor and generalize
 chunk/dev_extent allocation
Date:   Tue, 06 Apr 2021 22:40:40 +0800
In-reply-to: <20210406132429.y4ew2n3yanrm6ayn@naota-xeon>
Message-ID: <zgybbhls.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: OK
X-ESPOL: 6NpmlYxOGzysiV+lRWetewt38GpVJY3o/+Kk2BpHlX7kMi2YDTsAKnCr/x97TmA=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Tue 06 Apr 2021 at 21:24, Naohiro Aota <naohiro.aota@wdc.com>=20
wrote:

> On Tue, Apr 06, 2021 at 06:54:37PM +0800, Su Yue wrote:
>>
>> On Tue 06 Apr 2021 at 16:05, Naohiro Aota=20
>> <naohiro.aota@wdc.com> wrote:
>>
>> > This is the userland counterpart of the following series.
>> >
>> > https://lore.kernel.org/linux-btrfs/20200225035626.1049501-1-naohiro.a=
ota@wdc.com/
>> >
>> > This series refactors chunk allocation and device_extent=20
>> > allocation
>> > functions and make them generalized to be able to implement=20
>> > other
>> > allocation policy easily.
>> >
>> > On top of this series, we can simplify userland side of the=20
>> > zoned series
>> > as
>> > adding a new type of chunk allocator and extent allocator for=20
>> > zoned
>> > block
>> > devices. Furthermore, we will be able to implement and test=20
>> > some other
>> > allocator in the idea page of the wiki e.g. SSD caching,=20
>> > dedicated
>> > metadata
>> > drive, chunk allocation groups, and so on.
>> >
>> > This series also fixes a bug of calculating the stripe size=20
>> > in DUP
>> > profile,
>> > and cleans up the code.
>> >
>> > * Refactoring chunk/dev_extent allocator
>> >
>> > Two functions are separated from=20
>> > find_free_dev_extent_start().
>> > dev_extent_search_start() decides the starting position of=20
>> > the search.
>> > dev_extent_hole_check() checks if a hole found is suitable=20
>> > for device
>> > extent allocation.
>> >
>> > Split some parts of btrfs_alloc_chunk() into three functions.
>> > init_alloc_chunk_policy() initializes the parameters of an=20
>> > allocation.
>> > decide_stripe_size() decides the size of chunk and=20
>> > device_extent. And,
>> > create_chunk() creates a chunk and device extents.
>> >
>> > * Patch organization
>> >
>> > Patches 1 and 2 refactor find_free_dev_extent_start().
>> >
>> > Patches 3 to 6 refactor btrfs_alloc_chunk() by moving the=20
>> > code into
>> > three
>> > other functions.
>> >
>> > Patch 7 uses create_chunk() to simplify=20
>> > btrfs_alloc_data_chunk().
>> >
>> > Patch 8 fixes a bug of calculating stripe size in DUP=20
>> > profile.
>> >
>> > Patches 9 to 12 clean up btrfs_alloc_chunk() code by dropping
>> > unnecessary
>> > parameters, and using better macro/variable name to clarify=20
>> > the meaning.
>> >
>> >
>> gcc10 complains following warnings:
>> kernel-shared/volumes.c: In function =E2=80=98decide_stripe_size=E2=80=
=99:
>> kernel-shared/volumes.c:1119:1: warning: control reaches end of=20
>> non-void
>> function [-Wreturn-type]
>> 1119 | }
>>      | ^
>> kernel-shared/volumes.c: In function =E2=80=98dev_extent_search_start=E2=
=80=99:
>> kernel-shared/volumes.c:465:1: warning: control reaches end of=20
>> non-void
>> function [-Wreturn-type]
>>  465 | }
>>      | ^
>>
>> Looked at locations just two nits about 'switch'. Care to fix?
>
> These are actually false-positve warnings. They never reach the=20
> end of
> the function because BUG() in the default case will abort the=20
> program.
>
> The warnings are showing up because the BUG() macro is not=20
> marked as
> unreachable. This is addressed in the following patch. So, once=20
> the
> following patch is merged, the warnings will disappear.
>
I see. Thanks.

--
Su
> https://lore.kernel.org/linux-btrfs/5c7b703beca572514a28677df0caaafab28bf=
ff8.1617265419.git.naohiro.aota@wdc.com/T/#u
>
>> --
>> Su
>> > Naohiro Aota (12):
>> >   btrfs-progs: introduce chunk allocation policy
>> >   btrfs-progs: refactor find_free_dev_extent_start()
>> >   btrfs-progs: convert type of alloc_chunk_ctl::type
>> >   btrfs-progs: consolidate parameter initialization of=20
>> >   regular
>> > allocator
>> >   btrfs-progs: factor out decide_stripe_size()
>> >   btrfs-progs: factor out create_chunk()
>> >   btrfs-progs: rewrite btrfs_alloc_data_chunk() using=20
>> >   create_chunk()
>> >   btrfs-progs: fix to use half the available space for DUP=20
>> >   profile
>> >   btrfs-progs: use round_down for allocation calcs
>> >   btrfs-progs: drop alloc_chunk_ctl::stripe_len
>> >   btrfs-progs: simplify arguments of chunk_bytes_by_type()
>> >   btrfs-progs: rename calc_size to stripe_size
>> >
>> >  kernel-shared/volumes.c | 514=20
>> >  +++++++++++++++++++++-------------------
>> >  kernel-shared/volumes.h |   6 +
>> >  2 files changed, 274 insertions(+), 246 deletions(-)
>>

