Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F356706693
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 May 2023 13:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjEQLYd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 May 2023 07:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjEQLYc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 May 2023 07:24:32 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5781B3
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 04:24:31 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id 3f1490d57ef6-ba76528fe31so8562172276.1
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 04:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684322670; x=1686914670;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=czB/HliNlFMZVGXH2kRucIXrmZZ48EMsVZnHymjAGEc=;
        b=hpamZMTVEnZV47Q/79EgHo8vtHINcALMAa+whDVpixuJ1RsDRmyJRnqrX+C4d7BQ2l
         hN2NicK1JDDKNx88KR5KGEF22CDNlB2r91FgTyK59RRB8aeD0B7WR4Aw8/DXMABAEL3j
         y053usYUAYnnFGx6Q/DH5mMP0BaplYGeYrvoK+jKXvi7vJhQUQEJ9N3OVwf4Pa4IUs5A
         fldqLKYXQl4Gj2CPNf3lWNSNoaQRRyilaHGMFThDvqS27NCgFTdUPqHCLlWc3FgAIQfD
         w9AMgtAScyxVUUbzgM8a0t3V9CGXx2hkeamhXM+qzrAp1jt4eoLMJpcfBR7Rmf7HylJB
         WfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684322670; x=1686914670;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=czB/HliNlFMZVGXH2kRucIXrmZZ48EMsVZnHymjAGEc=;
        b=OskOnSAY+zMwglFoOO+retkJxelSD+E/XUSxBzKJ+YgqZC9ZCb+5c3GPzsPqSHIBKY
         DEvydjhEdvdyaqIwnG7moGhba001+OLnyta4uinOFw8MCVW79PGfSfbH6brss8UWXFlJ
         NLDbUuRUzgm46+hsCscED0M7cwD7hK1Uq3INaSsmS4IhVI2t5/Z1ucmtNZgQVEJaTPuT
         yWDn0Ach9rO7wJMFiLa39NDuhNcaE7NWaxCRRx2NfkWhekONgkwW+DRMsXwoyghEfTiE
         QEq4GRamlxmYHP+Omep8k/vJpYPKfxuazisezQ3yC9YuBzLXkrJiwTjhOeI82KTQMwko
         fTVg==
X-Gm-Message-State: AC+VfDyFaBsClGlnkjPGdPdjVDw7XyEpe/AtM6HNCcJEX4lb/QS7YTPV
        K6MCu+z7gtmCEiTa+Qoka5aoxh3e7cTTbz4h8yWKA4hkFXY=
X-Google-Smtp-Source: ACHHUZ62xzY0dYPijIhnmQTmPCVlmPOcmS52Hc/ZZNCF8Ke2CUcGGLuHkxE33Oet/VV9/ZOKqfQCnSDs2abAKr6/hHo=
X-Received: by 2002:a0d:c605:0:b0:561:bbb8:2dc3 with SMTP id
 i5-20020a0dc605000000b00561bbb82dc3mr1441921ywd.21.1684322670236; Wed, 17 May
 2023 04:24:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:499a:b0:340:969d:199 with HTTP; Wed, 17 May 2023
 04:24:29 -0700 (PDT)
From:   Subhan electricworkshop <subhanelectricworkshop@gmail.com>
Date:   Wed, 17 May 2023 11:24:29 +0000
Message-ID: <CAF1CeMUypEacJyT_jvy+SZWyd2vxX0_4TgF0HTB1Od24nN9jpw@mail.gmail.com>
Subject: Franz Schrober
To:     Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
        Jesper Juhl <jj@chaosbits.net>,
        Jean Marc Valin <jmvalin@jmvalin.ca>,
        Jonathan Nieder <jrnieder@gmail.com>, jw <jw@jameswestby.net>,
        kim phillips <kim.phillips@freescale.com>,
        kovarththanan rajaratnam <kovarththanan.rajaratnam@gmail.com>,
        linux btrfs <linux-btrfs@vger.kernel.org>,
        Lars Wirzenius <liw@liw.fi>, lool <lool@debian.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.1 required=5.0 tests=BAYES_05,BODY_SINGLE_URI,
        BODY_SINGLE_WORD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SCC_BODY_SINGLE_WORD,SHORT_SHORTNER,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

https://bit.ly/42IeBEu
