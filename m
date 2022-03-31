Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343B44EE3AD
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Mar 2022 23:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240524AbiCaWBE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 31 Mar 2022 18:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242127AbiCaWBD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 31 Mar 2022 18:01:03 -0400
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62402E9C8
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Mar 2022 14:59:14 -0700 (PDT)
Received: by mail-pj1-f51.google.com with SMTP id mr5-20020a17090b238500b001c67366ae93so3551822pjb.4
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Mar 2022 14:59:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d4Sd/WlDoYZnbrMdOLIUWna8bTDchiWUH8C+SBeaMbQ=;
        b=YhX1f8M2fWqK4v9+wtRABg5JMJSoUXDfC9PHAfLGdaut8dZ5y4KgoJ16EVT4pmp6ON
         ikPVxBGooucAKP+CRCwmP7yKR3L01fsAyxZolsSoRLcexEKLSOx/pRxk6CdaHBpgVFNd
         PQ53LUNHPwAgbdrfmbjKRcNbkggA4cGSV4As7gwWGWk+nFp4PGkUsUVHwuYUANLO2mA9
         ARVtvvnJXj0+1tC4AoWxSzTaPFk57hR6pR9SqhxTpn9bED3CeA9/1ZrP587J27vC4pmY
         NvGFqUirQ44vwSAkLfo2LiKd2+ypIF+JsqaDSb2oL88V/OYKpQTRbpxAuBn9a479L2Gh
         NCvg==
X-Gm-Message-State: AOAM533lhytqVxcz8br8ZkBl+42yTBMdOHT8EdJlGOyto2oRnUPi88NM
        B3AnLzR/pf+AcLwMJQr6QWU=
X-Google-Smtp-Source: ABdhPJz7SKD8abF+Jl8Q1yGpSFsbDJEzmmGgn1KGS30L8wbi67VNeajY+sq6uwdQNivcuyorXGW/VQ==
X-Received: by 2002:a17:90b:1c03:b0:1c7:5523:6a27 with SMTP id oc3-20020a17090b1c0300b001c755236a27mr8222010pjb.29.1648763954232;
        Thu, 31 Mar 2022 14:59:14 -0700 (PDT)
Received: from localhost.localdomain (136-24-99-118.cab.webpass.net. [136.24.99.118])
        by smtp.gmail.com with ESMTPSA id s10-20020a63a30a000000b003987eaef296sm300914pge.44.2022.03.31.14.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 14:59:13 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 0/1] btrfs: compressed writeback cgroup attribution
Date:   Thu, 31 Mar 2022 14:58:27 -0700
Message-Id: <20220331215828.179991-1-dennis@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I was looking at some blk-cgroup attribution stuff due to an ask
regarding io_uring and was thinking back to this work. I noticed that
the cgroup attribution for writeback is gone. Josef or Chris, can you
comment if this is still desired / the state of REQ_CGROUP_PUNT?

Thanks,
Dennis

Dennis Zhou (1):
  btrfs: fix btrfs_submit_compressed_write cgroup attribution

 fs/btrfs/compression.c | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.34.1

