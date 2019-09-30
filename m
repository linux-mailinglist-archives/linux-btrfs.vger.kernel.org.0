Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39F2CC1EDE
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2019 12:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730595AbfI3KYC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Sep 2019 06:24:02 -0400
Received: from forward103j.mail.yandex.net ([5.45.198.246]:59350 "EHLO
        forward103j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730419AbfI3KYB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Sep 2019 06:24:01 -0400
Received: from forward102q.mail.yandex.net (forward102q.mail.yandex.net [IPv6:2a02:6b8:c0e:1ba:0:640:516:4e7d])
        by forward103j.mail.yandex.net (Yandex) with ESMTP id A33AC674124D;
        Mon, 30 Sep 2019 13:23:58 +0300 (MSK)
Received: from mxback12q.mail.yandex.net (mxback12q.mail.yandex.net [IPv6:2a02:6b8:c0e:1b3:0:640:3818:d096])
        by forward102q.mail.yandex.net (Yandex) with ESMTP id 9F2F07F20016;
        Mon, 30 Sep 2019 13:23:58 +0300 (MSK)
Received: from vla1-f6c1f80fae19.qloud-c.yandex.net (vla1-f6c1f80fae19.qloud-c.yandex.net [2a02:6b8:c0d:d87:0:640:f6c1:f80f])
        by mxback12q.mail.yandex.net (nwsmtp/Yandex) with ESMTP id lGqTXCUwg8-Nw4OZuxg;
        Mon, 30 Sep 2019 13:23:58 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1569839038;
        bh=6wY+4Mwu7d+icnvSzS701ByVMFMQ7IrwZOfVfXI+6Fs=;
        h=In-Reply-To:From:Date:References:To:Subject:Message-ID;
        b=N1tvQvBvLYHIwPYwwT4dySFJoaXirJQEn+PHe37xdA8V6Xf5f8B9FARcPhbLUKhTq
         X2E5LWuWd1H5bGBqlFLER26rOftmjLpZtw6KlRBpqLfCZ0nOaSlLUFjbFUZ/KHmMQs
         9mN0q898K7N/prDvreKoDdaDehzkMn//LnXO2wJo=
Authentication-Results: mxback12q.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla1-f6c1f80fae19.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id UTwr5aIjh5-NvpaBFMM;
        Mon, 30 Sep 2019 13:23:57 +0300
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
 <e5383397-3556-1c9c-7483-79ad6d74de49@yandex.ru>
 <c9d71bdd-7fe2-faaf-23c0-ede163c1d04a@gmx.com>
 <c3ecfeb9-2900-3406-4d92-e40021753310@yandex.ru>
 <1ca0434b-3ae6-bbbe-efd3-06cab9089782@gmx.com>
From:   Andrey Ivanov <andrey-ivanov-ml@yandex.ru>
Message-ID: <fb259ee2-c9e2-f44d-ce5b-b3f688565c28@yandex.ru>
Date:   Mon, 30 Sep 2019 13:23:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1ca0434b-3ae6-bbbe-efd3-06cab9089782@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: ru-RU
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 30.09.2019 13:10, Qu Wenruo wrote:
>> I had built and run it:
>>
>> # /home/andrey/devel/src/btrfs/btrfs-progs-dirty_fix/btrfs-corrupt-block
>> -X /dev/sdc1
>> incorrect offsets 15223 15287
>> Open ctree failed
> 
> That branch updated to skip the item offset check completely.
> 
> But please keep in mind that, that check itself still makes sense, so
> please use the original "btrfs check" to check the fs.

# /home/andrey/devel/src/btrfs/btrfs-progs-dirty_fix/btrfs-corrupt-block -X /dev/sdc1
key (613019873280 EXTENT_ITEM 1048576)slot end outside of leaf 1073755934 > 16283
Open ctree failed

# btrfs check /dev/sdc1
Opening filesystem to check...
incorrect offsets 15223 15287
ERROR: cannot open file system
