Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9EA144D1C
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2020 09:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgAVISW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jan 2020 03:18:22 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:33368 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgAVISW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jan 2020 03:18:22 -0500
Received: by mail-wr1-f51.google.com with SMTP id b6so6256217wrq.0
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jan 2020 00:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=LfXnWK3Z+QI8gfjG3oTGW/IoSHRDs4IkVKADVbMAeww=;
        b=RihGDOmvXNyq4Co2ONLJPt7AxTLr4f43dzBacyztGiumEJqV0ybuZqIma93D+LvQMw
         2WqfZ5cprFmcvayGl76S5GmkkfilusoHVWtvlLwJ5Uodf/fhfUcBBJbfUNyOWNvttSCR
         6EHgZkSEChhu/LFixSw6hdP0saramS2YTg9KhTCEiM4sMJHOD3sJVRb67GE3lDgsEnS+
         UzPRE1Pbtu2pLeJaOv8bFW8G5zrgFXy+zr7KYtArxZrTRoUBxxxBl6dOXcoitPMxBQpl
         t2JWyCnqPsuHSaWFb9VeEk5U/6SgNNFGnZRpNuMAbzGV3es5hkLOJ0ddT3O8CGWoyZGj
         zvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LfXnWK3Z+QI8gfjG3oTGW/IoSHRDs4IkVKADVbMAeww=;
        b=jE8l30Jttp564ylre2SVx+rPN9Z1hzf+GWioNrBvyVafvi0zx27oa+K77egrLS6NB1
         jJ7VXsguhE+/77TtWja8NrjljPfBAYEGfPx3mTOOA56ZrIr5wmZRMmRBX+x5mlCO7ljo
         tndQ13vY1hBVmrOH605XYv0w44DZKas+MwPJ3QbFXDQZzLPpnd6luEfTboAuw6RGxRrB
         /7BtgtbvM0Gzy++QbEkKhhY5hDP12FbmLZ5yuYVxJ3NQC/BDcDBAqcqf3NVjacVt6/a+
         h2pVChyIs38lrKD+rPtffJBiy4trVpGDqkjT8YBpLcOXu2DjCSj83bGRAdy0mfFjpTIg
         nIkw==
X-Gm-Message-State: APjAAAWmplp6+nsrR6MxcFA9bv+zNFjsUivSSZPb0+qYsmSwg+FtlMup
        IJcfLayCYDwBx00yiSiMR+9UOzkn
X-Google-Smtp-Source: APXvYqxDTS0WieAihBLWwu30kDh5F5rv4mAhfkQvozHBpFzSr36j4VmXbzSnG3Z00NyEhosAO/hPwQ==
X-Received: by 2002:adf:f311:: with SMTP id i17mr10313729wro.81.1579681099884;
        Wed, 22 Jan 2020 00:18:19 -0800 (PST)
Received: from ?IPv6:2001:984:3171:0:126:e139:19f1:9a46? ([2001:984:3171:0:126:e139:19f1:9a46])
        by smtp.gmail.com with ESMTPSA id f1sm2732718wmc.45.2020.01.22.00.18.19
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 00:18:19 -0800 (PST)
Subject: Re: btrfs raid1 balance slow
From:   kjansen387 <kjansen387@gmail.com>
To:     linux-btrfs@vger.kernel.org
References: <6bc329d9-6dc5-a4bc-e7c4-eccd377823eb@gmail.com>
 <176ec92f-56ba-4c8a-bcce-115c69fb7eeb@gmail.com>
Message-ID: <79b677e2-8aee-ecd5-bb7e-c5fabeb0b2c8@gmail.com>
Date:   Wed, 22 Jan 2020 09:18:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <176ec92f-56ba-4c8a-bcce-115c69fb7eeb@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hmm, for some reason, I did not get the mail from Hugo and Qu (had too 
look it up in the archive). I think there is a delay when subscribing to 
the email list.

 > Do you have lots of snapshots? It can take a lot of time on some of
the metadata chunks if there's lots of shared extents.

No, I do not have any snapshots. Never made one - just got started with 
btrfs.
# btrfs subvolume show /export | grep Snap
         Snapshot(s):


 > Are you using qgroup?

No, quotas are disabled:
# btrfs qgroup show /export
ERROR: can't list qgroups: quotas not enabled


 >Please use kernel newer than v5.2, which contains the optimization.

I'm running 5.4.10-200.fc31.x86_64, that should be good


 > Just as Hugo said, cancel the current one, add all device, then 
rebalance.

Yes, that would be the best. I'm moving data however.. Expand btrfs > 
move the content of a 2TB disk > use that disk to expand btrfs > move 
the content of a 2TB disk etc. When this balance is done I'll move 2TB, 
find a temp drive to store the other 2TB and add the remaining 2 drives 
in 1 go.

I'm not in a hurry.. just wondering if this is normal. As I had 2x4TB 
with 150GB free and am adding 1x2TB (~1800GB, ~900 after raid1) I would 
expect that I will end up with 150+900=1050 GB free (usable), spread 
like (approx.):
4TB disk 1: 420GB (previously: 75GB)
4TB disk 2: 420GB (previously: 75GB)
2TB disk: 210GB

Thinking very simplisticly -and that's probably where I'm wrong, just 
wondering if it's a factor 8 wrong- this would mean 420-75 = 345GB read 
from each 4TB disks and written to the new 2TB disk. At a rate of 20MB/s 
(pretty conservative, but I do have a little bit of load) this should 
take like 10 hours. It will, however, at this rate, take approx. 82 
hours. Even if all data needs to be read (does it? ~3500GB net) it 
should only take ~50 hours..

Klaas
