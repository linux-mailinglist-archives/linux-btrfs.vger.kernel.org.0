Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A63FCF44E5
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Nov 2019 11:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731524AbfKHKpf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Nov 2019 05:45:35 -0500
Received: from mout.gmx.net ([212.227.15.18]:40497 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730224AbfKHKpf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 8 Nov 2019 05:45:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573209933;
        bh=WLurTD1sWiB6qSHaZlDyEaVjbkjATYHfOyoUr2Ngtmo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=b5/Mz9CgovXLIdxUisNEBj8ldEKbZCKcYaxW1AWkUqN29y6aVQlLDigUGeYKETxP8
         rODKZWEMsUDaeXeM/qc6RY86HByYt7EIcX6qv3oas6DrcKDQGPmZJ7jWi/c9Jg4+CD
         tqxBCWMdft6ODZEKnYw/EaFc+C0xfPH4NJ3DbFz8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.164] ([34.92.246.95]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N0FxV-1hfstf217n-00xJks; Fri, 08
 Nov 2019 11:45:33 +0100
Subject: Re: [BUG report] KASAN: null-ptr-deref in btrfs_sync_log
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <dd9f22ee-e73c-7476-82d1-45a10d1f16f9@gmx.com>
 <cbd13dd4-a844-5a4f-59b0-ec672280e0b3@suse.de>
From:   Su Yue <Damenly_Su@gmx.com>
Message-ID: <8b8594e9-3523-9a83-3900-001f95a0850d@gmx.com>
Date:   Fri, 8 Nov 2019 18:45:24 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:71.0)
 Gecko/20100101 Thunderbird/71.0
MIME-Version: 1.0
In-Reply-To: <cbd13dd4-a844-5a4f-59b0-ec672280e0b3@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UhTf/F+R/uyVVupSdFBBocvMmNAaGdzHbyDYtoewtWg8i11UHzZ
 sPCKSz1Y/tVfC/hSuo7ukIcWEvPLfOIpBbzewgEzdOM8m4BXbhQGIGcux6ZVPFYiFPBy1lf
 5rWWXuBDm0VKjBa5OzyS2Y+o8SH5vYSx4rf7TdaasyuSyo1MKBtGrtU4rxmUZ0AS1R9eqdD
 g//aaW+crzgotED58nbNw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:R7fxfsDEQkw=:N3kmW9I71xUXIEnk4XGceK
 l5jLQZ+9HOgQE2bp7Xza4kQClqXjjmUoKDcYoGSj4d1AkdPH3rOYSaaK/BdFvAon1D2iDgxqa
 2CG5sQ0CSZfKhUj0m7kxagfkpdjOEpPSJnb41RLOPfAs4D9bycAxhD3Kzzo6LVCkEIOzU9WUs
 /cgpqAbH0ePdxH7e5yhQnZfB61by+oH5RCk1wV5SDcfYZFzn2z1Fl36NOf3zy73kTXu6xqEMs
 c4bc0mVSqp0uczO9pMQb2TuEFzrp1iy04KfWq5PiERp6DPF4RFqSn1dpuI8cufW9eFjY4Uyst
 5l0fZK2zb7NiSzv3MVqekTPuhZ9n64gzWiIZhIfGHUuE7pWwT0siu8IQarAWQ/28zNwBDbSI7
 fLtO6XJLZ7SzaAvbu4gmQOWjs6X1wRahKvrpB6lWhnioNs8uhMfzBF6tBQYnKrDencdlruKqe
 NMRrYvuQG1ulPQGcTaUQ1xNGohY+0plpkBveI8bYGJCY/oaXta7qFtMyGPjAftwU+re6PKfZA
 8xwPAZ2PBoXY10ODegWKYpZK1rorTLhgaa1fZKJUOG9hsCyp1IKpNy6RsrFGt9wrautrITkWS
 RBL36OntYVUl3vyWZALkmWEieDwXkYgEqUo6fPGskkPoxemgZCaVkMi2caOF2RX5JaP/oTE7U
 vzqve+zLElWIL90p9sS+uZOhLy3nZAx3hqReGlrzXdGaO/joz6kr42YEjoEp96++aedozPFEC
 ipbpWnSqjup8jU1ORaj7oOFQ7Up0Q24k3XbhDTDly234EVVGde4mAP/t2rLd08qRFR9rb2BO1
 wSqj4vHdLwqAr+DKH2E83eZcymONqTUSWgbpO7q5/ChKoSMN0lqJcE029Ae7oTDTblCKc8ED5
 ZY1Ylkoy76QFIX0y6nVl5MHoE8cOYynsRA6EMSUuAFx60QPsnFnukP2uCjqOmAWviyhyjH79H
 CHuJva72PJWiseIjf5U64MZxnvGpJFaH+qVcQgya7/YyVG8hpSlaByofvcF9aXXmsFXqyMmn6
 9bJikwvZXLK7bH+p83998rccLz/3vs02YAqOsNJhexnAjnNtbmxNQnsdxpGMXfFR5dE2p1t+l
 7iJhZdd7BB0Ib0yiLiV0w2ljd5Qgl74SkQUENwlzlpfsR+OfoeJ9iheM/je1QKzU5RzwWoDt6
 RkCHH7oUC+1zCXTiYcSzWsC6wNyRKB5UARPcciFljTRjOuq0X3QVrDweyaYGZGkOaHqJjh8Zw
 8cOvboTmdp1sTw8YW8/iO9ANfJ/sN5BQwK1wpozKczVzGbMOH1NZ/Av22XVI=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/11/8 6:37 PM, Johannes Thumshirn wrote:
> On 08/11/2019 06:21, Su Yue wrote:
>> Hi,
>>
>> While running xfstests/btrfs/004 and btrfs/067 whith KASAN enabled
>> on v5.4-rc6, KASAN reports following BUG(btrfs/004):
>
> Hi Su,
>
> Is this on Linus' v5.4-rc6 or David's misc-next branch based on Linus' r=
c6?
>
It's v5.4-rc6 on Linus's tree.

Thanks.
> I cannot reproduce it on the latter (tried a loop of 50 btrfs/004 runs).
>
> Thanks,
> 	Johannes
>
