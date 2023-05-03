Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6256F608D
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 23:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjECVdb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 17:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjECVda (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 17:33:30 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185077DB1
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 14:33:27 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-55a1462f9f6so44921667b3.3
        for <linux-btrfs@vger.kernel.org>; Wed, 03 May 2023 14:33:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683149605; x=1685741605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MItZf/v0VQ0Yh60SJiYWybpj4oyXmDTTLgT570D5Bsg=;
        b=J6OXVZstVE3HK56GadZRz7/bohEb7DTieI0Xr5Wzws+QBUdHdMA8vgbY0UTdoCO+UV
         0AMtRjhTtX7rxUcftsRAMp7fgXT38AFEcZPMjL/U8XW6f5WGG4tlCz+lWKNcmwNQBDjX
         QE9Q9TE0LmFNHfKZkJiei/MA7FPHLEdTWy3QHKhAYC1zrWouD3iPexQvfAjhvx8NGkAg
         CgrW5nV3UhpPLH1o6Pn5vZLfsAodHge+9KgYpmNcTSnK01sTVe07XWiz+8EVSOU3gX5g
         UaQikAEhE/QXSB+zO6FBkI9kXbJ0YLgFScwoib8Ryvriw81OYXK+LmJxcCPJxrcn++uu
         r5Jw==
X-Gm-Message-State: AC+VfDzl9KW0ajr2QUJo8HXhMNN42m85zz7KIUrd76S6KBE1n0e6C/6J
        +yFIWe+oXgs9P6B37FAzXDRq1nAVZOPMs7aU
X-Google-Smtp-Source: ACHHUZ6kuAbdY0RRdl0YEW6RtN3zjZ81m6z3H/cl/jSDLvPEjQTJi1IFH/t8/xiEI0ScSqaiXkCmDw==
X-Received: by 2002:a81:8453:0:b0:55a:9df1:9505 with SMTP id u80-20020a818453000000b0055a9df19505mr54301ywf.8.1683149605071;
        Wed, 03 May 2023 14:33:25 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id y127-20020a818885000000b00559d9989490sm1078450ywf.41.2023.05.03.14.33.23
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 14:33:23 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-55a8e9e2c53so29192417b3.1
        for <linux-btrfs@vger.kernel.org>; Wed, 03 May 2023 14:33:23 -0700 (PDT)
X-Received: by 2002:a81:5b05:0:b0:556:2699:f3ce with SMTP id
 p5-20020a815b05000000b005562699f3cemr20379361ywb.36.1683149602872; Wed, 03
 May 2023 14:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAHhfkvwo=nmzrJSqZ2qMfF-rZB-ab6ahHnCD_sq9h4o8v+M7QQ@mail.gmail.com>
 <CAL3q7H5yKd1=WuZaU-s7hQ-MwzWONsOtVNoA6cjpLW0-3DDEEQ@mail.gmail.com>
 <CAL3q7H7FyF6YYuMbz0GTBb9G3WYxy9Pr9xQ11rde7jR3zVXuwA@mail.gmail.com>
 <CAHhfkvzQaRtxBqSKodAj2Gy21TMRC_fOd0cq9ECcxnU4QeuV_w@mail.gmail.com> <CAL3q7H6255X42N1gMy78ViXuPw4GExyhv-fptOwi_K3yJvAk1Q@mail.gmail.com>
In-Reply-To: <CAL3q7H6255X42N1gMy78ViXuPw4GExyhv-fptOwi_K3yJvAk1Q@mail.gmail.com>
From:   Vladimir Panteleev <git@vladimir.panteleev.md>
Date:   Wed, 3 May 2023 21:33:06 +0000
X-Gmail-Original-Message-ID: <CAHhfkvwUiSD7EmkQ9WxO-r1ASqXOKEDmePKMvHRAbVdq3sSfAA@mail.gmail.com>
Message-ID: <CAHhfkvwUiSD7EmkQ9WxO-r1ASqXOKEDmePKMvHRAbVdq3sSfAA@mail.gmail.com>
Subject: Re: 6.2 regression: BTRFS_LOGICAL_INO_ARGS_IGNORE_OFFSET broken
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 3 May 2023 at 13:06, Filipe Manana <fdmanana@kernel.org> wrote:
> Ok, great.
> I'll add a changelog and send it to the list.
>
> Thanks for the testing and report.

Hi Filipe,

I have done some more testing on my laptop's real filesystem. Good
news: the patch is 85% correct!

Unfortunately however, out of all randomly chosen logical addresses
that previously returned non-zero inodes with
BTRFS_LOGICAL_INO_ARGS_IGNORE_OFFSET, about 15% still return zero
inodes with the patch (for whatever reason, almost entirely confined
to files in snapshots).

This small change inspired by your patch gets it to 100% for me:

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 799668b35b3c..a59d854db372 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1604,8 +1604,7 @@ static int find_parent_nodes(struct
btrfs_backref_walk_ctx *ctx,
                 goto out;
         }
         if (ref->count && ref->parent) {
-            if (!ctx->ignore_extent_item_pos && !ref->inode_list &&
-                ref->level == 0) {
+            if (!ref->inode_list && ref->level == 0) {
                 struct btrfs_tree_parent_check check = { 0 };
                 struct extent_buffer *eb;

Hope this helps!
