Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F644B406E
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Feb 2022 04:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240044AbiBNDlB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Feb 2022 22:41:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240068AbiBNDlA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Feb 2022 22:41:00 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430FF56220
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Feb 2022 19:40:54 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id g145so13422624qke.3
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Feb 2022 19:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=N9tEFmJ5EUuxB+3+X+96jFuGp4B/wZQHGYlWHIoC8HU=;
        b=lgq5VSHmw1DzybGE9MZPvq6ebia8CZi0hVHBV1jwBsoOxRXIBbIjHPa1swFxPdK8+o
         MTX8ZYONcHVSA5X4hOKrWvP9HKsb1bmEkG07vu+bqGvbh+iEI3chxPMUEPaqvMbTmQuk
         pKVcMtix58Ef6hdVP1cmH67gFgpd4FgPlrohwdp9037XR2RgtYpk4vUw8gKcAbbLn4qG
         xxFpTmrhx4J5n513tpNU1iHEAjpLGWnNlOXBXCEzgAJK/c5zwng5ralV1SKET7oyYYKj
         4L7FS2k3JUMgVyidQDVar3tQR5qf5TWzK+migTxcwWgvP0Cw0IdiRcxkVomu/8sjGFPK
         f10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=N9tEFmJ5EUuxB+3+X+96jFuGp4B/wZQHGYlWHIoC8HU=;
        b=zdv9pUns7GQeE96URgE++2LpRQGFBnQIgNI5tFj35N2jVnz4ETDV6fLbRgnmfUF0bj
         xkhRmdXuG4j8EL6ApmWdCpJCQmxrs0t55NRS3abOZPX9wqH9D4oaRfM/8nBN4MfW3Hxs
         qym40XG6ngWsx8GEeXJsNewMaAQmZEb8HaV3UTdMHM1EEr3PsanflT1A0BCprFa/+N9Z
         mKyT4D1fAg+KdXwTjgGC+EQUPJCgMV4woUDoPiulKKqJ3wnFE1mH7gGWyD4kZjzyoZhM
         whcLYwLzCPOLJ3dDrzVpkSfFHH0AqGgcjrDbngqUpc5erODCuUF8Cc5yW9dVO9iofQD7
         EIDg==
X-Gm-Message-State: AOAM533vhow3VO7wuHvoTaex7Z5Oo3cWF5VzU1v6D77HLrHn1jfmvKec
        fUavEVLHcU0at7cW2AIGpNPVN3dzA5bz1Gj+Qgg=
X-Google-Smtp-Source: ABdhPJzVD2DMsBQHEQ/jabn+sv24I/iBASj817U7wNplUaAVtkM+uV0T9AQy/LuuxCz2tcyEn4Q1DkjHYi9g6etaQaM=
X-Received: by 2002:a37:ab16:: with SMTP id u22mr6030964qke.785.1644810053496;
 Sun, 13 Feb 2022 19:40:53 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ad4:5c69:0:0:0:0:0 with HTTP; Sun, 13 Feb 2022 19:40:53
 -0800 (PST)
Reply-To: tiffanywiffany@gmx.com
From:   Tiffany Wiffany <ivanroberti284@gmail.com>
Date:   Sun, 13 Feb 2022 19:40:53 -0800
Message-ID: <CAKp8dfrorvQkstMgwhkU1jnCLJ5v52S9GNMO=gcyqqUiWcP7FQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

-- 
Hello, Please with honesty did you receive our message we send to you?
