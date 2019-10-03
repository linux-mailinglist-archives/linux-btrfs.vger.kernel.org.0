Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 789BFC96DC
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2019 05:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbfJCDHy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Oct 2019 23:07:54 -0400
Received: from forward100o.mail.yandex.net ([37.140.190.180]:49348 "EHLO
        forward100o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725860AbfJCDHy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Oct 2019 23:07:54 -0400
Received: from mxback8j.mail.yandex.net (mxback8j.mail.yandex.net [IPv6:2a02:6b8:0:1619::111])
        by forward100o.mail.yandex.net (Yandex) with ESMTP id 236404AC0A69;
        Thu,  3 Oct 2019 06:07:51 +0300 (MSK)
Received: from iva4-994a9845f60e.qloud-c.yandex.net (iva4-994a9845f60e.qloud-c.yandex.net [2a02:6b8:c0c:152e:0:640:994a:9845])
        by mxback8j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 2FVSsUK6a0-7og8jsd1;
        Thu, 03 Oct 2019 06:07:51 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1570072071;
        bh=WRNzM9tSYmVZJEQCbUdAKS2sJPkdnLjMvBiy/0yoS4Q=;
        h=In-Reply-To:From:Date:References:To:Subject:Message-ID;
        b=FCVoVR3RcHlmaOos7HpK+ibdbQopOBvwwSKcGS5FJ9qbMFJVCfY3ao/sJJhvbffMy
         RAWk1xZSgYV2zmspefi1hAdYxED7ecutwp5L7s1C/ocDtdWcqnUk6J/ZifscoOEeo4
         ypejonA0M/8hoe+2bi808Ldj+OY7vXj30L2fh5Uw=
Authentication-Results: mxback8j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by iva4-994a9845f60e.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id 0gEG87IsCO-7oqKKk24;
        Thu, 03 Oct 2019 06:07:50 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: Btrfs partition mount error
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <79466812-e999-32d8-ce20-0589fb64a433@yandex.ru>
 <85cb7aff-5fa4-c7f7-c277-04069954d7fe@gmx.com>
 <170d6f2f-65aa-3437-be21-61ac8499460b@yandex.ru>
 <4be73e38-c8b1-8220-1e5a-c0a1287df61d@gmx.com>
 <b0ec0862-e08c-677d-8bf4-8a87b74c1ec2@yandex.ru>
 <54a2e030-3b8f-6680-a1b6-826c2f5c0928@gmx.com>
 <d7a9650c-db8f-34db-fb7c-c1ba55159c93@yandex.ru>
 <a6f68cf9-20b9-f1bf-379a-a361c4387dc7@gmx.com>
 <0ecf3dc2-c884-7c08-5f11-86e1b1d2f631@yandex.ru>
 <8863e0a1-adb5-81d9-e15a-9dedda00f4bc@gmx.com>
From:   Andrey Ivanov <andrey-ivanov-ml@yandex.ru>
Message-ID: <1f7b1930-bd28-0d3c-c46e-b11618a2629d@yandex.ru>
Date:   Thu, 3 Oct 2019 06:07:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8863e0a1-adb5-81d9-e15a-9dedda00f4bc@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: ru-RU
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 03.10.2019 5:19, Qu Wenruo wrote:
> The problem is the invalid dir item size caused by that bitflip.
> 
> I'm afraid there are too many unexpected bitflips.
> 
> But at least you can try to salvage some data.

As I can see, there is only one damaged directory, which did not
contain any important data. All other data in the partition is intact.
Partition is perfectly mounts.

Will I be able to fix the disk errors if I create a new btrfs partition
and copy all the contents of the old partition to it?
