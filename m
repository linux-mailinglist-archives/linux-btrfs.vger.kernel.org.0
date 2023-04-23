Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88906EBE4E
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Apr 2023 11:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjDWJeq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Apr 2023 05:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDWJeo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Apr 2023 05:34:44 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3006::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7ED4199A
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Apr 2023 02:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds202212; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tHBgLeM+WWjkoRoNlyL1wLhKG6Lqv8BHTb4Gy3h8JM0=; b=UqKxYBB1SPN8uUg0OVZeFquhyV
        sWG3PhQtVkyujK4wmiqXGqXFYahIBH5q94relFE0HF4Sq18bF6zRgy1tFwr+nrrjNuh86whHzmtAA
        ReAW9vz6hefDy7rZEuChD2bmMfHe2BzjWL+wXKhoxqhkDiADL2sKyGQ2x3xyoyRodB2uwYMHTTXE5
        kz+896tvR/fattPzeBmsj1sWFW5ea3jFRiCVcfhquHY1tc/pBM6z2UkZdUv1ZGJ93iCnD5W+YGFj1
        r30JoIdJ6eugV/+CiYw2/ZzlzlwVm+EJfcrnOt77ka0rRNk8E6zxSedomlJq0V+RoquUlVM9AOELq
        oYE2m7mA==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:8429 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1pqW7C-008KqG-SV;
        Sun, 23 Apr 2023 11:34:39 +0200
Reply-To: waxhead@dirtcellar.net
Subject: Re: Does btrfs filesystem defragment -r also include the trees?
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, joshua <joshua@mailmag.net>,
        Qu Wenruo <wqu@suse.com>
Cc:     Remi Gauvin <remi@georgianit.com>, dsterba@suse.cz,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <44-64431b80-5-7f085200@250139773>
 <cd4024f7-3ff6-328a-08f5-7f405d5a9491@gmx.com>
From:   waxhead <waxhead@dirtcellar.net>
Message-ID: <1fbcdce2-a268-aa1d-1e6c-bb1e61e18ad9@dirtcellar.net>
Date:   Sun, 23 Apr 2023 11:34:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 SeaMonkey/2.53.16
MIME-Version: 1.0
In-Reply-To: <cd4024f7-3ff6-328a-08f5-7f405d5a9491@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> 
> On 2023/4/22 07:25, joshua wrote:
>> For my situation, (and others with large arrays) yes definitely.
>> It's definitely the feature I'm most interested in patiently waiting 
>> for....
>>
> 
> You can already compile the current btrfs-progs release with 
> experimental features, which enables the "btrfstune -b" command to 
> convert your existing btrfs to the new feature.
> 
> I believe David would release the next btrfs-progs with bg tree moved to 
> regular features.
> 
> And even better, the new bg-tree feature is compat_ro, meaning 
> unsupported kernel can still mount the fs RO.
> 
> Thanks,
> Qu

And for those of us that have BTRFS as root? Would we live happily ever 
after or would GRUB choke on this?
