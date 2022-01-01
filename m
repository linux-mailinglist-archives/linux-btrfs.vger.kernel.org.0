Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8255448287F
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Jan 2022 21:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiAAUto (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 Jan 2022 15:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiAAUtn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 1 Jan 2022 15:49:43 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80B6C061574
        for <linux-btrfs@vger.kernel.org>; Sat,  1 Jan 2022 12:49:43 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id k69so72949612ybf.1
        for <linux-btrfs@vger.kernel.org>; Sat, 01 Jan 2022 12:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y3DLZeRSzzlWTEgvPiwcyp71Kd9WKP2M8RSxyKHtUBI=;
        b=jENeBqq+9LjEr0VFd60ZDrawOIygN7QnX9z/aS1xjwUVFdOuNjefb2z7ic+iD6d7ws
         auFeus+224agk5HZHVtIAcNsbdHyT3+KATVFU18Vsb2DPX+mLRKbQKzmHjvmNWtFeGxE
         rVl/T84KQysAd/N3DZo+wH66ckHXZU+WxmFu35vHoB1NSUN2TZnlBwv31L+fF4+xefTo
         0ZwCdCyJRyet5t6oaMLk/JvxOQM9VQmei257GNRd2kdBSU/1E5GPspFNa67mhooC/HOv
         S4yg2qzK3tTd2Kd7rL1229R+4Do3UD/rpj3BE0Prd/2YFWv9ZTEBZVpGWhyAc8O1/bql
         GA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y3DLZeRSzzlWTEgvPiwcyp71Kd9WKP2M8RSxyKHtUBI=;
        b=hka5HbL5WZlfdoZT4r0XOvcqDLhtj02ItO3bcmsNJbMtKB8GqMM7Ufw3ZM2/HjnC18
         UynBEKWR0AG8KvHMBNju+O2WoHTGsQtRXto/Q912y4NPP7yJE9jllQjVYgyaMNlAytub
         q7eft5F/+fVZc+Z5uq00JBG9Nm0c7vfkhSv9Q+Ex67OOV66HY4hFmoRbzJGVAwuCpZNr
         zjKEj3KFqJhkSJSXOTDlc+nRwmnvCCVcKKM95T+3b5rSybq6BnwKfWT72obXBeq/biXg
         aji1oHUaxPsar8keAYGjXGDsJe1b4D00dBow+1LXORahEpFPiw+Klb7+8e78uUibHFLa
         Yyqg==
X-Gm-Message-State: AOAM531/9ZsGqLS3ID+Ox57p2O0Yn2n5el1idZGGaV5CZEadBAxIh/zF
        HYCSXATZUZBKKCkslNOiRtA+Iqua7ylEv4vVCV+eYjdoPejWEKvh
X-Google-Smtp-Source: ABdhPJwFNhY5koYwUVncYTr2VDUC8kbRosPag7Um/asih+N79eTknpXv2fJuCMqsHgHA5+KyFKncF7S9Boi70nREGlM=
X-Received: by 2002:a25:e705:: with SMTP id e5mr2399823ybh.618.1641070182585;
 Sat, 01 Jan 2022 12:49:42 -0800 (PST)
MIME-Version: 1.0
References: <c0c6ec8de80b8e10185fe1980377dcc7af8d3200.camel@ericlevy.name>
 <Yc9Wgsint947Tj59@hungrycats.org> <baa90652685a400aa60636f8596e3d28304da1ad.camel@ericlevy.name>
 <CAJCQCtRxkZ4NjQA9KrOvb_ybDE-sg_BzzMU=91fT_p8gMEKw6Q@mail.gmail.com> <7cffc181c0b01a52dfd82128eb656ec2ec44b94d.camel@ericlevy.name>
In-Reply-To: <7cffc181c0b01a52dfd82128eb656ec2ec44b94d.camel@ericlevy.name>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 1 Jan 2022 13:49:26 -0700
Message-ID: <CAJCQCtSYBv805+Yi4EJ-sZh6b4d0BX7=XAufQYtdqvmHvXKZMw@mail.gmail.com>
Subject: Re: parent transid verify failed
To:     Eric Levy <contact@ericlevy.name>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 1, 2022 at 12:34 AM Eric Levy <contact@ericlevy.name> wrote:

> The hardware is an appliance with an array of SATA magnetic disks
> managed in a RAID6-like volume. The volume is formatted with a top-
> level Btrfs file system, on which is installed an OS that manages
> services and provides an administrative interface.
>
> All of these components are presently reported healthy through normal
> diagnostics and logging. More intensive diagnostics would include a
> S.M.A.R.T. extended test of each media device, and a scrubbing of the
> file system. All available indications suggest these operations would
> expose no problems.

OK except we've got kernel messages clearly showing /dev/sdc is
rejecting writes, and that's what btrfs is complaining about. Since
there's only a partial dmesg to go on, I can really say if there's
something else going on, but pretty straightforward when there's
multiple of these:

Dec 30 03:47:10 hostname kernel: blk_update_request: I/O error, dev
sdc, sector 523542288 op 0x1:(WRITE) flags 0x104000 phys_seg 128 prio
class 0

That it will result in these:

Dec 30 03:47:10 hostname kernel: BTRFS error (device sdc1): bdev
/dev/sdc1 errs: wr 10, rd 0, flush 0, corrupt 0, gen 0

Btrfs is telling us that writes are being dropped. I'm not sure why
/dev/sdc is dropping writes but the block layer also knows they're
being rejected and what sector, so I kinda suspect the block device
itself is aware of and reporting the write failures with sector
address to the kernel.


Dec 30 03:47:10 hostname kernel: BTRFS warning (device sdc1): error -5
while searching for dev_stats item for device /dev/sdc1
Dec 30 03:47:10 hostname kernel: BTRFS warning (device sdc1): Skipping
commit of aborted transaction.
Dec 30 03:47:10 hostname kernel: BTRFS: error (device sdc1) in
cleanup_transaction:1975: errno=-5 IO failure
Dec 30 03:47:10 hostname kernel: BTRFS info (device sdc1): forced readonly

Too many dropped writes and Btrfs decides it's going to stop trying,
so that the file system hopefully doesn't get corrupt with some writes
getting to stable media but not others. But as it turns out, maybe
some of those writes did get to stable media, hence the confusion.

I can't tell if you've tried umounting this file system and then
mounting it again cleanly (not remount) and what messages appear in
dmesg if it fails.


> Possible reasons for the device becoming read only include the
> following:
>
>    1. As a side effect of provisioning the new volume, write privileges
>       were effectively removed for the existing one.
>    2. The LV backend became confused and entered a protective state.
>    3. The iSCSI initiator was unable to add a new volume without affecting
>       the existing one.

Btrfs went read-only in this case because it detected dropped writes,
and it's deciding to stop further writes so that the confusion doesn't
end up on disk, hopefully. Going read-only is not the problem, that's
the fail safe action Btrfs is trying to take as a result of the
problem. The problem is, all these dropped writes from /dev/sdc


>
> However, the logs show that between the detection of the new volume and
> the reversion to the RO state, several add and remove operations were
> completed. Without knowing about the mechanics of Btrfs, I would
> postulate that these operations depend on successful write access to
> all devices in the pool, including any added or removed. It appears to
> me as though the volumes were healthy and accessible for at least some
> time, which can be calculated from the log timestamps, long enough for
> me to issue commands.
>
> Thus, my first thought was a file-system issue, not a device issue.

It's definitely an issue with /dev/sdc, but I can't tell from the
available info why it's dropping writes, only that two parts of the
kernel are seeing it, btrfs and blk_update_request


> Is the present indication more strongly that a) the driver refuses to
> mount the file system because its state shows as corrupt, or b) the
> driver aborts the mount operation because it fails to write at the
> block level?

You can check the consistency of the file system by umounting and then
running 'btrfs check --readonly` against any device in the file system
(the command finds all member devices and the fs is checked on all of
them as needed).

>
> If the problem is device-level, then there is much to try, including
> renewing the iSCSI login. I can also restart the daemon, reboot the
> host, even restart the iSCSI backend service or appliance.
>
> Would any operations of such a kind be helpful to try?

iSCSI isn't my area of expertise, someone else might have an idea what
could be going on.


-- 
Chris Murphy
