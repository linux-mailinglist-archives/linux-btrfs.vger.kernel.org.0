Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF1B913B7A1
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2020 03:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbgAOCYL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jan 2020 21:24:11 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44911 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728862AbgAOCYL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jan 2020 21:24:11 -0500
Received: by mail-wr1-f66.google.com with SMTP id q10so14219775wrm.11
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jan 2020 18:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=po7M++cKHf1+0u7DadnWcNf/a+M8CfPlR4MrLdOyKU8=;
        b=KQII8EQv7msc52QT72Na0/3lIJy6hvm4boQjP7SYkOdHX/3Bb9U4T31rAywnTeliJ0
         i325vCGWvqU4Jv+JUOXMi4dbgpbxb7H1lOA/QrGJa5il71ceRMrBQ0Q2VzAedKo5l5Ah
         IuquQPYrAR2MEl6bunYWcjctF6F+r4FS6HQZFxTKzSmslQ/A5VaiOdWM5pVEBJz6PxSK
         wk4HKIjMfXhvWyHNqq2tv9IOn6y6vU9PtpANNM4dGEb4bjAJUMPDgCV4eH8ZgiQ7yeRg
         5AZt3P7p4Lz3yofUy3NmKFns+7uk7yXvoOxn5M6KUJai5TeBFqVV+p9U7Rc0Sff9ST0g
         LAbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=po7M++cKHf1+0u7DadnWcNf/a+M8CfPlR4MrLdOyKU8=;
        b=tG62NmunN2UzLmhf7EN6KJ9qnl8yLPoZjqGMVOrZb5GzTkhFsVcQ7fnCDk9HwSapt6
         ATFs5a35/Qi7j/2baUSvmj4naqsipnwWyrbxNirmVLv3F1CjqWFEVvmFXDM0romexgr2
         9qeazflaKCQw6G8I+yOrMtZMIAP6pSfOKGwExBdtcKgEgD0k0h9CetZwgpVCxMvZA+t7
         pwTDACZLMKrcCJJ3kQ8Cymy71BEYCi/MB85LI/WfaBvz8D92t+M/zaExs267+gLht5NI
         K2AiGL//KZDepVGWKBcHpzW8icg/kjlq2nb4YXjKUQQS1zeFun26shBG8hQrsQmaKLTn
         frCw==
X-Gm-Message-State: APjAAAUsBQ4TNmw4NFAG4PKTk96X5nJqlTTpc8OZingXxDLYtyiKCaqc
        blyv2hzk9uU7zjkL6SqTu4M+00/pwl6ursECm1z7x8/SQXhCVw==
X-Google-Smtp-Source: APXvYqyyBZ5WQ//JfhMM8Kq4fqx2m1tU+zsC4bSY9RIls0ZknkOiXuMJ2OmUgR6Z6FsviS6MSNNEXHhe/t+VGAo6iHo=
X-Received: by 2002:adf:9c8f:: with SMTP id d15mr28662333wre.390.1579055048945;
 Tue, 14 Jan 2020 18:24:08 -0800 (PST)
MIME-Version: 1.0
References: <107f8e94-78bc-f891-0e1b-2db7903e8bde@forever.cz>
 <CAJCQCtSeq=nY7HTRjh0Y_0PRJt579HwromzS0NkdF4U6kn_wiA@mail.gmail.com>
 <2e55d20c-323f-e1a2-cdde-8ba0d50270e7@forever.cz> <CAJCQCtQhVQrnq7QnTd6ryDSg4SAGv55ceJ+H8LTM6MEYzQX4jQ@mail.gmail.com>
 <ce3fb06f-5a24-df55-f1b5-a0c2b176ec13@forever.cz>
In-Reply-To: <ce3fb06f-5a24-df55-f1b5-a0c2b176ec13@forever.cz>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 14 Jan 2020 19:23:52 -0700
Message-ID: <CAJCQCtTijDTQiaO-SUPZ-R40dQbLmrfKhGLCifv6=fB2O6zxJA@mail.gmail.com>
Subject: Re: slow single -> raid1 conversion (heavy write to original LVM volume)
To:     jn <jn@forever.cz>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Jan  8 12:28:54 sopa kernel: [   13.552491] BTRFS info (device dm-0):
disk space caching is enabled
Jan  8 12:28:54 sopa kernel: [   13.803006] BTRFS info (device dm-0):
bdev /dev/mapper/sopa-data errs: wr 420, rd 44, flush 0, corrupt 0,
gen 0

Any idea what these are and if they're recent or old? This is the
original device with all the data and there are read and write errors.
Write errors mean writes have been dropped. It's usually an indicator
of a device problem.

Jan  8 12:59:40 sopa kernel: [  229.560937] Alternate GPT is invalid,
using primary GPT.
Jan  8 12:59:40 sopa kernel: [  229.560954]  sdb: sdb1 sdb2 sdb3

This suggests something overwrote the backup GPT on /dev/sdb. This
probably isn't related to the problem you're having, because it comes
before you add /dev/sdb3 to the Btrfs volume, and doesn't look like
Btrfs has written anything to /dev/sdb3 at this point. But whatever
did this should be tracked down, and in the meantime the backup GPT
should be fixed. Most anything will fix it these days, I send to use
gdisk.


Jan 10 08:16:12 sopa kernel: [156022.305629] BTRFS info (device dm-0):
relocating block group 2051006267392 flags data
Jan 10 08:16:23 sopa kernel: [156033.373144] BTRFS info (device dm-0):
found 75 extents


Last line repeats hundreds of times, over the course of hours. Even if
it's highly fragmented, I wouldn't expect it takes this long to read
75 extents. The differential is reasonable in some cases if these are
small 4K file, but others, it's suspicious:

Jan 10 12:10:14 sopa kernel: [170063.613418] BTRFS info (device dm-0):
found 75 extents
Jan 10 12:10:44 sopa kernel: [170093.813300] BTRFS info (device dm-0):
found 75 extents

But no errors, for many hours.

I can't really make much out of the task list, whether Btrfs is the
cause or a victim.


---
Chris Murphy
