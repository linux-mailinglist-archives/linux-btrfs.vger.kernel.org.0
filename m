Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCF54F71C9
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Apr 2022 03:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbiDGB7G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 21:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiDGB7F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Apr 2022 21:59:05 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C0E5676B;
        Wed,  6 Apr 2022 18:57:07 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id hu11so3942884qvb.7;
        Wed, 06 Apr 2022 18:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tZB4vW+6/PaCerTEYxK+hZgmxatRHftRvaeDxqdEI1A=;
        b=ZhZZWQj0upGYS1dHLLp3XvzIBw2TzyAcGaUEikU9nYMaVSKRQBUlub8c4HTjZ0s+rr
         8aBlZAEGVsmvh2MEPlxxazZNfvaCBPo7aVZdn9Y7iZsIpR63BvVyLkH1SJfSDr1j3PNx
         pqwPavguKArR3C79nazHK2UscAsmiPVhP+DaPc+Am+R4VOi129x6ODuKUNLQDBpBktm+
         A1HWZcvrbAQLeVNES35lsYrsOQckRoNjAj8SNmSOi1v+7vq+05Boh8H9C2tLi8Xumhpz
         03fESpb6Cl7AX877Lyq6M+FIVF7cJ51UvK4fQZfw0cYc0BgIuBI6mxrfOOleklTRPjV6
         O/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tZB4vW+6/PaCerTEYxK+hZgmxatRHftRvaeDxqdEI1A=;
        b=n14SBdCIgP1cZVbNfd3Z5bD4E5KsA3Czvhnu0uTTvDwa1DjjuXyfECWDzfW6/VZuHa
         o7plJh8inWUp6JTFbSPG5fZvewY+w69/AfleHHyZK+X1gigZ179mgIujoSxV+3x56kEU
         xe+rNLmTNNS/N+x6a0jNf/MiQB4sk5JyiExBuzIic8r/28QC28QLx6JY8X1hOHzmKqBn
         FiCwIVPaMAaI3VxmGNyGF1rk3Qcutrbj51dTX1KsmcNoB7hEjR2pM5ASYd1Qi+o1JApa
         7bTA0uNwBMSWj99eQO+WyX51PxV3ipcUXZH8srgWbClTvTIQwYgWIly9glqrCrtjN+AG
         Vs+Q==
X-Gm-Message-State: AOAM530HLY4EvbHb9rgm6mYzgimUMi/t5z3GVuhSajAOOe7kXRId+evb
        8/7RH3Q8noRgieFRYaZI+hsHvNKK60Q=
X-Google-Smtp-Source: ABdhPJxK8Hcky2RxCBuGxuto0Ya8lf3h/vk2diaHDDtRjYS/FiFip0kewta1f/Df5pu1lFrYUeCMrQ==
X-Received: by 2002:ad4:4eac:0:b0:443:cfa6:ab90 with SMTP id ed12-20020ad44eac000000b00443cfa6ab90mr9560731qvb.36.1649296627003;
        Wed, 06 Apr 2022 18:57:07 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id u22-20020a05622a199600b002eb841fcb6dsm14536367qtc.73.2022.04.06.18.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 18:57:06 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     dsterba@suse.cz
Cc:     cgel.zte@gmail.com, clm@fb.com, dsterba@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, lv.ruyi@zte.com.cn
Subject: Re: [PATCH] Btrfs: remove redundant judgment
Date:   Thu,  7 Apr 2022 01:57:00 +0000
Message-Id: <20220407015700.2489671-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220406130453.GB15609@suse.cz>
References: <20220406130453.GB15609@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

< Ok, we can drop the check, have you looked if there are more similar
< places to update?
I found six by coccinelle, but they are in different paths.Should I
send one patch or six?

Thanks
Lv Ruyi
