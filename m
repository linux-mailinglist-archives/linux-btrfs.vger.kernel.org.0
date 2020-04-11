Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7361A5396
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Apr 2020 21:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgDKTqr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Apr 2020 15:46:47 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:54803 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgDKTqr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Apr 2020 15:46:47 -0400
Received: by mail-wm1-f41.google.com with SMTP id h2so5653434wmb.4
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Apr 2020 12:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4tDJ073dHZEjGcVnC6frcUQq+Mb3G2nFXKgsYtaAA7Q=;
        b=lLW0dg5KmNUopbZQjThPfd0kfh7bzTadcDOsqAghYmhpbr6W9aFmLcikiuvCwzVBEA
         7VsCC13tHF2oMOXfIdS0oErtttpT9SbG2VNG9fxSc7r7BuzxZX1v9iy4Q6QZXajWPumL
         oX+yWJE0BwuFiZhlcDsQUq3s9zMS5dRtLl5BsaXMwyg1iLemzHQJhR3BoA1r0uPOxBjk
         zHcbx2Dv38itPIrXQlybzOWgg8trtEKjWfUwhbeWeZQ0zmNq2xOF1UlT8rJ3QaT3FBFL
         /PcWenWI3eYnecBnMQO0wQ88U1W7q8Ch7lNt7SEMAPGxQXBlOh/yWKwNpepAQT+jTfbi
         zdhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4tDJ073dHZEjGcVnC6frcUQq+Mb3G2nFXKgsYtaAA7Q=;
        b=ql4tGpkbG9MxeqpoMGe5vXmTdJ0mjMbUaXoYNl1M3aqwrTinKFAOivmwubXr386gzs
         bU4D+Y5w89bGiWLjr9kywT12X67v7KBUkTAQrJf9cLZlyA0UK762y8p0GphYOANGxfQW
         n9u28itFtdY7eJeBtOTBR+2s1fG8FNKzhKO0IkQ7wYDe0h7KxHVqMsZif9ywOZUwUZZv
         YKFGkGTCNW5kFoyKyNM4sBBBjuWH5RAsjV2zemCaAPDJgmPmoZciWPTmOrUl9IzpZeQ8
         dfH0x+0Q7DxtkOp5vzW+ZEFwmRNIeNP5/Bfucu6sJbc5aMURhkqEPpzN9ZUDoOcbWdkE
         ZcPg==
X-Gm-Message-State: AGi0PuZX86mVv7iKlOks4N8PXHum3LipXY7eSsay7USdAAZBi7RAwNx4
        qySkWOzqXB8P1BlbZAy1Rw9FiqR2
X-Google-Smtp-Source: APiQypKzeHUccoDXEc4qqSXAPVZY6TdnJGMEn1Cy6cRyYAdrM2+/ckPQ1DKQmuU7wrQ5lL85qdXayw==
X-Received: by 2002:a1c:f60c:: with SMTP id w12mr10889184wmc.29.1586634405323;
        Sat, 11 Apr 2020 12:46:45 -0700 (PDT)
Received: from ?IPv6:2001:984:3171:0:126:e139:19f1:9a46? ([2001:984:3171:0:126:e139:19f1:9a46])
        by smtp.gmail.com with ESMTPSA id p10sm7891434wrm.6.2020.04.11.12.46.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Apr 2020 12:46:44 -0700 (PDT)
Subject: Re: btrfs freezing on writes
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
References: <6a1c8ce0-ce2a-698d-dcc6-0657a125dae4@gmail.com>
 <20200409043245.GO13306@hungrycats.org>
 <e1ed482f-158a-650a-f586-d8ad0310157d@gmail.com>
 <20200409230724.GM2693@hungrycats.org>
From:   kjansen387 <kjansen387@gmail.com>
Message-ID: <a4c5fcd2-c6cd-71e2-560e-9c7290e0c47d@gmail.com>
Date:   Sat, 11 Apr 2020 21:46:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200409230724.GM2693@hungrycats.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I have tried to rebalance metadata..

Starting point:
# btrfs fi usage /storage
Overall:
     Device size:                  10.92TiB
     Device allocated:              7.45TiB
     Device unallocated:            3.47TiB
     Device missing:                  0.00B
     Used:                          7.35TiB
     Free (estimated):              1.78TiB      (min: 1.78TiB)
     Data ratio:                       2.00
     Metadata ratio:                   2.00
     Global reserve:              512.00MiB      (used: 0.00B)

Data,RAID1: Size:3.72TiB, Used:3.67TiB (98.74%)
    /dev/sdc        2.81TiB
    /dev/sdb        2.81TiB
    /dev/sda     1017.00GiB
    /dev/sdd      840.00GiB

Metadata,RAID1: Size:6.00GiB, Used:5.09GiB (84.86%)
    /dev/sdc        3.00GiB
    /dev/sdb        3.00GiB
    /dev/sda        1.00GiB
    /dev/sdd        5.00GiB

System,RAID1: Size:32.00MiB, Used:608.00KiB (1.86%)
    /dev/sdb       32.00MiB
    /dev/sdd       32.00MiB

Unallocated:
    /dev/sdc      845.02GiB
    /dev/sdb      845.99GiB
    /dev/sda      845.02GiB
    /dev/sdd     1017.99GiB

I did:
# btrfs fi resize 4:-2g /storage/
# btrfs balance start -mdevid=4 /storage
# btrfs fi resize 4:max /storage/

but the distribution of metadata ended up like before.

I also tried (to match the free space of the other disks):
# btrfs fi resize 4:-172g /storage/
# btrfs balance start -mdevid=4 /storage
# btrfs fi resize 4:max /storage/

again, the distribution of metadata ended up like before..

Any other tips to rebalance metadata ?


On 10-Apr-20 01:07, Zygo Blaxell wrote:
> On Thu, Apr 09, 2020 at 11:53:00PM +0200, kjansen387 wrote:
>> btrfs fi resize 1:-1g /export;           # Assuming 4GB metadata
>> btrfs fi resize 2:-2g /export;           # Assuming 5GB metadata
> 
> Based on current data, yes; however, it's possible that the device remove
> you are already running might balance the metadata as a side-effect.
> Redo the math with the values you get after the device remove is done.
> You may not need to balance anything.
> 
>> btrfs balance start -mdevid=1 /export;   # Why only devid 1, and not 2 ?
> 
> We want balance to relocate metadata block groups that are on both
> devids 1 and 2, i.e. the BG has a chunk on both drives at the same time.
> Balance filters only allow one devid to be specified, but in this case
> 'devid=1' or 'devid=2' is close enough.  All we want to do here is filter
> out block groups where one mirror chunk is already on devid 3, 4, or 5,
> since that would just place the metadata somewhere else on the same disks.
> 
>> btrfs fi resize 1:max /export;
>> btrfs fi resize 2:max /export;
>>
>> Thanks!
>>
>>
