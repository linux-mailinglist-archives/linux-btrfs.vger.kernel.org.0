Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360684830BE
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jan 2022 12:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbiACLvq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jan 2022 06:51:46 -0500
Received: from mout.gmx.net ([212.227.15.19]:49031 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229788AbiACLvp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Jan 2022 06:51:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641210702;
        bh=PnKXNdk/NA/LlhLs/gRQU2PBjJddXkq0hMOatb38FWo=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=lbsvFna0/rq7XKgf0OvvPd4q+oJ/xDUJ2LQxt2gdReKdsdFA2jdBBzTmpANqFM2nL
         cp/dD2kxDZ+2AH7wwQl18gCdL19tO5rCe1QYekuNJF2zi95DNl1x2/AGoMKoj70tr9
         F9EK2mFIRqev/jDSJMtNDTIw33+VzMoKgKnnTzZI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M4JmN-1n4crE2m9Z-000JmI; Mon, 03
 Jan 2022 12:51:42 +0100
Message-ID: <e3fd9851-ccf4-6f04-b376-56c6f7383de7@gmx.com>
Date:   Mon, 3 Jan 2022 19:51:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To:     Eric Levy <contact@ericlevy.name>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <2c80ca8507181b1e65a67bbd4dca459d24a47da2.camel@ericlevy.name>
 <b0d434dd-e76d-fdfa-baa2-bb7e00d28b01@gmx.com>
 <487b4d965a6942d6c2d1fad91e4e5a4aa29e2871.camel@ericlevy.name>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: "hardware-assisted zeroing"
In-Reply-To: <487b4d965a6942d6c2d1fad91e4e5a4aa29e2871.camel@ericlevy.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t43MH834QEA2HkNgRKwLJpKoXDSMCU4HLv+LUSrhrDaP5AWhN/R
 y3gwwPUrJGBebGtkRYI1drPKM+7EOe3+Hd1B3UEpUKntwVHNdUVDcqD4lY9ABnZk5mJFcyR
 MXVDW/2td18HKpgxjA+ijRjmk7lG6udm3lOzrhnhrhmI6/Z2b+dNxvbH2bmiLY9SZ7PdOoX
 DR+dY+OJZ9Sl1QW6ZPkUg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9opj2QZR4js=:bYaigZbxtpGyMzML6bGJhg
 Sc1BSb4HrHBl3v4TexbgKsGHcP+epg9GgK+SSvX/+THdVSUjTYTKP4Ns8no0wmGCYxLGjMsmn
 kLWVuIIVVelx5auHinkpXOG4+66tlcapM7Xh96p9cGcDzkuAKGYkakJ2E9utQocUGuJnDAioI
 tRf3qOCkjWuUs6iT2EnH2SWvjPUJbzi+ZYO9PmG+AGtwLIJ4sIH8bxP7mOa8q0pErpiDUaJp9
 Q8CjXOqK5MV12hWXVCjRzaudlg6qKc5RgiDL7tcbLUgcwbQUeRhfEg9Tr/lafvELRsJo4MqjN
 fYBAwmS5XmBbyKFSqaZLQjsbtPiqjydERpuPBfdHFnVDtgOCUoY9qIEYmFElVaB3aD/WwBryN
 TaUuBpE/epxv4AHszEfU89xxh2rEI1rjwHMEuP3AWS6Cza1R17Sw7koxWvF9ocD7v3RnFRW/G
 Yg+J36nRGQOjlTrNIg/FJ0M2bBiSnCkEyb6YtbPQLFGexwuerTVSgAh93tgCt07bgvmeSqV4c
 XXYZcYeWLGu5arMCiIXxQc9nAqvZfUW4IV9wytHB2cjo7TY4yR2jsPnyV83Ruyx/wOE+zePqk
 g9geME1WFeTRw94SQ8tTM0PVfPUuhHMmpSPtURQBQZbSSNQDmzxol5WEpsOrZMJ5AU3Odo4Z1
 kB790zxA/scS4zYi9QbI2hzhZjFa+U13Pj2yx54y3FojFcWH9y56QB06IYE/kPdiCv11UsYve
 wSiqdxBp2CE33kNk81sFEWVe1ebuCseZZpdUKe1CT8OFlU5tZW04HM1ugg6Sherd3co5dnTgO
 3EnRjzQOyY+A7tqeD5mMkhI53MYX84cOe8QJGS6qGETO7UHpFGw129W+XrgByhtb5TPj0pUTJ
 zMW3OkaxKHEsIHOk7TSyjyOZ1GKiZ3qgnqvmDOEiihylRtWun3aVfIl8LiciM16VO5fkvZNvo
 uvnAHqKUUvsUzPPg5VY1T9ONWBUrcGyxzkSB1iruc8Taei9nG4KJln1u0wcx95O4UyqXq6QsR
 rlNrfraDmaAhmPbKUGf34ZOS6vXYqrGjFeLvkjDcaQdqs0a1eXuA6WfcHyJo3LJjhkFnHS11h
 jgCVITbw931eMQ=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/3 19:24, Eric Levy wrote:
>>> an iSCSI target. The software managing the volumes shows that they
>>> are
>>> configured for certain features, which include "hardware-assisted
>>> zeroing" and "space reclamation". Presumably the meaning of these
>>> features, at least the former, is that a file system, with support
>>> of
>>> the kernel, may issue a SCSI command indicating that a region of a
>>> block device would be cleared.
>>
>> This looks pretty much like ATA TRIM or SCSI UNMAP command.
>>
>> If they are the same, then btrfs supports it by either fstrim command
>> (recommended) or discard mount option.
>
> Thanks for the explanation. How does trimming work?

The filesystem will call blkdev_issue_discard() to do the trimming.
Which will in turn issue corresponding command according to the driver.

For ATA devices, it will be a ATA TRIM command. For SCSI it will be a
SCSI UNMAP command, and for loop device backed up by a file, it will
punch holes (and then handled by the filesystem holding the loop file).

> Does the file
> system maintain a register of blocks that have been cleared?

The filesystem (normally) doesn't maintain such info, what a filesystem
really care is the unused/used space.

For fstrim case, the filesystem will issue such discard comand to most
(if not all) unused space.

And one can call fstrim multiple times to do the same work again and
again, the filesystem won't really care.
(even the operation can be very time consuming)

The special thing in btrfs is, there is a cache to record which blocks
have been trimmed. (only in memory, thus after unmount, such cache is
lost, and on next mount will need to be rebuilt)

This is to reduce the trim workload with recent async-discard optimization=
.

> Why is the
> command not sent instantly, as soon as the space is freed by the file
> system?

If you use discard mount option, then most filesystems will send the
discard command to the underlying device when some space is freed.

But please keep in mind that, how such discard command gets handled is
hardware/storage stack dependent.

Some disk firmware may choose to do discard synchronously, which can
hugely slow down other operations.
(That's why btrfs has async-discard optimization, and also why fstrim is
preferred, to avoid unexpected slow down).

Thanks,
Qu
