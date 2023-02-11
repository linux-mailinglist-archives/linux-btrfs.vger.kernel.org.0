Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD71692D6A
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Feb 2023 03:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjBKCkw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Feb 2023 21:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjBKCkv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Feb 2023 21:40:51 -0500
X-Greylist: delayed 3862 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 10 Feb 2023 18:40:50 PST
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3006::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A53F79B14
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Feb 2023 18:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds202212; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Reply-To:To:Sender:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gF1ykXRcGzvr3c8Bm44PLSR86iqb/m5PoQR9eM5phR0=; b=t2pu+yxQmhJcdibEoNg7N90VRy
        76S6dnH97gkfdx4g2IOOxpjL3ylS2PnP3NL2gBRoXvZtMW74ynIZDUI7/GcWS9rCIAfnAbYz177LA
        aONBZbzP3CHMf10TTwGntCzO3rlINU564y0AI7JmlewPG2ZpODCuQvmMiSVHuU7kNuN4fx992dobD
        0ZBqITQMKSDdCjsY5tQU6TGuFaiPcYRVGhEry1ACzkiWdBUQn3E0nEHT163WLYSZD/qwLfgmCCbL3
        hzMXL6T8EWFSIPr9j22/s74DdxWnDQx9utFh9XljuMEBJugQEUJqRx/yVtctwL80tuQ96iyjj+9bM
        XmEEN8qQ==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:41009 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1pQeoU-00ENHx-Bt
        for linux-btrfs@vger.kernel.org;
        Sat, 11 Feb 2023 02:36:26 +0100
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Reply-To: waxhead@dirtcellar.net
From:   waxhead <waxhead@dirtcellar.net>
Subject: Never balance metadata?
Message-ID: <ad4de975-3d5f-4dbb-45a5-795626c53c61@dirtcellar.net>
Date:   Sat, 11 Feb 2023 02:36:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 SeaMonkey/2.53.15
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I have read several places, including on this mailing list that metadata 
is not supposed to be balanced unless converting between profiles.

Interestingly enough there is nothing mentioned about this in the docs...
https://btrfs.readthedocs.io/en/latest/btrfs-balance.html

Should one still NOT balance metadata? If so - please update the docs 
with a explanation to why one should not do that.
