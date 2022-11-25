Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C6D6385A3
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Nov 2022 09:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiKYIzz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Nov 2022 03:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiKYIzy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Nov 2022 03:55:54 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8497931F82
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Nov 2022 00:55:53 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id z4so4432139ljq.6
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Nov 2022 00:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0mDRVPalzESjO7rkYCQWPMjB4nxMHrhh9SN3VuZZOI=;
        b=qSgcOVc8rukcS+k+PSPvulBBUPq/st9JYJ0o8rsK+dAMb56PA+owhj25Tv9ATi//+v
         uL9KzV1qWNy6j6G5CSzZ4CYfj6ww19HnlX2zo/sf3g8kkljbWYBE9BQldzHW2Ocq1446
         RUdfEeCY63Oy5BzaoHYNZJudvJml8QKMTDasR6FKQGchmqGbFR5yiFRonoA3nIFYAhOB
         xdNOY+sf7ctt/85mJK2pxQMSDKxnJQ17RKSkmV+onfdqquVjkSx+TuG+HxgqMFr2QLoB
         JdYiTGWlFp13N/B9aIZmBKX0MdNgimm6vhFH06wYMfRKXkXe7EHqc9xp5o+5XL/kBFml
         mtMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W0mDRVPalzESjO7rkYCQWPMjB4nxMHrhh9SN3VuZZOI=;
        b=3KNVnlDhRWABCe2IdAC+q8jEeY5lZhM24ipeD42uVnc5+EJb1LyecoT+JZ1onmVjgu
         Z+/1YdxntPnjU9QNFOHdaaLECN2SDETOliqTXSn20GOdxHmEMCmDGqLBbWwlUOxnH41u
         3LSGfCMkG9jb6PtLWPLZHl4fgJARlEgBos7iMuLROCEiW8LQ6qy4sURi68C68SUufUhI
         65eFTw3ACNUR5JsxjoWljn/pXCgdqHB0RWe/jzYcjztSQ3i/7DmvRDcYLAtO4V5vVbcL
         HhhHjQu4hunZ2EoCZMVuAw3nF2VfqVf6JdCfLFHcb0+jIewGv3rb0IWrGHB7cY2bpbzY
         qiyw==
X-Gm-Message-State: ANoB5pm3Gj14WTngpRv0WwGMjr5TMTr96BXel8K3W6aaxaFsR1jY67+I
        KrbYYEK/Fi6uc1hFL93oLM0=
X-Google-Smtp-Source: AA0mqf5F3HuKUCeF1UrzQU/SbIs96tM8Py0LIi4UfMtJXvNfruM1StPORWK0Fxgrw7q7JUeIr/NlAA==
X-Received: by 2002:a2e:8847:0:b0:279:7611:36f5 with SMTP id z7-20020a2e8847000000b00279761136f5mr4240348ljj.134.1669366551673;
        Fri, 25 Nov 2022 00:55:51 -0800 (PST)
Received: from localhost.localdomain (fw.storegate.se. [194.17.41.68])
        by smtp.gmail.com with ESMTPSA id u7-20020ac258c7000000b0048aa9d67483sm443889lfo.160.2022.11.25.00.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 00:55:51 -0800 (PST)
From:   Joakim <ahoj79@gmail.com>
To:     wqu@suse.com
Cc:     ahoj79@gmail.com, linux-btrfs@vger.kernel.org
Subject: Re: Speed up mount time?
Date:   Fri, 25 Nov 2022 09:55:38 +0100
Message-Id: <20221125085538.280-1-ahoj79@gmail.com>
X-Mailer: git-send-email 2.38.1.windows.1
In-Reply-To: <376af265-a7c4-6897-b6fe-834d225b150f@suse.com>
References: <376af265-a7c4-6897-b6fe-834d225b150f@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

That sounds great! Is there any rough ETA for when that might be released?=
=0D
Thanks! :)=
