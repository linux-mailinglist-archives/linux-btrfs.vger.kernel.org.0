Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA704B1936
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Feb 2022 00:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345546AbiBJXOi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 18:14:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345532AbiBJXOi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 18:14:38 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3A05F4E
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 15:14:37 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 13so13234818lfp.7
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 15:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=gae0iqrJma0ubJGx+korPq/UL8n+mTcx7+m98ESw/To=;
        b=CDfgiNYZmKZ6d07ntaraVSY6W/WOcLFs7w8MaWN9QtpRIi08TPOmiVMl/IrKPqdfgo
         72qWsaLAIlkuu5SIo8YO4QvP6w1g+fwj6rV7Rnb9PAuQmOQmvl19LXpDGLOXnbJGCwI5
         8YZ8myRMDw6yWvkPtzJ0Hqu3nVQOOsHeCgOmIG80toeMirexPtVsHNG2Dl3bxe+O95lc
         Q/M/CFPyf29s1cdSKv3CFbvZUUPRlnDlsYarDMTnfmdo0Hsu69tTbpP01IUWDx/pLST/
         Cm4NnRwPPy6dWSCYC+qNYyVXIj7MSd3yF+HJ5Yv2jh5zrqsmu596wj886PgZiDnoLWtN
         N+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=gae0iqrJma0ubJGx+korPq/UL8n+mTcx7+m98ESw/To=;
        b=X04DNyx6h7Nt57zCSyJwEnDagJJYyuKfj1Wi4924AwQ0ZdCihUQ6oSsdGBitdG44un
         ChhJVByMmJrPxWNC4amUOcxHXYdH3XehTXCI5JWyIqOjBf4dbzaWYb8+koKmWeqTcRwV
         xvalTX5mXQbF+E/rd0TvbB2e7ifhoHtUDstHgkv2Tm/3o9UYanKSR6W21nHyCJAkrjhW
         kkdf4BPlY/Axf/0XQAX+YWvxIRPoV0wz8OymNZQnbj69pY6RdRfRx/7IQGgx1PAqghYr
         7pfX/v+avomJOjl5t+IYm1oeaF0l0H1SHqXdtlJap83RUKxz8rpu1GjxsAdskKDoE9iT
         TfFw==
X-Gm-Message-State: AOAM531y0lKIJWJchYr2e1q2QZrTdrUYJ5LhfsDMPitIW04Gauhkb0ck
        maSuWXrWH0NwUEQPDTm4cItdATaXj9DKSoIZdLg=
X-Google-Smtp-Source: ABdhPJyC+u3YeHwR3Kl+f2MlwASw7gaBq0Gm2kAyNJGF10YR2HpQQ98it3DDET3RURsZ52HVHNuJz4bqW38wBnLAVxI=
X-Received: by 2002:a05:6512:3996:: with SMTP id j22mr5965592lfu.99.1644534876171;
 Thu, 10 Feb 2022 15:14:36 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab3:6792:0:0:0:0:0 with HTTP; Thu, 10 Feb 2022 15:14:35
 -0800 (PST)
Reply-To: tiffanywiffany@gmx.com
From:   Tiffany Wiffany <rogerpakayi@gmail.com>
Date:   Thu, 10 Feb 2022 15:14:35 -0800
Message-ID: <CAL0uRZBAX1qVdpCx1nOsw+6cg7rbXHJQ_uPFF7g1SHaOPr1ytg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

-- 

Hi, please with honest did you receive our message ? we are waiting
for your urgent respond.
