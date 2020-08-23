Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B5E24EDE0
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Aug 2020 17:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgHWPNM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Aug 2020 11:13:12 -0400
Received: from mailrelay1-3.pub.mailoutpod1-cph3.one.com ([46.30.212.10]:43780
        "EHLO mailrelay1-3.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726935AbgHWPNL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Aug 2020 11:13:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lechevalier.se; s=20191106;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version:date:
         message-id:references:to:from:subject:from;
        bh=x6CXDA9KDnyznhWqqWtMXPpPFx1vpmBgdQaLV969HfA=;
        b=OWs8CYTJT8e6c2u2qGJmD7Qed6GncORZLXIiBVINn/gzCjJWXdhAVJZuCuMFaLOAleJg82mhkCVAK
         wPWOd5MTA5DrdcyE5GirtrsYynb2BQrTD9pR8T7EotvUGb1SSvkoaGG3YjFBNGwARPwdPP9wmKfjig
         HLZJQlZ+zKkEcqlSPiDm6EGemxPN1wuNawbaGK/wn5zTIlAy9vvwE9JCS8bfGv8qdcRWYLTXJTO9Ya
         2F/lYGQd9WI3rdVB4UhYr2IhSkPLhq/Ue211S2/IuV4RcpjLWbplcUnfhiAGMZQ0jbFb7Lcx/VUBTv
         gnd5yDrp0WNX4KTZDVFmuFpdvLlACLg==
X-HalOne-Cookie: c0577868278f897f28f9e68f6e221c84bdef7a94
X-HalOne-ID: 249bd56a-e553-11ea-b2e9-d0431ea8a283
Received: from [10.0.88.22] (unknown [98.128.186.116])
        by mailrelay1.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 249bd56a-e553-11ea-b2e9-d0431ea8a283;
        Sun, 23 Aug 2020 15:13:04 +0000 (UTC)
Subject: Re: Minimum size of Btrfs volume ?
From:   A L <mail@lechevalier.se>
To:     Bill Dietrich <bill@billdietrich.me>, linux-btrfs@vger.kernel.org
References: <1de8d385-4f63-cf84-2a60-9519e55035bc@billdietrich.me>
 <19d8936.867cd4c.1741bdced46@lechevalier.se>
Message-ID: <45ab10d3-6202-48b1-c775-669197eb4822@lechevalier.se>
Date:   Sun, 23 Aug 2020 17:13:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <19d8936.867cd4c.1741bdced46@lechevalier.se>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 2020-08-23 17:08, A L wrote:
>
> ---- From: Bill Dietrich <bill@billdietrich.me> -- Sent: 2020-08-23 - 15:26 ----
>
>> [Noob here, sorry if I'm doing anything wrong.]
>>
>> What is the minimum size of a simple single-disk Btrfs volume,
>> and where is it documented ?  I can't find that info.
>>
>> I'm told the minimum size is about 109 MB (114294784 bytes).
>> True ?  Is there any way to get around that, at mkfs-time ?
>> I'd like to use Btrfs inside a VeraCrypt container, and that's
>> a fairly big minimum size for that use.
>>
>> I'm using Btrfs on Ubuntu GNOME 20.04 desktop.
>>
>> Thanks,
>>
>> Bill Dietrich
>> bill@billdietrich.me
>>
>>
>>
>> -- Email domain proudly hosted at https://migadu.com
> I'm not sure what minium limit is, but you can try using mkfs.btrfs --mixed. This worked with a 50MiB fs on btrfs-progs 5.7:
>
> # btrfs fi us /mnt/loop
> Overall:
>      Device size:		  50.00MiB
>      Device allocated:		   9.00MiB
>      Device unallocated:		  41.00MiB
>      Device missing:		     0.00B
>      Used:			  32.00KiB
>      Free (estimated):		  45.16MiB	(min: 45.16MiB)
>      Data ratio:			      1.00
>      Metadata ratio:		      1.00
>      Global reserve:		 832.00KiB	(used: 0.00B)
>      Multiple profiles:		        no
>
> Data+Metadata,single: Size:5.00MiB, Used:28.00KiB (0.55%)
>     /dev/loop0	   5.00MiB
>
> System,single: Size:4.00MiB, Used:4.00KiB (0.10%)
>     /dev/loop0	   4.00MiB
>
> Unallocated:
>     /dev/loop0	  41.00MiB
>
I was curious, so I went lower. Seems the limit is 16MiB using --mixed:

  # fallocate -l 10MiB loop.img
  # mkfs.btrfs -M loop.img
btrfs-progs v5.7
See http://btrfs.wiki.kernel.org for more information.

ERROR: 'loop.img' is too small to make a usable filesystem
ERROR: minimum size for each btrfs device is 16777216


