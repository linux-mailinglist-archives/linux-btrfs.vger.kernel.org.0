Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4752C693846
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Feb 2023 17:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjBLQBT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Feb 2023 11:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjBLQBQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Feb 2023 11:01:16 -0500
X-Greylist: delayed 1419 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 12 Feb 2023 08:01:15 PST
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355EF11640
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Feb 2023 08:01:15 -0800 (PST)
Received: from frontend03.mail.m-online.net (unknown [192.168.6.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4PFBzF4xBHz1sBpp;
        Sun, 12 Feb 2023 17:01:13 +0100 (CET)
Received: from localhost (dynscan3.mnet-online.de [192.168.6.84])
        by mail.m-online.net (Postfix) with ESMTP id 4PFBzF3fQRz1qqlS;
        Sun, 12 Feb 2023 17:01:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan3.mail.m-online.net [192.168.6.84]) (amavisd-new, port 10024)
        with ESMTP id C-oF_36Pmaem; Sun, 12 Feb 2023 17:01:12 +0100 (CET)
X-Auth-Info: ONXS5SWF5mFOI/PPX38KJ492SQp77lf+rib+hX9vUmjlMKgOThZvBLg9wfrOXbMx
Received: from igel.home (aftr-82-135-86-52.dynamic.mnet-online.de [82.135.86.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun, 12 Feb 2023 17:01:12 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 378352C17DA; Sun, 12 Feb 2023 17:01:12 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     u-boot@lists.denx.de, linux-btrfs@vger.kernel.org,
        Sam Winchenbach <swichenbach@tethers.com>
Subject: Re: [PATCH] fs/btrfs: handle data extents, which crosss stripe
 boundaries, correctly
References: <57ad584676de5b72ae422a22dc36922285405291.1672362424.git.wqu@suse.com>
        <87ttzqsxmr.fsf@igel.home>
X-Yow:  So this is what it feels like to be potato salad
Date:   Sun, 12 Feb 2023 17:01:12 +0100
In-Reply-To: <87ttzqsxmr.fsf@igel.home> (Andreas Schwab's message of "Sun, 12
        Feb 2023 16:37:32 +0100")
Message-ID: <87pmaeswjb.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The length returned by btrfs_map_block is clearly bogus:

read_extent_data: cur=615817216, orig_len=16384, cur_len=16384
read_extent_data: btrfs_map_block: cur_len=479944704; ret=0
read_extent_data: ret=0
read_extent_data: cur=615833600, orig_len=4096, cur_len=4096
read_extent_data: btrfs_map_block: cur_len=479928320; ret=0

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
