Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DEF676C65
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Jan 2023 12:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjAVLlf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Jan 2023 06:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjAVLle (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Jan 2023 06:41:34 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30C51E5E1
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Jan 2023 03:41:33 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id jl3so8985947plb.8
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Jan 2023 03:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ceremcem-net.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U5i9sBk4tIoVpUfSJ0Ct9+aRampCHNSNf8XqmCksxME=;
        b=Bz9HeMKJVSDYT61MwndOw5kBo+slOfeHA0Nbti/88WoHvCk6soOkkRAwySngha15oU
         hIRsFKhXCw/jNhKI0uk34ay8UjA2O9AbG2g6ip8P5SsMVt3j0Zo8XizrGkHG5LgOPZKK
         FPu7F4NZTP3PEOdVhE4/38B+A08szFatlWSlwWrKgE19j3BMo+GVsezIoioS/LkH+De6
         9pn0zAOH88r0HzOIVdbB+gT5OPFpWD20SQ2d6PglBbYsjmYMISBptFW0ZHkJNITjVJUe
         jBMRnuDtG2vlW4kfRcjy/G5ujtpBO++kbgNKoJLpOopqi+CMWQJ3DbPaQ+L0f6q8GY5c
         A/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U5i9sBk4tIoVpUfSJ0Ct9+aRampCHNSNf8XqmCksxME=;
        b=DAz/wCKcQ+yaScsW0g1y+Y0uQqNxObpSeDdgQ/1z6Ujnh4wXu/sZTaKhdh/HQPC7ir
         3M7oELEAuUEXIseY9Fp4o+RXpu8+jAyPMjwiUn2+QzHZsJ3vVmmFlZX7d2aZ6V4aoLag
         /58ayCkLoLh8ScvFhgFK+SXm8EvbDQQMcituxXIKxKW42b2qx4sqxaMYbbguV3Wsiqmo
         jCKYoK8jq5KQUm+pcRul4+3nH0+7pyxZoIwXSrmNTUAqotcOVjJPIvkSaWIhXF7/sV3X
         jpHFqNW7Bhxin8Bw37nBHOJvaU380Uwq1T3E1v1h1bkXEfodZvAIzRW5gLosFTWnBqcQ
         9Oog==
X-Gm-Message-State: AFqh2krkrtD1NVK67mFd3mHOC5/RQvIK2y7o6h7zbzlCZllpJpa0VSXc
        nq+3Rx7kgTo4D1OmYM1xvqI6H1Ayua2acsWzQDHiBtlyL0D0KrxqXHg=
X-Google-Smtp-Source: AMrXdXuZE0aVFQY7bXMP3ZLpfMs8+FbZNTx9Nx1rR3ct2DtEnzzNFI70Qh4ortSKpINNkEP8GQ1J+DGOGrs9ny8qA0g=
X-Received: by 2002:a17:902:b217:b0:191:10b0:5fa5 with SMTP id
 t23-20020a170902b21700b0019110b05fa5mr1821940plr.34.1674387693076; Sun, 22
 Jan 2023 03:41:33 -0800 (PST)
MIME-Version: 1.0
From:   Cerem Cem ASLAN <ceremcem@ceremcem.net>
Date:   Sun, 22 Jan 2023 14:41:22 +0300
Message-ID: <CAN4oSBcsfBPWUc9pwhSrRu5omkP7m8ZUqhFbF-w_DwQJ3Q_aSQ@mail.gmail.com>
Subject: Will Btrfs have an official command to "uncow" existing files?
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Original post is here: https://www.spinics.net/lists/linux-btrfs/msg58055.html

The problem with the "chattr +C ..., move back and forth" approach is
that the VM folder is about 300GB and I have ~100GB of free space,
plus, I have multiple copies which will require that 300GB to
re-transfer after deleting all previous snapshots (because there is no
enough free space on those backup hard disks).

So, we really need to set the NoCow attribute for the existing files.

Should we currently use a separate partition for VMs and mount it with
nodatacow option to avoid that issue?
