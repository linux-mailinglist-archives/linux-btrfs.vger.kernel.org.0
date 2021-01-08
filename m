Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F782EF6B1
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Jan 2021 18:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbhAHRof (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jan 2021 12:44:35 -0500
Received: from smtp-33.italiaonline.it ([213.209.10.33]:40984 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728114AbhAHRoe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 8 Jan 2021 12:44:34 -0500
Received: from venice.bhome ([94.37.172.193])
        by smtp-33.iol.local with ESMTPA
        id xvnkkAVkW11DDxvnkkasu0; Fri, 08 Jan 2021 18:43:52 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1610127832; bh=jx5qo6y0O1I1ndeTP56WD5SbJ/NhfGnisdYNBppy9BA=;
        h=From;
        b=Ie96ErOBuXXnsnk46bkchsQSt2OwV0MTpnRwaDQkzRKqCs3XIffsES6zw0n+kvvEk
         JyKDn+D5lnziimVZzsNy7XLR0w5bhiDB0nQxRFBBlUK8eO8kRa5BeoY8RGwetFTZd3
         Jr16x37I52el70U9JEkc6YA0BtsvC+1lcV2BSA1HaicI9al5B78FyndCLCDEZM8yXe
         PpCFLvjRylVLqdveXO/W11VwMgglXbibh1ZigyVfhaB8yP0AHtW57lxw3McRXj/qbe
         8Ha6rd6ky+zUwM3VUrmo7o33QpZ08p7UdhFTj0wlT6e/0Y9VnXSeG7MvJdQu8NKQ6O
         46Ak1DtEuCYbQ==
X-CNFS-Analysis: v=2.4 cv=ba6u7MDB c=1 sm=1 tr=0 ts=5ff899d8 cx=a_exe
 a=z1y4hvBwYU35dpVEhKc0WA==:117 a=z1y4hvBwYU35dpVEhKc0WA==:17
 a=IkcTkHD0fZMA:10 a=QbysXcJIjD34N5RL6yQA:9 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: BTRFS and *CACHE setup [was Re: [RFC][PATCH V4] btrfs:
 preferred_metadata: preferred device for metadata]
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org, Michael <mclaud@roznica.com.ua>,
        Hugo Mills <hugo@carfax.org.uk>,
        Martin Svec <martin.svec@zoner.cz>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Paul Jones <paul@pauljones.id.au>,
        Adam Borowski <kilobyte@angband.pl>
References: <20200528183451.16654-1-kreijack@libero.it>
 <20210108010511.GZ31381@hungrycats.org>
 <bc7d874f-3f8b-7eff-6d18-f9613e7c6972@libero.it>
Message-ID: <0dbec46b-8f46-afca-c61a-51b85300b0f2@libero.it>
Date:   Fri, 8 Jan 2021 18:43:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <bc7d874f-3f8b-7eff-6d18-f9613e7c6972@libero.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfOYjQtd5RmlRl9ZedWnPmDMUuqlJAQjvwmP4/nt3x6gp5/EhVDkWdPEU9T3LSLfyX3HAzZ61TDAbVLgiir7ZeBVpT/zcxEbkGmON53AkDScHVTlYieLn
 Z2nOFLsag2ASt86er5++F3584u5yUrJ6yRo5YL3W/+jj9v9sCVusSrjAEpddX78VR6IizppLqjJKezRvS5bR1YMHMoS2NxVPFvFLzWhhtDZAooWHniVs0JrA
 hUVovkUJR792oQVlzo7hTAw5IoYa5jo/jZxGUAsXyHKushAQhHVTf1UT7v/knQ/cHErS6x4mV9O1Z5Wu8TlnpoqRhEPD0Iv9gzD0F64pKUzRdDcqxsBLrXZK
 OuopUBEmmlwDHIXAt3C7Gv9mw2WDbSF16dDaXLOlNic2bPlqItUIz9ZvFw9h39P1KeeuHHzu0/NhpblBRn29sU+vlPl1VA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/8/21 6:30 PM, Goffredo Baroncelli wrote:
> On 1/8/21 2:05 AM, Zygo Blaxell wrote:
>> On Thu, May 28, 2020 at 08:34:47PM +0200, Goffredo Baroncelli wrote:
>>>
> [...]
>>
>> I've been testing these patches for a while now.  They enable an
>> interesting use case that can't otherwise be done safely, sanely or
>> cheaply with btrfs.
> 
> Thanks Zygo for this feedback. As usual you are source of very interesting considerations.
>>
>> Normally if we have an array of, say, 10 spinning disks, and we want to
>> implement a writeback cache layer with SSD, we would need 10 distinct SSD
>> devices to avoid reducing btrfs's ability to recover from drive failures.
>> The writeback cache will be modified on both reads and writes, data and
>> metadata, so we need high endurance SSDs if we want them to make it to
>> the end of their warranty.  The SSD firmware has to not have crippling
>> performance bugs while under heavy write load, which means we are now
>> restricted to an expensive subset of high endurance SSDs targeted at
>> the enterprise/NAS/video production markets...and we need 10 of them!
>>
>> NVME has fairly draconian restrictions on drive count, and getting
>> anything close to 10 of them into a btrfs filesystem can be an expensive
>> challenge.  (I'm not counting solutions that use USB-to-NVME bridges
>> because those don't count as "sane" or "safe").
>>
>> We can share the cache between disks, but not safely in writeback mode,
>> because a failure in one SSD could affect multiple logical btrfs disks.
>> Strictly speaking we can't do it safely in any cache mode, but at least
>> with a writethrough cache we can recover the btrfs by throwing the SSDs
>> away.
[...]

Hi Zygo,

could you elaborate the last sentence. What I understood is that in
write-through mode, the ordering (and the barrier) are preserved.
So this mode should be safe (bug a part).

If this is true, it would be possible to have a btrfs multi (spinning)
disks setup with only one SSD acting as cache. Of course, it will
works only in write-through mode, and the main beneficial are related
to caching the data for further next read.

Does anyone have further experiences ? Does anyone tried to
recover a BTRFS filesystem when the cache disks died ?

Oh.. wait... Now I understood: if the caching disk read badly (but
without returning an error), the bad data may be wrote on the other
disks: in this case a single failure (the cache disk) may affect
all the other disks and the redundancy is lost ...

BR
G.Baroncelli
