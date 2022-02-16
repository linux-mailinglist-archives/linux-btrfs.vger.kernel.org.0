Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982B64B8FBE
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Feb 2022 18:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237360AbiBPR4b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Feb 2022 12:56:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbiBPR4a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Feb 2022 12:56:30 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4FB2722CB
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Feb 2022 09:56:17 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id j24so2342798qkk.10
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Feb 2022 09:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=JCh5aT6OzoQ7MrerEIA0YqDqCefcKWII1DFdmjEdezY=;
        b=pKlKHTgpPvYb2cUoxK95JR/4USpoownSmG0eacJzN1X7GNm52N5R1yYYU/2gbWvdi0
         JkhLsCgZVCG4VOtTddFXdtdB/18GU3TuGkSFTGsIFCQ3J9KQFfOd6XzN0yZGqmqo4DZM
         9Iy4LZvA3vrYSSRtzNKvA+yyZJcQxeodjiw5Fe/mEHNuQkOSWDg9lp5/dzdPy8+B2uL9
         MPIMa7QmdkeWiYKWy+Zt+TYtqpIIRYYohlBRKiw5X/5s4eHtPIPiwiq9A8dMeOoAaheO
         ROsk84OQDZ4Yeiml4+9kNOg6pa81BInlW7mUdN+pkpV43UqdvLZFFb7o9iDbftX9TkOo
         AKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=JCh5aT6OzoQ7MrerEIA0YqDqCefcKWII1DFdmjEdezY=;
        b=JX1F1V5ZMzej/06Ym05Fj23sHpmnk6JCrNkhssjhe1OAY+qPc8kSJdG8Cyzl3Rtsur
         4ZHU+bivOLoNlClRnXzINzXPr4+F6sNcc4DBwEt/OnEbvDHsARTIjVmB1XKmqJz4QZ/x
         Nx8S2Ay6rRWoukFGLSju0i6iZFsvYsedztSoVkgx1CyWhqgU4GwY4TcPUtyRlbNAxVld
         DWFxXlFv5eYK4/IfaqjS07SloHKkiOFB0v4xzpToqTv7EHS7/3bxTgxkP7M+HBtaTV5u
         6NgvqB+4240VBIFOqdlmUD+pVV5+pvAtwdbwFfCaCu1Vg1yR2Faih6bjbeWvc+1G+rQX
         Mi8Q==
X-Gm-Message-State: AOAM532/Sro9X4/LMgTyRayNUKxnfK+n/trk3S4p633GO4FHK6V6/Uk5
        9rRuL5z26o30THd+c/5TR/GBbkACNY/G8tTaajA=
X-Google-Smtp-Source: ABdhPJwnMiVITwHiYObbeeLyhFjIkzX3iYTezS0x7qP76kfe/yprW7W82WXHUznT6DgyWSJ5iPDH+nZjkdp7fg4/CLc=
X-Received: by 2002:ae9:c10e:0:b0:508:18c1:147e with SMTP id
 z14-20020ae9c10e000000b0050818c1147emr1963897qki.570.1645034176948; Wed, 16
 Feb 2022 09:56:16 -0800 (PST)
MIME-Version: 1.0
Sender: mrssuzaramalingwan02@gmail.com
Received: by 2002:a05:6214:19c7:0:0:0:0 with HTTP; Wed, 16 Feb 2022 09:56:16
 -0800 (PST)
From:   FAFA ABUDU <fafaabudu@gmail.com>
Date:   Wed, 16 Feb 2022 09:56:16 -0800
X-Google-Sender-Auth: HNUtTKakU1xSXNGegM8ZlAWHrA8
Message-ID: <CAGoqFBT=LLF_bjo1_Zm-GJmyz4Zr-86yHfj0D19b_=baKXBTGg@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.0 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If you are interested to use the sum US17.3Million)to help the orphans
around the  world and invest  in your country, get back to me for more
information on how you can  contact the company

Warm Regards,
MRS.FAFA ABUDU
