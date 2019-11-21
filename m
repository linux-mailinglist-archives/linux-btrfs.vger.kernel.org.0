Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF81D105068
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Nov 2019 11:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfKUKVU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Nov 2019 05:21:20 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36568 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfKUKVU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Nov 2019 05:21:20 -0500
Received: by mail-pf1-f194.google.com with SMTP id b19so1447293pfd.3
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Nov 2019 02:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qyA35dJYEqlsdrJZw//tTOSmzXD+DDk5DTQtTEouFRg=;
        b=ffBvtCKG6oJMMFeMPE64Hid2cP9rj3PYnqMqCGRw0dUAaYc97sd+Xt/PtDfMTYsRdV
         HxpckFogqaHyV7Mi2T919Wm4SH+SW/3fRUlbVJlWOzCpf0wNBz1GM4pRI7/uXcfycVx5
         qCHPbS692lmrnuRpLCu9xQxJ4cS2TqdrqHF0r/GhgPVibqv0ahy184YD7/HZWdT8eoOm
         /i1rmlTHsCVQhN0r1ngodVEya8tVq2SVE6UQUY699bRwZNYrIqUeWs7mOF/x8498lgvE
         1/pYQhLT8fiZXNitYa1SGJrKfRFzaq9JGRuvJLVOS7xa6X4ONRiB7LDn6h3d3xHRs5l6
         KKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qyA35dJYEqlsdrJZw//tTOSmzXD+DDk5DTQtTEouFRg=;
        b=K0qtkWOiOu9Cn2wyFl6zpSYlfQ9tldYjnOMXSVpG+Zt3ZIfXAlhUfOcHgU6BfXrj8h
         EvHAFpgPeNNqpH9d8DmlysTPQ3CIB4xGcLJeO67GI+MFvUN9CpNO3GqwamiFUvkl8sxy
         gL0UUnSseoILd4CO5jgRrmMp/TIagmwu+quWc+Y9fxNdiVX+X03JpG8970ktUAQxf5tq
         dw6T5qgLu9XIwJjoO6uO9UwvffO3EBg9YxI+IPrZ3rR4HTJ3JeNTXtboojXlQsIHFoZR
         a5fdyVgTnVjGk/9U0oNkAqcjwEOwdMbcdcnpfaaq4fj3pTzpjFRUU7c7BVfsE31vAcfQ
         yWmg==
X-Gm-Message-State: APjAAAUxBfBblupAfeG7yI4q9b2tcad+FAJyBrh91yC4yvzEd9FDWH5o
        CpLUmw2PmZWXKcxAkipYv2+7cRYim1TRXw==
X-Google-Smtp-Source: APXvYqxy2AXLIrMFyi9Iyw8f78o98DJ1jRDPMmD3kG2B6QeQgqvlg8+WjFjXGqGs93BAQi+ROZbQug==
X-Received: by 2002:a63:43c3:: with SMTP id q186mr8034473pga.95.1574331678620;
        Thu, 21 Nov 2019 02:21:18 -0800 (PST)
Received: from [192.168.1.145] ([39.109.145.141])
        by smtp.gmail.com with ESMTPSA id k32sm2482101pje.10.2019.11.21.02.21.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 02:21:17 -0800 (PST)
From:   Anand Jain <anandsuveer@gmail.com>
X-Google-Original-From: Anand Jain <anand.jain@oracle.com>
Subject: Re: How to replace a missing device with a smaller one
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Nathan Dehnel <ncdehnel@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAEEhgEt_hNzY7Y3oct767TGGOHpqvOn4V_xWoOOB0NfYi1cswg@mail.gmail.com>
 <58154d62-7f6e-76ee-94d5-00bfcd255e59@gmx.com>
 <d9cc411e-804d-d1c4-f65f-60a9c383b690@gmx.com>
 <20191119143857.GU3001@twin.jikos.cz>
 <0a8fd2a8-12fe-f899-5a53-b5f584a35878@gmx.com>
 <20191120000524.GE22121@hungrycats.org>
