Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5CE6B4022
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Mar 2023 14:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjCJNUd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Mar 2023 08:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjCJNUb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Mar 2023 08:20:31 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48AC13D65
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Mar 2023 05:20:27 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id f11so4994697wrv.8
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Mar 2023 05:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678454426;
        h=content-transfer-encoding:mime-version:user-agent:date:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LPH8e4a5b2r7j00THOIeAXUmTti4+Hio3KM5lQVTROU=;
        b=WrnH5+bP/Npse5CestEItXYHqui0ZgVzrs0/UoMmclRw+GGkMgPFYKM/xbwqsh72R1
         RZpYchrPI8ja+uT3xufd/jGAJzi9QkNIJiB3WMUOIhRC1h/gd6ZR50DAPYP8r7bluEXW
         eJvqH7Ymomcayj+HRO9V1rqIFnvE8pleGFr7gvGRK8HqX274k25buxx/SMkiIjbr3Q8W
         YJHkecNWm+gW7HGSBMQa0KaMzEm8nwXSgLwq5cODoTqO6OD3aPyUdhlpVuEyTEtsPU7z
         5P7tqb4z6Vk/n0WOxS8ygup3DONCv4oj1UBFRIG19Kfo+9Vgze9bwgD2xsNvlfqs2A4A
         by+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678454426;
        h=content-transfer-encoding:mime-version:user-agent:date:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPH8e4a5b2r7j00THOIeAXUmTti4+Hio3KM5lQVTROU=;
        b=sr0b6OE8NFZJICUkKor57QvkfcjdTKH5DYa5T1/7977/OLXbTxAwClx9zQQA1bN3az
         Q8TxsAJWwwvXT9PbSKXWFIrb1GavvvqnhMrOm82Cuym8QO2CnqmvbQb7QfGJJwAyeaRn
         8QgFJC16T3S/nMNd3VXN6wlj/a3IUsTnhChBvB5vDnDTaWQKHKwvlJVJzkNn94Qg6q37
         5vZw5xTA2HlLguAf56aqVDbQ9/R520oBEluSLacOuNslpIJxzJvuw7+A/hxx2fzk1Qp7
         vU3MgSn1l9O/SZ5k9xHFavc4GNELGhoHZF2AOsiGAJInM+bCAr7BFBsF74EThtaX4kfu
         wvFQ==
X-Gm-Message-State: AO0yUKXNQLBUJ6Db7ywGnSL2H1x2/Xpx8DL64pO+7LVIX0T0lq1yBjfq
        sVeWfN10nVmAImv5jK4p7K4+/HBMqQXE4s0FL0I=
X-Google-Smtp-Source: AK7set/+CdIbNquEBTIqLx8m4F1vDyKb7P6cQ+ZVoyWPXHByST+7RawWjbvpdvWixzxqGj0UG2WnNw==
X-Received: by 2002:a5d:4ad0:0:b0:2c7:da1:4694 with SMTP id y16-20020a5d4ad0000000b002c70da14694mr15669985wrs.62.1678454426263;
        Fri, 10 Mar 2023 05:20:26 -0800 (PST)
Received: from [192.168.1.94] (190.44.136.88.rev.sfr.net. [88.136.44.190])
        by smtp.gmail.com with ESMTPSA id p6-20020a5d4e06000000b002c70851bfcasm2126401wrt.28.2023.03.10.05.20.25
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 05:20:25 -0800 (PST)
Message-ID: <4508efb976dddf7ca5be98f742de2db4db677ab2.camel@gmail.com>
Subject: Utility btrfs-diff-go confused by btrfs-send output - a file isn't
 changed but is associated with an UPDATE_EXTENT command
From:   Michael Bideau <mica.devel@gmail.com>
To:     linux-btrfs@vger.kernel.org
Date:   Fri, 10 Mar 2023 14:20:24 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1+deb11u1 
MIME-Version: 1.0
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

Hi all,

First, thank you for the btrfs FS and all your work.
This is my first interaction with this community and I'll try to communicate to
my best.

I am developing 'btrfs-diff-go' (https://github.com/mbideau/btrfs-diff-go), an
utility that analyse the output stream of a 'btrfs-send' command, and produce an
output like the 'diff' utility to visualise which files/directories have changed
(and how) between two btrfs subvolumes/snapshots.

While I was testing it I encountered an issue: some files were detected as
changed, when they where actually not (no difference with 'diff' nor
'sha256sum').
With my program's debug log I found out that it was related with the
UPDATE_EXTENT command, always interpreted as a file change.
Digging into it I ended up in the 'btrfs-send' source code and found out that
this command was used when data actually has changed I guess (in function
'send_extent_data'
https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git/tree/fs/btrfs/send.c#n5682
), but also for "holes" (in function 'send_hole'
https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git/tree/fs/btrfs/send.c#n5456
).
I couldn't debug further nor check myself (according to my current free time and
knowledge), but as I read the code I understand that the function
'send_update_extent' always send a path, and maybe that path is wrong or should
be empty when sending a "hole" ?

Could you please help me:
- to reproduce a simple test case that send the UPDATE_EXTENT command for a real
file change and for a hole ? This way I could acknowledge properly the issue in
my program 'btrfs-diff-go', and later on the fix.
- to understand what's going on ... Is a "hole" an actual file change even no
data has changed in that file, and if so, how I am supposed to filter them out
to only report real data changes to match 'diff' output ?
- to report this as a bug if you think it is one ?

See also:
- btrfs-progs sending UPDATE_EXTENT command:
https://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git/tree/libbtrfs/send-stream.c#n455
- btrsf-progs receiving UPDATE_EXTENT command:
https://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git/tree/cmds/receive.c#n986

Thanks in advance for your time and answers.

Best regards,
Michael Bideau [France]

