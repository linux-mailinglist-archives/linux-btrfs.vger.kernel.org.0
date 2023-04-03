Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7516D4661
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Apr 2023 16:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbjDCOCT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Apr 2023 10:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbjDCOCR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Apr 2023 10:02:17 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC6625572
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Apr 2023 07:02:16 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id ew6so117697691edb.7
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Apr 2023 07:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680530534;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fPUu/gTEWMfRD2fUD0Lb+HeIXNcKu0v0MyoVKOZQn8c=;
        b=YLzofZtTIiGFrM2lfe/SI0NUrES6ntTem/IBLcC6V3hFWBZP5QSI+tCZH/DqDBm/cU
         Clf/2c5EAEjAkmXvi/X6Uo5uBXoedze1C6+lc2XSqnTGKpXKPnM2NVybgMigWrwW7a7Q
         t4La2CUg54IHZcgYoI+W5/uz8hdGb6wjek76etILZnpjLsvZA0FdNok012wnfDOzOsxl
         WDBb+DrLc3cOV91/AvHeZAggb7TyNFRoQomHmv7rXwCvN+xMqycyODKlQ9pHptxcp5IC
         fzVzGDuaK1Svb4xP3u3Vg7Bu5GemdcZ2C4rwEz7QHdC+aeE1m5gJ0RQeT+vlRDJwJTVV
         UpUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680530534;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fPUu/gTEWMfRD2fUD0Lb+HeIXNcKu0v0MyoVKOZQn8c=;
        b=lhwD9vpIK89EriAsywj+mSfH0r2vwzOkpJ6mgGMWqKnxc7gjaYF451ymQxZ8wBCtOB
         LvvmLbechKg/JJCvk5d1F6xrKyYnKXrLGyrRgJlObeM/hYu+QYiFX6ue8M1cYqhhwvLV
         70nHHpu1VtEpAvyhRr3TJpbsfsMAJbtZjKkkYL1uWMFc8Y1QO0Fi84IZ4T0D5Q51AtMY
         wulN0Y2zxQYyrJzlgFJboSFIHKoAD5OKzyY26/WYl+XP27yXqqPs/fYv275YGbGytKHp
         hGNVHz/2T5xSLksU1g+gfH4fFwj/LmFy74/gVpvTu8CmmmUusBVI+U4C/qg7XOsME1NI
         Wgrw==
X-Gm-Message-State: AAQBX9dtElCanOblXtTH3DvTzAa7gP70BMUe57bzhOE/sjOIoPwjV94b
        NkL0aNWe4OmPNM/v1Etc6NMGgfpxbaPgn01o4ZYA5KSHtho=
X-Google-Smtp-Source: AKy350bYf8V1hU2CQCUrG71zCNkGhng8R05jfe07e1P9ClGCVsWBMYtvSv5P/JZ6SHLWZthJcdAjYv/PXDLOJcfCAe0=
X-Received: by 2002:a17:907:d687:b0:93d:a14f:c9b4 with SMTP id
 wf7-20020a170907d68700b0093da14fc9b4mr17952730ejc.2.1680530534053; Mon, 03
 Apr 2023 07:02:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAL5DHTHak9PPOGqqQ9huxKMEdb0y_iiJqZvN+e-JQk6HrbcLkA@mail.gmail.com>
In-Reply-To: <CAL5DHTHak9PPOGqqQ9huxKMEdb0y_iiJqZvN+e-JQk6HrbcLkA@mail.gmail.com>
From:   Torstein Eide <torsteine@gmail.com>
Date:   Mon, 3 Apr 2023 16:01:57 +0200
Message-ID: <CAL5DHTFgb-47hSA+c0MW-4WTNTuntM+wWitKMcBtvuxF3pEZsg@mail.gmail.com>
Subject: [Feature request] Removing device
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi
I experienced a disk that started failing, and noticed some missing
feature around `btrfs device remove $Dev_to_remove $mount_point`.

## 1. Do the removal as a bakgrunn task.

Currently if run `btrfs device remove $Dev_to_remove $mount_point  `,
the process runs in foreground.
And the user disconnects, the process is terminated.

A way to fix this can be to  add a foreground flag (-B| --foreground
do not background), if a user wants to remove it in the foreground,
they can set a flag for it.

## 2. Feedback to the user that a device is in progress.

After a device removal is in progress, there is little feedback that
it has started successfully, and that is in progress.
I think there are 2 ways I would be given feedback:
- Standard output
- In `btrfs  device usage`
- in `btrfs  filesystem show|usage`

### 2.1. Standard output
To standard output i would like to get something like:

"Device $Dev_to_remove started on   $mount_point    , fsid $FSID"
If there is error will removing

### 2.2. `btrfs  device usage`

$Device, ID: $Device_ID
\s\s\sFlags:
\s\s\s\s\s\s- Removal in progress

### 2.3. `btrfs  filesystem show|usage`
Add a trail flag like "-R" after device name

$Device (-R) $size

## 2. Add a way to monitor progress.

With `btrfs scrub status $mount_point`, and `btrfs balance status $mount_point`
There is a output that user can use to monitor the progress of the removal:


````shell
#btrfs balance status  $mount_point
Balance on '/mnt/test' is running
3 out of about 3925 chunks balanced (4 considered), 100% left
````

````shell
#btrfs scrub status  $mount_point
UUID:             b1346130-c3c5-49d0-bd68-978ed7e4759a
Scrub started:    Mon Apr  3 13:42:00 2023
Status:           running
Duration:         0:09:41
Time left:        41:33:41
ETA:              Wed Apr  5 07:25:23 2023
Total to scrub:   18.54TiB
Bytes scrubbed:   73.42GiB
Rate:             129.41MiB/s
Error summary:    read=3849888
  Corrected:      0
  Uncorrectable:  0
  Unverified:     0
````
but for `device removal` there is now equal output.

## 3. Soft removal of device.

I noticed under SMART control that one of my other drives also started to fail.
But this BTRFS only can remove one device at the time, i don't want
new writes to be done to the second drive i am removing next.

So a flag like (-Rs), that tells BTFTS don't write new blocks to this device.

In this context soft remove will over timer, remove the device, as
opposed to hard/forced removal that uses active IO to  make new blocks
on other devices.

## 4. Autoremove device

If a device exceeds a user defined threshold, automatically set -Rs to
the devices.

Users are most of the time not actively look at  `btrfs device stats
`, so a feature to set a limit on how many errors are allows per time
unit, and if exceed the device is automatically given the remove
softly.

## 5. Error handling, will removing device
Will trying to remove device, the process stop do to `ERROR: error
removing device 'missing': Input/output error`

Journal output, is equally unhelpful:
````
Apr 03 13:40:28 server2 kernel: BTRFS warning (device sdc): csum
failed root -9 ino 374 off 2132144128 csum 0x8941f998 expected csum
0x8b2fa154 mirror 2
Apr 03 13:40:28 server2 kernel: BTRFS warning (device sdc): csum
failed root -9 ino 374 off 2132140032 csum 0x8941f998 expected csum
0xa7a0690b mirror 2
````

In this situation BTRFS needs to skip the bad blocks and focus on
blocks that work.
At the end it needs to print a list of paths of files that it was unable to fix.


-- 
Torstein Eide
Torsteine@gmail.com
