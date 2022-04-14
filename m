Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649DC501A73
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Apr 2022 19:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343838AbiDNRww (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Apr 2022 13:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343812AbiDNRwu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Apr 2022 13:52:50 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29B8E9976
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Apr 2022 10:50:24 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id t25so10392540lfg.7
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Apr 2022 10:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=DEbyqe5T1fF6VgFja/FH+cT3MjyU6Qe5ms7Et35C47I=;
        b=enRFJPN2ry3oLW9Nu5JotbGGsHR7ByeR1DibeBcVvutB5c5vKiYOunirRxVMIU6gSP
         8VzrpgJ4KulhydUE1oyN9Kg2vpoufZ90jQ6sdPbZ3YRiC2uaSo5o2bFMGcI/DEOSoyfm
         udgRJWxheBJznlvkIj0zcpZ/xiHnHKIMx8nAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=DEbyqe5T1fF6VgFja/FH+cT3MjyU6Qe5ms7Et35C47I=;
        b=hpj0j8ZqHvIi/zSbnO/1XUaqZTqXxpAEnl9XPx97BfOGNFM0bmUF9t4O6G6kZjNHzo
         6SkHOnSS8Di/eh2FijQDUKDqxFMYheetwkzi1lWhRystFI2fi1Kl4kVIGks090BvPM7R
         Kg4jlQv0uDsJpiT8/VWTrMmxy8xjEsPqb3FQrsjrse98KqeKgnbkqVyMunHfFyOp2eQt
         BHtRsZUiwr4Oravh2jxHarpCJgHyVTm45zdJglOXKdPNmchu57qvWJcaJyYiMxdUEH24
         /4booTY8ozmx79xVAMnyg3nOu1NGRuHFe0HnYBiyjYOu1erAhwgOLCAeR7CQSu7bHaUH
         G5CQ==
X-Gm-Message-State: AOAM533a9h90V40gQ70cxwUI6aIIM05VocwQH1bBFZ/Ux4OlwJbW13Ru
        /XITzFJgZRJhcW6IoFEYnE+SMASt1aQNVfI9
X-Google-Smtp-Source: ABdhPJysLT1U0UXn/w5Wh93+lsBZekoFf+tcDgU0pfecfQ0kzGhhDr8+JUM/lVBmy3mRRnCEM8vIzg==
X-Received: by 2002:a05:6512:1516:b0:448:39b8:d603 with SMTP id bq22-20020a056512151600b0044839b8d603mr2517238lfb.599.1649958622674;
        Thu, 14 Apr 2022 10:50:22 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id f20-20020a056512229400b0044a6ac1af69sm60416lfu.181.2022.04.14.10.50.20
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 10:50:20 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id w19so10364553lfu.11
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Apr 2022 10:50:20 -0700 (PDT)
X-Received: by 2002:a05:6512:3c93:b0:44b:4ba:c334 with SMTP id
 h19-20020a0565123c9300b0044b04bac334mr2598700lfv.27.1649958619851; Thu, 14
 Apr 2022 10:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1649705056.git.dsterba@suse.com> <20220414143729.GP3658@twin.jikos.cz>
In-Reply-To: <20220414143729.GP3658@twin.jikos.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 14 Apr 2022 10:50:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg5m1uDfeGQ=rRA7Kvz=hQe4p3jVKcXc40-zBKqwTiU0g@mail.gmail.com>
Message-ID: <CAHk-=wg5m1uDfeGQ=rRA7Kvz=hQe4p3jVKcXc40-zBKqwTiU0g@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs fixes for 5.18-rc3
To:     dave@jikos.cz, David Sterba <dsterba@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 14, 2022 at 7:37 AM David Sterba <dave@jikos.cz> wrote:
>
> I'm sending this from a different mail address after 2 days of no reply
> and no merge of the btrfs updates (message body deleted in case it
> triggers the spam filter). The mail is in lore archives at
> https://lore.kernel.org/all/cover.1649705056.git.dsterba@suse.com/

Indeed, I don't see that email in my inbox, and I must have apparently
missed it and deleted it from spam too.

gmail *really* hates email from suse.cz these days, I had multiple
emails from Vlastimil about the page pinning series go into the spam
folder too.

I've explicitly added you as a contact in the hopes that it will help.

Thanks for re-sending,

             Linus
