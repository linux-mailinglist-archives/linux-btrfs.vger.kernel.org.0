Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3566A7689
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Mar 2023 23:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjCAWBD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Mar 2023 17:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjCAWBC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Mar 2023 17:01:02 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCCC3B64F
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Mar 2023 14:01:02 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-536bf92b55cso390555497b3.12
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Mar 2023 14:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677708061;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0WvPIjvJySmeyGBuurh091SczFdPjzfvwwQjXNn6vDw=;
        b=GvkglXU85je4EtR7L5zk+ZZO+JBk8DvJGp2k5G7ROdWoTvzUHsETXL7MnYRjfmDFU/
         PBKqyiYoVYRgsS8pRkYVnnT0GWICg7t3XZP92TjQcXRX/F3F5QfVtRseg1WydoYkjw1a
         /+BXP5mNTczy2jLOS0RuQvpIjpzxJkkFBf2/8sPNNrJnSiT96XTs02ylRoaGBR0+jUut
         +N++aI9GqLoeWvfPATm64CZr5vW5KN4EU7ttPeG+ao6G7/t8TYDBNJXGwK2/Bx8a5MCV
         CjHOOyJcrNr1886q89WARmxlewh2lV6BPaZuDSd0JHgh2FIxtYZy5Yst5S+A8ZXtO+A/
         Cd3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677708061;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0WvPIjvJySmeyGBuurh091SczFdPjzfvwwQjXNn6vDw=;
        b=ttMkZfKYLzw4/tHYK2F+YUIe0/7BqaNZlC6ybWVfNcXS5lj2NPL8Pv9j7hLEP79/Nf
         FTni9rtzCKcL5fHuYCBgJdJTn8tUejzzB+NGmDt3pIDaaQcJf6vsLR85b3lTqsxava8Z
         WGMZ36hCHZ2zeIqyu15pT6ykeOzUfjpmTvzMiM6PfkMAgdOi/RPBA7X0mNelZMtPm9PW
         W78H24f0gQMF1pVRoBpkKxgjfUKBOqNsG7sr3GM8XybBhosjX5CGaHDsoZ6pmO+GzdsK
         IIsA0Oc+b1l3WUX5TBiQqQ35mBCnLNyKWlifq9tYVCUHsUjPU/OYAt/XookDyBSpDApS
         QQ1w==
X-Gm-Message-State: AO0yUKWsvr6+gsJg7ukUpuxXf+zlcJlwCwP0TF3a7Rnzpu7qis9vqjgk
        QJayeXo575jrabNEJJqmmkpIvUomHJofnjS79YY=
X-Google-Smtp-Source: AK7set+gyppOTWFSZGAp2Axb2dhl8RNrkWjUFheUt6hfydDkEPBU8LHbGM5EaxmELypN9WI/KAJLbS8ojCpHzWmWnZU=
X-Received: by 2002:a81:b621:0:b0:52e:b7cf:4cd1 with SMTP id
 u33-20020a81b621000000b0052eb7cf4cd1mr4941419ywh.5.1677708061294; Wed, 01 Mar
 2023 14:01:01 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7108:1702:b0:2a3:49cf:c7d2 with HTTP; Wed, 1 Mar 2023
 14:01:01 -0800 (PST)
Reply-To: fionahill.2023@outlook.com
From:   Fiona Hill <dr.sophia.moore@gmail.com>
Date:   Wed, 1 Mar 2023 14:01:01 -0800
Message-ID: <CAJUx1i_iy2XikQQKbgm8JLu14JMUdgxcRyYao3EKFSuaM8P1vw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

-- 
How are you and your family you receive my message?
