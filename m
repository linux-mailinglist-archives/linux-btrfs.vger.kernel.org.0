Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD7B9C96AA
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2019 04:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfJCCSN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Oct 2019 22:18:13 -0400
Received: from forward101j.mail.yandex.net ([5.45.198.241]:58871 "EHLO
        forward101j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726267AbfJCCSN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Oct 2019 22:18:13 -0400
Received: from forward101q.mail.yandex.net (forward101q.mail.yandex.net [IPv6:2a02:6b8:c0e:4b:0:640:4012:bb98])
        by forward101j.mail.yandex.net (Yandex) with ESMTP id 425061BE0958;
        Thu,  3 Oct 2019 05:18:09 +0300 (MSK)
Received: from mxback7q.mail.yandex.net (mxback7q.mail.yandex.net [IPv6:2a02:6b8:c0e:41:0:640:cbbf:d618])
        by forward101q.mail.yandex.net (Yandex) with ESMTP id 3CCD9CF40004;
        Thu,  3 Oct 2019 05:18:09 +0300 (MSK)
Received: from vla1-b617950fbd54.qloud-c.yandex.net (vla1-b617950fbd54.qloud-c.yandex.net [2a02:6b8:c0d:3495:0:640:b617:950f])
        by mxback7q.mail.yandex.net (nwsmtp/Yandex) with ESMTP id AFf8vo9WGL-I9kKVxIO;
        Thu, 03 Oct 2019 05:18:09 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1570069089;
        bh=/QcV/50A/gHMGGRj/NPhW6105YcqEhsws0ZWTpibKCY=;
        h=In-Reply-To:From:Date:References:To:Subject:Message-ID;
        b=Upj+C2gBN8LpsKsKkLugHWuUJN8/Tk6M3A9lSfMcn4TQl1IZpEbsd4WXk7J08HUvu
         bDWz6BQEAltfZ28T6CtyBqOh07TH4ubyRIULz+XzebWMAFNKG3PbX05uOHk/YGp/y1
         PAriwQT1oRPkd1EgJxmjIA9xv2xZgiH0wFB5cRP8=
Authentication-Results: mxback7q.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla1-b617950fbd54.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id wYjsHEnUyf-I8quGSj7;
        Thu, 03 Oct 2019 05:18:08 +0300
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
From:   Andrey Ivanov <andrey-ivanov-ml@yandex.ru>
Message-ID: <0ecf3dc2-c884-7c08-5f11-86e1b1d2f631@yandex.ru>
Date:   Thu, 3 Oct 2019 05:18:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a6f68cf9-20b9-f1bf-379a-a361c4387dc7@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: ru-RU
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 03.10.2019 5:00, Qu Wenruo wrote:
>> I think "btrfs check" is looped somewhere. Or not?
> 
> You can try "btrfs check --mode=lowmem --repair" as an alternative.

$ btrfs check -p --mode=lowmem --repair sda4.image.copy
enabling repair mode
WARNING: low-memory mode repair support is only partial
Opening filesystem to check...
Checking filesystem on sda4.image.copy
UUID: a942b8da-e92d-4348-8de9-ded1e5e095ad
[1/7] checking root items                      (0:00:07 elapsed, 509895 items checked)
Fixed 0 roots.
No device size related problem found           (0:00:47 elapsed, 71347 items checked)
[2/7] checking extents                         (0:00:47 elapsed, 71347 items checked)
cache and super generation don't match, space cache will be invalidated
[3/7] checking free space cache                (0:00:00 elapsed)
ERROR: root 5 DIR_INDEX[843063 15] data_len shouldn't be 256sed, 1055 items checked)
invalid dir item size
ERROR: fail to repair inode 908624 name filterlog.html filetype 1
ERROR: root 5 DIR ITEM[843063 15] name filterlog.html filetype 1 missing
ERROR: root 5 INODE REF[908624, 843063] name filterlog.html filetype 1 missing
ERROR: root 5 DIR_INDEX[843063 18] data_len shouldn't be 256
ERROR: root 5 INODE_ITEM[908627] index 18 name Sent/sbd filetype 2 mismath
ERROR: root 5 DIR_INDEX[843063 18] should contain only one entry
Set isize in inode 843063 root 5 to 318
ERROR: root 5 EXTENT_DATA[843064 45056] csum missing, have: 0, expected: 16384
invalid dir item size
invalid dir item size
ERROR: fail to repair inode 843091 name Sent.sbd filetype 2
ERROR: root 5 DIR INDEX[843063 18] missing name Sent.sbd filetype 2
invalid dir item size
invalid dir item size
ERROR: fail to repair inode 843091 name Sent.sbd filetype 2
ERROR: root 5 DIR INDEX[843063 18] missing name Sent.sbd filetype 2
invalid dir item size
invalid dir item size
ERROR: fail to repair inode 843091 name Sent.sbd filetype 2
ERROR: root 5 DIR INDEX[843063 18] missing name Sent.sbd filetype 2
invalid dir item size
invalid dir item size
ERROR: fail to repair inode 843091 name Sent.sbd filetype 2
ERROR: root 5 DIR INDEX[843063 18] missing name Sent.sbd filetype 2
invalid dir item size
invalid dir item size
ERROR: fail to repair inode 843091 name Sent.sbd filetype 2
ERROR: root 5 DIR INDEX[843063 18] missing name Sent.sbd filetype 2
invalid dir item sizets                        (0:00:13 elapsed, 1297 items checked)
invalid dir item size
ERROR: fail to repair inode 843091 name Sent.sbd filetype 2
ERROR: root 5 DIR INDEX[843063 18] missing name Sent.sbd filetype 2
invalid dir item size
invalid dir item size
ERROR: fail to repair inode 843091 name Sent.sbd filetype 2
ERROR: root 5 DIR INDEX[843063 18] missing name Sent.sbd filetype 2
invalid dir item size
invalid dir item size
ERROR: fail to repair inode 843091 name Sent.sbd filetype 2
ERROR: root 5 DIR INDEX[843063 18] missing name Sent.sbd filetype 2

...


I think it looped again.
