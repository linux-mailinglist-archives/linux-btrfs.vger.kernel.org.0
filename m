Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE0357D451
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jul 2022 21:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiGUTmi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Jul 2022 15:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiGUTmh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Jul 2022 15:42:37 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B162132B92
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Jul 2022 12:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds202112; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Reply-To:To:Sender:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/mZ3ZnDpcSEE1uT+FTDJf93kWtjFWYVJap4VYwX2XtA=; b=JOoxGp9bbgswRo1bQHSgE96BU8
        VjBlj4K4oUzA5JWACllY3zpvD0wjM1dtfNvzF6JQ5p7CwR040/XVvTGanSnqGmp7RUBbj3FyDhb5T
        2KoKtFAuivcz/+MErAaBTW1tOcjKIChORTvedyYTh8lYFMMq1I1qzppcdAqcZB2h17KicTeYPZXWD
        Xbc734IVrTK0jN6q029+uktppJER3HJs93sWVomZSLRYvnGZyiWnfWKJ+lBTUARfDhZUEhXEh4aI7
        PG3awqaWj0+IGKPWqrvm1iCks98Nd3qFDO1tvleRiElejRdEELnaW8HBRvU6fMpS2AKbzCML3OE1u
        RsnTB1tg==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:9381 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1oEc4A-0002pp-EY
        for linux-btrfs@vger.kernel.org; Thu, 21 Jul 2022 21:42:34 +0200
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Reply-To: waxhead@dirtcellar.net
From:   waxhead <waxhead@dirtcellar.net>
Subject: BTRFS online manual , search function is not working
Message-ID: <237fa9e9-af23-b71f-f3fa-3ef8375116b1@dirtcellar.net>
Date:   Thu, 21 Jul 2022 21:42:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 SeaMonkey/2.53.13
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Howdy,

Searching for stuff on the manual pages on readthedocs.io does not work 
on browsers based on older code such as SeaMonkey 2.53.13

Works fine in chromium so this must be some of the chromeifying things 
that happens more and more across the web. This is a bit like the dark 
ages when things required IE on a certain nasty  platform.

Perhaps another platform is better suited for manuals? After all it is 
"only text" so why make it difficult?

https://btrfs.readthedocs.io/en/latest/search.html?q=compression&check_keywords=yes&area=default#

