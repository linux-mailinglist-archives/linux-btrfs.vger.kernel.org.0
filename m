Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE1874B474
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2019 10:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731377AbfFSI6p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jun 2019 04:58:45 -0400
Received: from ns211617.ip-188-165-215.eu ([188.165.215.42]:53348 "EHLO
        mx.speed47.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731347AbfFSI6p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jun 2019 04:58:45 -0400
Received: from [10.158.252.5] (unknown [92.184.96.174])
        by box.speed47.net (Postfix) with ESMTPSA id 9F1D41AFC;
        Wed, 19 Jun 2019 10:58:42 +0200 (CEST)
Authentication-Results: box.speed47.net; dmarc=fail (p=none dis=none) header.from=lesimple.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lesimple.fr;
        s=mail01; t=1560934722;
        bh=NFdUA4gsixhyM0XTiYGC/9DonmKK/gG9Fh5tmKJ1Hew=;
        h=From:To:Date:In-Reply-To:References:Subject;
        b=ukyrzWQNDXf+epq3y7ud4VsBWbrRoHWpj+dOs9oqX3rX7pdpyDvFF7sawFOR3yMWD
         BaShBlzhMwr7kRXBf5ZG8GTvbSvyaRwV6DrGxM+iu/2UvggfnI95a1btAi9T3MeihU
         OqkeALE+Fz6pjCIuNdnh31vleQI3PQttI2gLg10s=
From:   =?UTF-8?B?U3TDqXBoYW5lIExlc2ltcGxl?= <stephane_btrfs@lesimple.fr>
To:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Hugo Mills <hugo@carfax.org.uk>, <linux-btrfs@vger.kernel.org>
Date:   Wed, 19 Jun 2019 10:58:42 +0200
Message-ID: <16b6ef5a5e8.2787.faeb54a6cf393cf366ff7c8c6259040e@lesimple.fr>
In-Reply-To: <42d90ede-b469-0c9e-2a97-1d53df5eeaaf@gmail.com>
References: <16b6bd72bc0.2787.faeb54a6cf393cf366ff7c8c6259040e@lesimple.fr>
 <20190618184501.GJ21016@carfax.org.uk>
 <42d90ede-b469-0c9e-2a97-1d53df5eeaaf@gmail.com>
User-Agent: AquaMail/1.20.0-1458 (build: 102100001)
Subject: Re: Rebalancing raid1 after adding a device
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



Le 19 juin 2019 05:27:21 Andrei Borzenkov <arvidjaar@gmail.com> a écrit :

> 18.06.2019 21:45, Hugo Mills пишет:
> ...
>>
>>> Is there a way to ask the block group allocator to prefer writing to
>>> a specific device during a balance? Something like -ddestdevid=N?
>>> This would just be a hint to the allocator and the usual constraints
>>> would always apply (and prevail over the hint when needed).
>>
>> No, there isn't. Having control over the allocator (or bypassing
>> it) would be pretty difficult to implement, I think.
>>
>> It would be really great if there was an ioctl that allowed you to
>> say things like "take the chunks of this block group and put them on
>> devices 2, 4 and 5 in RAID-5", because you could do a load of
>> optimisation with reshaping the FS in userspace with that. But I
>> suspect it's a long way down the list of things to do.
>
> It really sounds like "btrfs replace -ddrange=x..y". Replace already
> knows how to move chunks from one device and put it on another. Now it
> "just" needs to skip "replace" part and ignore chunks not covered by
> filter ...

Yes having btrfs balance able to "empty" a device as replace does, without 
actually removing the device from the array would be nice.

There's a way to mimic that: running a btrfs device remove, and rebooting 
when it's almost done. The operation itself is not cancellable, but btrfs 
forgets about the pending remove after the reboot, and the device ils still 
part of the FS. It's ugly of course, and not really advisable, but it works.

However what I would need here seems a bit different: I need block groups 
moved from any device(s) (I don't care which), to one specific device.
I don't think anything like that exists (even counting hacky ways).

-- 
Stéphane.






