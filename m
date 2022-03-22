Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA83D4E3DA4
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Mar 2022 12:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbiCVLdI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Mar 2022 07:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbiCVLc6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Mar 2022 07:32:58 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6787B82D2C
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 04:31:30 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id mp6-20020a17090b190600b001c6841b8a52so2297079pjb.5
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 04:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=pbCVlee58SNRljTVR7wTvz7D3A0MvcLCtUjVncuzsEg=;
        b=JnbCtVCr8rwG1iwI0TisWfNmnyw/duGShLjbtmHwpxk5HEbwuqb33hU3zb5RsFJt+0
         Y3Erv0udyVAqIOSgVpCQj2JrT4vS+QivCAAhqGUXSw7cykOX/pMh77oq4NBhYLRWKNvM
         RdDn4+wotCG+DYSFrl0eyTvymgDBAPRCzW8piVAek1VF+jtwp6GU8iVLyg1EP681VRwr
         o7qh70FeKBc1YkK6vNnLe786kZBBld7+g2bq1wGhrM/0aWIY6ureQc2Ww+v3rJKT+tXc
         9yBUOZ65IsILwukdaLatsT6xE3QomWtgxXh3L9P6sxr+1fjRIcXNbKesBbc425HBPOKV
         wL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=pbCVlee58SNRljTVR7wTvz7D3A0MvcLCtUjVncuzsEg=;
        b=6bmaVep+zljBdMrzVeSnQpKlU10WoMcsDRQDnc0iXovfYId/5ABr3GAHnOmm0fB6pR
         XtVXQGu/LdXOtMhLoJSC0H1bzNET2jSV6vV7BBu37OGV9mPXCe2+XXDnMG4l5Mn1Viv+
         4U3u2XFaBWyLAF28ppho7XJF+2Kg3zMOSw8NgGBcgl5BlV7ZngXWUTifCsv16Xni9ams
         EY8FWgYq5L8I/lpU9dbBFyw0HhvD3EtZcDNrkTDKoszAMTNzJVo+q7DyaPCBSdpag8PT
         On6BMWicseTmSlpPHYSDhtfG0QgvmXhAQqxyfAJ4N13yRPc7zIDUnH8CTUiN8R/b7szc
         Ld5Q==
X-Gm-Message-State: AOAM531O7XvGZmYHL2wvABMW3VMug4XUbJ3OaEi+Zhn/q8wBCdc4vpkd
        o8fWQ8x3KynfNNTx2hP2tAoS6ka3GMz9PB1hPBQ=
X-Google-Smtp-Source: ABdhPJwtrlWX814b40251cQfeAmXYOWIbADRYufUkJvGdUNVwyaXOXy2XL7UTolwAZsqCEypYfucF/vKf1M03fLw/vo=
X-Received: by 2002:a17:902:ecc6:b0:154:31a3:e036 with SMTP id
 a6-20020a170902ecc600b0015431a3e036mr15395257plh.154.1647948689721; Tue, 22
 Mar 2022 04:31:29 -0700 (PDT)
MIME-Version: 1.0
Sender: br.rw02@gmail.com
Received: by 2002:ac4:cc4f:0:b0:4ab:d874:e49 with HTTP; Tue, 22 Mar 2022
 04:31:28 -0700 (PDT)
From:   Charles Anthony <c122anthony@gmail.com>
Date:   Tue, 22 Mar 2022 11:31:28 +0000
X-Google-Sender-Auth: 1zAymGGo9pvlMUrsV6aLq20SCGM
Message-ID: <CAMc6C-p9wQgn3g8LbM7KaWMyXShhH332qs+uAyufvykkiwJS5A@mail.gmail.com>
Subject: Good day
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_BARRISTER,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1031 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4897]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [br.rw02[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [br.rw02[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.0 MONEY_BARRISTER Lots of money from a UK lawyer
        *  3.8 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

-- 
Hello

My Dear, I am Barrister Charles Anthony, I am contacting you to assist
retrieve his huge deposit Mr. Alexander left in the bank $10.5
million, before its get confiscated by the bank. please get back to me
for more details.

Barrister. Charles Anthony
