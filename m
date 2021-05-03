Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5893714A0
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 May 2021 13:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbhECL7V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 May 2021 07:59:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57802 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbhECL7V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 May 2021 07:59:21 -0400
Received: from cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net ([80.193.200.194] helo=[192.168.0.209])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1ldXDW-0007KD-5g; Mon, 03 May 2021 11:58:26 +0000
Subject: Re: [PATCH] fs/btrfs: Fix uninitialized variable
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Khaled Romdhani <khaledromdhani216@gmail.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20210501225046.9138-1-khaledromdhani216@gmail.com>
 <20210503072322.GK1981@kadam> <20210503101312.GA27593@ard0534>
 <20210503115515.GJ21598@kadam>
From:   Colin Ian King <colin.king@canonical.com>
Message-ID: <7b58f7c7-1586-0e0f-4166-d5132322fe58@canonical.com>
Date:   Mon, 3 May 2021 12:58:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210503115515.GJ21598@kadam>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 03/05/2021 12:55, Dan Carpenter wrote:
> On Mon, May 03, 2021 at 11:13:12AM +0100, Khaled Romdhani wrote:
>> On Mon, May 03, 2021 at 10:23:22AM +0300, Dan Carpenter wrote:
>>> On Sat, May 01, 2021 at 11:50:46PM +0100, Khaled ROMDHANI wrote:
>>>> Fix the warning: variable 'zone' is used
>>>> uninitialized whenever '?:' condition is true.
>>>>
>>>> Fix that by preventing the code to reach
>>>> the last assertion. If the variable 'mirror'
>>>> is invalid, the assertion fails and we return
>>>> immediately.
>>>>
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>> Signed-off-by: Khaled ROMDHANI <khaledromdhani216@gmail.com>
>>>> ---
>>>
>>> This is not how you send a v4 patch...  v2 patches have to apply to the
>>> original code and not on top of the patched code.
>>>
>>> I sort of think you should find a different thing to work on.  This code
>>> works fine as-is.  Just leave it and try to find a real bug and fix that
>>> instead.
>>>
>>> regards,
>>> dan carpenter
>>>
>>
>> Sorry, I was wrong and I shall send a proper V4.
>>
>> Yes, this code works fine just a warning caught by Coverity scan analysis. 
> 
> We're going to a lot of work to silence a static checker false positive.
> As a rule, I tell people to ignore the static checker when it is wrong.
> 
> Btw, Smatch parses this code correctly and understands that the callers
> only pass valid values for "mirror".

..and Coverity does report a lot of false positives, so one needs to be
really sure the issue is a genuine issue rather than a warning that can
be ignore.

Colin

> 
> regards,
> dan carpenter
> 

