Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42B258BCF7
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Aug 2022 23:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiHGVIV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 7 Aug 2022 17:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiHGVIU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 7 Aug 2022 17:08:20 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D708D65B0
        for <linux-btrfs@vger.kernel.org>; Sun,  7 Aug 2022 14:08:19 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id d8so664502qkk.1
        for <linux-btrfs@vger.kernel.org>; Sun, 07 Aug 2022 14:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=2ER2WW01ET2wH1WV2jGlyhputEhjwKA2tNpxchjmONE=;
        b=fY+RZ4V1S7k862vBR+aT4RK6X/12mX726kgcd1hWE9hiFbMGl9WwSjjd7J4viW41ld
         XS4CIJTHDIvctnKBkg0y8b92REDjKJ+zDHHa7b5KZvfC9lSr1aR0CdjZHM0Jdlsh9UUM
         8bTsQZ4whXy3aYuY/MhbQ3VHuuKMxeHc5n5nUP9MAI7ZzaI2GlbhbaSNn9BviD9J1Aji
         mGeD/3p+EseJUiXw5bmn0WDH5joiU0s4rkKSv8IEjex5AVFbrojv3gd0jjEYABrtXrIq
         mTDK5a792uot3rWz2iHGx86zda77MqPpp11iRvcduBhq1dDU9uBpgzTODAvuGCOZXgcE
         8lTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=2ER2WW01ET2wH1WV2jGlyhputEhjwKA2tNpxchjmONE=;
        b=vnceGD0JplBFGcbY1uqSLk5WyZJF1QPK+2sHAmILs22qLrRWeHomqTYo2tQdWcNs7m
         p1/fZ2JQmUn7Wynafb4i9sisPbjU65ZPRbN+MXSrnmsFCYfesAwC/updS6gliTqT1MwH
         dty+3WM/+hF/A8OeUbVbhANvxxUTebEtmMgKtFIDCOFGbJOYacKJHhOVFW4m5QIkm/Tr
         1SvD2bbobNsSuBuy4ml3GrB1KLtstLuJRXMAOPmtAJTj4c0qquQoPDjeEpCdHKB7oLKJ
         0oOwKY5Vxq5+yfNhkdek1MWHsIR5Zvkis4nd5fn+UrBTK7ZGQbPNKhd50+qqwOokGHji
         9UPQ==
X-Gm-Message-State: ACgBeo188qSObDpcQ7dcy1NzmuLzlB8Fu9jPKLtp0/1DTkyG3CnMA3Jb
        ezKUNUrY3FNt1pKAgb1VoBMQLLXGO3Mtr09FAoc=
X-Google-Smtp-Source: AA6agR5X4cPDKGWxqE9XKVk/gtFj7u8J7i51tV13GJK7c/I7oGCntS3L2VY/wzZixVa7V8b3dJx1ymp0guxX3Io0XIU=
X-Received: by 2002:a05:620a:2b87:b0:6b8:df20:326c with SMTP id
 dz7-20020a05620a2b8700b006b8df20326cmr12281031qkb.106.1659906499017; Sun, 07
 Aug 2022 14:08:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ad4:5e8b:0:0:0:0:0 with HTTP; Sun, 7 Aug 2022 14:08:18 -0700 (PDT)
Reply-To: drlisa985@gmail.com
From:   Lisa <mrharryjohnson105@gmail.com>
Date:   Sun, 7 Aug 2022 23:08:18 +0200
Message-ID: <CANKn9d2USziAKghmmB6Q6_WOtnJrYmAMkJU_3dpXcaU8rHUVEQ@mail.gmail.com>
Subject: With Love
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5030]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mrharryjohnson105[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrharryjohnson105[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [drlisa985[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:729 listed in]
        [list.dnswl.org]
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Dear,

My name is Dr Lisa Williams from the United States.I am a French and
American nationality (dual) living in the U.S and sometimes in France
for Work Purpose.

I hope you consider my friend request. I will share some of my pics
and more details about myself when I get your response.

Thanks
With love
Lisa
