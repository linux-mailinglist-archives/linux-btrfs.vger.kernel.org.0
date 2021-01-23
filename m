Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539A430161A
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Jan 2021 15:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbhAWO46 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Jan 2021 09:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbhAWO45 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Jan 2021 09:56:57 -0500
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61104C06174A
        for <linux-btrfs@vger.kernel.org>; Sat, 23 Jan 2021 06:56:17 -0800 (PST)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id D7AF89C307; Sat, 23 Jan 2021 14:56:13 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1611413773;
        bh=wAc2OYWLWtE3TR9NBMJhXLWcOagPNBG4+GaikMS5wkk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=qdJPYCXiI3zX2BSq+02jIhUojZfHCYlBckkhHZBAihlF5KP2RTs+432s5dvPhI2p3
         fzE4SLoCuUxa2rx+a5MVNFRDYpPRbHo4h1/wZV7cByIWQDkZzPBSCLD/BDCZok93n1
         phMXGckZDdgKBKfbXByKbZkW2wJWgg7MvEA65aoPwm80f9xHtxgQW6GJ+8EHxIFqo7
         Ci5fm2+wx6siaNGbrQ9/3LrpLejoZPJw+ajA6SgTOgJye6DQScMfKXr40W3dnlTVqV
         jzMWQ8EvxMyxiMuuW8pEYWOlPHv9IbXznTINNnynWISOujH6BBuZB7WIMmHue7Nb32
         NTZKGXYvSLxaQ==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-3.0 required=12.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 028EE9BBB5;
        Sat, 23 Jan 2021 14:56:01 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1611413761;
        bh=wAc2OYWLWtE3TR9NBMJhXLWcOagPNBG4+GaikMS5wkk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=otH/xMFv6uy7o2Su1O9ZGMZCNoXJ7Jjmu0nsnUQBqqCix0B7hMIKIyIK40YHjnM/0
         VhB0dSV8RgaqhO3B1YmGkwpKBhOqyO4F3VzNB2+FG6sPwJBq1hfkjUc6bxn5qAxPyl
         uyxFLKcXMLstzmncAN5DbwTZGA1vRAq6PS1pGLR51rFqsG0R7RuxgJa8+ngU5OcFW1
         3IV3xIS9wpivkUyXPVmAXYUjTDUWf1JNhntk0GEuiyo2d/7bNm8u5nea7jJm79J7A1
         9cVgTuKX0/f2LogQsyTmfaGcUSo8WSTc1PfhkF09as+TghXZ8yyv3ld4wCSpvXORZn
         UDSFOuv6Kj66Q==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id 33B1F1D885E;
        Sat, 23 Jan 2021 14:55:53 +0000 (GMT)
