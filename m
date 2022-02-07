Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57AAA4ABF56
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Feb 2022 14:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383779AbiBGM6P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Feb 2022 07:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442693AbiBGMzP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Feb 2022 07:55:15 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789DDC0401C0
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Feb 2022 04:55:12 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id z19so26563976lfq.13
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Feb 2022 04:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=+zB79ok8+scrzrgYKxLKHdTPGXHaNMs4/kAV8iB60HM=;
        b=Ls8SEqK0c5NiJAhO44BAIz23+e/3nbYZ02VnkH7mNS2HNVw3oDZU9Vp9JYIYpRsRkW
         /vuNfSrvHcE2BVXBFGRHd8gVLDSdv63HcEy/sA3dF84afTwLIwuMhNKBeI8YNtoj4tvE
         ZloSfKI8tniDWFRjv8iflLRO4RSv9EAviP2rDF9pfgSba1+qnqf1MjvDpRqFSXhU+6Dx
         L+2DX3KrdSKDKd+qnd5h0qAOBsmZxzSvmnT1udBTbpvQzF0TxagyomL15iDHxXiAhrfv
         cIeFEXAioZGCKcM7syHdhKvd4kjljlTc0eg5gjOxlksTGQ578JlNkq4RTzSLGLFSoydd
         6kKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=+zB79ok8+scrzrgYKxLKHdTPGXHaNMs4/kAV8iB60HM=;
        b=ngaIaku7cfLd7AAcwuk2RniAbEYbfhKHvBkcmNqHyVcGA5Mz6fMaRIZMYVViyhLPYL
         wZsN7WzgrGenrO66Yt3ZswxuTOSSgZT25vHAnQUMCtTsE0bVAgkeH6ftb1NcZZPwwp5c
         pIZMoNfnzkkFAjJDUf/4IXfmlRp4yoRfF1R76wdJg2NPQxWwurcNr+a7MrVkd0lVMWV4
         gKO4mWJzX9bA3HYU2sdW2JnOzGTOcRsCKG/T1lS0Be3LNL3XSZOhieLtmeQ2j1CN9ibw
         iKpjTgWi+Vsfm1Pcaotg15NbAAJnaw/XtuiQ5iazf0us1EKtL51fZ3x9ti2exvdDwcO3
         wiQQ==
X-Gm-Message-State: AOAM533oPprDQIh2v1nUzzfqiMpDNWuP9Sczi/gDkKJPnAe6Uxqd/uQg
        tydoSuO2JuXZE0utLUL2DO2/XGAcDg2a+K9Zo2A=
X-Google-Smtp-Source: ABdhPJxrTjk5sK7v7NECMxKrdB5/t8FBSNikYM7xLKPhDrSiKRaPOfNjkYHXu7gYZV5kYCH63+7VMvKaoD5sq7u5eJM=
X-Received: by 2002:a05:6512:3991:: with SMTP id j17mr8247958lfu.391.1644238510181;
 Mon, 07 Feb 2022 04:55:10 -0800 (PST)
MIME-Version: 1.0
Reply-To: avas58158@gmail.com
Sender: kingevido56@gmail.com
Received: by 2002:a05:6512:3b98:0:0:0:0 with HTTP; Mon, 7 Feb 2022 04:55:09
 -0800 (PST)
From:   Ava Smith <avas58158@gmail.com>
Date:   Mon, 7 Feb 2022 04:55:09 -0800
X-Google-Sender-Auth: s9QlXpTVIA4oWyRCX37InPHKtSQ
Message-ID: <CAH+=8uQwmXxUytW-PjoAUw3RfspZW-jX9j2E=rVohPRmmg1ejg@mail.gmail.com>
Subject: From Ava
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Dear,

My name is Ava Smith from United States. I am a French and American
national (dual) living in the U.S and sometimes in the U.K for the
Purpose of Work. I hope you consider my friend request and consider me
Worthy to be your friend. I will share some of my pics and more
details about myself when i get your response.

Thanks

Ava Smith
