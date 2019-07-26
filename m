Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F32C75EC9
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2019 08:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725869AbfGZGND (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jul 2019 02:13:03 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:47242 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfGZGND (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jul 2019 02:13:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564121582; x=1595657582;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=1RqFNTUZPMUj6S+6Y0GNwc5/ZIEZUqmioTbPM4gVAn4=;
  b=h+xUYzaqJ37gK0GoFxHXqWjKwSW+fAfuqRMRToWFZpPeWG4ILElU4T2I
   7bc3dN0Cfn9+EjlUZzp+hOIVL0GteUGHjCjyhYg/33sbUZ3XeIJJZH3h0
   daG63G5Dil6b5kwmaX588UtevOXMUvnD12Ao8b8V7/8ZHCHUjtHxnQ17O
   Pg+q1Z0tGeuQZ39Ixe8MH2XGSmEMpiWKSJkyWXSWaBfPQMevRdyoFKczD
   +i63BC4vemgBMi0RF/cBK5HuCmRFpqVrNmpML9R2Z9LMjlRbgHABB9Dnq
   4HWPF+jnFDFWUgkEGCQhIk8aQ7zsM7CIy/t5eHMMfl1CMGj9O5YAJCfjR
   g==;
IronPort-SDR: YpIAzBSNi6jSlIb4UiewlCbUY91T2VfupplVXUn7Oez0go+s+f9C8w1bbjSXwO7kYJvU/QxIXK
 zfLh9kLORHeCr+hPZ+UQtWhKfpD4reioNWh2PtfMJVxyeqmXCKLR/IU2JzA+rtmjHJpL10byA0
 kZZnP1gphA4Oy5kdp9YEXR8/Ue6Kj9xcv0kI0uWPqZ5I4MIdvrHWJh8NZYBOcwf5SFsuSQ+etZ
 lCIkkkeIxACDCX59GJRHj7lEF7gb5cV2wjN9i8yCecI/XJqbV5GfaTwq+NHqtsm14oV+9A5hXA
 8BI=
X-IronPort-AV: E=Sophos;i="5.64,309,1559491200"; 
   d="scan'208";a="118880201"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jul 2019 14:13:02 +0800
IronPort-SDR: RB78L9bZ7YPC73g2K6HMfLhGMe4QK6nG7UdJvvss3BzBPcNR9tsNlqZ58lqEIIs4VvIJqbEVwi
 gZj/le9UioqFCLzhMgVHf8q8F1FtRe72wNH84Ka3oiNHW+C1hPNLw3ThdmLsCoaCsubiHGbRFF
 vYyHfsD/QsB6xndggm+OxBX/VNTwQw0VjWlNb5u1lRC6w+1bxOjH33EZwdWB/xJoNVxNmMrzlk
 f6VV28eUr/Y5YeqLioAKyukkXTW70AbCLCNAMV0xKBaLX/tdEroGC4bv98K4XNHKRvHgbaMoCf
 PlAeGKlS/o/qB2vbAt0JZbN7
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 25 Jul 2019 23:11:12 -0700
IronPort-SDR: lt1VcI5iHRyqu2Toq1gyWV6b9EGdITO4zWX2nzb58edgEZfLw2nIH+lcoTybTfZxcbwczxc6ah
 U1PSayHcCcbLdXPPWIztZAXFd95QLSMoKuivqZgFASifutut77QFWsmR9k6ZTWBgDRrELen7xE
 gl84uwBxO1Or2g2o+tFR/AYn2MTVL/QE9YqTGm486DlrOf5JBvw75MWESVEKkVWqtoQdFLEciS
 Fi6g3q7u32epQFOf9Txn5xYhhoaqbe8zNqIWbTT+0Ti2lD3aAa3tZXZnz7XBbKCuk0YHYIDupJ
 HzE=
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with SMTP; 25 Jul 2019 23:13:01 -0700
Received: (nullmailer pid 12685 invoked by uid 1000);
        Fri, 26 Jul 2019 06:13:00 -0000
Date:   Fri, 26 Jul 2019 15:13:00 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH] btrfs: fix extent buffer read/write range checks
Message-ID: <20190726061300.gvwypjd32elqtkhu@naota.dhcp.fujisawa.hgst.com>
References: <20190726052724.12338-1-naohiro.aota@wdc.com>
 <d81154a4-dd3f-481f-92cb-25ea32b55900@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d81154a4-dd3f-481f-92cb-25ea32b55900@suse.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 26, 2019 at 08:38:27AM +0300, Nikolay Borisov wrote:
>
>
>On 26.07.19 г. 8:27 ч., Naohiro Aota wrote:
>> Several functions to read/write an extent buffer check if specified offset
>> range resides in the size of the extent buffer. However, those checks have
>> two problems:
>>
>> (1) they don't catch "start == eb->len" case.
>> (2) it checks offset in extent buffer against logical address using
>>     eb->start.
>>
>> Generally, eb->start is much larger than the offset, so the second WARN_ON
>> was almost useless.
>>
>> Fix these problems in read_extent_buffer_to_user(),
>> {memcmp,write,memzero}_extent_buffer().
>>
>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>
>Qu already sent similar patch:
>
>[PATCH v2 1/5] btrfs: extent_io: Do extra check for extent buffer read
>write functions
>
>
>He centralised the checking code, your >= fixes though should be merged
>there.

Oops, I missed that series. Thank you for pointing out. Then, this
should be merged into Qu's version.

Qu, could you pick the change from "start > eb->len" to "start >= eb->len"?

>
>
>> ---
>>  fs/btrfs/extent_io.c | 16 ++++++++--------
>>  1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 50cbaf1dad5b..c0174f530568 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -5545,8 +5545,8 @@ int read_extent_buffer_to_user(const struct extent_buffer *eb,
>>  	unsigned long i = (start_offset + start) >> PAGE_SHIFT;
>>  	int ret = 0;
>>
>> -	WARN_ON(start > eb->len);
>> -	WARN_ON(start + len > eb->start + eb->len);
>> +	WARN_ON(start >= eb->len);
>> +	WARN_ON(start + len > eb->len);
>>
>>  	offset = offset_in_page(start_offset + start);
>>
>> @@ -5623,8 +5623,8 @@ int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
>>  	unsigned long i = (start_offset + start) >> PAGE_SHIFT;
>>  	int ret = 0;
>>
>> -	WARN_ON(start > eb->len);
>> -	WARN_ON(start + len > eb->start + eb->len);
>> +	WARN_ON(start >= eb->len);
>> +	WARN_ON(start + len > eb->len);
>>
>>  	offset = offset_in_page(start_offset + start);
>>
>> @@ -5678,8 +5678,8 @@ void write_extent_buffer(struct extent_buffer *eb, const void *srcv,
>>  	size_t start_offset = offset_in_page(eb->start);
>>  	unsigned long i = (start_offset + start) >> PAGE_SHIFT;
>>
>> -	WARN_ON(start > eb->len);
>> -	WARN_ON(start + len > eb->start + eb->len);
>> +	WARN_ON(start >= eb->len);
>> +	WARN_ON(start + len > eb->len);
>>
>>  	offset = offset_in_page(start_offset + start);
>>
>> @@ -5708,8 +5708,8 @@ void memzero_extent_buffer(struct extent_buffer *eb, unsigned long start,
>>  	size_t start_offset = offset_in_page(eb->start);
>>  	unsigned long i = (start_offset + start) >> PAGE_SHIFT;
>>
>> -	WARN_ON(start > eb->len);
>> -	WARN_ON(start + len > eb->start + eb->len);
>> +	WARN_ON(start >= eb->len);
>> +	WARN_ON(start + len > eb->len);
>>
>>  	offset = offset_in_page(start_offset + start);
>>
>>
