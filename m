Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83DD6AE4DA
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Mar 2023 16:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjCGPfD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Mar 2023 10:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbjCGPek (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Mar 2023 10:34:40 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7186E83143
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Mar 2023 07:34:30 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id l1so13583628pjt.2
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Mar 2023 07:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678203270;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=56U3L/n2SWLavdhRRg0Yc0+2596Qz1l4ZkRdkLejoUU=;
        b=XE05ce7VjhLcmg2b6k24qZ4CG2aON6h0dnP5MrZA7IpCmkFOjSc56jZtmJXScBxysC
         uJJMGpzLgPndF5BdD9l+kufPJ39Ds74mzp56H+CzM0KXzWKUOTDPLVmWW3gXyFx8P1/n
         GV0A471MymaCiJnMtpsLU+ZoVZr3jOMnkdp0koibRo66Z+etqMOd9SPmoqw20DzVpsY3
         SEQC7+fdkqaXdj2WQuAtaDGp3MP4dIS8h+Yp5p6/2Ya9f2f71af2eupeXiRmWz/J4avN
         0H/Wo6xNB2JfaOQT2oVegcDKEl2/JTAciqpmqBfBsglS/G7R2T/MxPqLhfDrOXNPDABH
         X9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678203270;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=56U3L/n2SWLavdhRRg0Yc0+2596Qz1l4ZkRdkLejoUU=;
        b=Lz7a0UHdZrDhBFxaGOJvQy2BXAqf3WX9L0oqbADp1EGXMB35exeF2dNEbuMtyEC7fl
         E+7DuBd8YH5WlIYlb/UdvmbR1LKzCtp2FCoxqke5FGdLo482URMeX8SnUzN7KMHJjOlt
         4V7cHHYpdoT4Im/9s+ouMxEJu/rb6h1GITCpVrrk+/efO1UggkTUEVv9HzIG+RYfyrHi
         dmYoj1RUESY/YygvVY+Kwjjteboucrl+rItQX1N3RoWSIwSUXH0KDiLv3U41+8HlVKW1
         lOETzQuqDEFEHYpL6WNaEKZuD/Oyw/cKUQfG8EFIkBM3moKLtnVOkpEw1Dd7Ye4FMlqB
         vYUA==
X-Gm-Message-State: AO0yUKVFrmhZJpHyJ4HLAJEeXqYN9tQrZGSYO2AMHxosS26pOjcCzVAW
        XZzTYtRneyY1qQytnAu+A4UwkYLTb3M2+/B5bQ==
X-Google-Smtp-Source: AK7set9i5jTidB+5iLfFo/kIgbSP2yrxjysm14B1X3GeeckSSVOgQIQZ65cMFS64KvQAHlRwWUL6jMSu/c/TEMm3E1Q=
X-Received: by 2002:a17:90a:a793:b0:237:9ca5:4d5d with SMTP id
 f19-20020a17090aa79300b002379ca54d5dmr5442398pjq.6.1678203269829; Tue, 07 Mar
 2023 07:34:29 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a10:6745:b0:410:da3a:5074 with HTTP; Tue, 7 Mar 2023
 07:34:29 -0800 (PST)
Reply-To: westernuniont27@gmail.com
From:   Western Union Togo <yatche512@gmail.com>
Date:   Tue, 7 Mar 2023 15:34:29 +0000
Message-ID: <CALrTvTpK7z_gR8=vCLW9vZHQ5Y+sSttB9CQP5=xcGTA0TiMq3Q@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.2 required=5.0 tests=BAYES_80,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1030 listed in]
        [list.dnswl.org]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.8993]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [yatche512[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [yatche512[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [westernuniont27[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Your overdue fund payment has been approved for payment via Western Union
Money Transfer. Get back to us now for your payment. Note, your Transaction
Code is: TG104110KY.
