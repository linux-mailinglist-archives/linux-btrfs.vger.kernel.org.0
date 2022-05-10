Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0950520D49
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 May 2022 07:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236777AbiEJFvD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 May 2022 01:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbiEJFvA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 May 2022 01:51:00 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7332D5A158
        for <linux-btrfs@vger.kernel.org>; Mon,  9 May 2022 22:47:04 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id x23so14048305pff.9
        for <linux-btrfs@vger.kernel.org>; Mon, 09 May 2022 22:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=9qPmmvdmg9Y7atUYbQm4tZIEIaskvmEAW5s2XXs56H8=;
        b=DpKjR1fLMr8sl4ke//sj7Du5TpKBdFe+tH5t4iFoDLHiAloG/dVnWTUFPyQTbjRu8N
         QmSehewIAwuUrqC/cXCBfxbnOXIV9lvxszTopXMR76OqnYNtqxsdkBxfkK+z3s+69+13
         Z2APjlCGU/BOJe9MarAxfWOMSCvfbPs+3u7KU52iJpDr/H2K5I99D3czdRIZeKqq6nY8
         pgb2J5YdtjQP4WO3GaI6ZVJ3t78pCJ/TAi/fbMkEf5rKR1Ayg5REr80/1SCsiO6ZqPtV
         eEDUCMhUK0aNWbE+3NWOQbnDSgWuLKUk/LLHX8KbEhJUGwcnEtCuF2HZATantBFANgTs
         ZoGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=9qPmmvdmg9Y7atUYbQm4tZIEIaskvmEAW5s2XXs56H8=;
        b=p8LDjDnBaMx4Hyo7qlycZNUW/UrTRt9nyCJsmn0OREOzAIdmrziFLwUFOHSOho20x0
         0BnsXELzQO7W9/JSAgfiqasKiFUZgb83pIe9NAK1Uyl5ET9oDh+1bocbpZBxxXzr9D1I
         2Ax+s29UWX7jzKGjUOwNwpyK/m4QgssTSf7VhvIMhBcKlbBTvq9XAehbY49e1Knmt5on
         lpjALUOd74AscMzmQ17cEkoFS80TBthdms0idszTahgIqo16u403BJBh1cD+kSIPgbHA
         XNik8h3rtTZHc8iGnPrCfuimtDPDPEO+XFRwomwNhhJgOOvwwjU/P3WsopDuuCgJuhzI
         HQNA==
X-Gm-Message-State: AOAM532NS452aNr7aNJkZhl1inbl9RYtcvk0vjaXQHsx96mknKeiL6YP
        oLBXGgLb+V2yIYqQhjW8o/OmmjXukDk0Ws5ooC8=
X-Google-Smtp-Source: ABdhPJyylpZ3eXKe1GyUfTyOG5F61wKwojXzn7zQO39JDQcyBVCcdnn3sxsPHnMWImJr4E/0ZYmzGxhbAJBkkqAvl8M=
X-Received: by 2002:a05:6a00:b56:b0:510:8107:5cf8 with SMTP id
 p22-20020a056a000b5600b0051081075cf8mr18478075pfo.2.1652161624049; Mon, 09
 May 2022 22:47:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7300:191d:b0:60:cb2c:ccd2 with HTTP; Mon, 9 May 2022
 22:47:03 -0700 (PDT)
Reply-To: sgtkayla2001@gmail.com
From:   Kayla Manthey <kafouiapeti@gmail.com>
Date:   Tue, 10 May 2022 05:47:03 +0000
Message-ID: <CAC6cm1+TZAkw3qRc0uj7m9FFc3KHWSG64xVA1UKHTz8azg5-SA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.0 required=5.0 tests=BAYES_05,DKIM_SIGNED,
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

--=20
Pozdrav draga moja, molim te, =C5=BEelim znati jeste li primili moju
prethodnu poruku, hvala.
