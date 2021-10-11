Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D79428CD6
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 14:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235040AbhJKMQs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 08:16:48 -0400
Received: from mout.gmx.net ([212.227.17.20]:52063 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234961AbhJKMQr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 08:16:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1633954486;
        bh=JvbogaJvp4pR1XTcDZARIQSZxmLrNMQOEj6EJeYmLA8=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=bSLaDInEz+/Q3u0Hndsf0HqtAqxFPy/Qz98OCWq1cE7iTKmF+BcnDglybH+SXabpC
         iVmb8iV8SBzSOTPwk2ye/wc/ukn76+thxqQC7xa+cw0ypERqGmpM8Yr+bNu8FFdnEW
         o4jbCjkIWTbz0QHpYNiaRZVALFG0SPoHZKYSXe7o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M26r3-1mcNB621XN-002bwS; Mon, 11
 Oct 2021 14:14:46 +0200
Message-ID: <057ae017-d79f-183b-719e-7d8c11cb6600@gmx.com>
Date:   Mon, 11 Oct 2021 20:14:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v2 0/3] btrfs-progs: mkfs: make sure we can clean up all
 temporary chunks
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211011120650.179017-1-wqu@suse.com>
 <c97120d6-d599-5882-57ef-6f7534660dda@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <c97120d6-d599-5882-57ef-6f7534660dda@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IvZ6lNZx4+E/gRuR0lCEElWkb5s343z1rMAGP/RWSVG2Eg/KJZ4
 aHK6gsKLakXN9Q/9lf033UUsqxkRuJQSBP3zhXV5PqKP+mSN5kvOlg3BGlNpVw07Geb0fAC
 L///Al8o4LGT8FUT9rMX2FL7211RVRN60okutwSJjutWPd3xv11puMS2g48X2U96WL+HsR9
 4vIJXE3hpDPNSctfiXGBg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+XHNpuEVXac=:xvc1SiDkDDe7dpJQZxgXoQ
 0t6YJpYfhMzvgNFaZgCYR7Xb5Cy3Uj5fMJULzyv3xMf8OXie0WPAmMkVV2Z0QhElLQGI5tgZ1
 Z8vFOZZ0SNLyXzBuaSr/HizO/HbYIj3yPOQJ6yGAvDq+u4Xat7kuNz27UnWTWEd4rctOY7eeh
 +DTiCXp0IO5VBk7251iEYx+qdzOA+ZHpnS3K1T8qKzl6i4K0e9eTZOF0rRBnmIQAtaFjZ/eq8
 iQr0xfO+FWyMEsxoz2p6997b4SjzqcNRuYUxQgVIO+tcEIsk8d2z06euf3t44IxmHBzbdsv+w
 kMVymzbajVPiPER5NxHDLCrXMCD1HQQz2hD+sPdfGD8bG/5KHYhgUL/GmcKMAzvAEWqgPDp48
 Ny2VIWVa2DN+vtZtY6p0i8Mk1lks1HONKKaNc72tRwbmJU6+BazoFl/WsPiPIz8yrfSw/TSj1
 d5SqqiI8Fy4CEtidMWpPk49UTfB0+2TdPTA0dLLagnjfo0GpDJTjOhJRoP0ih70UGJZe7b9cV
 /dG0EYT8fIX6nAnyImSb6Ijf1HmWnpDE13H9nvqJzOa5CmTCL1zCDFcqoG7TBu6bDc1R+ZzgL
 1T5l47npKFETU4FlzAP9RCnvZ4y4DIZgVTlAdrisiiIuHA+82ZjJObXL57DOvWQEn6FsWVpnM
 DKJykCnJJqu1S6vAE9WQzJXB8w9girX2lsZ7lpv+z4A6CLrigOvWWpSLeNZPoTEDAkZQDjey5
 xpqjvzoKEIPmV2+ka6OXWlkSCWmAWhMCmEDsOgGT+uzDTE9yRaV3BARo6ZLqw1GvyrgrrsEDC
 4+SIvUJG1NN8H+zkJ/ucQlo/EFGH/4eoJEJyajSjIeKS68XU7xEgz+78Yuamu3esSoMj4sVS1
 ylJXX3Vo1fRfUeuHhjM0DwWVj7Cj/jWCjWt89S8W7sQ9XPIEqpGLdt8wwjMpUb3EjnuRPTrSA
 /wZEls/61qOiA49yueF2CxnX0+R9kx05HFFeHOjkMbqWXrTiPuYu/Dg5xS5VAaIEf+dKbXDBY
 94ZfY8oJqd62xjfXarbw8Mh0pLYVlBpcGxljDSn/YIio60pnxtLwoBf1H83X+JXJQSEDloFHa
 dZod4NCB02a9g0=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/11 20:10, Nikolay Borisov wrote:
