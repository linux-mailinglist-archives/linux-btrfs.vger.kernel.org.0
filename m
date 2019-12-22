Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5C0128D56
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Dec 2019 11:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfLVKQC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Dec 2019 05:16:02 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:43307 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfLVKQC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Dec 2019 05:16:02 -0500
Received: from [192.168.1.168] (unknown [88.191.131.7])
        (Authenticated sender: swami@petaramesh.org)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 12C2E200003;
        Sun, 22 Dec 2019 10:15:59 +0000 (UTC)
Subject: Re: Kernel 5.4 - BTRFS FS shows full with about 600 GB Free ?
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "'linux-btrfs@vger.kernel.org'" <linux-btrfs@vger.kernel.org>
References: <8bd55f28-2176-89f7-bd53-4992ccd53f42@petaramesh.org>
 <81dec38b-ec8e-382e-7dfe-cb331f418ffa@gmx.com>
 <e743df15-4830-8d83-bc36-6ddd33c1e720@petaramesh.org>
 <dd37e99c-e087-2b6d-830a-96811b337ba2@gmx.com>
 <bd183df9-4742-301d-251c-443d99d170c7@petaramesh.org>
 <a39bd758-69d2-cf16-de39-36e22cefe233@gmx.com>
From:   =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>
Message-ID: <0282e3ae-4d48-ac9d-79f9-459ea5420727@petaramesh.org>
Date:   Sun, 22 Dec 2019 11:15:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <a39bd758-69d2-cf16-de39-36e22cefe233@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Le 22/12/2019 à 10:37, Qu Wenruo a écrit :
>>
>> With « uncommitted metadata » do you mean that this situation is only
>> temporary and should end once all transactions are commited to disk ?
> 
> Yes. The temporary part also matches with one kind reporter's description.
> So for that v5.4 temporary 0 available, it should be the case.

Unfortunately in my case it was not « temporary », the filesystem was 
idle, and the « zero free space » survived unmounts and remounts and 
showed the same using kernels 5.3 and 4.15 on other machines...

...But a « btrfs balance -m » (under kernel 5.4) fixed it in the end.

> But there is one valid behavior which may cause such 0 available space
> situation.
> Are you using RAID1 or RAID10 with hugely unbalanced disk size?

Absolutely not. Relatively fresh BTRFS FS on a single 2TB device on 
which at least 33% of the space had never been allocated.

> We need extra info to further determine the cause of the persistent 0
> available space problem.
> `btrfs fi usage` output would help a lot.

Here's all what I get AFTER the "btrfs balance -m" fixed things:

[moksha /]# uname -r
5.4.2-1-MANJARO

[moksha /]# btrfs fi sh
Label: 'MyFS'  uuid: xxxxxxxxx-yyyy-zzzz-tttt-wwwwwwwwwwww
	Total devices 1 FS bytes used 1.19TiB
	devid    1 size 1.82TiB used 1.20TiB path 
/dev/mapper/luks-aaaaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee

[moksha /]# btrfs fi df /run/media/myself/MyFS
Data, single: total=1.18TiB, used=1.18TiB
System, DUP: total=32.00MiB, used=160.00KiB
Metadata, DUP: total=8.00GiB, used=6.93GiB
GlobalReserve, single: total=512.00MiB, used=0.00B

[moksha /]# btrfs fi us /run/media/myself/MyFS
Overall:
     Device size:		   1.82TiB
     Device allocated:		   1.20TiB
     Device unallocated:		 633.90GiB
     Device missing:		     0.00B
     Used:			   1.20TiB
     Free (estimated):		 634.26GiB	(min: 317.31GiB)
     Data ratio:			      1.00
     Metadata ratio:		      2.00
     Global reserve:		 512.00MiB	(used: 0.00B)

Data,single: Size:1.18TiB, Used:1.18TiB (99.97%)
    /dev/mapper/luks-aaaaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee	   1.18TiB

Metadata,DUP: Size:8.00GiB, Used:6.93GiB (86.63%)
    /dev/mapper/luks-aaaaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee	  16.00GiB

System,DUP: Size:32.00MiB, Used:160.00KiB (0.49%)
    /dev/mapper/luks-aaaaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee	  64.00MiB

Unallocated:
    /dev/mapper/luks-aaaaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee	 633.90GiB

[moksha /]# df -h /run/media/myself/MyFS
Filesystem                       Size  Used Avail Use% Mounted on
/dev/mapper/luks-aaaaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee   1,9T    1,2T 
635G  66% /run/media/myself/MyFS


ॐ
-- 
Swâmi Petaramesh <swami@petaramesh.org> PGP 9076E32E
