Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB3332A11ED
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Oct 2020 01:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgJaA2C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Oct 2020 20:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgJaA2B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Oct 2020 20:28:01 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C67C0613D5
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Oct 2020 17:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds201912; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Reply-To:Sender:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HpOVGxJDRbP2Rz1i1DFFog+YxfgS78XizC3e07j+EKk=; b=Iv2m7Td8LFN8IlWTqXiotIAchc
        jhJNr+0DD9GhZqFwHlaMEEufH+4qu3g5WYNe9yBxUXYv2O4lRoeeAeT97CfWRv3zD/Ah9n96IL8sQ
        6Fwt8qS8iyAdb4+UqIEextzmV6RSjEIq4oAtItf26EBEHPjXdhimzJW0l9AsbOjmphnkRmTIuCTnz
        0GqAQgnBq6DQIAj7SMge4aEZKMOn6tlv47fx1uf56iMEAq/LLXB8L4DkIezaEfLi3WDDrYM4gOVUa
        IL4kvxg6jybkg56UPpOU0tn+4Y/AnRrcCSwz8i95N10yrW50Im6jI0fvqbplpx1oGXwdqiahbttc3
        bdfs2qwg==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:47475 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1kYekP-0000UO-Ia
        for linux-btrfs@vger.kernel.org; Sat, 31 Oct 2020 01:27:57 +0100
Reply-To: waxhead@dirtcellar.net
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
From:   waxhead <waxhead@dirtcellar.net>
Subject: Switching from spacecache v1 to v2
Message-ID: <fc45b21c-d24e-641c-efab-e1544aa98071@dirtcellar.net>
Date:   Sat, 31 Oct 2020 01:27:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A couple of months ago I asked on IRC how to properly switch from 
version 1 to version 2 of the space cache. I also asked if the space 
cache v2 was considered stable.
I only remember what we talked about, and from what I understood it was 
not as easy to switch as the wiki may seem to indicate.

We run a box with a btrfs filesystem at 19TB, 9 disks, 11 subvolumes 
that contains about 6.5 million files (and this number is growing).

The filesystem has always been mounted with just the default options.

Performance is slow, and it improved when I moved the bulk of the files 
to various subvolumes for some reason. The wiki states that performance 
on very large filesystems (what is considered large?) may degrade 
drastically.

I would like to try v2 of the space cache to see if that improves speed 
a bit.

So is space cache v2 safe to use?!
And
How do I make the switch properly?

