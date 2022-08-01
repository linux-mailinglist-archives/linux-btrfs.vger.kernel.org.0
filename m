Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12425872B2
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Aug 2022 23:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbiHAVAC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Aug 2022 17:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbiHAU76 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 1 Aug 2022 16:59:58 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E272715F
        for <linux-btrfs@vger.kernel.org>; Mon,  1 Aug 2022 13:59:57 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id r21so9014282qtn.11
        for <linux-btrfs@vger.kernel.org>; Mon, 01 Aug 2022 13:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=iLb8ugeaf3dbpDh9pOJVGSMieKWvANPBP/SCH9cR+Sw=;
        b=dDiHXaOe+QG91YrTiT+3oIdfqihTqPfA0t6A5CieYPO2HOGvplKHFU0e+wn3BdaheF
         My2uJzHRHdAekD9rVjVFHnu3hNwPe3WSVj+wbJY9MVMCeSIunD/py/Q1pj8MrIplAV6S
         rSB6TeaWIzF4o/tUCyYxyYoB8qhqNZb6yeWLPS/2VjXPQ/ddTg8Kjh2O8EsTfUD9ZGYU
         xo4ulD7LLlXvCB5+7Nm6jElguP86ZYEPpfhsmht1T0tsGpBaC0GV0pZ/EPuiMgc068a4
         Y6xJlqJaMCKUQQ/OTGFiXxkx32AovjXDQXhTh5sXWs+NzdxXdix11Ncoej996TpUPcF2
         wDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=iLb8ugeaf3dbpDh9pOJVGSMieKWvANPBP/SCH9cR+Sw=;
        b=JIdItyftN8zq58+gxAHM6UlNBeTpIBS+QiI0l0x4W40wzZHkSVc9wxt9WjgVTWQuQk
         1D7fcWe4Wxwhgdp6YjCjxqEhaCT5tsfO3dm9LJROMnbK8kd+aN79sypL66lMN9Ov35OH
         Tb2EzPUS+dLZyUXoaK7/EB82EUJ5maQCUSeUj2KRmU8SG9X0/6zyhyyCSRNyLE/bleD5
         bBpuR3tMNgzGojEU8663dVUnvrsOYvPbnCVqKyZU2J8LKrZSeJ1YoVwa4ieALn1S1cSq
         v/Z4flf7obMLI+FjEqRV2sDDDL0qm4XUw8V58TwmQLzvD1bQCFnShzsgBLa2o5xn7z+z
         5Ghg==
X-Gm-Message-State: AJIora9vRI4QRnWuCbNXi6JwGQhBHmGJ6cBbYLpa5wHLXHS95mDI7w2D
        t52T0yCK5d0DVH27X2ZMD+LYpbjg2qOOAphfGLk=
X-Google-Smtp-Source: AGRyM1u1DYHC7rB691jDfV7jPyiCPaQpdf1ku1HpjMB4eqMzYXmppvewEAP5W5IFpdJCXrsd8pQ76yaWTexdLRu7u0w=
X-Received: by 2002:ac8:5913:0:b0:31f:1541:6b8a with SMTP id
 19-20020ac85913000000b0031f15416b8amr16094899qty.231.1659387595844; Mon, 01
 Aug 2022 13:59:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6214:238d:0:0:0:0 with HTTP; Mon, 1 Aug 2022 13:59:55
 -0700 (PDT)
Reply-To: te463602@gmail.com
From:   "Mr. Jibri loubda" <gjibriloubda@gmail.com>
Date:   Mon, 1 Aug 2022 13:59:55 -0700
Message-ID: <CAO=FyH+GZOqOk63=5vUvvZE95WxADQV=mm7TCJrTKXLxD=wZUg@mail.gmail.com>
Subject: Greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

-- 
Hello,
We the Board Directors believe you are in good health, doing great and
with the hope that this mail will meet you in good condition, We are
privileged and delighted to reach you via email" And we are urgently
waiting to hear from you. and again your number is not connecting.

My regards,
Dr. Jibri loubda.

Sincerely,
Prof. Chin Guang
