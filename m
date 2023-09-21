Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBBA7AA51B
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 00:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjIUWdO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Sep 2023 18:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjIUWdO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Sep 2023 18:33:14 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3006::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A723691
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Sep 2023 15:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds202212; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Reply-To:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1ZsWsJbG101JNQS6pfUiu8eHboTDIhQZadadiXdeJLQ=; b=vDAmnsvY2mNYe1oBOpyvEpq7gt
        cZ0cDw8/K2H+Ckp5i/6Gj6mOqXoA3Jspmw4bgmmzlHgfhO/E1m5OuvJCcaLB4Qppl15J4Ph15oTyZ
        tGpSYMtIUB5hIgZHIg1ADKkTOvebmPwleQVycXRxHyQwI/z28PX2iKoc+NJhtQhMgjjIpHG0F03xl
        tsttkBXxUhPX95WqFrmhXry0hqaeXmH3K7LtMnoUZxootlE0LyOoJrxxhCAz6uDUUTHrqTvo1Ldec
        tl7iN3+Zvzqo/Pka0zeanJ7HqgS2uY3Wi8YuL2oMwwp8mPiCBejRNHoD94kH/DLZVaVSQPvDV2biY
        SuEneEWQ==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:11036 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1qjSEK-00E1zs-Nt;
        Fri, 22 Sep 2023 00:33:04 +0200
Reply-To: waxhead@dirtcellar.net
Subject: Re: [PATCH 0/7] btrfs-progs: cmds/tune: add set/clear features
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1693900169.git.wqu@suse.com>
From:   waxhead <waxhead@dirtcellar.net>
Message-ID: <81c4792e-b7d9-73ab-452b-d840917ebbee@dirtcellar.net>
Date:   Fri, 22 Sep 2023 00:33:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 SeaMonkey/2.53.17.1
MIME-Version: 1.0
In-Reply-To: <cover.1693900169.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qu Wenruo wrote:
> This is the first step to convert btrfstune functionality to "btrfs
> tune" subcommand group.
> 
> For now only binary features, aka set and clear, is supported,
> thus uuid and csum change is not yet implemented.
> (Both need their own subcommand groups other than set/clear groups)
> 
> And even for set/clear, there is some changes to btrfstune:
> 
> - Merge seed feature into set/clear
>    To enable seeding, just go "btrfs tune set seed <device>".
> 
> - All supported features can be checked by "list-all" feature
>    Please note that, "btrfs tune set list-all" and
>    "btrfs tune clear list-all" will have different output.
> 
As just a regular BTRFS user I would like to please ask you to consider 
having functions that may have consequences e.g. "dangerous" functions 
disabled until enabled.

In other words much like you need to arm a missile or flip a safety 
cover on a toggle switch

So if btrfs on every mount set a bit that disabled access to dangerous 
functions (such as the tune functionality you would have to explicitly 
enable it to be able to do scary stuff).

btrfs tune enable
btrfs tune whatever_needs_tuning=123
btrfs tune disable (manually disable scary functions)

And yes, I am aware that root users have powers to do scary stuff, but 
sometimes even root users need to be protected against free will.

Please consider something like the above...
