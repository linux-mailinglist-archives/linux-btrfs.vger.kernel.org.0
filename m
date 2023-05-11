Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291616FF1F3
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 May 2023 14:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237827AbjEKMzn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 May 2023 08:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237865AbjEKMzm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 May 2023 08:55:42 -0400
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D111106
        for <linux-btrfs@vger.kernel.org>; Thu, 11 May 2023 05:55:39 -0700 (PDT)
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id DBC855FABE;
        Thu, 11 May 2023 14:55:36 +0200 (CEST)
Date:   Thu, 11 May 2023 14:55:36 +0200 (CEST)
From:   Christian Kujau <lists@nerdbynature.de>
To:     Neal Gompa <ngompa13@gmail.com>
cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: btrfs-transaction stalls
In-Reply-To: <CAEg-Je_Cjiy8ajwDrHrLfxxnx0xv91Jq4tca+Lc_gTm4h7q5rw@mail.gmail.com>
Message-ID: <272faab0-1195-3263-8d01-44b5d89adb37@nerdbynature.de>
References: <837c4ca9-7694-4633-50b8-57547e120444@nerdbynature.de> <8a3f47c0-5b0f-a6c8-d1c4-714e3251b9eb@nerdbynature.de> <61025b77-2057-5a90-032b-f36ffa85deb4@gmx.com> <1a1a6ccf-25f9-d362-d890-8a609ff743f2@nerdbynature.de> <7d4287c6-e854-e79a-874a-0f76ea4285a4@nerdbynature.de>
 <ecd355db-e252-4993-97c4-1987963507cd@app.fastmail.com> <dcc34c41-f7c8-e8b2-0a78-c134a257a8db@nerdbynature.de> <f73c20ae-f52a-436f-9fa4-6e3839d4b9a6@app.fastmail.com> <c3e3578b-cb09-9643-caca-e52172c18578@nerdbynature.de>
 <CAEg-Je_Cjiy8ajwDrHrLfxxnx0xv91Jq4tca+Lc_gTm4h7q5rw@mail.gmail.com>
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

On Thu, 11 May 2023, Neal Gompa wrote:
> So what's probably going on is that "discard" triggers sync discards,
> whereas having nothing or specifying "discard=async" will do async
> discards.

So, Chris wrote to me the following:

-------------------------------------------
It's fixed in dev and just hasn't found its way into Fedora yet.

commit 93d51b286c848bc21900c105ce9fae1286ff65b4
Author: David Sterba <dsterba@suse.com>
Date:  Wed Apr 26 12:42:39 2023 +0200

    btrfs-progs: docs: mention discard=async in mount options

    Issue: #617
    Signed-off-by: David Sterba <dsterba@suse.com>

https://github.com/kdave/btrfs-progs/issues/617
-------------------------------------------

And discard=async is the default since Linux 6.2, even when no "discard" 
option is specified at all. Interestingly, the current version of that 
file[0] still reads:

 > In the synchronous mode (sync or without option value),

...which I find somewhat counter-intuitive:

* no option means "discard=async"
*   discard means "discard=sync"

...I would assume that "discard" defaults to "discard=async" (since this 
is the default with 6.2 kernels anyway) and only with "discard=sync" one 
can force its synchronous mode. But either way, the man page has been 
corrected now and my weird stalls appear to be gone now too, hooray!

Thanks,
Christian.

[0] https://github.com/kdave/btrfs-progs/blob/master/Documentation/ch-mount-options.rst
-- 
BOFH excuse #42:

spaghetti cable cause packet failure
