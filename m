Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556F270961B
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 May 2023 13:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjESLRr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 May 2023 07:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbjESLRq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 May 2023 07:17:46 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A9B10F4
        for <linux-btrfs@vger.kernel.org>; Fri, 19 May 2023 04:17:44 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-969f90d71d4so480048666b.3
        for <linux-btrfs@vger.kernel.org>; Fri, 19 May 2023 04:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684495063; x=1687087063;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmxaI1amCfTksu6ynk2557PwK0HJxrBQmYIx/Pz5hBs=;
        b=Eiw4JAU3c1Q2BJpBu1tvSTZba4z8SbBucbbhiR3frhv7VlB6Qa8tbmbHXfQfqk9GA8
         UEo8VemXoK1wKqQFZOpC8T91jLsWsbwSFdtaaLUeA/Vwz81AcxZdsuKZX4h/NtnKKzmC
         2tvQXLcfGBiepPGjbJe1B2KwvsVp0S6ct1r4pwgcr9Ad/erjUhWNo2wdI7StoD2mJqjA
         ZgBYyriSfxevToJukWdFsz73GWHJq4E4bG+PiaobB+o5pECZFFXEF2f8vPMokQOdAjd1
         Rc2Wj9xb+DHV8rPGR9rM6kDSkczPvwBV4gzggVrmfXpI6aMAOJ5GMWJqos/IT+JfHY7l
         hIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684495063; x=1687087063;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YmxaI1amCfTksu6ynk2557PwK0HJxrBQmYIx/Pz5hBs=;
        b=fCzjxkKrTvQUys/+lIELIciBlRoAlXBPQVWwCL/u3X8oaV6nxC4OAIMc5HjrvfQ19c
         FO18SEe/Ak2SNrhiCC4Nr3RKpuO6MFvzY8HL2LaFilyf/Nos/LybDa/5yaiT9emVgTar
         kuq0NRqx3y9UuX1x6UM9WUYpaPMsujiLvP2aqfYXuC+ClNHkOZtluDb5PsU5FphvHcMA
         SshesdElbAHZL1s9eDemkl2f6tvZjVIk1zGeW3jDwC/PU5oCmAPWk2gTn4+Eavnpcsc0
         MottBtmasZSzRX6jLBTXicaS8HApyZtKk2k93XLfH2gw+Z+GXz2XTcWmlSfNrPxkuaDz
         i89w==
X-Gm-Message-State: AC+VfDzOUW1a+Ms0GOa0C7k71fcDWSZwGttbbqwrA8knzgVSiT+6gLQ8
        jSHHWL4CW/1bo3iudmAjFAEvUTDZHOcYKjqHwk4=
X-Google-Smtp-Source: ACHHUZ4GcdKjctEWmkMJD/Q5ZDCusH7zrjV+w4c4EgP8GDbM+BMa7NNuPpP4cOMUW2oAUk/kOHHzW6hqw5zKR98kQX0=
X-Received: by 2002:a17:907:1b12:b0:8b8:c06e:52d8 with SMTP id
 mp18-20020a1709071b1200b008b8c06e52d8mr1298232ejc.36.1684495062361; Fri, 19
 May 2023 04:17:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:907:7dab:b0:94f:7d03:8e8b with HTTP; Fri, 19 May 2023
 04:17:41 -0700 (PDT)
Reply-To: ninacoulibaly03@myself.com
From:   nina coulibaly <ninacoulibaly199@gmail.com>
Date:   Fri, 19 May 2023 04:17:41 -0700
Message-ID: <CAM7Z2JAd00KW6b=O8M27vwRnsJ1w3AmDO5tP+gSmzkaHvk6=CA@mail.gmail.com>
Subject: from nina coulibaly
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear,

Please grant me permission to share a very crucial discussion with
you. I am looking forward to hearing from you at your earliest
convenience.

Mrs. Nina Coulibal
