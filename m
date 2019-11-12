Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2E0F9A13
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2019 20:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfKLT5o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Nov 2019 14:57:44 -0500
Received: from smtp-32.italiaonline.it ([213.209.10.32]:37741 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726388AbfKLT5o (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Nov 2019 14:57:44 -0500
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Nov 2019 14:57:43 EST
Received: from venice.bhome ([94.38.75.109])
        by smtp-32.iol.local with ESMTPA
        id UcAPiQIAYhCYOUcAPi9D4X; Tue, 12 Nov 2019 20:49:33 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1573588174; bh=2egvcRnX0NyCpbemlBseqkpd2ZRqQaNG5xh7znNqQCI=;
        h=Reply-To:Subject:To:References:From:Cc:Date:In-Reply-To;
        b=mcHoq9Q8WFIID+uF6K3UdvQTpOW8Zi73G3xtXpblkeFlTp18JRDBgwMe6VnhD454u
         9uf74XfFUL7dtuExwJgkVDXG62V8T8vUSXBTKuUoZ875fAW/T2MF48dWTQrep1ewbS
         /QSI544SE7v7zQa+/98mdYE3WUbqXfTiA/bdDqJ9A1IrEmk5EwER7Pb04EevCCPVNq
         HSB7seoODRhaW/gce1c1Y6HhV/5PqxJT+kQ3i3Sy/FiQi6rw7WKMvgnpNcBTAODtyX
         VfVCJmAgnu1TgBCERd1XhMdhoUQvW8aACnrzkMx/tSASTWmY3l/aqnHmJUsimwVuJ8
         4Qm5gKruJIulg==
X-CNFS-Analysis: v=2.3 cv=D9k51cZj c=1 sm=1 tr=0
 a=KzXHLLuG32F0DtnFfJanyA==:117 a=KzXHLLuG32F0DtnFfJanyA==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=Vt2AcnKqAAAA:8
 a=VwQbUJbxAAAA:8 a=BWdaOUHQawdRun5xwn4A:9 a=QEXdDO2ut3YA:10
 a=v10HlyRyNeVhbzM4Lqgd:22 a=AjGcO6oz07-iQ99wixmX:22
Reply-To: kreijack@inwind.it
Subject: Re: Avoiding BRTFS RAID5 write hole
To:     Hubert Tonneau <hubert.tonneau@fullpliant.org>
References: <0JG8IAF11@briare1.fullpliant.org>
From:   Goffredo Baroncelli <kreijack@libero.it>
Cc:     linux-btrfs@vger.kernel.org
Message-ID: <441de86e-a0ea-fdc9-7fce-bb2cf56d0be8@libero.it>
Date:   Tue, 12 Nov 2019 20:49:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <0JG8IAF11@briare1.fullpliant.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKsmks1CpYgvGgx6A1ADTU5l0i0ASai6Mdn/6H6YSnYQfmiEDnlY7HxnHzFXU10/Vvc8NHo14xfxF18awcDnCE3RJMh83ioDH+neAb8owq+ouMO4tcET
 PUZi8swLO7w2Hq/jh6oaHpuFSppYuD1/d4hWmTeCphzUmhytAXT0v8ioD0RB9jZy6GgicA0da+HF0nGhTqkZI3421vFbu70QVRESFO/XcpVpGO8KGhG8hYDG
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/11/2019 16.13, Hubert Tonneau wrote:
> Hi,
> 
> In order to close the RAID5 write hole, I prepose the add a mount option that would change RAID5 (and RAID6) behaviour :
> 
> . When overwriting a RAID5 stripe, first convert it to RAID1 (convert it to RAID1C3 if it was RAID6)

You can't overwrite  and convert a existing stripe for two kind of reason:
1) you still have to protect the stripe overwriting from the write hole
2) depending by the layout, a raid1 stripe consumes more space than a raid5 stripe with equal "capacity"

So you have to write (temporarily) the data on another place. This is something not different from what Qu proposed few years ago:

https://www.mail-archive.com/linux-btrfs@vger.kernel.org/msg66472.html [Btrfs: Add journal for raid5/6 writes]

where he added a device for logging the writes.

Unfortunately, this means doubling the writes; that for a COW filesystem (which already suffers this kind of issue) would be big performance penality....

Instead I would like to investigate the idea of COW-ing the stripe: instead of updating the stripe on place, why not write the new stripe in another place and then update the data extent to point to the new data ? Of course would work only for the data and not for the metadata.
Pros: the data is written only once
Cons: the pressure of the metadata would increase; the fragmentation would increase


> 
> . Have a background process that converts RAID1 stripes to RAID5 (RAID1C3 to RAID6)
> 
> Expected advantages are :
> . the low level features set basically remains the same
> . the filesystem format remains the same
> . old kernels and btrs-progs would not be disturbed
> 
> The end result would be a mixed filesystem where active parts are RAID1 and archives one are RAID5.
> 
> Regards,
> Hubert Tonneau
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
