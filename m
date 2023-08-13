Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5B277A5E1
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Aug 2023 11:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjHMJvR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Aug 2023 05:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjHMJvQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Aug 2023 05:51:16 -0400
Received: from mail-108-mta195.mxroute.com (mail-108-mta195.mxroute.com [136.175.108.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CB1170C
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Aug 2023 02:51:16 -0700 (PDT)
Received: from mail-111-mta2.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta195.mxroute.com (ZoneMTA) with ESMTPSA id 189ee49dfb500023b6.001
 for <linux-btrfs@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sun, 13 Aug 2023 09:46:06 +0000
X-Zone-Loop: 09e8e10f3fd6261d0ff55bfd02634dd18b7b9c607a91
X-Originating-IP: [136.175.111.2]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=c8h4.io;
        s=x; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ditxff6QaCBmgFhZlCCIEE+0ywBGpM6B/2aGgFyB014=; b=hfl78wi8I7tu7kOUW+5CWlZKJF
        gOkRwo1pFD0dPgVN0IANzN8TqgiQ8E/LU+8llu9hJB4HxtYpnv/5DeCsm3kSN7rrp2Wul0A6Nf19D
        k2FtIfi3Hu/otIMsNJ/HHK1TT71i2sEpUYPNYX+XwzSFM9oQua0VVhWKfdwTtzMHvMgT4flVEumdw
        8lMarIpw3L5MTmNJesChLv8LL8sevyrFq1Uj+fKCP1mCxukfnPZzy+tbd8VIaO6GJ6XiI4zgsM+Kl
        wL9BoVUnShspU5vZ+Qo1DSsIg9q77iTesVeLgl1sUhpFklVD///dlOSLb/5y7AFfA0iIeI8FtwDeZ
        6hoPPvYA==;
From:   Christoph Heiss <christoph@c8h4.io>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/7] btrfs-progs: common: document `time-long` output format
Date:   Sun, 13 Aug 2023 11:44:56 +0200
Message-ID: <20230813094555.106052-2-christoph@c8h4.io>
In-Reply-To: <20230813094555.106052-1-christoph@c8h4.io>
References: <20230813094555.106052-1-christoph@c8h4.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: christoph@c8h4.io
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Seems this was forgotten; rectify that.

Signed-off-by: Christoph Heiss <christoph@c8h4.io>
---
 common/format-output.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/common/format-output.h b/common/format-output.h
index 95e2a117..ab12a7f1 100644
--- a/common/format-output.h
+++ b/common/format-output.h
@@ -28,6 +28,8 @@ struct rowspec {
 	 *   (values: va_args)
 	 * - uuid: format UUID as text
 	 *   (value: u8 *uuid)
+	 * - time-long: pretty print timestamp, including timezone
+	 *   (values: time_t)
 	 * - list: print list opening bracket [
 	 *   (values printed separately)
 	 * - map:  start a new group, opens {
-- 
2.41.0

