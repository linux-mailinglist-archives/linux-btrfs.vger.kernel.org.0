Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62D94E87BD
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Mar 2022 14:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbiC0MoC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 27 Mar 2022 08:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiC0MoB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 27 Mar 2022 08:44:01 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCFE2CCB5
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Mar 2022 05:42:22 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j18so16636934wrd.6
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Mar 2022 05:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=47kf0ro8nQHAkdX3vdQ4dzT4S+l40LvxJF+veew1+30=;
        b=g5iDi03CqSK1gT7Rl3ELHwCC+wscOklYCNc7cU4m13U7z8gVOkm+TSN75G352PBS1D
         QC90n2TupO9odKfmNSLi0Xmxat3NWdq7V7DaT6FG0iytJzLSJ1oSBAhLDYkrXhBcG8Iw
         wXfb4FqQhGvLYGITD59InULy8W72bkzTeW6eNLKV8r+n/rh7Z/WIDaJk8LRRvXUMOqGr
         +VyAt+5WQ2Y4PD3M6wZDs/361UUzpw1kDWdn5g0VjJXtzermTvSkdOrOJKb6nBwMxhHW
         XAEtoLUMb4qpIvVRa8SAanJOwfwxuS6T4tiL8fWjVqjAXyLV6HKnjOPtjTqoTG2GgoY1
         uj5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=47kf0ro8nQHAkdX3vdQ4dzT4S+l40LvxJF+veew1+30=;
        b=1GT1Mil84FmhFiyezg8HlbBlB4QbeUgiRcxqeDksOHnL63bvYrceBgNGQ63viS+0jF
         SnavoheqIS/ji1RhTvyycOoXUuIILPkotqh/59NgQuNUoHBxn23FhESjqDkLu4c0uZPr
         fVIxTyZGORDYKpvgaOXhC3jPK0Q5J4TYy3lvITvT7l1Sj7MVyLrM+1DITagBTq9hZIRN
         ue8/tLHIf25PZyfsd2GwJvCq2uryQBczu+gOwPOPYYPRuSGzUTnuhnJctFdJzW7fk/Cu
         ESZRKxf7EYkkayUwgKd1gT8cTmqPkBF/D7udstjBn1VN3+nuwW9djkCc0YZYwPKbnZjg
         AH+w==
X-Gm-Message-State: AOAM533SaAr7xV+jUFjLspbomQTPWP2gqnyW/ORULnF4G50AzdcoQN2u
        5CCcJjYVxtg/YeqBOwDKyko9SN1X3gXyyxOXp4Q=
X-Google-Smtp-Source: ABdhPJzm2z+NnpxN7FrI8csFeen2lFDpjIUrqfmqTiwS9/+y3JYfleJER9appDy8yPTU0BU13K4iqx6tJlHVhSjrEao=
X-Received: by 2002:a05:6000:178c:b0:204:670:5b20 with SMTP id
 e12-20020a056000178c00b0020406705b20mr17871031wrg.637.1648384941096; Sun, 27
 Mar 2022 05:42:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:ee8b:0:0:0:0:0 with HTTP; Sun, 27 Mar 2022 05:42:20
 -0700 (PDT)
Reply-To: wijh555@gmail.com
From:   "Dr. Irene Lam" <confianzayrentabilidad@gmail.com>
Date:   Sun, 27 Mar 2022 05:42:20 -0700
Message-ID: <CANrrfX5rii-saHB4UsY47PZYDUWq+g85JCoUyfah2FCvsz+j_A@mail.gmail.com>
Subject: Greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_40,DKIM_SIGNED,
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
Hello,
I'm Dr. Irene Lam, how are you doing ope you are in good health, the
Board director
try to reach you on phone several times Meanwhile, your number was not
connecting. before he ask me to send you an email to hear from you if
you are fine. hoping to hear from you soonest.

Sincerely.
Dr. Irene Lam.
