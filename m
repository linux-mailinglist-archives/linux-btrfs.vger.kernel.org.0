Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E088ADC2A
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Sep 2019 17:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388351AbfIIPfV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Sep 2019 11:35:21 -0400
Received: from zaphod.cobb.me.uk ([213.138.97.131]:42548 "EHLO
        zaphod.cobb.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbfIIPfU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Sep 2019 11:35:20 -0400
X-Greylist: delayed 338 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Sep 2019 11:35:18 EDT
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 270AB142BC4; Mon,  9 Sep 2019 16:29:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1568042979;
        bh=cPOtf85m2JiX2HEaBZlbAl007OlVNmy1m4WkK/YOcPc=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=NLIjy4WvtzhIeRUILla0gYKLIcgkjjUOOQ1JWoJ3wdGK9dyM+2q08aCnzM4zCyTlw
         xkYSkl905fjj6XjXD0RNfgR0BunLGTmWJfKtgmeupztFWFNdB7CkGHOaPZzQEQaumy
         9eG3fnqTy1No/7tkI7aUUgOx5f94RdrB7kWXxUkUvrajB47R8M/jr+JNO0ckHAfhUe
         1ItUHnMmQTaZw2RYJ4Rlp+ZW2PEOF/pC/iK2P/Ik8/i/VjaquvL+tlH/QekrryfOIn
         WoT1EZTZsxnn1544++Y7VydeEJcHmePnpIz0zRsH3oC6mKPueH74OCcFkqUlaxQLCF
         uY/L9m17CdMMA==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-0.8 required=12.0 tests=ALL_TRUSTED,DKIM_INVALID,
        DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 3F6C3142BC3;
        Mon,  9 Sep 2019 16:29:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1568042977;
        bh=cPOtf85m2JiX2HEaBZlbAl007OlVNmy1m4WkK/YOcPc=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=WxOZPkgFfYhSctc8PKxwUlohIPtLoD+w3pUUrcs5N6qja3+NyGARKM4WsH6XQRp7A
         FyzDnR7f3lmKdLMF0UJYxDOm1lWEZPU1Jf5Wj+edOFLoY6prYcz7qtmjizVRsv1WFD
         kHYrm+Y7fLJhiZQTd6SxvXOq3i6KQfLGBIxYAfmZ8I3lRirGMiVsJSJT2DB46ceAc1
         5V+HFFagsYBVzJ2BnZHSc70hcZdwLDHOTI/B1/FAGy4/nHbotqaRAVC7EbCsiEQ4IH
         KxdXIN0xeAWgOva9+x5azxrKxMEKUSWnXbfW+vEqKLw83XaygOYu+LqqkvCiscdA9N
         rsCpJ2PAqAS4Q==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id 03CB04384C;
        Mon,  9 Sep 2019 16:29:36 +0100 (BST)
Subject: Re: Feature requests: online backup - defrag - change RAID level
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        zedlryqc@server53.web-hosting.com, linux-btrfs@vger.kernel.org
References: <20190908225508.Horde.51Idygc4ykmhqRn316eLdRO@server53.web-hosting.com>
 <5e6a9092-b9f9-58d2-d638-9e165d398747@gmx.com>
 <20190909072518.Horde.c4SobsfDkO6FUtKo3e_kKu0@server53.web-hosting.com>
 <fb80b97a-9bcd-5d13-0026-63e11e1a06b5@gmx.com>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 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 myxb
Message-ID: <c4f05241-77d4-3ae4-9773-795351a26a8e@cobb.uk.net>
Date:   Mon, 9 Sep 2019 16:29:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <fb80b97a-9bcd-5d13-0026-63e11e1a06b5@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 09/09/2019 13:18, Qu Wenruo wrote:
> 
> 
> On 2019/9/9 下午7:25, zedlryqc@server53.web-hosting.com wrote:
>> What I am complaining about is that at one point in time, after issuing
>> the command:
>>     btrfs balance start -dconvert=single -mconvert=single
>> and before issuing the 'btrfs delete', the system could be in a too
>> fragile state, with extents unnecesarily spread out over two drives,
>> which is both a completely unnecessary operation, and it also seems to
>> me that it could be dangerous in some situations involving potentially
>> malfunctioning drives.
> 
> In that case, you just need to replace that malfunctioning device other
> than fall back to SINGLE.

Actually, this case is the (only) one of the three that I think would be
very useful (backup is better handled by having a choice of userspace
tools to choose from - I use btrbk - and does anyone really care about
defrag any more?).

I did, recently, have a case where I had started to move my main data
disk to a raid1 setup but my new disk started reporting errors. I didn't
have a spare disk (and didn't have a spare SCSI slot for another disk
anyway). So, I wanted to stop using the new disk and revert to my former
(m=dup, d=single) setup as quickly as possible.

I spent time trying to find a way to do that balance without risking the
single copy of some of the data being stored on the failing disk between
starting the balance and completing the remove. That has two problems:
obviously having the single copy on the failing disk is bad news but,
also, it increases the time taken for the subsequent remove which has to
copy that data back to the remaining disk (where there used to be a
perfectly good copy which was subsequently thrown away during the balance).

In the end, I took the risk and the time of the two steps. In my case, I
had good backups, and actually most of my data was still in a single
profile on the old disk (because the errors starting happening before I
had done the balance to change the profile of all the old data from
single to raid1).

But a balance -dconvert=single-but-force-it-to-go-on-disk-1 would have
been useful. (Actually a "btrfs device mark-for-removal" command would
be better - allow a failing device to be retained for a while, and used
to provide data, but ignore it when looking to store data).

Graham
