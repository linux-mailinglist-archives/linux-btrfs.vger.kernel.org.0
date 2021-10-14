Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0634B42DA43
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Oct 2021 15:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhJNN1p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Oct 2021 09:27:45 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40970 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhJNN1o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Oct 2021 09:27:44 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 162311FD33;
        Thu, 14 Oct 2021 13:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634217939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YZei0wSKhtRb1Ws60Wny2AGsS58jyeMkUPChzTarB7U=;
        b=HRwFlOx/7mihpCYPUaXmMCqjkRkuTfnsPXsefSJ2kyWu7BGbBIaWnUFYOkpVQRxDHROSJT
        Zmuwdn/Hfwyk5fOmlEQHc/K2N2EPJDaBuBFU9ujbPYeJwsNct8fV88dldLZfbr6qEl7hih
        E7waPpT8pMoFLsI3N+dg2LoU3QrKNWE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E466313D8A;
        Thu, 14 Oct 2021 13:25:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5etFNdIvaGFpWgAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 14 Oct 2021 13:25:38 +0000
Subject: Re: some principal understanding problems (balance and free space)
To:     "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>,
        Btrfs ML <linux-btrfs@vger.kernel.org>
References: <1920407503.58357312.1634216278641.JavaMail.zimbra@helmholtz-muenchen.de>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <79a27c00-5475-12e0-8227-7eb9aa3b080e@suse.com>
Date:   Thu, 14 Oct 2021 16:25:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1920407503.58357312.1634216278641.JavaMail.zimbra@helmholtz-muenchen.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 14.10.21 г. 15:57, Lentes, Bernd wrote:
> Hi,
> 
> OMG. Why is BTRFS in some cases so complicated? I just expect that a FS does its job, nothing else.
> I read the wiki and Merlin's Blog, but the more i read the more i get confused.
> Please help me, i'd like to use BTRFS, especially because of the snapshot feature which i'm missing in the most others FS.
> And i like to understand what i do.
> 
> Let's take this:
> 
> root@pc65472:~# btrfs fi df /
> Data, single: total=361.00GiB, used=343.29GiB
> System, single: total=32.00MiB, used=80.00KiB
> Metadata, single: total=9.00GiB, used=7.10GiB
> root@pc65472:~#
> root@pc65472:~# btrfs fi show /
> Label: none  uuid: 3a623645-a5e1-438e-b0f3-f02520f1a2eb
>         Total devices 1 FS bytes used 350.39GiB
>         devid    1 size 420.00GiB used 372.03GiB path /dev/mapper/vg1-lv_root

In order to understand those numbers and interpret them correctly you
need to understand how btrfs manages its memory. Essentially we take a
linear device (or multiple devices, but for this example it will be
linear) and we split them in Metadata/Data chunks (this is what the
Metadata/Data mean above). I will ignore system as it's not important.


Respectively metadata/data writes would go to the respective space. For
example say you want to write 4megabytes if there are no free data
groups i.e total == used in the "DATA" line we'd allocate a data block
group with a size of 1gb, so now total would be 1g larger than Used, and
we'll be able to write our 4 megabytes. Now what happens in this case is
that we've allocated 1 gigabyte for data and only used 4 megabytes of
it, in this case you might argue we are wasting the rest of the 996
megabytes. However, if you want to write further data you'd be able to
do so within those 996megabytes, after they are exhausted btrfs will go
and fetch another chunk of 1 gigabytes. This works the same way for
metadata.


So based on the numbers above you have a device whose actual physical
size is 420 gigabytes, of it 372 are allocated i.e split among
data/metadata groups, but only 350 giigabytes of those 372 which are
allocated are used. Looking further we can see that you have 9gb of
metadata allocated and only 7.1g of this is used. BY the same logic you
have 361g of data allocated, but only 343 used.

And you have close to 40g of "unallocated" space i.e one which is not
dedicated to either data or metadata. So that's a healthy filesystem state.

The reason why you'd want to run balance is if you have some
pathological workload which creates a lot of blockgroups of either type
(Data/Metadata) but which are sparsely populated. For example you write
a bunch of files which cause the FS to allocate 100g (i.e 100
blockgroups) for data, then you free 95% of every block group. The end
result would be you will have 100 blockgroup but only 5 of each is going
to be populated, the rest of the space is going to be "wasted" because
it is dedicated for data but you are not using it AT THE MOMENT, this
doesn't mean you won't use it in the future. This situation can become
problematic if you run out of unallocated space and your workload
requires you to allocated a metadata chunk, in this case the filesystem
might give you an ENOSPC error because it will see that there is no
unallocated space but in reality you could squash those 100, very
lightly used blockgroup into 1 or 2 almost full block group which would
render the rest of the space "unallocated", meaning it can be used for
either data/metadata.

Does that answer your question?


> 
> What does "Data, single: total=361.00GiB, used=343.29GiB" mean ?
> Having 343GB pure data occupying 361GB ?
> From what i've read before my understanding was that 361GB are reversed for data allocation ("data will be stored there").
> And 343GB are really used for data, so 18Gb pure data can still be saved. Is that correct ?
> What if i save now 18GB, so the total and used value are equal ? Does BTRFS claim new space so that the total value is growing ?
> 
> Or are the 18GB lost and unusable ?
> 
> I read that if Metadata is occupying more than 75% of the total value you need to react.
> I did some "btrfs balance start / -dusage=5", increasing the value of dusage in steps of 5.
> I expected that i get more total space or less used space for Metadata. But it didn't.
> What happened is that the total value for Data shrinked a bit, from 363GB to 361GB.
> 
> I did then some "btrfs balance start / -musage=5" increasing in steps of 5. I expected that "used" for Metadata decreased, but it didn't.
> Finally the value "total" for Metadata decreased (from 9GB to 8GB), which isn't completely contrary to what i've expected:
> 
> root@pc65472:~# btrfs fi df /
> Data, single: total=361.00GiB, used=343.46GiB
> System, single: total=32.00MiB, used=80.00KiB
> Metadata, single: total=8.00GiB, used=7.10GiB
> GlobalReserve, single: total=512.00MiB, used=0.00B
> 
> That would mean that after my "btrfs balance ... musage= " there is now less space for Metadata than before. Why to balance then ?
> 
> OS is Ubuntu 16.04, kernel is 4.4.0-66-generic.
> 
> What is with the most recent kernels ? Is there an automatic "btrfs balance" or do i still have to check my BTRFS regulary ?
> 
> Thanks for helping me to sort that out.
> 
> Bernd
> 
> 
