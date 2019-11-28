Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC9C10CFD0
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2019 23:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfK1WsU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Nov 2019 17:48:20 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:38873 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbfK1WsU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Nov 2019 17:48:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds201810; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Reply-To:Sender:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5NKUtxLDxoWWr0SzQONq2Rj/Vlm46Doz6KFCmY4U1Gs=; b=lmiyH2JOsSAYt5hs10Q19GhNDi
        ntwzooP/KUCFeMAMVRrgefFGF+Lx6ikgXxFBDqVqpvS9dK1Alq0ly+NOtLBNp/OPFkKybNjlUDxy4
        uKs7tdJJGVFU8ExT7P3LMvG1mMyCTBNhouiKIA9d/mv1vix5rMfIt8byGEEguXnub14Fbnw89R6og
        kM+cklDbbJXtEi6EtKUPJrhxDR+6VDxMBbnAKbNIMjpMut8XlG8Yr1slgSsQWzMvK2eD6HG3og8/t
        FcHXEooVXyrtHpQPZlpJOIQ/8gst5xXNHlZXXMBhqx5e+nTV/nKL8HlN3x7BDitliURg37lEenj8t
        kbFbJrLA==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:60186 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1iaSaA-0001GH-0V
        for linux-btrfs@vger.kernel.org; Thu, 28 Nov 2019 23:48:18 +0100
Reply-To: waxhead@dirtcellar.net
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
From:   waxhead <waxhead@dirtcellar.net>
Subject: BTRFS subvolume RAID level
Message-ID: <494b0df1-2aab-5169-836d-e381498f64db@dirtcellar.net>
Date:   Thu, 28 Nov 2019 23:48:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Just out of curiosity....

What are the (potential) show stoppers for implementing subvolume RAID 
levels in BTRFS? This is more and more interesting now that new RAID 
levels has been merged (RAID1c3/4) and RAID5/6 is slowly inching towards 
usable status.

I imagine that RAIDc4 for example could potentially give a grotesque 
speed increase for parallel read operations once BTRFS learns to 
distribute reads to the device with the least waitqueue / fastest devices.
