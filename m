Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF9D395B1A
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 May 2021 15:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbhEaNKn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 May 2021 09:10:43 -0400
Received: from mout.gmx.net ([212.227.15.15]:38997 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231327AbhEaNKl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 May 2021 09:10:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1622466539;
        bh=6dtnOaJn1/S/n4hHqF4gKdJaLnvdl5K6qa0dD++N4RE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Lvn1h0jueGgEnmXuBEYMHE6CbppK2LzbuWL7zRpdmSm1/RGppSbKx0CAgm+jLLeHV
         6JcEV9PSERZMcqX5aeipmzKmDgSX/dWacn5xPjcF5J3Nd45ci+S4r6qe28x+O5MaVX
         OkiZ9ll1cdXdHnZ86oR5sj33nEyT/pSxMT9aKM0E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MgNh7-1lBrLJ1Wfv-00hw6b; Mon, 31
 May 2021 15:08:58 +0200
Subject: Re: [PATCH v4 00/30] btrfs: add data write support for subpage
To:     Neal Gompa <ngompa13@gmail.com>
Cc:     Qu Wenruo <wqu@suse.com>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <20210531085106.259490-1-wqu@suse.com>
 <CAEg-Je_0FrdEYKsHKb3e-kL2zehawwA9UVVmv+2wVC_+wQTC1Q@mail.gmail.com>
 <3e254c57-b82c-443c-a05e-d18fdf261e41@gmx.com>
 <CAEg-Je8b74AHC32Z7Zwrfz_83bBSLjaU58AdzvgSanBNoZ3X=w@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <20453a76-2e2c-7b07-b0b1-dce7507e5ebd@gmx.com>
Date:   Mon, 31 May 2021 21:08:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAEg-Je8b74AHC32Z7Zwrfz_83bBSLjaU58AdzvgSanBNoZ3X=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:d3dthrrX49F5OGwUNPIKGoSpe739KOw8rZ2MMvoCnrMSb5oVO2E
 qbt2GvKaVQA+cczfDdsB5YdKQg0OQ7no7AJNgREm/UoMovqdeSeg+BfCsuklhHqr3PyXDKo
 YB1za2boCl9PmlyFt16XqwNmF8XOOQvYif99OAXQfNHBYj61hOpFXK9eI3DMPXLINI7Jihl
 0HMNgGAZXo60st3SnmCfw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RWO2KjgbP5g=:MQRrpUEuYnFJtdIECoZT14
 5gl8L25T/D49dBP1cCMXevbc1zgybXL1FWfE1srmgJnjW9F1QHk1e0lDctwGbwioRQHR5MtF8
 z1QK7uIrRV4sWGSB3fgtb9VlXwgyQU24BGeFMQr0NswRiN8eEH5YWdxDxgh21kjOUVr5YfhPg
 9Sc9EyYo3I+G3uqZIOAiSs1y6tzsefdde9McjnRhQjCuFURAjsVbwodeOG6Cn0gZxO+4ZvBfT
 phfCes0AMjhxCchyNq1+Z384mOBVJMKoJTz/ElBATwNu61K8yL13ecHtT7yoOqxcynLZmmFFw
 UwY+aiOutZ/6V5LcBgqVFLvbmC5iFa9LAUx5YsBqUKPNC7QKoeBLfjJ7M9mG8dkPSUUp4QPjY
 VMHvx8T7/6KQ4PUH+URhEU2l30UCPxByslOaOtKb1Hk+J0YeXg88CXOw35uwHpawx5TG502DE
 AZr80iCSEyxsfHjkYe3ZH+nk9YBdaULA6X2QK1P0fJY/S1BObV8GnVde4phDoi9fr3fy0pA2X
 q7+yATIRSm1oZZa6oKs1agPQoEl9/P+1YVsEJn5+mItRlmK6mGIx2Z/I+VXn0mKgKc92n9AxT
 mABBcuPwHEOl2K0SJfgAcg1FCoV5OLaO/39qQeEggvNVg4FFfKT399Vsw4uEsX5qI8kuz4+uG
 99jdoUzY3+v1XEfNFRqSPnHFl3dElfz3v0NdCTKMhH6DKzNoyphAQ1ZdWhR6LQgnXGRbZ4TJd
 tXqJ9t+aSvGKFJMn50ekaUQigEjAu0enhl0KKFNOF8Cnk1KzobhAUJNrJ8+CfUgEtLvpnwosy
 TEB/5VzpcOJg0Su9A4ZflzbQ2qVYSQFJoweLPYKv2po58m65ysKHwInJdkw7q95cEBSvrNICD
 1Fq7PKzJ75OuJVVNOIjVgvXmiOCrN5gUrJdU7L3K6yPY+rJckCc/fcrQPPAujWRlWB2tvOBNh
 WGED5+SCzDJGqT3sahcCBYnVQQ57shtjYpWhKHWsSxS/eet3pPhzvw/3Uo5sJIE1R5SsKYCS5
 27uC8K637HZNTT5wX4UM+A9Q5z36avd8E4WWDF4xOCxCxAe4eExxcfMsLYru+bkPggpbxdZ7/
 HpAoGcONVvliu4KwaFphxi8Lgy0EYNr481Yc7/7lKLCg3+qqyF8H+kxSUL/dWCvVhZAc6MJgB
 omYVH4Lz+nsMBPyPLYvftuOjwF5fXpgTtU9DD4n22w0D2rg/KhumhJiuf5lqznPZT+xKR03/A
 lzvjT1pidkiUZWLqI
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/31 =E4=B8=8B=E5=8D=888:17, Neal Gompa wrote:
> On Mon, May 31, 2021 at 5:50 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>>
>>
>>
>> On 2021/5/31 =E4=B8=8B=E5=8D=885:47, Neal Gompa wrote:
>>> On Mon, May 31, 2021 at 4:52 AM Qu Wenruo <wqu@suse.com> wrote:
>>>>
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
>>>> Or there will be too many false alerts.
>>>>
>>>> =3D=3D=3D Limitation =3D=3D=3D
>>>> There are several limitations introduced just for subpage:
>>>> - No compressed write support
>>>>     Read is no problem, but compression write path has more things le=
ft to
>>>>     be modified.
>>>>     Thus for current patchset, no matter what inode attribute or moun=
t
>>>>     option is, no new compressed extent can be created for subpage ca=
se.
>>>>
>>>> - No inline extent will be created
>>>>     This is mostly due to the fact that filemap_fdatawrite_range() wi=
ll
>>>>     trigger more write than the range specified.
>>>>     In fallocate calls, this behavior can make us to writeback which =
can
>>>>     be inlined, before we enlarge the isize, causing inline extent be=
ing
>>>>     created along with regular extents.
>>>>
>>>> - No support for RAID56
>>>>     There are still too many hardcoded PAGE_SIZE in raid56 code.
>>>>     Considering it's already considered unsafe due to its write-hole
>>>>     problem, disabling RAID56 for subpage looks sane to me.
>>>>
>>>> - No defrag support for subpage
>>>>     The support for subpage defrag has already an initial version
>>>>     submitted to the mail list.
>>>>     Thus the correct support won't be included in this patchset.
>>>>
>>>> =3D=3D=3D Patchset structure =3D=3D=3D
>>>>
>>>> Patch 01~19:    Make data write path to be subpage compatible
>>>> Patch 20~21:    Make data relocation path to be subpage compatible
>>>> Patch 22~29:    Various fixes for subpage corner cases
>>>> Patch 30:       Enable subpage data write
>>>>
>>>> =3D=3D=3D Changelog =3D=3D=3D
>>>> v2:
>>>> - Rebased to latest misc-next
>>>>     Now metadata write patches are removed from the series, as they a=
re
>>>>     already merged into misc-next.
>>>>
>>>> - Added new Reviewed-by/Tested-by/Reported-by tags
>>>>
>>>> - Use separate endio functions to subpage metadata write path
>>>>
>>>> - Re-order the patches, to make refactors at the top of the series
>>>>     One refactor, the submit_extent_page() one, should benefit 4K pag=
e
>>>>     size more than 64K page size, thus it's worthy to be merged early
>>>>
>>>> - New bug fixes exposed by Ritesh Harjani on Power
>>>>
>>>> - Reject RAID56 completely
>>>>     Exposed by btrfs test group, which caused BUG_ON() for various si=
tes.
>>>>     Considering RAID56 is already not considered safe, it's better to
>>>>     reject them completely for now.
>>>>
>>>> - Fix subpage scrub repair failure
>>>>     Caused by hardcoded PAGE_SIZE
>>>>
>>>> - Fix free space cache inode size
>>>>     Same cause as scrub repair failure
>>>>
>>>> v3:
>>>> - Rebased to remove write path prepration patches
>>>>
>>>> - Properly enable btrfs defrag
>>>>     Previsouly, btrfs defrag is in fact just disabled.
>>>>     This makes tons of tests in btrfs/defrag to fail.
>>>>
>>>> - More bug fixes for rare race/crashes
>>>>     * Fix relocation false alert on csum mismatch
>>>>     * Fix relocation data corruption
>>>>     * Fix a rare case of false ASSERT()
>>>>       The fix already get merged into the prepration patches, thus no
>>>>       longer in this patchset though.
>>>>
>>>>     Mostly reported by Ritesh from IBM.
>>>>
>>>> v4:
>>>> - Disable subpage defrag completely
>>>>     As full page defrag can race with fsstress in btrfs/062, causing
>>>>     strange ordered extent bugs.
>>>>     The full subpage defrag will be submitted as an indepdent patchse=
t.
>>>>
>>>> Qu Wenruo (30):
>>>>     btrfs: pass bytenr directly to __process_pages_contig()
>>>>     btrfs: refactor the page status update into process_one_page()
>>>>     btrfs: provide btrfs_page_clamp_*() helpers
>>>>     btrfs: only require sector size alignment for
>>>>       end_bio_extent_writepage()
>>>>     btrfs: make btrfs_dirty_pages() to be subpage compatible
>>>>     btrfs: make __process_pages_contig() to handle subpage
>>>>       dirty/error/writeback status
>>>>     btrfs: make end_bio_extent_writepage() to be subpage compatible
>>>>     btrfs: make process_one_page() to handle subpage locking
>>>>     btrfs: introduce helpers for subpage ordered status
>>>>     btrfs: make page Ordered bit to be subpage compatible
>>>>     btrfs: update locked page dirty/writeback/error bits in
>>>>       __process_pages_contig
>>>>     btrfs: prevent extent_clear_unlock_delalloc() to unlock page not
>>>>       locked by __process_pages_contig()
>>>>     btrfs: make btrfs_set_range_writeback() subpage compatible
>>>>     btrfs: make __extent_writepage_io() only submit dirty range for
>>>>       subpage
>>>>     btrfs: make btrfs_truncate_block() to be subpage compatible
>>>>     btrfs: make btrfs_page_mkwrite() to be subpage compatible
>>>>     btrfs: reflink: make copy_inline_to_page() to be subpage compatib=
le
>>>>     btrfs: fix the filemap_range_has_page() call in
>>>>       btrfs_punch_hole_lock_range()
>>>>     btrfs: don't clear page extent mapped if we're not invalidating t=
he
>>>>       full page
>>>>     btrfs: extract relocation page read and dirty part into its own
>>>>       function
>>>>     btrfs: make relocate_one_page() to handle subpage case
>>>>     btrfs: fix wild subpage writeback which does not have ordered ext=
ent.
>>>>     btrfs: disable inline extent creation for subpage
>>>>     btrfs: allow submit_extent_page() to do bio split for subpage
>>>>     btrfs: reject raid5/6 fs for subpage
>>>>     btrfs: fix a crash caused by race between prepare_pages() and
>>>>       btrfs_releasepage()
>>>>     btrfs: fix a use-after-free bug in writeback subpage helper
>>>>     btrfs: fix a subpage false alert for relocating partial prealloca=
ted
>>>>       data extents
>>>>     btrfs: fix a subpage relocation data corruption
>>>>     btrfs: allow read-write for 4K sectorsize on 64K page size system=
s
>>>>
>>>>    fs/btrfs/ctree.h        |   2 +-
>>>>    fs/btrfs/disk-io.c      |  13 +-
>>>>    fs/btrfs/extent_io.c    | 563 ++++++++++++++++++++++++++++--------=
----
>>>>    fs/btrfs/file.c         |  32 ++-
>>>>    fs/btrfs/inode.c        | 147 +++++++++--
>>>>    fs/btrfs/ioctl.c        |   6 +
>>>>    fs/btrfs/ordered-data.c |   5 +-
>>>>    fs/btrfs/reflink.c      |  14 +-
>>>>    fs/btrfs/relocation.c   | 287 ++++++++++++--------
>>>>    fs/btrfs/subpage.c      | 156 ++++++++++-
>>>>    fs/btrfs/subpage.h      |  31 +++
>>>>    fs/btrfs/super.c        |   7 -
>>>>    fs/btrfs/sysfs.c        |   5 +
>>>>    fs/btrfs/volumes.c      |   8 +
>>>>    14 files changed, 949 insertions(+), 327 deletions(-)
>>>>
>>>
>>> Could you please rebase your branch on 5.13-rc4? I'd rather test it on
>>> top of that release...
>>>
>>>
>> It can be rebased on david's misc-next branch without any conflicts.
>> Although misc-next is only on v5.13-rc3, I don't believe there will be
>> anything btrfs related out of misc-next.
>>
>> Is there anything special only show up in -rc4?
>>
>
> Not particularly. I just want to layer it on top of what's shipping in
> Fedora Rawhide to test it there locally. Admittedly, Rawhide is still
> at ad9f25d33860, which is just a bit above rc3. Nevertheless, the
> patch doesn't apply right now, so it's a bit hard to test beyond the
> "I compiled it locally and it doesn't break my system" level.

The failure to apply is more or less expected, as this patchset is
dependent on subpage data write preparation patchset.
Which is not yet merged, but already in misc-next branch.
(Which also reduces overhead for 4K page size)

Thus it's recommended to grab the branch, other than applying it upon
upstream commit.

Thanks,
Qu
