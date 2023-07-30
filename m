Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5047685F0
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 Jul 2023 16:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjG3OLU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 30 Jul 2023 10:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjG3OLT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 30 Jul 2023 10:11:19 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FFFF4
        for <linux-btrfs@vger.kernel.org>; Sun, 30 Jul 2023 07:11:18 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id 71dfb90a1353d-4866be648ffso1239669e0c.2
        for <linux-btrfs@vger.kernel.org>; Sun, 30 Jul 2023 07:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690726277; x=1691331077;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kLN6+RxABNijmIQJDVbBtL/ejAiGsKWYoP+W0sVMAAQ=;
        b=XlQ0wCqld9Dz3P/eEEMslKLeK3koJajP13LAsie89bEuVJaTiyYPlt61iKSNw/tg2g
         vLFI8ccvRtuEiGs/ocXBwe/lqdssFEckIR1CKh5BwOipFm2fbM4R3W4YDe47/vGefjvS
         TriLVfu9gfz+85yI58whgfJtiDWEgW3zbFvN65nKWFqvPIBlTe1uWFMNsbgc/2AwxluM
         7Vdfaq0n2gW3nVO52S9Mc6shQF8lb5AtameE84z/NkkUTMAdPbvfPNcS547zbkvB/Npm
         I4ZX2Wh9Vw0UymlNa43crIeHKzTcOVNvSW0cOEwQACTK4Y0waa7hq0mvq5AUapyhisDc
         L6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690726277; x=1691331077;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kLN6+RxABNijmIQJDVbBtL/ejAiGsKWYoP+W0sVMAAQ=;
        b=HhN/SOWDrDGQZaYuQqh7zvJNnAchLNlPloMXMk3pM3TiVG482KVktMPbCC8TuL2FZp
         LI/AV54KXWIwx2cxiWyLu1ljKnYQuKmAPRYaqD32LqPod2/DG7tOQYxCgWuLvY4ilk+U
         h45xP9cYRjxwU35V2dMPUun5dc1FY3cibJEPhPjb6cL4fnKg3aJY/Jcr6kI+SxC7fw6m
         o5cSliy6xyI6zHftYaMwdT/YpdRQG55MYWNhIOof5Q/0mb4MrJ2pqrJ1FrVIe8Dza3CD
         fujJBaFiwH6WiMpJyCi3P6y0ilxPw3erusaShHZzqxd3Kc9C0G6Mhjj0SyLgK0F2NetU
         lBqQ==
X-Gm-Message-State: ABy/qLbf2JdXCwFRJrypgMtTMBHzl/1pnfM54exVL23ef9BpedDRf2Jk
        h39yZCYpVrszj6w9ci9li5VJypSEV5coU08I5NmyPoft8WU=
X-Google-Smtp-Source: APBJJlEnYTex3c4svY6wYVAq50oCVMTFMmtUTxqMLkxjuZBGS6EWUXjgH4/UzqlsgnmRHHhkSlAp+sR1MOo9hWZqLrY=
X-Received: by 2002:a1f:5401:0:b0:481:65cd:7549 with SMTP id
 i1-20020a1f5401000000b0048165cd7549mr4977510vkb.5.1690726277495; Sun, 30 Jul
 2023 07:11:17 -0700 (PDT)
MIME-Version: 1.0
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Sun, 30 Jul 2023 16:11:06 +0200
Message-ID: <CAA85sZvJy6DgTJ9G83acyM7f3bHO22u70QgX3AnJhy9niDdbbA@mail.gmail.com>
Subject: improvements for users - crc errors and more
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I have a filesystem (actually a raid6 device using md raid) that had
acquired three crc errors due to testing... So, eventually
I decided to do:
btrfs check --init-csum-tree <dev>

I had looked at any way to identify what files were affected by these
three crc errors but to no avail - they seemed to be leftovers from
something that didn't exist anymore.

Anyways, 19 days later (hint, something to handle crc errors and to be
able to say "Oh, loosing data, but ok!" would be much better)
i had a bit of a broken filesystem, it mounted but there was issues
from the crc initialization
(It starts out fast and then slows down to a crawl eventually)

So eventually i thought: "lets see if this thing works... " and continued with:
btrfs check --init-extent-tree <dev>

A few days later it resulted in:
ERROR: commit_root already set when starting transaction
failed to repair damaged filesystem, aborting

I do know that this isn't recommended but i wanted to test =)

And, there should be better ways to handle all of these things...
Wanted to start a discussion about what could be improved =)

While i continue to try to save this filesystem ;)
