Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D74D70BFAD
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 May 2023 15:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbjEVN0Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 May 2023 09:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbjEVN0L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 May 2023 09:26:11 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C2D1AD;
        Mon, 22 May 2023 06:25:50 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64d30ab1f89so2386584b3a.3;
        Mon, 22 May 2023 06:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684761949; x=1687353949;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4b3cl3OODzw5cbGHTkbsgtSEp8oZPxcTDpluClxVbUk=;
        b=eO3rIpsi40iN+2w6btP49efxsdxTdxFOiCQQBcJFc1qjQAPCHGM1ndbcirI2jrHElM
         82mIWTyUiKNEbcA1OqxJxV/cy8w860ZuUZa19gI7FohoWQGljuvwuTXWG6ypc1UYjeRJ
         esqRmGWv3h5sai88fccF5Dgo4w9HWJAtapyegg02sBy8GwiNkMcpONHU+DaRbJgnAaTH
         zkgUTctpnh2Ne/hUgJAL4SZX8j7XBYl7B+DtXgbLWg+U/FWkH+SqwB9hHy0Y322M9872
         Ipie/tzXpsQqNs0CAZlNF7H0EYGqA9Hq7uYvp0b+UWxQc99RLw7B7VNSkRXF24233fxJ
         RntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684761949; x=1687353949;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4b3cl3OODzw5cbGHTkbsgtSEp8oZPxcTDpluClxVbUk=;
        b=Xp5AQO4mPzg4hPdVmFxk0lwgitlFqC83pSO4pLFJ5YBI/c+I+5qovYROruKNBr6Jt7
         pEdBKpcEnVRchef48aHktOpRTkhC/hhv7n+fylp+MAOcrj91SgeslK3EPuo4gsLv5d8b
         D/0GKwAYqk/YvuXDb/Zkshu9FUHp7ku98Na2l1ub0XQddWDMY5DMFrGTrLZ8WpdOOGy6
         R0/ElwsorMAQfrQ2Duod8jk0QZEriovIr2wQBR2Y1r1lBJ8GzJxb+Ez1K5K4iduxaDgX
         WOCvLS1gkivyJWZ6yiuNMEnlG388pjNcmuKYvgzIo8bAZHFOmZQrtw+IjmRDnnGwioyQ
         fj0g==
X-Gm-Message-State: AC+VfDwTZpUNtx28Hwn06KsrzHInTEmbWZcfkPaMmnDRWJP103FLg5lW
        HC/ROXliYOlmjmlhKnaMBoJapywFCfY=
X-Google-Smtp-Source: ACHHUZ6W3TTQEgMmXQa5zURSi0AtXuxh42yw2+Qd5pWuLLi/EMw6NyJGi1HDsSizjXkveQPFhxVT7w==
X-Received: by 2002:a17:902:b496:b0:1ae:bf5:7b5 with SMTP id y22-20020a170902b49600b001ae0bf507b5mr9747125plr.34.1684761949072;
        Mon, 22 May 2023 06:25:49 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-24.three.co.id. [180.214.232.24])
        by smtp.gmail.com with ESMTPSA id d6-20020a170902c18600b001addf547a6esm4883562pld.17.2023.05.22.06.25.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 06:25:48 -0700 (PDT)
Message-ID: <efa04d56-cd7f-6620-bca7-1df89f49bf4b@gmail.com>
Date:   Mon, 22 May 2023 20:25:42 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Linux btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Stable <stable@vger.kernel.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, a1bert@atlas.cz
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: vmalloc error: btrfs-delalloc btrfs_work_helper [btrfs] in
 kernel 6.3.x
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> after updating from 6.2.x to 6.3.x, vmalloc error messages started to appear in the dmesg
> 
> 
> 
> # free 
>                total        used        free      shared  buff/cache   available
> Mem:        16183724     1473068      205664       33472    14504992    14335700
> Swap:       16777212      703596    16073616
> 
> 
> (zswap enabled)

See bugzilla for the full thread and attached dmesg.

On the report, the reporter can't perform the required bisection,
unfortunately.

Anyway, I'm adding it to regzbot:

#regzbot introduced: v6.2..v6.3 https://bugzilla.kernel.org/show_bug.cgi?id=217466
#regzbot title: btrfs_work_helper dealloc error in v6.3.x

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217466

-- 
An old man doll... just what I always wanted! - Clara
