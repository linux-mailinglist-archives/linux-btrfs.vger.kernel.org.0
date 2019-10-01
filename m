Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D250FC2CBA
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2019 06:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfJAE43 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Oct 2019 00:56:29 -0400
Received: from forward106p.mail.yandex.net ([77.88.28.109]:49235 "EHLO
        forward106p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725535AbfJAE43 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 1 Oct 2019 00:56:29 -0400
Received: from mxback1j.mail.yandex.net (mxback1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::10a])
        by forward106p.mail.yandex.net (Yandex) with ESMTP id E7DE31C815DD;
        Tue,  1 Oct 2019 07:56:24 +0300 (MSK)
Received: from sas2-44d129ed7200.qloud-c.yandex.net (sas2-44d129ed7200.qloud-c.yandex.net [2a02:6b8:c08:ff0a:0:640:44d1:29ed])
        by mxback1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id TXb5uCju7U-uOVG2c19;
        Tue, 01 Oct 2019 07:56:24 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1569905784;
        bh=Njj1ZlnCh95Ivbh/z57CHzXkOVQUfyBf4wfg4SHI0OA=;
        h=In-Reply-To:To:Subject:From:Date:References:Message-ID;
        b=BZNdGkqR70k9gMhhR3wFRxc4j0NEXjDdVARfS2qOrADZ7t664P02Iajd3mwDV+ujL
         h0wUxMy0BcNJ/Onn0SGr4HwWW3TU+oAzRb2cEpvAMB+cAoSN1bnXAtbQf6MpWbjcwQ
         4dzXFhkte7th3V9isOt8JYOtBDRcDwe2O7OQYgX8=
Authentication-Results: mxback1j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by sas2-44d129ed7200.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id Rl0SKB8Wmo-uOH4cjS3;
        Tue, 01 Oct 2019 07:56:24 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Andrey Ivanov <andrey-ivanov-ml@yandex.ru>
Subject: Re: Btrfs partition mount error
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <79466812-e999-32d8-ce20-0589fb64a433@yandex.ru>
 <85cb7aff-5fa4-c7f7-c277-04069954d7fe@gmx.com>
 <170d6f2f-65aa-3437-be21-61ac8499460b@yandex.ru>
 <4be73e38-c8b1-8220-1e5a-c0a1287df61d@gmx.com>
 <31560d49-0d03-1e26-bb55-755a4365dce7@yandex.ru>
 <70eaf85f-751a-f540-7fde-bb489a0bb528@gmx.com>
Message-ID: <42227b4a-d905-bc68-5cdd-88fa98699b83@yandex.ru>
Date:   Tue, 1 Oct 2019 07:56:23 +0300
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
>>> Please provide the following dump:
>>>
>>> # btrfs ins dump-tree -b 855738744832 /dev/sdc1
>>
>> attached btrfs-ins-dump-tree-855738744832-sdc1.output
> 
> OK, tree-checker is again detecting the problem correctly.
> 
> 	item 19 key (613039370240 EXTENT_ITEM 1048576) itemoff 15223 itemsize 53
> 		refs 1 gen 52116 flags DATA
> 		extent data backref root FS_TREE objectid 5841996 offset 607125504 count 1
> 	item 20 key (613040418816 EXTENT_ITEM 1032192) itemoff 15170 itemsize 117
> 		refs 1 gen 52162 flags DATA
> 		extent data backref root FS_TREE objectid 5842000 offset 927858688 count 1
> 
> Item 20 should be a regular single reference, but its size is 117.
> But please check this:
> 
> 117 = 0x75
> 53  = 0x35
> 
> The difference is 0x40, which is a single bit.
> 
> And if itemsize for slot 20 is regular 53, then it matches its neighbors
> without any problem.
> 
> So at least to me, this looks like a bitflip.
> Although I'm not sure if it's btrfs itself causing the problem or it's
> the hardware or even 3rd party kernel modules to blame.

I ran memtest86 and discovered that, indeed, one of the memory modules has a bit flip:

    https://drive.google.com/file/d/1pnHfUcoSwH8DEnWfl0S7newMLBVo3eXE/view?usp=sharing
    https://drive.google.com/file/d/1iDOlSFfMSZ1ffxrSQTeXDmv0luOHT3yS/view?usp=sharing

As you can see on screenshots, two bits flip:
- 0x00400000
- 0x00010000


  > 117 = 0x75
  > 53  = 0x35
  >
  > The difference is 0x40, which is a single bit.

I think it's the 0x00400000 bit.

