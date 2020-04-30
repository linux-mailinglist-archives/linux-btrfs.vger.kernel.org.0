Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D300D1C072F
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Apr 2020 21:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgD3T7d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Apr 2020 15:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgD3T7d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Apr 2020 15:59:33 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDACC035494
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Apr 2020 12:59:33 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id f15so2711128plr.3
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Apr 2020 12:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ka9q-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ZTrGvK1D+y/1ac75YwNVysCZ4zPrEpLeQbeXOCi3Eyk=;
        b=PRyrM9GE9kVLhNtZwGV6lLUpirbTFE/SbEEEL1xIVQpc+o7L3GY1CArrZIhjcUpuFL
         rJ6SneFhIBP+HJJwQJTjyvO5WYQJ2Jnz/Ny2i1sxUnqictwSAZrOqEY/icFzmP90zRBq
         iI0HG2pj+2MFqiCrN8YzDzIPwHKkB2PCO0bhdO3kxWFI2bRd9SIQTxTVuVAulZ6rzEo7
         B/DrNDf2y5TI+AG8iaaheLTlaDdVWIrctQ7g+0C1nVAo8Ctm9UX2uf2xUC1fiDGLkS0o
         e2It9XZtL9J1419RAyiBlOMk+XEOOrEFrjEgUrW17EHf6KCzDcsJltDSrKTnarkRljyN
         POBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=ZTrGvK1D+y/1ac75YwNVysCZ4zPrEpLeQbeXOCi3Eyk=;
        b=pdIeckFHPgH8pNqBSgN/bAko56snPKTu6AxFi2P0wDEcV8jfB6spm2n681W2HUc+qu
         fp21M1Wf2cOE2h9gLCeWu31mO8uE7W5VtjOlzUE2GK5CstVR6neHLV4ay/cv3RsrY+mR
         wek0izrqJfqfrWC1NI2AiMtN6DF4EYp3L3ALnyz/uZfsEszZVHM6fG3Sor36z8HMrvIA
         Xu+evkcfwjy+GIY4yWHErQKuPJLvEp1zwQ5BQUUCAd13y9P72MaaGP4YZU3cSIkF0hRy
         xo+hIvhtP3c0YhMgdePfUCbaFu7L1Tn35tmL4HneRX0iMe9pUGWqlG99kEtEtiyz8Orx
         dRZA==
X-Gm-Message-State: AGi0PuZ8h9DVUOKIRt32Y1HD2QAc8+muB/ezZnOK10H7NMv5ITx6DONV
        F+Tq6tMyrRqZlsjfa9zN8n1Www==
X-Google-Smtp-Source: APiQypLbc3MCmzMtYqYuLZ+JpttENKDqL6Jstc1KOQlWT97FPro7fqlWUwiG3+1+LQXMjWkISlvmOQ==
X-Received: by 2002:a17:902:5ac2:: with SMTP id g2mr663951plm.167.1588276772293;
        Thu, 30 Apr 2020 12:59:32 -0700 (PDT)
Received: from selma.local ([2605:e000:1c0e:43f7:85d2:c317:ef64:6afd])
        by smtp.gmail.com with ESMTPSA id b9sm520593pfp.12.2020.04.30.12.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 12:59:31 -0700 (PDT)
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <8b647a7f-1223-fa9f-57c0-9a81a9bbeb27@ka9q.net>
 <14a8e382-0541-0f18-b969-ccf4b3254461@ka9q.net>
 <CAJCQCtQqdk3FAyc27PoyTXZkhcmvgDwt=oCR7Yw3yuqeOkr2oA@mail.gmail.com>
