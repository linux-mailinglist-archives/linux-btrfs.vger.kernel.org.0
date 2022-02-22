Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4041E4BF749
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Feb 2022 12:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbiBVLe3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Feb 2022 06:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiBVLe2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Feb 2022 06:34:28 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC0D134DD6
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 03:34:02 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id w16-20020a056830281000b005ad480e8dd5so7870254otu.9
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 03:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=vTR/8Rp3ZPOCxUywjE3qAbiASt8/c0tKigqqky7YLrE=;
        b=ltrbfvCT6+lXaDlug3nX3FRgl/xApFV1D7BsUuQSRpCbaAexboDwPXt0iHqapfLfkE
         Wy2UEWzQaeYEEcCQe9Ri54hCyvGNUKOYCRvpu6bhCGd1HkRKrPwz+HaCID97fP/S6sy5
         FGDLfnWLxdSCv82Lt81oKUoeoWvEQhnraHnpwKE3VAn9IJ6R5l0yhkMutPes2Y7d62qq
         eelnkR2o8VQqGcslxCkK84OLn17p9fh04rKdwVnJouEfHB8dfU6wd0/LLHPqY8ELQ/KG
         ug57E2P4p2ORUY6bRASeBBUj6hqdNYcOLBjU6txyNu8gNW4gyC3vuTD2Y3xijYcRXemI
         Ii5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=vTR/8Rp3ZPOCxUywjE3qAbiASt8/c0tKigqqky7YLrE=;
        b=R2Divjw6uxyz3hBBvf6+FpoLLNg3o/wBzoP3epkWhNgxF+futvH8dVeKJx9UfF7DSK
         EU2L60ULFPug0ZxZmTm+PIcYLE/FG38tBSpJuOQDvuwuTYNI1BFcyBBra1JvzoIW/kQP
         psEH8aEI1I6IiswbZQThuSslVSY6+SIjAc7JyEsmpUCyRlFewJTeR6/sfDbFZTQxtpPw
         s46s9lHtwwN5vyi8P4KlDl7pPPfUC7aRY6xsQEyc2Mm3t0vdYVuM1t4CdblLrwjq0nlc
         tdbwI7hTrr/AXGJjjLdAl9jph2i1uXbRYUhbtGLsuVoOXcK0UBYiCyhZVki2v2Pdd8oC
         k7yg==
X-Gm-Message-State: AOAM532cDtQSLAAFnLd4jwAgGEY+fYdiizBNyoXBTlUWR8e+pWw1ovDp
        V74sg42h84TSvvWxNW/cIXsN9uQheByMcMb/KPA=
X-Google-Smtp-Source: ABdhPJzLZZyvYqpaPzoRuAqTNcqYfTpFrzw/aTzBdT0SF/L4MdtrYtEF77pAkMHyG4xsxcYwEXlmrZbawu0k6Ot/PFY=
X-Received: by 2002:a9d:28e:0:b0:5ab:e889:2560 with SMTP id
 14-20020a9d028e000000b005abe8892560mr8200768otl.119.1645529641529; Tue, 22
 Feb 2022 03:34:01 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a8a:481:0:0:0:0:0 with HTTP; Tue, 22 Feb 2022 03:34:00 -0800 (PST)
Reply-To: donaldcurtis3000@gmail.com
From:   Donald Curtis <alexandrinekengbo@gmail.com>
Date:   Tue, 22 Feb 2022 12:34:00 +0100
Message-ID: <CAH9ijYnaTxX0zUu=-Rx_Eni1x2p-sYvqh0PM8pLuWeNdoCRMHg@mail.gmail.com>
Subject: Donald
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

HI,
Good day.
Kindly confirm to me if this is your correct email Address and get
back to me for our interest.
Sincerely,
Donald
