Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4C927276A
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 16:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbgIUOfg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 10:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727775AbgIUOfd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 10:35:33 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F67C061755
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Sep 2020 07:35:33 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id o5so15170203qke.12
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Sep 2020 07:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=+1Jyo6ZDCsQx4GG3FiRFZBXG250AS9nyE0vZAWZDr8A=;
        b=PYHPbLvWRXndX+z+eBYmkUKcQfl1hjentPCeic0bFjGe6NfNnZCjuddGJsjvlVTsyX
         IxPMDys0O/g2tKHx0usMvB/rPMjoXDoGacTIRYXbjHfyM8grro5dBmUrqLXNwCFu9XBX
         52s29UtLH9zz0xHDdM1KhHyF7oZmrno0wUjMpI1IiPj+wxrOQ/B4V73wDIlEN0+ITqfh
         gulRR6k9AaH0iLeXXGxA4QMziQ+hf8ADom4YXjUSRzgiHYam96pnTASRr7+ljLZLFQEQ
         Yv3aTRvgMVB7FkkF91Bbm522TBr7m0fq+YVqjoOUmVma/AUfxhFiShnJr2Iz3m72dpIL
         iCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+1Jyo6ZDCsQx4GG3FiRFZBXG250AS9nyE0vZAWZDr8A=;
        b=i+4+0w4DzdzSurW3L/73UWPTOXwBrQGYawlPtapqtROOFh9Ww56wdYNHg5S4qKYMHg
         V8vjIcUi2pRVHWlKuiQUR1ibajxCCkUQSdwidshsMcxePzZh5DQ6mwcsGUosK7lrjlV5
         8hOKTGqwkLzo9N068SowtQL/JkvG3v3jdhAN8pL8ezpiXmJjWH3qPJPgt5up/bhJZoa8
         k4GWR52ZtvKBMDeKg++prpthOgv1MIUVdywmKcgwBwGX5I2wAFaKrVqLYSrawOxYzYOb
         B69ihxOx9bIyWCP7ETRrnE5H1gG80FXcjuEaScit3lfgu0X1DkYhqcNKFwb1CKyxenSF
         V+2Q==
X-Gm-Message-State: AOAM531qgQvZ/CRownBoMvUlOV9en1XnihbUBl3L+MeQ1BIN5vkr4+vH
        TJkAzu9lpaLEx7yLrXhDdMY+K6++VVXnNAii
X-Google-Smtp-Source: ABdhPJy0uVwWUOtcCge1OIyae/RMHI8w8kUyTkd6Jw+lBuBAH0EqK3uRFtk/8F9y0OBZUIQ4z0wGpQ==
X-Received: by 2002:a37:68c7:: with SMTP id d190mr57619qkc.127.1600698932871;
        Mon, 21 Sep 2020 07:35:32 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f2sm1011097qkk.80.2020.09.21.07.35.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 07:35:32 -0700 (PDT)
Subject: Re: [PATCH v3 1/4] btrfs: support remount of ro fs with free space
 tree
To:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1600282812.git.boris@bur.io>
 <1d0cca6ce1f67484c6b7ef591e264c04ca740c96.1600282812.git.boris@bur.io>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <eb59aeaa-0193-6582-9660-6db0cf1b2ef0@toxicpanda.com>
Date:   Mon, 21 Sep 2020 10:35:31 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <1d0cca6ce1f67484c6b7ef591e264c04ca740c96.1600282812.git.boris@bur.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/17/20 2:13 PM, Boris Burkov wrote:
> When a user attempts to remount a btrfs filesystem with
> 'mount -o remount,space_cache=v2', that operation silently succeeds.
> Unfortunately, this is misleading, because the remount does not create
> the free space tree. /proc/mounts will incorrectly show space_cache=v2,
> but on the next mount, the file system will revert to the old
> space_cache.
> 
> For now, we handle only the easier case, where the existing mount is
> read-only and the new mount is read-write. In that case, we can create
> the free space tree without contending with the block groups changing
> as we go. If the remount is ro->ro, rw->ro, or rw->rw, we will not
> create the free space tree, and print a warning to dmesg so that this
> failure is more visible.
> 
> References: https://github.com/btrfs/btrfs-todo/issues/5
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
