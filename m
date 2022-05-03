Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C443518262
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 May 2022 12:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbiECKfM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 May 2022 06:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbiECKfH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 May 2022 06:35:07 -0400
Received: from rin.romanrm.net (rin.romanrm.net [IPv6:2001:bc8:2dd2:1000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F23221250
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 03:31:32 -0700 (PDT)
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
        by rin.romanrm.net (Postfix) with SMTP id EF1D9758;
        Tue,  3 May 2022 10:31:29 +0000 (UTC)
Date:   Tue, 3 May 2022 15:31:28 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Neko-san <nekoNexus@proton.me>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [Help?] "errors" found in fs roots
Message-ID: <20220503153128.6a641de6@nvm>
In-Reply-To: <20220502222210.6893657f@nvm>
References: <8hH0EBKfKaciK1_cX-iqDutaxznwCYo_pJp5SCgfxC-qGnmQ6-YWHJx69Mi0N2akRh-OZOedEPGeHCUqguEnMXM8Kqz13pHUxZw6hwp05AM=@proton.me>
        <6mLGKEfkxtWN7Z-dUziEgizAdclo0RftcmcYG74zaXY1F0hgqeknrqKc5CGo0IjliM7_2BAp515jR3X1OJ5GzqTG8-QWOPDe56goD2dSZm8=@proton.me>
        <20220502222210.6893657f@nvm>
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

On Mon, 2 May 2022 22:22:10 +0500
Roman Mamedov <rm@romanrm.net> wrote:

> It could be most people thought it was too much of a barrier to entry to just
> "take a look". I have downloaded your files and attaching them to this E-Mail
> now. Let's see if it goes through -- raw files didn't, but in gzip it's not
> anything huge after all.

I'm not a Btrfs developer, so not sure if those btrfs check errors matter much
or not.

Some general advice though, maybe you could try command-line tools to resize?

I always do:

  - btrfs fi resize to a lower size than planned, to leave some safety
    headroom (10-100 GB) and not get bitten by any possible GB vs GiB
    confusion;

  - resize the partition with GNU fdisk, or the volume with lvresize;

  - btrfs fi resize again, this time to "max", to fill the exact resulting size
    of the partition.

-- 
With respect,
Roman
