Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A603AE810
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jun 2021 13:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhFULXP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Jun 2021 07:23:15 -0400
Received: from rootvole.net ([148.251.41.247]:34960 "EHLO rootvole.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229487AbhFULXO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Jun 2021 07:23:14 -0400
X-Greylist: delayed 2347 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Jun 2021 07:23:14 EDT
Received: from [192.168.178.33] (HSI-KBW-46-223-130-48.hsi.kabel-badenwuerttemberg.de [46.223.130.48])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by rootvole.net (Postfix) with ESMTPSA id 71E64CC332B;
        Mon, 21 Jun 2021 13:20:59 +0200 (CEST)
Subject: Re: Recovering from filesystem errors?
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <a2d39735-b54d-a11f-cee3-92f72e3f00b9@fsync.org>
 <8c91a6dd-e94f-1214-df5a-9fcaad57d042@gmx.com>
From:   Volker <volker@fsync.org>
Message-ID: <732e712b-2443-442b-e4b1-dafbcf0000cf@fsync.org>
Date:   Mon, 21 Jun 2021 13:20:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <8c91a6dd-e94f-1214-df5a-9fcaad57d042@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

thanks a lot for the hint and the quick response! It's a rather old 
kernel from current Debian stable (4.19.0), so many new btrfs 
improvements are not in yet. I'll check about the memory problem and if 
there are other problems. As for the data on disk, that seems to be a 
case for replaying data copies or backups then - luckily no problem in 
this case.

Best wishes,
Volker


On 2021-06-21 13:00, Qu Wenruo wrote:
>
>
> On 2021/6/21 下午6:41, Volker wrote:
>> Hi,
>>
>> I've been running btrfs for a number of years now on a Debian server
>> without problems, but now got into trouble. The filesystem automatically
>> switched to read-only due to errors and that's how I noticed. I could
>> actually find in the logs of the regularly running scrub that there were
>> errors but, shame on me, I didn't notice these log messages before now.
>> Now I'm trying to fix the errors, but didn't succeed so far.
>>
>> After finding the disk read-only, I could remount the disk with "-o
>> recovery" and subsequent mounts were successful. However, a new run of
>> scrub found errors, as did "btrfs check /dev/sda4":
>>
>> - errors found in extent allocation tree or chunk allocation
>>
>> - errors 2000, link count wrong
>>          unresolved ref dir ...
>>
>> - errors 2001, no inode item, link count wrong
>>          unresolved ref dir ...
>>
>
> [...]
>> [ 1758.383764] BTRFS critical (device sda4): corrupt node: root=7
>> block=644705402880 slot=247, bad key order, current
>> (18446744073709551606 128 9223372547127476224) next
>> (18446744073709551606 128 510283886592)
>
> This is an obvious memory bitflip:
> hex(9223372547127476224) = 0x80000076ce9f8000
> hex(510283886592)     = 0x00000076cf4a3000
>
> See the high 0x8 bit flip?
>
> So it looks like your memory has some problem.
>
> Any idea what's your kernel version?
> For newer kernel we should have write-time tree-check, which should
> prevent this, although by an anonying trans abort.
> But at least there should be no corrupted data.
>
> I don't have any good idea to recovery though, as the corrupted data has
> already reached disk, and I don't believe it's the only memory 
> corruption...
>
> Thanks,
> Qu
>
