Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A3A41BF6E
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Sep 2021 08:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244478AbhI2HBU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Sep 2021 03:01:20 -0400
Received: from mout.gmx.net ([212.227.17.22]:53277 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229536AbhI2HBT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Sep 2021 03:01:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1632898777;
        bh=NVlxX0hUDVQHxFD5prTXgQmWuy4ymr/tKSA0+vn8dT4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=X5NdzFoMDl0igOQOo6Aqg5ZEwWnPjOa/6C0UI1WXZwazCCgdI9dHYZy5ltT+Vdgc3
         sXaRCeRcHQ5j9P9txH8Jz8GiNp1RqjSEWNqn7xTkDsb6O7PLJkCnGz3QczZBKPQ8h0
         rikvXjtK2g7SWqIeb6AiM3bzFqE0sMJzzZL/lNqg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MwQXN-1mmS5N0e4j-00sK2X; Wed, 29
 Sep 2021 08:59:36 +0200
Message-ID: <1b268f4f-ad5f-3efd-9072-a9382fda20d1@gmx.com>
Date:   Wed, 29 Sep 2021 14:59:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH] fstests: btrfs/248: test if btrfs receive can handle
 clone command on inodes with different NODATASUM flags
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <20210929004446.12654-1-wqu@suse.com>
 <7ee471f1-d262-dcc5-8e21-82b3cf2cffd5@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <7ee471f1-d262-dcc5-8e21-82b3cf2cffd5@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y/+/ZXj5KxD2RsiNaqjZNcEswkUlZH+GFzGk4Hm2gYhJSYjBSJP
 ropivki2+DOm6maV8Dgld9EEkhAJMHjIp/bqFRwfcl8P/xwVOuwCg0DNCuK78hzioUItSbi
 zFiWqNu/luHQd9xrI+ttNZXWHjDxVWrRH2FWIa9cMn6rWRXIZUn2KosFBlxmTOq+hQM+nBv
 G3jgqZA4gBBtyznZ44gwA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:s2Bfvk+sqBs=:D5B2DdRj3nrfBOQL5tBqoG
 HJIC1ejh5mrM0z3cuYFVcK85QyrqfFSL4Ban/gZUnZBdQjS8y5rl+TaFNSY74p9+ZQFX7m83/
 9XR3uVPfVcMpY7sXhFTZewcwqyRblPEOXNTZLQIz5TCucJsKXaLpHF3lbXCMmM7eXowxlLLVH
 yLT5plQDZzxAaMbEEwsul9T3M1oYe1w9sIQHpz+RQFTXSoVgnPAi2KtMFsHZKrgGqmbPUqNZ2
 8JXiuJxHvHIl0IY4s3+T9jcH5Y1xjnFdfzu/J7Dj4Rx+KOG/hHMP34koCxxfG4HWv+bEenrM2
 Z2Mj85PHx0OSX8Wy4y9ZmyHogihw169qDJs8bxzprczQ3aMN+5Z4X/1tnVbx19sSySVdHcRCZ
 ipO6AnUm/+c4RSRgO/cyPdduTNI5jvnF1y1i3lNXiVPX+2e96SXDMfYbuaKCmC4vp4L+S3VtQ
 RjftISn8WJRtZUW+x567niLf4uqidUPGZnDjvWHlm++vafRATgbo+vRzwKrSTn7tDY9iat5AS
 HEoGlP1YpTV0xC2B3qNKELAwdN7UmjZqzzU6oW84S3YVzj05w6sk8mXojOlLSTq8gsmIYeqTR
 yesbXRJc8U+cly4l7PRhoI4C0+yIGphqS7+XmfNsRFp0Vf0Vxa3xk3L+riVoJdzSsqeiXzCAJ
 4CpQA1TcvTyFL4kaff25MH9sQHPVIn3skarEf3fPVeQeu/5wZabXn/n5DypAo4BGTxZuNVUTw
 O6noKkigNQzX96oL/PLGd8sqTP+5iV2yTjMf5mZIFyYxp1Dn0vosbm18uFRisSGLmLgjoBKsO
 Ddg9TCDYmXkUPR6x9YLZaZz/mvSrg+d153Ng7OBWiuAfP8gm7VaLfskgobPVM4K0+X0gYX3zh
 mmvWXHRDkX4DTQ1M9fRCI+Q+GPcaqTAk8YGp3wlocGQzh4me0Pcjj3bZkpQ650m8h9undiKdt
 VWIvIn9AXkaU+MW6xtUTvKc7U9sJCPwTsUGgKpbQ5DEXW6YmoTm10+SOJBv3nqGXq/oZtKcGW
 oYD47Tk9+qK8vmybdXNKcMf2wRnIwUcPtQOnTb8KUtIOg3qI4mNxvZfQRFydeZPBVcwOnUPD9
 iWN0h7l64Er4oQ=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/29 14:45, Nikolay Borisov wrote:
>
>
> On 29.09.21 =D0=B3. 3:44, Qu Wenruo wrote:
>> The planned fix is titled "btrfs-progs: receive: fallback to buffered
>> copy if clone failed".
>>
>> The test case itself will create two send streams, and the 2nd stream i=
s
>> an incremental stream with a clone command in it.
>>
>> Using different mount options we are able to create a situation where
>> clone source and destination have different NODATASUM flags, which is
>> prohibited inside btrfs.
>>
>> The planned fix will make btrfs receive to fall back to buffered write
>> to copy the data from the source file.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> If this is fixed by btrfs-progs fix shouldn't the test be part of
> btrfs-progs and not the kernel test suite?
>

Makes sense.

Would move it to btrfs-progs misc-tests, which can be more flex there.

THanks,
Qu
