Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE0E033961
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2019 21:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfFCT4L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jun 2019 15:56:11 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:43420 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfFCT4L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jun 2019 15:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dirtcellar.net; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Reply-To; bh=FVeFMbPRdjSMUsnQlQ/MUV10I51783EGhBeMw8AsyXQ=;
        b=GjcGQlUK/Vwqujv7OZSz2yrub/SEVbT4cKZYosZoqb8jRqHH8Un6oOxCSStYyoBkMFBlkayonws91mso7t2ghf75hRJKEcdEsdpZ4FOPtEJOvKaeTP+EZefcsIwVmpw3ZM5N99Grqu5qFWbRj5bFWIDq0wkr1EUS+Op+0XynNGUblWlg5uISLoL95qZAoxCSVFsNfie2j1t6nwjavD7FHZ3oB2ZGLn52Z8cT5hE0rIJy4Vv9lzu/A/ppURHuQ8eMJk6i8qNzAHG7MIsvGtggn7cM+2dKIBTAwHqviks49l8WvEoqp+rPvJqdtI2v5NM9CZTJyqJFQtzMNR8Of5Q1kA==;
Received: from 73.79-160-166.customer.lyse.net ([79.160.166.73]:50377 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1hXt3x-0000I1-KM; Mon, 03 Jun 2019 21:56:09 +0200
Reply-To: waxhead@dirtcellar.net
Subject: Re: [PATCH v4 00/13] Add support for other checksums
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>
References: <20190603145859.7176-1-jthumshirn@suse.de>
From:   waxhead <waxhead@dirtcellar.net>
Message-ID: <78fb639b-3f2d-7cb5-77b7-fee7339a0449@dirtcellar.net>
Date:   Mon, 3 Jun 2019 21:56:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <20190603145859.7176-1-jthumshirn@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



Johannes Thumshirn wrote:
> This patchset add support for adding new checksum types in BTRFS.
> 
> Currently BTRFS only supports CRC32C as data and metadata checksum, which is
> good if you only want to detect errors due to data corruption in hardware.
> 
> But CRC32C isn't able cover other use-cases like de-duplication or
> cryptographically save data integrity guarantees.
> 
> The following properties made SHA-256 interesting for these use-cases:
> - Still considered cryptographically sound
> - Reasonably well understood by the security industry
> - Result fits into the 32Byte/256Bit we have for the checksum in the on-disk
>    format
> - Small enough collision space to make it feasible for data de-duplication
> - Fast enough to calculate and offloadable to crypto hardware via the kernel's
>    crypto_shash framework.
> 
> The patchset also provides mechanisms for plumbing in different hash
> algorithms relatively easy.
> 

Howdy , being just a regular user I am in fact a bit concerned about 
what happens to my delicious (it's butter after all) filesystems if I 
happen to move disks between servers. Let's say server A has a 
filesystem that support checksum type_1 and type_2 while server B only 
supports type_1.

If the filesystem only has checksum of type_2 stored I would assume that 
server B won't be able to read the data.

Ignoring checksums will kind of make BTRFS pointless, but I think this 
is a good reason to consider adding a 'ignore-checksum' mount option - 
at least it could make the data readable (RO) in a pinch.

....actually since you could always fall back to the original crc32c 
then perhaps RO might not even be needed at all ?!

I openly admit to NOT having read the patchset, so feel free to ignore 
my comment if this has already been discussed...
