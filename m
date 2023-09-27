Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824F87AF8A4
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Sep 2023 05:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjI0D2K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Sep 2023 23:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjI0D0I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Sep 2023 23:26:08 -0400
Received: from w1.tutanota.de (w1.tutanota.de [81.3.6.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C55E26A0
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 18:46:25 -0700 (PDT)
Received: from tutadb.w10.tutanota.de (unknown [192.168.1.10])
        by w1.tutanota.de (Postfix) with ESMTP id 81C87FBF51D;
        Wed, 27 Sep 2023 01:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1695779184;
        s=s1; d=tutanota.com;
        h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
        bh=QCBE23xFLJrhfnluLsYduy2xocdhluHPtRGlTg0J0H8=;
        b=k87tSuV5W6xy/iZU3kAN9xl1F5SlBp7CuRgxG9utSDlUQoZ8bLdFGJTtQhx+etZ2
        23EMsi4Z69xx5BtFVKv+vqoZLLud1a6KhUVe9kX4EXkoxhagsvaaJ4qWtn/P/ij0Jed
        GN85m9cbPyK8WnKlJsrqWhzRgOPc08CHEUwieceST1ubgQNo6Ah8tktYvS/EWxL5RHh
        8CNUbu7hgqUugSSV/IxnbA3uaiytbRrc9sUGsSpOKHWGIHw7NnIZ8VCJwiCOf9+V8rH
        7aGxiAJkzV3kFa2JXsWh4lPqwaigRM6NHuUpfIi+zMMQrAuE96ID6ChuI8sS8wdbGde
        LGfulhmorg==
Date:   Wed, 27 Sep 2023 03:46:24 +0200 (CEST)
From:   fdavidl073rnovn@tutanota.com
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, Linux Btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <NfJJCdh--3-9@tutanota.com>
In-Reply-To: <NeKx2tK--3-9@tutanota.com>
References: <NeBMdyL--3-9@tutanota.com> <4b8a10e4-4df8-4d96-9c6f-fbbe85c64575@suse.com> <NeGkwyI--3-9@tutanota.com> <bb668050-7d43-467f-8648-8bc5f2c314f1@gmx.com> <NeKx2tK--3-9@tutanota.com>
Subject: Re: Deleting large amounts of data causes system freeze due to OOM.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Sep 14, 2023, 23:08 by fdavidl073rnovn@tutanota.com:

>
> Sep 14, 2023, 05:12 by quwenruo.btrfs@gmx.com:
>
>>
>>
>> On 2023/9/14 13:08, fdavidl073rnovn@tutanota.com wrote:
>>
>>> Sep 13, 2023, 05:55 by wqu@suse.com:
>>>
>>>>
>>>>
>>>> On 2023/9/13 11:58, fdavidl073rnovn@tutanota.com wrote:
>>>>
>>>>> Dear Btrfs Mailing List,
>>>>>
>>>>> Full disclosure I reported this on kernel.org but am hoping to get mo=
re exposure on the mailing list.
>>>>>
>>>>> When I delete several terabytes of data memory usage increases until =
the system becomes entirely unresponsive. This has been an issue for severa=
l kernel version since at least 5.19 and continues to be an issue up to 6.5=
.2-artix1-1. This is on an older computer with several hard drives, eight g=
igabytes of memory, and a four core x86_64 cpu. Slabtop output right before=
 the system becomes unresponsive shows about four gigabytes used by khugepa=
ged_mm_slot and three used by btrfs_extent_map. This happens in over the sp=
an of a couple minutes and during this time btrfs-transaction is using a mo=
derate amount of cpu time.
>>>>>
>>>>
>>>> This looks exactly like something caused by btrfs qgroup.
>>>>
>>>> Could you try to disable qgroup to see if it helps?
>>>> The amount of CPU time and IO of qgroup overhead is directly related t=
o the amount of extent being updated.
>>>>
>>>> For normal writes the IO itself would take most of the CPU/memory thus=
 qgroup is not a big deal.
>>>> But for massive snapshots drop or file deletion qgroup can be too larg=
e to be handled in just one transaction.
>>>>
>>>> For now you can disable the qgroup as a workaround.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>> I've never enabled quotas and my most recent attempt using the single p=
rofile for data was on kernel 6.4 so they would have been disabled by defau=
lt. Running "btrfs qgroup show [path]" returns "ERROR: can't list qgroups: =
quotas not enabled".
>>>
>>
>> OK, at least we can rule out qgroup.
>>
>> Mind to provide more info? Including:
>>
>> - How many files are involved?
>> A large file vs a ton of small files have very different workloads.
>> Any values on the average file size would also help.
>>
>> - Is the fs using v1 or v2 space cache?
>> - Do the deleted files have any snapshot/reflink?
>> - Is there any other processes reading the to-be-deleted files?
>>
>> One of my concern is the btrfs_extent_map usage, that's mostly used by
>> regular files as an in-memory cache so that they don't need to lookup
>> the tree on-disk.
>>
>> I just checked the code, evicting an inode won't trigger
>> btrfs_extent_map usage, it's mostly read/write triggering such
>> btrfs_extent_map usage.
>>
>> Thus there must be something else causing the unexpected
>> btrfs_extent_map usage.
>>
>> Thanks,
>> Qu
>>
>>>
>>> Sincerely,
>>> David
>>>
> On my latest attempt using the single profile there is about fifteen tera=
bytes total of space used, around eight hundred and fifty thousand files, o=
ver 9000 directories, and there are three very large files (two two terabyt=
e and one four terabyte). There are also about two terabytes of compressed =
files using zstd at a fifty percent ratio.
>
> The device is using space cache version two, there are no reflink or snap=
shots as far as I know and nothing else is reading or happening when this o=
ccurs. The system idles at about three hundred megabytes of memory used wit=
h negligible cpu activity before this happens.
>
> For some context the device is currently mounted with compress-force=3Dzs=
td:3 and noatime. The data currently on the device was transferred via send=
-receive version two (and was already compressed) as a snapshot but it is t=
he only copy of it on the disk so I am not sure if that counts as a snapsho=
t. I do not think the snapshot is related because I have deleted a single f=
our terabyte file (from the snapshot) as a test and the memory usage went f=
rom about three hundred megabytes to over a gigabyte before going back down=
. I assume that was the same thing but the system just did not run out of m=
emory.
>
> Sincerely,
> David
>
>
To follow up on this I've tried creating a ten terabyte file then deleting =
it then tried creating approximately ten terabytes of files randomly betwee=
n one and thirty two megabytes then deleting that folder. I tried this both=
 at the root of the btrfs device and inside a subvolume. Each trial did inc=
rease the memory usage by up to one gigabyte at points but did not cause th=
e system to run out of memory.

I still believe the cause is that requests are being queued faster than the=
y're completed until there is no memory left so my current thought is that =
this either has something to do with nested directories or my real backup i=
s significantly more fragmented. I think either of those possibilities migh=
t cause significantly more=C2=A0 seeks for the harddrives and slow down how=
 fast operations are completed causing them to pile up.

I might try to put together something to make nested directories with lots =
of small files and delete that but otherwise I am out of ideas (I cannot th=
ink how I could properly replicate fragmentation easily). If you have any t=
houghts or things you think it'd be worthwhile to test I would love to hear=
 them.

Sincerely,
David
