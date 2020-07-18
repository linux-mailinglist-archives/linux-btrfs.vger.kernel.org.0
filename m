Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23BA224AA8
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Jul 2020 12:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgGRKgu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 18 Jul 2020 06:36:50 -0400
Received: from bang.steev.me.uk ([81.2.120.65]:38529 "EHLO smtp.steev.me.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726490AbgGRKgu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 Jul 2020 06:36:50 -0400
Received: from [2001:8b0:162c:2:f8a9:5acc:1acd:b676]
        by smtp.steev.me.uk with esmtpsa (TLS1.3:TLS_AES_128_GCM_SHA256:128)
        (Exim 4.93.0.4)
        id 1jwkCz-00HXll-6t; Sat, 18 Jul 2020 11:36:45 +0100
Subject: Re: Filesystem Went Read Only During Raid-10 to Raid-6 Data
 Conversion
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
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
From:   Steven Davies <btrfs-list@steev.me.uk>
Message-ID: <de9a3d52-0147-255c-4c39-09bf734e1435@steev.me.uk>
Date:   Sat, 18 Jul 2020 11:36:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717055706.GJ10769@hungrycats.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17/07/2020 06:57, Zygo Blaxell wrote:
> On Thu, Jul 16, 2020 at 09:11:17PM -0400, John Petrini wrote:

--snip--

>> /dev/sdf, ID: 12
>>     Device size:             9.10TiB
>>     Device slack:              0.00B
>>     Data,RAID10:           784.31GiB
>>     Data,RAID10:             4.01TiB
>>     Data,RAID10:             3.34TiB
>>     Data,RAID6:            458.56GiB
>>     Data,RAID6:            144.07GiB
>>     Data,RAID6:            293.03GiB
>>     Metadata,RAID10:         4.47GiB
>>     Metadata,RAID10:       352.00MiB
>>     Metadata,RAID10:         6.00GiB
>>     Metadata,RAID1C3:        5.00GiB
>>     System,RAID1C3:         32.00MiB
>>     Unallocated:            85.79GiB
> 
> OK...slack is 0, so there wasn't anything weird with underlying device
> sizes going on.
> 
> There's 3 entries for "Data,RAID6" because there are three stripe widths:
> 12 disks, 6 disks, and 4 disks, corresponding to the number of disks of
> each size.  Unfortunately 'dev usage' doesn't say which one is which.

RFE: improve 'dev usage' to show these details.

As a user I'd look at this output and assume a bug in btrfs-tools 
because of the repeated conflicting information.

-- 
Steven Davies
