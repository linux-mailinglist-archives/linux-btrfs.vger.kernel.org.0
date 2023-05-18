Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67077082FA
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 May 2023 15:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjERNnY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 May 2023 09:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjERNnX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 May 2023 09:43:23 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0167B1A2
        for <linux-btrfs@vger.kernel.org>; Thu, 18 May 2023 06:43:18 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-253570deb8dso935768a91.1
        for <linux-btrfs@vger.kernel.org>; Thu, 18 May 2023 06:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684417397; x=1687009397;
        h=reply-to:date:from:to:subject:content-description
         :content-transfer-encoding:mime-version:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oHv2rHBt/MPxF0IRPeVP3s0RoUZCIx5DZjq+S8Ci6vc=;
        b=JW/BbL68/N9034yJ8K6wUJ9J8/xFjhWbBcWqrB+yWwglWRobZ30c8U8ZXFCJDgKgdD
         iFQSGc6EBFqoAVIJEHbtgxmn4QCe0MCmY7OJ+PBJrcfHCOcVrKO15ZebJ3G/sbSGebFy
         hHDviRBhsvpK1citiIDs6j6Na+2wbI9obnDFqypWln+ywJ1OIwtbz+A4I30LXWOD5+iK
         OYdaN8eUpJTKpQocdSyxAT/0gOcwEIz9GSpgvOVCwJ+Pnw+0hySuiKKPaYjieZTI0LRJ
         izfpTZZAoaCoVBpM5VID9lpdvfsHvbx5c49Y6Y7gCrjYDmFBoPxV8B3+CVfQ+SE2Chkn
         h/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684417397; x=1687009397;
        h=reply-to:date:from:to:subject:content-description
         :content-transfer-encoding:mime-version:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oHv2rHBt/MPxF0IRPeVP3s0RoUZCIx5DZjq+S8Ci6vc=;
        b=P495Ku1hI+11Ri7dhqOMHpDZ98tfqMOyrz1KIc+essIAxGRoFvr1b12FWinZSDgVz+
         l5nPQZRsOaA6HN2UOi7GoDTlTi95osNjMZizscSjq61prRSJrJ51UYf7yNBSNA1w4Jby
         cEunx3T3ptOeLB5rJR0HsV6ghUn1b4zvLA/q/iqJ8Vmn9hx/Dn6YavNTxZOGJKAEBhZB
         f6o2LzBzRlxAEnlLfwKNrmsAoa8qSmSGVfN9moiGZVUlaVGLq/TJetQD6OiYaYX6sQdw
         nHPD0d7ZM+cOVv3/NeAaRFq+iomhk0ngecTlxKejNrEF9JVi+mTESrm/RujJFCnieR8P
         6L7Q==
X-Gm-Message-State: AC+VfDyy5jBjUgcbHPKGUSO0NT5Ey0QrsNgnSpeXdscaA9LshzOtMQL0
        b+8QqYFacRid1ZA0MkbS4YLUGGdV+2oOvO7I
X-Google-Smtp-Source: ACHHUZ7aT5mcOHc7UVgl5nJQdt8uzYiYjM83nB/xIgI1tAgAWPpOR18+WnzNAPU+li7cB+M5Ee2GGA==
X-Received: by 2002:a17:90a:6388:b0:24e:4b02:4f0 with SMTP id f8-20020a17090a638800b0024e4b0204f0mr2350804pjj.6.1684417397169;
        Thu, 18 May 2023 06:43:17 -0700 (PDT)
Received: from [192.168.0.106] ([98.159.37.96])
        by smtp.gmail.com with ESMTPSA id bs10-20020a63280a000000b0050f93a3586fsm1269822pgb.37.2023.05.18.06.43.15
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 18 May 2023 06:43:16 -0700 (PDT)
Message-ID: <64662b74.630a0220.c79d6.1f25@mx.google.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: JOB OPPORTUNITY
To:     Recipients <williammarkson2121@gmail.com>
From:   World Health Organization Empowerment Group 
        <williammarkson2121@gmail.com>
Date:   Thu, 18 May 2023 20:42:59 +0700
Reply-To: dr.masonfinley@gmail.com
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,SUBJ_ALL_CAPS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Greetings! We are writing this email to you from the World Health Organizat=
ion Empowerment Group to inform you that we have a job opportunity for you =
in your country.

If you receive this message, send your CV or your personal details (your fu=
ll name, your address, your occupation) to Dr. Mason Finley, through this e=
mail: dr.masonfinley@gmail.com, for more information about the job. The job=
 cannot stop your business or the works you are already doing. =


We know that this message may come to you as a surprise.


Best Regards
Management Director
Dr.Mason Finley
Email: dr.masonfinley@gmail.com
Office WhatsApp Number: +447405575102.
