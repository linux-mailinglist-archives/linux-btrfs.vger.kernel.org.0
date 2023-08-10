Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37074776FBD
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Aug 2023 07:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjHJFpf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Aug 2023 01:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjHJFpe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Aug 2023 01:45:34 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805B3DA;
        Wed,  9 Aug 2023 22:45:34 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id 98e67ed59e1d1-267fc1d776eso306831a91.2;
        Wed, 09 Aug 2023 22:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691646334; x=1692251134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuSObd534A3IY1uBWocTgVjAhB7hKNDF4r8Xon2NDVQ=;
        b=kahje2phyEh4Ui7/cr6TZqyoTj70jN5ZdEGS68YUv+6a1sa3Ukz7sket7OjJp2W4L7
         ZcmLVaKnq/bDqJ5yZuPVkA1eCdMegMc76If/VO8Vjo/hnCW6GIVzoa7bwNa82ikVu7fl
         wOZLrFpmNwTRs43a43uJj9CxwUTMbyZ2iQXU7P5UrPTjYP1/u6FIyBoRiMVqdNA6B96r
         LDlafNZ4Srw+aG9jRwBO2IHzYmtvbuXDDg75cYDI1Fo9rvXtFpUbIgc7Naz4gJqC5RfF
         QC84A0aDJ+lYu/5bvonZLHRCrdfIdDwpj2QEpO6q2+JBzaSROKHdVBvnadza2xNUjOaQ
         cbaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691646334; x=1692251134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FuSObd534A3IY1uBWocTgVjAhB7hKNDF4r8Xon2NDVQ=;
        b=DGxHiw1IWpqqsnRmhXeD/YB09g6ZUSoGhF9f01QKMDn3ZI6whe3MaROh2MH06zGKzd
         8gEwQQMrsvwaxCvR33fKGRRJyLBN4PASdfqn9d+18MDowOEdjbqp0OsrH2nDuqJiE2Dv
         zwnzS7ZguKo8Nsiy6zL4RoSUpcWazTSbMNZQEpoZOkdhUhnFTskF6q5N74d2hiNnLeiX
         9kDHeOik/WYaFFTK2qYuhOreOE4YAHTvQZlpoJv4h4OZ2F65AX2vpMXJQbZnVFMtW1Fl
         YEUYx4fag6pVKP+nka9SrEb5W75dcZna/h0662sl+l5scBUpark1iWr1es6lm7v1INtc
         RNDA==
X-Gm-Message-State: AOJu0YzHec/7TJO9Gs1Kcb8wHrbGxIGmqhyqwv+QiNUqTPWmYqoy23qO
        /SSfS160lQcIx36wc8vyMA4=
X-Google-Smtp-Source: AGHT+IEVcXFu7m/6GBEkmOtRMhgDcvLO7HGTENK6NAaLXT7Z1BG3AYO5RuuPhs5AH4mPu1hSZN6HUw==
X-Received: by 2002:a17:90b:4a0b:b0:268:2500:b17e with SMTP id kk11-20020a17090b4a0b00b002682500b17emr1028196pjb.23.1691646333881;
        Wed, 09 Aug 2023 22:45:33 -0700 (PDT)
Received: from localhost.localdomain ([218.66.91.195])
        by smtp.gmail.com with ESMTPSA id gd10-20020a17090b0fca00b002635db431a0sm573336pjb.45.2023.08.09.22.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 22:45:33 -0700 (PDT)
From:   xiaoshoukui <xiaoshoukui@gmail.com>
To:     josef@toxicpanda.com
Cc:     clm@fb.com, dsterba@suse.com, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiaoshoukui@gmail.com, xiaoshoukui@ruijie.com.cn
Subject: Re: [PATCH] btrfs: fix race between balance and cancel/pause
Date:   Thu, 10 Aug 2023 01:45:29 -0400
Message-Id: <20230810054529.24149-1-xiaoshoukui@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230809131600.GB2515439@perftesting>
References: <20230809131600.GB2515439@perftesting>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> They're just two different issues.  My patch is concerned with the panic, yours
> is concerned with getting the correct return value out to the user.

Agreed.

> Rebase your patch ontop of Sterba's tree with my fix and send it along, getting
> an accurate errno out to the user is a reasonable goal.  Thanks,

Send the patch through below thread, pls review. Thanks.
https://lore.kernel.org/linux-btrfs/20230810034810.23934-1-xiaoshoukui@gmail.com/T/#u
