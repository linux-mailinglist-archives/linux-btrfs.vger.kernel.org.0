Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D54B39F194
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jun 2021 11:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhFHJEy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Jun 2021 05:04:54 -0400
Received: from mout.gmx.net ([212.227.15.18]:60433 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230280AbhFHJEx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 8 Jun 2021 05:04:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623142976;
        bh=FklWYN/LoWndr9xJg91ZZFQI1b+C+uR+2fIPsaFOUK0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=g/Z4gM5sj902nx9QXMHP12lOB0MCI33xLuOB8X20SyfKniBB2Q067i0fugb9j5O4s
         DUmx0c62etpTnDJ3GpIMM9cZC6lpS/DiVnPwpuLlRSVlLqJ27X1YZKK/sKIqM2CMp8
         doML0J8ueebXmQ29q5ydgWETH95x+ZC59gUZTpBU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MYNNo-1luPFt1xdS-00VRvq; Tue, 08
 Jun 2021 11:02:56 +0200
Subject: Re: [PATCH v4 00/30] btrfs: add data write support for subpage
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210531085106.259490-1-wqu@suse.com>
 <55ba3489-98de-3a69-8912-3a32e73ffca4@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <a1a2aebb-759d-35a2-ade0-3a0119346166@gmx.com>
Date:   Tue, 8 Jun 2021 17:02:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <55ba3489-98de-3a69-8912-3a32e73ffca4@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jGmp9CHHE4kNpAadeLFf3TZ4xJ4xcC3B6lBpKIwu28EZYzGxXGE
 weazktTpBHWIIJiroSeS53kgLv+Il3/u+gfg5EV82lyd9Q/jC3xqSRiKDEg/7ZtfadVpaJc
 1//cqcYvNTA+RxpHENTw6mJGgHMZEuHvM8CF1xDuCLeJH1h3m43icLyoAfvmD+WK9lDsN9Z
 k5xmYY620AwPPPKeTSzdA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lQ8c7WA+DSM=:+0CHIYMYi49i2PFdBVdUBS
 yqWxkU7Cw0CUrZ3eCf0/58DgXn9wH7dMRyKie65oDoWURdI60LH2c44WdpiyxftOiEhb3EvWc
 NcloyYCqYYHVcZs3PZCdnXrTu+AwP1EeFwleCt0B5W6UiVg9KA5HD9F8rnPtPi340jP7KCCyH
 M9dsKEYLOQCxVxew08gxPwSi8n0sGCQ/mrJO/eCrRbwzqzCIhILxPDYWJwPJuym5Wz2QWkfYX
 gIzEcQLS9Ns+GqpCcYuE1Xa7vkbFe+sKAAmM9YWWCSzP6IEnaiH0911+SC9rgC85YOVyitW8j
 JtJ4MWM1jKnGKfLa9BA8upIeG0P4djqvmyp9p6sqhTptJq9vPVRs6NCbXOOjE6RJEjZhkTn6t
 +ikkiMeOUhe5/vfS1r/UXSFVQ8O6s0Ee6DIwpuWasfK/noImj3KJOCCNFlSFFqhArU+QPPA6y
 Kxhy4KmHbkpjrfkb6L43fGTDnfHszt075u4ckbbRQt8WKD4KVFMqJ+J3uLJ9V9dQ74+JjJHNs
 Y1dp8KF/x00CMRDXfknfPqZY+Lx7cf39sM/2vI/ffsrQh051HFE9cYKGUv2s1KquxVjUhE4V4
 i8ySkOfea4+s9fQazq94LvtV8sOCbuaPeqqXNXjxQMkKx8o3bJxpKS7xPZ/FGdklTJrZet46e
 YDli7tYfWKdl6DTA3wSQuVq7K31IRc5Dq73c6jpTPWgOu71bMEONlP5+B2uXphdebra+SGA3E
 YHOxXoJl35NG85KoRgBxF+/fyc6gDwSnDx6+Ad1XEn3N5Wt+5f8S3utJmNFQ9K33gB7D/ua03
 f0IsvGjWb/1nrU2xiFsH/6ssBI1S82R5xdljZQFyhMP9Aq3irLWc8DfXbRizQJOyOkokJ11KC
 vgkffIckWbGRGgByspuxCL2DRRG+8XSSOzfnVJUBYC/O2TNRJjyj99bSg/wdRSym6YAYjrn+y
 RsPfXmoAosoegb2PnTa1bKi6hhRZcaD5HqeDAC2/fkcQwoSxTNdVy0b5KLBFzmAb7PbBKLx8N
 MNsTpAF0YG3HKmo3EiOgLxWxHRHXzpxngAIVhjiiwR7BehWckC2IgE58TLWSdW2PkHrSB0YqK
 COWPNFtGYLl9r8vElDWMcrX40zKCHDPsIwMm7TJ81yVku4Su5FG8jeKEQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/8 =E4=B8=8B=E5=8D=884:23, Anand Jain wrote:
> On 31/5/21 4:50 pm, Qu Wenruo wrote:
>> This huge patchset can be fetched from github:
>> https://github.com/adam900710/linux/tree/subpage
>>
>> =3D=3D=3D Current stage =3D=3D=3D
>> The tests on x86 pass without new failure, and generic test group on
>> arm64 with 64K page size passes except known failure and defrag group.
>>
>> For btrfs test group, all pass except compression/raid56/defrag.
>>
>> For anyone who is interested in testing, please apply this patch for
>> btrfs-progs before testing.
>> https://patchwork.kernel.org/project/linux-btrfs/patch/20210420073036.2=
43715-1-wqu@suse.com/
>>
>> Or there will be too many false alerts.
>>
>> =3D=3D=3D Limitation =3D=3D=3D
>> There are several limitations introduced just for subpage:
>> - No compressed write support
>> =C2=A0=C2=A0 Read is no problem, but compression write path has more th=
ings left to
>> =C2=A0=C2=A0 be modified.
>> =C2=A0=C2=A0 Thus for current patchset, no matter what inode attribute =
or mount
>> =C2=A0=C2=A0 option is, no new compressed extent can be created for sub=
page case.
>>
>> - No inline extent will be created
>> =C2=A0=C2=A0 This is mostly due to the fact that filemap_fdatawrite_ran=
ge() will
>> =C2=A0=C2=A0 trigger more write than the range specified.
>> =C2=A0=C2=A0 In fallocate calls, this behavior can make us to writeback=
 which can
>> =C2=A0=C2=A0 be inlined, before we enlarge the isize, causing inline ex=
tent being
>> =C2=A0=C2=A0 created along with regular extents.
>>
>> - No support for RAID56
>> =C2=A0=C2=A0 There are still too many hardcoded PAGE_SIZE in raid56 cod=
e.
>> =C2=A0=C2=A0 Considering it's already considered unsafe due to its writ=
e-hole
>> =C2=A0=C2=A0 problem, disabling RAID56 for subpage looks sane to me.
>>
>> - No defrag support for subpage
>> =C2=A0=C2=A0 The support for subpage defrag has already an initial vers=
ion
>> =C2=A0=C2=A0 submitted to the mail list.
>> =C2=A0=C2=A0 Thus the correct support won't be included in this patchse=
t.
>>
>
> I am confused about what supports as of now?

 From my latest subpage branch, everything work as expected.

Defrag support is in another patchset, which can be applied independently.

>  =C2=A0/sys/fs/btrfs/features/supported_sectorsizes

[adam@arm-btrfs linux]$ uname -a
Linux arm-btrfs 5.13.0-rc2-custom+ #5 SMP Tue Jun 1 16:11:41 CST 2021
aarch64 GNU/Linux
[adam@arm-btrfs linux]$ getconf PAGESIZE
65536
[adam@arm-btrfs linux]$ cat /sys/fs/btrfs/features/supported_sectorsizes
4096 65536

It still shows 4k as support sectorsize.

What's your branch/HEAD? And are you using 64K page size?

Thanks,
Qu

> list just the pagesize.
>
> Thanks, Anand
>
>
>> =3D=3D=3D Patchset structure =3D=3D=3D
>>
>> Patch 01~19:=C2=A0=C2=A0=C2=A0 Make data write path to be subpage compa=
tible
>> Patch 20~21:=C2=A0=C2=A0=C2=A0 Make data relocation path to be subpage =
compatible
>> Patch 22~29:=C2=A0=C2=A0=C2=A0 Various fixes for subpage corner cases
>> Patch 30:=C2=A0=C2=A0=C2=A0 Enable subpage data write
>>
>> =3D=3D=3D Changelog =3D=3D=3D
>> v2:
>> - Rebased to latest misc-next
>> =C2=A0=C2=A0 Now metadata write patches are removed from the series, as=
 they are
>> =C2=A0=C2=A0 already merged into misc-next.
>>
>> - Added new Reviewed-by/Tested-by/Reported-by tags
>>
>> - Use separate endio functions to subpage metadata write path
>>
>> - Re-order the patches, to make refactors at the top of the series
>> =C2=A0=C2=A0 One refactor, the submit_extent_page() one, should benefit=
 4K page
>> =C2=A0=C2=A0 size more than 64K page size, thus it's worthy to be merge=
d early
>>
>> - New bug fixes exposed by Ritesh Harjani on Power
>>
>> - Reject RAID56 completely
>> =C2=A0=C2=A0 Exposed by btrfs test group, which caused BUG_ON() for var=
ious sites.
>> =C2=A0=C2=A0 Considering RAID56 is already not considered safe, it's be=
tter to
>> =C2=A0=C2=A0 reject them completely for now.
>>
>> - Fix subpage scrub repair failure
>> =C2=A0=C2=A0 Caused by hardcoded PAGE_SIZE
>>
>> - Fix free space cache inode size
>> =C2=A0=C2=A0 Same cause as scrub repair failure
>>
>> v3:
>> - Rebased to remove write path prepration patches
>>
>> - Properly enable btrfs defrag
>> =C2=A0=C2=A0 Previsouly, btrfs defrag is in fact just disabled.
>> =C2=A0=C2=A0 This makes tons of tests in btrfs/defrag to fail.
>>
>> - More bug fixes for rare race/crashes
>> =C2=A0=C2=A0 * Fix relocation false alert on csum mismatch
>> =C2=A0=C2=A0 * Fix relocation data corruption
>> =C2=A0=C2=A0 * Fix a rare case of false ASSERT()
>> =C2=A0=C2=A0=C2=A0=C2=A0 The fix already get merged into the prepration=
 patches, thus no
>> =C2=A0=C2=A0=C2=A0=C2=A0 longer in this patchset though.
>> =C2=A0=C2=A0 Mostly reported by Ritesh from IBM.
>>
>> v4:
>> - Disable subpage defrag completely
>> =C2=A0=C2=A0 As full page defrag can race with fsstress in btrfs/062, c=
ausing
>> =C2=A0=C2=A0 strange ordered extent bugs.
>> =C2=A0=C2=A0 The full subpage defrag will be submitted as an indepdent =
patchset.
>>
>> Qu Wenruo (30):
>> =C2=A0=C2=A0 btrfs: pass bytenr directly to __process_pages_contig()
>> =C2=A0=C2=A0 btrfs: refactor the page status update into process_one_pa=
ge()
>> =C2=A0=C2=A0 btrfs: provide btrfs_page_clamp_*() helpers
>> =C2=A0=C2=A0 btrfs: only require sector size alignment for
>> =C2=A0=C2=A0=C2=A0=C2=A0 end_bio_extent_writepage()
>> =C2=A0=C2=A0 btrfs: make btrfs_dirty_pages() to be subpage compatible
>> =C2=A0=C2=A0 btrfs: make __process_pages_contig() to handle subpage
>> =C2=A0=C2=A0=C2=A0=C2=A0 dirty/error/writeback status
>> =C2=A0=C2=A0 btrfs: make end_bio_extent_writepage() to be subpage compa=
tible
>> =C2=A0=C2=A0 btrfs: make process_one_page() to handle subpage locking
>> =C2=A0=C2=A0 btrfs: introduce helpers for subpage ordered status
>> =C2=A0=C2=A0 btrfs: make page Ordered bit to be subpage compatible
>> =C2=A0=C2=A0 btrfs: update locked page dirty/writeback/error bits in
>> =C2=A0=C2=A0=C2=A0=C2=A0 __process_pages_contig
>> =C2=A0=C2=A0 btrfs: prevent extent_clear_unlock_delalloc() to unlock pa=
ge not
>> =C2=A0=C2=A0=C2=A0=C2=A0 locked by __process_pages_contig()
>> =C2=A0=C2=A0 btrfs: make btrfs_set_range_writeback() subpage compatible
>> =C2=A0=C2=A0 btrfs: make __extent_writepage_io() only submit dirty rang=
e for
>> =C2=A0=C2=A0=C2=A0=C2=A0 subpage
>> =C2=A0=C2=A0 btrfs: make btrfs_truncate_block() to be subpage compatibl=
e
>> =C2=A0=C2=A0 btrfs: make btrfs_page_mkwrite() to be subpage compatible
>> =C2=A0=C2=A0 btrfs: reflink: make copy_inline_to_page() to be subpage c=
ompatible
>> =C2=A0=C2=A0 btrfs: fix the filemap_range_has_page() call in
>> =C2=A0=C2=A0=C2=A0=C2=A0 btrfs_punch_hole_lock_range()
>> =C2=A0=C2=A0 btrfs: don't clear page extent mapped if we're not invalid=
ating the
>> =C2=A0=C2=A0=C2=A0=C2=A0 full page
>> =C2=A0=C2=A0 btrfs: extract relocation page read and dirty part into it=
s own
>> =C2=A0=C2=A0=C2=A0=C2=A0 function
>> =C2=A0=C2=A0 btrfs: make relocate_one_page() to handle subpage case
>> =C2=A0=C2=A0 btrfs: fix wild subpage writeback which does not have orde=
red extent.
>> =C2=A0=C2=A0 btrfs: disable inline extent creation for subpage
>> =C2=A0=C2=A0 btrfs: allow submit_extent_page() to do bio split for subp=
age
>> =C2=A0=C2=A0 btrfs: reject raid5/6 fs for subpage
>> =C2=A0=C2=A0 btrfs: fix a crash caused by race between prepare_pages() =
and
>> =C2=A0=C2=A0=C2=A0=C2=A0 btrfs_releasepage()
>> =C2=A0=C2=A0 btrfs: fix a use-after-free bug in writeback subpage helpe=
r
>> =C2=A0=C2=A0 btrfs: fix a subpage false alert for relocating partial pr=
eallocated
>> =C2=A0=C2=A0=C2=A0=C2=A0 data extents
>> =C2=A0=C2=A0 btrfs: fix a subpage relocation data corruption
>> =C2=A0=C2=A0 btrfs: allow read-write for 4K sectorsize on 64K page size=
 systems
>>
>> =C2=A0 fs/btrfs/ctree.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 2 +-
>> =C2=A0 fs/btrfs/disk-io.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 13 +-
>> =C2=A0 fs/btrfs/extent_io.c=C2=A0=C2=A0=C2=A0 | 563 +++++++++++++++++++=
+++++++++------------
>> =C2=A0 fs/btrfs/file.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0 32 ++-
>> =C2=A0 fs/btrfs/inode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 147=
 +++++++++--
>> =C2=A0 fs/btrfs/ioctl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 6 +
>> =C2=A0 fs/btrfs/ordered-data.c |=C2=A0=C2=A0 5 +-
>> =C2=A0 fs/btrfs/reflink.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 14 +-
>> =C2=A0 fs/btrfs/relocation.c=C2=A0=C2=A0 | 287 ++++++++++++--------
>> =C2=A0 fs/btrfs/subpage.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 156 +++++++++=
+-
>> =C2=A0 fs/btrfs/subpage.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 31 +++
>> =C2=A0 fs/btrfs/super.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 7 -
>> =C2=A0 fs/btrfs/sysfs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 5 +
>> =C2=A0 fs/btrfs/volumes.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8=
 +
>> =C2=A0 14 files changed, 949 insertions(+), 327 deletions(-)
>>
>
