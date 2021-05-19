Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1DEB388A52
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 May 2021 11:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344334AbhESJS1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 May 2021 05:18:27 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:46557 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343716AbhESJS0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 May 2021 05:18:26 -0400
Received: (Authenticated sender: swami@petaramesh.org)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 81560100008;
        Wed, 19 May 2021 09:17:05 +0000 (UTC)
Subject: Re: System freeze with BTRFS corruption on 4 systems with kernel 5.12
 (MANJARO)
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <a924147d-1403-369b-85d5-a5ba5be662d8@petaramesh.org>
 <31eea3fb-926e-ce69-95bc-5ade744100d3@gmx.com>
From:   =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>
Message-ID: <d88d8d90-9218-dd51-a47e-7b7c507eb583@petaramesh.org>
Date:   Wed, 19 May 2021 11:17:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <31eea3fb-926e-ce69-95bc-5ade744100d3@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/19/21 9:25 AM, Qu Wenruo wrote:
>
>> Kernel affected : Linux 5.12.1-2-MANJARO
>> (Not sure if I tried Manjaro Linux 5.12.1-1-MANJARO)
>>
>> Kernel not affected : All previous versions up to 5.11.18-1-MANJARO
>>
>> Symptoms : Under heavy disk usage (such as performing a system backup
>> onto external USB HD) the machine soon completely freezes and only a
>> hard power cycle can get it out of it.
>
> Any dying message?
>
No, just a sudden and complete system and disks freeze. Thus no 
messages, nothing logged.

>>
>> After reboot, systems on which BTRFS is built over bcache may show heavy
>> filesystem corruption.
>
> Which kind of corruption? Just data csum mismatch?

AFAIR it was some kind of “generation mismatch”, expected something, 
found another, in very large quantities.

The machine with BTRFS RAID-1 could heal itself out of this by running a 
simple btrfs scrub, I gave up on the non-RAID one my previous experience 
with similar errors making me think the FS was beyond repair, I 
reformatted and restored from backups.

> Does `btrfs check` reports other problems?

I didn't try.

Thanks for the quick help :)

ॐ

-- 
Swâmi Petaramesh <swami@petaramesh.org> PGP 9076E32E

