Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A897C1C82
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2019 10:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbfI3IFv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Sep 2019 04:05:51 -0400
Received: from forward103j.mail.yandex.net ([5.45.198.246]:37168 "EHLO
        forward103j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725767AbfI3IFu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Sep 2019 04:05:50 -0400
X-Greylist: delayed 341 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Sep 2019 04:05:49 EDT
Received: from forward102q.mail.yandex.net (forward102q.mail.yandex.net [IPv6:2a02:6b8:c0e:1ba:0:640:516:4e7d])
        by forward103j.mail.yandex.net (Yandex) with ESMTP id 8555F674104F;
        Mon, 30 Sep 2019 11:00:06 +0300 (MSK)
Received: from mxback12q.mail.yandex.net (mxback12q.mail.yandex.net [IPv6:2a02:6b8:c0e:1b3:0:640:3818:d096])
        by forward102q.mail.yandex.net (Yandex) with ESMTP id 8076D7F20010;
        Mon, 30 Sep 2019 11:00:06 +0300 (MSK)
Received: from vla1-5ff4bc6b92b2.qloud-c.yandex.net (vla1-5ff4bc6b92b2.qloud-c.yandex.net [2a02:6b8:c0d:4201:0:640:5ff4:bc6b])
        by mxback12q.mail.yandex.net (nwsmtp/Yandex) with ESMTP id A4VyjP6NcD-064efQxH;
        Mon, 30 Sep 2019 11:00:06 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1569830406;
        bh=TmLPnMRu0Q/UC6v5IXZTRJ5O6CifAPy45O58XAkfpok=;
        h=In-Reply-To:From:Date:References:To:Subject:Message-ID;
        b=DvqiJ0Xl8E+SWBdS9PKyAElztH/RDWRlHYbEQV8psL4iGKuujpyBoDweItJjMKDjw
         5noUqJpWIYr43JxN93ciOVlKg4icym4XYXxiSyV3OGsF0v2EmJSdSF/j10tMwDLbQ2
         eNYBZ0O6MglbMmwqzWOKuvdvy/c9RW6FYdy53amc=
Authentication-Results: mxback12q.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla1-5ff4bc6b92b2.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id I8Y1UQk1vC-05HmLqVv;
        Mon, 30 Sep 2019 11:00:05 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: Btrfs partition mount error
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <79466812-e999-32d8-ce20-0589fb64a433@yandex.ru>
 <85cb7aff-5fa4-c7f7-c277-04069954d7fe@gmx.com>
 <170d6f2f-65aa-3437-be21-61ac8499460b@yandex.ru>
 <4be73e38-c8b1-8220-1e5a-c0a1287df61d@gmx.com>
 <31560d49-0d03-1e26-bb55-755a4365dce7@yandex.ru>
 <70eaf85f-751a-f540-7fde-bb489a0bb528@gmx.com>
From:   Andrey Ivanov <andrey-ivanov-ml@yandex.ru>
Message-ID: <e5383397-3556-1c9c-7483-79ad6d74de49@yandex.ru>
Date:   Mon, 30 Sep 2019 11:00:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <70eaf85f-751a-f540-7fde-bb489a0bb528@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: ru-RU
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 30.09.2019 10:31, Qu Wenruo wrote:
> For this one, I could help you by just reverting that bit, and then you
> may be able to continue mounting the fs or at least run btrfs check on it.
> 
> Please prepare an environment to compile btrfs-progs (at least
> btrfs-corrupt-block) if you want to try.

Great, I'm ready to do it. Environment is ready.


>> I did a memtest earlier. All had passed without errors. I can do a
>> memtest again,
>> but it seems to me that if the memory was faulty, the system would not
>> be stable
>> and often hung, but the system works fine.
> 
> Indeed, especially considering that there are already two bitflips in
> one leaf, which should be pretty rare.
> 
> Any out-of-tree kernel modules? 

I only have vmware out-of-tree kernel modules.


> Or would you like to try v5.2.15 kernel,
> which has a self detection for such problem.

If I understand correctly, if I install v5.2.15 or later kernel
then I'll fix my /dev/sda4?
