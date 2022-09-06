Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6EF5AE1D1
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Sep 2022 10:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbiIFICa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Sep 2022 04:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbiIFIC3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Sep 2022 04:02:29 -0400
Received: from sender4-pp-o92.zoho.com (sender4-pp-o92.zoho.com [136.143.188.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6327345982
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Sep 2022 01:02:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1662451345; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=j9Rv7Nq1fejjW6dUlsmP172G0Pys8mqeSJoqYNUSFxJxs6vYpp7Fng89d/IMb2N4dst+UorqBQdjatvRv/GSvG6CPllfWTDBhO0bexHZF5e+2eC6F1MXLFFLa83n1+OPtTEtpyDbWwoNWmLgNvPX4kCIq/XtWrkhskGWpSIJ+aw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1662451345; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=QZTXMrRj6f03L2fQuCCa+/eW9h6xkga/Ez2+CmckjRo=; 
        b=Y/jrk4NYlmuFqiln0nyDd1+ZhBCmAGqxXT02jx1OqUtor0ENlKr0E0hFtJyEkoPc5L3C7ckN3h5u041QwM8xFU2+uY/LwV7MvdHlQHu4OlEb9vIxvNd9OcoJVA+75cHobwIZpR3LzLFz+UGlvjHBAo7YFRHTKq/a1jL271hawxA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=hmsjwzb@zoho.com;
        dmarc=pass header.from=<hmsjwzb@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=message-id:date:mime-version:user-agent:subject:to:references:from:in-reply-to:content-type; 
  b=AGVrBgtcoOC2XcKGJKoE1mDb92tA/KVMAZN1x5sXrZaqb1X9JgYFs8y45X/p6EIxx90eUukjmnGK
    h2ReEv1GVhbSp214rKmguQUpGn35kqmBoSB+3RQjSrurOcV+TBC6  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1662451345;
        s=zm2022; d=zoho.com; i=hmsjwzb@zoho.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
        bh=QZTXMrRj6f03L2fQuCCa+/eW9h6xkga/Ez2+CmckjRo=;
        b=cWt6OSJxfwdlTzsY7el/rrem37IPfNpmv/U1YNEXWrmcXDonTgHBqFaE2glE3zqk
        s0QieQLJamuShJ6nFuNLQ+LVeQDrlBj1UWQ3hAQmt85Q6u+oXcY5WLW98oMNkgHTu1r
        P2j0jvlA1z0ng6+Xb8EN3pw+QX8It26oJ+kPHrCM=
Received: from [192.168.0.103] (58.247.201.9 [58.247.201.9]) by mx.zohomail.com
        with SMTPS id 1662451344704566.3781802610697; Tue, 6 Sep 2022 01:02:24 -0700 (PDT)
Message-ID: <9c295a8c-5167-116e-4fae-d548f1deb3b2@zoho.com>
Date:   Tue, 6 Sep 2022 04:02:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: some help for improvement in btrfs
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <fb056073-5bd6-6143-9699-4a5af1bd496d@zoho.com>
 <655f97cc-64e6-9f57-5394-58f9c3b83a6f@gmx.com>
 <40b209eb-9048-da0c-e776-5e143ab38571@zoho.com>
 <72a78cc0-4524-47e7-803c-7d094b8713ee@gmx.com>
 <00984321-3006-764d-c29e-1304f89652ae@zoho.com>
 <18300547-1811-e9da-252e-f9476dca078c@gmx.com>
 <4691b710-3d71-bd26-d00a-66cc398f57c5@zoho.com>
 <7553372e-1485-63ae-d3f1-e9e0a318b2f6@gmx.com>
From:   hmsjwzb <hmsjwzb@zoho.com>
In-Reply-To: <7553372e-1485-63ae-d3f1-e9e0a318b2f6@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

Thank you for providing this interesting case. I use qemu and gdb to debug this case and summarize as follows.

[test case]

mkfs.btrfs -f -m raid5 -d raid5 -b 1G /dev/vda /dev/vdb /dev/vdc

mount /dev/vda /mnt

xfs_io -f -c "pwrite -S 0xee 0 64k" /mnt/file1

sync

	After the above command, the device look like this.
           	119865344
	vda |     |     stripe 0:Data for file1            |      |
           	98893824
	vdb |     |     stripe 1:redundant Data for parity |      |
           	98893824
	vdc |     |     stripe 2:parity                    |      |

	We can see that stripe 1 is not used by btrfs filesystem.

umount /dev/vda

xfs_io -f -c "pwrite -S 0xff 119865344 64k" /dev/vda

           	119865344
	vda |     |     stripe 0:Data for file1(Corrupted) |      |
           	98893824
	vdb |     |     stripe 1:redundant Data for parity |      |
           	98893824
	vdc |     |     stripe 2:parity                    |      |

	This command erase the data for file1 in stripe 0. I think it simulate the 
	data loss in hardware.

mount /dev/vda /mnt

	If we issue a read request for file1 now, the data for file1 can be recovered
	by raid5 mechanism.

xfs_io -f -c "pwrite -S 0xee 0 64k" -c sync /mnt/file2

           	119865344
	vda |     |     stripe 0:Data for file1(Corrupted)               |      |
           	98893824
	vdb |     |     stripe 1:Data for file2                          |      |
           	98893824
	vdc |     |     stripe 2:parity(Recomputed with Corrupted data)  |      |

	After the above command, the stripe 1 in vdb is used for file2. The parity data
	is recomputed with corrupted data in vda and data of file2. So the Data for file1
	is forever lost.

cat /mnt/file1 > /dev/null
	
	This command will read the corrupted data in stripe 0. And the btrfs csum will find
	out the csum mismatch and print warnings.

umount /mnt

[some fix proposal]

	1. Can we do parity check before every write operation? If the parity check fails,
           we just recover the data first and then do the write operation. We can do this
	   check before raid56_rmw_stripe.

[question]
	I have noticed this patch.

		[PATCH PoC 0/9] btrfs: scrub: introduce a new family of ioctl, scrub_fs
		Hi Qu,
			Is some part of this patch aim to solve this problem?

Thanks,
Flint


On 8/16/22 01:38, Qu Wenruo wrote:
> 
> 
> On 2022/8/16 10:47, hmsjwzb wrote:
>> Hi Qu,
>>
>> Sorry for interrupt you so many times.
>>
>> As for
>>     scrub level checks at RAID56 substripe write time.
>>
>> Is this feature available in latest linux-next branch?
> 
> Nope, no one is working on that, thus no patches at all.
> 
>> Or may I need to get patches from mail list.
>> What is the core function of this feature ?
> 
> The following small script would explain it pretty well:
> 
>   mkfs.btrfs -f -m raid5 -d raid5 -b 1G $dev1 $dev2 $dev3
>   mount $dev1 $mnt
> 
>   xfs_io -f -c "pwrite -S 0xee 0 64K" $mnt/file1
>   sync
>   umount $mnt
> 
>   # Currupt data stripe 1 of full stripe of above 64K write
>   xfs_io -f -c "pwrite -S 0xff 119865344 64K" $dev1
> 
>   mount $dev1 $mnt
> 
>   # Do a new write into data stripe 2,
>   # We will trigger a RMW, which will use on-disk (corrupted) data to
>   # generate new P/Q.
>   xfs_io -f -c "pwrite -S 0xee 0 64K" -c sync $mnt/file2
> 
>   # Now we can no longer read file1, as its data is corrupted, and
>   # above write generated new P/Q using corrupted data stripe 1,
>   # preventing us to recover the data stripe 1.
>   cat $mnt/file1 > /dev/null
>   umount $mnt
> 
> Above script is the best way to demonstrate the "destructive RMW".
> Although this is not btrfs specific (other RAID56 is also affected),
> it's definitely a real problem.
> 
> There are several different directions to solve it:
> 
> - A way to add CSUM for P/Q stripes
>   In theory this should be the easiest way implementation wise.
>   We can easily know if a P/Q stripe is correct, then before doing
>   RMW, we verify the result of P/Q.
>   If the result doesn't match, we know some data stripe(s) are
>   corrupted, then rebuild the data first before write.
> 
>   Unfortunately, this needs a on-disk format.
> 
> - Full stripe verification before writes
>   This means, before we submit sub-stripe writes, we use some scrub like
>   method to verify all data stripes first.
>   Then we can do recovery if needed, then do writes.
> 
>   Unfortunately, scrub-like checks has quite some limitations.
>   Regular scrub only works on RO block groups, thus extent tree and csum
>   tree are consistent.
>   But for RAID56 writes, we have no such luxury, I'm not 100% sure if
>   this can even pass stress tests.
> 
> Thanks,
> Qu
> 
>>
>> I think I may use qemu and gdb to get basic understanding about this feature.
>>
>> Thanks,
>> Flint
>>
>> On 8/15/22 04:54, Qu Wenruo wrote:
>>> scrub level checks at RAID56 substripe write time.
