Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F6859B142
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Aug 2022 04:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiHUCCa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 20 Aug 2022 22:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbiHUCC2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 20 Aug 2022 22:02:28 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DEC2C66A
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Aug 2022 19:02:27 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id p6so7572956vsr.9
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Aug 2022 19:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=o2rScCjvXVxWvz35qYLyGk2pLCsnGqfLECgC0wg1Bvk=;
        b=pjjIRFCyndrRiNZHN0JpGZ5blK2zqs/kNdZ1mUM6gGHE4okaBMrIVXKGRmyheUmWEG
         ikoY9Dhf5RGE9aFOlM5NXuRabG8v3xWjbKbRT5dDfXMaMfPz+8Qc3Z87TkZruXA1roc+
         LGkD0zoJY0ctwbNcMqpyBxtsTRghUGbB2NXxpOIyI6EF/TAaTfzAuCdrq15tawNWXVHN
         0rvG9UQ0dtEK3E/lly8+Hs/OJBHHIZbp8cCbwMyZkJUF0pzCubJ6Kk4OLGXZOZjEsFvK
         Vqi2X1BI3RmtN3v3Cz1vAF+dv2vNq8/GzROUMPczQYioiNeY5z4j3oX9G/RNRtv3jMWn
         UHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=o2rScCjvXVxWvz35qYLyGk2pLCsnGqfLECgC0wg1Bvk=;
        b=YjI+X6wkeXlihTDzg+9FMwXXh+gxf+LO2yyk/uE/5umxkCkZRiKTtW+/EarpcvnHq5
         /5T9Zg9pKJm7yTFKXTU9WDoDp+tpxSsNUgoFnG+W7wV4PqEMxF0STEL8TBJL64STOF1H
         Jgu6V3g4rSHM8mCr4axECaFe1OWW5V1e11rLyMps/Kjo1TMevZbnFYQfPcwnmedmJRMx
         QBZOGD9LNNKx2FnzCifYLfNkqvVdt5YaZ2GubFwh51+Dftzhwxvl3J3cw3XqEmVnUJrR
         nRW6iYyXx9nLmTZoXSET34x7cDz2gXe1KHp2824c0P5n+4vnBl26TUM3F4Yce98BAtrv
         nj0w==
X-Gm-Message-State: ACgBeo3M63hFqM/qDrO6yj5weK7Ujx/BTsrd9ojIP7PFAKsp3Zm1W9h/
        RE0wf+PVKK9aQpDWJnABJ2uLuDTrFxTdfuVzxg0=
X-Google-Smtp-Source: AA6agR4tqyTvSA2j73rDHOrYiN4l2RiaiQetEFVKsP4y7AXlS9PmQdjpgGeYmWbE7QhlAj2S/eKP0KhKJDbKlAvUaB4=
X-Received: by 2002:a67:ed51:0:b0:38d:34b9:98b9 with SMTP id
 m17-20020a67ed51000000b0038d34b998b9mr5150458vsp.68.1661047346500; Sat, 20
 Aug 2022 19:02:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:6052:0:0:0:0:0 with HTTP; Sat, 20 Aug 2022 19:02:25
 -0700 (PDT)
Reply-To: wijh555@gmail.com
From:   "Prof. Chin Guang" <confianzayrentabilidad@gmail.com>
Date:   Sat, 20 Aug 2022 19:02:25 -0700
Message-ID: <CANrrfX4sY6LO8ifO5KY27366Wp-rZKWTb=YBaBrxtYe62sRGLg@mail.gmail.com>
Subject: Greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

-- 
The Board Directors want to know if you are in good health doing great and
with the hope that this mail will meet you in good condition, We are
privileged and delighted to reach you via email" And we are urgently
waiting to hear from you. and again your number is not connecting.

Sincerely,
Prof. Chin Guang
