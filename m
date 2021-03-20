Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A54342E2F
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Mar 2021 17:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhCTQJh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 20 Mar 2021 12:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhCTQJV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 20 Mar 2021 12:09:21 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD6BC061574
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Mar 2021 09:09:19 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id y2so6810697qtw.13
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Mar 2021 09:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=PDZUudERkc0edi5fP/GUTNJvF7sCLvFD7qQ3pN46poM=;
        b=MnfRtf8gxRqJFHVMEYU+wk6iwgzg1LfgjgLCC/BFP2vCCFR76wuOijjr1iH9cIkLav
         pZUbT9U5v2fzA/2hgg6nV54lS6R2EUIf946Gw2Ewk5+dT6Efnv+AjqTpofYSxPfrxSIH
         aPuvrY4c3OvP8X3hCKd1+q1wKc8lV7yG7Kv0lYm3lrKKe2DyBCKqf9f4vwsfW9psISV8
         Yem4Et5BOn36g7NB5A1MNOG3GejfnJyw8DFe9IeRJIBId1ijcb1OSr42nPqO5xt3bKK0
         r8cDjLIdBwGO7LePC2vbAwhoxeaY1RwkOMhdi3sRH5Ihy8snXBUYB3/C0WBiPi2dz4Q3
         aO3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=PDZUudERkc0edi5fP/GUTNJvF7sCLvFD7qQ3pN46poM=;
        b=l2/3NEBvR/T1sGWD1nlEtxyu/PkQg6vYoTXuF8yMBWjAftXIiEs0HMPAX/QxUnJ42w
         aPHHSaqmOFOIqNffyAdfBSn/4elEaNfasfTbmUcgEcDcUqKkJ194y1u/18rKG1yof7Gg
         YBQk9XCzCHkKHOVl4b8J4P9BM6aFQb+85YCPCcpC8rT+PqlR6OQlcPMV7I/IdLyt2rFJ
         1yfIJ4/epVQ8YC2ZSsUZAiOohn7aPGLO/SWCeotfSG9qnjThqlmwRZQlqwjCYCKUD4c3
         V89HNqXfs0a9e8ovEreRLT/cjY34JrDIzNejuNlR3eGpGGiv8TO/0ItUrbmthwvRQ4OI
         VVOA==
X-Gm-Message-State: AOAM530n1/NH9t/9vFWLA5aMEasU1sURdBzZGBMAF1uCOb63NyN3k3rU
        6nHu+1zk3g6t45/P9dhpiPSe3TXgG2E=
X-Google-Smtp-Source: ABdhPJyg5S65/1eGMMjRDmBY/OGUvEZ0odTvf32xRwmymmKLGr/Z9uCoMZAOp6cf0803PSTm7+82Fw==
X-Received: by 2002:aed:2a82:: with SMTP id t2mr3339244qtd.217.1616256558673;
        Sat, 20 Mar 2021 09:09:18 -0700 (PDT)
Received: from MacbookPro.local (c-73-249-174-88.hsd1.nh.comcast.net. [73.249.174.88])
        by smtp.gmail.com with ESMTPSA id g74sm6793599qke.3.2021.03.20.09.09.18
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Mar 2021 09:09:18 -0700 (PDT)
From:   Forrest Aldrich <forrie@gmail.com>
Subject: APFS and BTRFS
To:     linux-btrfs@vger.kernel.org
Message-ID: <f2508894-5198-7c33-bec7-b731667f597b@gmail.com>
Date:   Sat, 20 Mar 2021 12:09:16 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I have a really large (3+ TB) volume I am copying to a BTRFS volume 
(both over USB) which is painfully slow.  In fact, it will probably take 
days to complete.   My goal is to use BTRFS on that larger USB volume 
(it's an 18TB drive)....

I don't suppose there is a way to convert APFS to BTRFS :)   I know, but 
I thought I would ask as it seems like others may have a similar query.


Thx...



