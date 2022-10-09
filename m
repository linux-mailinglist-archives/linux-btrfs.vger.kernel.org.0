Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EB15F8BA0
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Oct 2022 15:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiJINrx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 9 Oct 2022 09:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiJINrw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 9 Oct 2022 09:47:52 -0400
X-Greylist: delayed 177 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 09 Oct 2022 06:47:48 PDT
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA327255B0
        for <linux-btrfs@vger.kernel.org>; Sun,  9 Oct 2022 06:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds202112; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Reply-To:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=c1pSvO7EGCmYNKuN/cDrLRWBnctBBcXXHg68Nb3R4i8=; b=t1pSsvZhdenGCbVPh4efFWr9Wx
        6ChMMJca2NKscvRYqCFAbGVZ3J4OP8SrTnCFCg2BMi/nJ0QdYChQyN0lAYnjR5rE4eDXvffRN9Owq
        TtWN5Fu8eMJJamI0ld2UO4ddrPNJJyjUNkaal5VnnKM6lTS77XnUt+RKyjUyPF5s2jkhNQpU28hNy
        12z5TLCAcFv18WneVeMcFNBZr3wKElJlBsE0vMemKwFXnEBFwpi9SA7nRPp81cda7AK6hQ54XvsyF
        JYlO8YEv089hOly4/VFqZV7+/tPWycPp9nUrTWzmruJrnmA+bIP0AHTqbilonckXTbogVU8IqAoZR
        8mjh8ugw==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:60029 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1ohWbo-0001V4-I3; Sun, 09 Oct 2022 15:44:48 +0200
Reply-To: waxhead@dirtcellar.net
Subject: Re: RAID5 on SSDs - looking for advice
To:     Ochi <ochi@arcor.de>, linux-btrfs@vger.kernel.org
References: <a502eed4-b164-278a-2e80-b72013bcfc4f@arcor.de>
From:   waxhead <waxhead@dirtcellar.net>
Message-ID: <a7bb77fb-2950-30ff-3a24-71cc0bf4512e@dirtcellar.net>
Date:   Sun, 9 Oct 2022 15:44:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 SeaMonkey/2.53.14
MIME-Version: 1.0
In-Reply-To: <a502eed4-b164-278a-2e80-b72013bcfc4f@arcor.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> Hello,
> 
> I'm currently thinking about migrating my home NAS to SSDs only. As a 
> compromise between space efficiency and redundancy, I'm thinking about:
> 
> - using RAID5 for data and RAID1 for metadata on a couple of SSDs (3 or 
> 4 for now, with the option to expand later),

As a BTRFS user I would personally avoid BTRFS RAID5/6 (for now).

Have you looked at this? https://carfax.org.uk/btrfs-usage/

If you are planning to only use 3 or 4 devices there is not THAT much to 
gain from running RAID5 instead of RAID1 so it might not be worth the risk.

The cost increase of slightly larger capacity SSD's may be a much better 
option for you, and thanks to BTRFS brilliant design you can always 
rebalance some years later if RAID5/6 at some point becomes safe.

(Oh, and no matter how robust your filesystem or setup is - if you value 
your data make sure you have tested, working backups! :) )
