Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA57819ED68
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Apr 2020 20:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgDESrT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Apr 2020 14:47:19 -0400
Received: from smtp-35.italiaonline.it ([213.209.10.35]:56171 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726771AbgDESrT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 5 Apr 2020 14:47:19 -0400
Received: from venice.bhome ([94.37.173.46])
        by smtp-35.iol.local with ESMTPA
        id LAIdjBBKiMAUpLAIejSs1R; Sun, 05 Apr 2020 20:47:16 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1586112436; bh=RDnNP7FIJuUKSoZ9DNeDVirXjDu5O7bsydqccwSDqKQ=;
        h=From;
        b=BChgpMFaKTTV/gcSg0xHMDvky3ykw0TAwAqjUyv0lkUIEdLA1rL51Qgy2UHaJxxBy
         1TbvIkUfRLFY/XaWsFNTXK2rTBkCXYmH2r4UbV8rBRZUak1h1vxGfloNBRBT19kZd/
         xLsGyTmHw6b609CiisQ4xUDxvke8ku3WNIDAZ2xuQx8yAeeQFk79Kz0W4CwhTHKK+E
         PyGIQX+z+jQ/bk5okaCwZxDbzMqVfCIqpV3kX5d7HQ+TlE5MK8T9AdmqvGaL5q0wr4
         uyOv8NSCPdf21KRjWS9WAfMYFQrfN51v7Izt0ErjUEYLtTbEDls+pL+KHgay1TcZxi
         1itSg+3UQB/ow==
X-CNFS-Analysis: v=2.3 cv=B/fHL9lM c=1 sm=1 tr=0
 a=TpQr5eyM7/bznjVQAbUtjA==:117 a=TpQr5eyM7/bznjVQAbUtjA==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=PBbJxcHo1tzoxWNbgcUA:9
 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: [RFC][PATCH V3] btrfs: ssd_metadata: storing metadata on SSD
To:     Graham Cobb <g.btrfs@cobb.uk.net>, linux-btrfs@vger.kernel.org
References: <20200405082636.18016-1-kreijack@libero.it>
 <58e315a1-0307-9a26-8fb4-fd5220c1d5a6@cobb.uk.net>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <4f10882a-fa89-25e0-901c-aff8010d46cd@libero.it>
Date:   Sun, 5 Apr 2020 20:47:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <58e315a1-0307-9a26-8fb4-fd5220c1d5a6@cobb.uk.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJPQHGQbvDXlKaGMyqrC7FR3iv3po4Ya+ct4YrtL4Qs9UY+f2PaLxkFeJa6bWsxhOL9lvYYjT3/WuSceagbmUGX/OMXGi5kDCO2Owv5cuT19tD0fP2va
 UAPI93WOyI+esVrH9Vvq6zdXdBYzgqe9inVn4p2vJ+FFTuk6bxwxElsbc5bFD54A1dxslLJX/DtzJv5kJ/YzfhsVIH4q6ewMlpQ=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/5/20 12:57 PM, Graham Cobb wrote:
> On 05/04/2020 09:26, Goffredo Baroncelli wrote:
[...]
>>
>>
>> Test description      real (mmm:ss)	Delta %
>> --------------------  -------------  -------
>> btrfs hdd w/sync	   142:38	+533%
>> btrfs ssd+hdd w/sync     81:04	+260%
>> ext4 hdd w/sync          52:39	+134%
>> btrfs bcache w/sync      35:59	 +60%
>> btrfs ssd w/sync         22:31	reference
>> ext4 ssd w/syn           12:19	 -45%
> 
> Interesting data but it seems to be missing the case of btrfs ssd+hdd
> w/sync without your patch in order to tell what difference your patch
> made. Or am I confused?
> 
Currently BTRFS allocates the chunk on the basis of the free space.

For my tests I have a smaller ssd (20GB) and a bigger hdd (230GB).
This means that the latter has higher priority for the allocation,
until the free space became equal.

The rationale behind my patch is the following:
- is quite simple (even tough in 3 iteration I put two errors :-) )
- BTRFS has already two kind of information to store: data and metadata.
   The former is (a lot ) bigger, than the latter. Having two kind of storage,
   one faster (and expensive) than the other, it is natural to put the metadata
   in the faster one, and the data in the slower one.

BR
G.Baroncelli

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
