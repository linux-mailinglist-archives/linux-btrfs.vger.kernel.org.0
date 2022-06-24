Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E38555A486
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Jun 2022 00:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbiFXWzt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jun 2022 18:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiFXWzs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jun 2022 18:55:48 -0400
Received: from rin.romanrm.net (rin.romanrm.net [IPv6:2001:bc8:2dd2:1000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961C186ADA
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jun 2022 15:55:46 -0700 (PDT)
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
        by rin.romanrm.net (Postfix) with SMTP id 175895D8;
        Fri, 24 Jun 2022 22:55:44 +0000 (UTC)
Date:   Sat, 25 Jun 2022 03:55:43 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Forza <forza@tnonline.net>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: FSTRIM timeout/errors on WD RED SA500 NAS SSD
Message-ID: <20220625035543.2c65c834@nvm>
In-Reply-To: <fae6e07f-6ad3-218c-f220-c8b159d5ec3c@tnonline.net>
References: <98c43f5e-2091-b222-edad-632caef9f9e3@tnonline.net>
        <20220624233722.05038e48@nvm>
        <fae6e07f-6ad3-218c-f220-c8b159d5ec3c@tnonline.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, 25 Jun 2022 00:45:55 +0200
Forza <forza@tnonline.net> wrote:

> I have tried lowering the discard_max_bytes, but it did not help - on 
> the contrary it takes much longer to do the blkdiscard /dev/sdf and does 
> not solve the problem.

Should be possible to verify exactly which size discard requests are being
submitted to the device, using https://linux.die.net/man/8/blktrace

In no event requests larger than discard_max_bytes should be seen.

If lowering it does not help, perhaps after a sustained stream of those,
some individual requests, even small, start to take longer than 30s?

> However, since btrfs-progs do split discard ranges into smaller chunks, 
> and that ext4 seems to handle this as well, I think it is worth looking 
> into handling.

That's not something to be handled on the FS side, even if one of them
happens to work, by luck. I suggest to focus on diagnosing with blkdiscard
only, and proceed to FSes only after that has been made to work reliably.

-- 
With respect,
Roman
