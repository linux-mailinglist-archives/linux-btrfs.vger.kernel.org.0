Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC5D1F0C62
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jun 2020 17:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgFGP3w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 7 Jun 2020 11:29:52 -0400
Received: from smtp-34.italiaonline.it ([213.209.10.34]:56173 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726619AbgFGP3w (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 7 Jun 2020 11:29:52 -0400
Received: from venice.bhome ([78.12.136.199])
        by smtp-34.iol.local with ESMTPA
        id hxF6jVRpctrlwhxF7jDKWv; Sun, 07 Jun 2020 17:29:49 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1591543789; bh=EXmHN+zTGkBGoAaqgJJ7hMfOcpvcz7Aq2hOi6ilJAyI=;
        h=From;
        b=pDpG+Jvu4VC91BW50rNYrh+ha9NqLRwGG4Emxh+2zlcYLFPVI4IFkKFW3E587tCHN
         mtF1KZURIJPGdNZfXrK8UcyfuxOEvKJHYBCNsSYx2Ty8Dd3CGrW/lWEIefUHExr4YR
         SbCQRuNx53Hvyb9AnrEtawPfMYv7QQX+mshorCKbg+xRR++LvNWrkPfBPqCLxOB5/6
         wvY9DoZ/M4brEmL+0DuMT+8G9XA/n2R3NaZ8PFEy0nlMH7268NK1F7rFyWVw8+aiIy
         3pmG4OIpz4N4yASGimyVMEDEFG/4jNl//efvtPzzibXx+eWdCNTXGlQYqVeInbuNlT
         tnxEUJuRHm7rQ==
X-CNFS-Analysis: v=2.3 cv=TOE7tGta c=1 sm=1 tr=0
 a=kx39m2EDZI1V9vDwKCQCcA==:117 a=kx39m2EDZI1V9vDwKCQCcA==:17
 a=IkcTkHD0fZMA:10 a=OKuaToMikj6r8xDHfFIA:9 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: balance + ENOFS -> readonly filesystem
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <20200607051217.GE12913@qmqm.qmqm.pl>
 <88e8b58e-9a4c-1f3e-4b08-8a56de191dd4@gmx.com>
 <20200607083452.GA9208@qmqm.qmqm.pl>
 <41bfa30e-cc9f-5f26-3aab-c141a9e3aa91@libero.it>
 <20200607105018.GA2249@qmqm.qmqm.pl>
From:   Goffredo Baroncelli <kreijack@inwind.it>
Message-ID: <bba0847a-dcd3-6fe0-0c59-8d79f4b6ea2f@inwind.it>
Date:   Sun, 7 Jun 2020 17:29:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200607105018.GA2249@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfMFQ+Uw9aZwVAR6ko0mETUmQpnuzkvstsYBeb6RxbGz1UEv+IDmeSQRNPVSi4nG+yymizU83m08V+U+0OHFboy9Bd9lSRQaHjm26XnFzNK7o2u8W2aVv
 19TpVlFOaADsegPOqPvvwf7jEIgfU8W7EflBm/Y53kzfOctnodISxn/GwhBaATixKNP1Nj6dv2HR1zgK96JaHUEOg/esNZ+tXxlOEY5z7pICIcjGWwkxsupl
 zsGeSfZW1vnOXGpfcFFGYA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Michał

On 6/7/20 12:50 PM, Michał Mirosław wrote:
> On Sun, Jun 07, 2020 at 12:09:30PM +0200, Goffredo Baroncelli wrote:
[...]
>>> # btrfs filesystem usage .
>>> Overall:
>>>       Device size:                   1.82TiB
>>>       Device allocated:            932.51GiB
>>>       Device unallocated:          930.49GiB
>>>       Device missing:                  0.00B
>>>       Used:                        927.28GiB
>>>       Free (estimated):            933.86GiB      (min: 468.62GiB)
>>>       Data ratio:                       1.00
>>>       Metadata ratio:                   2.00
>>>       Global reserve:              512.00MiB      (used: 0.00B)
>>>
>>> Data,single: Size:928.47GiB, Used:925.10GiB
>>>      /dev/mapper/btrfs1         927.47GiB
>>>      /dev/mapper/btrfs2           1.00GiB
>>>
>>> Metadata,RAID1: Size:12.00MiB, Used:1.64MiB
>>>      /dev/mapper/btrfs1          12.00MiB
>>>      /dev/mapper/btrfs2          12.00MiB
>>>
>>> Metadata,DUP: Size:2.00GiB, Used:1.09GiB
>>>      /dev/mapper/btrfs1           4.00GiB
>>>
>>> System,DUP: Size:8.00MiB, Used:144.00KiB
>>>      /dev/mapper/btrfs1          16.00MiB
>>>
>>> Unallocated:
>>>      /dev/mapper/btrfs1           1.02MiB
>>>      /dev/mapper/btrfs2         930.49GiB
>>
>> The old disk is full. And the fact that Metadata has a raid1 profile prevent further metadata allocation/reshape.
>> The filesystem goes RO after the mount ? If no a simple balance of metadata should be enough; pay attention to select
>> "single" profile for metadata for this first attempt.
>>
>> # btrfs balance start -mconvert=single <mnt-point>
>>
>> This should free about 4G from the old disk. Then, balance the data
>>
>> # btrfs balance start -d <mnt-point>
>>
>> Then rebalance the metadata as raid1, because now you should have enough space.
>>
>> # btrfs balance start -mconvert=raid1 <mnt-point>
> 
> Thanks! It worked all right! (data rebalance wasn't needed.)

Which metadata profile will you set ?
If you set a RAID1 metadata profile, in the long term you will face the same problem. And even if you use a different metadata profile than RAID1, I suggest to switch to RAID1 as metadata profile.

 From the "btrfs fi us" output, balance the data is not an high urgency, however I strongly suggest to do soon.


> 
> Best Regards,
> Michał Mirosław
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
