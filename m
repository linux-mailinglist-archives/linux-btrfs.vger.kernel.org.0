Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B36592EFB
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Aug 2022 14:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbiHOMhQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Aug 2022 08:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiHOMhP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Aug 2022 08:37:15 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1C01EC66
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Aug 2022 05:37:13 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id 13so6193141plo.12
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Aug 2022 05:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=T1UfNu4f+rVvsx1YdFcBiMg+GL/kJZ/ghdBps7XP4cU=;
        b=YVS+wIH8Dk89zvFwfMZmYEbnrIgb6//X4VgvU9AVOhDIKQdtqkUXqZXL1R1iLiCQO5
         E6OZiFaNSPceyWcdZgG3sfUbJ5ngVgFyYIIP96ElwAMviX9rIEGHHTX5fY6ft8S7Jogc
         KDeQyHGCU1lKKb9PrpY+7su2+OVBl1H4yfI3hNi/zBkltcIjicYmgYcelPeqK/m5+gmJ
         vUuF9Qci+/b0mXzMnT79sTQ6GErqOLgYONulJqHWO54Pt5DhrPkdVHwJPbxvEkgWtGhB
         zpd9/BpQ5I7PuU+WHTlpHa+c50ysaBJ62jnYPyGZIVZ6acOaOvOYkt8tZMkiT5AferYf
         pXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=T1UfNu4f+rVvsx1YdFcBiMg+GL/kJZ/ghdBps7XP4cU=;
        b=VEvIer2M7Zh0HYtXRRgU9252yRSQLyt48ENhl+81UuvotLX5A6G/JvcusjAobYo/EJ
         vyz6uTfIjnfixX5DDwzRfr0XXarXbh4LQjPwk9d123FqvMKCnH5hlEwDgPGAm0NFAJdA
         UisHRPAxKN376eMob17B6rc+CTEqe2mcXqT1E52TaUYDgtPkeA376FzA+CtAnALMJ8uh
         awwN20dazMHF8kuGoAjolw9sRY3NYXE/WEVomkBViRLR3wnYRMHBgt5qjA6RskJ/N5Xg
         qCyB5DUfYvlcV5JOoIHKD95ZjPuyYtDg3z19UJJChCug94A6kGAzmd6/nEmP+1Lft7cy
         d15w==
X-Gm-Message-State: ACgBeo0ys6BcVPok1rPDk5Wnr6b76ZDdSEyIxNcotGNmqOieornE2n7a
        oMIKbUnrYPKKQYlyOHMfPDHfCPk6GFw=
X-Google-Smtp-Source: AA6agR46LN9Nd7czCSQ1E1OA5+QvrVqNElDE1Mzo2eZ32wzqmnIpLXSBS8yHEKLDXE1Uow9npGHOzw==
X-Received: by 2002:a17:902:b086:b0:171:2632:cd3b with SMTP id p6-20020a170902b08600b001712632cd3bmr17500304plr.111.1660567032000;
        Mon, 15 Aug 2022 05:37:12 -0700 (PDT)
Received: from realwakka-vm.. ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id i17-20020aa796f1000000b0052d46b43006sm6485533pfq.156.2022.08.15.05.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 05:37:11 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [RFC PATCH 0/2] support all option for resize command
Date:   Mon, 15 Aug 2022 12:36:50 +0000
Message-Id: <20220815123652.52314-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

This patch series is for supporting resize command in btrfs-progs.
It resolves btrfs-progs github issue #471

This is prototype for work. It also needs to add manual for option.
I want to know that it's good way to implement the option.

If there is better way, I'd appreciate it.

Sidong Yang (2):
  btrfs-progs: fi resize: refactor function check_resize_args()
  btrfs-progs: fi resize: support all option for resize

 cmds/filesystem.c | 218 +++++++++++++++++++++++++++-------------------
 1 file changed, 127 insertions(+), 91 deletions(-)

-- 
2.34.1

