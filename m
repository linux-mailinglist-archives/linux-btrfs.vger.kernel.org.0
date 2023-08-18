Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4B078041F
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Aug 2023 05:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357393AbjHRDDS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Aug 2023 23:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357374AbjHRDCs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Aug 2023 23:02:48 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83A61BB;
        Thu, 17 Aug 2023 20:02:46 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d9443c01a7336-1bc5acc627dso3586715ad.1;
        Thu, 17 Aug 2023 20:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692327766; x=1692932566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=guHiRKlirR8C+e5VcfvEe5Nv59i+xY9rOHB85rBOPzM=;
        b=CDhc2RxbAhpq4KgWYz5OglgpMh9oUNWIh3heUYfWl0a6C6C/2yIeU8EuQjn68et0FC
         eJk50As/0Y45kz8vx5fW1emOy6z+CdST/m7yH+JQRe0vLVvy+2rncQjbcl4mKoyxjRU4
         XGqqn2hNGtck5qKxdmRsj4AE6HeiEZ+ppCXpZwPZc4n4umupiupXr1J+vESwuXZ0fovw
         MsY4CQZ7BCKtG7t2N2a0ysJrPsMAjWiW/Kj09WuLIQ73jl+RbrEoW2K7+riOb8y9OTDL
         3fBEUZz1FqXfEBJ+PjeQbD4J57TnioryzZl0mSjKZHstAa0eJXLpJwN5/J7Z/e7FviQu
         OA1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692327766; x=1692932566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=guHiRKlirR8C+e5VcfvEe5Nv59i+xY9rOHB85rBOPzM=;
        b=gvne/3ZWsTyGAEZ7hKG5SkO7JPmr5GXXM6WiDYwWYR7uSizbWQeyrKVBnUpUQt1EzI
         XvPrMtoeo7deXamBafVUTRKhok5ppNdBCOYHtfL93t6k/wj1r3FzmmyIwEIXOq3wFKgx
         FsRARvBp+hHTRg90lnDk8JWboNT8J2BG54frrc5ZWIrRpaSV7ezbdp1oOzCtXgFVi6Xh
         4y+h8pE9Z+Q49JN6DCLQaP4AjGlTG46ptYNSVIsWl8Kio7u6CsumpGglpmUiHh8IFbQM
         X02y/49ITK6O/dAmDwycdQXZQuOPgRvcZivYnOV3BcksolmQSIQ1r1YGWUiMee3TJjw5
         BmAQ==
X-Gm-Message-State: AOJu0YwPbY9MATqsYjxbh1jYvDofXxs9lK0oz+BTCjkrDA6vbbIRvPZ7
        R4nVFN5AbFr71qDs5wMLKWY=
X-Google-Smtp-Source: AGHT+IFZFQyh3hI2zlW9OufJZUpB6gDe9gAoLK2NQCkEwxOXkw2EJo5neGz1zxMstYrt7r2Gxq80TA==
X-Received: by 2002:a17:902:d2c5:b0:1b5:edd:e3c7 with SMTP id n5-20020a170902d2c500b001b50edde3c7mr1552818plc.16.1692327766213;
        Thu, 17 Aug 2023 20:02:46 -0700 (PDT)
Received: from localhost.localdomain ([218.66.91.195])
        by smtp.gmail.com with ESMTPSA id o4-20020a170902bcc400b001b88da737c6sm503035pls.54.2023.08.17.20.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 20:02:45 -0700 (PDT)
From:   xiaoshoukui <xiaoshoukui@gmail.com>
To:     dsterba@suse.cz
Cc:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiaoshoukui@gmail.com, xiaoshoukui@ruijie.com.cn
Subject: Re: [PATCH] btrfs: fix BUG_ON condition in btrfs_cancel_balance 
Date:   Thu, 17 Aug 2023 23:02:39 -0400
Message-Id: <20230818030239.39524-1-xiaoshoukui@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230817121135.GL2420@twin.jikos.cz>
References: <20230817121135.GL2420@twin.jikos.cz>
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

> Seems that it's from times the balance was not cancellable the same way
> as now. Also it's a good time to switch the BUG_ON to an assertion or
> handle it properly.

That's the point. Canceling the balance only takes into account the normal scenarios.
Replacing the BUG ON here with an assertion would make the code cleaner.

> I'll change to to ASSERT, this is really to verify that the state
> tracking works properly.

The ASSERT and BUG ON macros have already helped us uncover many hidden issues. 
