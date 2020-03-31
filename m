Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF61C199FC4
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Mar 2020 22:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgCaUIH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Mar 2020 16:08:07 -0400
Received: from smtp-35.italiaonline.it ([213.209.10.35]:36604 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726411AbgCaUIH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Mar 2020 16:08:07 -0400
Received: from venice.bhome ([94.37.173.46])
        by smtp-35.iol.local with ESMTPA
        id JNB4jU0XBMAUpJNB5j08sE; Tue, 31 Mar 2020 22:08:04 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1585685284; bh=8axCsWiGM5a+2Lshw2gL6eTnAb6K0IR9jZ2UXGKVW6E=;
        h=From;
        b=DeQi3wjKwRz3cuTCSx9ftW+vJ77vVkbn7fkYKvtsTdNXUgJ/L3K65zaL8LbrYbUoA
         3L8Maa65Gc40E2gZ00ZiygG/uJmRdb6UgeU8061p7hEBSzPfM5mIygT93BGT39zY1b
         y0jTiApszhP3UqLVEGf9SZlGxfqaObxylqVhPRNJoV7kVGAlB4G29TynP9gh4KHsSg
         cz5bvZUlntu+c9fJ3mWXfr7fld+e5jnGcy8B6CfKnf0S5vE2uuumgGyZenp8RNmUSY
         nF7eZRzBre9KyNKdzBmFcm6KqY6pwbwNaBWOHIyvZZgdg8mm9DRzsbJPTpgeqMeQes
         mku4B3IGInlpA==
X-CNFS-Analysis: v=2.3 cv=B/fHL9lM c=1 sm=1 tr=0
 a=TpQr5eyM7/bznjVQAbUtjA==:117 a=TpQr5eyM7/bznjVQAbUtjA==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=JwdY5pGUldPTrAkirgwA:9
 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: Using Intel Optane to accelerate a BTRFS array? (equivalent of
 ZLOG/SIL for ZFS?)
To:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Eli V <eliventer@gmail.com>, Paul Jones <paul@pauljones.id.au>
Cc:     Victor Hooi <victorhooi@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAMnnoULAX9Oc+O3gRbVow54H2p_aAENr8daAtyLR_0wi8Tx7xg@mail.gmail.com>
 <a9b73920-65d5-b973-8578-9659717434b5@gmail.com>
 <SYBPR01MB38978D6654705941C50AF95E9ECB0@SYBPR01MB3897.ausprd01.prod.outlook.com>
 <CAJtFHUSjwBKGyjSQfB-aZwsvV=4AcnG+-h5uF_4zmBOESxd=hA@mail.gmail.com>
 <2ff672d4-875b-5242-96d6-1e248e2aa57a@gmail.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <b6f8ec3a-cd58-bbce-fdd6-a5001a92b3b1@libero.it>
Date:   Tue, 31 Mar 2020 22:08:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <2ff672d4-875b-5242-96d6-1e248e2aa57a@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfIvp43ujAYxLcUGnYU7yL4bELhIgtitaBGI9nNS8MPRZUsdLaH+kcwWEound+3ANgdokTQd2MilM5fECry+EQWh+TVwqO/sSOPGJ30euzLLker4kQBpX
 pY3uwocCXG3J9hKHYjpsrHlT9CvnpNSbFeEsmy4b3f675PaQvSqWs3cQf1ivXYloCXVyaF/AlCqXcew4yTR9LGUkAprx8GxyXj6pQy43NXiVjvs0t+OO2jmn
 hf6U7LYSMm+L/RiMfAaWulADQmGZz+mEFdxDGRKaFq56ZuK5+ltNTSGZ3nD8e4AT
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/31/20 7:09 PM, Andrei Borzenkov wrote:
> 31.03.2020 20:01, Eli V пишет:
>>
>> Another option is to put the 12TB drives in an mdadm RAID, and then
>> use the mdadm raid & the ssd for btrfs RAID1 metadata, with SINGLE
>> data on the the array.
> 
> How do you restrict specific device for metadata only?

I never tried, but I don't think that it would be so complicated.

When BTRFS has to allocate a new chunk, it collects all the available
free spaces on the disks; it sorts all these free spaces on the basis of
criterion like the largest contiguous area and how the disk is full
and pick the top one.

It could be sufficient to add another criteria to the sorting algorithm,
something like that
- if the chunk is a metadata one, an SSD has an higher priority
- if the chunk is a data one, an SSD has a lower priority

So the metadata will have an higher likelihood to be on the SSD,
instead the data will have an higher  likelihood to be a NON SSD disk.

Of course this is a soft constraint, when a kind of disk is full, it will
be possible to use the other kind, only with a lower priority.

> 
>> Currently, this will make roughly half of the
>> meta data lookups run at SSD speed, but there is a pending patch to
>> allow all the metadata reads to go to the SSD. This option is, of
>> course, only useful for speeding up metadata operations. It can make
>> large btrfs filesystems feel much more responsive in interactive use
>> however.
>>
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
