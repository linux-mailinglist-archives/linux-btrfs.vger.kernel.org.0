Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97488430C8D
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Oct 2021 00:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344746AbhJQWRJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 17 Oct 2021 18:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344720AbhJQWRJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 17 Oct 2021 18:17:09 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279A2C06161C
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Oct 2021 15:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds202012; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BzmQql/QV0n+QoTwHNWIcJ+wZmnEC+OPJhvy7PL7mDU=; b=3YqBT0pkGlIIN3m+io0bt08E3t
        EFNYKpw3lfNUJLzb9Gkxp2Qe1gh4YTsIzQkjjtkgn1YAKt2WYyvg42hyQLKFbIRt++wWEe3li8Sd0
        wIGJ/bV/YfOJP53QLJSzKmq63QZj5XyHoNdOCvSBqw/JxjBeyxNrYbmcWNmNC6nMw+VLFyLZBuVkX
        ijxKF11foPKD5J8wkzKMmnHqZsFz/eOel03FLkXlJxJPiuyywMneeq0zwoezDIqEvuX2vVXFWoEDm
        ZkyIdfKXoHmPplFomgBuBCeRZiVxHwRC6HWwxub9nsWKn/xw4JXOCcLsfr0MVxEBC8YqjdFC0eibi
        h+b0wOOg==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:20575 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1mcEQh-0005PL-Rd; Mon, 18 Oct 2021 00:14:55 +0200
Reply-To: waxhead@dirtcellar.net
Subject: Re: Ubuntu 21.10, raid1c3, and grub
To:     Neal Gompa <ngompa13@gmail.com>, Jim Davis <jim.epost@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CA+r1ZhgCPB0JYyfC=pRK3mP0_xXGfTW9YpYV0RtYZ_pDMdYCOg@mail.gmail.com>
 <CAEg-Je8Ao8VdZsajsuNheysqM=zjwZ+d9MowhEygfV63f6Qy9w@mail.gmail.com>
From:   waxhead <waxhead@dirtcellar.net>
Message-ID: <5dd76af5-60a6-99bf-0d3e-94f162a898cf@dirtcellar.net>
Date:   Mon, 18 Oct 2021 00:14:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.9.1
MIME-Version: 1.0
In-Reply-To: <CAEg-Je8Ao8VdZsajsuNheysqM=zjwZ+d9MowhEygfV63f6Qy9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Neal Gompa wrote:
> On Sun, Oct 17, 2021 at 6:37 AM Jim Davis <jim.epost@gmail.com> wrote:
>>
>> I've been trying some experiments with raid1c3 on a qemu virtual
>> machine running Ubuntu 21.10.  Choosing btrfs initially as the root
>> file system during installation works just fine.
>>
>> Adding a new virtual disk to btrfs root file system and running btrfs
>> balance with -mconvert=raid1 and -dconvert=raid1 works too -- the vm
>> reboots with no problems.
>>
>> Adding another new virtual disk to btrfs root file system and running
>> btrfs balance again, with -mconvert=raid1c3 and -dconvert=raid1c3 and
>> then rebooting doesn't work: the vm drops into grub rescue with a
>> cryptic
>>
>> error: unsupported RAID flags 202
>>
>> message.  Any ideas?
>>
> 
> Support for the raid1cX modes was added to GRUB in GRUB 2.06. The
> Debian family (including Ubuntu) has not upgraded yet, nor have they
> backported the support to their custom release of GRUB 2.04 yet. I
> would suggest filing a bug with Ubuntu to backport the following
> commit: https://git.savannah.gnu.org/cgit/grub.git/commit/grub-core/fs/btrfs.c?id=495781f5ed1b48bf27f16c53940d6700c181c74c
> 
This would be useful information to have on the STATUS page for 
RAID1c3/RAID1c4 as well. I am on Debian and had to discover this the 
hard way when I believed that Grub 2.04 *had* this backported , which it 
of course has not...
