Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07726581B14
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 22:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiGZUck (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jul 2022 16:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiGZUcj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jul 2022 16:32:39 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3325C11168
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jul 2022 13:32:35 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id x91so19063014ede.1
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jul 2022 13:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=TCHjfk3yn6FOFV0XiDwQHvDJfHa/K3UJeljyJ4JvCSA=;
        b=UCD5bZqun+Lk3qFkXPeL3nrSSrgFjPdlwZSABp/OsRp/FK0Ph4VomDtjwqDau+kBv2
         hlPMHWai9Ci/b3i5eDyjusOmbSNaeLWRwZw6xVX4l2L2kBbWDbDXyF5j4BoeCOOGw5gF
         3m1NT1h4iy6M0rt8sgZSyTTerj/ptC5R1iiTWHhH+2PwOa1ZHZsJof8JliZFp6QKwZ4J
         2KsXaLz9Kr4ZAzzNuJ5cEPPM44ZzSiduhT/o+xn3XaDwmRpQglbnGrhhJWAaowF+tlaZ
         SjETl1r/fQyrrUC59sA4876MM8YIODGJozY+EeiK+e8aYt7apVtn8YyI5hwG68vv+Uce
         zGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=TCHjfk3yn6FOFV0XiDwQHvDJfHa/K3UJeljyJ4JvCSA=;
        b=PxOMZ6S/rzYYOa0whCRcy5S69H1lZXQfOKd3SOSksHo6gVKBFV3zLDHa1wOjBXua3Q
         CAsO/DLFu3144eIPyceL3QrJqQGaXv7m3UMUJaa8Qsam2G52UWqje3BREMRnf0zFECOE
         kU7pZyi7gocn4T0e2GGySrOBsPu9bhRsXA/B0LmOxSmhFssTOZ2v6W8PQlJwpqpx47Ve
         Po/U4WnKnz/+HteK1wCo4/F3Bhx9cnwvFgBZ0eUsJXyWfgapFgYBCSePWS0X3yag0b88
         G3s/ZDzD8J7rVj9CFMQ5dqVP9b3ttTAgjyisFuBxDVD7eJDNI2o42OG7BB4xrV6TKrvq
         xaCQ==
X-Gm-Message-State: AJIora9A1AF4uV4sDCigBkeP9QxEovNpReBJs7RixN5kHuWwRhTmaZB8
        N7360HQ/Gj2IIYnk8oP3urYVGuWHS9Nk4JR/rQArvcWO
X-Google-Smtp-Source: AGRyM1s56CUtQQ8JyS/kRTsYx8E8G7etYXezCH0YMOuqDRzf/49e0mz5dCaa2x9+9yP7kDyrksV0zPw1EOAUtQIuT5M=
X-Received: by 2002:a05:6402:5c8:b0:433:545f:a811 with SMTP id
 n8-20020a05640205c800b00433545fa811mr19945901edx.101.1658867553552; Tue, 26
 Jul 2022 13:32:33 -0700 (PDT)
MIME-Version: 1.0
From:   Rich Rauenzahn <rrauenza@gmail.com>
Date:   Tue, 26 Jul 2022 13:32:22 -0700
Message-ID: <CAG+QAKUu6TXJqoq=eQczE+CWJCL06bN8oymbSFQVCzXto+fzyQ@mail.gmail.com>
Subject: Combining two filesystems into single pool
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I've spent a little while trying to google for this and haven't seem
to hit the right keywords yet or it just isn't possible.

I have two btrfs filesystems.  These are independent filesystems with
mutually exclusive sets of disks.  RAID1, if that matters.

They are mounted on / -- let's say /A and /B.

I'd like to combine the disks into a single filesystem.  These file
systems are large, so creating a third filesystem and merging them is
not practical, nor is copying /B onto /A.

Could I, say, move /A to a subvolume A in itself and then permanently
"connect" /B as a subvolume B, putting all the disks into a single
pool?  And then mount the two subvolumes as /A and /B?

I'd swear I'd seen instructions on how to combine filesystem pools
before, but I can't find it again.

Thoughts or other ideas?

Rich
