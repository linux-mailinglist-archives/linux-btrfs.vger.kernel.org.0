Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533616EB126
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Apr 2023 19:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbjDURuN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Apr 2023 13:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbjDURuF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Apr 2023 13:50:05 -0400
X-Greylist: delayed 467 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 21 Apr 2023 10:49:39 PDT
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3006::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AAA83E7
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Apr 2023 10:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds202212; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=H5JmpAwRhchE8pEuouXgiaEw/e7z8OAT1TRQVFNk9lA=; b=RTkoT+X/p9emjBpP9lZdzFPMBI
        XiRydhLQvT4yh/bQljUK9UlyQtMz90cw57pLlw9AjbBp4kiAUBNqT9aK+PvIXyL+UNRTRgSzlZ/5H
        aoG+n5b12XFT1gNuetqeUJnTYaI3ykNKJcaspdZRu4zPXfFxIgmQ6i19XUNdVFuKXCIsrA5BSK496
        6sVVuF4UMioeSCUc8E6ZZGMGXfdtSxCYneaFtNqrKmT+tleNfJHap+ErTsqCyMSmFUheA/TlHvlsL
        s6sx1ZgwiHIxCydFJPEXapIcRNmdhNBF7bLm8tr9slIpLK0GPo4pSjtELkdZRr7MMcRiZGpm62HK1
        pmxp+5pw==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:57065 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1ppula-0029dX-1D;
        Fri, 21 Apr 2023 19:41:50 +0200
Reply-To: waxhead@dirtcellar.net
Subject: Re: Does btrfs filesystem defragment -r also include the trees?
To:     Remi Gauvin <remi@georgianit.com>, Qu Wenruo <wqu@suse.com>,
        dsterba@suse.cz
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <b7c067eb-e828-35f7-4b26-499173fd07d9@georgianit.com>
 <20230420224242.GZ19619@twin.jikos.cz>
 <6f795670-eae6-6aef-3fd0-dad81bb89700@suse.com>
 <fc0e9969-8414-e947-a768-320516c2eee0@georgianit.com>
From:   waxhead <waxhead@dirtcellar.net>
Message-ID: <59643ed9-3e51-f1b1-3719-a30c3c449f1d@dirtcellar.net>
Date:   Fri, 21 Apr 2023 19:41:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 SeaMonkey/2.53.16
MIME-Version: 1.0
In-Reply-To: <fc0e9969-8414-e947-a768-320516c2eee0@georgianit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> On 2023-04-21 3:57 a.m., Qu Wenruo wrote:
>>
> 
>>
>> I did a quick glance, btrfs_defrag_root() only defrags the target
>> subvolume, thus there is no way to defrag internal trees.
>>
> 
> It did *something* that allows Nautilus and Nemo to navigate a large
> directory structure without stalling for > 10 seconds when moving back
> and forth between subdirectories.
> 
Are you sure that it is not just files being cached?

If you run something like find -type f | parallel md5sum{} on the 
directory/subvolume you can see if it has the same effect.
