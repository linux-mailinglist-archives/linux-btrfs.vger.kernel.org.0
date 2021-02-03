Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFAC30E6F3
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Feb 2021 00:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbhBCXOG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Feb 2021 18:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbhBCXK1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Feb 2021 18:10:27 -0500
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D8AC0613D6
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Feb 2021 15:09:47 -0800 (PST)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 880DF9BBD2; Wed,  3 Feb 2021 23:08:49 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1612393729;
        bh=U+IWkpxckPej/KmIuIKafJJm142jQdZq09YP509dKwM=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=GwTTIq8vRDRmY0GVcpPqPcZ3VuGxAEJmjkXBnpsDzpi3Lm0LMsUnQqCu3sngFYNv+
         GN6CULMjSwakt6stSa52JyIPN1ZY9WBJz5z3nIJ8qoLERmqlGhxQ0sIcbWWQVbloZn
         +gnqFvRNwBjX9JYGql+8LGk0SfXp1Zkdh+aG/AqcSZsyQA+lanejuEOoeSflLYQLDa
         VDuiAgIBdW6LDT5L6aNG9HXDyqeJ2INIv+/a3/rDnchxDvusnkGJqWN5bRL+oNOtTo
         mqPuixxO5K34sateB1RG7qZM7bswwbN384OIuCPOzp+mgk6ie3hrq9glxIIxFZnqVV
         cvUYGU8TxXgSQ==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-3.2 required=12.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 755AF9B7D0;
        Wed,  3 Feb 2021 23:08:44 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1612393724;
        bh=U+IWkpxckPej/KmIuIKafJJm142jQdZq09YP509dKwM=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=whNilygK6ZTCcAA8V4g08bBkLzK+rusPJRxRg73WImjnJivAwY2OUj+NfuW2fI7Ot
         iwz+FI3LBklnO2nvdzPajbszKIKM5rJ2IDTNFBpnJM0n3+EWRfYU9shtHPljF5gwWB
         vAqX4eAoUNOjkOxbCnZvsXXdOOjq6anRZVfsRlH4ldPHh9z5DTYLt0Shu7/S9o3c5S
         tfFul8KB1EQ1ySHzzyc9flT5Rdm8jigKC2oLUUFIKqW43cowXqou/Kp8sMfcf+Fxhq
         l/abJpASKWH5teVD3emtzybQYoF2Xl6HqSPSYEhhZTSPTYEGh9RHY6h7agIASvaFgQ
         h0xuGZGmerAcw==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id 21C981E78D1;
        Wed,  3 Feb 2021 23:08:43 +0000 (GMT)
Subject: Re: Large multi-device BTRFS array (usually) fails to mount on boot.
To:     joshua@mailmag.net, linux-btrfs@vger.kernel.org
References: <e23a835842fa7ecf5b8877e818bc68ea@mailmag.net>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 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
 AqhfIg4IeGywNhQ5k6edog3qMK/weZgMYi8=
Message-ID: <8ae61a4f-8a7f-332f-a6b6-4ad808cc88c8@cobb.uk.net>
Date:   Wed, 3 Feb 2021 23:08:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e23a835842fa7ecf5b8877e818bc68ea@mailmag.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 03/02/2021 21:54, joshua@mailmag.net wrote:
> Good Evening.
> 
> I have a large BTRFS array, (14 Drives, ~100 TB RAW) which has been having problems mounting on boot without timing out. This causes the system to drop to emergency mode. I am then able to mount the array in emergency mode and all data appears fine, but upon reboot it fails again.
> 
> I actually first had this problem around a year ago, and initially put considerable effort into extending the timeout in systemd, as I believed that to be the problem. However, all the methods I attempted did not work properly or caused the system to continue booting before the array was mounted, causing all sorts of issues. Eventually, I was able to almost completely resolve it by defragmenting the extent tree and subvolume tree for each subvolume. (btrfs fi defrag /mountpoint/subvolume/) This seemed to reduce the time required to mount, and made it mount on boot the majority of the time.
> 

Not what you asked, but adding "x-systemd.mount-timeout=180s" to the
mount options in /etc/fstab works reliably for me to extend the timeout.
Of course, my largest filesystem is only 20TB, across only two devices
(two lvm-over-LUKS, each on separate physical drives) but it has very
heavy use of snapshot creation and deletion. I also run with commit=15
as power is not too reliable here and losing power is the most frequent
cause of a reboot.

