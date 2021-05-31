Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4914395871
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 May 2021 11:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbhEaJwZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 May 2021 05:52:25 -0400
Received: from mout.gmx.net ([212.227.15.18]:60607 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230520AbhEaJwT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 May 2021 05:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1622454631;
        bh=M/9ZVGoap6s6ogMhiFfCCb0VPioAGjItos7VhxfJEsQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=MZ1oWCNEU/6e4xG+eOLBaAZTlsM0uT4PlWBL4Zrfcs9sMahS1DiOcqjkBJLKBZrWo
         gBMgKBZf/2wnpmYO70Zqnni0hJ7Sli2JyYW/y2nGMx6RX4o+wWSVDTTKkfT8lxEvD3
         m5/vhoS4SH1LvPKJRJQFjyxnOo/D1ryvzdrHAroU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MsYqv-1lZ1KP1Y5L-00u4jz; Mon, 31
 May 2021 11:50:30 +0200
Subject: Re: [PATCH v4 00/30] btrfs: add data write support for subpage
To:     Neal Gompa <ngompa13@gmail.com>, Qu Wenruo <wqu@suse.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <20210531085106.259490-1-wqu@suse.com>
 <CAEg-Je_0FrdEYKsHKb3e-kL2zehawwA9UVVmv+2wVC_+wQTC1Q@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <3e254c57-b82c-443c-a05e-d18fdf261e41@gmx.com>
Date:   Mon, 31 May 2021 17:50:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAEg-Je_0FrdEYKsHKb3e-kL2zehawwA9UVVmv+2wVC_+wQTC1Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Nx4DuNEd4/n84xs2hp4SQKIMl/ksiIqu/6J0A385dAerHTuc352
 LrNrOVM6FcmvfoCXFPxgTurPAs0xmIje7rG6f7iW5lS6xyQ38NN6dGq+QtrANI5v60bEcQH
 YvKPzAhp811xDNDoyC0QHQQGT7ZfId7/BYcCPRdEUdXkma112bNf5IwuSfPzyn5rdB7CCoq
 wzsvTn9jji5eB8pYWdQ6g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1fFtVDc1ChA=:W8rgvVxw3tBtm2KPsWjjUl
 VpIUdn6FaS75Gk9imGDlipszyX1w4w/O/+zmPSoHfFQR2XkqqkJBvzKa87VrzSfJkUDpZergd
 OQobuoTmMopuM0tJEQheCuy3uZiSvOc46Bmu6jOthN6woE0hzHEj+/zNmyHMH0HTGCmzD7Tgh
 HMvNBJpHIZXHDoYm9x7adyg0X8/BbjR19wClkfSMZJpts8Hj6QHK/apn4Q89AE0/+2RBWfM0v
 TNjbrf2hZ4ROjfdhf1shtLcZm+JwA5O6SNWf8gpWF0ZVy8jQ7dlndiK+sgPxJPXAHL3uEHtuP
 91fnFWgmArEE+udr44tLOKYFJEtEiSbnhYyrRzoSOKc4apEU8ScrD0dXxOfkTpFwGMcXenb1T
 1yb2DWKa98249mWBrXlkly8JSolb3H9OFhbC6Wu/s/npumU9pM+ZF/w1Ba6ptq6Q0YtCgemA3
 BVsS48Nl8qYa/cDC5YUEOz4b/Ly9tKMisTc9CpsE9Ujia7Q+X5ciXfU4tQv+pJFfZYiUIXIZV
 6emTClL8BxmcYAoPTTiLLQs+N8Jam+dsaslvKZORu10aLfjwVdSZnOhmd4SRUgS/ey2niml//
 rD5YhjDabyRZaI4nmVAKliGXHwOv+SL5itGTpWSO0mDFo42DLqghbtnlEKHuX4WytwDptK8OD
 A3ao8Hqp6ay+8BghNdX2otWn7sz6hkBavOubFXoHzWjSOF3Bk3no3mL8A51zPBCZlpGjsyhp6
 aqFVCzPHgmRhAFBDXNvpmOe9ak7T2bQWLSklWuTbgOz+bOX2bVhtkH94BGN7vTzCLMUlsxc0o
 45zDlas0U3R3/MhCIYDMw3S39193o1oQ/g1co84pamOskUqBfTERkclgvi13iMAqJsXHptbhB
 WuTIna2oW+abzufeScTzo67I4kraLMSIFy+nQPlegeISuuYiXTYxYUHRHJpzd/bBaLWhKx2Ww
 tF2gP8NFdlIrtLo+6Nm19w5QswLLaqRxdztW6tI0RuU1eLUveP1Do8OoAUohZhs3NI3QkglNv
 FDPLzBcF0aZ+JAm1E5flv2nDKA+qaMyrf+FxPEKmr7vokZXAlqvAydtBY/LAVMDPOaKoRpB75
 C0m65piUFKHzuw1BaRJpDCcD4NYqS5DABvimC+NywS8uxcN9rvXHFzgQA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/31 =E4=B8=8B=E5=8D=885:47, Neal Gompa wrote:
> On Mon, May 31, 2021 at 4:52 AM Qu Wenruo <wqu@suse.com> wrote:
>>
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
>> - No defrag support for subpage
>>    The support for subpage defrag has already an initial version
>>    submitted to the mail list.
>>    Thus the correct support won't be included in this patchset.
>>
>> =3D=3D=3D Patchset structure =3D=3D=3D
>>
>> Patch 01~19:    Make data write path to be subpage compatible
>> Patch 20~21:    Make data relocation path to be subpage compatible
>> Patch 22~29:    Various fixes for subpage corner cases
>> Patch 30:       Enable subpage data write
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
>> v4:
>> - Disable subpage defrag completely
>>    As full page defrag can race with fsstress in btrfs/062, causing
>>    strange ordered extent bugs.
>>    The full subpage defrag will be submitted as an indepdent patchset.
>>
>> Qu Wenruo (30):
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
>>   fs/btrfs/extent_io.c    | 563 ++++++++++++++++++++++++++++-----------=
-
>>   fs/btrfs/file.c         |  32 ++-
>>   fs/btrfs/inode.c        | 147 +++++++++--
>>   fs/btrfs/ioctl.c        |   6 +
>>   fs/btrfs/ordered-data.c |   5 +-
>>   fs/btrfs/reflink.c      |  14 +-
>>   fs/btrfs/relocation.c   | 287 ++++++++++++--------
>>   fs/btrfs/subpage.c      | 156 ++++++++++-
>>   fs/btrfs/subpage.h      |  31 +++
>>   fs/btrfs/super.c        |   7 -
>>   fs/btrfs/sysfs.c        |   5 +
>>   fs/btrfs/volumes.c      |   8 +
>>   14 files changed, 949 insertions(+), 327 deletions(-)
>>
>
> Could you please rebase your branch on 5.13-rc4? I'd rather test it on
> top of that release...
>
>
It can be rebased on david's misc-next branch without any conflicts.
Although misc-next is only on v5.13-rc3, I don't believe there will be
anything btrfs related out of misc-next.

Is there anything special only show up in -rc4?

Thanks,
Qu