Message-ID: <fba31f91-a5d4-a443-0f03-56be73763d67@oracle.com>
Date:   Thu, 21 Nov 2019 18:21:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191120000524.GE22121@hungrycats.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/20/19 8:05 AM, Zygo Blaxell wrote:
> On Wed, Nov 20, 2019 at 08:02:43AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2019/11/19 下午10:38, David Sterba wrote:
>>> On Mon, Nov 18, 2019 at 03:08:00PM +0800, Qu Wenruo wrote:
>>>> On 2019/11/18 下午1:32, Qu Wenruo wrote:
>>>>> On 2019/11/18 上午10:09, Nathan Dehnel wrote:
>>>>>> I have a 10-disk raid10 with a missing device I'm trying to replace. I
>>>>>> get this error when doing it though:
>>>>>>
>>>>>> btrfs replace start 1 /dev/bcache0 /mnt
>>>>>> ERROR: target device smaller than source device (required 1000203091968 bytes)
>>>>>>
>>>>>> I see that people recommend resizing a disk before replacing it, which
>>>>>> isn't an option for me because it's gone.
>>>>>
>>>>> Oh, that's indeed a problem.
>>>>>
>>>>> We should allow to change missing device's size.
>>>>
>>>> I have CCed you with a patch to allow user to *shrink* the missing device.
>>>>
>>>> You can also get the patch from patchwork:
>>>> https://patchwork.kernel.org/patch/11249009/
>>>>
>>>> Please give a try, since the device size is pretty small, I believe with
>>>> that patch, we can go quick shrink, that means "btrfs fi resize" command
>>>> should return immediately.
>>>
>>> So it can be recteated eg. on loop devices, where some of them are
>>> slightly smaller, then go missing and replace is started, right?
>>>
>>
>> Replace will still be rejected, but we can do resize of that missing
>> dev, then replace, as a workaround.
>>
>> I haven't do the auto-resize for replace yet, since I'm not sure if that
>> could make cases like replacing 1T device with 10G driver happening.
> 
> That case would be much more tolerable if device replace/resize/delete would
> stop to check for fatal signals at least between block groups, if not more
> often.  Currently if you pick the wrong size, the only way to make it stop
> is to reboot.

  I agree. IMO too
     btrfs replace --<option to skip-check|auto-resize>
  is better as commented in the patch thread.

  Already if you comment out the size checks[1], the replace with
  a smaller device works fine. But But you have to manually estimate
  the disk size for the actual consumption. So the effort here should
  be auto pre-check.

[1]

diff --git a/cmds/replace.c b/cmds/replace.c
index 2321aa156fe2..1a4155d360d6 100644
--- a/cmds/replace.c
+++ b/cmds/replace.c
@@ -246,11 +246,13 @@ static int cmd_replace_start(const struct 
cmd_struct *cmd,
                 goto leave_with_error;

         dstdev_size = get_partition_size(dstdev);
+/*
         if (srcdev_size > dstdev_size) {
                 error("target device smaller than source device 
(required %llu bytes)",
                         srcdev_size);
                 goto leave_with_error;
         }
+*/

         fddstdev = open(dstdev, O_RDWR);
         if (fddstdev < 0) {


diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 9a29d6de9017..86fc0f8653be 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -214,7 +214,7 @@ static int btrfs_init_dev_replace_tgtdev(struct 
btrfs_fs_info *fs_info,
                 }
         }

-
+/*
         if (i_size_read(bdev->bd_inode) <
             btrfs_device_get_total_bytes(srcdev)) {
                 btrfs_err(fs_info,
@@ -222,7 +222,7 @@ static int btrfs_init_dev_replace_tgtdev(struct 
btrfs_fs_info *fs_info,
                 ret = -EINVAL;
                 goto error;
         }
-
+*/

         device = btrfs_alloc_device(NULL, &devid, NULL);
         if (IS_ERR(device)) {





>> Thanks,
>> Qu
>>
> 
> 
> 

