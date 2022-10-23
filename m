Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63382609515
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Oct 2022 19:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbiJWRTq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Oct 2022 13:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbiJWRTl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Oct 2022 13:19:41 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA6555A9
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Oct 2022 10:19:33 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id m6-20020a17090a5a4600b00212f8dffec9so1694735pji.0
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Oct 2022 10:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DXGFRRl8QKqIOt8okkG2YA5y9wwKi4Y+4+u6oVSDjFI=;
        b=fF+cWRHIBAMZU6kocUWQe+kpmiq7oLc3WEd+rnQXFKDAejmCnbz3Srjy5QBQClP5+J
         fXELRGx6VqEp9IfKXgJWu/BBlvXgo3DEfC7LPTkoLXclFrHghqujVz8lRTj895zh27yD
         LtyNqny7f458ySYzEF7yIFenM5QHcjV2E1aP3jIEmIGTbzYtxPbkKM7QGsxy9wuZh8nY
         sxeU2QQKGANt9b1lfJA9a+I9wUaZV2foeTHeB5uuilt80sWW1Ba6OihXcATWFTiTlXit
         ps0UGOvC1cjK7ro7BBza7qb/uHIgvZSbFnHpDAL0U5nk8D7WsDhrcWgJDOqpOYVGm/+5
         TsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DXGFRRl8QKqIOt8okkG2YA5y9wwKi4Y+4+u6oVSDjFI=;
        b=oiuOaIeBXlhNVCM+tItTdjlA4IrT6mnDDWchel4Pux0TlxzMR6iLrj8ZyhxKnEc/1e
         mq7ozbPqg8Vgns+fBL9LXEFjZICdeEMmM3e/eSa2yvMaQfos8dYBaotxA3XZ2u2YYxOX
         eU3sXrdkpbf3QpjRgWeatQdizLwK8bKp0wVbwQ6f8x19XUsCqN2IxaBaHAszNdep+TXD
         P/P1cvNjqqAGumd1QOQv3oJVkvztfaaUNqYg/hfbXCFJLGSsZI+aLAd9eIJyvy+9HkzB
         lawWnKj73ipfVwkndyI5qaRjSsDnFOyypbumAQ73XDbCYsoPkcEX7fiCQYAgxwzf8Chg
         Ms/Q==
X-Gm-Message-State: ACrzQf31rUdMyi/0e5RWU9BnsYzIkNfiHGIBnuKSk1X/f/njhAGotYff
        3rYVJPPgdRInqAKeR+LsNWZmKHL07OzaoWqz249zzVT6ELo=
X-Google-Smtp-Source: AMsMyM4OLKMPDyGUQOY/A71JptLkv2T9mmePFGSR/8o76VU0kSBSS8w+BwY9WhgFAqi+mc8853R80SHHILMjqS9MKBU=
X-Received: by 2002:a17:903:2452:b0:186:99e0:672d with SMTP id
 l18-20020a170903245200b0018699e0672dmr5177698pls.95.1666545572450; Sun, 23
 Oct 2022 10:19:32 -0700 (PDT)
MIME-Version: 1.0
From:   Tobias Powalowski <tobias.powalowski@googlemail.com>
Date:   Sun, 23 Oct 2022 19:19:20 +0200
Message-ID: <CAHfPjO-gtcdvzgjm1o5NdS0bRy8ukyROH24UhWUATn6ouj07yw@mail.gmail.com>
Subject: 6.0.3 broke space_cache=v1 devices
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SHORT_SHORTNER
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,
https://bugs.archlinux.org/task/76266
as talked to darkling on IRC here the report for the ML.
My servers got broken with kernel 6.0.3, downgrading to 6.0.2 solved my issue.
My btrfs was using version 1 of space_cache, after upgrading it to version 2
6.0.3 worked.
greetings
tpowa
-- 
Tobias Powalowski
Arch Linux Developer & Package Maintainer (tpowa)
https://www.archlinux.org
tpowa@archlinux.org
Archboot Developer
https://bit.ly/archboot
