Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25106638602
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Nov 2022 10:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiKYJXP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Nov 2022 04:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKYJXN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Nov 2022 04:23:13 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA3A205E6
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Nov 2022 01:23:10 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id z24so4500733ljn.4
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Nov 2022 01:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rzmkdwCkCrsfamqhqYbcJiDjvHqGgZWzvJ/i1FtwLzM=;
        b=mtBAyYsahCGeQl2WqVgWcTu47dPNPq975to8noTzA7lYQBodqD/KH3EAQAID99Gru3
         ppFAJxUM8ZP656y22pHdwpXktLX+LPPjZapm5Mx2K+v3AoOSmrbNEfdzWZ4kBvHib+bG
         yDVL5RHmcthVVgcqeDpB/+N7iOihg1hN3HOyXBDCCv+yeD12bTAmOXWG6hbxcyzuRg3Q
         C5O3mM2ZLKhYAsZ+EZKOCMNzMLBmgYm7Fy+GrEWf95ds16vl4LqnD73lHxR38trdxiU5
         UulaE6MBQ9hrxa19EPUhA/Mdwqecekq0Yp3137haB4uX7/CEDywb1SDshRudi5j1k2Bl
         3NFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rzmkdwCkCrsfamqhqYbcJiDjvHqGgZWzvJ/i1FtwLzM=;
        b=O7rEDRp8x+jQ0I8MIuniaq/1PJMx5kKFQkZfvj5FSJKH0XUYS13M8t5y/egn9gmGTL
         duI6XoHGeBe//yBSWxmsMf1UU2FSbx+XXdRilV+lSOZU3lJVNdw5wiTdS+QYPhMFGk17
         JB49Pc+oM2DrWZ0RuiB3K9HpHflCC3+IPej1kC/eSyVpJqjMhOJNH/xG/v1Xej8e20zw
         HsnjwMAwpZifrGF6H2cqCOyr+Qbv/itUU7XeNkbScoPvxN922LQfyxjNIiwkFP6fpKwr
         Iy+VzAJftj2mtkWmJDNtA1F0zZBNVwO8pY2TBC5o77YeS1QAAVyhH0vkqchUcr6UyiPu
         rfYA==
X-Gm-Message-State: ANoB5pnxkrWGZIw0JuhoHtIiTDQO+gOZxljTwOSrMNxLWHJFoBARsqYS
        4Zasx8QeBWmMtJk/3Hphr2I=
X-Google-Smtp-Source: AA0mqf53TDWdaV/KWvhxdkkz2QRUKKIG/k+nvxYzOr+LChdYPOb7d5t9bSt7JjpTdhksNCy+wZIe/A==
X-Received: by 2002:a05:651c:241:b0:26d:e38f:7e21 with SMTP id x1-20020a05651c024100b0026de38f7e21mr2400760ljn.273.1669368189316;
        Fri, 25 Nov 2022 01:23:09 -0800 (PST)
Received: from localhost.localdomain (fw.storegate.se. [194.17.41.68])
        by smtp.gmail.com with ESMTPSA id g4-20020a056512118400b004b40f5e7336sm447914lfr.199.2022.11.25.01.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 01:23:08 -0800 (PST)
From:   Joakim <ahoj79@gmail.com>
To:     quwenruo.btrfs@gmx.com
Cc:     ahoj79@gmail.com, linux-btrfs@vger.kernel.org, wqu@suse.com
Subject: Re: Speed up mount time?
Date:   Fri, 25 Nov 2022 10:22:55 +0100
Message-Id: <20221125092255.316-1-ahoj79@gmail.com>
X-Mailer: git-send-email 2.38.1.windows.1
In-Reply-To: <e1eac218-bc97-0f62-4be8-b81c37b76296@gmx.com>
References: <e1eac218-bc97-0f62-4be8-b81c37b76296@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Alright, thanks for clarification.  =0D
This machine has Oracle Linux, so i guess there will be som waiting.=0D
=0D
//Joakim=
