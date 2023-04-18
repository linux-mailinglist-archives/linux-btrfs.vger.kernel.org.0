Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185816E5796
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Apr 2023 04:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjDRCnl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Apr 2023 22:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjDRCnj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Apr 2023 22:43:39 -0400
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3CD44AE
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Apr 2023 19:43:37 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 5BC03C01E; Tue, 18 Apr 2023 04:43:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1681785816; bh=NxmyHPijekriopNxvfOCOrCMMhHehRTR4DDzqrywo40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y+vxVS45ADyqNGlzArJ6OiR7FUHT99rd+03/Rlo4Ug6ZLOJkqDfI9cPLUU4h7xHIc
         MiXtX+OXlUpO2TZCtfRglP10ka2/2ZpKKR8XEt9h2PmA3K9ocFaxfI6Qb/eSKJY9BH
         p77M3Q4FAIyCi5d3qFcv/PnD573Tuhgi9xc7sE7cJ02N2Ck7iyIuRiN913FzbS80Md
         BvobV3TtxCIMqORPf6Oz1Gcqwe1V3m80Oep/MC9aTIqneCfwJ+j7+1wvuin+70xZkU
         MZjZksWHvPLDImu6r+/7jmWZda5xMV464GgyVMmTT5yTxZ5NmSE8eIAaY/Ae3/ZPZe
         c0pwv+LJOWXkA==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id EDBA8C009;
        Tue, 18 Apr 2023 04:43:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1681785815; bh=NxmyHPijekriopNxvfOCOrCMMhHehRTR4DDzqrywo40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SPi1S+FE99KVC1B0KjZXe/l/LBSssQ15mHKyYtgdzpoFD5RRa//Z2vyaI7vqLykc7
         m9Bnv4B4/Hfah4Kn/u2tzCbIFEJVAqfQGnZGpI5NNGS4/DypO+IDlHu4fG5udDTE5C
         st1RymzR7d3l4cXFfZKcFpIFs5VztyQOGHcQ1byJzfb0ml+gEewT5BMawMFtGpOFDZ
         p4p4PR5JRG85lEplEMEU5MVT18KeSKr5JlkTMXyb/5NwvqfXAR3S17SID+dnpkO/yh
         OAJm91y27+U9rPk8N1pKkLN20d7yiN9nYQEYs4FDKocf9xVgGSCLzaUQA0S59Io5e+
         ORpSCJt9qkV5A==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id fe51b019;
        Tue, 18 Apr 2023 02:43:31 +0000 (UTC)
Date:   Tue, 18 Apr 2023 11:43:16 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        u-boot@lists.denx.de,
        Dominique Martinet <dominique.martinet@atmark-techno.com>
Subject: Re: [PATCH U-BOOT 3/3] btrfs: btfs_file_read: zero trailing data if
 no extent was found
Message-ID: <ZD4DxM9lCGnAsSzN@codewreck.org>
References: <20230418-btrfs-extent-reads-v1-0-47ba9839f0cc@codewreck.org>
 <20230418-btrfs-extent-reads-v1-3-47ba9839f0cc@codewreck.org>
 <ef27f8e9-df8f-316a-eb90-e2227572c910@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ef27f8e9-df8f-316a-eb90-e2227572c910@gmx.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qu Wenruo wrote on Tue, Apr 18, 2023 at 10:04:56AM +0800:
> > This is a theorical fix only and hasn't been tested on a file that
> > actually runs this code path.
> 
> IIRC there is a memset() at the very beginning of btrfs_file_read() to set
> the whole dest memory to zero.

Right, sorry.

I'll drop this and send a new patch that removes the duplicate memset
(at "The whole file is a hole" comment) instead as seeing multiple
memsets is what made me think it'd be necessary without thinking; that
can be done even if we rework the function a bit in later cleanups...

-- 
Dominique Martinet | Asmadeus
