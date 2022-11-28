Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506AF63AB8C
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Nov 2022 15:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiK1Oru (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Nov 2022 09:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbiK1Ore (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Nov 2022 09:47:34 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23571305
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Nov 2022 06:47:32 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id j196so13592064ybj.2
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Nov 2022 06:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yi1nwdZVcovrN/errUXXhZeN1eR0+sBJVw3FsjfBv6g=;
        b=dShwrYRLQfv/wLYBpSc+Mx34q63Bv5QEwlgogtzbsoIUyxwzAZlFlnNKZ0a8TN/Xjs
         SSA2Rhd7fQaje/+vx/yl38vKQ6r4JLfnaUHT/zTHdHQmeUU5rkGThTdNGXluUfiagbp0
         N6nZxMONGT4u6tmw2w7H6Jj7iIQhIp5Fyx8ctsprCrtwRv2aAk60kb2FA3+YrirkDMlS
         pHggDfcYBILU5Pnm+WapEhCjvYnAH06Xx6viT/N4+CA2bT6iwhZjP4CFMO6rs6qXh4i8
         R/Iy3mmLuetGT56+YygOpw278m3l7YKPqwWLZmEq0ziWU491HkLkvmNa4UwojKpoVemM
         l1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yi1nwdZVcovrN/errUXXhZeN1eR0+sBJVw3FsjfBv6g=;
        b=SjpivIQW0fimxpyil+KBwwyZfXVIpLjcgEup1/VE/h3sI7zxI3beqrU8oG/3HGsTeQ
         +y6sbhTydeGIhjy8Re9O9L8aoVOoaAJq/7wD52h8Kar+K7I130AYNTCcKLmE2xney0k7
         Qjj3OymPp7ADoEw8hdSPSvjTgkjmS6VsH013fxKadHvjfJzcZKk6HK3FjvW0jKKCpwPO
         y+VQ+M5o/oPM2oNQUB8Wtd2Nod9iYdJzsD/KXwenaWQ4zT41XQ17/fSdnAeHZjjy8oyW
         mnejZM658+Wo/MWu4YFMS1NmzQzGGpAwEnrtchhfJD2xmwHWIWYCb7BjY1zjb29w/lCV
         7qhQ==
X-Gm-Message-State: ANoB5pkSgpstkqipbKyoT3i42Jq9M78+ShKBM/uKZNwwuDiMS6ACULsq
        j+qYQ6cENGCNMX65XXpF+KLO+tOLzQJ5a2+ifmg=
X-Google-Smtp-Source: AA0mqf5Ikqb7N4p52xf2FZD//ghhTskR8UNiChVUa6rvLbhQtyApa2p4F001LtGOEt9Zz4BPQg7gHnipfXNwd2YhmCE=
X-Received: by 2002:a25:afc6:0:b0:6cf:c851:8ea1 with SMTP id
 d6-20020a25afc6000000b006cfc8518ea1mr32170031ybj.213.1669646851293; Mon, 28
 Nov 2022 06:47:31 -0800 (PST)
MIME-Version: 1.0
Reply-To: sgtkalamanthey@gmail.com
Sender: angelleangelle1234567890@gmail.com
Received: by 2002:a05:7010:a887:b0:316:1f48:e601 with HTTP; Mon, 28 Nov 2022
 06:47:31 -0800 (PST)
From:   kala manthey <sgtkalamanthey@gmail.com>
Date:   Mon, 28 Nov 2022 06:47:31 -0800
X-Google-Sender-Auth: GTGPIPiQUZs-QxLb0q7g103TAvY
Message-ID: <CAGT7zP1CV+BrOvtEf7Yd2WsmX54jvT1PsP_XioCJDRsK15ObMA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

0JfQtNGA0LDQstC10LksINC/0L7Qu9GD0YfQuCDQu9C4INGB0YrQvtCx0YnQtdC90LjRj9GC0LAg
0LzQuD8g0LzQvtC70Y8sINC/0YDQvtCy0LXRgNC10YLQtSDQuCDQvNC4INC+0YLQs9C+0LLQvtGA
0LXRgtC1DQo=
