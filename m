Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D161264FD79
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Dec 2022 03:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiLRC7W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 17 Dec 2022 21:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiLRC7V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 17 Dec 2022 21:59:21 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D9AE0F5
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Dec 2022 18:59:20 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso9867157pjt.0
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Dec 2022 18:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qO8cNrH/FxbTdDGsAcNYzmgOpn5dSXwX/z6vgQre3JM=;
        b=jbdBYFgQMvkU/q9MR7+X2H63u7Zd5AfDDEyJb/hSqK0tl8AUQaw3HVDOt0vXMrCO0u
         2qvYGIsluput/pr0CItE4e6kEmhqkjr5deS4BHdUvbt3Wv60x4+0zUV+DjXNVG6Bslc8
         wAkI16TRy02bHD3NO11sstlZrzImdqHB+RT4JlWyeUGf3ERG06eJJtbnZVA9A6pLwzNC
         2Hdvsayphvwk2wfiiipltXuTLe5KN67nSWX2mNtyu+vNzD1DC0CGPn+ds8LhlDW7+Zgj
         2FrlO51I9GWTD9ywUK3D6X8IQ5aatUVH58AADy2FHyEnBsqUsrCK7ED9D7qTyG4Ru7RX
         tO9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qO8cNrH/FxbTdDGsAcNYzmgOpn5dSXwX/z6vgQre3JM=;
        b=CdSEqMJT8XRDYzt9A6ImGvbR4biJFWNZsy3bSXyEtCp2nXfgwsEklDHKNcY7qNlRQX
         iS5REhRlEmw15JmcqEoLDKILkVPb2Qz74FhEPVztpAT70xd4HzjTgs+BnhkPAdwTnV7+
         OThx9zIDKztqGZQyN4AUDjQbgB5R5wNxPunBitYhJ2mK6YuDwftTtILa9515jN5FJFBE
         L2oBzRDs5FV1cKVpxnqqnyFXhhXBVg/XP/SwU1MH6StYTWvNXqbzS9O39n+SVSTMrnUr
         xVAsp3gZqBp3XutQIPPKTQOBzo+Ud2phKVVbLeIwPq5h08RtOqYsqz22q9Mo2EqlyVpA
         dSQQ==
X-Gm-Message-State: ANoB5pkzx4ipUmWNqZc7E239ueaEL1uQWDAZ94wFG5l/EOrmoFJHfrCz
        6gZdE52UGLj60tPd3CLYy/OOSKkN/i87f72fpdwWZavehtbkYw==
X-Google-Smtp-Source: AA0mqf6YP9HsPZ9ebywmDaaAtK1G2bq3uy8mPCd1RiUdmdoLmxy3265gqjShhfrPyDoOgN3C2vicnDWTgMFhyewxV5c=
X-Received: by 2002:a17:903:285:b0:18b:25d:9a51 with SMTP id
 j5-20020a170903028500b0018b025d9a51mr4812325plr.105.1671332359340; Sat, 17
 Dec 2022 18:59:19 -0800 (PST)
MIME-Version: 1.0
From:   rockjawz <rockjawzd@gmail.com>
Date:   Sun, 18 Dec 2022 02:59:09 +0000
Message-ID: <CABhfcFdNP_1thZr2WAgxZh0BR-iiPb3L_nfVuuO9+XTJqkikhw@mail.gmail.com>
Subject: 
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

subscribe linux-btrfs