Subject: Re: [RFC][PATCH V5] btrfs: preferred_metadata: preferred device for
 metadata
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Goffredo Baroncelli <kreijack@inwind.it>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
References: <20210117185435.36263-1-kreijack@libero.it>
 <30cd0359-e649-dcc7-e373-4dd778fbf70b@toxicpanda.com>
 <765cec4e-b989-081b-2ad7-e2d1c9cf7f55@libero.it>
 <20210121185400.GH28049@hungrycats.org>
 <89ee4ab9-64cd-b093-92d2-02eee4997250@inwind.it>
 <20210122224253.GI28049@hungrycats.org>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 mQINBFaetnIBEAC5cHHbXztbmZhxDof6rYh/Dd5otxJXZ1p7cjE2GN9hCH7gQDOq5EJNqF9c
 VtD9rIywYT1i3qpHWyWo0BIwkWvr1TyFd3CioBe7qfo/8QoeA9nnXVZL2gcorI85a2GVRepb
 kbE22X059P1Z1Cy7c29dc8uDEzAucCILyfrNdZ/9jOTDN9wyyHo4GgPnf9lW3bKqF+t//TSh
 SOOis2+xt60y2In/ls29tD3G2ANcyoKF98JYsTypKJJiX07rK3yKTQbfqvKlc1CPWOuXE2x8
 DdI3wiWlKKeOswdA2JFHJnkRjfrX9AKQm9Nk5JcX47rLxnWMEwlBJbu5NKIW5CUs/5UYqs5s
 0c6UZ3lVwinFVDPC/RO8ixVwDBa+HspoSDz1nJyaRvTv6FBQeiMISeF/iRKnjSJGlx3AzyET
 ZP8bbLnSOiUbXP8q69i2epnhuap7jCcO38HA6qr+GSc7rpl042mZw2k0bojfv6o0DBsS/AWC
 DPFExfDI63On6lUKgf6E9vD3hvr+y7FfWdYWxauonYI8/i86KdWB8yaYMTNWM/+FAKfbKRCP
 dMOMnw7bTbUJMxN51GknnutQlB3aDTz4ze/OUAsAOvXEdlDYAj6JqFNdZW3k9v/QuQifTslR
 JkqVal4+I1SUxj8OJwQWOv/cAjCKJLr5g6UfUIH6rKVAWjEx+wARAQABtDNHcmFoYW0gQ29i
 YiAoUGVyc29uYWwgYWRkcmVzcykgPGdyYWhhbUBjb2JiLnVrLm5ldD6JAlEEEwECADsCGwEG
 CwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAhkBBQJWnr9UFRhoa3A6Ly9rZXlzLmdudXBnLm5l
 dAAKCRBv35GGXfm3Tte8D/45+/dnVdvzPsKgnrdoXpmvhImGaSctn9bhAKvng7EkrQjgV3cf
 C9GMgK0vEJu+4f/sqWA7hPKUq/jW5vRETcvqEp7v7z+56kqq5LUQE5+slsEb/A4lMP4ppwd+
 TPwwDrtVlKNqbKJOM0kPkpj7GRy3xeOYh9D7DtFj2vlmaAy6XvKav/UUU4PoUdeCRyZCRfl0
 Wi8pQBh0ngQWfW/VqI7VsG3Qov5Xt7cTzLuP/PhvzM2c5ltZzEzvz7S/jbB1+pnV9P7WLMYd
 EjhCYzJweCgXyQHCaAWGiHvBOpmxjbHXwX/6xTOJA5CGecDeIDjiK3le7ubFwQAfCgnmnzEj
 pDG+3wq7co7SbtGLVM3hBsYs27M04Oi2aIDUN1RSb0vsB6c07ECT52cggIZSOCvntl6n+uMl
 p0WDrl1i0mJUbztQtDzGxM7nw+4pJPV4iX1jJYbWutBwvC+7F1n2F6Niu/Y3ew9a3ixV2+T6
 aHWkw7/VQvXGnLHfcFbIbzNoAvI6RNnuEqoCnZHxplEr7LuxLR41Z/XAuCkvK41N/SOI9zzT
 GLgUyQVOksdbPaxTgBfah9QlC9eXOKYdw826rGXQsvG7h67nqi67bp1I5dMgbM/+2quY9xk0
 hkWSBKFP7bXYu4kjXZUaYsoRFEfL0gB53eF21777/rR87dEhptCnaoXeqQ==
Message-ID: <7b73eb0f-1b59-e6dd-5420-ef2d31a9fd62@cobb.uk.net>
Date:   Sat, 23 Jan 2021 14:55:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20210122224253.GI28049@hungrycats.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 22/01/2021 22:42, Zygo Blaxell wrote:
...
>> So the point is: what happens if the root subvolume is not mounted ?
> 
> It's not an onerous requirement to mount the root subvol.  You can do (*)
> 
> 	tmp="$(mktemp -d)"
> 	mount -osubvolid=5 /dev/btrfs "$tmp"
> 	setfattr -n 'btrfs...' -v... "$tmp"
> 	umount "$tmp"
> 	rmdir "$tmp"

No! I may have other data on that disk which I do NOT want to become
accessible to users on this system (even for a short time). As a simple
example, imagine, a disk I carry around to take emergency backups of
other systems, but I need to change this attribute to make the emergency
backup of this system run as quickly as possible before the system dies.
Or a disk used for audit trails, where users should not be able to
modify their earlier data. Or where I suspect a security breach has
occurred. I need to be able to be confident that the only data
accessible on this system is data in the specific subvolume I have mounted.

Also, the backup problem is a very real problem - abusing xattrs for
filesystem controls really screws up writing backup procedures to
correctly backup xattrs used to describe or manage data (or for any
other purpose).

I suppose btrfs can internally store it in an xattr if it wants, as long
as any values set are just ignored and changes happen through some other
operation (e.g. sysfs). It still might confuse programs like rsync which
would try to reset the values each time a sync is done.

