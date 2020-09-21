Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A320D27292C
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 16:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgIUOyQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 10:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgIUOyQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 10:54:16 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20314C061755
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Sep 2020 07:54:16 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id c18so12547878qtw.5
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Sep 2020 07:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=+ipezkVIVDcQp2N6H4eAaev13jvvE/w8XKeShkMcb6M=;
        b=i3+lpnp+hlFKgnyJOR5r5E8T7Hr2aHQkpgv7koB41J/CEzfh0kfVNGk73z3iv4fqQj
         5tL4qD8tC0VqlvUKmF17R9ad7WWB/vyq1WQMM32DtlG2TyfUz+JYh8q9xkAj181Re5HJ
         Yb+/I5JHS2e9nGoUTQyAzSO1aI6rYm4EtvlDpB7QSmy/drSZMs1aIFJ4d4TdAvGyqa+U
         e53j86Q9dPfzODqH2jqc3miFpjrc5fr2xohygEGMUCPG6qzGfOsSn+AH6ioBp2OkFbNu
         UG8GEMtyWUcC1VXSemjH1sEqGakBQagk3BWzwOFL9sqBxR+avehrWLby7f3iTqjCU1aw
         d9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+ipezkVIVDcQp2N6H4eAaev13jvvE/w8XKeShkMcb6M=;
        b=LvArJMed1IsdZdsfN5mypT7Dku2L6QeHD4rTnDO4B9ccTi5prNaskB2N5JcPi2PsIi
         dlcwhqNiy2bwm0m5htoMb0nlMBJ9JpL9I7riJRiyGUd5PS9QXw2VIfiK9wBjFyqtwdHy
         Gpq9aBTSrH2K8qfAtg6BmoABSp3jE+MywItiS0uFsOLy+HuOJaxTy3IRhRqeHLMMOjxO
         OJNN7UM/rsfKVmHJ2BlQRr99yTgmVY656DsLD0JKYt1wT22OLmygx8C79GP3XG9ZP6Cy
         FNmdt2PN1Mohu+d1b7QrmkLe7zLyu353A+uQhWf5ARkSR+XFwFePtAvDaZgEE6G2D3ja
         XUOg==
X-Gm-Message-State: AOAM532NVvdIiyp/rfNzxfbhQOBKY6cOfti3TlUzwB0ErBfE9I0dwU11
        JW994/8F6IMhT+jjQb5xgu8WjA==
X-Google-Smtp-Source: ABdhPJwhUg8hqaS8QlUG88XtI4jGVW7CLkHEeuRoLg+7J7jK/O5/Kd7NDEVlhX/kRgAzQh+e4kWtlQ==
X-Received: by 2002:ac8:1604:: with SMTP id p4mr1170238qtj.309.1600700055301;
        Mon, 21 Sep 2020 07:54:15 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s15sm9257221qkj.21.2020.09.21.07.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 07:54:14 -0700 (PDT)
Subject: Re: [PATCH v3 3/4] btrfs: remove free space items when creating free
 space tree
To:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1600282812.git.boris@bur.io>
 <e8c4e0e500f1f19787c84cf8fb7a54063f0fedf0.1600282812.git.boris@bur.io>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <fd48f907-7913-57c0-6ff1-d2d62ee08dbb@toxicpanda.com>
Date:   Mon, 21 Sep 2020 10:54:12 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <e8c4e0e500f1f19787c84cf8fb7a54063f0fedf0.1600282812.git.boris@bur.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/17/20 2:13 PM, Boris Burkov wrote:
> When the file system transitions from space cache v1 to v2 it removes
> the old cached data, but does not remove the FREE_SPACE items nor the
> free space inodes they point to. This doesn't cause any issues besides
> being a bit inefficient, since these items no longer do anything useful.
> 
> To fix it, as part of populating the free space tree, destroy each block
> group's free space item and free space inode. This code is lifted from
> the existing code for removing them when removing the block group.
> 
> References: https://github.com/btrfs/btrfs-todo/issues/5
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
