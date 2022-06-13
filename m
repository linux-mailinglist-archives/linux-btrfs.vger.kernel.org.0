Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E28549EFB
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jun 2022 22:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238640AbiFMUZ5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jun 2022 16:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345127AbiFMUZs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jun 2022 16:25:48 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C5FCD2
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 12:09:52 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id c83so4774939qke.3
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 12:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GzCvY3kKu+uZhnAiqlJreF55Vg8g452kFdwp12veySk=;
        b=XBErKw8p3nnqrdwv5ugId0kPW/Xt4IHAeUoEfUZqP/bsTHzzmOKCba9HjweWkRgyXW
         949u1X2xf1ZlWxFqO1zRM50g/+hHf2/YtfwdEg2Q7IPK/P1e8U4y7hpDO0aW6iRiZY7N
         BOckiycEgD/uhDfdPckMMV/IcdIomGoKj9ir9LtGJnT+9XQZ+Za3NShVGS90Jg7E3hRd
         OuXo3fg249as7bKZEi5G5mry+F3yGEfQk4BacWMkud3SfOzSvvXPZ70ZVvR9/SzqKBWM
         eVJpPjylpDpKsCzyBCmhoVrjYCq+BveOweqNj8tXe3ENLFblG5pHzHOtcuabMFhCXE/C
         JTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GzCvY3kKu+uZhnAiqlJreF55Vg8g452kFdwp12veySk=;
        b=Cz6PsgoBwMZzEUA7D/URjPw3GOD5vrncOF3JQ8raz8OdGSTVDFQ/eUS5osJ0XFC63w
         W+KRZ15JYS0E0uXiQd5HXBjYBgcWb6BEIC+JeNsSz3XCagovyurxx0aNZdSpa2pXGnR1
         KrZ8Ga8xz9xX+tVWmRbQE7vRSZ+y/tBnrgbLteGmEONzRl+OqtPWoShveQ1e6cYSjO26
         4kXiu5LPa6ldswPiYh4cTgPJrYilWoYOVJhoYqJQblp8agPYImWJQATVMmDjGFlj4Y/s
         REY/pZ/2Po3YFXCEV3h3peFBlQ2Lo78e+TBZbMx289PaPpmRQUjS5X9d8AY7BmCu7Mwe
         zCHw==
X-Gm-Message-State: AOAM532fFseUDU37V9Uw5HsQXYn6DQevjVIQKOJSXBX6N8V04heLRuIV
        IiEUyqqWeVjj1APUh5YDBW/qOorO54e0QA==
X-Google-Smtp-Source: ABdhPJwSdrKImBpw7uzAqur1yztQ7WEdimOZq9RSpGE2RMYWBS8E0XFsDCgakPjCTvoWKObvcWTwfA==
X-Received: by 2002:a05:620a:2401:b0:6a7:60ce:89f8 with SMTP id d1-20020a05620a240100b006a760ce89f8mr1206286qkn.101.1655147391241;
        Mon, 13 Jun 2022 12:09:51 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id gd8-20020a05622a5c0800b002f93554c009sm5413201qtb.59.2022.06.13.12.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 12:09:50 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 0/2] btrfs: fix deadlock with fsync and full sync
Date:   Mon, 13 Jun 2022 15:09:47 -0400
Message-Id: <cover.1655147296.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v1->v2:
- Make btrfs_sync_file also use the new BTRFS_LOG_FORCE_COMMIT define.
- Adjust the title of the second patch

--- Original email ---
Hello,

We've hit a pretty convoluted deadlock in production that Omar tracked down with
drgn.  I've described the deadlock in the second patch, but generally it's a
lock inversion where we have an existing dependency of extent lock ->
transaction, but in fsync in a few cases we can end up with transaction ->
extent lock, and the expected hilarity ensues.  Thanks,

Josef

Josef Bacik (2):
  btrfs: make the return value for log syncing consistent
  btrfs: fix deadlock with fsync+fiemap+transaction commit

 fs/btrfs/file.c     | 69 ++++++++++++++++++++++++++++++++++-----------
 fs/btrfs/tree-log.c | 18 ++++++------
 fs/btrfs/tree-log.h |  3 ++
 3 files changed, 65 insertions(+), 25 deletions(-)

-- 
2.26.3

