Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1D67226DB6
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jul 2020 19:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731032AbgGTR5x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jul 2020 13:57:53 -0400
Received: from smtp-32.italiaonline.it ([213.209.10.32]:34235 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726699AbgGTR5w (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jul 2020 13:57:52 -0400
Received: from venice.bhome ([78.12.13.37])
        by smtp-32.iol.local with ESMTPA
        id xa2vjeUoNzS33xa2vjGxF6; Mon, 20 Jul 2020 19:57:50 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1595267870; bh=pk7X31+oUMxE7tGCRumshEMZpYxAcx4FhvOGqwvThoU=;
        h=From;
        b=WyL+rwfM+8L4CkqvSmxwyFrBu1w97SYsAlotpfIQkFKaeXzOezsNrPVetlLtDqAY9
         1EJo6o0y0ccg2hsYakpVblPcEgZm6XBwqPwu79AaQ5wKCEx2Q/n6QCej7x/D+d5eJB
         7Lhm0irZtw1j5azWCl0bJepnCXtLcCtm9VXHpcAlt4ilm5CsTYGmXZT4ueT1skHFES
         azy9c9xTBNNOyc2gvRDFw8SKxPVUzoI+3GRIZK+0AiAkthOD/BpCWY01E8F4VkcbRH
         +RiEmAoe1XykyDXhIY4nEXl4AHvVnhPWKN0OQFo3D8duuB6qbrqSNIw+cro/twvK7B
         m9ZuzJ2WapyJw==
X-CNFS-Analysis: v=2.3 cv=PLVxBsiC c=1 sm=1 tr=0
 a=XJAbuhTEZzHZh8gzL9OeLg==:117 a=XJAbuhTEZzHZh8gzL9OeLg==:17
 a=IkcTkHD0fZMA:10 a=belFwQ2eRTcRM_bPuc8A:9 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: Filesystem Went Read Only During Raid-10 to Raid-6 Data
 Conversion
To:     Steven Davies <btrfs-list@steev.me.uk>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        John Petrini <john.d.petrini@gmail.com>
Cc:     John Petrini <me@johnpetrini.com>, linux-btrfs@vger.kernel.org
References: <CADvYWxeiNynEWUYwfQxP7fQTK4k2Q+eDZsA8j7rLcaTSeND9fg@mail.gmail.com>
 <20200715011843.GH10769@hungrycats.org>
 <CADvYWxcq+-Fg0W9dmc-shwszF-7sX+GDVig0GncpvwKUDPfT7g@mail.gmail.com>
 <20200716042739.GB8346@hungrycats.org>
 <CADvYWxdvy5n3Tsa+MG9sSB2iAu-eA+W33ApzQ3q9D6sdGR9UYA@mail.gmail.com>
 <CAJix6J9kmQjfFJJ1GwWXsX7WW6QKxPqpKx86g7hgA4PfbH5Rpg@mail.gmail.com>
 <20200716225731.GI10769@hungrycats.org>
 <CADvYWxcMCEvOg8C-gbGRC1d02Z6TCypvsan7mi+8U2PVKwfRwQ@mail.gmail.com>
 <20200717055706.GJ10769@hungrycats.org>
 <de9a3d52-0147-255c-4c39-09bf734e1435@steev.me.uk>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <507b649c-ac60-0b5c-222f-192943c50f16@libero.it>
Date:   Mon, 20 Jul 2020 19:57:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <de9a3d52-0147-255c-4c39-09bf734e1435@steev.me.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfAa5NPZs83n3PLtir/YBUne7gvsg70s2xAfCMPFhNnUPMi5LJDMqbz0wwZJYtzehbOynPI3XY+u2PD43Z/VKYMeduyjA2TEsMB/MH3j/k6K3Lx3mASf3
 MhkA6ZO0ypePz89ClwnTas+RXqOwxP4x5YBO+3zMb/GTWUq8+0yg6OPdzH58tjLf4n++j2QqeANduxu5f0u81TrdH5a1BXNR0jdNV9a2hFD/B1yjaiDWbCkb
 Kw5qc+aZU+OknnonMDTTD/a6H7y1XSP5cOe/tWqbdYw2gx0JdkyWqBoXELJVlqExHG3k+s30LLKLVTa/qaWwNA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/18/20 12:36 PM, Steven Davies wrote:
> On 17/07/2020 06:57, Zygo Blaxell wrote:
>> On Thu, Jul 16, 2020 at 09:11:17PM -0400, John Petrini wrote:
> 
> --snip--
> 
>>> /dev/sdf, ID: 12
>>>     Device size:             9.10TiB
>>>     Device slack:              0.00B
>>>     Data,RAID10:           784.31GiB
>>>     Data,RAID10:             4.01TiB
>>>     Data,RAID10:             3.34TiB
>>>     Data,RAID6:            458.56GiB
>>>     Data,RAID6:            144.07GiB
>>>     Data,RAID6:            293.03GiB
>>>     Metadata,RAID10:         4.47GiB
>>>     Metadata,RAID10:       352.00MiB
>>>     Metadata,RAID10:         6.00GiB
>>>     Metadata,RAID1C3:        5.00GiB
>>>     System,RAID1C3:         32.00MiB
>>>     Unallocated:            85.79GiB
>>
[...]
> 
> RFE: improve 'dev usage' to show these details.
> 
> As a user I'd look at this output and assume a bug in btrfs-tools because of the repeated conflicting information.

What would be the expected output ?
What about the example below ?

  /dev/sdf, ID: 12
      Device size:             9.10TiB
      Device slack:              0.00B
      Data,RAID10:           784.31GiB
      Data,RAID10:             4.01TiB
      Data,RAID10:             3.34TiB
      Data,RAID6[3]:         458.56GiB
      Data,RAID6[5]:         144.07GiB
      Data,RAID6[7]:         293.03GiB
      Metadata,RAID10:         4.47GiB
      Metadata,RAID10:       352.00MiB
      Metadata,RAID10:         6.00GiB
      Metadata,RAID1C3:        5.00GiB
      System,RAID1C3:         32.00MiB
      Unallocated:            85.79GiB


Another possibility (but the output will change drastically, I am thinking to another command)

Filesystem '/'
	Data,RAID1:		123.45GiB
		/dev/sda	 12.34GiB
		/dev/sdb	 12.34GiB
	Data,RAID1:		123.45GiB
		/dev/sde	 12.34GiB
		/dev/sdf	 12.34GiB
	Data,RAID6:		123.45GiB
		/dev/sda	 12.34GiB
		/dev/sdb	 12.34GiB
		/dev/sdc	 12.34GiB
	Data,RAID6:		123.45GiB
		/dev/sdb	 12.34GiB
		/dev/sdc	 12.34GiB
		/dev/sdd	 12.34GiB
		/dev/sde	 12.34GiB
		/dev/sdf	 12.34GiB


The number are the chunks sizes (invented). Note: for RAID5/RAID6 a chunk will uses near all disks; however for (e.g.) RAID1  there is the possibility that CHUNKS use different disks pairs (see the two RAID1 instances).


BR
G.Baroncelli


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