From:   Phil Karn <karn@ka9q.net>
Autocrypt: addr=karn@ka9q.net; keydata=
 mQENBEw2mJ4BCADELiPsLFHDwapoSU7d2xNHxmwzzrFUCZWhO34kM6G5+o9GUNmGgMQ0BmXp
 I6hx77HHnrj9FC6kWh/bxBt3+o8HW+NTWzJSvf6kW7ThaNt7v9iewkS23JOMarAZs4qy6MhT
 1RW1/yWY7RimWxrmkKPTKKa0Ad4CWT6fcP3t+doqGslSQIeoTh0C33ZT+LY59Wcr224iXohN
 4Uu/nFe4yAHjtA+4Sesveo3Tyi8cbOgkcO6vij+pXesCcuhtGMlnE2dxRqbenrfVGLUVxNug
 LkQdLWezaGGm+dcjWYk1xjtaDnsCpVaYCMsfYNADQPJAjAFu37pVdoXhseVXfzOUN2EXABEB
 AAG0GVBoaWwgS2FybiA8a2FybkBrYTlxLm5ldD6JATgEEwECACIFAkw2mJ4CGwMGCwkIBwMC
 BhUIAgkKCwQWAgMBAh4BAheAAAoJEPFOQ1TtRjRGU98H/Atsb/N4lNbzNdzdIRcHD9XgCEa1
 UdR4mxgjwvLxS1nYRNdHwfTxvA5nxWfMx/0CB26VaNFdI3lkg/S0vYsSUu6M7l8Zb8v4JMyU
 4B4yvkFHZ3II5oilzIMa3e2cMfDz7TSwO1JcXyI5y9vHnvH65/LQF+QojDgzf3vXKiNdTXJp
 3nEa5IgMAB0rcSNsXFx8xbHi8s5niL9+1I7XTPvVMeXrMe8h4AG1nM/dK96WwmV+tLyXKYXn
 xVeb9F4X9CNQbkn/xAH+egvKHHT3V7K9cAhrDfu9Qwpo7zKk/akBpLWG2kmkTOfhXjm3UQhv
 MVgDmpeQIYa1HgAsKrsDQMzrIFm5AQ0ETDaYngEIAJmFdm0MmENzLEosD1FvGPJleWDYb0ah
 8dOk4XUug1RhW40f7AsugT75pKs9PolXt92920GdU727X3Jpgdj4kLDtIQA0KZrOXiEOZjIZ
 WcROAyvTGyMs/P7Um1AGNM161Ga6/Wtlc076FN7EUQtzPbthH26M3lGWUX0Ccls/8Ep4qbnF
 IrMRBxjaxKbqfKPTeU10pDykzA7s5hiNe7qaegvqD6YLseZ+6FqCn988YnLiIaFeNbWxUY5G
 spjAsfesnAmpn5vhUqAGiizkNlAMIN31xvpLd93oM4/vORszIuN1UP2RlxL3s30BncZl2XOd
 Mk1/59Sy70zVqF1ANyMrA18AEQEAAYkBHwQYAQIACQUCTDaYngIbDAAKCRDxTkNU7UY0Rszt
 B/9ZPH9xw47lPkVJRbhgf0G7fdsxsyiuouAqOKklUNFSy4+qeGomjwE6YvdMybwGtaUGla7t
 2mDzrva+7Gzb0inXIgmahQPmM16F3GVxGoFL+QJ+7gD8Hco6e0/2kju7ZREDE7SOEwKb3lhD
 eNLccfX2AqAHfCT/LVLbgBpMRmwUJQThM+33Z2L9BqIM3awj2mOTmeDumpxiDfroU90mGc9c
 pXe4YrNIkL/N8eMzLe1bpu+mpPCiIrEO+dFA7N8jjVcOCQ4Lr8sU6cOsEdkaACZiNFKT99eb
 NkKigK8sEkDZc/AKhPCEsnaZpwBZPScOL88LLi7FHj9Osznt+uhWfbLe
Subject: Re: Extremely slow device removals
Message-ID: <bfa161e9-7389-6a83-edee-2c3adbcc7bda@ka9q.net>
Date:   Thu, 30 Apr 2020 12:59:29 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtQqdk3FAyc27PoyTXZkhcmvgDwt=oCR7Yw3yuqeOkr2oA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/30/20 11:40, Chris Murphy wrote:
> It could be any number of things. Each drive has at least 3
> partitions so what else is on these drives? Are those other partitions
> active with other things going on at the same time? How are the drives
> connected to the computer? Direct SATA/SAS connection? Via USB
> enclosures? How many snapshots? Are quotas enabled? There's nothing in
> dmesg for 5 days? Anything for the most recent hour? i.e. journalctl
> -k --since=3D-1h

Nothing else is going on with these drives. Those other partitions
include things like EFI, manual backups of the root file system on my
SSD, and swap (which is barely used, verified with iostat and swapon -s).=


The drives are connected internally with SATA at 3.0 Gb/s (this is an
old motherboard). Still, this is 375 MB/s, much faster than the drives'
sustained read/write speeds.

I did get rid of a lot of read-only snapshots while this was running in
hopes this might speed things up. I'm down to 8, and willing to go
lower. No obvious improvement. Would I expect this to help right away,
or does it take time for btrfs to reclaim the space and realize it
doesn't have to be copied?

I've never used quotas; I'm the only user.

There are plenty of messages in dmesg of the form

[482089.101264] BTRFS info (device sdd3): relocating block group
9016340119552 flags data|raid1
[482118.545044] BTRFS info (device sdd3): found 1115 extents
[482297.404024] BTRFS info (device sdd3): found 1115 extents

These appear to be routinely generated by the copy operation. I know
what extents are, but these messages don't really tell me much.

