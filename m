Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D281E220E6B
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jul 2020 15:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbgGONtf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jul 2020 09:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729086AbgGONte (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jul 2020 09:49:34 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554BBC061755
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jul 2020 06:49:34 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a1so2209473ejg.12
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jul 2020 06:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=zeViOh2orgG60XFzN87odItB31rTFkAqEDgeYYexRbU=;
        b=HMX8H/+VSPb0AWs/HTx8iR768QkR1c9tvZftaQegAfNxCbqdkHTEaDz2QXG2OL8cXM
         f/C0NWyHazgGXOivIGw+5/O/ZvvH0J51ycLQKkdYdTlB2OblB+4lXAik/kUvaVnShacb
         7DfNoKobfxFYZpTEHQblKFCKJwEahj6gOe0Zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zeViOh2orgG60XFzN87odItB31rTFkAqEDgeYYexRbU=;
        b=tirdku1w+oGfyaC1oKzRESuQ1GTcakP3UEcEgA5kkouGgtCdPWXOGdZN//uTmgQvVN
         BUVCK5Qdry+DKskkGcailHpvYpaKHWziLXTqPVlc1H9mdg62KvgF6o8xIYNAoWEPIi2K
         7b1ITQz1yIcG3A9cEku5OZnsvIXCFkCB2URMIEbijTOw84KBVHzVvnpjiv7K8TTixDEf
         EQZ9+AUN/q8lAoMFendnkf+4OsN7xD64dmlBZf7WV8QipoFh8t03/y75JxI8ER+VDUpf
         NucBge8kSDhXec6plxta2iU8ENue5+olgbnqxCGmnOT+cw8dHioUaeEtOLAQ9AcjZj4l
         oLww==
X-Gm-Message-State: AOAM530rgOpIjfM0QyyzMBEoJcWzszZuJyGiEgRNfiozFY2YgiSGgU6y
        zWsQxA3TWDFBhPLvVtCWqKbqyw==
X-Google-Smtp-Source: ABdhPJwZnF/x41ajJsrab8AP8TGY2hx8AqSI8JdB3MCIjndyFlBsXgYmbocbNOq1qkY8a0m27vepRQ==
X-Received: by 2002:a17:906:a459:: with SMTP id cb25mr9226346ejb.234.1594820972892;
        Wed, 15 Jul 2020 06:49:32 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:a5b1])
        by smtp.gmail.com with ESMTPSA id e8sm2124878eja.101.2020.07.15.06.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 06:49:32 -0700 (PDT)
Date:   Wed, 15 Jul 2020 14:49:31 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 2/2] btrfs: qgroup: add sysfs interface for debug
Message-ID: <20200715134931.GA2140@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200628050715.60961-3-wqu@suse.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Wenruo,

While testing my pending patches on top of linux-next, I encountered a bug that 
seems related to this patch during btrfs unmount. Specifically, a null pointer 
dereference in kobject_del inside btrfs_sysfs_del_qgroups from close_ctree.

The fix may be as simple as checking if the kobject is initialised, although 
perhaps it should always be initialised in this case, so I'll leave you to work 
out what the real issue is :-)


     RIP: kobject_del+0x1/0x20

     [...]

     Call Trace:
      btrfs_sysfs_del_qgroups+0xa5/0xe0
      close_ctree+0x1cd/0x2c0
      generic_shutdown_super+0x6c/0x100
      kill_anon_super+0x14/0x30
      btrfs_kill_super+0x12/0x20
      deactivate_locked_super+0x36/0x90
      cleanup_mnt+0x12d/0x190
      task_work_run+0x5c/0x90
      __prepare_exit_to_usermode+0x164/0x170
      [...]

Thanks,

Chris
