Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 835DD2C704
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2019 14:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfE1Mvt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 May 2019 08:51:49 -0400
Received: from icts.hu ([195.70.57.6]:50672 "EHLO icts.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726867AbfE1Mvt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 May 2019 08:51:49 -0400
Received: from [192.168.6.104] (80-95-82-11.pool.digikabel.hu [80.95.82.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by icts.hu (Postfix) with ESMTPSA id 92FC7269F5FD
        for <linux-btrfs@vger.kernel.org>; Tue, 28 May 2019 14:51:45 +0200 (CEST)
Subject: Re: parent transid verify failed on 604602368 wanted 840641 found
 840639
Cc:     linux-btrfs@vger.kernel.org
References: <5406386.pfifcJONdE@monk>
 <2a6df734-4c39-2f8a-7d8f-c627c2c15f76@dblaci.hu> <5695711.43npD3TUoY@monk>
From:   =?UTF-8?B?U3phbG1hIEzDoXN6bMOz?= <dblaci@dblaci.hu>
Message-ID: <37c76891-028d-8fce-8f80-ac08d7853ade@dblaci.hu>
Date:   Tue, 28 May 2019 14:51:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5695711.43npD3TUoY@monk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear Dennis,

Without the bcache cache device, I was able to mount the file system ( 
root ) for read-only. I recreated it on the same LVM volume, and 
rsync-ed the files. The files I lost (i/o error because checksum error) 
was not important. Your case might be different. But without the cache, 
additional corruption stopped happening, so I think it is safe to 
recover your files with the gcc9 + 5.1 kernel (on bcache0) - if cache 
device is not present. If you cannot mount the fs, you can try the 
standard btrfs recovery methods (mount read only) or btrfsck (please be 
aware you can make things worse with btrfsck, so if the data is 
important backup the device as byte stream for new chance)

I want to mention I had another corruption (btrfs checksum error), but 
it was simply not there after reboot without bcacha cache device. This 
means the corruption that time was not written back to the backing 
device, so I haven't lost data that time. I think I was lucky.

László Szalma

2019. 05. 28. 14:36 keltezéssel, Dennis Schridde írta:
> Dear Szalma!
>
> Thank you for the information.
>
> On Dienstag, 28. Mai 2019 08:40:40 CEST Szalma László wrote:
>> I experienced the same, the problem is with bcache + gcc9. Immediately
>> remove the cache device from the bcache, as it prevents more damages to
>> your filesystem. After it downgrade gcc to 8 or avoid using bcache (with
>> cache device) until the problem is solved by upstream.
>>
>> Please see here for more information:
>> https://bugzilla.kernel.org/show_bug.cgi?id=203573
>>
>> This is a very serious issue I think, but in my case I could save all my
>> files after reboot without bcache cache device (except 1 insignificant
>> one), but I guess you might need backups (I hope you have).
> I did the following so far:
>
> readlink /sys/fs/bcache/*/cache0/set | sed 's,.*/,,' > /sys/block/bcache0/
> bcache/detach
>
> How should I proceed from here on the path that you took to recover your
> system?
>
> --Dennis


