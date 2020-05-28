Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9741E67AB
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 May 2020 18:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405167AbgE1QqO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 May 2020 12:46:14 -0400
Received: from smtp-34.italiaonline.it ([213.209.10.34]:50099 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405154AbgE1QqN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 May 2020 12:46:13 -0400
Received: from venice.bhome ([78.12.136.199])
        by smtp-34.iol.local with ESMTPA
        id eLfVjm4lwtrlweLfVjO3Vx; Thu, 28 May 2020 18:46:09 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1590684369; bh=xH7WARBwm8vx3FpqaRsiSUBjQfz1PvJnEhNHC/VLQFc=;
        h=From;
        b=pbOewf8y455u9iC3izx5XZwe7puHFHJ/xHKOyhA+uXdt7dHc1A4rOSynHhSHOThiX
         fLx2fqXfg7D/jY9WNzxZA4UWBWsDEaLguKw0BNQ+UeUxg6enhWK8FNarM6Ua0YP7l8
         SVSIyqKSQh5et4svk3AVmgoV3a5mC1g1ta2I0nsjuSPNdhG0c72BZ0Ue5v6RrjG0yx
         k5CmkauZpY/M8jTzmWrypUvZ0okLV6jCXz6dBL1Z84L/9ZeAsjhbyYEQEVvef8bsZI
         yPTLZqAbdYHiRGwt8KYQN8S5Ay34h+1txeVxryHOY9o6J6RK6iVhv+StFJtZzq2iLJ
         Eqr6ul1IY8dhg==
X-CNFS-Analysis: v=2.3 cv=TOE7tGta c=1 sm=1 tr=0
 a=kx39m2EDZI1V9vDwKCQCcA==:117 a=kx39m2EDZI1V9vDwKCQCcA==:17
 a=IkcTkHD0fZMA:10 a=MxUByxnuJ-PMbodASgkA:9 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH V2] btrfs-progs: add RAID5/6 support to btrfs fi us
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org,
        DanglingPointer <danglingpointerexception@gmail.com>,
        Joshua Houghton <joshua.houghton@yandex.ru>,
        David Sterba <dsterba@suse.com>
References: <20200527203748.32860-1-kreijack@libero.it>
 <20200528160721.GN18421@twin.jikos.cz>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <a705e6ad-cc99-b802-ec03-1ce56b04a95d@libero.it>
Date:   Thu, 28 May 2020 18:46:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200528160721.GN18421@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKcMcf6JvCqv1xUMukjXIKCy/u+HenVh648OonUa6wyrm8Jd/LiuvtFhcRNTz2el0VfWEBv1CVwF5f0S3t7p09kUWcBPQIp+4jTdtgc0NvfabmDbg9q7
 UjpOWFF3f/dsJnLlKn/zYU57F04u2WL3IHxj/WV19xlbhbfdY5HxrV2AUIzRvWkndJYzHYUCuJZWKp2hLY3vW9OfBttl5Z0xS1CaS88EhZbR5vTOrOznnezR
 JrzsLo0KFtVSKxrJRCFSDLKYBulkzCKoyUPy3cUbbA0s813YupNYoXtHK1EWYizmUtJqzjf8sbis2VNtQZefhA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/28/20 6:07 PM, David Sterba wrote:
> On Wed, May 27, 2020 at 10:37:47PM +0200, Goffredo Baroncelli wrote:
>> this patch adds support for the raid5/6 profiles in the command
>> 'btrfs filesystem usage'.
> 
>> $ sudo btrfs fi us /
>> Overall:
>>      Device size:		  40.00GiB
>>      Device allocated:		   8.28GiB
>>      Device unallocated:		  31.72GiB
>>      Device missing:		     0.00B
>>      Used:			   5.00GiB
>>      Free (estimated):		  17.36GiB	(min: 17.36GiB)
>>      Data ratio:			      2.00
>>      Metadata ratio:		      0.00
>>      Global reserve:		   3.25MiB	(used: 0.00B)
>>
>> Data,RAID6: Size:4.00GiB, Used:2.50GiB (62.53%)
> 
>> Instead before:
>>
>> $ sudo btrfs fi us /
>> WARNING: RAID56 detected, not implemented
>> WARNING: RAID56 detected, not implemented
>> WARNING: RAID56 detected, not implemented
>> Overall:
>>      Device size:		  40.00GiB
>>      Device allocated:		     0.00B
>>      Device unallocated:		  40.00GiB
>>      Device missing:		     0.00B
>>      Used:			     0.00B
>>      Free (estimated):		     0.00B	(min: 8.00EiB)
>>      Data ratio:			      0.00
>>      Metadata ratio:		      0.00
>>      Global reserve:		   3.25MiB	(used: 0.00B)
>>
>> Data,RAID6: Size:4.00GiB, Used:2.50GiB (62.53%)
> 
>> I rewrote the patch after some David's comments about the difficult to
>> review it because I changed too much code. So this time I tried to be less
>> intrusive. I leaved the old logic and I computed only the missing
>> values.
> 
> Thanks, that's what I expected. Patch added to devel.
> 

Greath ! Many thanks
BR
G.Baroncelli

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
