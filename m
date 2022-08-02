Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C85587A5B
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Aug 2022 12:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236512AbiHBKJn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Aug 2022 06:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236493AbiHBKJm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Aug 2022 06:09:42 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D44731382
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Aug 2022 03:09:41 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id h19so4590946ual.8
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Aug 2022 03:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=edeevZ54MxyNr2ONaDsC9jI+UtdZjrCL/LCuSFC70Ao=;
        b=EQu4zXZcA4glur7Clyuvxu7+dbJHeqbn2g6nl8RSzHKy6hRhY/Jy6hkfthXwTEDXcB
         ZIxjxmekyp8ZkH8C8BKe4a5g1qfu1KRoEgVGZB6zfjNhJVNOLGWBZe+kqSmO3EB6W2il
         AkWTM3o2gTYPQ7uudXICA6pAxFR4sYDPDq+sD3x5j14WZ9a9NI4+V8gKLfGrYBFI5uxi
         0lURGGGDsjzuda/dL+TJLXLVjtodMdqWPNW2vPXw1n7jEFWja46XDwFREWmtEHrY+bxw
         f8CyRe1G2HwACt8zXlxr9EJQLq3DlckbszNHxb+VOMNCHUxxrwT0v0R/YcI6wzCgzAJA
         YPHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=edeevZ54MxyNr2ONaDsC9jI+UtdZjrCL/LCuSFC70Ao=;
        b=0G5ymWflx+YgzmHETZ27QlHBkWjXd3iJ/AB4eouQx27BSGQopi2+2hy6WDU5JuISkr
         WKQNY//T20DmA/t2npRLFeaiA4YpYd6NcaAHVwkN4qx/gVoefc8FX5wP5nJCD+GKXZsa
         zM1uPDO+q/Z0SlxUxPvbXXjVWigN38XCZjU0yEiWNrUIExtphBCij35cAhalDxk85vDG
         uRkbTEOLDEUYlEOdFhrbGr6OQu+cfSSPUPfOewI46KC9lR4oRJZB8Pr9B5/9Lm7niZZa
         3FUctr3cMtzWCwFRrgNxICKZ1zJJeBWqfWH3qzXA/nu1dX/bxx/vfj8S4ny38nbfTmzd
         Jn0g==
X-Gm-Message-State: ACgBeo2+g2Bt7SJckEwv99FmisYyyV2jkUJDgONOj+Q1CZ3ksdRGYFcG
        S9uz5cuhaVWLPjeqo6j83BpB61WRIrg4Q1137Zg=
X-Google-Smtp-Source: AA6agR7AznDPBx+Dy0qnLzjcy/L7CRHsqmICY0r9j/mJIOFYr6Z1w+N8VTlA3k53Tg6p+iqrVgOFv2RK1UTz0RCWzOA=
X-Received: by 2002:ab0:278f:0:b0:387:7d2a:28f6 with SMTP id
 t15-20020ab0278f000000b003877d2a28f6mr535944uap.115.1659434980029; Tue, 02
 Aug 2022 03:09:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:beda:0:b0:2cd:f4a8:c08d with HTTP; Tue, 2 Aug 2022
 03:09:39 -0700 (PDT)
Reply-To: mohammedsaeedms934@gmail.com
From:   Mohammed Saeed <bienevidaherminiia@gmail.com>
Date:   Tue, 2 Aug 2022 03:09:39 -0700
Message-ID: <CAHyTKtiKTPxGMg8z_xa4EMQHysE7sBA7u2pxoG9gLBM4wG--tQ@mail.gmail.com>
Subject: Proposal
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.1 required=5.0 tests=BAYES_80,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:944 listed in]
        [list.dnswl.org]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.8745]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [bienevidaherminiia[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mohammedsaeedms934[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Salam alaikum,

I am the investment officer of UAE based investment company who are
ready to fund projects outside UAE, in the form of debt finance. We
grant loan to both Corporate and private entities at a low interest
rate of 2% ROI per annum. The terms are very flexible and
interesting.Kindly revert back if you have projects that needs funding
for further discussion and negotiation.

Thanks

investment officer