>
>
> On 11.10.21 =D0=B3. 15:06, Qu Wenruo wrote:
>> There is a bug report that with certain mkfs options, mkfs.btrfs may
>> fail to cleanup some temporary chunks, leading to "btrfs filesystem df"
>> warning about multiple profiles:
>>
>>    WARNING: Multiple block group profiles detected, see 'man btrfs(5)'.
>>    WARNING:   Metadata: single, raid1
>>
>> The easiest way to reproduce is "mkfs.btrfs -f -R free-space-tree -m du=
p
>> -d dup".
>>
>> It turns out that, the old _recow_root() can not handle tree levels > 0=
,
>> while with newer free space tree creation timing, the free space tree
>> can reach level 1 or higher.
>>
>> To fix the problem, Patch 2 will do the proper full tree re-CoW, with
>> extra transaction commitment to make sure all free space tree get
>> re-CoWed.
>>
>> The 3rd patch will do the extra verification during mkfs-tests.
>>
>> The first patch is just to fix a confusing parameter which also caused
>> u64 -> int width reduction and can be problematic in the future.
>>
>> Changelog:
>> v2:
>> - Remove a duplicated recow_roots() call in create_raid_groups()
>>    This call makes no difference as we will later commit transaction
>>    and manually call recow_roots() again.
>>    Remove such duplicated call to save some time.
>>
>> - Replace the btrfs_next_sibling_tree_block() with btrfs_next_leaf()
>>    Since we're always handling leaves, there is no need for
>>    btrfs_next_sibling_tree_block()
>>
>> - Work around a kernel bug which may cause false alerts
>>    For single device RAID0, btrfs kernel is not respecting it, and will
>>    allocate new chunks using SINGLE instead.
>>    This can be very noisy and cause false alerts, and not always
>>    reproducible, depending on how fast kernel creates new chunks.
>>
>>    Work around it by mounting the RO before calling "btrfs fi df".
>>
>>    The kernel bug needs to be investigated and fixed.
> It's better to see the kernel bug fixed rather than papering over it.

That's for sure.

Just get overloaded by so many small bugs in one day.

Will investigate and fix the bug soon.

For the test case itself, mounting with RO in fact makes sense, we just
want to the initial chunk layout created by mkfs.

If later we choose to compare the total chunk size against the reported
values, such RO mount is a hard requirement to avoid chunk preallocation.

Thanks,
Qu
>
>>
>>
>> Qu Wenruo (3):
>>    btrfs-progs: rename @data parameter to @profile in extent allocation
>>      path
>>    btrfs-progs: mkfs: recow all tree blocks properly
>>    btrfs-progs: mfks-tests: make sure mkfs.btrfs cleans up temporary
>>      chunks
>>
>>   kernel-shared/extent-tree.c                 | 26 +++---
>>   mkfs/main.c                                 | 90 ++++++++++++++++++--=
-
>>   tests/mkfs-tests/001-basic-profiles/test.sh | 16 +++-
>>   3 files changed, 104 insertions(+), 28 deletions(-)
>>
