Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C99402CD3
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Sep 2021 18:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbhIGQ3o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Sep 2021 12:29:44 -0400
Received: from smtp-31.italiaonline.it ([213.209.10.31]:52678 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233877AbhIGQ3n (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Sep 2021 12:29:43 -0400
Received: from venice.bhome ([78.12.137.210])
        by smtp-31.iol.local with ESMTPA
        id Ndxbm3HVhzHnRNdxbmp1ob; Tue, 07 Sep 2021 18:28:35 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1631032115; bh=nQLj5CebZj4o2dI9KIGBzfbvEB3MbRNy70xXMx/+UvE=;
        h=From;
        b=swawNr3b+OJa6Og2IyJYlKalQ/2jg/Q2mWGfQCn2oeHr5F8t51Pejt6+tuc5XT2Ih
         uOW3eGe1xwgEfSNonP9fgcL1Z47crDO1UDNuOBi4ahssHADK4Eb1XIKYIKK1hg+87L
         T+BoA6QYiQBg1xDMUPcsu1yR/5VmjJxJxgqVaL6pFgjKVM6WtYzpGlWdRuUYwnbPcu
         UedWZy08lI59skWUu/OxNYz5r3pC/uVQ4Lncb3ycFg1Yy7K/rKifAIXZ30JmdBHXWW
         fRcWbfhIkX0pFIW/H3awHLvSVIzgaz/drh1J4vm5Rc37H7qbqfz2mv4LlGHXsjcQb1
         1+7lyKX1ZIkBg==
X-CNFS-Analysis: v=2.4 cv=L6DY/8f8 c=1 sm=1 tr=0 ts=61379333 cx=a_exe
 a=VHyfYjYfg3XpWvNRQl5wtg==:117 a=VHyfYjYfg3XpWvNRQl5wtg==:17
 a=IkcTkHD0fZMA:10 a=1xae1QhLAAAA:8 a=GcwI0rFiquSfpKI_1SsA:9 a=QEXdDO2ut3YA:10
 a=b-fQNwddwzsWbJgTXFiA:22
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH 1/2] btrfs-progs: fi show: Print missing device for a
 mounted file system
To:     g.btrfs@cobb.uk.net, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210902100643.1075385-1-nborisov@suse.com>
 <c5930e90-ca5b-4089-6f2e-830af6576baa@gmx.com>
 <7c4ecbc6-41a7-5375-42cc-9bf87ff35507@suse.com>
 <5030bc35-fdda-b297-94e4-d484f8aee444@gmx.com>
 <4da2f41d-c1e0-1da9-e4c9-bfe87067a6af@suse.com>
 <b5dba5a6-256b-ee5c-57f2-84e9875e6c0a@gmx.com>
 <757eb738-a9f0-0c6b-a713-dc89122eb5f6@cobb.uk.net>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <42717291-444f-cfc2-ea5c-95bd7b9a8c29@libero.it>
Date:   Tue, 7 Sep 2021 18:28:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <757eb738-a9f0-0c6b-a713-dc89122eb5f6@cobb.uk.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfL8B3Zb4MrBcdbsxQP4QpNe77adBaf1j5XsNBJ2Uj+ZY52QCO0qp1Ur34aOChFB5IlVHgnXYPbk4xkx2ZWvG//4z/J8dFgUdu9p1WxvqIMoqXTQLngak
 W3+uUPnlcYpBUIUC40TMkk7pM53njx7d9Vc6+wJ4yFdZgFTYQv6Um1AJ6Jq31ohLsCYUQLivVWKDV2e0PhPAw7VbLWF+mTMPMeqwYKXqkwkQAxcwCYSwzHQB
 18LdvLgtru0GV7hKjf7g3cVmzbjTdw3wfZ+duve+q70Sr+D0UkwDutrIW9YJM1TG
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/6/21 6:47 PM, g.btrfs@cobb.uk.net wrote:
> 
> On 02/09/2021 13:17, Qu Wenruo wrote:
>>
[...]
> I realise this comment might be too late so feel free to ignore it if
> so. Could this path name potentially conflict with a (new) device using
> the same name? For example, could someone have created a new /dev/loop1?
> Or could a USB disk /dev/sdf1 (say) have been removed and a different
> disk inserted and acquired the /dev/sdf1 name? Or would that be
> prevented in the case where "the device's record was still in the
> fs_devices"?
> 
> If so, I think this could be very confusing to the user trying to work
> out what has happened. Maybe the output needs to change to something like:
> 
> devid    2 size 0 used 0 last seen as /dev/loop1 ***MISSING***
> 
> "last seen as" could just be "previously". Or, to make it even clearer
> that this is just a hint to help the user understand which device is
> missing, maybe something like "(last mounted as /dev/loop1)".
> 


My 2¢:

   Label: none  uuid: 4a85a40b-9b79-4bde-8e52-c65a550a176b
	  Total devices 2 FS bytes used 128.00KiB
   	  devid    1 size 5.00GiB used 1.26GiB path /dev/loop0
	  devid    2 size 0 used 0 ***MISSING*** (last seen as /dev/loop1)

I suggest to swap MISSING and 'last seen as...' part, because I think that the most
important part of the message is MISSING.


> Graham
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
