Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B811F24C677
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Aug 2020 22:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgHTUAW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Aug 2020 16:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgHTUAU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Aug 2020 16:00:20 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B29C061385
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 13:00:19 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id h21so2105560qtp.11
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 13:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nNvVy2WLpbPp2baQox5YSybctWx9Q2+KH3oY4BsuaUk=;
        b=oopKPhoc+gEdYOm8sacWkYklsstpVuqSJKncLOB7IJ1l+PMuG0EHwWwh3vGmUIhiII
         P7o71T135AuVQ/eyEfDapKaV6qgEtS6lxIiY/8qdtvjn2aBuDWDPX42+mdvX0EjwcaEZ
         RJgdDz64bOfSsTQQnL0zyL89UtV5bGHZ1rF1kHDWeHTovSXlC/71Dk5J3tWzQa5KXGy3
         txxzXP+gSAwfN6s5oRZVwXfi/H32fOFdzc16RYFP000IkWl2c00upKHOsTxWFYyxfm5A
         m/kQaD4IjB0+jIk4zva9HU0Ml/ZGZ36ZrOcCq9ZjHCi/1YlPBFWpT02svgeU3Rs9DX6H
         gtZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nNvVy2WLpbPp2baQox5YSybctWx9Q2+KH3oY4BsuaUk=;
        b=SF814Q3LEaiPCEN1D/FWXHDQZxUC9fUkk1t+yghQoQmmgJDbDXRpPGahGQyrqkXCB0
         cVLisciNBPbfGyHsQ5QGJZ1oCK6kgn7e3oSoso+FCjgSnADF3Xdr+JnyRLkItSMi3Zeo
         cDE4kvCzNkfWSRMIDf08xIH9g/bSBIW5uGs7vPHQwhqd/fWJgrsAbZ/I78ymHKxxi0cP
         XHkSnmvNC6YLZge0IRSR9S/9yCPUCWPuWU9l1E+6QeyDy0RrIrbBaa8UVhNkNK7LeVDu
         9Qrff/VF+Xw4A5iBbONUb2++YNFwwWX4JweGMykTKBudMbKNYxjZllos/XoXwBoz8lKW
         o/yQ==
X-Gm-Message-State: AOAM530YeN3WlXKkjWjZzeaD+uygXG0vX9Ejm2diS4/uKAH6bRF/Tu5v
        IOUIq6iXs6G2R9sG4IR0v0BpMu5QkJ64VzJL
X-Google-Smtp-Source: ABdhPJzt6z3IcoxNCILNTHfeVEfMMoJhBLOa7c9vf9TLpdkZtvhv45pY2dlSGvPI3+cLszX5UwM3KQ==
X-Received: by 2002:aed:2825:: with SMTP id r34mr157585qtd.321.1597953617142;
        Thu, 20 Aug 2020 13:00:17 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l13sm3682844qth.77.2020.08.20.13.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 13:00:16 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/2][v2] Some leaked root fixes
Date:   Thu, 20 Aug 2020 16:00:13 -0400
Message-Id: <cover.1597953516.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

These are two fixes for a leaked root problem I noticed a while ago.  One is the
actual leaked root fix, the other is to add a pretty print for the leaked root
message, as figuring out that some giant %llu number was the data reloc root is
not a feat meant for humans.  Thanks,

Josef
