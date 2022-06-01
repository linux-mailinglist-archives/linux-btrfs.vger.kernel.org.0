Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B8653AF32
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 00:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbiFAVQO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jun 2022 17:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiFAVQN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jun 2022 17:16:13 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D1E33E14
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 14:16:12 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id s23so3024813iog.13
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Jun 2022 14:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=I93SjMvC7nFJIWIML9sMncYn9YJZTuce7gnNksY4p2w=;
        b=RC1bTdqX+Jx32T6NNgQ+dyd+PlIAMmC3OcSqAuhcw8kC07cE0F4Kl5nj8CSGQAlMf6
         OAdaR9hZKVjYKEOpmi8rYSYfQt6s9uSpC20EdduZbpP7ugiyO8t5dpJXn/XkCK8u4LyF
         xxI8Kg039r+Ut324qoLnaPLDP2e0EAvdfSYh9yyPWiCf5mOOuf0Frsp5OpHlS3O6jvxl
         WHDZs8EE5K7I631ZD9Yw3STC0MWgx4II14Gif+RzTHqMEgS7HoxhpNsFhlHwIlnxsoFP
         xI1iNzagN9/Bux20bBUx86uGs4lR908KkpUUuLIXNAGxuY/OYCVnm1z3ZFuzkqTjscNn
         REDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=I93SjMvC7nFJIWIML9sMncYn9YJZTuce7gnNksY4p2w=;
        b=BAQG6IDwqeLQXmQDZwgHbSqmsBkjgE+Fai+dkK2YW/f4YRkb55kCB6KM8CSxZJyWdv
         IJ7W2JHXiGGkwlR0VZNiv6i77ZAG7zzBDXewygN0uXsMU9qaWrhqopDDag/TtvSAhIz7
         6epkHhC7ExUUpI9CJ2em9N9fE8tJhvSQRfDx7HXakqn+69Sirrdv9+N7c/CoufF9LO2W
         an+LDWrO5cPwsysKc1UrH0F7njYl+2XzB0UbueLtCVgD4a1K+1kG7cS/DbxUCy1CoP/t
         s5OKEsYLC40AOVgys7ZGnIJrZOstZl4atYjmbFkjUHG2NtLEgt9Vuyv/7pWevmz2mTG8
         rQnA==
X-Gm-Message-State: AOAM533Iv7B0Qxtt/hEg1rokV2dXc5v95PjNM72x/G/Q2XidTt7zmkNw
        kZ41A/ZHNztSCqaF5nI7TLNineWebR3q89BMvA69qb7B/1Q=
X-Google-Smtp-Source: ABdhPJy/AQwplYZQfc2kkwluSWqs7gBdDF8pb1YfY5KU+8G8N/BGhem52GV9hOmJcNGaLL/zTBoD2uX+ncYgNPZrUvk=
X-Received: by 2002:a05:6638:430f:b0:331:5f0a:4722 with SMTP id
 bt15-20020a056638430f00b003315f0a4722mr1310658jab.15.1654118172277; Wed, 01
 Jun 2022 14:16:12 -0700 (PDT)
MIME-Version: 1.0
From:   Matthew Warren <matthewwarren101010@gmail.com>
Date:   Wed, 1 Jun 2022 16:16:01 -0500
Message-ID: <CA+H1V9xQEDf0G-Nvcv3irtSPF+09dJ6VMs7F8LBLpUGEUSfxmg@mail.gmail.com>
Subject: Manual intervention options for csum errors
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I have FS which is currently not in any sort of raid configuration and
occasionally a bit flip will occur somewhere on the disk. It would be
nice to be able to tell BTRFS to recalculate the checksum for that
specific block and assume the data is correct. For instance, I just
had this bit flip in the csum for a non-important file which I have an
external backup of.

Jun 01 15:58:04 planeptune kernel: BTRFS warning (device nvme0n1p2):
csum failed root 258 ino 63674380 off 208896 csum 0xa40b3c39 expected
csum 0xa40b2c39 mirror 1

This is a very clear case of a csum bitflip and I'd like to have the
ability to tell BTRFS that the data is correct.

Matthew Warren
