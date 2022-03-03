Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931534CB8CD
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Mar 2022 09:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbiCCI3Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Mar 2022 03:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiCCI3P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Mar 2022 03:29:15 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C041712BF
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Mar 2022 00:28:30 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id g7-20020a17090a708700b001bb78857ccdso7084164pjk.1
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Mar 2022 00:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=88ocfaTwP8XzyxRBU9N/2BlMhjYo4cFyYg29sCPc7VA=;
        b=C6N8/lzE1oM5cOr/fRLM2DqzPRcIf+bGsKjkW0bruLCDRUYNlRBbl7YGC/SKK4kxH8
         r1Nu9xeFLqZT0FfGyVQMGGT+EK0vmvObOWrZP0SsiFVzYhqJ7iKson2slTvgqnFHqsjt
         BjCCseN2qPmeMn3ZenR73/abiHUPa8RuLhPLaDkQDRzG6sLnWUeqVAqEZDyNKdYERwoG
         LUZsJWkxoYpFva+r0dtzCu4H03nJmEAms/dXeP4aEQnKsGl6qiPl9sCG9vtycO1PkQUs
         BUtNyYEJoYGv4KMNJWhaS0lIIjcd97oH0JB0Uui/mkYkhVvV+FH0olSDUH1O7gW06NKd
         qZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=88ocfaTwP8XzyxRBU9N/2BlMhjYo4cFyYg29sCPc7VA=;
        b=S8mDxwg7bsVeG0cXe5XsYam8/DsenPEbMlgr0ytY1fE/bv8XtQvyWPU38SOby4N7fK
         V3UHhO3vgpzv69Ilzfjg0uKTf/22/v4D5Twe0SX7SOS0glIRx0DXfi+rnNTRNlfm8a31
         eHU8XhzfusTvB0cKQG8rMn2H7mZ5IIBJqLVpC/hBexL7JX1yWjospWPUiQcDP2YrO+Ih
         hWU8aXOx7Db3r4goSAqHAtT+GmyGIl1AhrIML5r3ykNsFpIuWjwEoHfQ6nIPvzXYkRFV
         2mS3uAdwso8JKtSs3h9d8BewydlcpzJ14bXvnZxa2W6sSNTO9IgW7jGKDuUh4LZUZtjp
         YGXw==
X-Gm-Message-State: AOAM531/3LPuze0AD7MUMfu2a4JDnaepaSKbVNyYvRvbabuUY+mXntDT
        /3uzsSq1uprAhSxOfIi7q46vWOSHGbU=
X-Google-Smtp-Source: ABdhPJyTwC7PRYnb7Y7ot50qN/Hpi+/km0o3GNGJNweEaN2VrWHexsD2jc6/qGdwjro5fG6P0KSI3Q==
X-Received: by 2002:a17:902:6903:b0:151:6781:9397 with SMTP id j3-20020a170902690300b0015167819397mr19930392plk.137.1646296109520;
        Thu, 03 Mar 2022 00:28:29 -0800 (PST)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id f18-20020a056a00229200b004f3cb984582sm1595313pfe.136.2022.03.03.00.28.28
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 00:28:29 -0800 (PST)
Date:   Thu, 3 Mar 2022 08:28:21 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org
Subject: Questions about qgroup_lock and qgroup_ioctl_lock in enable/disable
 quota
Message-ID: <20220303082821.GA1243@realwakka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi. 

As a newbie, I have some questions about qgroup_ioctl_lock and
qgroup_lock in enable/disable quota.

I'm reading btrfs_quota_enable() in qgroup.c, I'm confused about
qgroup_ioctl_lock. It seems that in the begining of the function, it
checkes fs_info->quota_root with qgroup_ioctl_lock locked. And I feel
like that fs_info->qgroup_ioctl_lock protects fs_info->quota_root. After
that it releases qgroup_ioctl_lock and starts transaction in line 1005.

I understand that there was problem about deadlock between
qgroup_ioctl_lock and the vfs freeze semaphores. And it also lock
qgroup_ioctl_locki again. Just after that, There is code checkes
fs_info->quota_root like below. 

lock qgroup_ioctl_lock => check fs_info->quota_root => unlock
qgroup_ioctl_lock => unlock qgroup_ioctl_lock => start transaction =>
check fs_info->quota_root

I think there is no need to double checks. Is it right?

And the end of the function, It seems that the code as below.

unlock qgroup_ioctl_lock => commit transaction => lock qgroup_ioctl_lock
=> lock qgroup_lock => set fs_info->quota_root => unlock qgroup_lock =>
unlock qgroup_ioctl_lock

For the beginning of the function, there was no qgroup_lock for check
fs_info->quota_root. It should be protected?

I think the typical pattern below works and it's simple for the function.

start transaction => lock qgroup_ioctl_lock => unlock qgroup_ioctl_lock
=> commit transaction

Will there be any problems with this implementation?
