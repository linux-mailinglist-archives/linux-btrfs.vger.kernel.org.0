Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E500DB1197
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 16:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732831AbfILO5s convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 12 Sep 2019 10:57:48 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:33551 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732566AbfILO5s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Sep 2019 10:57:48 -0400
Received: from [10.137.0.38] (unknown [37.166.132.1])
        (Authenticated sender: swami@petaramesh.org)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 541D3200005;
        Thu, 12 Sep 2019 14:57:44 +0000 (UTC)
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
To:     Christoph Anton Mitterer <calestyo@scientia.net>,
        fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <11e4e889f903ddad682297c4420faeb0245414cf.camel@scientia.net>
 <CAL3q7H4peDv_bQa5vGJeOM=V--yq1a1=aHat5qcsXjbnDoSkDQ@mail.gmail.com>
 <ce6a9b8274f5af89d9378aa84e934ce3f3354acd.camel@scientia.net>
 <CAL3q7H5qNE4rizN14qmgrAwtju9KRHspKxo3S-PoTcSUvXYuew@mail.gmail.com>
 <41d5dae3587efa5c19262a230e3c459f8e14159b.camel@scientia.net>
From:   =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>
Openpgp: preference=signencrypt
Autocrypt: addr=swami@petaramesh.org; keydata=
 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
 BtUAN08OPA==
Message-ID: <2cfe8d20-43f1-ae88-0712-60bb9d6d4dc0@petaramesh.org>
Date:   Thu, 12 Sep 2019 16:57:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <41d5dae3587efa5c19262a230e3c459f8e14159b.camel@scientia.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: fr-FR
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/12/19 4:39 PM, Christoph Anton Mitterer wrote:
> On Thu, 2019-09-12 at 15:28 +0100, Filipe Manana wrote:
>> This is case 2), the corruption with the error messages
>> "parent transid verify failed ..." in dmesg/syslog after mounting the
>> filesystem again.
> Hmm so "at least" it will never go unnoticed, right?
>
> This is IMO a pretty important advise, as people may want to compare
> their current data with that of backups... if silent corruption would
> have been possible.
>
>
> Cheers,
> Chris.

Per my own experience hitting this bug, it definitely doesn't go
unnoticed - I haven't experienced the system hang, which obviouslly
cannot go unoticed, but the « Parent TransID » failure thing.

The most annoying consequence is that the filesystem is then beyond
repair and needs to be completely recreated. In my case I still could
backup most of my files from the damaged FS, even though a few were lost
or damaged - files that were open or had been recently changed, while
old files were still there and healthy.

So for me most of the hassle was to first recreate my FS with all its
complexity (subvols, snapshots...) and restore from a backup made just
before, then check missing files from another (luckily very recent)
other backup and trying to fix what got broke.

I have to say that I have re-upgraded said machine to latest Arch 5.2
kernel a couple weeks ago and a couple other Manjaro machines to latest
5.2 kernel as well, and haven't been hit by the bug since.

However having read that the bug is diagnosed, confirmed and fixed by
Filipe, I seriously consider downgrading my kernel back to 5.1 on the 2
Manjaro machines as it is rather straightforward, and maybe my Arch as
well... Until I'm sure that the fix made it to said distro kernels.

Fortunately other common, less “bleading edge” distros that I use, such
as Debian stable or Mint/Ubuntu, still ships a kernel which is older
than 5.1 and I will stay away from 5.2 backports...

I'm however quite concerned that the FS on which I store all of my most
precious data and considered “the safest native Linux FS available” can
still suffer such regressions that can plainly trash it to ruins.

Kind regards.

>
ॐ

-- 
Swâmi Petaramesh <swami@petaramesh.org> PGP 9076E32E


