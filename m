Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC56548282
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jun 2022 10:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240552AbiFMItU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jun 2022 04:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240329AbiFMItC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jun 2022 04:49:02 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B201CFDD
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 01:48:17 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id o16so6197014wra.4
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 01:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:from:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=z2gFosycv/4d8F4IH6M5EFvOMVfX/xiPl+lWjQfsKQI=;
        b=RUx0eb42wDS5jRjpf89LdNMV2iBto/6fo/z6WOP2CijNPfMcOjv3lc7y6NafR9sTiY
         Ej2ENCAFK1RZNvL98rw6xnm7E09ZqkvwQlyjKFQXHXVm1xp56xPsHcRlaCYHN44YWmM/
         0FNDe5spl5jAAw7tA+mWngHxihSTZq1BzYe/ctSfQUgY2TkbXFyWRT8GvaVvEtnPE1Ra
         IF3pMcCP38/mB379OJ7mA3GTj318Om6xM8EllJKcAOQ3eKa9z1cztbX6ql0+S1JXBwsa
         ma/B1OprPG3zsnW3SYZy1cSeBeHpfNPTPz4wh+KLuxm00obzcqIWD0rK5SsPMyhzNEbe
         eFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=z2gFosycv/4d8F4IH6M5EFvOMVfX/xiPl+lWjQfsKQI=;
        b=BLKFkuZ3sxatQDJeGm9ZC4ondLTGLRv24IuKsunTdDHfjCSyizLDFpGfkWb4f5JW2F
         cX2HPrCsrtsE5o/672+7gG6Ix8J9ynuoH8guYRWnkXuhJJJl1ZZLfxywbCKXuPd00cBT
         j17OEtp+NrNZsQ5Sm/dOUrafB/Z78MmJXi6f5KbPLpiAoLKWc/S/GnUbzyfb6gfo9YB1
         ZZiI/3/jkqa9PvlGvBV1darhszl7JenHINFzC5qN+HTpGh0FeUhNnuSHr+QzqtPqtDwf
         Oc0AKiWf/GpwxAZ/HauWv2/W/R4yLVi/ATSvqKxCwhcmlm7K2BMZz7N/P2Fr/j/VWli3
         cxgQ==
X-Gm-Message-State: AOAM531zDgoeNUUALaMXeqLCLH+bgjGWQ971M2Fbexr8Owk1nxqqVnkE
        5mCgJDCyKfhddYVddtkrJnT6LbQHPwM=
X-Google-Smtp-Source: ABdhPJxCE55lWJ3CWTGcVKEQUc67OQYZNewKHaqsBaQBu1ojBYMyCAVJbjHVfsslrHxFNP3nGSGWpQ==
X-Received: by 2002:a05:6000:184f:b0:218:555e:6b69 with SMTP id c15-20020a056000184f00b00218555e6b69mr30114779wri.562.1655110096174;
        Mon, 13 Jun 2022 01:48:16 -0700 (PDT)
Received: from [10.5.0.2] ([185.212.69.24])
        by smtp.gmail.com with ESMTPSA id q14-20020adfea0e000000b00213ba4b5d94sm9381564wrm.27.2022.06.13.01.48.15
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 01:48:15 -0700 (PDT)
To:     linux-btrfs@vger.kernel.org
From:   k g <klimaax@gmail.com>
Message-ID: <1b54f116-6232-bfd5-6df8-6d9c47b5fc63@gmail.com>
Date:   Mon, 13 Jun 2022 10:48:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: fr
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MISSING_SUBJECT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

unsubscribe linux-kernel

