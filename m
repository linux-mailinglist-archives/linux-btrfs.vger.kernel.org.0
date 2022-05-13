Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCC5526D38
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 May 2022 00:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357020AbiEMW6Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 May 2022 18:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384916AbiEMW6W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 May 2022 18:58:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1426A5DD3F
        for <linux-btrfs@vger.kernel.org>; Fri, 13 May 2022 15:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652482696;
        bh=JgRkruD9tY5hM++EUGtf4pxfQs5vUXIt9GUI6mi88SU=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=YFryi+aPj5WI8YBLBNuNT/mdZxxsMqzA/VBo17Kn6Z6KC3B+jWdUlL6KMpjw9wq8B
         4D7FJIM302J9Ae3jyAsBP8tlDTFCJBuZPgETao5oVE0YByZy1sX26pHC4ksERl8NSP
         DkRDR+Xl+lCq1uxxx/TCi8XBVpmIGMoJYp3BVnOo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mn2WF-1oEVCi05El-00k9Ag; Sat, 14
 May 2022 00:58:15 +0200
Message-ID: <aa64c204-2ae7-3a85-73c6-bb5f14b9a3c0@gmx.com>
Date:   Sat, 14 May 2022 06:58:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Forza <forza@tnonline.net>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1652428644.git.wqu@suse.com>
 <b49e00b.dcea448a.180bdfc2a51@tnonline.net>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 0/4] btrfs: cleanups and preparation for the incoming
 RAID56J features
In-Reply-To: <b49e00b.dcea448a.180bdfc2a51@tnonline.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yZYOdOYHyzzcewNh5N1XKIublXogY+V8R5PJiznIADIVLmmFwwH
 27jfze5+KahZFdkJukpzvXmqSF4dJ2BgokcmCZL5hytR6xu4fz9b9uVzwfpcy4cJRfsszzg
 s05AETWepHcdL/PSKHY34YbosABsVrCpjiJzmG25MiZFr2GNYb+MCrCiqQ6tOihyriyOivp
 0D0hbIecko4WWtz4jIryA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iMDBs5c8kNQ=:r0bb7hd+9sdn9xiGGrqg28
 pix4dFp5RAWVB7cffA7noBmsFj4KwyAFxEHtxeE7W7bH3JugBHuihGBh26QNUDvzWdolip6u3
 loV2dDntxrVWgVpo/izE6mt06MybLYY9x+GsVcRwzyBU+OeeQbalMsYvdLz/1BjHFEFL1RZCW
 ZOTOMtpwa37Bu8GWtu6VHv7gG5W3E3uJpz66Yg+KyGKuTHcfS4IFQIfZAHtg/FarFDQAhb2qo
 mCPrVMUKbjt1/BAMRL5eh3Mr3vWrpZdTIkp8JNiU966ISU5BClb0L3Rr0mxKG7sqYhWBd+8w9
 E49ix7MzLKM/y1NZy7IYR7iLcgSvJKBiPw16ravzZS/q1yc0c4aYdQuGGIvDxmFGbuEKL2mkv
 iRcEO2fY1E5mPv2CCAqQbeuaAJTmEhfxiXckTk6/JPhFIyljuzVoTE0dLePNkMJiXwQOZ4swt
 iqB6IxsmhY77dh5A2PZM98TbTIaAwtT37w9saPqYL/Fq/mShEnL+T1SptQqsYe1BYsnQHcrec
 Xj3u533iIhdVry8/WBsT7RSFESEbMzKSoB3fh9QP9wyu7jVfvOMaufJFKk+sMDGZfPvnw+8aL
 ZTBPnhuMYo+tE5dQZLOf1drkKvHki/KKi+ISTsWGrotRO8YMKZP8IVnSG/ddyeuoEG82CtU99
 4bvcigLvFk0uNIe6e36HSDtvpIV3FHsDuPIpGOoQw3n1O40pqFW8+ul0bfGZYVGYC1uIqQP/m
 7WhXpPLk7ENYbETzS9ooP3l+CqtOMhX20eGQRWq2wz+3Us5yefHYHuD/oVvSjHUxsqevw9QkZ
 IwusyLNxlgx+CGo5VA8TcXzFIDlMBIr4JqBnEhCcQrg12/HrLZ0aRfC0EVdsAlfDPttfREKyZ
 6B3jh33cSnwlAK5Vo4QPXZiZbjsOWfnTQkqKg0U4KQlrfqTTU+xTkXRoUoFdg1Z20Blw18GoM
 4ZdnWsk2g6DrrHcOri1S77lYFLF1M254m1TZ/J8cG7PU3MgOnK8CyiU2JNyx51Lr1JRZ12c47
 hkpq4S3YcEY7jCdZ1PvNCMuFwbMsGcNAFIrD6Cqc9zOlJscS09jZeR3tqIpjmyI70q6vnHol+
 Zr6zS/4FdAglzM=
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/13 23:14, Forza wrote:
> Hi,
>
> ---- From: Qu Wenruo <wqu@suse.com> -- Sent: 2022-05-13 - 10:34 ----
>
>> Since I'm going to introduce two new chunk profiles, RAID5J and RAID6J
>> (J for journal),
>
> Great to see work being done on the RAID56 parts of Btrfs. :)
>
> I am just a user of btrfs and don't have the full understanding of the i=
nternals, but it makes me a little curious that we choose to use journals =
and RMW instead of a CoW solution to solve the write hole.

