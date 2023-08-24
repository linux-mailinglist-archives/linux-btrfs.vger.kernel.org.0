Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6AC786447
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Aug 2023 02:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238910AbjHXAil (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 20:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbjHXAiP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 20:38:15 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237F5E7F
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 17:38:14 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-410ad0ae052so1843601cf.1
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 17:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692837493; x=1693442293;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tnwf4aJQsQwTXNOrqPEoMOZGqrQtssEVqTSgm4DnpRo=;
        b=Dm+x3Dl8kNl3xaompkvAUwcm76bqT6wrRNa8g3PIMgsx9TQeZq+g4dKPeXFX8SMftU
         SmXqFaxXzpbnORfHVmeRfd/z0LD3gyVGJ8v2Vw1ZtPA0A8BlpWg3bKsbKL7PnWisGdxY
         87Zj+5ctIFpli4Y6OtOTJrs3Tk+vJ2pr9QwqCXOerEXkqwiE+EAaBM5qr8OgDKiaJyww
         vL1FYVK7GyRNomoC/1bBrcB0N62w9Kwyd8Xin3yKeNZc5nnkQdaJt4iVEavJwmY03Wlt
         VoZqmWM82ULeVrFPSuGyW4DAPM4lzL+nxOTwbeAjlspTsUauqSThVJRO/MfAHyBIf8bM
         VfAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692837493; x=1693442293;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnwf4aJQsQwTXNOrqPEoMOZGqrQtssEVqTSgm4DnpRo=;
        b=b6YqCVSdklk5U0ZA9N46IHmR2zdCjraOs7/YF6TVXHfqOc+TFLGQ9yo3rnCnLwKWRR
         9hzgnDQAQcbz2IB5AhFN+fPoo/cxT0u2KEE6OOjoyug6CjJHXIK8KnkPwE1dCUIWh7So
         Or2nHWaSXxbdEy/6FEX/O9y6S3gp8apccP1wJ5gjRbsdLAKRv06L9JHmqR2pfWa1LZzk
         JSgsCQBayN19oKo6MgiY1tdRToSTLS9RYOCjfKOrqQP4z4DYUzdxV/x4JtYLPUIoxVMg
         vamI+eknCSbKs0RtrxJrMPgVXL4fDkWUT0kD4mf4siX5v5wLO+La4sfHqdqS+PuE5nDk
         Sdqg==
X-Gm-Message-State: AOJu0Yx/mD9ACoZ82XeGM7+Wf3J7FS5llu2nkY8nKuLUh1qVk0qZ02KH
        AoOfuGpgy9YlBcy+5bvrsWUnKFIvm6h8fQ==
X-Google-Smtp-Source: AGHT+IEC3l8eCPX1WPsyrxPX/C2RwfDQQaN3kpxc6gEN7lmJT8srpa+aPBWzDsgc1gaYMePo+rNuUw==
X-Received: by 2002:a05:622a:309:b0:407:c2e2:2a06 with SMTP id q9-20020a05622a030900b00407c2e22a06mr17063913qtw.8.1692837492649;
        Wed, 23 Aug 2023 17:38:12 -0700 (PDT)
Received: from ?IPv6:2603:7081:3406:8f26:cc85:48e1:2259:9b56? (2603-7081-3406-8f26-cc85-48e1-2259-9b56.res6.spectrum.com. [2603:7081:3406:8f26:cc85:48e1:2259:9b56])
        by smtp.gmail.com with ESMTPSA id h20-20020a05622a171400b00410957eaf3csm2519383qtk.21.2023.08.23.17.38.11
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 17:38:12 -0700 (PDT)
Message-ID: <4a18c53b36e312b3de3296145984ed74323494ff.camel@gmail.com>
Subject: btrfs check: root errors 400, nbytes wrong
From:   Cebtenzzre <cebtenzzre@gmail.com>
To:     linux-btrfs@vger.kernel.org
Date:   Wed, 23 Aug 2023 20:38:10 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I am getting these errors from btrfs-progs v6.3.3 on Linux 6.4.7.

Can I safely run `btrfs check --repair`?

root 258 inode 123827824 errors 400, nbytes wrong
root 15685 inode 123827824 errors 400, nbytes wrong
root 15752 inode 123827824 errors 400, nbytes wrong
root 15760 inode 123827824 errors 400, nbytes wrong
root 15768 inode 123827824 errors 400, nbytes wrong
root 15772 inode 123827824 errors 400, nbytes wrong
root 15786 inode 123827824 errors 400, nbytes wrong
root 15798 inode 123827824 errors 400, nbytes wrong
root 15814 inode 123827824 errors 400, nbytes wrong
root 15818 inode 123827824 errors 400, nbytes wrong
ERROR: errors found in fs roots

Thanks,
Cebtenzzre
