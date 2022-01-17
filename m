Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337B04905AB
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jan 2022 11:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238509AbiAQKGy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jan 2022 05:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235962AbiAQKGy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jan 2022 05:06:54 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B632C061574
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jan 2022 02:06:54 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id e19so20688413plc.10
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jan 2022 02:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=OdCBgQaraomp/q794ZAI+yT45N3IpLSZn67jkLcbZvI=;
        b=Yd8ASl4vH05emWKMzLjjNSDpcSxUK5qhxqxoXZ03Rh5RJyFoPG934+Bw/9/7BQvhcv
         DYp5ZPy6unqqAkuQM7Nrz8mGye9zuOZDlfdTZKtV1CKIk5nqKAo36eyignPjeu+0OONb
         1NSO47kF1kg8QJdC1ZAtVPzvLNwxSHnT1gdB7pPONPmV+WrERMQoKv05Dw6BAkFP57av
         UH1FFckY22SsDRlgtTAIgLH/sZLRQoyshzH0tmyGFjQSIRBVSsFzgYd/qzo7MF+GPj45
         LHTEDoMJaflkaN/LDpc8zHquWRYGClOwS4oWphufCPsdOgY+u85l4V5CIRvYNYBcDv27
         pilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=OdCBgQaraomp/q794ZAI+yT45N3IpLSZn67jkLcbZvI=;
        b=y5BwaLuRTwJOwjBlnO1tUCNWeXfbOrmxGeAG6P/HLFPt+mDWF6bSs5ESmGuy6yWonE
         jj2k88GHcnX98gHPSqp19Ai69LQqiwJkDQ25MbbJgPFLVffxz9+G+kaAHW+I7LX2LHWt
         xQ5zUFaHmHhc150DxJFX04907txEj7hncig0XQo4VF62wOkr/TTn0Ehnivcc3prlq0IE
         h/vDiczxP0qs/c4mA2Cqax3sAHHIXWyqgoUJxaC51z92gfD1fkvy0Q96igc5JGPlPYu6
         YvdH0aAJgJcV90+RO7fsnYENbq4PwU0Elm4kf/0Nr79QmINU8Ga1XceGt+kHe2y0lmPz
         8BNQ==
X-Gm-Message-State: AOAM530KHzzJkKsTQdMg09cHOp7zYALbE8pAgQQvSAjGPELJ6ZKue4O/
        ZkA3aZKalmc4Xe0T24YUgMQkl1FQzry+No8p/eildaM1xBwGsw==
X-Google-Smtp-Source: ABdhPJwtUy2LECVc+DaQz8HUJbtIEtBaGuTaWRPJe0rxvRJVND/LsLxUGBqOt3KwgyXop/9oi+7oCIyTp+/mUpk94AQ=
X-Received: by 2002:a17:902:f681:b0:14a:2a1e:4692 with SMTP id
 l1-20020a170902f68100b0014a2a1e4692mr21313477plg.99.1642414013488; Mon, 17
 Jan 2022 02:06:53 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?Fran=C3=A7ois=2DXavier_Thomas?= <fx.thomas@gmail.com>
Date:   Mon, 17 Jan 2022 11:06:42 +0100
Message-ID: <CAEwRaO4y3PPPUdwYjNDoB9m9CLzfd3DFFk2iK1X6OyyEWG5-mg@mail.gmail.com>
Subject: Massive I/O usage from btrfs-cleaner after upgrading to 5.16
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello all,

Just in case someone is having the same issue: Btrfs (in the
btrfs-cleaner process) is taking a large amount of disk IO after
upgrading to 5.16 on one of my volumes, and multiple other people seem
to be having the same issue, see discussion in [0].

[1] is a close-up screenshot of disk I/O history (blue line is write
ops, going from a baseline of some 10 ops/s to around 1k ops/s). I
downgraded from 5.16 to 5.15 in the middle, which immediately restored
previous performance.

Common options between affected people are: ssd, autodefrag. No error
in the logs, and no other issue aside from performance (the volume
works just fine for accessing data).

One person reports that SMART stats show a massive amount of blocks
being written; unfortunately I do not have historical data for that so
I cannot confirm, but this sounds likely given what I see on what
should be a relatively new SSD.

Any idea of what it could be related to?

Fran=C3=A7ois-Xavier

[0] https://www.reddit.com/r/btrfs/comments/s4nrzb/massive_performance_degr=
adation_after_upgrading/
[1] https://imgur.com/oYhYat1
