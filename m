Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5875C1E92
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2019 12:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfI3KBh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Sep 2019 06:01:37 -0400
Received: from forward106p.mail.yandex.net ([77.88.28.109]:58543 "EHLO
        forward106p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727025AbfI3KBh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Sep 2019 06:01:37 -0400
Received: from mxback9o.mail.yandex.net (mxback9o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::23])
        by forward106p.mail.yandex.net (Yandex) with ESMTP id 026AC1C80BA1;
        Mon, 30 Sep 2019 13:01:35 +0300 (MSK)
Received: from sas2-b0ca3cd64eaa.qloud-c.yandex.net (sas2-b0ca3cd64eaa.qloud-c.yandex.net [2a02:6b8:c14:718c:0:640:b0ca:3cd6])
        by mxback9o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id tNgu8tL0nD-1Y80Mtlm;
        Mon, 30 Sep 2019 13:01:34 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1569837694;
        bh=Bt9iYSCEmFxY/xLyFPuf2Wy2QUcJrXV3bXsb6RuQ1uE=;
        h=In-Reply-To:From:Date:References:To:Subject:Message-ID;
        b=Y3Y4LdcLDyiQpNxtHHvsGlB80vJzoFRqZu/yJyaQOBEfsLtAjKo7loHTtt4lJ63ew
         8y9UipVBtqQ5x90rPhDKd49jcYZw9UgBLPlnYpHxJcD/5HPdzq9OsWjJEFeXDNplqq
         Ku6v7+bis3pTEjJpc4fHXFGBbJP6kRdzDn+lU1H8=
Authentication-Results: mxback9o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by sas2-b0ca3cd64eaa.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id cMXKtumkFs-1YIq2euQ;
        Mon, 30 Sep 2019 13:01:34 +0300
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
From:   Andrey Ivanov <andrey-ivanov-ml@yandex.ru>
Message-ID: <c3ecfeb9-2900-3406-4d92-e40021753310@yandex.ru>
Date:   Mon, 30 Sep 2019 13:01:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c9d71bdd-7fe2-faaf-23c0-ede163c1d04a@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: ru-RU
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 30.09.2019 11:59, Qu Wenruo wrote:
>>> Please prepare an environment to compile btrfs-progs (at least
>>> btrfs-corrupt-block) if you want to try.
>>
>> Great, I'm ready to do it. Environment is ready.
> 
> Here it is.
> 
> https://github.com/adam900710/btrfs-progs/tree/dirty_fix
> 
> To use it:
> 
> $ ./btrfs-corrupt-block -X /dev/sdc1

I had built and run it:

# /home/andrey/devel/src/btrfs/btrfs-progs-dirty_fix/btrfs-corrupt-block -X /dev/sdc1
incorrect offsets 15223 15287
Open ctree failed
