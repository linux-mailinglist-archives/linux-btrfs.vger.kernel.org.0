Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D5664FE1B
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Dec 2022 09:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiLRIul (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 18 Dec 2022 03:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiLRIuk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 18 Dec 2022 03:50:40 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE0ECE2A
        for <linux-btrfs@vger.kernel.org>; Sun, 18 Dec 2022 00:50:37 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id bj12so15158784ejb.13
        for <linux-btrfs@vger.kernel.org>; Sun, 18 Dec 2022 00:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZiLNbpeJxAiCy9MiWNZfHlqYT0Azji4gfFwNkcdq8vc=;
        b=Vs6albOlsRIqz/dJQ6mmDb1TdtVb9oX4yiuVB9zEG9m3OmdFnN8osXLsGkI5dTzrow
         ffy3ldbxlVmmnZPUCaDOW1VPDXVjXqdaNzj/KhNvx1ITKUBqT8lnrg+n7lePraOyPBHA
         yrtv0e2FrFcORGeYGUV4R2qLG6iwaMC06DhwF8OmCqyN0ml3jHk2NKr/EzzWbd/4OIfI
         jcUysu9un+rxnPzCTK6yBu8WGASFZV9QBeG46/XikiymJNKn9zj7kkGdrbJHlhitYDR+
         edjTxyfLTdJmxMdy7JxHVHJwVuCbgW3oFOy69vpuktrR6aVQ9aM0++PRFzfIS5VIF0o+
         snmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZiLNbpeJxAiCy9MiWNZfHlqYT0Azji4gfFwNkcdq8vc=;
        b=Y1AvA0INVCD1c26gXzoT24u0Y58J5Fp1JMPE9fsqprcpoBIbffgsWDYaaah0YE07Jq
         Mv+I1Uwgunfmpt1cZxXEhNyH/HANXoJGYAGP48pqVpp7dryMe4LUSZrm4aBvJ7W8K/Xc
         /QNhZlZ+7/V3N4zGNLMTqp+w4TGh0gj3oDXbnb72MC8mk9cvPmyGSb9PQPjGOGt50RF6
         h3KV2Sf6KLSyUABqQGk2Bx4nVIhayJeUqMr/LliQ1N8TZErtsasZCP7hzHfM3PgP73wB
         XhdB2/QJJEGanERF4ZnAeHdaERxtMNHhXqUH1Eskx8N42MXmdsvfKvCBvv+f0wKnScCM
         +1Nw==
X-Gm-Message-State: ANoB5pltemeTA8VtzE1j1aj73zRAJXLt0Bl/2BNAISytM1bgZwQYb7En
        m5bimUgBMjZJPQk7Crqrk6aiNiSKtXif2sfCzbg=
X-Google-Smtp-Source: AA0mqf6kX0N0GFN6fWhuqawuRb+8lm4qbbdRCNjrU7qQaa9UDaxFeMFFEXCl1tqNlb0gW0fOA7wsZ5JeDJi11rO8clg=
X-Received: by 2002:a17:907:11de:b0:7c0:e4b6:47a5 with SMTP id
 va30-20020a17090711de00b007c0e4b647a5mr18954410ejb.480.1671353436413; Sun, 18
 Dec 2022 00:50:36 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7208:c588:b0:5e:bcb5:ca4b with HTTP; Sun, 18 Dec 2022
 00:50:35 -0800 (PST)
Reply-To: mdm223664@gmail.com
From:   "Dr. Elvis Chi" <laviis7111@gmail.com>
Date:   Sun, 18 Dec 2022 00:50:35 -0800
Message-ID: <CALMQbW-V=k=pW0YRn_2Z=+hsvrugMRE02yWEJ=gs0LMcFKLveg@mail.gmail.com>
Subject: Very Urgent,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

-- 
Hello,
I tried e-mailing you more than twice but my email bounced back
failure, Note this, soonest you receive this email revert to me before
I deliver the message it's importunate, pressing, crucial. Await your
response.

Best regards
Dr. Elvis Chi
