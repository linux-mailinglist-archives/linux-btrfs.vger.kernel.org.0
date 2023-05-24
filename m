Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A759870FEA0
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 21:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjEXTlI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 15:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjEXTlH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 15:41:07 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515B012F
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 12:41:02 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1afbc02c602so1541555ad.1
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 12:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684957262; x=1687549262;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b9q0xJYKnbjCtsYVm5R+zuCBKF3I524vT1yTL4pBX60=;
        b=YyYYGaBUDB0SwGay8IrSbJKFEgDp/QMTy8694cPki98MtwbEl7p0FfZwMPnCqLHoNl
         /CJG/7nocF80vonrYVsb02J94oRQURlW5aWJVvqzfcLebgi5l2fmgpNi2LPF0CrLygJ/
         Yv49j0KC4l7JogWav3KyEu6/0WHAPRpvnYLiytpjTPGNgyw1sMXSRQNEXrhtU1mW5+mZ
         btayc6z5SlZrQLbXoi5Ux86BdMy3tBwoZleykYdG9uvcZ5puHYFzVexSjUP5n9bYjcZ9
         KX0PvCIuPAvehIFzZAHAXFIYoLMqqH7qdhgIwU8ktLGGAsXwM1TZvXbLat+34MWPOeJG
         SsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684957262; x=1687549262;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b9q0xJYKnbjCtsYVm5R+zuCBKF3I524vT1yTL4pBX60=;
        b=eGarbJ/wMHp9mzX/LgmD+XIaveEYXgyY/kU8gz85GlX5f0ak9EBkOany5DDoaSTu5C
         jWsXa0P6+ydnxbFMyRB6yEIUgTzO6cjF5ZvU1soJBZsVDM85QZ+g+MiCWrCs7juzWttY
         fc2sPOJ3fQapoc9rMfjYcHJHce/x9sBQ48xDN+801jWXX+xbm8rPF5tzocKkyeSwb+cU
         mOabMwlJH3DgsvBllTiL8gSle8WFRAq3ytbqoTdO9+d5UFKogEQHr2jn8S+BprGXqEn0
         mIqPQZoK4II6v7wY+pHRyDJuTgflnziwNsXuu56cYmUHKz/AWUTmnKgVswwcD7bNMO/X
         +E1w==
X-Gm-Message-State: AC+VfDyqDAkPa5z+6hQHvrNzdvIquAizrPTYUwTZ4n2HIME0NfQyGiGB
        XwbvXNVQ1h5JsA5k/rk0RUI7GDUBuFpOSemXEww=
X-Google-Smtp-Source: ACHHUZ7F1pWghhKPn29tc+N3g6a6Im2oPkOWB06SKFXG0qYIQJ89/cAaU3RU+Jbhk7i8OV/ycKbdoOv2qpX14rN31yQ=
X-Received: by 2002:a17:902:f813:b0:1af:e116:4b42 with SMTP id
 ix19-20020a170902f81300b001afe1164b42mr275576plb.34.1684957261582; Wed, 24
 May 2023 12:41:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a11:627:b0:4b8:cbf7:c718 with HTTP; Wed, 24 May 2023
 12:41:01 -0700 (PDT)
From:   "'Katja Dabelstein'" <lulupipirere@gmail.com>
Date:   Wed, 24 May 2023 19:41:01 +0000
Message-ID: <CACkTDfYBV9F50G2oFT8JGQt1aWOmGuOSwaNXgD=8QArcxnppfQ@mail.gmail.com>
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
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_20,BODY_SINGLE_URI,
        BODY_SINGLE_WORD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SCC_BODY_SINGLE_WORD,
        SCC_BODY_URI_ONLY,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,
        T_SCC_BODY_TEXT_LINE,URIBL_SBL_A autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:635 listed in]
        [list.dnswl.org]
        *  0.1 URIBL_SBL_A Contains URL's A record listed in the Spamhaus SBL
        *      blocklist
        *      [URIs: 1drv.ms]
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.1370]
        *  2.5 SORTED_RECIPS Recipient list is sorted by address
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [lulupipirere[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 TVD_SPACE_RATIO No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.2 SCC_BODY_URI_ONLY No description available.
        *  0.0 SCC_BODY_SINGLE_WORD No description available.
        *  0.0 BODY_SINGLE_WORD Message body is only one word (no spaces)
        *  2.0 BODY_SINGLE_URI Message body is only a URI
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

https://1drv.ms/b/s!AhZh44f9Qh0sb9V5CJGp6nQAkLM
