Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547506DF982
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Apr 2023 17:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjDLPPL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Apr 2023 11:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjDLPPK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Apr 2023 11:15:10 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E16C7ABC
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Apr 2023 08:15:01 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id qa44so29406704ejc.4
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Apr 2023 08:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681312499; x=1683904499;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l2Uz6YywxBMkWcBAlvxVRUHII32QKi3ekyo6RTaSv6E=;
        b=QD4s5Rc2uAQMn3/2eIbcjCg4oBj+gfBOPbvomJAMCiUIRx8PujCCzu8te0zmrO1XaN
         d1wWqvzPzR81Q1lf5tFEFixAuD0wIo5gkZj4uc4uW6LHfMDLYTBrDAoTqHTma9kGrad1
         K6jDQMIIHC/0vhYtw29rYKZaAy6R3oyyahyStsLSwDOkuuZ/RPI78z43ySX9DL8W3MZb
         aDw3QcOi7TEqw5mSn6XeeYEFNH9dZX6/Ad2uQqDGyK29pPzeUmonpRg4LoWNP0z0rR09
         NAjbHjZNnIf+Yt764U3CiH0sK0FCKX9zu4ZKO1X5DjBSvGhRlkQiy3GEJed7vY5lhagS
         5q5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681312499; x=1683904499;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l2Uz6YywxBMkWcBAlvxVRUHII32QKi3ekyo6RTaSv6E=;
        b=ZMbYHpaXLXFBxR3fI8w/ytjmDNQhUFjBz3ldTTSPFTHdFAJNzZSIpiC8WXi+sZ3VML
         M2oQo/cAkLmdiGxdUFyCJ957gcMgJ5fJugIcie9VpemMFllETsFSypalPZg08QxqOgFk
         f6I17zC4lntYBNv1T/5bs3KR68PJLLW4+Nbytm9G9RZs/sJF+Srcsf0qP48FsAlWVfbM
         IVBPW18hWPCyBwYYNfUpH9SLelQUWpiBtrpeBgzk5DjCudi+MPDqI7NQ2npsO2p+yIFo
         +Suyt6lmZsoYU6X8TiZdTGWreBCcaRQDBaQPzZsdKWJgyoovi4d0CkQbzajqpXJl4EQ5
         en2g==
X-Gm-Message-State: AAQBX9dHVQE3Vv2XhpiJRF/0chG4/Gdb2mZuhFwsntfrOajYTeP817PD
        hfcxXkV2sJWMhQW4Bjt2P8v7UyXKFyQ=
X-Google-Smtp-Source: AKy350b4fNtkRkTVGYoTM2z/sUeJw9Qt7tfyjW8IeiwV533TLHta7/I+bObCpFCIYAf7FYHiyMguuw==
X-Received: by 2002:a17:906:65c5:b0:94a:68a9:b399 with SMTP id z5-20020a17090665c500b0094a68a9b399mr6361750ejn.53.1681312498969;
        Wed, 12 Apr 2023 08:14:58 -0700 (PDT)
Received: from [127.0.0.1] (pd95d382a.dip0.t-ipconnect.de. [217.93.56.42])
        by smtp.gmail.com with ESMTPSA id s4-20020a170906500400b0093e817ee3f9sm7357147ejj.191.2023.04.12.08.14.58
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 08:14:58 -0700 (PDT)
Date:   Wed, 12 Apr 2023 17:14:59 +0200 (GMT+02:00)
From:   Emil <broetchenrackete@gmail.com>
To:     linux-btrfs@vger.kernel.org
Message-ID: <dfd1905a-2633-40b9-87eb-a64bc6013c7a@gmail.com>
In-Reply-To: <35d0e423-a969-4dfb-963c-26ed00056c17@gmail.com>
References: <35d0e423-a969-4dfb-963c-26ed00056c17@gmail.com>
Subject: Re: Replacing missing disk failed (btrfs_scrub_dev(<missing disk>,
 5, /dev/sdf1) failed -5)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <dfd1905a-2633-40b9-87eb-a64bc6013c7a@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

So I tried to find the files responsible for the last errors in the log with inspect-internal but no avail...

I then tried to run a btrfs check (readonly) and it segfaulted...

This is the end of the btrfs check log:
parent transid verify failed on 15959631003648 wanted 671918 found 671864
extent back ref already exists for 20295519666176 parent 0 root 4220
extent back ref already exists for 20295519682560 parent 0 root 4220
extent back ref already exists for 20295519698944 parent 0 root 4220
extent back ref already exists for 20295520452608 parent 0 root 4636
extent back ref already exists for 20295520468992 parent 0 root 4636
extent back ref already exists for 20295521206272 parent 30423438540800 root 0
extent back ref already exists for 20295521222656 parent 30423438540800 root 0
extent back ref already exists for 20295521828864 parent 0 root 4636
extent back ref already exists for 20295522369536 parent 0 root 4220
parent transid verify failed on 16079759130624 wanted 671918 found 671896 items checked)
parent transid verify failed on 16200175910912 wanted 671918 found 671896
parent transid verify failed on 16325838782464 wanted 671918 found 671896
extent back ref already exists for 16569929728000 parent 0 root 463688657 items checked)
extent back ref already exists for 363828461568 parent 0 root 46361788780 items checked)
extent back ref already exists for 363828936704 parent 0 root 4636
extent back ref already exists for 466136793088 parent 0 root 4636
extent back ref already exists for 466136809472 parent 0 root 4636
Segmentation fault
[bluemond@BlueQ ~]$


And this the dmesg log:
[Wed Apr 12 16:34:35 2023] btrfs[205859]: segfault at 10 ip 0000563e56d478fd sp 00007ffff78fc130 error 4 in btrfs[563e56ce4000+a3000] likely on CPU 5 (core 5, socket 0)
[Wed Apr 12 16:34:35 2023] Code: 00 4c 8d 47 01 0f 1f 84 00 00 00 00 00 48 8b 43 20 48 8b 4b 28 48 01 c1 48 39 cf 0f 83 bc 00 00 00 4c 39 c0 0f 83 e3 00 00 00 <48> 8b 42 10 48 3d ff 00 00 00 0f 86 e3 00 00 00 48 3b 7a 18 0f 84


Not sure what to try next tbh.... Any suggestions?