The copy operation appears to be proceeding normally, it's just
extremely, painfully slow. And it's doing an awful lot of writing to the
drive I'm removing, which doesn't seem to make sense. Looking at
'iostat', those writes are almost always done in parallel with another
drive, a pattern I often see (and expect) with raid-1.

>
> It's an old kernel by this list's standards. Mostly this list is
> active development on mainline and stable kernels, not LTS kernels
> which - you might have found a bug. But there's thousands of changes
> throughout the storage stack in the kernel since then, thousands just
> in Btrfs between 4.19 and 5.7 and 5.8 being worked on now. It's a 20+
> month development difference.
>
> It's pretty much just luck if an upstream Btrfs developer sees this
> and happens to know why it's slow and that it was fixed in X kernel
> version or maybe it's a really old bug that just hasn't yet gotten a
> good enough bug report still, and hasn't been fixed. That's why it's
> common advice to "try with a newer kernel" because the problem might
> not happen, and if it does, then chances are it's a bug.
I used to routinely build and install the latest kernels but I got tired
of that. But I could easily do so here if you think it would make a
difference. It would force me to reboot, of course. As long as I'm not
likely to corrupt my file system, I'm willing to do that.
>
>> I started the operation 5 days ago, and of right now I still have 2.18=

>> TB to move off the drive I'm trying to replace. I think it started
>> around 3.5 TB.
> Issue sysrq+t and post the output from 'journalctl -k --since=3D-10m'
> in something like pastebin or in a text file on nextcloud/dropbox etc.
> It's probably too big to email and usually the formatting gets munged
> anyway and is hard to read.
>
> Someone might have an idea why it's slow from sysrq+t but it's a long s=
hot.

I'm operating headless at the moment, but here's journalctl:

-- Logs begin at Fri 2020-04-24 21:49:22 PDT, end at Thu 2020-04-30
12:07:12 PDT. --
Apr 30 12:04:26 homer.ka9q.net kernel: BTRFS info (device sdd3): found
1997 extents
Apr 30 12:04:33 homer.ka9q.net kernel: BTRFS info (device sdd3):
relocating block group 9019561345024 flags data|raid1
Apr 30 12:05:21 homer.ka9q.net kernel: BTRFS info (device sdd3): found
6242 extents

> If there's anything important on this file system, you should make a
> copy now. Update backups. You should be prepared to lose the whole
> thing before proceeding further.
Already done. Kinda goes without saying...
> KB
> Next, disable the write cache on all the drives. This can be done with
> hdparm -W (cap W, lowercase w is dangerous, see man page). This should
> improve the chance of the file system on all drives being consistent
> if you have to force reboot - i.e. the reboot might hang so you should
> be prepared to issue sysrq+s followed by sysrq+b. Better than power
> reset.
I did try disabling the write caches. Interestingly there was no obvious
change in write speeds. I turned them back on, but I'll remember to turn
them off before rebooting. Good suggestion.
> Boot, leave all drives connected, make sure the write caches are
> disabled, then make sure there's no SCT ERC mismatch, i.e.
> https://raid.wiki.kernel.org/index.php/Timeout_Mismatch

All drives support SCT. The timeouts *are* different: 10 sec for the new
16TB drives, 7 sec for the older 6 TB drives.

But this shouldn't matter because I'm quite sure all my drives are
healthy. I regularly run both short and long smart tests, and they've
always passed. No drive I/O errors in dmesg, no evidence of any retries
or timeouts. Just lots of small apparently random reads and writes that
execute very slowly. By "small" I mean the ratio of KB_read/s to tps in
'iostat' is small, usually less than 10 KB and often just 4KB.

Yes, my partitions are properly aligned on 8-LBA (4KB) boundaries.

>
> And then do a scrub with all the drives attached. And then assess the
> next step only after that completes. It'll either fix something or
> not. You can do this same thing with kernel 4.19. It should work. But
> until the health of the file system is known, I can't recommend doing
> any device replacements or removals. It must be completely healthy
> first.
I run manual scrubs every month or so. They've always passed with zero
errors. I don't run them automatically because they take a day and
there's a very noticeable hit on performance. Btrfs (at least the
version I'm running) doesn't seem to know how to run stuff like this at
low priority (yes, I know that's much harder with I/O than with CPU).
>
> I personally would only do the device removal (either remove while
> still connected or remove while missing) with 5.6.8 or 5.7rc3 because
> if I have a problem, I'm reporting it on this list as a bug. With 4.19
> it's just too old I think for this list, it's pure luck if anyone
> knows for sure what's going on.

I can always try the latest kernel (5.6.8 is on kernel.org) as long as
I'm not likely to lose data by rebooting. I do have backups but I'd like
to avoid the lengthy hassle of rebuilding everything from scratch.

Thanks for the suggestions!

Phil



