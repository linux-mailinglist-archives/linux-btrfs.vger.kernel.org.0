Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE353DAAD6
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jul 2021 20:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhG2SRr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jul 2021 14:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhG2SRq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jul 2021 14:17:46 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63927C061765
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jul 2021 11:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds202012; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Reply-To:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Yu1QahtALPTXXytTgcx5uoQmwmcwUA/jTJvnYlYm+Xg=; b=BBnp7vyaPmLYVhcMNfdWsyjD5h
        TGJg+Wisj6pjKv/jqY4w515de7C9EKorTV8MsNHTwIxXOVhFoJS1XxugQn//wIbe2m3shU+p6quX+
        yo72QGNuaw2ZIzf3xYTiLciJIdoX7i/KkhhfRhuhOwjQJmMDS17ZQLivflpodj+3SOh8bgRTrQ6os
        XzzUVS3ovSiBQltHy64ZpQCAKO4f9vr6DJ/LUUYN+FB/eOPuINhnkP0lrnhsNXVUb9V3i/JIgp3Mn
        mKJ9Sj4REIraaT9Xyf0BXY3b8udX5XW05ibD23C0SGSPCw+U5axXBTVdKVbrNGc8G3V8R4HZAuPs1
        k9jyyj0w==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:46569 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1m9AbE-0001wa-7H; Thu, 29 Jul 2021 20:17:40 +0200
Reply-To: waxhead@dirtcellar.net
Subject: Re: Why usable space can be so different?
To:     Jorge Bastos <jorge.mrbastos@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAHzMYBSap30NbnPnv4ka+fDA2nYGHfjYvD-NgT04t4vvN4q2sw@mail.gmail.com>
From:   waxhead <waxhead@dirtcellar.net>
Message-ID: <24c59f01-97ff-8dc7-2e8c-e33598e317ca@dirtcellar.net>
Date:   Thu, 29 Jul 2021 20:17:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.8.1
MIME-Version: 1.0
In-Reply-To: <CAHzMYBSap30NbnPnv4ka+fDA2nYGHfjYvD-NgT04t4vvN4q2sw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Jorge Bastos wrote:
> HI,
> 
> This is not a big deal, but mostly out of curiosity, I've noticed
> before that sometimes I couldn't fill up a single device btrfs
> filesystem as much as I would expect, recently I've been farming some
> chia and here is a very good example, both are 8TB disks, filled up
> sequentially with 100MiB chia plots, this one looks about what I would
> expect:
>
I am just a regular BTRFS user , and this is just a wild guess - but it 
seems like the small difference in size causes data and metadata chunks 
to be allocated in a different order. E.g. you hit full data before you 
hit full metadata and vice versa.

One thing that confused me when I started to use BTRFS was the concept 
of allocated vs used disk space. I use "btrfs fi us -T /mnt" often and 
from my experience it is perfectly healthy to panic when unallocated 
(not necessarily unused) space is low. This is when I start to balance 
and shuffle stuff around so that I can have at least 2-3 gigs free for 
each device. Anything less than that is in my experience quite annoying.

I know there is a global reserve, but quite frankly I wish BTRFS did 
allocate 3-4 gigs that one might release for use with a magic 
maintenance command.

