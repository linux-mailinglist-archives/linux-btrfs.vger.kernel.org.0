Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1743627917
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Nov 2022 10:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236608AbiKNJgi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Nov 2022 04:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236471AbiKNJgg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Nov 2022 04:36:36 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D969C19C21
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Nov 2022 01:36:35 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id 63so7702719iov.8
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Nov 2022 01:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g8fJutcykUn2980aY4WhA2pfqO7yiH5/1zqgG8RpeBo=;
        b=IE6frINZH04wSHEbXIOqRqBB/zlPosuk4CHZh/4zUJYARhktNWc07HtUsL9gwfcp8e
         naXbwJ1e/LPiU81mLk/UYOCIJwDu2YETq4N4RXaFt1t636IzkdO+Is6Svrv7loZqBgDM
         XlliEmAk5AuHUj8t+uOFKSusT7eB0y3B02eK5eFfvEUNT1LS7oqwKHJDsGDsiwlHfbQW
         tyqbBsPHmPaaUGZQCyaxg8oGJgGcbI9sWXXYgN/7Wwv3qQKwSB7U9JR7j4x3ncrpa1Zn
         qp1/Vdp945VliF4wOWMEQg4sCNZK1AN9pMkbS7k1KTvzgGCuyaJxzltfISi1aMxl5tfw
         Vuig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g8fJutcykUn2980aY4WhA2pfqO7yiH5/1zqgG8RpeBo=;
        b=YiT1NzQLA7huILbtcEYKAEjsNTYQcIbRC2p1o3g2Zwa1qU94A3x3zZaa1QoPN8P2oh
         X7tStGZQKmk9D5ogMtX2MFW1jmE7INUxC76EJVOUA5Wnwb56BIR8YPHjXHvFdIKV3stj
         FoYnjGNKULQrK2SbVcdEw/PT05W50JkQdaJRV8eS2yEUv+lQTtfXTXayqfHr0H4W78I9
         SxfJQ1zOaoNpQ6cS0Vv+VS36UNU8gqjAsEzDaWNH0KCy+xr/WwIhydCpo+k5tqTupfWc
         qvM3xiA08nFvpiNjvlFp4P8zkUkDHlyjIvZCOGbHSegtlbLlrbx/mdMkeoc9cuxERj6K
         ayHw==
X-Gm-Message-State: ANoB5pnNDArip3XW9f6fqElnMrCbgd/JvZz5Ox6o2EiVFTkkjvF6pvjV
        WLJINB8JxCSdt9GHDHOMbQrB9Rm2FDkNADMsjP0=
X-Google-Smtp-Source: AA0mqf5prhf1IBQXdVjC1gavc7/Hdp+1WFKIl8pj+ccHT5VLGM2LVnBbRXf8ExnUX6DyYdA5TPGelSaJ10ZsmPKpvMs=
X-Received: by 2002:a02:9092:0:b0:375:ae19:858e with SMTP id
 x18-20020a029092000000b00375ae19858emr5283409jaf.289.1668418593828; Mon, 14
 Nov 2022 01:36:33 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6638:138c:0:0:0:0 with HTTP; Mon, 14 Nov 2022 01:36:33
 -0800 (PST)
Reply-To: wijh555@gmail.com
From:   Latifah Adamaou <adamaou882@gmail.com>
Date:   Mon, 14 Nov 2022 01:36:33 -0800
Message-ID: <CAFDHBsvUedVbJDeHzDL_GsE+S_33Ke_KXOALSy74XF7TeyX6oQ@mail.gmail.com>
Subject: Very Urgent,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:d32 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.6126]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [wijh555[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [adamaou882[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [adamaou882[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

-- 
Greetings,
We are privileged and delighted to reach you via email" And we are
urgently waiting to hear from you. and again your number is not
connecting.

Thanks,
Mrs. Latifah Adamaou,