In fact, Johannes from WDC is already working on a pure CoW based
solution, called stripe tree.

The idea there is to introduce a new layer of mapping.

With that stripe tree, inside one chunk, the logical bytenr is no longer
directly mapped to a physical location, but can be dynamically mapped to
any physical location inside the chunk range.

So previously if we have a RAID56 chunk with 3 disks looks like this:

     Logical bytenr X		X + 64K		X + 128K
		   |            |		|

Then we have the following on-disk mapping:

   [X, X + 64K):		Devid 1		Physical Y1
   [X + 64K, X + 128K)	Devid 2		Physical Y2
   Parity for above	Devid 3		Physical Y3

So if we just write 64K into logical bytenr X, we need to read out data
at logical bytenr [X + 64K, X + 128K), then calculate the parity, write
into devid3 physical offset Y3.

But with the new stripe tree, we can map [X, X + 64K) into any location
in the devid 1.
So is [X + 64K, X + 128K) and the parity.

Then we we write data into logical bytenr [X, X + 64K), then we just
find a free 64K range in stripe tree of devid 1, and check if we have
mapped [X + 64K, X + 128) in the stripe tree.

a) Mapped

If we have [X + 64K, X + 128) mapped, then we read that range out,
update our parity stripe, and write the parity stripe into some newer
location (CoW), then free up the old stripe.

b) Not mapped

This means we don't have any data write into that range, thus it is all
zero. We calculate parity with all zero, then find a new location for
parity in devid 3, write the newly calculated parity and insert a
mapping for the new parity location.


By this, we in fact decouple the 1:1 mapping for RAID56, and get way
more flexibility.
Although this idea no longer follows the strict rotation of RAID5, thus
it's a middle ground between RAID4 and RAID5.


The brilliant idea is introduced mostly to support different chunk
profiles for zoned devices, but Johannes is working on enabling this for
non-zoned devices too.



Then you may ask why I'm still pushing this way more traditional RAID56J
solution, the reasons are:

- Complexity
   The stripe tree is flexible, thus more complex.
   And AFAIK it will affect all chunk types, not only RAID56.
   Thus it can be more challenging.

- Currently relies on zoned unit to split extents/stripes
   Thus I believe Johannes can solve it without any problems.

- I just want a valid way to steal code from dm/md guys :)

Don't get me wrong, I totally believe stripe tree can be the silver
bullet, but it doesn't prevent us to explore some different (and more
traditional) ways.

>
>
> Since we need on-disk changes to implement it, could it not be better to=
 rethink the raid56 modes and implement a solution with full CoW, such as =
variable stripe extents etc? It is likely much more work, but could have b=
etter performance because it avoids double writes and RMW cycles too.

Well, the journal will have optimizations, e.g. full stripe doesn't need
to journal its data.

I'll learn (steal code) from dm/md to implement the code.


But there are problems related in RAID56, affecting dm/md raid56 too.

Like bitrot in one data stripe, while we're writing data into the other
data stripe.
Then RWM will read out the bad data stripe, calculate parity, and cause
the bit rot permanent.

The destructive RMW will not be detected in traditional raid56 with
traditional fs, but can be detected by btrfs.

Thus after the RAID56J project, I'll take more time on that destructive
RMW problem.

Thanks,
Qu

>
> Thanks
>
> Forza
>
