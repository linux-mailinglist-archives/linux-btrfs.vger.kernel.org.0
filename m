Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6926572F403
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jun 2023 07:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242792AbjFNFMX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jun 2023 01:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242806AbjFNFMW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jun 2023 01:12:22 -0400
Received: from mail.as397444.net (mail.as397444.net [IPv6:2620:6e:a000:1::99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD550198D
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 22:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bluematt.me
        ; s=1686717661; h=In-Reply-To:From:References:Cc:To:Subject:From:Subject:To:
        Cc:Reply-To; bh=6Wv0+HTGUU3m28p1NS2bS8ZEpHD2btz4W+ArkZfnX+c=; b=B+xj6x4agZjuD
        0pEQrwoeAQRnORwd5H0pdyv7zZNmJUDRC1mPa+6VZfuaZL6pwVWaHbRQ5Kn9cUO755lQzGj4s89PN
        owSOisCkoqFCk5QKOJbQXUGsOcrlSQ0gBn6E8S4GTQVCxNXTBsL71dk8H34SWU1GViHQW6FWz48nx
        Ne6mFVUTln57d7P0aIKFL1yb/hengienRIT+UWmkTm/EToNOm88sMvHNtSXNIrdrR/RlWjFK69/Nh
        QqWd6hs/6JidYckfv4PlhgMqIa5hqz0ZTBg4DzxSZHuZKFi32oDHUJErpmGaLzQU/PXBT7xjyduQC
        62qzK4AJSDrTs9v3JJing==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=clients.mail.as397444.net; s=1686717662; h=In-Reply-To:From:References:Cc:
        To:Subject:From:Subject:To:Cc:Reply-To;
        bh=6Wv0+HTGUU3m28p1NS2bS8ZEpHD2btz4W+ArkZfnX+c=; b=aiPmXjxuwXY1ZS90vL1Lpe98DC
        YOnDGGgBRemy4lzC410us/wIVS3sIWhsNsin+64cSdMYA+o6ga2dMUx9CiT8gp2w23eYEM6YZA1eb
        a3ZuU5BunpwgjyYgRQiVWZGnxXiDg2FPHsSVx9g0FQlNBl9+V+xLT27O9oXT9nxaiaPdgvTcS4k1V
        dDQ9FRqpLSvGj47wtctFg8YqkCP798k8NT2bG5oDWQ8bQUVUa1T7XFoXZ5IF8m5FglEGOTA7cn/o9
        e4yYMlVpUWrd/qs6kD6AbFmaUrMFlNRpFtRrSvsw692XytWwOiL7derLbwQJk7NMTcHL+XUpATa6f
        5+T0dngw==;
Received: by mail.as397444.net with esmtpsa (TLS1.3) (Exim)
        (envelope-from <blnxfsl@bluematt.me>)
        id 1q9Inq-006Wzp-0p;
        Wed, 14 Jun 2023 05:12:18 +0000
Message-ID: <d5894af1-1ea3-6d38-7c74-b6bc82892916@bluematt.me>
Date:   Tue, 13 Jun 2023 22:12:18 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v4] [btrfs] Add handling for RAID1CN/DUP to,
 `btrfs_reduce_alloc_profile`
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <2895df68-7ff3-5084-d12e-4da1870c09fc@bluematt.me>
 <20230612230026.GJ13486@twin.jikos.cz>
From:   Matt Corallo <blnxfsl@bluematt.me>
In-Reply-To: <20230612230026.GJ13486@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DKIM-Note: Keys used to sign are likely public at https://as397444.net/dkim/bluematt.me
X-DKIM-Note: For more info, see https://as397444.net/dkim/
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_LOCAL_NOVOWEL,
        HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 6/12/23 4:00 PM, David Sterba wrote:
> 
> I'm not sure about DUP, unlike the RAID1C34 profiles where I clearly
> forgot to add them, it's been around since the logic in
> btrfs_reduce_alloc_profile for the fallback.

It wasn't actually a bug until more were added - you can only (AFAICT) trigger this when you're 
converting from one unhandled flag to another, so as long as its only one its okay :)

> With DUP here it would mean
> that a multi-device fileystem could potentially end up with DUP, which
> is supported but may be not desired.

Indeed, but only if that FS/block group already has DUP in it, which seems sensible? If I have some 
metadata that is DUP and some that is SINGLE, probably write more DUP, at least until I start 
balancing it again.

> OTOH as you said above, cancelled conversion between the unhandled can
> lead to the transaction abort. In the distant past cancelling balance
> was not easy and the extended RAID1 profiles were not availabe, so this
> problem is relatively new.
> 
> I'll add the patch to misc-next. We'll need a reproducer for that, I'll
> try to write it.

Thanks!
