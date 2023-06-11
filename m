Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5B872B494
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jun 2023 00:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjFKWSF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 11 Jun 2023 18:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjFKWSC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 11 Jun 2023 18:18:02 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3006::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07ABE53
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Jun 2023 15:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds202212; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Reply-To:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=K9KlTYaC9n1sJ/znA+6iw1+/rc2ElRcpf7Dv3POzTzQ=; b=uEE8fXsZMEIPPBKDFRZXC55xjq
        DVu70i9URTzWz9VVkar5o9q718PEyXLBok0F/X4rbP0XFmZPRE9bzRR49rTA5QEt0/GL7iyDEYQWE
        /5Y+bxLmCcXYzbCz1jsfjNIhmo43+eplaDFRK+RLhepuftLvFqD9IvQaaym/xRNVSElSd3VkQgAfZ
        xnt2ayMibqE3K0FdkG69D/CuFy1/z6n4CfEJlIHlIgUez3lfyNYV+wI5ItBWw9+De1ffNfnqRn9fl
        xb8HAkxkdrAwr5/hoEv+SCmg9z9/KEBuk8RrxTnsuITwOuofl04UM0mv6gC+owtCxYFIe16i9OjnE
        ZSc41ErA==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:33508 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1q8TNl-00GhPa-3T;
        Mon, 12 Jun 2023 00:17:57 +0200
Reply-To: waxhead@dirtcellar.net
Subject: Re: Is there a performance difference between RAID10 and RAID1C4 for
 metadata?
To:     Robert Krig <robert.krig@render-wahnsinn.de>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <84574a65-e405-237c-bd0f-834a5254ba3e@render-wahnsinn.de>
From:   waxhead <waxhead@dirtcellar.net>
Message-ID: <6e23245e-f4f3-7e71-2b66-1bc58a77485b@dirtcellar.net>
Date:   Mon, 12 Jun 2023 00:17:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 SeaMonkey/2.53.16
MIME-Version: 1.0
In-Reply-To: <84574a65-e405-237c-bd0f-834a5254ba3e@render-wahnsinn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Robert Krig wrote:
> Hi.
> 
> 
> I have a BTRFS RAID10 Array, which consists of 8 disks that have the 
> same size.
> I'm using Raid1C4 for the metadata.
> 
> Would there be any performance benefits for converting metadata to RAID10?
> Are there any drawbacks, e.g. would it make the FS less resilient?
> 

I am just a regular user, but let me try to answer:

As for resilience, yes there are drawbacks...:
https://btrfs.readthedocs.io/en/latest/mkfs.btrfs.html#man-mkfs-profiles

And as for performance... it depends:
https://btrfs.readthedocs.io/en/latest/Status.html
(read this note: 
https://btrfs.readthedocs.io/en/latest/Status.html#raid1-raid10 )

The usual answer is , it depends test your workload and pick whatever 
fits the bill.

Personally I would love for some optimization to happen on the RAID1Cn 
(n=number) profiles, but that too is not a simple magic bullet. Should 
it be optimized for latency or throughput?

While it may make sense to pick the idle device on the surface, it may 
be better to pick a device which already may have the data you need in 
it's read ahead cache etc... I am no expert on this, but I imagine that 
many of the same principles that the NEST (CPU) scheduler tries to 
achieve would at least in theory be somewhat valid for <insert random 
storage device> as well.
(see : 
https://lpc.events/event/16/contributions/1198/attachments/983/1909/plumbers.pdf 
)




