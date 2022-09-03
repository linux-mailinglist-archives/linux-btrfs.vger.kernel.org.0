Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DD35ABBFC
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Sep 2022 03:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiICBJC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 21:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiICBJB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 21:09:01 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492E7EA8AE
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 18:09:00 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-33dc31f25f9so30222487b3.11
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Sep 2022 18:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=E+ajkPOCiKpgi10ZeArLTtbDc9uBNA7SEB1kzCenf2E=;
        b=CgIVjwR7sIjVMBIX2528ixznS0Yil2U/iTg03LSX+N3BWS8aOr9/TH9AqEwKR+LNM4
         5wToql9ATN/hDU2W11z71/oJB6l1t/0u0vkuw0/WFrkDPJSMaelJs5Gfa1eLW5/1fwN8
         PGYz5njNc5Ish25/fPnALl1BouYDIjIlLS28ivIDXRAZ+y7nYGYqpEj1ivvG9K13EL0t
         Zce5BJnC/QP29B9STyeC5vx/mDP8HDQzkKQhvi5Q6+oeYoTZqujwi2d830f6kc8q0px5
         VZZW+GDUYtY3vffiN5rQH1YaDXO3a+Sve2LapO6c3SK+O/q95Ee92awEAZ+ikWeg6ep8
         +qug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=E+ajkPOCiKpgi10ZeArLTtbDc9uBNA7SEB1kzCenf2E=;
        b=V3w9ooz5HwElJCpWUHKExuSdn10/EdPyobmnM1cIqoABztAloxKqeiWgLi9MzkjlCi
         /vT5AeXb+nKDYDWMrXoLqlp2BY+WurrwYFmH4LxClh/yyZZrzJmXPF9RQEdrXqFcJG3V
         N7jkHZIas5pBwV0S52o+H7MLnBEZVBMdeamoL6O+ns2HYMMsHY0jHDVNdSURfx9tEW3n
         dpVAKg5Y/wPHM1hru8xR85QZFarh9LkUvgG2C3hXmUZB1HqD8DCj3ib01mu/bJUjVwID
         SLVkdLrUt1BzBpdLlXUZmxxD1h6fqwVoQ236xFRKgoEqS8apBN2iU5X4ZRfdikkm1zOJ
         uOyg==
X-Gm-Message-State: ACgBeo0blfcwWRDFEbry1rspRfX2D/SbEM21ifTBeOvZ+uMRjFfE5Ale
        7fqPqT4akf5iUwMFD2gpdf9p4uTBSHlaIcIX3xE=
X-Google-Smtp-Source: AA6agR7HVOc5FK5HTldMrCCFX9WMva6nfdRdzVRJsrhLyFgBQeY9eTRt1ymSykmAVkSDyjFsWQ7viMpc+7nWOkgs8uI=
X-Received: by 2002:a81:ae5f:0:b0:33d:c00a:8c93 with SMTP id
 g31-20020a81ae5f000000b0033dc00a8c93mr30956775ywk.376.1662167338300; Fri, 02
 Sep 2022 18:08:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0d:d542:0:0:0:0:0 with HTTP; Fri, 2 Sep 2022 18:08:57 -0700 (PDT)
Reply-To: mr.alabbashadi@gmail.com
From:   Mr Abbas Hadi <genbellalogan21@gmail.com>
Date:   Fri, 2 Sep 2022 18:08:57 -0700
Message-ID: <CAPEfYkEEr4KjgGyssKZrkqO_hQm-SLS3Vsifvp3fS9C-Wrb_4Q@mail.gmail.com>
Subject: Greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1129 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [genbellalogan21[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [genbellalogan21[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

-- 



Good Day,

I am Mr. Abbas Hadi, the manager with BOA i contact you for a deal
relating to the funds which are in my position I shall furnish
you with more detail once your response.

Regards,
Mr. Abbas Hadi
