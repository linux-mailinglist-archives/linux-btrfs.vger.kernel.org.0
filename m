Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD2633D48D
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Mar 2021 14:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234533AbhCPNEb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Mar 2021 09:04:31 -0400
Received: from mout.gmx.net ([212.227.15.19]:48701 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234531AbhCPNEF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Mar 2021 09:04:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615899827;
        bh=6Ljz1YMg4H97ZSl5F+UH0jbR/Y9UFnqXxIyh3FEhmys=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=amoqaSa/9CQ3WAn+/RWBvO4DnOyyu3rq9oxBx2yJdUOd0JOr/Sn6YOOTgjHYsE+39
         UL/iDU93SAVSAWCkzbI1LVoKUSMWROwK1SRFXBH/IzK4cmUIkrRMqULP1SsXHJxPq/
         KP4A0//dgP42pX0rIPihhpkxmbkSwYlaO1+XKy6o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MJE2D-1l7diT3911-00Kjzb; Tue, 16
 Mar 2021 14:03:47 +0100
Subject: Re: [PATCH] btrfs-progs: common: make sure that qgroup id is in range
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.cz
References: <20210315155638.18861-1-realwakka@gmail.com>
 <2c58bf6a-d13c-2628-bfa5-c122b7ad73a6@gmx.com>
 <20210316125805.GA19669@realwakka>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <b5806abc-69fc-4eb5-f88e-936f5565793d@gmx.com>
Date:   Tue, 16 Mar 2021 21:03:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210316125805.GA19669@realwakka>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tKeNM15swkOqAdIUopem1jjbwFSQxmrUaV1K42kRDIxFn7L66Yd
 eeHhmLKh/uDv5k855udAflPXEBE4WvjhjeMcFjBkhO9gVuT9XZnSUAUPGqmC8Ck5Whh8nv+
 OOw5BVx0bx/zKGeZ6X13KWtpZY9cRc0Y8CKDL7LgNrfKL3GNji7/6Qh6CDIUm+3KuWdMX5+
 DJOJYIuNv7DdBWoswIjww==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zAjhANHZwnE=:sB6pSfuLvT2U2Sjl6pP/cl
 /jbKytINgxXWXcETzJKgDNqtYX0J1uaNZrUyRnquGFeeLmaphQZk3L6IXJDaCXxQKxb2aGkDD
 1Zmk/WknQBJw/nl2/T6G62+ViAUdz4IoEYbfw1Lf3/4EkQT85g8lG7mi4hZWyIcRYkLCxErI5
 D7MvwmhD7ybEbY++nAFIgUHaNYyxClXr7nW3gzd51E95iCpHGqGop2h5yf/Sdpi/5ai1HwuG7
 aU42HJeR5t2Srncz+rwN/zDzryUVzfP8TUTx0ZFRYVgyUxmYVMRZtJo9CXhrg9AFsEuQ26bD0
 qd614YRwfSDvwYiNIwr5HcJ1wN3CNdu2ojFjcTfWfmjP0m5t0F+lVkcxQassrmeUKUNpK1FE1
 DyRlAGrQcQi5uUy+8WF9HQBwjbT4e+3hJm4qJ/hf0oTdy0aUdZmLPFhDtq+omuAvUFCcT8xiJ
 rm1kwi70S19jgQiP12rGE8KnGmNdQlkEbpesbtoI0tKM5wPEWEVaiKAanqTZ/TNZCQJPXNlQI
 ViWzRhix5VdT9xVQPteR4UDaSOjZqls5Le1j0AEU1Kf0nagfi3psj+MZ9bO6tE+ve5z5hLUVK
 cZarfAb10zCWHk+ocq3o9qP5EJ7nxW3KYMC7czMPaSkIUU+LlMGC1GzrTsChLGr0Qe4kcBZOb
 5leJBvdiEc02n+USwAiCT7FK0WKYupXdBm/hBF1WNXOItSuAK+vLcWhawcl01NqP1AOkdDScB
 712GKeAOwv2ZDwnYAOlEO3o4vjtFfmMqMTGXeE9pMHBq2Kzh8RBR8PpQ3AuQjhGlfzookukFX
 cfPsoYgasG895Z0xuN22JHDihG+Pv17ygUV4mZsTq739yxjSTlueBIlEIh8+Pvvs3v2+okHhg
 k6vhI+f5gB/TihAH7n2g==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/3/16 =E4=B8=8B=E5=8D=888:58, Sidong Yang wrote:
> On Tue, Mar 16, 2021 at 01:44:33PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2021/3/15 =E4=B8=8B=E5=8D=8811:56, Sidong Yang wrote:
>>> When user assign qgroup with qgroup id that is too big to exceeds
>>> range and invade level value, and it works without any error. but
>>> this action would be make undefined error. this code make sure that
>>> qgroup id doesn't exceed range(0 ~ 2^48-1).
>>>
>>> Signed-off-by: Sidong Yang <realwakka@gmail.com>
>>
>> Shouldn't the check also happen inside the ioctl?
>
> Yes, I checked the ioctl code in kernel. but there is only the code that
> check if it is zero like !sa->qgroupid. and it just assign to
> key.offset. Also it should be checked in ioctl?
After more check, the ioctl interface doesn't need that check, or user
can't parse any qgroup with higher qgroup level.

Thus the check should only exist in user space to avoid case like
1/(U48_MAX + 1).

Thanks,
Qu

>
>>
>> Thanks,
>> Qu
>>> ---
>>>    common/utils.c | 5 +++++
>>>    1 file changed, 5 insertions(+)
>>>
>>> diff --git a/common/utils.c b/common/utils.c
>>> index 57e41432..a2f72550 100644
>>> --- a/common/utils.c
>>> +++ b/common/utils.c
>>> @@ -727,6 +727,8 @@ u64 parse_qgroupid(const char *p)
>>>    		id =3D strtoull(p, &ptr_parse_end, 10);
>>>    		if (ptr_parse_end !=3D ptr_src_end)
>>>    			goto path;
>>> +		if (id >> BTRFS_QGROUP_LEVEL_SHIFT)
>>> +			goto err;
>>>    		return id;
>>>    	}
>>>    	level =3D strtoull(p, &ptr_parse_end, 10);
>>> @@ -734,6 +736,9 @@ u64 parse_qgroupid(const char *p)
>>>    		goto path;
>>>
>>>    	id =3D strtoull(s + 1, &ptr_parse_end, 10);
>>> +	if (id >> BTRFS_QGROUP_LEVEL_SHIFT)
>>> +		goto err;
>>> +
>>>    	if (ptr_parse_end !=3D ptr_src_end)
>>>    		goto  path;
>>>
>>>
