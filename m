Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851BE337BB7
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Mar 2021 19:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhCKSFj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Mar 2021 13:05:39 -0500
Received: from a4-1.smtp-out.eu-west-1.amazonses.com ([54.240.4.1]:48889 "EHLO
        a4-1.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230246AbhCKSFK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Mar 2021 13:05:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=pqvuhxtqt36lwjpmqkszlz7wxaih4qwj; d=urbackup.org; t=1615485907;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=rv1uGdL+iCl5EZuzka3APqYo29rsuaqd6RXkd6NzazU=;
        b=ThaxJb+VB+Y68eY+R81iVOb3gNE96Ax3BKw7d2xT/oKndaqgU+nz+WnGj5086cbx
        AVlnxYb5Dg/EbvL/uoHBqOfrshsyHjVWRIcG5fLDBXNCvOUh7NLSQEzXL3K4ydtLCfg
        MSdiLZ5boTzPKHdgxDbRSw4TOdVhW4c2ni2mM9/0=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1615485907;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=rv1uGdL+iCl5EZuzka3APqYo29rsuaqd6RXkd6NzazU=;
        b=TBZtc4kMICQYtk/QAJwixtix1L+KQDK1awi/As/jVm0+auu2blggUpasSX5ggSAa
        xMbiSB8wmTsKFB0VFHxouUicRAPqSVXsD0jORZ6Qq1dHtosF29J3dFpc/XKYqHV3ANb
        BLM7KwMaCrBhdjr+W8TiyddIOGnMDo9wt1FG6x1g=
Subject: Re: Multiple files with the same name in one directory
To:     fdmanana@gmail.com
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <010201781d22d3e9-78ba2d74-fc45-4455-813d-367e789d3e9b-000000@eu-west-1.amazonses.com>
 <CAL3q7H79BO0qgTUVmbW2kzcUqtp4vgRLK8vNT95+Sz7tgWDdMQ@mail.gmail.com>
From:   Martin Raiber <martin@urbackup.org>
Message-ID: <010201782276b01f-7930fadd-7b4b-4f45-bd66-6862adb594f4-000000@eu-west-1.amazonses.com>
Date:   Thu, 11 Mar 2021 18:05:06 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H79BO0qgTUVmbW2kzcUqtp4vgRLK8vNT95+Sz7tgWDdMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-SES-Outgoing: 2021.03.11-54.240.4.1
Feedback-ID: 1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11.03.2021 15:43 Filipe Manana wrote:
> On Wed, Mar 10, 2021 at 5:18 PM Martin Raiber <martin@urbackup.org> wrote:
>> Hi,
>>
>> I have this in a btrfs directory. Linux kernel 5.10.16, no errors in dmesg, no scrub errors:
>>
>> ls -lh
>> total 19G
>> -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
>> -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
>> -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
>> -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
>> -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
>> -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
>> -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
>> -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
>> -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
>> -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
>> -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
>> -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
>> -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
>> -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
>> ...
>>
>> disk_config.dat gets written to using fsync rename ( write new version to disk_config.dat.new, fsync disk_config.dat.new, then rename to disk_config.dat -- it is missing the parent directory fsync).
> That's interesting.
>
> I've just tried something like the following on 5.10.15 (and 5.12-rc2):
>
> create disk_config.dat
> sync
> for ((i = 0; i < 10; i++)); do
>     create disk_config.dat.new
>     write to disk_config.dat.new
>     fsync disk_config.dat.new
>     mv -f disk_config.dat.new disk_config.dat
> done
> <power fail>
> mount fs
> list directory
>
> I only get one file with the name disk_config.dat and one file with
> the name disk_config.dat.new.
> File disk_config.dat has the data written at iteration 9 and
> disk_config.dat.new has the data written at iteration 10 (expected).
>
> You haven't mentioned, but I suppose you had a power failure / unclean
> shutdown somewhere after an fsync, right?
> Is this something you can reproduce at will?

I think I rebooted via "echo b > /proc/sysrq-trigger". But at that point it probably didn't write to disk_config.dat anymore (for more than the commit interval). I'm also not sure about the delay of me noticing those multiple files (since it doesn't cause any problems) -- can't reproduce.

This is the same machine and file system with ENOSPC in btrfs_async_reclaim_metadata_space -> flush_space -> btrfs_run_delayed_refs. Could be that something went wrong with the error handling/remount-ro w.r.t. to the tree log?

>
>> So far no negative consequences... (except that programs might get confused).
>>
>> echo 3 > /proc/sys/vm/drop_caches doesn't help.
>>
>> Regards,
>> Martin Raiber


