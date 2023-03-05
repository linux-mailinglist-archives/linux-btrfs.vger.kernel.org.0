Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433A56AADBE
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Mar 2023 02:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjCEBWd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 4 Mar 2023 20:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjCEBWc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 4 Mar 2023 20:22:32 -0500
Received: from mail.as397444.net (mail.as397444.net [69.59.18.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC42E83E8
        for <linux-btrfs@vger.kernel.org>; Sat,  4 Mar 2023 17:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bluematt.me
        ; s=1677978061; h=In-Reply-To:From:References:To:Subject:From:Subject:To:Cc:
        Cc:Reply-To; bh=OjBU97k+IH8C51+fv+VCQdadGh9LOdxd3+fKbBDdELE=; b=YXSL2hM5Ztdn5
        IuANeM/ST4R+R6+Juc5Knl85IHlJb0zn3ZhHVSrmEFW74LhjjtvAWhxA6ifGGFWxdcabzrND+mlpH
        E/ss86ifKV1XYfNFwBYmo02oqdi+LSv2fz8oiJrfJBSZuCdtHkaMcfxoR2Zotexk+tlb4oPBEPv50
        /12aIuc3N1wN2jIOqkcSctZ/9lbEdBJGLnIG7sAJK+JZuqmoCcZXvM8w8RDwYMupW6ywIhPlJJjEu
        ZufCOrY3BHxGXiTqeGpI9KZG+pAq42eOY5R3lj3Z807ENndIT4W7+LDP55k7kE+jnnMQ/VcOeOtLX
        z68WdzD/vy+RN79bNOpjw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=clients.mail.as397444.net; s=1677978063; h=In-Reply-To:From:References:To:
        Subject:From:Subject:To:Cc:Cc:Reply-To;
        bh=OjBU97k+IH8C51+fv+VCQdadGh9LOdxd3+fKbBDdELE=; b=fF4xOGJEqOEoLy6BWwvVxGuiKV
        BkHxNf4OOvxlk2nQ7HQ5QJgEqspeW3LFL7FrRW5iNc6LSVXs0wz95GRP9+FtLWIG+tuCVrAujMA98
        f5iGNK4aHvKqE4yzd3l1O8RD5Csq6J9xYM+I0BGCAYYJkFQ0lAQEC8RnGAYiv6Ps++CY+4Y/H5V1j
        yHS41hBFDa+fIL4maa6QS6/Pt5LtWLf6UQkZYyRSBoBZ0oxYjV2CQHXMu7dMPGR4zKUM6ElXgjYZF
        tRXPVF1cFf7D1cQ6GLENxSeiqLBwch/OrEtS6Ar1dDfTzFi7CSMV6dShFOqGEIPxCVYNtRe3vXu2G
        8HRYlTgA==;
Received: by mail.as397444.net with esmtpsa (TLS1.3) (Exim)
        (envelope-from <blnxfsl@bluematt.me>)
        id 1pYd4w-000VL8-2S;
        Sun, 05 Mar 2023 01:22:22 +0000
Message-ID: <5e539171-0ea7-fd2c-e041-54d8f9b3097d@bluematt.me>
Date:   Sat, 4 Mar 2023 17:22:22 -0800
MIME-Version: 1.0
Subject: Re: Salvaging the performance of a high-metadata filesystem
To:     Forza <forza@tnonline.net>, Roman Mamedov <rm@romanrm.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <59b6326d-42d4-5269-72c1-9adcda4cf66c@bluematt.me>
 <20230303102239.2ea867dd@nvm>
 <aca66935-0ee5-bdb9-2fbc-eac0e5682163@tnonline.net>
 <a851e040-9568-acf0-a08f-593280350840@bluematt.me>
 <4d17590f-b938-6c6d-93ba-a6a61d3ea475@bluematt.me>
 <a8c6921c-48a4-9511-8df8-5250d819fb46@tnonline.net>
Content-Language: en-US
From:   Matt Corallo <blnxfsl@bluematt.me>
In-Reply-To: <a8c6921c-48a4-9511-8df8-5250d819fb46@tnonline.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DKIM-Note: Keys used to sign are likely public at https://as397444.net/dkim/bluematt.me
X-DKIM-Note: For more info, see https://as397444.net/dkim/
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_LOCAL_NOVOWEL,
        HK_RANDOM_ENVFROM,HK_RANDOM_FROM,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 3/4/23 12:24 AM, Forza wrote:
> Unless you need to, replace relatime with noatime. This makes a big difference when you have lots of 
> reflinks or snapshots as it avoids de-duplication of metadata when the atimes are updated.

Yea, I've done that now, thanks. I'm vaguely surprised this big a footgun is the default, and not 
much more aggressively in the subvolume manpage, at least.

> Not sure if running with multiple profiles will cause issues or slowness, but it might be good to 
> try to convert the old raid1c3 data chunks into raid1 over time. You can use balance filters to 
> minimise the work each run.

I don't think that's really an option. It took something like six months or a year to get as much 
raid1c3 as there is, and the filesystem has slowed down considerably since. Trying to rate-limit 
going back just means it'll take forever instead.

> # btrfs balance start -dconvert=raid1,soft,limit=10 /bigraid
> 
> This will avoid balancing blockgroups already in RAID1 (soft option) and limit to only balance 10 
> block groups. You can then schedule this during times with less active I/O.
> 
> It is also possible to defragment the subvolume and extent trees[*]. This could help a little, 
> though if the filesystem is frequently changing it might only be a temporary thing. It can also take 
> a long time to complete.

IIUC that can de-share the metadata from subvolumes though, no? Which is a big part of the 
(presumed) problem currently.

> # btrfs filesystem defragment /path/to/subvolume-root
> 
> [*] https://wiki.tnonline.net/w/Btrfs/Defrag#Defragmenting_the_subvolume_and_extent_trees
> 
