Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46B6773707
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Aug 2023 04:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjHHCsC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Aug 2023 22:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjHHCr7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Aug 2023 22:47:59 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0955AE5A;
        Mon,  7 Aug 2023 19:47:59 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 41be03b00d2f7-563df158ecaso3796677a12.0;
        Mon, 07 Aug 2023 19:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691462878; x=1692067678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVMPbRlocfh/FkpqpdX9dc9Olw9tI0l78lQhyb5jsb8=;
        b=TBU1ZXvO0XXUejhs8ykljpbUZn8nI3ELKKS5GN9eYi3lsUkVXGxmPI/S00HaSw3E4+
         OiRUPWlxJLhedYrAKKxqm1uqlEI4LkfUAXm3vBPmJrwABDn/+0RMYX/YSWDTIdFVEapV
         XqtS1QWIo0MZ2KPopGC06m5qxO3hWYXblZ3pVZqKCxGtjJBe0QFXkkpYjWErrxmuOGKc
         NP/3QWakZWlrLU1onenmWQwNfmzAH/Zi/lCND4bXqvHa/W++oK90ZhOW/Wrt3844MniG
         tXtN0QqkvdR6RFafmMZuzcznskO1Pgl1cDZMAz9Wb4SYGMPrVD0FFOMWPgm5cqdizBRP
         dTcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691462878; x=1692067678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVMPbRlocfh/FkpqpdX9dc9Olw9tI0l78lQhyb5jsb8=;
        b=iCvDNAISlztcVogTGnDnfVHSqQ+EVb0eP+4DKqmTYaznfFOoMzCzfIZWwJ3XRoqT/j
         5zAJF067r81JaogHzEptznstW07rNr0SrOfCFzhuMqnQTU9DyRY08+vMTkTlD4iTapHE
         CuZtdXdQ4zcms+Sf0Er1xCfMGotRq5yHfnwQ8MXHgLBkkT67L9ZDfgwe8hDcCR+8P8OZ
         GFhB3xaVmuxqtUoAY7DsrXPajCInAsjKfsrHJTsYPAvrrOlvpSCB0Ru/sc5SdrGNK+Wf
         f4jlHA5Ko5NDPe69N1U0bAveZpNibzEJqozHCJQ8XKj2HI4jKfH2NnV30ldMsgvxy4dD
         Blfw==
X-Gm-Message-State: AOJu0YzPociljuQiIS5Z2VVcVGLbgNItdizGh1L4TNY7Bv8q0nkuByLk
        TqKCIz/SiDFarjJaF0FexkYbBY1bxQC+73G6Az0=
X-Google-Smtp-Source: AGHT+IGv6jccPEJzI6N6VD44V4SXMSBFrNbWHXYpRHlFU9CFV8ZeXJUiy8j88Yxf+WwmoH1LVbqKNQ==
X-Received: by 2002:a17:90a:1208:b0:268:1354:7b03 with SMTP id f8-20020a17090a120800b0026813547b03mr11148487pja.12.1691462878427;
        Mon, 07 Aug 2023 19:47:58 -0700 (PDT)
Received: from localhost.localdomain ([218.66.91.195])
        by smtp.gmail.com with ESMTPSA id 30-20020a17090a005e00b0025023726fc4sm10189245pjb.26.2023.08.07.19.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 19:47:58 -0700 (PDT)
From:   xiaoshoukui <xiaoshoukui@gmail.com>
To:     josef@toxicpanda.com, dsterba@suse.cz
Cc:     clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoshoukui@ruijie.com.cn
Subject: Re: [PATCH] btrfs: fix race between balance and cancel/pause
Date:   Mon,  7 Aug 2023 22:47:48 -0400
Message-Id: <20230808024748.20530-1-xiaoshoukui@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <9cdf58c2f045863e98a52d7f9d5102ba12b87f07.1687496547.git.josef@toxicpanda.com>
References: <9cdf58c2f045863e98a52d7f9d5102ba12b87f07.1687496547.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I think this patch does not fully fix the issue.

This patch just fix assertion panic, but in the race situation, the ioctl pause 
request still returns an incorrect value 0 to the user which mislead the user the
pause request finished successfully. In fact, the balance request has not been paused.

Test results and analysis are as follows:
https://lore.kernel.org/linux-btrfs/20230726030617.109018-1-xiaoshoukui@gmail.com/T/#me125d17fa59e9e671149cc76d410ced747f488b1
