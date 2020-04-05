Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1300C19ED7B
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Apr 2020 21:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgDETDy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Apr 2020 15:03:54 -0400
Received: from smtp-35.italiaonline.it ([213.209.10.35]:58990 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726771AbgDETDy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 5 Apr 2020 15:03:54 -0400
Received: from venice.bhome ([94.37.173.46])
        by smtp-35.iol.local with ESMTPA
        id LAYhjBGUyMAUpLAYhjSvPf; Sun, 05 Apr 2020 21:03:51 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1586113431; bh=yjNMTuYppbiM/wLxxbeXdynaHR1TruiA63JKBR+jZLk=;
        h=From;
        b=DbLu0pb6jg1+Apj3YDgAY90tHsArDLA4fiXXIMnWQPVyVYoIaI5XZoAHFHkGk2Co4
         wFXNKn3DZ9n2LavV3MLNtBJDI/caAEGvNq8WsOW8GOVEWqY11f2KjNNvU7zX8+A9bG
         nfKWu3iL9PUQAzpq9fI/VJvdEmBV7S10naym0tfCFTfjiHbGB4vM49ZzUxGDArhwIT
         m13sg7QFBzLjzW9f5S7eDUDL8TU6ExwYVhx7jy299MamvdWieL/uwDzYc+tchz/L3g
         wNOBWOyI5XLnJFe1iMfJLsbm3f4faYx6+F/Wr3XpmhEsgTvM89+Vma2pgnS4txRgDb
         Ten7oS9UaJZBQ==
X-CNFS-Analysis: v=2.3 cv=B/fHL9lM c=1 sm=1 tr=0
 a=TpQr5eyM7/bznjVQAbUtjA==:117 a=TpQr5eyM7/bznjVQAbUtjA==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=FskqfF2Wfg00SfiktckA:9
 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: [RFC][PATCH v2] btrfs: ssd_metadata: storing metadata on SSD
To:     Achim Gratz <Stromeko@nexgo.de>, linux-btrfs@vger.kernel.org
References: <20200405071943.6902-1-kreijack@libero.it>
 <87o8s6bavr.fsf@Rainer.invalid>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <c5aaf7df-f5a7-d319-976f-ee203a6f4d9b@libero.it>
Date:   Sun, 5 Apr 2020 21:03:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87o8s6bavr.fsf@Rainer.invalid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfI+Fslg+h4cwfCbxvULgFa8L3vz6FkAkKu5bDoxNV2ikcNNQfckkaCQRV+9NCwBRKFkZQ9DbFBzC8JvTluRiUfycJVTrEUh45cObDjgcV0TkrGhllHgC
 J992xIsDcaiqluuuoH7gSHMp4QKSYEr+5hqFNIjtXEnCMcK6wVj4uGrX+NghlzNn9x2ENP2gAMrOrsfbu93/Nrw/MCTW6swjFYc=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/5/20 10:22 AM, Achim Gratz wrote:
> Goffredo Baroncelli writes:
>> This is an RFC; I wrote this patch because I find the idea interesting
>> even though it adds more complication to the chunk allocator.
>>
>> The core idea is to store the metadata on the ssd and to leave the data
>> on the rotational disks. BTRFS looks at the rotational flags to
>> understand the kind of disks.
> 
> My comment really is only about his aspect of your proposal: I would
> consider a more general way of introducing a tiering of disks so that
> one can discern between slower and faster SSD as well.

This is a further step. I didn't mind to a tiering of fast (NVM ?) and slow
SSD. For that there are some unused fields in the superblock
which can be used.

However now my first concern is if this is
a) really useful
b) I introduced some functional regression

Regarding a), there is an increment of performance; however stacking
btrfs over bcache leads to an even bigger gain; of course stacking
btrfs over bcache complicates the configuration for the raid setup

Regarding b) the only regression that I found is that the logic
behind the allocation of disks in RAID5/RAID6 became more
complex. But I am not sure if this can be called regression.


> 
> 
> Regards,
> Achim.
> 

BR
G.Baroncelli

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
