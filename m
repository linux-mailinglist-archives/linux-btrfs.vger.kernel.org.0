Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBAA969386B
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Feb 2023 17:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjBLQUR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Feb 2023 11:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjBLQUO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Feb 2023 11:20:14 -0500
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DDC11EB4
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Feb 2023 08:20:08 -0800 (PST)
Received: from frontend03.mail.m-online.net (unknown [192.168.6.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4PFCP34DXMz1sB7V;
        Sun, 12 Feb 2023 17:20:07 +0100 (CET)
Received: from localhost (dynscan3.mnet-online.de [192.168.6.84])
        by mail.m-online.net (Postfix) with ESMTP id 4PFCP33p8vz1qqlR;
        Sun, 12 Feb 2023 17:20:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan3.mail.m-online.net [192.168.6.84]) (amavisd-new, port 10024)
        with ESMTP id uVV8pHbhulqC; Sun, 12 Feb 2023 17:20:06 +0100 (CET)
X-Auth-Info: Hgd/GNSuHz2/rGR5m3ZrH3Fz87QgyNZRNGDtprbxCM73fPwtcJmAK6PxrXtraNP4
Received: from igel.home (aftr-82-135-86-52.dynamic.mnet-online.de [82.135.86.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun, 12 Feb 2023 17:20:06 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id B345A2C17DA; Sun, 12 Feb 2023 17:20:06 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     u-boot@lists.denx.de, linux-btrfs@vger.kernel.org,
        Sam Winchenbach <swichenbach@tethers.com>
Subject: Re: [PATCH] fs/btrfs: handle data extents, which crosss stripe
 boundaries, correctly
References: <57ad584676de5b72ae422a22dc36922285405291.1672362424.git.wqu@suse.com>
        <87ttzqsxmr.fsf@igel.home> <87pmaeswjb.fsf@igel.home>
X-Yow:  ..  he dominates the DECADENT SUBWAY SCENE.
Date:   Sun, 12 Feb 2023 17:20:06 +0100
In-Reply-To: <87pmaeswjb.fsf@igel.home> (Andreas Schwab's message of "Sun, 12
        Feb 2023 17:01:12 +0100")
Message-ID: <87lel2svnt.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When I print ce->size in __btrfs_map_block, it is almost always
1073741824, which looks bogus.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
