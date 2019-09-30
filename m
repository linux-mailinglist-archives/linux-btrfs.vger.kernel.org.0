Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42F70C28C7
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2019 23:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732166AbfI3V0H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Sep 2019 17:26:07 -0400
Received: from forward102j.mail.yandex.net ([5.45.198.243]:55952 "EHLO
        forward102j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732210AbfI3V0H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Sep 2019 17:26:07 -0400
Received: from mxback27o.mail.yandex.net (mxback27o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::78])
        by forward102j.mail.yandex.net (Yandex) with ESMTP id 9E402F20C49;
        Tue,  1 Oct 2019 00:26:04 +0300 (MSK)
Received: from myt5-7474ca8e6aca.qloud-c.yandex.net (myt5-7474ca8e6aca.qloud-c.yandex.net [2a02:6b8:c12:1d21:0:640:7474:ca8e])
        by mxback27o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id NaCdOmBsHe-Q4CW3I25;
        Tue, 01 Oct 2019 00:26:04 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1569878764;
        bh=Dx4SzCwoTNLlt7P/eGx79lTD0IJlULAc0E+rrFXXJ4Y=;
        h=In-Reply-To:From:Date:References:To:Subject:Message-ID;
        b=ScCMgIf3WoBwu5QUGvswgXOzjNtjm1E55iqHoOK5Y4qbrgoHBx5hdRoth5kR5rTCt
         bIDR3aTC1/7Cf54k71DZvSXHg0I82e3DxonPgsY9N6nMMtqZZ7pcyjhbNoaiaFStK3
         QyqurN1IYjLVOdAXAdSxNeAyb+uX9ASlUp65WqVY=
Authentication-Results: mxback27o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt5-7474ca8e6aca.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id Ksbqdz7aMa-Q4IKcKO9;
        Tue, 01 Oct 2019 00:26:04 +0300
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
 <fb259ee2-c9e2-f44d-ce5b-b3f688565c28@yandex.ru>
 <bf5265b7-96a1-5f98-07f8-947b981ac364@gmx.com>
 <245b13f7-20c9-3ab4-6e9f-0ed32f4d1c79@gmx.com>
 <27515deb-5225-4349-2406-132b5190f7cb@yandex.ru>
 <84e7ff9e-9c47-41c5-8457-bba4d9ec1f86@gmx.com>
From:   Andrey Ivanov <andrey-ivanov-ml@yandex.ru>
Message-ID: <86293d43-390e-83fb-6d8e-42e0313d52c5@yandex.ru>
Date:   Tue, 1 Oct 2019 00:26:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <84e7ff9e-9c47-41c5-8457-bba4d9ec1f86@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: ru-RU
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 30.09.2019 15:27, Qu Wenruo wrote:
>>> We have another report internally about a similar corruption (multiple
>>> bit flips in a single fs), and they are also using VMware, along with
>>> VMware guest kernel modules.
>>>
>>> Would you mind to migrate to KVM based hypervisor to see if the
>>> corruption happens again?
>>
>> I had this problem with btrfs after more than a year of using btrfs and
>> vmware.
> 
> So it looks like some regression, although still not sure who is to blame.

One more clarification. I had this problem with btrfs after switching from
linux-4.19.52-gentoo kernel to linux-4.19.66-gentoo.
