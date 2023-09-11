Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADED79B04F
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 01:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355899AbjIKWCS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Sep 2023 18:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243486AbjIKROx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Sep 2023 13:14:53 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF861AB
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Sep 2023 10:14:46 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31c5cac3ae2so4340280f8f.3
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Sep 2023 10:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694452485; x=1695057285; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yEN/04sCkB0JWg0biIvGJdl+0VCY8HY0U7JZa6XrY0=;
        b=L1h3PEMwjxS03WriTTLXkpKVJ2MC0dJMXAfPOuo13TLzKiWCsyP1glrWavWtV/DZBA
         vlEoPjqQ0k2t1ppTd/IwKpKdf5hV+CVH23zM7CeHQ7Zh4+6XYUGJ4WYHzUqla4ELtNVs
         h30Jf43CXZlzTYr94FlDlcSKkCK3WiwWtB8p2nZdFNKsW0IoqBnmtPfee7yxRMfbwZo+
         yYUwCFtqiWYLtw1Ssa9TyH66PeOaWQLGH2gUSvP9qJNzig4HVQ8Sfc9h88VMm7+M3cyp
         +CjF3phz4uGDF89xuDoDyZ599i3bCJDvmGrKYolIV9HXGKnKd/djaXevku8q4P1VpAdq
         q2iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694452485; x=1695057285;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8yEN/04sCkB0JWg0biIvGJdl+0VCY8HY0U7JZa6XrY0=;
        b=V6h5MZkrMxIxVPzsIXvxZLIcmjMSao6sw6wAtlVHoEyyYwDI+CUsQDLsTtep8Ur6Uo
         3J/tSTrIB8mAx4Y2L7A441QHZ9UMnX1jHeyhCZ6sN3IqI8U2i0nAnkfYKXlc74nJOg+2
         uAJE/OqrcdZiSjuEqZMf5jJcTEEd7Gh82Nca3ENm4cHlPOILkJXXYUvTaHtbj6sbi0Z8
         gOKcZIMavu7qLSi2Lf2GdO96s7ATFOp5CEZHInk2YoUcguhLfRNjXhBD36e1B+5Ut4q1
         Dc/ZKZ0zcoFYpRQCoGhf5OT9G3hpOD+rlf8cS+D6N46/Cf6bsQO3cWLSTy+MmD0nrPND
         djWw==
X-Gm-Message-State: AOJu0YwkIZb8YWrItFxSI0WLSrcPUubNCSoJxrB/vcMx3X9qUDNkTI/L
        3P4yE+p31oamdlU8fNf6oKjOanB1LyPMTmMn
X-Google-Smtp-Source: AGHT+IFL9g3UVbIYUYaiiR6klNUyEb7Ya2Dxii0mi2OCJEEDgjLp/MGDVaEe4ebAmHzUaLtrJrIA8Q==
X-Received: by 2002:adf:eece:0:b0:319:79bb:980c with SMTP id a14-20020adfeece000000b0031979bb980cmr8682618wrp.64.1694452484466;
        Mon, 11 Sep 2023 10:14:44 -0700 (PDT)
Received: from [192.168.20.10] ([141.0.156.136])
        by smtp.gmail.com with ESMTPSA id h5-20020adfe985000000b0031ae8d86af4sm10509811wrm.103.2023.09.11.10.14.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 10:14:43 -0700 (PDT)
Message-ID: <1ab61090-5c9a-434a-895b-3de2899d3e72@gmail.com>
Date:   Mon, 11 Sep 2023 20:14:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To:     linux-btrfs@vger.kernel.org
Cc:     Leonidas Spyropoulos <artafinde@gmail.com>
From:   Leonidas Spyropoulos <artafinde@gmail.com>
Subject: Mailing List missing messages
Autocrypt: addr=artafinde@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I've noticed the Mailing List archives contain messages I never received
in my email. Anyone else experienced this issue?

I'm comparing my inbox with: https://lore.kernel.org/linux-btrfs/

Example message I never received:
https://lore.kernel.org/linux-btrfs/f6ad7269b879d0ac24f3b051c3ff6530dc0953b4.1694260751.git.fdmanana@suse.com/T/#u


PS: I think previous messages were dropped due to pgp signatures (?)

Regards,
Leonidas

