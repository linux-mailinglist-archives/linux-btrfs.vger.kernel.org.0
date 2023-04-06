Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED536D8FDF
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Apr 2023 08:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235376AbjDFG6o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Apr 2023 02:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234923AbjDFG6n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Apr 2023 02:58:43 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43140DE;
        Wed,  5 Apr 2023 23:58:43 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso42048841pjb.0;
        Wed, 05 Apr 2023 23:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680764323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pjE1y6DkcSyhBXk4ShnrpQHXjNrs31wVH2hslBoMcec=;
        b=pLMEf0HOaZ8z/9lmwlxlMapKlCYhOCsrfTosTAEhZXsz8a05gzvkP8pe611RvWvbx3
         a+D9Ozdl55bTmnZ74z0BBF7jMmsPLkT/COwVgyKe1JvXAiKHHRphfHnQvRHltC4y3U9l
         oXiYFX4Jq1D41OBsvYWKtpUPoTj2pwFQPYxGGQ9/n+rlJODoYH/knvrVnDyB9xI44jNx
         i/q27EAPVBdPSmHU/36J604JN4nYJGYtVS871Sdv943jyOb2nNdS3WrV+8grVuTJgJkH
         PhSw11nnHFJUnoxhYmzTPHDCj4mgV7LM/40SRt1NIgr7jDdodLI1Ha4ZqmOri5DmOu1/
         Ct0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680764323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pjE1y6DkcSyhBXk4ShnrpQHXjNrs31wVH2hslBoMcec=;
        b=oPaQEMjffX1NRftEP6nujt1DTqBcZjbYbGJFGwWnD3aNsGBhffWOM5AF7vz6a5XLj+
         p2VfkDXIHKd7IHYgfSv+uNy49ow7NUKAfGbDh5GyD+eRcePlo+xuKvwrDGWrxAGZwhXj
         WVvVoOleVVd4lHTZJ3dLh6TBma0G09FOc/hS7KTZNc672ffFZRd9a/ev51bVzlrU3Fhp
         LgmGfUuoX/WCeqb3pDC5Lqz6f06GFozsUAS7TmsVIT26J5DE8o/vNo8NqtaYYqWTjm1T
         9xm9SLNGtKS1pHbI856uVlDF5HhB5o8wr8cLsTU20cpUc/RF3wZ8GYb5hs4WjXOJpLLn
         w+HA==
X-Gm-Message-State: AAQBX9dUr4s7xnTV52uBQUZWLLHaEinOY/3xOpZNvc3ZJBl3bj+uGlcG
        E0BDERoqNUZacZ2n9Kg4x/A=
X-Google-Smtp-Source: AKy350ZNPecxCSnNkknXBjksweulZ6KB7rxOeSJJ8GhitTGHC6nm9rjhuv4kXWuwelvgT0Srpsw/Yg==
X-Received: by 2002:a05:6a20:c4aa:b0:d9:4c19:fe6a with SMTP id eo42-20020a056a20c4aa00b000d94c19fe6amr2166630pzb.9.1680764322791;
        Wed, 05 Apr 2023 23:58:42 -0700 (PDT)
Received: from localhost.localdomain ([218.66.91.195])
        by smtp.gmail.com with ESMTPSA id i16-20020aa78b50000000b0062d35807d3asm556291pfd.28.2023.04.05.23.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 23:58:41 -0700 (PDT)
From:   xiaoshoukui <xiaoshoukui@gmail.com>
To:     dsterba@suse.cz
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiaoshoukui@ruijie.com.cn
Subject: Re: [PATCH] btrfs: ioctl: fix inaccurate determination of exclusive_operation
Date:   Thu,  6 Apr 2023 02:58:36 -0400
Message-Id: <20230406065836.126457-1-xiaoshoukui@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230404191042.GE19619@suse.cz>
References: <20230404191042.GE19619@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> Please send a fix with the analysis you dit and add the relevant parts
> of stack traces. The reproducer would be good to have in fstests, for
> the changelog please describe the conditions that could trigger the
> assertion, the reproducer itself is too long. Thanks.

Already posted the fix patch in a new thread. Thanks for your advice on
reproducer program. It will take some time to refactor it to fstests testcase.
