Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4298A394EA1
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 May 2021 02:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbhE3A0L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 May 2021 20:26:11 -0400
Received: from mout.gmx.net ([212.227.17.20]:44947 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229546AbhE3A0L (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 May 2021 20:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1622334270;
        bh=W4vc1o+ogamBnzFKzfrZeI18hJ+h1efJPW6YaHDoQpA=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=JkyyELS4y58Q6XTAnt0gll5VXdo5mdBTpLuoQQnCL7swNmFaZstL6vhe3oI8MxNXc
         /KVWcunyv2OTO7jqD0d7PZ6ER+x6wXF04sG+L6ZK69wFTUEhlyaknBJ7oHVVB+z0dl
         3IZqkJx5cfdD7iQniajb5pIth3FnBuT/Dyc/tOf4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MPogF-1lzz2M2gVv-00Mu79; Sun, 30
 May 2021 02:24:30 +0200
To:     Neal Gompa <ngompa13@gmail.com>, Qu Wenruo <wqu@suse.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.cz>,
        Josef Bacik <josef@toxicpanda.com>
References: <20210521064050.191164-1-wqu@suse.com>
 <CAEg-Je9m_Lpwq3oXOFfhrHU_OFxryrGE8-3vjMztn7tBt_uStw@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v3 00/31] btrfs: add data write support for subpage
Message-ID: <3d7122d6-9887-e799-fd57-09019c9c3533@gmx.com>
Date:   Sun, 30 May 2021 08:24:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAEg-Je9m_Lpwq3oXOFfhrHU_OFxryrGE8-3vjMztn7tBt_uStw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UPGkqh3lZMC8rQu0NE8c1fbyVsKatx98mcm4EI/RYETAN6TwNag
 uePLAXJ2N1hPaq+eugQNv/PgHvHX6u+KFtngx8/sLAhp4rjTaC/26N4wu/aIEEACJL2orfN
 hQ68/xCPQwZ0nNy9RQm8CpMxeDVVlm92OxVDSg2A3U6w05Jrtb9rgdUJBcD9NYhgEAxUG49
 zdyeJDo5lmIhBe1ozUz2Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:js7Bv9JzFQ8=:46wHaLRCSanSDEEVGgXdu9
 HgEWX9bv5rncBT+TOPfpE/D2AzNbEQnQBAkNPj/Bkbq/IsxT8AvzI6ASQNXi8O5sMItLeE13E
 pE9skzaZcf2AFoR+rz7ZuZl/Ep6jv7vFz4rXKxl00jxqTPVB7XOzaJDaA1+Gi2CjJT6Whgbcd
 wOtL5WVAz/FXtEChqcSjpRjd8pd6tyA2FyitvlAbfLd1nv2Jx0q9+iUVAvJWLXfFTjZfIuCzU
 aX37LtwiqoPMOgHWrW3d5l/DxkxQ5SjVErvhuPX3a+d08AAIPLwSnBNCiRXNC/Z61Ldv76iW4
 /DNyu73nNj6VjCuflPBfIacIsgE9WQ4AdCLZfvUFkwA3JXjSFSQkCRGmn3vp6lsohxG4edC7x
 b8srf5eeyb4zv6b46pgXrehsUwdVZEax6HFR6ihllhXSzl1orT7tkpJ71WKzTnlYQS26IiE9F
 6QPJAvMopVCnHeH1I7M1/tPW2FjSufArUfLeQKtgDDdSJZXrplnsoCC82rklAMoaZ93y55AxV
 ArvbpAd3Wp2XIyx0z4ptr10yCYOhfGoMMFoAXVXtIvvtKleHGMCZByLfGUowu1rBvlbYZVQBw
 GBOcuGcqGxJaggdHbWRfqkSry/g0MrGXvQ5/VmPGwSriG3as012z22G4pPidwogltIh4ZBLLt
 3u1L20ESiR557LzPswczhfaWbNRJNbRhYW5iVkh+Fkt5vIjvW3Dq1FhT8sgGSPGBWPTrCFj0A
 kq1FmCSIcvIHYpQVGW2kVNcZsjWikp624YOtACRheSIb9QpMdiH4XZkMXM0l1BjKgkBDtQWiF
 KwAyFPcs64yEpuQJ8SepFHWcSSgmwFVeGmblCSO5KpWejVmTCBKKvnxh1N8B6hkao7RaGrEEQ
 IDgc++o5bWGyhj7YJsSN2kKOahVMsdiNHKQGJYhTNyshZkXTORE5Nv2Exlocfcaskyxl7IHPQ
 5pcUPKd9RukJQRt6MJ5yQatHzmBUxeHARs6K7Ixl/kIPGf8BE0C2NHiQlQGd+BTU0BRBJRyRq
 gFTB1aePDContKyVfTSp0W8SQnKFteuZbxmVvFVnOmeNb8KkSHwUI8Ke92Ltv1z7VCkfncdEn
 KSP0sbvDQf0Him4/EWK2M9GtsrGMQ0y1JfmXDmddQMGcda+4X99ks5FDg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/30 =E4=B8=8A=E5=8D=888:12, Neal Gompa wrote:
> On Fri, May 21, 2021 at 5:56 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> This huge patchset can be fetched from github:
>> https://github.com/adam900710/linux/tree/subpage
>>
>> =3D=3D=3D Current stage =3D=3D=3D
>> The tests on x86 pass without new failure, and generic test group on
>> arm64 with 64K page size passes except known failure and defrag group.
>>
>> For btrfs test group, all pass except compression/raid56.
>> (As the btrfs defrag group doesn't require that restrict defrag result,
>> btrfs/defrag group also passes here)
>>
>> For anyone who is interested in testing, please apply this patch for
>> btrfs-progs before testing.
>> https://patchwork.kernel.org/project/linux-btrfs/patch/20210420073036.2=
43715-1-wqu@suse.com/
>> Or there will be too many false alerts.
>>
>> =3D=3D=3D Limitation =3D=3D=3D
>> There are several limitations introduced just for subpage:
>> - No compressed write support
>>    Read is no problem, but compression write path has more things left =
to
>>    be modified.
>>    Thus for current patchset, no matter what inode attribute or mount
>>    option is, no new compressed extent can be created for subpage case.
>>
>> - No inline extent will be created
>>    This is mostly due to the fact that filemap_fdatawrite_range() will
>>    trigger more write than the range specified.
>>    In fallocate calls, this behavior can make us to writeback which can
>>    be inlined, before we enlarge the isize, causing inline extent being
>>    created along with regular extents.
>>
>> - No support for RAID56
>>    There are still too many hardcoded PAGE_SIZE in raid56 code.
>>    Considering it's already considered unsafe due to its write-hole
>>    problem, disabling RAID56 for subpage looks sane to me.
>>
>> - No sector-sized defrag support
>>    Currently defrag is still done in PAGE_SIZE, meaning if there is a
>>    hole in a 64K page, we still write a full 64K back to disk.
>>    This causes more disk space usage.
>>
>> =3D=3D=3D Patchset structure =3D=3D=3D
>>
>> Patch 01~19:    Make data write path to be subpage compatible
>> Patch 20~21:    Make data relocation path to be subpage compatible
>> Patch 22~30:    Various fixes for subpage corner cases
>> Patch 31:       Enable subpage data write
>>
>> =3D=3D=3D Changelog =3D=3D=3D
>> v2:
>> - Rebased to latest misc-next
>>    Now metadata write patches are removed from the series, as they are
>>    already merged into misc-next.
>>
>> - Added new Reviewed-by/Tested-by/Reported-by tags
>>
>> - Use separate endio functions to subpage metadata write path
>>
>> - Re-order the patches, to make refactors at the top of the series
>>    One refactor, the submit_extent_page() one, should benefit 4K page
>>    size more than 64K page size, thus it's worthy to be merged early
>>
>> - New bug fixes exposed by Ritesh Harjani on Power
>>
>> - Reject RAID56 completely
>>    Exposed by btrfs test group, which caused BUG_ON() for various sites=
.
>>    Considering RAID56 is already not considered safe, it's better to
>>    reject them completely for now.
>>
>> - Fix subpage scrub repair failure
>>    Caused by hardcoded PAGE_SIZE
>>
>> - Fix free space cache inode size
>>    Same cause as scrub repair failure
>>
>> v3:
>> - Rebased to remove write path prepration patches
>>
>> - Properly enable btrfs defrag
>>    Previsouly, btrfs defrag is in fact just disabled.
>>    This makes tons of tests in btrfs/defrag to fail.
>>
>> - More bug fixes for rare race/crashes
>>    * Fix relocation false alert on csum mismatch
>>    * Fix relocation data corruption
>>    * Fix a rare case of false ASSERT()
>>      The fix already get merged into the prepration patches, thus no
>>      longer in this patchset though.
>>
>>    Mostly reported by Ritesh from IBM.
>>
>> Qu Wenruo (31):
>>    btrfs: pass bytenr directly to __process_pages_contig()
>>    btrfs: refactor the page status update into process_one_page()
>>    btrfs: provide btrfs_page_clamp_*() helpers
>>    btrfs: only require sector size alignment for
>>      end_bio_extent_writepage()
>>    btrfs: make btrfs_dirty_pages() to be subpage compatible
>>    btrfs: make __process_pages_contig() to handle subpage
>>      dirty/error/writeback status
>>    btrfs: make end_bio_extent_writepage() to be subpage compatible
>>    btrfs: make process_one_page() to handle subpage locking
>>    btrfs: introduce helpers for subpage ordered status
>>    btrfs: make page Ordered bit to be subpage compatible
>>    btrfs: update locked page dirty/writeback/error bits in
>>      __process_pages_contig
>>    btrfs: prevent extent_clear_unlock_delalloc() to unlock page not
>>      locked by __process_pages_contig()
>>    btrfs: make btrfs_set_range_writeback() subpage compatible
>>    btrfs: make __extent_writepage_io() only submit dirty range for
>>      subpage
>>    btrfs: make btrfs_truncate_block() to be subpage compatible
>>    btrfs: make btrfs_page_mkwrite() to be subpage compatible
>>    btrfs: reflink: make copy_inline_to_page() to be subpage compatible
>>    btrfs: fix the filemap_range_has_page() call in
>>      btrfs_punch_hole_lock_range()
>>    btrfs: don't clear page extent mapped if we're not invalidating the
>>      full page
>>    btrfs: extract relocation page read and dirty part into its own
>>      function
>>    btrfs: make relocate_one_page() to handle subpage case
>>    btrfs: fix wild subpage writeback which does not have ordered extent=
.
>>    btrfs: disable inline extent creation for subpage
>>    btrfs: allow submit_extent_page() to do bio split for subpage
>>    btrfs: make defrag to be semi subpage compatible
>>    btrfs: reject raid5/6 fs for subpage
>>    btrfs: fix a crash caused by race between prepare_pages() and
>>      btrfs_releasepage()
>>    btrfs: fix a use-after-free bug in writeback subpage helper
>>    btrfs: fix a subpage false alert for relocating partial preallocated
>>      data extents
>>    btrfs: fix a subpage relocation data corruption
>>    btrfs: allow read-write for 4K sectorsize on 64K page size systems
>>
>>   fs/btrfs/ctree.h        |   2 +-
>>   fs/btrfs/disk-io.c      |  13 +-
>>   fs/btrfs/extent_io.c    | 551 +++++++++++++++++++++++++++------------=
-
>>   fs/btrfs/file.c         |  31 ++-
>>   fs/btrfs/inode.c        | 147 +++++++++--
>>   fs/btrfs/ioctl.c        |  12 +-
>>   fs/btrfs/ordered-data.c |   5 +-
>>   fs/btrfs/reflink.c      |  14 +-
>>   fs/btrfs/relocation.c   | 287 +++++++++++++--------
>>   fs/btrfs/subpage.c      | 156 +++++++++++-
>>   fs/btrfs/subpage.h      |  31 +++
>>   fs/btrfs/super.c        |   7 -
>>   fs/btrfs/sysfs.c        |   5 +
>>   fs/btrfs/volumes.c      |   8 +
>>   14 files changed, 937 insertions(+), 332 deletions(-)
>>
>> --
>> 2.31.1
>>
>
> So this seems to have no impact on my system on x86_64 with the
> branch, which is good I guess?

Yep, that's the very basic requirement, not messing up 4K page size.

>
> Unfortunately, I couldn't make a test package based on 5.13rc4 for
> some confidence testing as the patch set from Patchwork doesn't
> apply...

I'll rebase the branch soon, with one small feature removal, defrag.

Currently the full page defrag is not working properly, causing rare
racing, and we're already at the edge of full subpage defrag, thus I
want to be extra safe to disable defrag.

>
> However, somewhat related to this, it seems that we're going to be
> seeing a need for 4K <-> 16K page interoperability because Linux will
> need to be configured to use 16K pages to run effectively on Apple ARM
> Mac systems[1][2].

It's already under the radar.

In fact, as long as we can ensure all tree blocks are properly nodesize
aligned, then the convert should be pretty simple.

Data path can handle any sectorsize smaller than 64K already.
While metadata path may need some small change to switch between
multi-page (e.g. 32K nodesize and 16K page size) and subpage nodesize
(e.g. 8K nodesize and 16K page size).

>
> How difficult would it be to extend this to also handle 16K pages too?
> Not necessarily in this patch set, but in a follow-up one?

At least no longer a multi-patchset, multi-kernel version huge change
like this one.

Thanks,
Qu

>
> [1]: https://twitter.com/marcan42/status/1398301930879815680
> [2]: https://twitter.com/marcan42/status/1398301933203431426
>
>
>
> --
> =E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=
=EF=BC=81/ Always, there's only one truth!
>
