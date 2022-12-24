Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE570655AB2
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Dec 2022 17:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbiLXQTI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Dec 2022 11:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiLXQTH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Dec 2022 11:19:07 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CC4B1C0
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Dec 2022 08:19:05 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id k26-20020a05600c1c9a00b003d972646a7dso1828685wms.5
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Dec 2022 08:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8VrlWjFvaspr6/t7M3O+2pd7cn948KuZjWZ0RRt5wvQ=;
        b=GE4MJLlsksjHTIrI5W/tOq1R820Wo5xvQBnyY4MBVfr/1n7AsiUiYrpgFRvcnX030A
         SA661HZ/jwMMCsX6N7qw/pcmvNCcFnc13i3oIQlkDs0GDm/kpssZabrIMO+B2O3q5fZQ
         VmA5BlWqkpSgCrZWlFWuUP2hbTGoie7QRGI54XvJzX6einujEaKXnw4tiSmivx46Oims
         8rd0swiWD3YdRZD3GYf0cG16ay1tpxDdLGbGcjJmyz8vOo9cTDXiR5p4yqT5GwNOLr2y
         9LdLaNqZ57phPLy0mKk6xgWBCCmM3XMBE/3PMyXc/gigZ1NsNc1JCTSW/XBf/esmPoZN
         +ubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8VrlWjFvaspr6/t7M3O+2pd7cn948KuZjWZ0RRt5wvQ=;
        b=R+Trj9RCc5ttYgRObG1wC5mgRys9SKNpHUOeeUJHtCNkM8sS6yBLKUjjyMj20oKRSh
         MxqZK2EqLcul71GV4NOCS6bL5bqNP0GuJqW9NDALcrjVPhTNxL4LgymlsGUVarMlttLn
         5T+3hLS54f+JuAxa21U/jj/SVPW/+rzHS89o1NM4ILNq0qrLXDl1QCOHkySn3YvVEXa0
         0LGPBhzlbyZQ+esv43zN0IYzw+fMBJF6U4DRdaF8eFjSdYFgFEUDB+wggfxrtUhKe+vW
         ir4B2DG0JbkKmDMihInb0SU/aqXWO6yiTWQF2AnpbkRdqa8IvQcq8hqO8XbgebRGw5Lo
         96yA==
X-Gm-Message-State: AFqh2kp4vrWHwpa3ZIOCrGED0k0ULrdJf1zgY3KOgR+htLqixEdqbcfW
        GgiKXkCe4b7YevJZxcatiIvSyme9bJVSNw==
X-Google-Smtp-Source: AMrXdXuAK7+DUijUEjs3YvSl8FNkMZgRwXu6KrbjYlZpd+UllnPKeLTFVG8+de0BnwXk74O0PLeAOg==
X-Received: by 2002:a05:600c:3506:b0:3cf:803b:d7cc with SMTP id h6-20020a05600c350600b003cf803bd7ccmr10360885wmq.33.1671898742876;
        Sat, 24 Dec 2022 08:19:02 -0800 (PST)
Received: from solpc.. (226.red-83-43-18.dynamicip.rima-tde.net. [83.43.18.226])
        by smtp.gmail.com with ESMTPSA id s16-20020a1cf210000000b003c6bd12ac27sm8123446wmc.37.2022.12.24.08.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Dec 2022 08:19:02 -0800 (PST)
From:   Joan Bruguera <joanbrugueram@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     fdmanana@kernel.org,
        =?UTF-8?q?Joan=20Bruguera=20Mic=C3=B3?= <joanbrugueram@gmail.com>
Subject: Re: [PATCH] btrfs: fix off-by-one in delalloc search during lseek
Date:   Sat, 24 Dec 2022 16:18:58 +0000
Message-Id: <20221224161858.11994-1-joanbrugueram@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <da314182610b43632ca81ba78ff73fac5ae1bf06.1671820088.git.fdmanana@suse.com>
References: <da314182610b43632ca81ba78ff73fac5ae1bf06.1671820088.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Tested-by: Joan Bruguera Micó <joanbrugueram@gmail.com>
