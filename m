Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9333039F2D6
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jun 2021 11:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbhFHJwf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Jun 2021 05:52:35 -0400
Received: from mout.gmx.net ([212.227.17.21]:34817 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230145AbhFHJwd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 8 Jun 2021 05:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623145835;
        bh=3eiLLB4eDHFDLHdvySePj6FrgA9XiMhj182ArgJTtLc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ZZFQo5HTT03LN36kaFuycQQ0CXlnEv773cg8BE4R512d2A40g9+H/Q4YQQB9bB9pf
         Hv7zFA798SsvhZy1zQxJKpuAXtQbViGG8fiTVx/RKXVVBYrTbw9X8q2svU9yPhNJ3X
         Gximnlz8uk0ij+AhJWS18oZfUhG5nvB7H/EHdIKo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MSbx3-1lwu0Z2vyD-00T0Qb; Tue, 08
 Jun 2021 11:50:35 +0200
Subject: Re: [PATCH v4 00/30] btrfs: add data write support for subpage
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210531085106.259490-1-wqu@suse.com>
 <55ba3489-98de-3a69-8912-3a32e73ffca4@oracle.com>
 <a1a2aebb-759d-35a2-ade0-3a0119346166@gmx.com>
 <b1eed283-af02-8052-40f4-b671ee17ac6f@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <d973de78-ae22-b3b6-be6f-b023a60ee90e@gmx.com>
Date:   Tue, 8 Jun 2021 17:50:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <b1eed283-af02-8052-40f4-b671ee17ac6f@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Kr+Mo6pl25xahZd14SSyndDELX6ADtxonyeKgjPrtmqXKVWFJDm
 hfBjNuAHN5nMhzZSZPdVMiKdJz57jtMuP9llihhb30HKYi4F5s+isQ813dbNkK2RItRLeFf
 0T9lKrhPonH0omcEN1q03eU1gkdibYUPVzpwPl2DTcs7w/nmz5Z93zi8k1aT4/RumsMENyS
 mTeSbH7DZ1C+O8/62juHQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qLbdnmWt71I=:TPxvVv6iinLi+dIioObaec
 ec1O4ygviDCUzNT8z/OiLSXtaGMoUaVf8X4b4vmVWmxhztLLjOv9qnpUO5hnjwGQncpB+7aaZ
 rSr+D8rBFjTLouDVwGlrNCbXetRCn3kzWcHWjVgsSfsb7zN88/5GLzqA6wzjUW8OARisnzCiT
 TU/lVLcCDS4xVctnOPTIt1NeG/VHm7EZaebrWqQca2JW5ZWRZOfxQTaEdnINnu5RaKKbjYaeT
 vS4QJD2Fjlf9a57wZMSGL6HB4t9teVhPqAkq1qKEApXGtJ7tFHIM6InvbcRa+3PdFxhGGjguB
 Hgxh/oFssIes1V8N5pQ8U7NyTARWFKE0b/E09GiVSgkZDiYWB2j0hM3y4ByiV715bz3MlPgBi
 49Ixap7uLW6G7JgIhPAhlWtz93QcPj4D2XCZHAE4BHNcthk0JONQ7Aq+b1qMLSzNEmUSwuI9k
 QInGHSJCtIMp+nY2jy556w3QtizInVRS1p56oDjBXahgB2L0F8/KIkmKAMd8xVst3tDQxb3fz
 vmAVfTA6L4RV86khA6QvlW1R++HPt3nSwpFKbyvwTkXn+B07y0x2KiQVTQPl/84W+RH5+6elJ
 4B9AIAN8c4HII64xRM4KEC+GPV06kwcCvrzbG9nRs3f9BnaZTZfHqC0deh93IL9YBYh0yTway
 htTBSvVCVFrDyjfcw3MGg8ISjoQ0HcIfNOvMLHwwzhz0M7J19vEVyRv5mFDR9CkdNDYa+Ay6z
 axDuJDz3Z4objSNfLoys/xErukNws9vmzCTmN05Guj3E+/+PktKkDMPfsgcTaxN0XFIpLCTn5
 a1lsgKbGYeG8UeerL1g+sOGM5y4mi1wtVJf7RnjdnThixv9gB5NHORFWJsBwO0vBZNpxozAEB
 ho4ydqFdH7IIKM/WKKvplrgcULsL1cXaCGa8GqTGCFEz2yPcof7Nw500N6UevMP1c66bIdOaQ
 WMq4qxFa2HbaUlo9NZi0ZNCPOugqvLcxHSz958sRKiKApNaGQ9O/YObfYPNJFcIrx7dxdvN58
 Cj0I9TeI/2VS4tgevnqLI/jiexI/ja1V23mZowmtBgGs00CCW1Rk8HKGNU22bYOIiFZ7yRxvK
 bpYTPpBsROn/QgnmLF9WRa5g61mJwh2d5cocEuxs8KSWQNrEmmoFFvvdQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/8 =E4=B8=8B=E5=8D=885:45, Anand Jain wrote:
>
>
> On 8/6/21 5:02 pm, Qu Wenruo wrote:
>>
>>
>> On 2021/6/8 =E4=B8=8B=E5=8D=884:23, Anand Jain wrote:
>>> On 31/5/21 4:50 pm, Qu Wenruo wrote:
>>>> This huge patchset can be fetched from github:
>>>> https://github.com/adam900710/linux/tree/subpage
>>>>
>>>> =3D=3D=3D Current stage =3D=3D=3D
>>>> The tests on x86 pass without new failure, and generic test group on
>>>> arm64 with 64K page size passes except known failure and defrag group=
.
>>>>
>>>> For btrfs test group, all pass except compression/raid56/defrag.
>>>>
>>>> For anyone who is interested in testing, please apply this patch for
>>>> btrfs-progs before testing.
>>>> https://patchwork.kernel.org/project/linux-btrfs/patch/20210420073036=
.243715-1-wqu@suse.com/
>>>>
>>>>
>>>> Or there will be too many false alerts.
>>>>
>>>> =3D=3D=3D Limitation =3D=3D=3D
>>>> There are several limitations introduced just for subpage:
>>>> - No compressed write support
>>>> =C2=A0=C2=A0 Read is no problem, but compression write path has more =
things
>>>> left to
>>>> =C2=A0=C2=A0 be modified.
>>>> =C2=A0=C2=A0 Thus for current patchset, no matter what inode attribut=
e or mount
>>>> =C2=A0=C2=A0 option is, no new compressed extent can be created for s=
ubpage case.
>>>>
>>>> - No inline extent will be created
>>>> =C2=A0=C2=A0 This is mostly due to the fact that filemap_fdatawrite_r=
ange() will
>>>> =C2=A0=C2=A0 trigger more write than the range specified.
>>>> =C2=A0=C2=A0 In fallocate calls, this behavior can make us to writeba=
ck which can
>>>> =C2=A0=C2=A0 be inlined, before we enlarge the isize, causing inline =
extent being
>>>> =C2=A0=C2=A0 created along with regular extents.
>>>>
>>>> - No support for RAID56
>>>> =C2=A0=C2=A0 There are still too many hardcoded PAGE_SIZE in raid56 c=
ode.
>>>> =C2=A0=C2=A0 Considering it's already considered unsafe due to its wr=
ite-hole
>>>> =C2=A0=C2=A0 problem, disabling RAID56 for subpage looks sane to me.
>>>>
>>>> - No defrag support for subpage
>>>> =C2=A0=C2=A0 The support for subpage defrag has already an initial ve=
rsion
>>>> =C2=A0=C2=A0 submitted to the mail list.
>>>> =C2=A0=C2=A0 Thus the correct support won't be included in this patch=
set.
>>>>
>>>
>>> I am confused about what supports as of now?
>>
>> =C2=A0From my latest subpage branch, everything work as expected.
>>
>> Defrag support is in another patchset, which can be applied
>> independently.
>>
>>> =C2=A0=C2=A0/sys/fs/btrfs/features/supported_sectorsizes
>>
>> [adam@arm-btrfs linux]$ uname -a
>> Linux arm-btrfs 5.13.0-rc2-custom+ #5 SMP Tue Jun 1 16:11:41 CST 2021
>> aarch64 GNU/Linux
>> [adam@arm-btrfs linux]$ getconf PAGESIZE
>> 65536
>> [adam@arm-btrfs linux]$ cat /sys/fs/btrfs/features/supported_sectorsize=
s
>> 4096 65536
>>
>> It still shows 4k as support sectorsize.
>>
>> What's your branch/HEAD? And are you using 64K page size?
>>
>
>  =C2=A0I am on misc-next (which contains all these 30 patches). I don't =
see
> subpages supported. Is there any patch I missed?

misc-next doesn't have full support yet.

It lacks:
- Relocation support
- Bio split support
- Various subpage specific fixes

Thus no subpage enabling patch.

Thanks,
Qu
>
>  =C2=A0$ cat /sys/fs/btrfs/features/supported_sectorsizes
> 65536
>
> Thanks, Anand
>
>> Thanks,
>> Qu
>>
>>> list just the pagesize.
>>>
>>> Thanks, Anand
>>>
>>>
>>>> =3D=3D=3D Patchset structure =3D=3D=3D
>>>>
>>>> Patch 01~19:=C2=A0=C2=A0=C2=A0 Make data write path to be subpage com=
patible
>>>> Patch 20~21:=C2=A0=C2=A0=C2=A0 Make data relocation path to be subpag=
e compatible
>>>> Patch 22~29:=C2=A0=C2=A0=C2=A0 Various fixes for subpage corner cases
>>>> Patch 30:=C2=A0=C2=A0=C2=A0 Enable subpage data write
>>>>
>>>> =3D=3D=3D Changelog =3D=3D=3D
>>>> v2:
>>>> - Rebased to latest misc-next
>>>> =C2=A0=C2=A0 Now metadata write patches are removed from the series, =
as they are
>>>> =C2=A0=C2=A0 already merged into misc-next.
>>>>
>>>> - Added new Reviewed-by/Tested-by/Reported-by tags
>>>>
>>>> - Use separate endio functions to subpage metadata write path
>>>>
>>>> - Re-order the patches, to make refactors at the top of the series
>>>> =C2=A0=C2=A0 One refactor, the submit_extent_page() one, should benef=
it 4K page
>>>> =C2=A0=C2=A0 size more than 64K page size, thus it's worthy to be mer=
ged early
>>>>
>>>> - New bug fixes exposed by Ritesh Harjani on Power
>>>>
>>>> - Reject RAID56 completely
>>>> =C2=A0=C2=A0 Exposed by btrfs test group, which caused BUG_ON() for v=
arious
>>>> sites.
>>>> =C2=A0=C2=A0 Considering RAID56 is already not considered safe, it's =
better to
>>>> =C2=A0=C2=A0 reject them completely for now.
>>>>
>>>> - Fix subpage scrub repair failure
>>>> =C2=A0=C2=A0 Caused by hardcoded PAGE_SIZE
>>>>
>>>> - Fix free space cache inode size
>>>> =C2=A0=C2=A0 Same cause as scrub repair failure
>>>>
>>>> v3:
>>>> - Rebased to remove write path prepration patches
>>>>
>>>> - Properly enable btrfs defrag
>>>> =C2=A0=C2=A0 Previsouly, btrfs defrag is in fact just disabled.
>>>> =C2=A0=C2=A0 This makes tons of tests in btrfs/defrag to fail.
>>>>
>>>> - More bug fixes for rare race/crashes
>>>> =C2=A0=C2=A0 * Fix relocation false alert on csum mismatch
>>>> =C2=A0=C2=A0 * Fix relocation data corruption
>>>> =C2=A0=C2=A0 * Fix a rare case of false ASSERT()
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 The fix already get merged into the preprati=
on patches, thus no
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 longer in this patchset though.
>>>> =C2=A0=C2=A0 Mostly reported by Ritesh from IBM.
>>>>
>>>> v4:
>>>> - Disable subpage defrag completely
>>>> =C2=A0=C2=A0 As full page defrag can race with fsstress in btrfs/062,=
 causing
>>>> =C2=A0=C2=A0 strange ordered extent bugs.
>>>> =C2=A0=C2=A0 The full subpage defrag will be submitted as an indepden=
t patchset.
>>>>
>>>> Qu Wenruo (30):
>>>> =C2=A0=C2=A0 btrfs: pass bytenr directly to __process_pages_contig()
>>>> =C2=A0=C2=A0 btrfs: refactor the page status update into process_one_=
page()
>>>> =C2=A0=C2=A0 btrfs: provide btrfs_page_clamp_*() helpers
>>>> =C2=A0=C2=A0 btrfs: only require sector size alignment for
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 end_bio_extent_writepage()
>>>> =C2=A0=C2=A0 btrfs: make btrfs_dirty_pages() to be subpage compatible
>>>> =C2=A0=C2=A0 btrfs: make __process_pages_contig() to handle subpage
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 dirty/error/writeback status
>>>> =C2=A0=C2=A0 btrfs: make end_bio_extent_writepage() to be subpage com=
patible
>>>> =C2=A0=C2=A0 btrfs: make process_one_page() to handle subpage locking
>>>> =C2=A0=C2=A0 btrfs: introduce helpers for subpage ordered status
>>>> =C2=A0=C2=A0 btrfs: make page Ordered bit to be subpage compatible
>>>> =C2=A0=C2=A0 btrfs: update locked page dirty/writeback/error bits in
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 __process_pages_contig
>>>> =C2=A0=C2=A0 btrfs: prevent extent_clear_unlock_delalloc() to unlock =
page not
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 locked by __process_pages_contig()
>>>> =C2=A0=C2=A0 btrfs: make btrfs_set_range_writeback() subpage compatib=
le
>>>> =C2=A0=C2=A0 btrfs: make __extent_writepage_io() only submit dirty ra=
nge for
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 subpage
>>>> =C2=A0=C2=A0 btrfs: make btrfs_truncate_block() to be subpage compati=
ble
>>>> =C2=A0=C2=A0 btrfs: make btrfs_page_mkwrite() to be subpage compatibl=
e
>>>> =C2=A0=C2=A0 btrfs: reflink: make copy_inline_to_page() to be subpage=
 compatible
>>>> =C2=A0=C2=A0 btrfs: fix the filemap_range_has_page() call in
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 btrfs_punch_hole_lock_range()
>>>> =C2=A0=C2=A0 btrfs: don't clear page extent mapped if we're not inval=
idating the
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 full page
>>>> =C2=A0=C2=A0 btrfs: extract relocation page read and dirty part into =
its own
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 function
>>>> =C2=A0=C2=A0 btrfs: make relocate_one_page() to handle subpage case
>>>> =C2=A0=C2=A0 btrfs: fix wild subpage writeback which does not have or=
dered
>>>> extent.
>>>> =C2=A0=C2=A0 btrfs: disable inline extent creation for subpage
>>>> =C2=A0=C2=A0 btrfs: allow submit_extent_page() to do bio split for su=
bpage
>>>> =C2=A0=C2=A0 btrfs: reject raid5/6 fs for subpage
>>>> =C2=A0=C2=A0 btrfs: fix a crash caused by race between prepare_pages(=
) and
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 btrfs_releasepage()
>>>> =C2=A0=C2=A0 btrfs: fix a use-after-free bug in writeback subpage hel=
per
>>>> =C2=A0=C2=A0 btrfs: fix a subpage false alert for relocating partial =
preallocated
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 data extents
>>>> =C2=A0=C2=A0 btrfs: fix a subpage relocation data corruption
>>>> =C2=A0=C2=A0 btrfs: allow read-write for 4K sectorsize on 64K page si=
ze systems
>>>>
>>>> =C2=A0 fs/btrfs/ctree.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 2 +-
>>>> =C2=A0 fs/btrfs/disk-io.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 13 +-
>>>> =C2=A0 fs/btrfs/extent_io.c=C2=A0=C2=A0=C2=A0 | 563
>>>> ++++++++++++++++++++++++++++------------
>>>> =C2=A0 fs/btrfs/file.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 32 ++-
>>>> =C2=A0 fs/btrfs/inode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1=
47 +++++++++--
>>>> =C2=A0 fs/btrfs/ioctl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 6 +
>>>> =C2=A0 fs/btrfs/ordered-data.c |=C2=A0=C2=A0 5 +-
>>>> =C2=A0 fs/btrfs/reflink.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 14 +-
>>>> =C2=A0 fs/btrfs/relocation.c=C2=A0=C2=A0 | 287 ++++++++++++--------
>>>> =C2=A0 fs/btrfs/subpage.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 156 +++++++=
+++-
>>>> =C2=A0 fs/btrfs/subpage.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 31 ++=
+
>>>> =C2=A0 fs/btrfs/super.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 7 -
>>>> =C2=A0 fs/btrfs/sysfs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 5 +
>>>> =C2=A0 fs/btrfs/volumes.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
 8 +
>>>> =C2=A0 14 files changed, 949 insertions(+), 327 deletions(-)
>>>>
>>>
