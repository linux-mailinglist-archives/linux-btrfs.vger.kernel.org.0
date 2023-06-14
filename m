Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BA573057F
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jun 2023 18:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbjFNQ4t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jun 2023 12:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjFNQ4s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jun 2023 12:56:48 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7DE1FDD
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jun 2023 09:56:47 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f8cc04c2adso9958725e9.3
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jun 2023 09:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686761805; x=1689353805;
        h=content-transfer-encoding:mime-version:to:from:subject:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dHI/zltTcz1UFnYCpfSmsG0j350+Jdu04JTLrqZ4NTs=;
        b=YGF52pHhEDzN2n6nGYSFtFO6Eim05DqsQ5xkpDFl/t5t2eVBNIpmrsbzmH8KEuWm0K
         /Zucvzk6KBo52roF39WXRQK3sapR0icYvux44FIIgKAgEjYpUl8R0+crs2Y4SjvZ32H4
         RiNwPdK5HnZnwlZGtLfBg8RTt6mwzRYgdGdkVGC2segvzBi5LSUy5dRgb4HXTS915r/R
         //XXVzZkkWtochmcWJCBfUaFFNS+XrDkItoi+5NAy5/xzPlTFyJwYuWZopY2rwKLl4tk
         qIZMywdY30TRJ0CA6dS2r74hIHduPqtItxeIUK/Amlq4xR3mxQhUZkxPXtKz0JtwSmyx
         VndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686761805; x=1689353805;
        h=content-transfer-encoding:mime-version:to:from:subject:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dHI/zltTcz1UFnYCpfSmsG0j350+Jdu04JTLrqZ4NTs=;
        b=ITKNc2LZLC9CetxzAkIgb3wGFeu+WjXGoE3FyiTg/JwAZ20JvaJ/fzkBYmDB2nPNyP
         vsfwutYzIHOiGag1XW4Ay8N/BoQ3Bom7gOA41HjjzblOvruebl+fm1IfVrQ7T7f0uhQq
         9HuKzg+YBn4L+Zrlgk2LSlSLUYQZ4E41u74v8lGbrCup3bFU7p48GUbVyuHC84Vx7r5f
         ai+OtB1j/9PBHtTL1mO0+tW4jtfS4b3zoSvMWgNHiwQ7TLtfZxJUh6R/SKXp96xKVQUf
         A9aLncF/XlBXhLvtLZsty7oZsRs9nyzWy3M73F1axbXDjdZ0P3JoF5H7H6XhOCodMg4T
         xdvg==
X-Gm-Message-State: AC+VfDw7ajWXQMS4YyTGcbI5fvuBa99v8/AxbWb0u1mVZ+MxImglFzN7
        hvGK0lib5hs7Je0gvbKjElUJFx+Gaz7Mjg==
X-Google-Smtp-Source: ACHHUZ5pTfipyDASHizUdGt6hGY4CjONi5nbETV0EtTeMimqxetm/lqgIgt2MDMnmv9Goyz+3Kg0Tw==
X-Received: by 2002:a5d:4d4f:0:b0:30f:c2b5:3990 with SMTP id a15-20020a5d4d4f000000b0030fc2b53990mr7299387wru.58.1686761805340;
        Wed, 14 Jun 2023 09:56:45 -0700 (PDT)
Received: from [127.0.0.1] (178.165.164.65.wireless.dyn.drei.com. [178.165.164.65])
        by smtp.gmail.com with ESMTPSA id k7-20020adfe3c7000000b0030fce98f40dsm4821487wrm.42.2023.06.14.09.56.44
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Jun 2023 09:56:44 -0700 (PDT)
Message-ID: <366b73445f304b321015c47aebf29b5f@swift.generated>
Date:   Wed, 14 Jun 2023 18:56:39 +0200
Subject: Re: Domainname facilityguide.de
From:   Rudi Steiner <strudolfst3@gmail.com>
To:     "" <linux-btrfs@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Sehr geehrte Damen und Herren,

facilityguide.de wird ab sofort angebot=
en.

Ihr freue mich =C3=BCber Ihr Feedback

Herzlichen Gru=C3=9F
=

Rudi Steiner


..................................
