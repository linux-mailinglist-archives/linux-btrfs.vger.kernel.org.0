Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600FD4FBC19
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Apr 2022 14:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346090AbiDKMc7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Apr 2022 08:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346258AbiDKMcg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Apr 2022 08:32:36 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FD83EAB3
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Apr 2022 05:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649680207;
        bh=I5+6cclsaddFetqW0wbQbOP1P1KeA82QD6vQBPb1W7I=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=d8CGix3v/nl9J4Fq/UcvYBc0x/UrA9aeB75JnRyH7C7ujIGfKK5X4kODK7pHX47lx
         e2YOTX+YMg2fPZgmOPOGIJz2i84zxtAMo0EBqwVsJVvCSpl8ScKKOCJ+r4jsYkqecv
         rorWFYm+ZvAJCIgzFzNu44gAssb1tpgTC/CDoFII=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MIdif-1nhTYm3olZ-00EbIo; Mon, 11
 Apr 2022 14:30:06 +0200
Message-ID: <19c5dc85-7591-14d1-b298-783180b86352@gmx.com>
Date:   Mon, 11 Apr 2022 20:29:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 4/4] btrfs: make submit_one_bio() to return void
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1649657016.git.wqu@suse.com>
 <e4bb98b5884a77114ef0334dee6677e6e6260ea7.1649657016.git.wqu@suse.com>
 <YlPWXw+cWtMG0kE8@infradead.org>
 <32af072b-ab06-9a89-ad6b-0503106cef94@suse.com>
 <YlQb9pH6dQ1zL8ix@infradead.org> <YlQdvFjBq8ESu3Yz@kroah.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <YlQdvFjBq8ESu3Yz@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I8fBXPpRUIVAIxVonOdEBKWemCTWLln1KnlW0N2Ck6HpyqCij/i
 iyjUJ3jc+OEpHHAd9WPu23R85eFhNS0VaWQYKcGzbadxMxEjw07N5t5fPnV0oGoDaZmFAsQ
 LHjVC5H27f5GRlZWQLKZoE7Sh8bqwy0jUARDIYCV/TM5sAH8cevQoFFxwH9g9yLBeMASqno
 SQocxkq+Br3hqDTUVUsyA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aipoKxEneiA=:K19QWGQ1WKu6/DzWJorQC4
 NS/4TB0WoM7ACtI0YMtp4ivxrXFjqBJtIOKzeDLULkYwG9SpXBYfBodLKLPvHyONveGpVMb3a
 AmRx5y8cslOeT2Tsq5OjhAIsDOzzfO+Z54jnp5he2BR8uN9EYc6EhK+bcBzEBN0Ku65sO0gzm
 vBY+0O0JYKujzjAz3jq1EjFObKjuYDL+Gw1Du2lqMj9FtU0KCKOu4+zSWMkcjkAQmVklfDbcG
 HSv6PsCJWZyVWhnNvUUtJ4S0+GpUuuRP/rOJotKS0Tx17/m4il0m61d5+1M8TC2YJY8ejtHd5
 lNVOebD+J4Udha9HImcCuClDQKS7qgIr/kMg3m3od9vaXv6KV1YfbfJ/8pEWCSIJKf9t3WywC
 1OBy+LLC/eJJs0Pkg6p0GTJCg6DDouShCKcFWXpaCUfT78C5PRCIBxJfMkz2Ddv5QVfBOVvo1
 wfHIxvONXehBOo3k2pDWKa6wS4sKwLY9GSMvpsIRYT7upWuFzTJMB4tB2As4POMUUmEkd2GV7
 lBk+Dpg5xVlVilqbiXhKjBHSVZTePNX1RL4ynQ7lP8NXsJES0tgBbM0OkpGxA0+hGFQcYASIZ
 Fnmj54MREy6q+bDzFv/Cb0cSrwsZWf1bTEqdhR1vCXrL71WIXoWsXmUQAGIQlPt9q2DmeuPEi
 iXVku9aDunLiwYH1A8ENvQAY2UvLgyJq9yIUZmFkpu7ko+jonvs78RJPW6ujUy/A1szYkIA13
 fhVE6yAVzfJB+Isxrg3CoGz1pOzZ6TzjVDqTcwUEE8bJjmukhddjwnf2uORSjuFUuz/XTtcqQ
 klJbKp0iGbEwKdyk8Wmo2CVuB9J3rBvxm1TqHiZwC93GmNSvxuBJFYlB+C/8ebtxZg6elpLem
 iNvfn/z0kTfs6Io/VXDMe4OQKju0EqYk9BqXM2xk/gw5sK2Ps47tcDUWDIRrO7Uxnj4t2pOQU
 MfvNuBOwNmYD4BcXNWvh1CMxaA7+3EAoC4jiXgPMZ6KDYUI+AI3b1AwRXtStJ/7yR1rLGB4D8
 rdAmFZpDEuAPEVm8v0jiZoCk8663E1q5PmGwODlvPRzcjKEFURIsvnOEBBC7A5DOBTk2NY+xv
 qd54iw8zow9ydc=
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/11 20:23, Greg KH wrote:
> On Mon, Apr 11, 2022 at 05:15:50AM -0700, Christoph Hellwig wrote:
>> On Mon, Apr 11, 2022 at 03:20:47PM +0800, Qu Wenruo wrote:
>>>> This really should go into patch 1.
>>>>
>>> Stable tree won't be happy about the size.
>>
>> Really?  I've never really seen stable maintainers complain about
>> the size of a patch.  Especially if it is almost 100% removal of buggy
>> code.
>
> That sounds like a great patch to take for stable kernels :)

OK, I'll merge patch 1 and patch 4 in this case.

Thanks,
Qu
