Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 650D0199ECF
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Mar 2020 21:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgCaTSV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Mar 2020 15:18:21 -0400
Received: from smtp-35.italiaonline.it ([213.209.10.35]:37502 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726315AbgCaTSV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Mar 2020 15:18:21 -0400
Received: from venice.bhome ([94.37.173.46])
        by smtp-35.iol.local with ESMTPA
        id JMOxjTkv9MAUpJMOxjzyFw; Tue, 31 Mar 2020 21:18:19 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1585682299; bh=W4L3tDf6IPuSpBx4sVyjuLnGU5PZPS4nFwYu2JL4tnI=;
        h=From;
        b=l92jIu/Rp7H1JDUiyaiPezUGzQ3G6dPGvSYUihDXdBZRBGN+CX5+WIyjCe8jZlQO8
         8j43Er3c+pd4l8uxTNfo+4Kop8ibPcZOy2F6lktHiXs2j5wP4KvWj4rnuCy5SsQoks
         WIRGi2uJeKZtB5XB+krknXV5yz7NP7HMccr9yf4fbQHD+Tjo8iGu7qvOHIxBNdqqWT
         SDzbAKK6hM3Hx0+rDRvFZyrjmDX2furBOyn1jrw4tMntUNSxtReSp9fwvmpaWsEFjW
         bwvzhdbA9B9zAzKopD1jKCETmkKpcAxl62B5zuk3Ev1L1b8dHXl1MXT6cMcyFRDBJD
         WyXZcGecT9z+A==
X-CNFS-Analysis: v=2.3 cv=B/fHL9lM c=1 sm=1 tr=0
 a=TpQr5eyM7/bznjVQAbUtjA==:117 a=TpQr5eyM7/bznjVQAbUtjA==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=5OyekcXyWqhWBhKfEzMA:9
 a=QEXdDO2ut3YA:10
Subject: Re: [RFC] btrfs-progs: use the new ioctl BTRFS_IOC_GET_CHUNK_INFO
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
References: <20200315152430.7532-1-kreijack@libero.it>
Message-ID: <9355eddd-c5d0-a989-8e41-45c994fdd07f@libero.it>
Date:   Tue, 31 Mar 2020 21:18:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200315152430.7532-1-kreijack@libero.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHF8do+qph5FMFp2nenEumTvInPbtRC5K2P7VuC3RwRIII34kZOt4/fTpqgcnY6I011ZWYiwwaMf50qkBzXi/b647n3R5cS4mKh/7RIZ71+zgRwHGeKe
 r5MqvTyGSh4wyXpAEaOwvThn/+ONFIwJNx/wNE4MbW8VRKhyn0BL5LgOrn4mJ1hBxSzMpFkV0pvgWA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Gentle ping.

BR
G.Baroncelli
On 3/15/20 4:24 PM, Goffredo Baroncelli wrote:
> 
> Hi,
> 
> this is a repost of an old patch (~2017). At the time it din't received
> any feedback. I repost it hoping that it still be interested.
> 
> This patch set is the btrfs-prog related one; another one related to the
> kernel is send separately.
> 
> This patch set createa a new ioctl BTRFS_IOC_GET_CHUNK_INFO.
> The aim is to replace the BTRFS_IOC_TREE_SEARCH ioctl
> used by "btrfs fi usage" to obtain information about the
> chunks/block groups.
> 
> The problems in using the BTRFS_IOC_TREE_SEARCH is that it access
> the very low data structure of BTRFS. This means:
> 1) this would be complicated a possible change of the disk format
> 2) it requires the root privileges
> 
> The BTRFS_IOC_GET_CHUNK_INFO ioctl can be called even from a not root
> user: I think that the data exposed are not sensibile data.
> 
> These patches allow to use "btrfs fi usage" without root privileges.
> 
> before:
> -------------------------------------------
> 
> $ btrfs fi us /
> WARNING: cannot read detailed chunk info, per-device usage will not be shown, run as root
> Overall:
>      Device size:		 100.00GiB
>      Device allocated:		  26.03GiB
>      Device unallocated:		  73.97GiB
>      Device missing:		     0.00B
>      Used:			  17.12GiB
>      Free (estimated):		  80.42GiB	(min: 80.42GiB)
>      Data ratio:			      1.00
>      Metadata ratio:		      1.00
>      Global reserve:		  53.12MiB	(used: 0.00B)
> 
> Data,single: Size:23.00GiB, Used:16.54GiB (71.93%)
> 
> Metadata,single: Size:3.00GiB, Used:588.94MiB (19.17%)
> 
> System,single: Size:32.00MiB, Used:16.00KiB (0.05%)
> 
> after:
> -----------------------------------------------
> $ ./btrfs fi us /
> Overall:
>      Device size:		 100.00GiB
>      Device allocated:		  26.03GiB
>      Device unallocated:		  73.97GiB
>      Device missing:		     0.00B
>      Used:			  17.12GiB
>      Free (estimated):		  80.42GiB	(min: 80.42GiB)
>      Data ratio:			      1.00
>      Metadata ratio:		      1.00
>      Global reserve:		  53.12MiB	(used: 0.00B)
> 
> Data,single: Size:23.00GiB, Used:16.54GiB (71.93%)
>     /dev/sdd3	  23.00GiB
> 
> Metadata,single: Size:3.00GiB, Used:588.94MiB (19.17%)
>     /dev/sdd3	   3.00GiB
> 
> System,single: Size:32.00MiB, Used:16.00KiB (0.05%)
>     /dev/sdd3	  32.00MiB
> 
> Unallocated:
>     /dev/sdd3	  73.97GiB
> 
> Comments are welcome
> BR
> G.Baroncelli
> 
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
