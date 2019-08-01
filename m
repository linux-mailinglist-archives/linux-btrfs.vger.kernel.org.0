Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6957D539
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Aug 2019 08:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfHAGIA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Aug 2019 02:08:00 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:46699 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfHAGH7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Aug 2019 02:07:59 -0400
Received: from [192.168.1.167] (unknown [88.191.131.7])
        (Authenticated sender: swami@petaramesh.org)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 52B6F100009;
        Thu,  1 Aug 2019 06:07:55 +0000 (UTC)
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Lionel Bouton <lionel-subscription@bouton.name>,
        linux-btrfs@vger.kernel.org
References: <bcb1a04b-f0b0-7699-92af-501e774de41a@petaramesh.org>
 <f8b08aec-2c43-9545-906e-7e41953d9ed4@bouton.name>
 <02f206eb-0c36-6ba7-94ce-f50fa3061271@bouton.name>
 <6fb5af6c-d7b8-951b-f213-e2b9b536ae6a@petaramesh.org>
 <d8c571e4-718e-1241-66ab-176d091d6b48@bouton.name>
 <f8dfd578-95ac-1711-e382-7304bf800fb2@petaramesh.org>
 <c4885e92-937c-8fc7-625a-3bfc372e3bf5@oracle.com>
From:   =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>
Openpgp: preference=signencrypt
Autocrypt: addr=swami@petaramesh.org; prefer-encrypt=mutual; keydata=
 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
 BtUAN08OPA==
Message-ID: <0bba3536-391b-42ea-1030-bd4598f39140@petaramesh.org>
Date:   Thu, 1 Aug 2019 08:07:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c4885e92-937c-8fc7-625a-3bfc372e3bf5@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

Le 01/08/2019 à 06:50, Anand Jain a écrit :
>>
>> So, I've had the issue of 2 FSes so far :
>>
>> - BTRFS FS on LVM over LUKS on a SATA SSD.
>>
>> - BTRFS FS directly over LUKS on an USB-3 mechanical HD.
>>
>> (All this having been perfectly stable until upgrade to 5.2 kernel...)
>>
> 
>  What kind of btrfs chunk profiles were used here (I guess its either
> single or dup)?

Yes, it was the default profiles :

- Single data, single metadata on the internal SSD (mounted with the
"ssd,discard,noatime" options and no compression.

- Single data, DUP metadata on the external USB HD (mounted with the
"noatime,compress=zstd" options.


I have downgraded the kenel to 5.1.16-arch1-1-ARCH when I restored the
machine (before rebooting it) and recreated the SSD BTRFS FS using the
latest "Parted Magic" (5.1 kernel).

The kernel was the ONLY package I downgraded.

The machine has been running like a charm since - as it ever dit - and
I'm typing this email on it.

(The SSD has passed extended self-tests, SMART tests, and BTRFS has been
successfully scrubbed since it was recreated)


So I am - for myself - positively sure that the 2 FS corruptions I met
were related to Arch kernel 5.2 on this machine, as it happened right
after I had upgraded the kernel, had never happened before, and doesn't
happen since I downgraded the kernel.

I have to add however that I upgraded another little machine to Manjaro
kernel 5.2 - after taking a full clone of the FS - and I don't have met
any filesystem corruption so far.

It is worth noting that Manjaro is the same family as Arch.


So even though I have no better logs to provide, here is my experience :

- Arch kernel 5.2 : BTRFS over LVM over LUKS on a SSD, and BTRFS over
LUKS on an USB HD : 2 filesystem corruptions. Both using numerous
snapshots, some were deleted (either by snapper or manually). Downgraded
to 5.1 now OK.


- Manjaro kernel 5.2 on a small laptop, BTRFS over LUKS on eMMC, no
compression, no snapshots, no problem so far.


- Manjaro kernel 5.2 on another laptop for a very short while before
reverting to 5.1, BTRFS over LVM over LUKS on SSD, a few snapshots, I
dunno if some were deleted (snapper) : Still OK.

- Manjaro kernel 5.2 on a desktop for a very short while before
reverting to 5.1, BTRFS RAID-1 over bcache over LUKS on a 2 HD + 1 SSD
mix, a few snapshots, I dunno if some were deleted (snapper) : Still OK.

So you see the setups can be a bit complex : Always a LUKS layer,
compression used on mechanical HDs, sometimes LVM or bcache, some BTRFS
RAID on one system...

As far as I can tell, the issue doesn't relate to the most complex setups.


I am under the unproved but strong feeling that the mess has something
to do with snapshots deletion with kernel 5.2...

Dunno if it can be of some help.

Kind regards.

ॐ

-- 
Swâmi Petaramesh <swami@petaramesh.org> PGP 9076E32E
