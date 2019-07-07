Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABDAA614F6
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jul 2019 15:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfGGNBJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 7 Jul 2019 09:01:09 -0400
Received: from a4-1.smtp-out.eu-west-1.amazonses.com ([54.240.4.1]:49490 "EHLO
        a4-1.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726541AbfGGNBJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 7 Jul 2019 09:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ob2ngmaigrjtzxgmrxn2h6b3gszyqty3; d=urbackup.org; t=1562504467;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=iYK6n3CMU6QZgcn+UvEuja2Ku/goRcpwk8NhNMU6IDc=;
        b=deOwIJrATgyYaoQj+4j4bie9SQUHM1g5CVXy9/clDNCls7m+qzzFegoxNCzrnPDq
        m/bo8CcCiRNJZjjcHhmuE4/1S+ckkMQBC/EbvjbQWgtEWiXt1hlXwUYBO0UMfpY9QG7
        1gN8RS8Rx/HJWN8DwxQgFBFG86/dbDqq/GkJJ3jw=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1562504467;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=iYK6n3CMU6QZgcn+UvEuja2Ku/goRcpwk8NhNMU6IDc=;
        b=UeS5Y+3zqRuxtZpYqSK4CNtCNb3tWaU6wzii8NjokUkeENIMavvQBXa6tADoQ7Sf
        MSw+ooqlfYSmbY+fVNYCuF+CnkE1YI3eb7UoNv2ySSpXyGgMyWULo4zls90zkA3j4fF
        knPbiKb+b84iZDduarWP23XSv7KkURnRpJ5sw2Po=
Subject: Re: syncfs() returns no error on fs failure
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <0102016bc283c774-ca60b6ce-5179-4de8-8df3-80752411b5c0-000000@eu-west-1.amazonses.com>
 <0102016bc3d2f2a2-46c55025-ec28-468f-b1d2-82d655fa3a1c-000000@eu-west-1.amazonses.com>
 <ecd6de71-e10f-e42d-7780-951a5a53923a@gmx.com>
From:   Martin Raiber <martin@urbackup.org>
Message-ID: <0102016bcc86127e-e40f743a-36db-4181-abe4-48b336c167e2-000000@eu-west-1.amazonses.com>
Date:   Sun, 7 Jul 2019 13:01:07 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <ecd6de71-e10f-e42d-7780-951a5a53923a@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2019.07.07-54.240.4.1
Feedback-ID: 1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 07.07.2019 14:15 Qu Wenruo wrote:
>
> On 2019/7/6 上午4:28, Martin Raiber wrote:
>> More research on this. Seems a generic error reporting mechanism for
>> this is in the works https://lkml.org/lkml/2018/6/1/640 .
> sync() system call is defined as void sync(void); thus it has no error
> reporting.
>
> syncfs() could report error.
>
>> Wrt. to btrfs one should always use BTRFS_IOC_SYNC because only this one
>> seems to wait for delalloc work to finish:
>> https://patchwork.kernel.org/patch/2927491/ (five year old patch where
>> Filipe Manana added this to BTRFS_IOC_SYNC and with v2->v3 not to
>> syncfs() ).
>>
>> I was smart enough to check if the filesystem is still writable after a
>> syncfs() (so the missing error return doesn't matter that much) but I
>> guess the missing wait for delalloc can cause the application to think
>> data is on disk even though it isn't.
> Isn't syncfs() enough to return error for your use case?
>
> Another solution is fsync(). It's ensured to return error if data
> writeback or metadata update path has something wrong.
> IIRC there are quite some fstests test cases using this way to detect fs
> misbehavior.
>
> Testing if the fs can be written after sync() is not enough in fact.
> If you're doing buffer write, it only covers the buffered write part,
> which normally just includes space preallocation and copy data to page
> cache, doesn't include the data write back nor metadata update.
>
> So I'd recommend to stick to fsync() if you want to make sure your data
> reach disk. This does not only apply to btrfs, but all Linux filesystems.
>
> Thanks,
> Qu

This is for UrBackup (Open Source backup software). What it does is,
create btrfs snapshot of last backup of a client, sync the current
client fs to the btrfs snapshot, then call syncfs(btrfs snapshot), then
check if the snapshot is still writable, then set the backup to complete
in its internal database. Calling fsync() on every file would kill
performance (especially on btrfs).
The problem I had was that there was a (complete in database) backup
that had files with wrong checksums (UrBackup does its own checksums,
the btrfs ones were okay), and missing files. On the day the corrupted
backup completed the btrfs went read-only a few hours after the backup
completed and the syncfs() was called with:

[253018.670661] BTRFS: error (device md1) in
btrfs_run_delayed_refs:2950: errno=-5 IO failure

So my guess is using BTRFS_IOC_SYNC instead of syncfs() fixes the
problem in my case, while it would probably be nice if syncfs() returns
an error if the fs fails (it doesn't -- I tested it) and waits for
everything to be written to disk (as expected, and the man-page somewhat
confirms).

>
>> On 05.07.2019 16:22 Martin Raiber wrote:
>>> Hi,
>>>
>>> I realize this isn't a btrfs specific problem but syncfs() returns no
>>> error even on complete fs failure. The problem is (I think) that the
>>> return value of sb->s_op->sync_fs is being ignored in fs/sync.c. I kind
>>> of assumed it would return an error if it fails to write the file system
>>> changes to disk.
>>>
>>> For btrfs there is a work-around of using BTRFS_IOC_SYNC (which I am
>>> going to use now) but that is obviously less user friendly than syncfs().
>>>
>>> Regards,
>>> Martin Raiber
>>

