Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF986A1B85
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Feb 2023 12:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjBXLjo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Feb 2023 06:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjBXLjn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Feb 2023 06:39:43 -0500
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A3765332
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Feb 2023 03:39:21 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-17264e9b575so10139915fac.9
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Feb 2023 03:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPj4O5f6au3nQvNTL1r4uZdub8bbiKBzA+RDnwzOP9Y=;
        b=Kx/nN/gTls44dSTb92OwYyP4952bIho8xr7Ns9yquWy80YSa3hOuWV9lXJxIyXDW/R
         TBz7Oxfum3SA/9rod1B0xM/hFqdv81hZwnVOC+Mi3nbtwfGZ5BREKpd5qsbZQl6Tq0B6
         WsynfGysXbzORH41u5tK01QHKU4Yx5XyWg/0wopyEL0u+vmrNOcNEkIAMyPfTmMeHzhr
         pNUAnWr1/Dz3RIQOpxotLlHK6i92MB/Fii689RShqmD/KuGnzobBMKUOgAJQXIPVGGWv
         59jfle/Mn27+htl/cv7jfB2EPHy1OmZUCtSzeHP45JUZUGoCxI+j1ZOYCSAdP/ai8x8S
         3MxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qPj4O5f6au3nQvNTL1r4uZdub8bbiKBzA+RDnwzOP9Y=;
        b=beqvGvMb14rqRxB4+lbqfuaPwavQVY05HCr82r3EEv0sd675PSTZ5b0seCIRQgOlMZ
         sTbZ4PcS30eP2Mu3tDJHUZq2+GgT4rNXJPC4yMv8+wyqyyxMy/ufrzYPMtB3Grmj4XWY
         3mkQxXqgJoYi6as2RsjkeWrz8xWnccSkdT8QCOkkOmHmeU10VYzl/+u0OHCtaQKiOd9o
         uNGB3JMN8DxS4jlCBwYcmE13PF8yCoNy3yAKdrUFtxHYhjkZ8kT2I0JR2ekOi4Rwa96x
         3GwNOU+yBIGPC46IAV7nU6+r1RxtGWarloOucJkE/A64ueofZGrfGhCB1Y29T8cEX3iG
         BCcQ==
X-Gm-Message-State: AO0yUKXKVg9veSw5Ka818PsnpUIPIl8p6QVrr4t9Qk/dvdBIEnxumXxX
        rlEocz/+ZcGU28mqQ+qsWg99SCsHNGiXyVlPtWk=
X-Google-Smtp-Source: AK7set8TNYwE2kH6gHpZhRUqPGEUIvKakHc4ePRh6ivWGajKJjXYfBOxV+82MtT4g3nmhMyC0GJUid16XhtvS2ixP+s=
X-Received: by 2002:a05:6871:6a96:b0:169:cbd1:d289 with SMTP id
 zf22-20020a0568716a9600b00169cbd1d289mr779032oab.2.1677238760617; Fri, 24 Feb
 2023 03:39:20 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6359:4815:b0:f4:3ed6:bc54 with HTTP; Fri, 24 Feb 2023
 03:39:20 -0800 (PST)
Reply-To: fionahill.usa@outlook.com
From:   Fiona Hill <danyo.victoire@gmail.com>
Date:   Fri, 24 Feb 2023 03:39:20 -0800
Message-ID: <CAMEwQAx-fxQwZCxVHQ0z7++g2=o_3DVpz5O_H=NoAkrr-Gce9A@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:36 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.7618]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [danyo.victoire[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

-- 
Hello did you receive message i sent you?
