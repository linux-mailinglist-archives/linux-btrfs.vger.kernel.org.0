Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3934978D0A
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2019 15:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfG2Nmi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Jul 2019 09:42:38 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:49785 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfG2Nmh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Jul 2019 09:42:37 -0400
X-Originating-IP: 88.191.131.7
Received: from [192.168.1.167] (unknown [88.191.131.7])
        (Authenticated sender: swami@petaramesh.org)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 32DBF24000A;
        Mon, 29 Jul 2019 13:42:31 +0000 (UTC)
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <bcb1a04b-f0b0-7699-92af-501e774de41a@petaramesh.org>
 <c336ccf4-34f5-a844-888c-cd63d8dc5c4e@petaramesh.org>
 <0ce15d14-9f30-ac83-0964-8e695eca8cbd@gmx.com>
From:   =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>
Openpgp: preference=signencrypt
Autocrypt: addr=swami@petaramesh.org; prefer-encrypt=mutual; keydata=
 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
 BtUAN08OPA==
Message-ID: <325a96b2-e6a4-91e3-3b07-1d20a5a031af@petaramesh.org>
Date:   Mon, 29 Jul 2019 15:42:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0ce15d14-9f30-ac83-0964-8e695eca8cbd@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Le 29/07/2019 à 15:35, Qu Wenruo a écrit :
> This means btrfs metadata CoW is broken.

I remember having had exactly the same kind of messages on the main
machine's SSD a week ago (before I had to recreate, backup and restore it)

> Did the system went through some power loss?

No *THIS* filesystem is an external backup. It's typical use is plug,
backup, umount (properly), unplug.

So there's very little reasons such a filsystem would en up broken.

> If not, then it's btrfs or lower layer causing the problem.
> 
> Did you have any btrfs without LUKS?

Not much...

Here's the rest of the (still running) btrsf check :

# btrfs check /dev/mapper/luks-UUID
Opening filesystem to check...
Checking filesystem on /dev/mapper/luks-UUID
UUID: ==somehing==
[1/7] checking root items
[2/7] checking extents
parent transid verify failed on 2137144377344 wanted 7684 found 7499
parent transid verify failed on 2137144377344 wanted 7684 found 7499
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
leaf parent key incorrect 2137144377344
bad block 2137144377344
ERROR: errors found in extent allocation tree or chunk allocation
[3/7] checking free space cache
[4/7] checking fs roots
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
Wrong key of child node/leaf, wanted: (1797454, 96, 23), have:
(18446744073709551606, 128, 2538887163904)
Wrong generation of child node/leaf, wanted: 7499, have: 7684


Uh I'm at a loss...

ॐ

-- 
Swâmi Petaramesh <swami@petaramesh.org> PGP 9076E32E
