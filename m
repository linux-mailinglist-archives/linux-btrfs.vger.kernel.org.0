Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB571781770
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Aug 2023 07:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243833AbjHSFEy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 19 Aug 2023 01:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237273AbjHSFE2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 19 Aug 2023 01:04:28 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B3E3598;
        Fri, 18 Aug 2023 22:04:27 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-649edb3a3d6so7515076d6.0;
        Fri, 18 Aug 2023 22:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692421466; x=1693026266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fJl5QAqKLuQQg1TlpenZLcwY8y6z6TpbzD30Z93sVbk=;
        b=IGgNDYe7TqrWrlZzhQMUbRGEvDHQqh7ROeXA1jRiGs4DBVLiloKYsCLFNkJURIBQUO
         fI3ZihW2WKvX1b40Ybs6bE1YH3cNhFktRDCs+QXkgaWI4t7EFL+NGIYz0jxSmTkIXLdU
         +I0xQPpPJWsQunVI7JAomR/Hfw8tT6F9kUOgnAO9oQc5nmLzps6aDKANS5vKEzf/9Ex+
         KNwk8S+hfd9PUzOHePO9/qPcZjR3CkiU5oK+fKbJ82MTlFxDQDA6aN7dt7SS9hy2ErqK
         jdfv/sHNNq+zNvc9QFvx4CWYXwCdMp8Hc1iNnN5bCIZi0rW7lrpwS58f8uCRTQx0VmhK
         I/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692421466; x=1693026266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fJl5QAqKLuQQg1TlpenZLcwY8y6z6TpbzD30Z93sVbk=;
        b=DBedJ+A8pWXIsuLEcDnv4Zu0w4oOBs7uOsFju3UDirmQRpnforfNt+obIlgSKiYkpl
         pZYsLeCl+JDdrWekYDXjPR2pyfEtKIWUU1xKFrE9Qy/vRMr0W6tA+JfLwHHOok+vtXdG
         85mwuHSufV3sEgm01sKN0F7OVXLm2ukdxrCzTeAH25qLVzw4hvfsJegDld/w226fnJ07
         gPjqT9qyV4FP1r9fwLK8/NAapehtcjyh0I54vRp5m39OOwXXlSD4mcBkCTtSoKjK5SKe
         ubSFS/SQ6bM0v/rMiZOs9DRCmoWx3F709jgjAwJgIXMaBCIrX0EoJtx0294z0IgmJAR4
         Nskw==
X-Gm-Message-State: AOJu0YxJcCVi9t58v8fczy06jt1c69S5quEaVavmRIOocheqXsbF2sQs
        uQwU7dSthHoPM7Etygxl/Ic=
X-Google-Smtp-Source: AGHT+IGa2a1OEIsri0RVzOTRphE09dfelbBNO39Aucas4i5ii7I8j5FttmhrYO3X/ohBjD+IFDVing==
X-Received: by 2002:a0c:dd0a:0:b0:643:6a7c:9fbb with SMTP id u10-20020a0cdd0a000000b006436a7c9fbbmr1726491qvk.8.1692421466201;
        Fri, 18 Aug 2023 22:04:26 -0700 (PDT)
Received: from Slackware.localdomain ([154.16.192.72])
        by smtp.gmail.com with ESMTPSA id d28-20020a0cb2dc000000b0063d0b792469sm1213356qvf.136.2023.08.18.22.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 22:04:25 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, corbet@lwn.net,
        linux-btrfs@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH 0/3] btrfs: kconfig: Doc: MAINTAINERS: Obsolete wiki link replace
Date:   Sat, 19 Aug 2023 10:23:02 +0530
Message-ID: <cover.1692420752.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.41.0
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

 Remove and replace old and obsolete wiki link to active maintained link.

Bhaskar Chowdhury (3):
  Remove obsolete wiki link
  Replace obsolete wiki link
  Remove obsolete wiki link

 Documentation/filesystems/btrfs.rst | 1 -
 MAINTAINERS                         | 1 -
 fs/btrfs/Kconfig                    | 2 +-
 3 files changed, 1 insertion(+), 3 deletions(-)

--
2.41.0

