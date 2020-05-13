Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBCB41D1276
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 May 2020 14:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732006AbgEMMQb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 May 2020 08:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731675AbgEMMQb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 May 2020 08:16:31 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C636DC061A0C
        for <linux-btrfs@vger.kernel.org>; Wed, 13 May 2020 05:16:30 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id m12so21397307wmc.0
        for <linux-btrfs@vger.kernel.org>; Wed, 13 May 2020 05:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=stqQD7OeRevl8LVGu4ZtQhuagDuL+Z/Oyh3THNwpoJI=;
        b=mKSQQK/82sqle6+gKHxyqBVb3BlWFZt21UGWow1uMDurCMviQbUikre6eFO4LWp0gO
         h8RdhvKEtA0kA01kIuO/UgB6oB5zOJcpTT4/06hRYy7jdfAKkjkFccJcItw8thtLS2HC
         Mfc74d5Yr/BHp/SBgJMeDG5c8xcORVnDYiob2oacGeq4Lj8NVPDSY1rKW/j678RTSYQz
         UkhLm9BOtXqdgcok7n8JEJiHeJbRDD24wJWfNIXLGDTVAaWDYFKnSvjPh4T/RfCdAhZp
         9N8zNPmeBKukd9+vt5Td5wcfPgrxtkgQiEdz5uha8+zMhAUnxS2J1YdOYNvJZAGt+0No
         Ugvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=stqQD7OeRevl8LVGu4ZtQhuagDuL+Z/Oyh3THNwpoJI=;
        b=lalvo4hLcghmp1M69bR/xLa7iEUo2mb+h2OUcXLuu+jId6C2sMz+xRmoRG+aefeZLH
         WCRvKy8Bju3LwtoB6MoSED7m8zIpb2HoIBvNwO/udIN32o19CvokexGC4Z128D7XFJaa
         Ku1rQ2OGEdqPNB6VCcGMVnwbjLjTlLSlti/Yl94IY4gw2atxOIUE/fHwP9qy64GdY/5i
         5nGNN8ZP7VU+UN+Y4K430ZD6KymJUQGQYnwIkhT2cmn53atN7DhKZ0BCtEHEtvD5pS+4
         zWruwcgDxjgUI2AmtD3kshDr9JI3Ifs0oC3Y2HxiMIll3jX66dWEYv8nHZ21qd+akOKh
         lO0w==
X-Gm-Message-State: AGi0PuYUOVBPcmETECC/EQemi9w3L/YWFA4HgZSCHnesu8W539gVqbPT
        OIUHQ/wRq7kwpG2IbYd459WRbAxp
X-Google-Smtp-Source: APiQypLTr7X77BcGNxfwqVHn30KtJ6ER6vN4i4DcyCLiXERBmYCmhCKEuwE7yXqxayz/D6AF8x4l1Q==
X-Received: by 2002:a1c:59c3:: with SMTP id n186mr41438114wmb.24.1589372189124;
        Wed, 13 May 2020 05:16:29 -0700 (PDT)
Received: from [192.168.168.63] (dslb-002-202-217-216.002.202.pools.vodafone-ip.de. [2.202.217.216])
        by smtp.gmail.com with ESMTPSA id g9sm17720299wru.7.2020.05.13.05.16.28
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 05:16:28 -0700 (PDT)
To:     linux-btrfs@vger.kernel.org
From:   =?UTF-8?Q?Ren=c3=a9_Fricke-M=c3=bcller?= <rene.fricke94@gmail.com>
Subject: Error when using btrfs subvolume snapshot & send | receive
Message-ID: <57021127-01ea-6533-6de6-56c4f22c4a5b@gmail.com>
Date:   Wed, 13 May 2020 14:16:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I have some trouble using btrfs snapshots on Ubuntu 19.10.

I am creating snapshots of my /-subvolume and use send | receive for 
incremental transferring. Sometimes I get errors like "ERROR: cannot 
open /media/Backup/OS/snapshots/snap_2020-05-13_11:39/o13170-19818-0: No 
such file or directory"

When I look deeper with the -v option, it seems like btrfs is creating a 
folder or something, moves it and then tries to rename the original folder.

The error occures on different devices, but only when I make snapshots 
of the root of my os subvolume. The error occures only from time to time 
(perhaps every 5th to 15th snapshot) the only solution to send a new 
snapshot complete and then send incremental snapshots.

I tried different kernels:
Currently I am using 5.3.0-51-generic on one device but also tried 5.5 
and 5.6.11.

I found this topic on github, where some people have the same errors. 
(but I am using an own script, not that program)

https://github.com/digint/btrbk/issues/223 
<https://github.com/digint/btrbk/issues/223>


Can you confirm this error and/or help me?


Kind Regards

René
