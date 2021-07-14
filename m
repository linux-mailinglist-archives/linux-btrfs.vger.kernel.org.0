Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454083C7C10
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jul 2021 04:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237456AbhGNCyD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jul 2021 22:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237415AbhGNCyC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jul 2021 22:54:02 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AD6C0613DD
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 19:51:11 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id l11so580933pji.5
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 19:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=rVHm0oq+VRnopmeEuC3A2GqVAfbgYXf4wapvsU6H7ns=;
        b=NPoC7DdPEZygUp01MruRH6p+alN57GNSsJTja7SB+3bFJdLSWgzyVOSnEeblPYk8uD
         VWuCTCzQeNnPmX17uINl5yLIsAj5t65FTenRKCnOXsQXpRj6Va77Q4r4PMzbs15uygFh
         Chje3EkccqVDZ/f2dRFWS6lw5UQL1XF+HYBnXvM0yjPM3GH905MmCEQd33r3HnctzK5t
         OVC8iX8f6WpVM8cA/tMco4YUiuMMXewFPNORX0NKL3Zr2NQj1RiS/DnpBLKRmhT7iMyv
         e+NFMRtaajRmr/BPrKXaS8sm2dJ9nnB24VDWLTqUGo++oL1dr5BC0boGp2tNe/5nB1ra
         KAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=rVHm0oq+VRnopmeEuC3A2GqVAfbgYXf4wapvsU6H7ns=;
        b=OdB0QBa/8d153NXwwZ8ncqt5ph2oEGFpQWBh7WoReqnkMjbue0zG3okmp38BM8SFwl
         zjk8W2VQBnXxWmWxZrfSOWWGWlO1qdMvjRQMUaEFoEqxYb2Znzbk4Ev8fTV7XyBQAo1y
         Uzqp286jhf4ze3caUCF9zsts4fG4gpHPefEnV1v+rNcPykG8TOQCYWuLUUaoX43wTMj1
         NsJFbv6KmypB4yTeGWGSZ8YFXtXYLo//3v+YY1ArqBejWCbMGxnmxGs1teyGDj+isNpN
         uLtYB1dff/WUAZHSwd99MA3MLBWEBO2O0RaBeAChWZ6mXO4lSUsKUqs9LViFdth+NTpz
         7V4g==
X-Gm-Message-State: AOAM532qiWu3UwAKUQ9J+0H+cTuSzDeRS8EIUXAuw8dFASfquNrVftsB
        SxcPgTda5DplDSTd+Ydc7Is=
X-Google-Smtp-Source: ABdhPJzzzhmyA4ntygYKYOG1e3z1u2lvJI1sz3ichD/tX5aqO7gmzLSRyD20fCvpi7naVjQ8cTf5wg==
X-Received: by 2002:a17:90b:128a:: with SMTP id fw10mr3592278pjb.116.1626231070733;
        Tue, 13 Jul 2021 19:51:10 -0700 (PDT)
Received: from [192.168.178.53] (14-203-78-180.tpgi.com.au. [14.203.78.180])
        by smtp.gmail.com with ESMTPSA id hf5sm1109407pjb.18.2021.07.13.19.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 19:51:10 -0700 (PDT)
To:     linux-btrfs@vger.kernel.org
Cc:     danglingpointerexception@gmail.com
From:   DanglingPointer <danglingpointerexception@gmail.com>
Subject: Enhancement Idea - Optional PGO+LTO build for btrfs-progs
Message-ID: <d0f8f74f-edd3-6591-c6e5-138daf6b25f5@gmail.com>
Date:   Wed, 14 Jul 2021 12:51:07 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-AU
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Recently we have been impacted by some performance issues with the 
workstations in my lab with large multi-terabyte arrays in btrfs.  I 
have detailed this on a separate thread.  It got me thinking however, 
why not have an optional configure option for btrfs-progs to use PGO 
against the entire suite of regression tests?

Idea is:

 1. configure with optional "-pgo" or "-fdo" option which will configure
    a relative path from source root where instrumentation files will go
    (let's start with gcc only for now, so *.gcda files into a folder). 
    We then add the instrumentation compiler option
 2. build btrfs-progs
 3. run every single tests available ( make test &&  make test-fsck &&
    make test-convert)
 4. clean-up except for instrumentation files
 5. re-build without the instrumentation flag from point 1; and use the
    instrumentation files for feedback directed optimisation (FDO) (for
    gcc add additional partial-training flag); add LTO.

I know btrfs is primarily IO bound and not cpu.  But just thinking of 
squeezing every last efficiency out of whatever is running in the cpu, 
cache and memory.

I suppose people can do the above on their own, but was thinking if it 
was provided as a configuration optional option then it would make it 
easier for people to do without more hacking.  Just need to add warnings 
that it will take a long time, have a coffee.

The python3 configure process has the process above as an optional 
option but caters for gcc and clang (might even cater for icc).

Anyways, that's my idea for an enhancement above.

Would like to know your thoughts.  cheers...

