Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0024454BF62
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jun 2022 03:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241020AbiFOBoe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jun 2022 21:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbiFOBoc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jun 2022 21:44:32 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E0331227
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 18:44:31 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id h7so7832852ila.10
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 18:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5T0jkmVCOogGKLQtZpWkIgM4TNd4EnqtW+WXWmZ1g6Y=;
        b=XO5ndbX6g7slCTtSLpU7LsgvNExUf6KEhDSh2IdcZikLXPF/glExn9mtJl3HCcrncA
         sMbPsLDGuoIZlB0rFtC7XRKoW2jjzCgjORtzMNZzLKxFk825YWCZUtXU4OVnTYxtbtGv
         8OKlI3AFCeoesQoDS6LYhwsBFMYxFEZ2/qI4j96/6sesrlJCNmDsrcoNrs7F+qGBjYI1
         0Vq5cXqyd72YJO5GY27s2gcV011Ht2qKPXOm3RlK9IT3m5ZIJJvBBOGHFN4pO78medeT
         UQjILEa8vd/DFKJkMDONiiraQDv/uWvMc5BpFGSqRKqBhA154JZfAiHq8tKYW/cF9xzj
         cMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5T0jkmVCOogGKLQtZpWkIgM4TNd4EnqtW+WXWmZ1g6Y=;
        b=SfXgeL3mXbXUNCw53T6HYxaiQxwOb0plqiy8d2nJTAP98AZ8X/dVGLMzSeG2PHm+2G
         mw93QAHJ5lhUslquCzvDFAkd/9uc5oTyxIA1MM3JJYMIzRnO03G2Mf8C0Izp8VM6GPgl
         41Li4UyAtgxO1CLI7yXyF101kzpRcJqZVVlQLTTUvXh1ZwgnpBD/cSDi3r6uddK4ZMua
         W2qdv0bsBY3g8C6BqsX30YdJIB78u6VJ5Ndp2XECTP4htVNkvHfqZ6vSILQScrxxBxF/
         DKpKb9+xXgyFEVw9CO0O0QFAe+nui+zD8WGHY0B0F2PLBFP1/pWGbaT8c8YhC9/gxCom
         kqOA==
X-Gm-Message-State: AJIora+DNaVnq5avQna4ME3xX4CPBh8lLjGiK8n0GIiIacmVHFDo6hR0
        Kiauy5vW46Z7zoq2X0GWIXAFo8rrm3UHA8DKfPN5uOCX+NyMFw==
X-Google-Smtp-Source: AGRyM1tmRJ+SL63mbdeZzthMBANCgOEoYBdGkDWkecTkSDRK5ShRipvtRUbgY7aZf8X6jR4xF0ZA4MSQeXQChCtM2Kg=
X-Received: by 2002:a92:ca49:0:b0:2d3:9e94:1af8 with SMTP id
 q9-20020a92ca49000000b002d39e941af8mr4586452ilo.127.1655257470547; Tue, 14
 Jun 2022 18:44:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220609030128.GJ22722@merlins.org> <CAEzrpqfy-sf_xGMohK1EVgtP58tLTso6e7s9iyd3t5XnM3zjCg@mail.gmail.com>
 <20220609211511.GW1745079@merlins.org> <CAEzrpqfhUMDjkaJaa4ZugSuKOWpLyTVJ8nLu9nep5n_qzo-PiA@mail.gmail.com>
 <20220610191156.GB1664812@merlins.org> <CAEzrpqfEj3c5wodYzibBXg34NxtXmQCB60=MtD+Nic2PN8i5bQ@mail.gmail.com>
 <20220613175651.GM1664812@merlins.org> <CAEzrpqdrRJGKPe8C1VvbyPaV3iEDtD1kB_oMiUP=bCs37NfSZw@mail.gmail.com>
 <20220613204647.GO22722@merlins.org> <CAEzrpqdRiG9_O=JTy2LOtp4m470hMj1Ev-bk6RE_ArdRKauLGQ@mail.gmail.com>
 <20220613235242.GR1664812@merlins.org>
In-Reply-To: <20220613235242.GR1664812@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Tue, 14 Jun 2022 21:44:19 -0400
Message-ID: <CAEzrpqc7rHHp_D0wO7rRPnCcfJ4TBtVbyCSxzvyOOyA33UpRRA@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 13, 2022 at 7:52 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Mon, Jun 13, 2022 at 06:19:05PM -0400, Josef Bacik wrote:
> > Hmm that's not good, I've pushed a patch to see if what I think is
> > happening is actually happening.  Thanks,
>
> Same?
>

Sorry Marc, saw this while putting kids to bed and immediately forgot
it.  I think I've spotted the problem, you should be good now.
Thanks,

Josef
