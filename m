Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7183ED145
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Nov 2019 01:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbfKCAfj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 2 Nov 2019 20:35:39 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:51795 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbfKCAfi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 2 Nov 2019 20:35:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds201810; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Reply-To:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=is7Dxud5F0DzlaQt+cSkIjkZIYC+w9tPrNrfzfmgjUg=; b=EzS1AumSAMv7NRROtBuOPxb8rc
        jHs4uZDy+egkaAm2TIwopVk1gzySteW4HYM0mn7z4HTbC7DTz7Mit97bfD4+OC6xd+FjvqkrVkQAf
        UeYog1sXCJtONyhX47S4CkPDt0Vfb63+RZY7YkFrEOxb+8dhrpq2+vGeINNXBpGr09HvypVEXbJI/
        C4bmteui1i21nGNmE9HbCI2Ye3MvymKOvVqZSw/jZPvVOXcByVD/ZRLIdYqsY7OB6pPgDM4OeUQkw
        thdHUm17WVnlW8lx+7zMEF7QFEUkuklU097O5857PxwzK++n5chazR4ch9IdYQ5GOdDiglxbGqqy3
        WLKbxrVA==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:2292 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1iR3rk-0003y1-Lm; Sun, 03 Nov 2019 01:35:36 +0100
Reply-To: waxhead@dirtcellar.net
Subject: Re: [PATCH v3 0/4] RAID1 with 3- and 4- copies
To:     dsterba@suse.cz, Neal Gompa <ngompa13@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <cover.1572534591.git.dsterba@suse.com>
 <CAEg-Je_oNz5BtpRAF3fzfX1G-Dhh7yjpshyy47NwLaREWv0wBQ@mail.gmail.com>
 <20191101150908.GU3001@twin.jikos.cz>
From:   waxhead <waxhead@dirtcellar.net>
Message-ID: <6e3f215f-e3e1-c7f9-c5dc-b89762ef6886@dirtcellar.net>
Date:   Sun, 3 Nov 2019 01:35:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.5
MIME-Version: 1.0
In-Reply-To: <20191101150908.GU3001@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Would GRUB be able to boot from RAID1c34 by treating it as "regular" 
RAID1?! If not I think a warning could be useful.

David Sterba wrote:
> On Fri, Nov 01, 2019 at 10:54:45AM -0400, Neal Gompa wrote:
>> What's the reasoning for not submitting this for 5.4? I think the
>> improvements here are definitely worth pulling into the 5.4 kernel
>> release...
> 
> Because 5.4 is at rc5, new features are allowed to be merged only during
> the merge window, ie. before 5.4-rc1. Thats more than a month ago.  From
> rc1-rcX only regressions or fixes can be applied, so you can see pull
> requests but the subject lines almost always contain 'fix'.
> 
> A new feature has to be in the develoment branch at least 2 weeks before
> the merge window opens (for testing), so right now it's the last
> opportunity to get it to 5.5, 5.4 is out of question. No matter how much
> I or users want to get it merged. This is how the linux development
> process works.
> 
> The raid1c34 patches are not intrusive and could be backported on top of
> 5.3 because all the preparatory work has been merged already.
> 
