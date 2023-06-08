Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA3272802F
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 14:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236109AbjFHMiB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 08:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbjFHMh6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 08:37:58 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008772D55
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 05:37:48 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b1b8593263so4958501fa.2
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Jun 2023 05:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686227867; x=1688819867;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=etDsOsklTFhdv20/ihPgdxxbpxkX/HMYSlW+AO+gqjs=;
        b=FYrmISaxpbslm/6ck7IOlVQuV8GD6C9sm6QWnwugqSTiPLJSYwfEzsTnHKe4yW7yr4
         eSTvzpBGL2RGnxFF3+LmKCN2NEJj+pTgwSNTVxLCvNediACIYrIQDdlJ8+O6rYJO3yap
         VhPcbaokNdhL5/1+sk/BvylSG5B9ukPmHZmIJARNF55rOSTEEAKWwekhbL6YpJyQjr9J
         JzmcqfYwjqWfoFPgm5G/z+xaSG5DMfHrTs1MrdK/hHU1iDPx+elpi2dOvZd8eRJoPWc9
         eHg85w9cNSFmpjgX3SXyB2Dl3TeEDsHiQ99bQSGnMAFgEZN3UHMKN1TOrcvtSHuHw5VS
         KEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686227867; x=1688819867;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=etDsOsklTFhdv20/ihPgdxxbpxkX/HMYSlW+AO+gqjs=;
        b=j8ouxbgUk6zn/Wibn84K7bgEKEPPIGqTKn5EKjrK+P3vy6/olCVy0Ifw9LbeBb1k0c
         B0VKMj0NPsK4CHQbdgOgezmFISSZP6MGSyXerhVm6KIwjunnAouh7g2bFnQCi3KHFk91
         53hSfr7/dBwvp9qaicMzjHHc1M1T73Pw+CvC4mD0/y0y0O9qgefUafzCaSR6UrVZc2Y9
         0TujSULj42G1WSkWO1FX+lB9vXfb26MAaheAyvWoYKk++cHw1oDbdlGs8Mjqqy8f47kz
         ASXWo8KsboLMT80K1seF+1DltcTcXgDJcD+UIRZ+TCKnJ7tzVCmclayMjyZ/l5wnwXrL
         /uAg==
X-Gm-Message-State: AC+VfDx71B2qbXhOD751BRRVdetRtFGdS+gChzYl8sQH41B0ZLrkHd8q
        5y7zTPgMVCupKxMZ18N8G9qZ0DGZVwO58ozLNbI=
X-Google-Smtp-Source: ACHHUZ4RxRBfCldovo8tx9ZcbpVsyA95a7XT27GAo7q2OTfcHG5O3sGXHtKXChQWVyc7wsdkozDzohROKOUnESyKAfU=
X-Received: by 2002:a2e:7c01:0:b0:2b1:bbf9:8bdd with SMTP id
 x1-20020a2e7c01000000b002b1bbf98bddmr3812639ljc.33.1686227866865; Thu, 08 Jun
 2023 05:37:46 -0700 (PDT)
MIME-Version: 1.0
Sender: gbandirodrigue47@gmail.com
Received: by 2002:a05:6504:99:b0:22e:83f0:5fa8 with HTTP; Thu, 8 Jun 2023
 05:37:46 -0700 (PDT)
From:   Fiona Hill <fionahill.usa@gmail.com>
Date:   Thu, 8 Jun 2023 05:37:46 -0700
X-Google-Sender-Auth: sS-o_rL3TgOUloG0tmwICgyc-DY
Message-ID: <CAO0sK26wrUCsbc9eDGJ24MaBB=G8-qu9kUvezTjhXHbq2yJg-A@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

-- 
Hello did you see my message i send to you?
