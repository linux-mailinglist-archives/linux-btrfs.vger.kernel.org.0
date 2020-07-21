Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991242282A4
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 16:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgGUOsv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 10:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgGUOsu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 10:48:50 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B42C061794
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:48:50 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id g26so9308737qka.3
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LwJxeULV9RnSB+2F2MkQhwWNermfi4ARA9pdO1sduC0=;
        b=dm2CmKqjtJBrysXc0ETxmL2a5JHStnoeqea4bshJeUBcQvXm+PKVOwzXSeyQZuV/Cm
         lxk1MNNpAzYNeEAQ8hPCdvN4DCJ4oEgC6ljct9w+NH7LdxC4ISe06duM3dZAJXGmLaEK
         SILtuSW6IzD0/w8NzFUSHMgSPs9jwRmyZfqq0O4bQUt45ypatjd0JNumN+HCmjE+J06e
         lXIAN7KLyob0ozM/VZNzzUYCQUfqQshHyhzKMJg7OtAx9qL+ILCLPOQgwwNAx9RkIht9
         5SjoMS+Z6ucwN01xYz4UYkjW/u2hIgHJsmwj3JuGoISEDLwIyWnOSTkvtRN2SY1oPWN9
         po5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LwJxeULV9RnSB+2F2MkQhwWNermfi4ARA9pdO1sduC0=;
        b=tE4+t7+hPP7HkK1a6wdeZZ14AZTEG+Kuj+wNrAouisFt+YemniuD7g9f9gkyQgVGnX
         /ZDEgVtdoAjLMG9BjLcr8UyZYXn2NsggkT/bQjNEfisUifA/Vz4M9TtmgzZFv+3b5bV2
         L8owE/eyzBHSAT9EbE4KJHJYT1qIV+mADOvGL8IWz6fcHFCYONeqwysEmrm1810thvCc
         9rfTQT2lMxdvRaApq4GyFQAXYnaZQRfLVBW1EJCq9ByP0S181nmhAP31xZl68d8LuxiM
         RC2Fwu7Ores7COteVfeJF549EXh/RNKPQ48uQ2G35fJ2ZzKXeNLH/MfGwau9kP1RcqP4
         tLmA==
X-Gm-Message-State: AOAM532Ykz3yU7IOb19eQhLOggPCQLkYW5B0xRGsqNhq7M7CL7ptJmU4
        TgecXbSmV9SgV0fV7jMGkp+pAcYrTGYuFg==
X-Google-Smtp-Source: ABdhPJzHz/VHEMCSb/KOdV9rIIGJJVirLiHMp7Cv3e4OUTxoYTUeP4vG2SWs7l6bMr3WQieXCTAWSw==
X-Received: by 2002:a37:4bcd:: with SMTP id y196mr26657673qka.495.1595342928647;
        Tue, 21 Jul 2020 07:48:48 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g8sm12731260qtu.65.2020.07.21.07.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 07:48:48 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/2][RESEND] Fix how we do block group flags
Date:   Tue, 21 Jul 2020 10:48:44 -0400
Message-Id: <20200721144846.4511-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These two patches address some wonkiness with how we do block group flags.
We've had long standing failures here, this makes things more consistent and
fixes some weird corner cases where we end up with lots of chunks we cannot use.
Thanks,

Josef

