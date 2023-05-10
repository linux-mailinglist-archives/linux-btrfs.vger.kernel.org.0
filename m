Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0231C6FD6A0
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 May 2023 08:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbjEJGR6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 May 2023 02:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjEJGR5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 May 2023 02:17:57 -0400
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6027272C
        for <linux-btrfs@vger.kernel.org>; Tue,  9 May 2023 23:17:55 -0700 (PDT)
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id E1792600F3;
        Wed, 10 May 2023 08:17:53 +0200 (CEST)
Date:   Wed, 10 May 2023 08:17:53 +0200 (CEST)
From:   Christian Kujau <lists@nerdbynature.de>
To:     Chris Murphy <lists@colorremedies.com>
cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: btrfs-transaction stalls
In-Reply-To: <f73c20ae-f52a-436f-9fa4-6e3839d4b9a6@app.fastmail.com>
Message-ID: <c3e3578b-cb09-9643-caca-e52172c18578@nerdbynature.de>
References: <837c4ca9-7694-4633-50b8-57547e120444@nerdbynature.de> <8a3f47c0-5b0f-a6c8-d1c4-714e3251b9eb@nerdbynature.de> <61025b77-2057-5a90-032b-f36ffa85deb4@gmx.com> <1a1a6ccf-25f9-d362-d890-8a609ff743f2@nerdbynature.de> <7d4287c6-e854-e79a-874a-0f76ea4285a4@nerdbynature.de>
 <ecd355db-e252-4993-97c4-1987963507cd@app.fastmail.com> <dcc34c41-f7c8-e8b2-0a78-c134a257a8db@nerdbynature.de> <f73c20ae-f52a-436f-9fa4-6e3839d4b9a6@app.fastmail.com>
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
> That is confusing.

It is! :-)

> If you do not specify any discard mount option, 6.2 kernels default to 
> discard=async.

So, ever since I installed this system (Lenovo T470, with an NVME disk) 
the "discard" option was added (by me or the install routine) to the mount 
options of the root disk. And btrfs(5) on this Fedoa 38 system (the man 
page says "6.2.2" and "Mar 26, 2023") states:

   discard, discard=sync, discard=async, nodiscard
      (default: off, async support since: 5.6)

So, the I'd assume that no discard option means...no discard. But you are 
saying that "discard=async" is now default, when the option is not 
specified at all?

The man page further states:

  In the synchronous mode (sync or without option value), lack of 
  asynchronous queued TRIM on the backing device TRIM can severely degrade 
  performance

...but I did not know that until a few days ago. So, I thought: "OK, I had 
'discard' specified for ages here, and that defaults to 'discard=sync', so 
better change that to 'discard=async' now." And ever since I did that 
(i.e. since last week) these weird stalls are now gone.

> If you are manually specifying only discard, you should get async 
> discards, not sync discards. I think sync discards is a bug. Surely with 
> 6.2 kernels and newer it should be async, but arguably it should be 
> backported to all stable kernels still accepting changes. If not 
> specified, async should be implied.

So, I'm not using vanilla Linux, I'm using 6.2.14-300.fc38.x86_64 from the 
Fedora distribution, but I doubt that they patched the man pages, as they 
sure state something else here: "discard is off by default, and discard 
without options defaults to sync". Or I'm misreading the man page, that's 
entirely possible too :-)

Thanks,
Christian.
-- 
BOFH excuse #230:

Lusers learning curve appears to be fractal
