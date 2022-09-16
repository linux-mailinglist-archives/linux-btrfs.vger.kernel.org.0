Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3D05BAFA4
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Sep 2022 16:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiIPOxl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Sep 2022 10:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbiIPOxj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Sep 2022 10:53:39 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB102B40D1
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Sep 2022 07:53:33 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id l40-20020a4a94eb000000b00472717928b5so3567178ooi.1
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Sep 2022 07:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=FcyQcUXi9xALQQ6Lm7VNXiWYStBjH/LCUTADg6v4m+k=;
        b=XE1h5id/WRVc+N038P1ofJHEG2ZMBPsob57uMbAFKzWLpA1OkuNwI1il0kueX8SMgb
         6AfoxqfE0yXzmLKZFUtMa37hr56fgXn4jKiHE5lvDwb8URDG9HopdETvAodv5MT2R9XI
         wNeKFqeyCz2b6gyna6LQBlpq5FJBrbO5MuDTtAiNrENfNKH02E5uDgW20HRqPZTyef91
         stUFZfwELQT8zjiUx5sDPrag1gpSOgUGWBnEy255XQltOjv8lC/dX86ELva4Xp5HLb0n
         0pghbqekyzqYxRgFVZbXLD/+KaP3iHVdu0or5WsxZcclMvwj6rSbls1GMkSSVs5n8Vjh
         zFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=FcyQcUXi9xALQQ6Lm7VNXiWYStBjH/LCUTADg6v4m+k=;
        b=O9DtdKpyL3wGfVqHeN3/SamEzph5gGmSYmhUNo9IM3tLtvqD1HaGjKqf6BXqpFfjHr
         6v6LXg/D2vqqDIQ+JZiSQgnHGXi+1o/mX4rPboV6wEHpQOVOsRjYVKO6H0O+Zalh2gxL
         ZGrC9syd/LQb/IhWs2XXAdx0Hv0arbS694tBE8xAHYY7Ym012qE4ixv/kLJSNHxt2aF/
         XJSE23habRNzm9UlROfhIYbz/dAjK6qCqtMJoOlhk/bdt17e221gNt6QWcUSydKUke7V
         MG79c07GLuIJ/d4WbsP4/cK+Cf406lP1nM7AIUgD3yZq2tJIuwF5VaY7DfLHseh4w7OW
         2Heg==
X-Gm-Message-State: ACrzQf36inJ7oxKh1oBa0eFAySWlam8MeW9nFjlDp3bQKFgvMZ47NGEn
        7RPfQFAxV+nsz1smne1zLFEo9Eremt3NJoHmoeA=
X-Google-Smtp-Source: AMsMyM7bNDMUOCBGKtNvM0sAL0fMH+mABHX+9QHfy6QUi9KH/uo0ceBkD2ohX8P8FUgU7iNYNodVdXavL2C3Zx5QAoI=
X-Received: by 2002:a05:6820:507:b0:475:c7d3:5949 with SMTP id
 m7-20020a056820050700b00475c7d35949mr2237219ooj.11.1663340013207; Fri, 16 Sep
 2022 07:53:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:7e8a:b0:a1:ada:7451 with HTTP; Fri, 16 Sep 2022
 07:53:32 -0700 (PDT)
Reply-To: maryalbertt00045@gmail.com
From:   Mary Albert <desouzabayi7@gmail.com>
Date:   Fri, 16 Sep 2022 15:53:32 +0100
Message-ID: <CADVjuPpXVee0zopsvk_tPHTkFxoa6FRm-RcZr-a1Yg6bPgNRZA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:c32 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4970]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [desouzabayi7[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [maryalbertt00045[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [desouzabayi7[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

-- 
Hello,
how are you?
