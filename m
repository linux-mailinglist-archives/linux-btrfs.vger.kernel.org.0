Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6540A5A0D99
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Aug 2022 12:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240765AbiHYKMy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Aug 2022 06:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241142AbiHYKMW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Aug 2022 06:12:22 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234EEABF1F
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Aug 2022 03:12:12 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id s199so22656722oie.3
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Aug 2022 03:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=NcQgfGWmNtGVcmYOkqhvmNWuEth66CXwSKmPdJfqqgM=;
        b=ce6mU4x+YKWr+I3dmJ6qs8b7txF7JFeSiCOMd9Z1F+NAk0bxtgf+8ENG3cwlQ//5us
         aZWwi1vKhphQ319fiB3ftaEa+ZycqQMC/hh6xV7eph77LepNHrAGj7/EfX28SPl3rGH+
         E1/utMP6wJq2Gw0smCq3cs/00YWGCkFM40HCqesHpRpdC/+CQqwqBNXBwamF95lejFxF
         HvWvXUkp8yvkrbBg3K4B7TemfujM+Px2j+TwvyImOr5aj39Qi3blVy4ctFqhrNCEuHX3
         bVWqArZr913KOypxlL8LM1bT8FtTonXd2DlsVowLWaXTsP/n7nD6bG1tveN/y4NeZ7+W
         lUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=NcQgfGWmNtGVcmYOkqhvmNWuEth66CXwSKmPdJfqqgM=;
        b=5dEXfOq9Tf1FTr83OtpeQmaDfQUNYOQ1F/D5mBvXwUq+KiJ8TGUeYqQi/RfTb1RzKh
         ZiCdvJMzZysLl02h9qgrtL08i4isX5uj1x+HQWDffAGU0Z90wsUM9QXVPG4yc14snW0C
         Rjm9NdjiE9omrjZ7AekxGWhQMszQA/h0AcQv62dxyp/YJ7iuAImcUikBhBS7zTcHUSph
         CMfrCZAbD0FVXmU2V9dbAUJludWFpMdLwmWZ7H5bi21eadmG0yCkGZHIjGvSpOtzYJO5
         uHV0uNs4VZ7nPm9unDB16UqqoxgfoqEDtx7aIQ8RD8AUQODQs2+zJl2uEPaxAv+jMyTj
         KYZA==
X-Gm-Message-State: ACgBeo2kvABiH77RDcyC67mswtdeVB0AEiakvmeDTHHlprvNAhx+Rdqb
        bs+9lHd1fZBR21WzvY0y72YvlNE/10aiwXQprCw=
X-Google-Smtp-Source: AA6agR4CHC0ZRoaO1QddY3viXtx90ftRPV6mfheZ4AOS3O5l6t5W4phNYRJG7SutyLNR70thS0p3Kq3svwSxslnHmmY=
X-Received: by 2002:a05:6808:1988:b0:343:49cb:619e with SMTP id
 bj8-20020a056808198800b0034349cb619emr1409820oib.184.1661422331586; Thu, 25
 Aug 2022 03:12:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:5ec3:0:0:0:0:0 with HTTP; Thu, 25 Aug 2022 03:12:11
 -0700 (PDT)
Reply-To: sgtkaylla202@gmail.com
From:   kayla manthey <tadjokes@gmail.com>
Date:   Thu, 25 Aug 2022 10:12:11 +0000
Message-ID: <CAHi6=KasihLAJ6uKfYQ-nCT-qYNr410HYy7WXSb_D=5x4fqUmw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:22b listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4997]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [tadjokes[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [sgtkaylla202[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
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

Bok draga, mogu li razgovarati s tobom, molim te?
