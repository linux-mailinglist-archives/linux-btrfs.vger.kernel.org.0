Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02EF710B0F1
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2019 15:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfK0OPr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Nov 2019 09:15:47 -0500
Received: from mail-qt1-f175.google.com ([209.85.160.175]:46029 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbfK0OPq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Nov 2019 09:15:46 -0500
Received: by mail-qt1-f175.google.com with SMTP id 30so25444786qtz.12
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Nov 2019 06:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=bVHtNgvsO+pqoxlp3DiiLUwne81VLxMm55SwI+5rWp8=;
        b=K5rh3al9XG2h/QwYEtZ75TSRuj9okcgKNDqETlQFwZB4/jWmTComVA2KWc+Oo4kxEH
         eB4kibVgcu8Aqsfb7WEsbmXoNe9ErTQSXrF9YdA+cejUzvFJEOQqlDDJu3/yFxfc4XK1
         yFLD6M5K72a4+iDw/gO/tfYCGxYQRKar/1GBfbqkrMCSXu0PGvCX36SurF7A2CVrhHKe
         VirhbUqLGiZW/7+lNp5efUsHzGQGectXhyjOFZErpeN+efEpZT3r6CSrqowbmBGrXt3s
         EGs0cnuRzXIdPqRKZM6vdM8sQb53Zc5lYiblpwY42kKPxhHcbT+kUQR563OsIOPGVQlD
         8Tig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bVHtNgvsO+pqoxlp3DiiLUwne81VLxMm55SwI+5rWp8=;
        b=Gyv7sEEo6ODG0TEdAlRr3CqY63G+lNZN2Lv5pHhCehMaTE5lDdMjDrod3kFaoZkjvY
         dZ+mZsQQv3lq2jga2wWMSDog4qeD56l9daydPc6dkkO31+5BxiohRsVc01G/lzjvZiZ8
         BaLLrL835Em1m+bRxEP4dOgAe2pWOAkz1Nr7wGKhsb3He8cB9CGp1yyeukzKjmMnGklE
         to6SsSoFF5RKLmGAwHS2E13oucvzzsjuZEUcgE55nBupmJkh1NCgHjgo6vNSCFknwR8f
         rSYfYFOxUYW5N6eauL7NDk/lbbkNRU+GWMG783raRa4cxMOwLNvOBSYr24FP2ti0gs79
         earg==
X-Gm-Message-State: APjAAAW5r+/2voD66WcRI9DM+7DgwvUzeWIqFbsouLDwSv7kRCCo6L12
        HyhqIzKSX0cN0scrjIsenv1ORwVGus4=
X-Google-Smtp-Source: APXvYqwuuEUuBPaFAHNpySczfW40dIWoWYbtuGz6Yc2kAdsQHZZIgxyoB1qzuOE1OQ1RpZnMuWCOQA==
X-Received: by 2002:ac8:7405:: with SMTP id p5mr3838088qtq.113.1574864143913;
        Wed, 27 Nov 2019 06:15:43 -0800 (PST)
Received: from [192.168.255.200] (user-12l2ihc.cable.mindspring.com. [69.81.74.44])
        by smtp.gmail.com with ESMTPSA id i203sm2095393qke.126.2019.11.27.06.15.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2019 06:15:43 -0800 (PST)
Subject: Re: bad sector / bad block support
To:     Christopher Staples <mastercatz@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CAGsZeXsEZ8EqPsuU9O+7d+suxBVNQAobASJaLNMZB9LhUe6Q7A@mail.gmail.com>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <c1473267-688c-201f-11e5-64761ad51f79@gmail.com>
Date:   Wed, 27 Nov 2019 09:15:41 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAGsZeXsEZ8EqPsuU9O+7d+suxBVNQAobASJaLNMZB9LhUe6Q7A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-11-26 22:30, Christopher Staples wrote:
> will their ever be a better way to handle bad sectors ?  I keep
> getting silent corruption from random bad sectors
> scrubs keep passing with out showing any errors , but if I do a
> ddrescue backup to a new drive I find the bad sectors
Zygo is correct, if there are no checksum errors, it's almost certainly 
not the storage device.

Put simply, for a media error to cause corruption without a checksum 
error, all of the following need to happen at the same time:

* At least one sector in a data block has to go bad without the storage 
device's built-in error correction catching it. If the ECC functionality 
of the drive caught it, it would either return the correct data or a 
read error. This is actually rather unlikely for small numbers of 
devices (but the likelihood of it happening goes up as you increase the 
number of devices involved).
* A mix of similar errors in the block containing the checksum for the 
data block has to similarly go bad without being detected or corrected 
and it has to match up with the corrupted data _or_ the checksum for the 
corrupted data block has to be valid for the corrupted data. This is 
astronomically unlikely, to a level that you're far more likely to be 
struck and killed by a meteor than this happening.
* The above then has to happen for the checksum for the metadata block 
containing the checksum for that data block, and in turn the same 
condition has to repeat for each block up the tree to the root (usually 
3+ times). This is so unlikely to be a statistical impossibility.

So, as Zygo suggests, check your RAM, check your CPU, possibly check 
your PSU (bad power supplies can cause all kinds of weird things).
> 
> 
> the only thing I can do for now is mark I/O error files as bad buy
> renaming them and make another file copy onto the file system ,
> 
> 
> I like btrfs for the snapshot ability , but when it comes to keeping
> data safe ext4 seems better ? at least it looks for bad sectors and
> marks them , btrfs just seems to write and assumes its written ..

ext4 wouldn't save you here, because you almost certainly aren't dealing 
with bad sectors.

BTRFS doesn't include bad sector support like ext4 because it solves the 
issue a different way, namely by checksumming everything and then 
validating the checksums on read.

On a slightly separate note, you should never need the ext4 bad block 
functionality on any modern hardware unless your storage devices are way 
beyond the point at which they should be replaced.  The original reason 
for having bad block lists in the filesystem was that disk drives didn't 
remap bad sectors, which in turn meant that the filesystem had to deal 
with them. It's been multiple decades since that was the case though, 
and all modern storage devices (except possibly some really cheap USB 
flash drives) remap bad sectors and only let the OS see them when they 
run out of space to remap them to.
