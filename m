Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB106AB372
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Mar 2023 00:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjCEXUc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Mar 2023 18:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCEXUb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Mar 2023 18:20:31 -0500
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3006::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A89A13517
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Mar 2023 15:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds202212; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Reply-To:To:Sender:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1CQYjH7ouKJEv0A7Z6KhpBXyzL7OqejMcjuUWAK5PQA=; b=Fyc8CskvNiNh/d45CY3kxZ+IA2
        HbGFA3jVsPkTqWt+lqWuToGIip1XeNfmVSvWQWvgipkZDmCpJZHRy7mG7bzDACUw9qkEaiOchR+Jp
        FH8DrP7FntcSWsOzj7o6Ks40yEuTKingFAlhAxpRLkBaGnxaOtDtcJ+alf4mEj6fmYuaiks6tjzGZ
        WuRRw2hhAdJI+LoQKASjeDO/AZfqLTjjcGg93fOzNw8PSsvKcYCzdmB1/TAs7Ass00xR4bxe/3MOL
        1jjMFSbvKjmHcm6TlvaA6K8CcgKn9Qlymtk7vUu8PBgmZ8Buw1IgzBGVaemTJ0zEc5GpWeLBC9wl7
        ApkFlkbA==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:21479 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1pYxeS-002l8G-SD
        for linux-btrfs@vger.kernel.org;
        Mon, 06 Mar 2023 00:20:25 +0100
To:     linux-btrfs@vger.kernel.org
Reply-To: waxhead@dirtcellar.net
From:   waxhead <waxhead@dirtcellar.net>
Subject: IO scheduler for BTRFS ?
Message-ID: <e60699bd-1cba-0adb-f9f3-dacf54d1948b@dirtcellar.net>
Date:   Mon, 6 Mar 2023 00:20:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 SeaMonkey/2.53.15
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Just out of curiosity , is there are benefits / drawbacks / problem 
spots regarding I/O scheduler choice for BTRFS filesystems?

Since BTRFS can work across multiple storage devices one could in theory 
have a filesystem with different schedulers for each storage device.

So if the I/O scheduler matters at all as far as reliability goes, are 
BTRFS tested on a particular I/O scheduler... for example mq-deadline? 
and would changing it to for example BFQ potentially be undefined behavior?

In any case, what are the recommended I/O scheduler for BTRFS?

