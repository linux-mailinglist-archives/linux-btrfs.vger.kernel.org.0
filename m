Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE7A792FD6
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Sep 2023 22:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243317AbjIEUWH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Sep 2023 16:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243372AbjIEUWG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Sep 2023 16:22:06 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD693127
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 13:21:57 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-41368601e92so16449951cf.3
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Sep 2023 13:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1693945316; x=1694550116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cAh0oYsQ3IBRGhUD8WNeSziHbPd1RFbpwJ6sSjVJtw0=;
        b=UL9m2ftIu5E7NgBA4ru2y7VlbuShzMDSt8xGM72SRVvI5Pc6vnpMQjq+n1gVmeIQHs
         nySkK8BAm9MGOmxWgp19+2Ms0lldYhrQmJPmehOTToUSMgPWGghUIKB3QNqzijhoIHZn
         HphMVha4xWP7qcaptLrt3WKXuW7qLn4QZCGcXtmqcb25+kQQwKGHvHQ9JNLc40pWzcyt
         gQihOBtH6FcOx7riH7HNL/04ud72KJlAo+EMD8nFYbZZxh0Qlf6opjvDuYIuqvN7buX3
         QKWUSOIP4AC5+cGByBKQ/MwkwIx1f6ykMkv4peJVI3nPlBGLcP6ouHiM2gFLlrOXu0mh
         NyrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693945316; x=1694550116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cAh0oYsQ3IBRGhUD8WNeSziHbPd1RFbpwJ6sSjVJtw0=;
        b=FU7g4AjE3p9ixAxzj3ta2XNKpZxN9ZkSsjX5QfiZXVw9NObrMTqsjZjdp6fQHG8oBY
         ZuEt+APYGyHPxuq7BGW4stLrwn30ZJhUv7yNuytfKnKUtgGT55aaU2GSIHVORe3v6jgj
         0WYxdlLsd8XF6HsumfjRNuWHPOdAYK1T/n3/uIrbB2fhdAk9WmGhs6YywOVJE9n/lNl3
         sCkENNWvkzcU3NcE4SK2VwHF+3NUTwsROnKkhgFOA1kFji2apK9aAkcAtFj2MldbrWb+
         IFEVywwT1ptHQiXgL0dkzxmBz4Av/VXQ/5jI2qSUkKq5tEJsAxAhIFd01Efe/6J1pyEr
         DsJw==
X-Gm-Message-State: AOJu0YyptIaibvfSFVts+096kIRLiH795UoUoZUdxdZHpl6YRm8YuNwe
        ghwoqr/VHIiRQL2XonZIDSRe0T2Z1Gk6wJ3B5L4=
X-Google-Smtp-Source: AGHT+IG12Bp8Jp1Y3PYQPHHpue4wGlU8/HyUwrGe6NHiY/955Puk6WJWiQ065hfSEkJjtfZVEK+tdQ==
X-Received: by 2002:ac8:5b89:0:b0:412:43a5:e5a4 with SMTP id a9-20020ac85b89000000b0041243a5e5a4mr15022872qta.65.1693945316739;
        Tue, 05 Sep 2023 13:21:56 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id h16-20020ac846d0000000b0040ff387de83sm4653610qto.45.2023.09.05.13.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 13:21:56 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/3] btrfs-progs: add eb leak detection and fixes
Date:   Tue,  5 Sep 2023 16:21:50 -0400
Message-ID: <cover.1693945163.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I introduced an EB leak that we only discovered when we started running fstests
with my code applied to the btrfs-progs devel branch.  We really want to detect
this before we start using this code for fstests, so update all the run_check
related helpers to use a helper that will check for extent buffer leaks and fail
accordingly.  This will allow developers to discover they've introduced a
problem when they run make test after their changes.

This functionality of course uncovered a few leaks that currently exist in
btrfs-progs, so there are two fixes that precede the leak detection work in
order to make sure we are clean from the leak detection commit ondwards.
Thanks,

Josef

Josef Bacik (3):
  btrfs-progs: cleanup dirty buffers on transaction abort
  btrfs-progs: properly cleanup aborted transactions in check
  btrfs-progs: add extent buffer leak detection to make test

 check/main.c                |  10 +++-
 kernel-shared/transaction.c |  45 ++++++++-------
 tests/common                | 108 ++++++++++++++++++++----------------
 3 files changed, 95 insertions(+), 68 deletions(-)

-- 
2.41.0

