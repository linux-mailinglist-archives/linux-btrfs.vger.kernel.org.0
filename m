Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A8659EC74
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Aug 2022 21:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiHWTfA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Aug 2022 15:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiHWTeg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Aug 2022 15:34:36 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EB0120A5
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Aug 2022 11:28:22 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id ds12-20020a17090b08cc00b001fae6343d9fso2005319pjb.0
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Aug 2022 11:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=RMZdNYSzv4NjHaqZ4xDO3y/4EIPEqOokWOHVzWp9qXA=;
        b=CfJvtwxpb36h3Tk7HEGEcvknXYGGOIUOtrTGa5/JUtw7An/l5vTyFtzzQBwo4etcct
         mCYGO1NccsEiYChWf59M8QDxWdsId6IdNLYU/KpSY+pjN3gnZupsvu5hngo+nDbWF3/a
         UljkZXMV/LH4BiIFMU+ENitTFDXKvm8wmpWdptQwlcE7xAeyRRhOlBsrKqxKmrUdo5U9
         eKSe3kkcuDYF9Sm7SBKvKcYoQ78VwMp47gFM4bCvVnyP7OxnzPGrYXukUVtWFJ5yCNve
         evZlq/+f3f1IWiLQ9sVA68U3IWaGNJWoY2lwPXU9RjtfZ6iLWH8dsvEgj3iZTtDke72m
         06Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=RMZdNYSzv4NjHaqZ4xDO3y/4EIPEqOokWOHVzWp9qXA=;
        b=bdncs+ISnAy0wzaJ/2IIQsUlWPsmVDRrJUpuh4OqS8xHp3ult5FDwCMG2HpnNdDO7v
         hgBGRw7sG3I8+HqKLlnwa7g3uQk1QrMCvaz6JQoKLax+4YvL2BIDw6z+HKOkPi32YPdv
         rt89oD4BABkmKczwxDVfRmePjy7FytHAwrIRzPAMvzQnz1cfZ15rZ57fhAv3qnxW22mo
         4+CKmXSJK1gblKqc2CyInIy7OwiTdBEBYhzxhTL9zQeZSBrB7i76Uq5gLDTdAnMJnG/h
         8eseAK3t6z7PDCEGgT0PU0gFelZ4i/ABfIX9FCJeVK9jBKXaFQftFjLF0rA27V/h2cu/
         8Aeg==
X-Gm-Message-State: ACgBeo3St7PUH/bEBzNGF4NfA7vMpvXm4CvrnAfCvljhoy4LW79ZOoF7
        70YUJ7W41n2OxJjnwE4vu/H8jCX8HZK8tQ==
X-Google-Smtp-Source: AA6agR43iP8ohCRvkvGYUYHp+2zp3kttvsr94zeH6g/NFMAbZcslhIkpgBy97uVRqaBwbicKai4WLg==
X-Received: by 2002:a17:902:e54f:b0:172:ef3e:f725 with SMTP id n15-20020a170902e54f00b00172ef3ef725mr9213684plf.66.1661279301217;
        Tue, 23 Aug 2022 11:28:21 -0700 (PDT)
Received: from relinquished.thefacebook.com ([2620:10d:c090:500::2:9aae])
        by smtp.gmail.com with ESMTPSA id f17-20020a170902f39100b0016bedcced2fsm7168184ple.35.2022.08.23.11.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 11:28:20 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH 0/2] btrfs: backports of space cache corruption fix
Date:   Tue, 23 Aug 2022 11:28:12 -0700
Message-Id: <cover.1661278864.git.osandov@fb.com>
X-Mailer: git-send-email 2.37.2
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

From: Omar Sandoval <osandov@fb.com>

Hi,

These are backports of
https://lore.kernel.org/linux-btrfs/9ee45db86433bb8e4d7daff35502db241c69ad16.1660690698.git.osandov@fb.com/
for 6.0 (which also applies to 5.19) and 5.15 resolving some minor merge
conflicts. We should get this fixed in 6.0 and backported to 5.19/5.15.

Thanks,
Omar

-- 
2.30.2

