Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F84778582
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Aug 2023 04:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbjHKCfx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Aug 2023 22:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjHKCfw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Aug 2023 22:35:52 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3AF171D;
        Thu, 10 Aug 2023 19:35:52 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d9443c01a7336-1bc73a2b0easo12200245ad.0;
        Thu, 10 Aug 2023 19:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691721352; x=1692326152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udzCkL4eC0y3DNVQdpkulppZYCE1gWkbBMtzmbo6Y/g=;
        b=f1Rx5ylLWpDeFvr5Owo0LL90bdr1UNyB2XZeMTDd7ep/0cVWe1PIi0r6TPqpEu6dF+
         26rfrEtGWBeMq/A8TMtRXUQ/87Y5NyPN1xoT3+O2ScTo60NggS2HdnkeUv2pY3eyRNha
         c3dXsXJpBrcWrxHDbxqDI5xJMGPsy928ruQjKU3OPLmUTM3F2VEU1qlhIcxjuDS7pSSA
         Z+IDRo0G00O68EJGLyV2rRi5Ij6v0vDlOgqf/Y9mYD19jjDAj9qZTL7D9sBfMW51HvxP
         3e/EbLJgbX8aW3I/5vp6/2aXnF8FGosXaxLe6MVh9f8pqUxi7JYprjFmiO0qBFxIo1R4
         J4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691721352; x=1692326152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=udzCkL4eC0y3DNVQdpkulppZYCE1gWkbBMtzmbo6Y/g=;
        b=iD6yw3taITb1tFXk/L2ML4BP7MkuXT8Q4787inGJV53LjLWsTqWrBLX/BLqwrBzcwK
         WdcZGDqtYmNz2Sk+Lx2AzP19NzjehAMMAChnvQdcAyMpa9ey9Y0hwL/yAa32vDR+h35s
         fwfNI7BFkypomrq6gCDYe0lVzm/iJ5V2Lb77Ky1SECAs655ZHo9vZ67KAzBK2Vdv2QxD
         PTbFZDxqzK+UncBU5dFDhA+QDF4/8yyUVg5Y/yXS+2Vq0qDmjQcYUnAGtzXM9K9taN7v
         Yl6stAJ36UxVNsDfEQvPGN8SUJ1+rRFLnSFDq+/XXC2engnM49OyeYpL1mPORz0sZ9+Z
         W6Mw==
X-Gm-Message-State: AOJu0YwtuhNZYdVDMVX0N1eprRC8PvbnYhaVVYI5n0jVqz+C9+V+1AhT
        xgmqcUZaRmgG6U37dNgMM9s=
X-Google-Smtp-Source: AGHT+IEhyTETw/pSMNNVfsy+W46OMIlvmkbJrnO2VPCz/skUiyl9dcAS0S8konHN2jLw3adtih6AKw==
X-Received: by 2002:a17:902:c409:b0:1bd:b8c0:b57e with SMTP id k9-20020a170902c40900b001bdb8c0b57emr246501plk.40.1691721351754;
        Thu, 10 Aug 2023 19:35:51 -0700 (PDT)
Received: from localhost.localdomain ([218.66.91.195])
        by smtp.gmail.com with ESMTPSA id b13-20020a170903228d00b001ab2b4105ddsm2503071plh.60.2023.08.10.19.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 19:35:51 -0700 (PDT)
From:   xiaoshoukui <xiaoshoukui@gmail.com>
To:     dsterba@suse.cz
Cc:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiaoshoukui@gmail.com, xiaoshoukui@ruijie.com.cn
Subject: Re: [PATCH] btrfs: fix return value when race occur between balance and cancel/pause 
Date:   Thu, 10 Aug 2023 22:35:47 -0400
Message-Id: <20230811023547.25423-1-xiaoshoukui@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230810120501.GA2420@suse.cz>
References: <20230810120501.GA2420@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The first thought to solve the problem was to use locks, but after practice,
it turn it out that this would made the original code even more complex.

The way of tracking status may just a workaround solution. The better solution
may is to refactor balance relevant code.

I think interface provided to the user is very important for reliability.
Looking forward to a better solution, If needed, I can take some effort
for testing and reproducing.
