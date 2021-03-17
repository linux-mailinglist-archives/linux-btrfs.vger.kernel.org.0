Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C8F33F4F6
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Mar 2021 17:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhCQQEu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Mar 2021 12:04:50 -0400
Received: from mail.xmyslivec.cz ([83.167.247.77]:49662 "EHLO
        mail.xmyslivec.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbhCQQEi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Mar 2021 12:04:38 -0400
X-Greylist: delayed 536 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Mar 2021 12:04:38 EDT
Received: from [172.23.0.68] (mh1-fw.logicworks.mh.etn.cz [82.113.58.199])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.xmyslivec.cz (Postfix) with ESMTPSA id 60EF640246;
        Wed, 17 Mar 2021 16:55:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=xmyslivec.cz;
        s=master; t=1615996538;
        bh=JBMyqbIihgalcArsZ+QbCW8HrguuuQNErHtTO+I+rG0=;
        h=To:Cc:References:From:Subject:Date:In-Reply-To:From;
        b=Y4kAB/OmYBJU7x2IkPa+FBCO9lXmtna1WDvYmgg/bZrDZhYbdHbq+f/2QyPDpzF/u
         VpcR9fLwzAByj5lEIFKWWrehQV2eeeOJA2s9sBmAhUPuRYM3fCslJNzM34XdPEBDVn
         F3DDwC3XQhrGNrG+YiRFjBRrVnCVqMSo5AQZblmvE2iUpQEh1LaEE/mLBBeVBxs4k8
         hVjnLBcbFnxY5n1OdecPeE+vxdiI8pal1P29pM/QAkbRlzQc+sAs4MR85EymrrQxrk
         7v+jZ+pSg2M1pq+uzc+rxd4Hsc90Jd+XYj2A72WFbM04HUeI7t9i3gU8QkgV7pQ2xS
         T8u0H5KsJHAOQ==
To:     Manuel Riel <manu@snapdragon.cc>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Michal Moravec <michal.moravec@logicworks.cz>,
        songliubraving@fb.com, guoqing.jiang@cloud.ionos.com,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux-RAID <linux-raid@vger.kernel.org>
References: <d3fced3f-6c2b-5ffa-fd24-b24ec6e7d4be@xmyslivec.cz>
 <CAJCQCtSfz+b38fW3zdcHwMMtO1LfXSq+0xgg_DaKShmAumuCWQ@mail.gmail.com>
 <29509e08-e373-b352-d696-fcb9f507a545@xmyslivec.cz>
 <CAJCQCtRx7NJP=-rX5g_n5ZL7ypX-5z_L6d6sk120+4Avs6rJUw@mail.gmail.com>
 <695936b4-67a2-c862-9cb6-5545b4ab3c42@xmyslivec.cz>
 <CAJCQCtQWNSd123OJ_Rp8NO0=upY2Mn+SE7pdMqmyizJP028Yow@mail.gmail.com>
 <2f2f1c21-c81b-55aa-6f77-e2d3f32d32cb@xmyslivec.cz>
 <CAJCQCtTQN60V=DEkNvDedq+usfmFB+SQP2SBezUaSeUjjY46nA@mail.gmail.com>
 <4b0dd0aa-f77b-16c8-107b-0182378f34e6@xmyslivec.cz>
 <CAJCQCtQWh2JBAL_SDRG-gMd9Z1TXad7aKjZVUGdY1Akj7fn5Qg@mail.gmail.com>
 <5e79d1f8-7632-48ef-de56-9e79cba87434@xmyslivec.cz>
 <CAJCQCtTR1JZTLr+xTEZxrwh8xSfb+zpKjc+_S2tJGFofVMUdSQ@mail.gmail.com>
 <0c792470-6ee9-8254-dd57-a7a90ac95bcd@xmyslivec.cz>
 <DBB07C8C-0D83-47DC-9B91-78AD385775E3@snapdragon.cc>
 <D3026A55-A7F2-4432-87A8-3E9B2CACE4C2@snapdragon.cc>
 <56AD80D0-6853-4E3A-A94C-AD1477D3FDA4@snapdragon.cc>
From:   Vojtech Myslivec <vojtech@xmyslivec.cz>
Subject: Re: Linux RAID with btrfs stuck and consume 100 % CPU
Message-ID: <5e9e627f-7f73-c243-8084-58f156b984c5@xmyslivec.cz>
Date:   Wed, 17 Mar 2021 16:55:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <56AD80D0-6853-4E3A-A94C-AD1477D3FDA4@snapdragon.cc>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks a lot Manuel for your findings and information.

It's good to know btrfs is not causing this issue and the common symptom 
is an MD journal on another RAID device.

I have moved journal from logical volume on RAID1 to a plain partition 
on a SSD and I will monitor the state.

Vojtech



On 17. 03. 21 5:35, Manuel Riel wrote:
> Final update on this issue for anyone who encounters a similar problem in the future:
> 
> I didn't observe any "hanging" RAID devices after using an ordinary NVMe partition as journal. So using e.g. another md-RAID1 array as journal doesn't seem to be supported.
> 
> The docs[1] say "This means the cache disk must be ... sustainable." The sustainable part motivated me to use a md-RAID1 array. I think the docs should mention that the journal can't be on another RAID array.
> 
> I'm sending in a patch to emphasize this in the docs.
> 
> 
> 1: https://www.kernel.org/doc/html/latest/driver-api/md/raid5-cache.html
> 
>> On Feb 28, 2021, at 4:34 PM, Manuel Riel <manu@snapdragon.cc> wrote:
>>
>> Hit another mdadm "hanger" today. No more reading possible and md4_raid6 stuck at 100% CPU.
>>
>> I've now moved the write journal off the RAID1 device. So it's not a "nested" RAID any more. Hope this will help.
>>
>> With only one hardware device used as write cache, I suppose only write-through mode[1] is suggested now.
>>
>>
>> 1: https://www.kernel.org/doc/Documentation/md/raid5-cache.txt
> 
