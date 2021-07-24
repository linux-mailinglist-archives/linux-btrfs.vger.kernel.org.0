Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32ECA3D46E8
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jul 2021 11:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbhGXJDe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Jul 2021 05:03:34 -0400
Received: from mout.gmx.net ([212.227.15.19]:54833 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234867AbhGXJDd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Jul 2021 05:03:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627119844;
        bh=fUPw3bEAS0zN657LyDcdvjdtG+Xo9oK+TvHSoSMxBYo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=E+5OYWGyC6EtyYZ2NPp9Kg/dWuTcHwQPBhA1HIlYWyoZuHpMsOnWg8wLL3LVRyHpO
         bIxfAsIzKj87In8Mfag78/ajvqN+pzZr0Djt5TC9dcAn/jhyj+hF1hIt/fzFlXzCKS
         fSX+CB7jFWTbDIEby9UcBF8OcZ2ClOjOPcLEYwQY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N2V4P-1l5TvY1SV5-013y4M; Sat, 24
 Jul 2021 11:44:04 +0200
Subject: Re: [PATCH] btrfs-progs: cmds: Fix build for using NAME_MAX
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20210724074642.68771-1-realwakka@gmail.com>
 <2305182b-1e12-df9c-320c-7a7eedba860d@gmx.com>
 <20210724082356.GA68829@realwakka>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <49a0090d-7055-b07b-f677-2d6e9bc4cc00@gmx.com>
Date:   Sat, 24 Jul 2021 17:44:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210724082356.GA68829@realwakka>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:coFlCa17OBQvtNmD8mmInok47MU82FBMzG6ZKXfGqbQUXmtqjas
 tbGjRXcFECrhHJxLUdAkb11JTaL6tpi7BfKgDTcjRmVM+6+Tojtf35l4gki/oYXbDVWdRhE
 Er7tMwd3UvLz7OlmUM1WR7InLalkcPe3ANSsNkM/TC18hnCNWfZ0lfYgsR5TUFxakOllwpA
 2iMKDPvOpXXShR0BQxjwg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:taItA961CL8=:ZYhWYuIu01px955dbcIqjx
 C+p7mEeUeCA+ZfX1JbVfShjXJZp8Lb6yz8vuTLi8SAZJwkbEzliQEZHfo2FPQXpS3o3oPmieL
 ez1QNFaROhxOKhdqIjcdBkfUffY3gBL2Oe6as5+JS3/o+hVe2MR6D0hflZ9UITXViWDjQQrMe
 gRlW0H6CC40dlK3WtF4FsksqAjd7M7NQS7Z1EZ6KkRr+T2Hd4c4n7uuSGF+bprFC9PLxBwGBM
 7gex+KUlci8HIdlF68qHaZWWk+FvX+l2NgwokWYkAD7OQHUaMEBZnCg+0trKdyt9i2QNqsuvp
 onVfIAM3Q3YbbC31I59nzYq241MtJrtTGGYGDXHUiRwxAtlCH9dQI7yo/LG9ovsrAcMAwbGY/
 k/BXYepBlgH7IKFqWZ3ADsE8yQkP6pvwsb9vR1VjVFF5t+kFyvg02AyyKc5qjSsvI+G0UE6Q/
 2rzAzj7nk+lB+oYI8xrXye7YvMHXsiLT2yWbMpSVEW7Ht9GcEwrN9WQTzdYaq3et9ZGQxyajY
 ThuUb/RIP56ivl4dSY8DM84cCXiEr2zymWMKLZMCvtfdvHA5Kx3YY9DsYEhK/0yW4I6JC71p5
 tI64LUh9IfkMFE2fyKWIEL1pF8y14L2/BC+qqHIYZhJlqGshs8YHaN6DCOreClNZ2C1xOTj99
 kJujvmzTOjzteecOMRhUE1T73O5aKvhzBpX3yJhPcdDTSBTU1YmEwzHX82G7+kSrbNLqByvq5
 TsyjMTDbEoEokSbH5Pywc4dWvXyUPsd6lNS1fCYDnl2Z/r7VDvtIkkDbR0oyVvI3JkckZPfwI
 lqdh2cxKUIyDFolLE19VZlV44KDXcmEJOIBqFRj+GJc+zdSXy/s0MpPt7hTN8ToY2dMLZQodS
 FTs9/Vv0boWz6TzeU0QzX9Y4vudi1zxvFfcHlUTZnJSBUoZeGxYGoSHfAfotSPS2T6S+vA//C
 yc6ajkRuqOc1AmrVWxyTgASTQpv4xUdEE59HZvT0F31P2KNdYgTs/6ekZpMi7YE0nwgJwHJkM
 fXLdNgiIy/7rOT0txxQs9dxQ9MacoSKPwpcI/2bd7vu9DEOlS1DyeH8EaCISDW95FtngC7YpT
 QiYJukJggpLsvlD1gCqdK2nrqzaT0f0ja+2fBvcPtoRs+ExXpwI5ZojmQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/24 =E4=B8=8B=E5=8D=884:23, Sidong Yang wrote:
> On Sat, Jul 24, 2021 at 03:50:25PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2021/7/24 =E4=B8=8B=E5=8D=883:46, Sidong Yang wrote:
>>> There is some code that using NAME_MAX but it doesn't include header
>>> that is defined. This patch adds a line that includes linux/limits.h
>>> which defines NAME_MAX.
>>
>> I guess it's related to this issue?
>>
>> https://github.com/kdave/btrfs-progs/issues/386
>
> Yeah, It seems that there is no patch for this yet. So I sent this
> patch. Is this too minor patch?

No, I just want to mention you could add tag like the below, so David
can be more aware of the fix.
As when it merged into devel branch, github will automatically mention
it in the issue.

Issue: #386

And it looks good to me, so:

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
>
> Thanks,
> Sidong
>
>>
>> Thanks,
>> Qu
>>
>>>
>>> Signed-off-by: Sidong Yang <realwakka@gmail.com>
>>> ---
>>>    cmds/filesystem-usage.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
>>> index 50d8995e..2a76e29c 100644
>>> --- a/cmds/filesystem-usage.c
>>> +++ b/cmds/filesystem-usage.c
>>> @@ -24,6 +24,7 @@
>>>    #include <stdarg.h>
>>>    #include <getopt.h>
>>>    #include <fcntl.h>
>>> +#include <linux/limits.h>
>>>
>>>    #include "common/utils.h"
>>>    #include "kerncompat.h"
>>>
