Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B645846B181
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 04:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbhLGDdc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Dec 2021 22:33:32 -0500
Received: from mout.gmx.net ([212.227.17.20]:57827 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232168AbhLGDdb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Dec 2021 22:33:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638847801;
        bh=gxXPt1ocetaapKNHCD+KYUnuVlBDBOWU3Fc7/FYyvw8=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=lq/H14hUp9kYKfviwxgRIeeqLjZFZLDdF9yo8Ao3/6x4X+nqdYxwrhxsVnAR/N/ZQ
         c3mJaQgoO7UjsCQ19cFDluDJRw14rddEAfH19RyOOWwCQjLGiwa04BL851RYn7XlBC
         9pYedTE4KfN5ZEmqrdrxuSz1M8+jP6Nca4S0fxBY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MYvY8-1n7aKe08oq-00UoI5; Tue, 07
 Dec 2021 04:30:00 +0100
Message-ID: <b7b6a6a7-700e-f83d-dae6-581ed6befbef@gmx.com>
Date:   Tue, 7 Dec 2021 11:29:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: ENOSPC while df shows 826.93GiB free
Content-Language: en-US
To:     Christoph Anton Mitterer <calestyo@scientia.org>,
        linux-btrfs@vger.kernel.org
References: <f001f3e81d413ea290722c38b14d95f3f1f52249.camel@scientia.org>
 <25d305e5-c75f-3d71-fc5a-c2019e49bed9@gmx.com>
 <c64be50bdc99b993b910a7ab019af8d552eeb0d4.camel@scientia.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <c64be50bdc99b993b910a7ab019af8d552eeb0d4.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8IAtGy3ImOeOS6BRYwWJVB56BAGH1jfjgs8RmEEhjqNFDtEvvUI
 O3QwvtRdQ5rmlAmpXjdNIxmwfEN6YzNy0RuZiAMT+CPEVzPIHUYzwGzZENzopjb+VXcN7/G
 6BGhJPZR5olpC3W66Gjl/warmhRSGQdvvzuDDMWigYfZ9kLW4prqBYpKulesO9vILft9Rsv
 v0Z0+juIP+7LQ+sMHcX5A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z5p3rImx4HQ=:6za/m4FYJtLtoKJwdwqcAS
 a4AzaY3eZUP1t72X0tEJJseaxR+tzw9MDpb+xyN3ZWctWrBFdbagPKG2XSJLF/mARpRAUXm+x
 pJ7DaknogCfKuhSp2pkCIWrlRpuPvBZf2yH2vBTcYKpNVt72DW8HfcWMHrRnJzha5f4CQRAFZ
 crXWXvCskXTpIKtZza5sReDncYarSjpXWtQnn1FhQs2pCRTzz0YaUN1IPWlXJhmcVuWwubImw
 t+/7NaiW1eVyVCty2ym14GZ8WzEzFEC4ak53dmhD4mwAfVdRINftBrfq8IwxK51OJgiGTeK5u
 684KVPaksBS0w5fTrevBGgoRhGxBf3uH8rjIIEI1uwkJ2vxc3HsvOXPJFjhMUxMYo1DIIFu4w
 WQJAeplfLV3z51yHeb+3pfKl9RKcxX67tvuBoN+L9OE/cqaEv69xV7K4outQFH6LF3br3lEVz
 xPG82/GN4GPHUAD9tYgxHtO6/UABuD3ONYpuEsFnBnTsaa3iKJW3zOLfitn2tBOgmNvJMAEXp
 /JBOOM0jRxetE7YlfYsxgd8m0Vv+wzmBwnW784C3iYbEaEmAIbH72RsdBVOawq+1dbieNGuc+
 Q3Pez1ey++AYNUk3DCbEeA89eouCV6bEdMuNDkBQCfvHev4Xv0zgyDHMGJWp+AXvKD1DmCOXD
 2zWULMnrgAyu4jUz81m6kAHpH9CHpXVr2ARRv7VOJYjwyZB5eOtdOqwnF0JNMYx+OrrSwpa9Z
 zYe94TP4Uu5NO7vnqQCA3AfKmg1YIGVvYKgQvqcppdujQeCS287RWj8G8VqxBGNPUNUfxbvbO
 6/Gy2hpkUEgSMw38nxJjdtMp8WseYppzTS6t3c3jWNRhRJPJIgMZyCuSKmTXO2n3nbLmLlzQ9
 ntBFkAXkJCfThYyMxcztTYzutS27lXsUMjCkDXVabcR92uW7yQkxkOI+hwjgNkJqgK2PEGCf1
 P+lSAGfnaRRH3oRthSwvX3yDIzewnOS1ZYjZfWhwZSDojcKg2ypYTrQsKOyuiv17LBY2QisZC
 E2t0myuo5cCOPext/itS3uHZuW7hnRhpzaWGzlMYdkWB3FdR95bCQNhAoqHaeLt2k16s/CsFe
 KTSurPIQ95CXl0=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/12/7 11:06, Christoph Anton Mitterer wrote:
> On Tue, 2021-12-07 at 10:59 +0800, Qu Wenruo wrote:
>>
>> Since your metadata is already full, you may need to delete enough
>> data
>> to free up enough metadata space.
>>
>> The candidates includes small files (mostly inlined files), and large
>> files with checksums.
>
> On that fs, there are rather many large files (800MB - 1.5 GB).
>
> Is there anyway to get (much?) more space reserved for metadata in the
> future respectively on the other existing filesystems that haven't
> deadlocked themselves yet?!

In fact, this is not really a deadlock, only balance is blocked by such
problem.

For other regular operations, you either got ENOSPC just like all other
fses which runs out of space, or do it without problem.

Furthermore, balance in this case is not really the preferred way to
free up space, really freeing up data is the correct way to go.

Thanks,
Qu

>
>
> Thanks,
> Chris.
>
