Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0395B1931AB
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Mar 2020 21:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbgCYUMC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Mar 2020 16:12:02 -0400
Received: from smtp-35.italiaonline.it ([213.209.10.35]:43239 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727280AbgCYUMC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Mar 2020 16:12:02 -0400
Received: from venice.bhome ([94.37.173.46])
        by smtp-35.iol.local with ESMTPA
        id HCNcjlhHQMAUpHCNcjTsZL; Wed, 25 Mar 2020 21:12:00 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1585167120; bh=CwCPngmIHXzDbCvikAXSCe3uTskcJ0fGN1CJwOI6Hb8=;
        h=From;
        b=F9iB9/SQcRXWgzoYCi+P22QRrXDYjzsm2D3DZ7B+a9+k6xCkcxhi1w2fVzqLKUvtW
         sUa7Gqx+PZM6y1pCHJkf7A+ga9f37AHHhTXppdRvEhfzwuAvERltI5fwXsd9iSgC7v
         8rffzTWrMMmJVQWIEFG31nlOFPhvCEEELIn3/OcW5v4I1EqEPu0ImYs2Y/2eX+2++P
         zOi//Fzjz1LV7FYMdNLAhnGzlXLxDlcQcL/B+3h+KUKm+++b6wwFsP2Tm5D4D57HLK
         X3IMzEC4buT7/kKZLYdMt3iLt0nu39ITuQloc815djAT6R4m8Vuq7e0x7Jwv+OWHdh
         vDpS4hHwja+kw==
X-CNFS-Analysis: v=2.3 cv=B/fHL9lM c=1 sm=1 tr=0
 a=TpQr5eyM7/bznjVQAbUtjA==:117 a=TpQr5eyM7/bznjVQAbUtjA==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=HuozUou23sIHX6oHUeMA:9
 a=r5RdhZlPGfi0ywxO:21 a=UEY1YkOT8fjfq0VW:21 a=QEXdDO2ut3YA:10
Subject: Re: [PATCH] btrfs-progs: add RAID5/6 support to btrfs fi us
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
References: <20200318211157.11090-1-kreijack@libero.it>
Message-ID: <91df2f66-ea8a-c369-9f03-b826dbbe1481@libero.it>
Date:   Wed, 25 Mar 2020 21:12:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200318211157.11090-1-kreijack@libero.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMgHZhaJXGum9AyvWSAkUo5LcsqXzq1e2tib4MzFt9Qvez8kv39n+VyJv6GTwaBUBFdWiAl4FGvOGHoRRfShb1VtBQQbqg17Qn5+sVgFxtn7IDMc/Al8
 v2NzyOi20IeLlSSEfYWYyXdX1l79YhAWDZhIy+dorptwNyadZweJXj/NquNp2xyY0+03Ilh44UZ2cA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

PING,

does someone find interest on this kind of patch ?

BR
G.Baroncelli

On 3/18/20 10:11 PM, Goffredo Baroncelli wrote:
> 
> Hi all,
> 
> this patch adds support for the raid5/6 profiles in the command
> 'btrfs filesystem usage'.
> 
> Until now the problem was that the value r_{data,metadata}_used is not
> easy to get for a RAID5/6, because it depends by the number of disks.
> And in a filesystem it is possible to have several raid5/6 chunks with a
> different number of disks.
> 
> In order to bypass this issue, I reworked the code to get rid of these
> values where possible and to use the l_{data,metadata}_used ones.
> Notably the biggest differences is in how the free space estimation
> is computed. Before it was:
> 
> 	free_estimated = (r_data_chunks - r_data_used) / data_ratio;
> 
> After it is:
> 
> 	free_estimated = l_data_chunks - l_data_used;
> 
> which give the same results when there is no mixed raid level, but a
> better result in the other case. I have to point out that before in the
> code there was a comment that said the opposite.
> 
> The other place where the r_{data,metadata}_used are use is for the
> "Used:" field. For this case I estimated these values using the
> following formula (only for raid5/6 profiles):
> 
> 	r_data_used += (double)r_data_chunks * l_data_used /
>                                 l_data_chunks;
> 
> Note that this is not fully accurate. Eg. suppose to have two raid5 chunks,
> the first one with 3 disks, the second one with 4 disks, and that each
> chunk is 1GB.
> r_data_chunks_r56, l_data_used_r56, l_data_chunks_r56 are completely defined,
> but real r_data_used is completely different in these two cases:
> - the first chunk is full and the second one id empty
> - the first chunk is full empty and the second one is full
> However now this error affect only the "Used:" field.
> 
> 
> So now if you run btrfs fi us in a raid6 filesystem you get:
> 
> $ sudo btrfs fi us /
> Overall:
>      Device size:		  40.00GiB
>      Device allocated:		   8.28GiB
>      Device unallocated:		  31.72GiB
>      Device missing:		     0.00B
>      Used:			   5.00GiB
>      Free (estimated):		  17.36GiB	(min: 17.36GiB)
>      Data ratio:			      2.00
>      Metadata ratio:		      0.00
>      Global reserve:		   3.25MiB	(used: 0.00B)
> 
> Data,RAID6: Size:4.00GiB, Used:2.50GiB (62.53%)
> [...]
> 
> Instead before:
> 
> $ sudo btrfs fi us /
> WARNING: RAID56 detected, not implemented
> WARNING: RAID56 detected, not implemented
> WARNING: RAID56 detected, not implemented
> Overall:
>      Device size:		  40.00GiB
>      Device allocated:		     0.00B
>      Device unallocated:		  40.00GiB
>      Device missing:		     0.00B
>      Used:			     0.00B
>      Free (estimated):		     0.00B	(min: 8.00EiB)
>      Data ratio:			      0.00
>      Metadata ratio:		      0.00
>      Global reserve:		   3.25MiB	(used: 0.00B)
> 
> Data,RAID6: Size:4.00GiB, Used:2.50GiB (62.53%)
> [...]
> 
> 
> I want to point out that this patch should be compatible with my
> previous patches set (the ones related to the new ioctl
> BTRFS_IOC_GET_CHUNK_INFO). If both are merged we will have a 'btrfs fi us'
> commands with full support a raid5/6 filesystem without needing root
> capability.
> 
> Comments are welcome.
> BR
> G.Baroncelli
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
