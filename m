Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A5F2CCAD4
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 01:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbgLCAC2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 19:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729167AbgLCAC1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 19:02:27 -0500
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA5BC0613D6
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 16:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds201912; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Reply-To:Sender:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ma49YYE7b5Xnmh4CWLquJ8SIX1BPyMjRANniUs47okA=; b=Zq2K98miO9I8bB4kfYnk2LRvmK
        2ZSBGO/amqHjYR7fL0UdvPRt8qHg4vILmrbd8oh5tSCDtSK1LTnBjJoIS38ypKZR4G0pkK43Atmr1
        SSLlByNL+tMMfU+emjleODEyw6JFmhCvvmDyKFclEElUk1Cd/hSzvh2L9ozJ2ihxT+5dyU2rupSpn
        /3n13rVu26OnPUo7u7fKJowm9nm7OZKAVVt8zpbGzAVWsuzzUQ7Gi3/IwsICIHhqgTULzt8a5l2RH
        tr1ZUGOR69CL8gC5sCqj7TPeuJAO3FMnRjBD/ZJD4Y60+1uDH4QJE1si0LEGl6WWg7g0TBPE1T+1T
        rfh0em0A==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:54090 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1kkc3p-00083q-IC
        for linux-btrfs@vger.kernel.org; Thu, 03 Dec 2020 01:01:25 +0100
Reply-To: waxhead@dirtcellar.net
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
From:   waxhead <waxhead@dirtcellar.net>
Subject: BTRFS RAID01 (not RAID10)
Message-ID: <93714091-aa62-796d-9466-3382f7ec67c0@dirtcellar.net>
Date:   Thu, 3 Dec 2020 01:01:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I caught myself thinking how RAID10 on BTRFS is really handled. Yes, I 
understand it is on chunk level , but is RAID10 in BTRFS terms really 
different from RAID01?

I always assumed that BTRFS RAID10 stripe over *half* of the available 
storage devices and then mirror it on the *other half*?

If this is indeed true , then why not consider RAID01 e.g. stripe over 
*all* the available storage devices and duplicate e.g. mirror it.

More or less essentially RAID0 with DUP. While this would not be as safe 
as RAID10 would it not be worth it, especially if the mirror is an 
"inversed" stripe. so that you perhaps could still reconstruct all data 
in case of a disk failure or corruption on one disk (assuming that BTRFS 
checksums the stripe invidually pr. disk)
