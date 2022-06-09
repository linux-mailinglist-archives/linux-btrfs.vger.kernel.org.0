Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBAF545693
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jun 2022 23:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241676AbiFIVkp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jun 2022 17:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbiFIVkn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Jun 2022 17:40:43 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16C44ECD5
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Jun 2022 14:40:41 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id i15so4509449plr.1
        for <linux-btrfs@vger.kernel.org>; Thu, 09 Jun 2022 14:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=mZ3wqB4NmL7z6lpFr/h15h1rYqsZKafJnUpMVahbEPg=;
        b=ZkYftyRGpMcveXvJMpgQmrhv/AK+OIR38U0gj7+k5ToXazsjt8DA47VgB7wH22vUOK
         M9aLAz6MZ8Ji+ZonR0ZSDY7evDSyDH0u/u0b+RCfUHZrlsu67gqbVifLnBg31WKMJxH4
         xcynhzC6bydaokSx01xdrt+i4Jy1OLTt/y8ZYV0y2McFs0hO5wCMkxJJMBWqCbWqsToM
         xP344HcvBx8v9Px/I/SS5E6eIKEGcjZe+HDvAiFszmdAZF8Z/nZKAzYf4hBT3R5qoqVg
         y+SnNDPebj5YKuwntNgQHSf5KgWpHGG8XE4Qlo3+wNXrLKiJXr5hbcwcAajdubUFRJ33
         l+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=mZ3wqB4NmL7z6lpFr/h15h1rYqsZKafJnUpMVahbEPg=;
        b=cXDC35rHscyBNT16o5fagMm75wBgTdcaCN3wOSFsBNctv8hR71UP9DDnGeBnpnJfkw
         by9/wK5B1fqgP4t5egbVSvejd3BrDZaNWoTE6VQpPeBJi9MWBQqWNLIw3juS6jLyrJKA
         Fx4HSRavHKjKlCBFiON3jRGPfQrDaAeRzqTLBcwbpc0bEkZmzuuPYJj7bUEjclk33kX/
         NZPLnr7pS4p9TseU7vGaobjgLztPxLxSzPGLrW0Mh/9g3wC4+V6sBqmdmFjWkJMGhvyJ
         9qkJB8cIKtV4If0RqJew2ZbW0HOU/wcp6kwtiDrobPx9ZxS5Lr1ye50ecyzK605f5kJM
         Lgvw==
X-Gm-Message-State: AOAM532vyRwig3pRkL99IPY8uHDl+mTsqnlMlxhg5T29+2OO704Md+zv
        yBJY2EUCMRgOUJeAxKCObjznYQ8x+pSgsbklz8Q=
X-Google-Smtp-Source: ABdhPJyvXzC7vzoiAK5Hno87Wsj+tz7diAQck7L3KllSWvCqdiCm6FzxfaW7MwzjdTVidsQ2kFUxqe/C4WwHSPk5zDI=
X-Received: by 2002:a17:90a:14a6:b0:1dc:f64f:ff2c with SMTP id
 k35-20020a17090a14a600b001dcf64fff2cmr5310519pja.161.1654810841155; Thu, 09
 Jun 2022 14:40:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:902:8345:b0:167:8960:e2d1 with HTTP; Thu, 9 Jun 2022
 14:40:40 -0700 (PDT)
Reply-To: wen305147@gmail.com
From:   Tony Wen <weboutloock4@gmail.com>
Date:   Fri, 10 Jun 2022 05:40:40 +0800
Message-ID: <CAE2_YrA41yWrKODFfwcbqBbUpXMTLrM5z10qZAzkP_7r3_uvOQ@mail.gmail.com>
Subject: services
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.6 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Can I engage your services?
