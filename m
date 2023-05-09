Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228416FD1A0
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 23:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235884AbjEIVsI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 May 2023 17:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjEIVsH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 May 2023 17:48:07 -0400
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C21640EB
        for <linux-btrfs@vger.kernel.org>; Tue,  9 May 2023 14:48:06 -0700 (PDT)
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id 5EE375FDEF;
        Tue,  9 May 2023 23:48:04 +0200 (CEST)
Date:   Tue, 9 May 2023 23:48:04 +0200 (CEST)
From:   Christian Kujau <lists@nerdbynature.de>
To:     Chris Murphy <lists@colorremedies.com>
cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: btrfs-transaction stalls
In-Reply-To: <ecd355db-e252-4993-97c4-1987963507cd@app.fastmail.com>
Message-ID: <dcc34c41-f7c8-e8b2-0a78-c134a257a8db@nerdbynature.de>
References: <837c4ca9-7694-4633-50b8-57547e120444@nerdbynature.de> <8a3f47c0-5b0f-a6c8-d1c4-714e3251b9eb@nerdbynature.de> <61025b77-2057-5a90-032b-f36ffa85deb4@gmx.com> <1a1a6ccf-25f9-d362-d890-8a609ff743f2@nerdbynature.de> <7d4287c6-e854-e79a-874a-0f76ea4285a4@nerdbynature.de>
 <ecd355db-e252-4993-97c4-1987963507cd@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 9 May 2023, Chris Murphy wrote:
> On Tue, May 9, 2023, at 8:30 AM, Christian Kujau wrote:
> > After upgrading from Fedora 37 to Fedora 38 the problem did NOT magically 
> > go away (heh!) and I've run another full balance (and a scrub too), 
> > although this did not help much in the past.
> >
> > I've since switched the mount option from "discard" to "discard=async" and 
> > the problem has not recurred....yet :-)
> 
> There are some edge case performance issues with async discards that 
> should be fixed in 6.2.13 or newer. I suggest upgrading your kernel 
> andremoving the discard inhibition so it is used (the default). And 
> report back if it fixes the problem or not.

Well, Fedora 38 has 6.2.14-300.fc38.x86_64, but I had these weird stalls 
right after the upgrade to F38 again. But "discard=async" (instead of 
plain "discard", which defaults to "discard=sync") appears to help. Knock 
on wood.

Christian.
-- 
BOFH excuse #299:

The data on your hard drive is out of balance.
