Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 569CEB03C6
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 20:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbfIKSme (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 14:42:34 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39754 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbfIKSme (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 14:42:34 -0400
Received: by mail-qk1-f193.google.com with SMTP id 4so21832504qki.6
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2019 11:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K39UN7J0CZJeSxYvraU6LdD7Jz5Wm3XdCY6+tL3u6do=;
        b=QRKZfpZwzIM8SVzYLv8CoOT4zNQOIlOIzcZD4lcBvLH8vZH+sTcmzpuhLghLmZeo1g
         6BZ7e+g4HqIFQplkuw2rvr3vAe7ABmzJa+tGa6wapOhu6/YYsi5cOM+ASmQrKZpCcqyQ
         8LWi6Z5A3HBIkGoXeuqq9B7laYDGbGRbQ7pQYIb/DLzMNqURHFNlg5X4VRYGXrMzuIbs
         3cVwRafah5FoDDlTcC69L/XgffPwSo5dMkTGWwZ6XN/o81F1lIPJD2IxSKvjBj9Bttye
         P+Q6Cv/MW6+rZYoCUda/vP//6uXiJv+pXR40YluDEHmacNeHTglYJU54GJHSyK9VI9QQ
         FvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K39UN7J0CZJeSxYvraU6LdD7Jz5Wm3XdCY6+tL3u6do=;
        b=K5u/v978Afm/+eVn4iSJP8hvGoWRWpZb5kvXgVUr8M6xOH0ePUUHeAz8fdk6hYMnvm
         gG+yIhgwqfjxsOst+Fd7CPo6ZVWWDkOJQNlUd2XiwHDXj/07w/IpmB57Rf7pMS+lbGwo
         Nbub9pOJIBSC/ex6lZqbpcBKdu4xvZ5a7IQiTkFWliIHgduib46XirLu13TPm5cXfyTz
         ffFZTE2cX0Mk6bqwiWEouZ7M58y0oflfv6iyLg1yKNZIPOxLZAPTzseOHHs0ojGWZqMJ
         ypXuiGy5PlfLkqnTJaRwsn29nZyxGUtQSsWfL3g2ISNLvaHgXHUQe11FE2mxNAYL9YZs
         BbKQ==
X-Gm-Message-State: APjAAAUqC67ThZSoSBrfTDdj+aSOdAiJjSyP0Vl0CXtYzZAxwbBGJSum
        l2OKeRxg+d7Tl2efz0bT796OMw==
X-Google-Smtp-Source: APXvYqy32VIj6gfYHrQa7K007YDKFCi0mVSMzonBabDDSZD12WAeZaWp9aZWhr/uEsw0rC3Goqvv4w==
X-Received: by 2002:ae9:ee1a:: with SMTP id i26mr36700096qkg.112.1568227353096;
        Wed, 11 Sep 2019 11:42:33 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::87bd])
        by smtp.gmail.com with ESMTPSA id h10sm13813973qtk.18.2019.09.11.11.42.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 11:42:32 -0700 (PDT)
Date:   Wed, 11 Sep 2019 14:42:31 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC v2 0/2]  readmirror feature
Message-ID: <20190911184229.gl7tu3igtuuepcvm@macbook-pro-91.dhcp.thefacebook.com>
References: <20190826090438.7044-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826090438.7044-1-anand.jain@oracle.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 26, 2019 at 05:04:36PM +0800, Anand Jain wrote:
> Function call chain  __btrfs_map_block()->find_live_mirror() uses
> thread pid to determine the %mirror_num when the mirror_num=0.
> 
> This patch introduces a framework so that we can add policies to determine
> the %mirror_num. And also adds the devid as the readmirror policy.
> 
> The new property is stored as an item in the device tree as show below.
>     (BTRFS_READMIRROR_OBJECTID, BTRFS_PERSISTENT_ITEM_KEY, devid)
> 
> To be able to set and get this new property also introduces new ioctls
> BTRFS_IOC_GET_READMIRROR and BTRFS_IOC_SET_READMIRROR. The ioctl argument
> is defined as
>         struct btrfs_ioctl_readmirror_args {
>                 __u64 type; /* RW */
>                 __u64 device_bitmap; /* RW */
>         }
> 
> An usage example as follows:
>         btrfs property set /btrfs readmirror devid:1,3
>         btrfs property get /btrfs readmirror
>           readmirror devid:1 3
>         btrfs property set /btrfs readmirror ""
>         btrfs property get /btrfs readmirror
>           readmirror default
> 
> This patchset has been tested completely, however marked as RFC for the 
> following reasons and comments on them (or any other) are appreciated as
> usual.
>  . The new objectid is defined as
>       #define BTRFS_READMIRROR_OBJECTID -1ULL
>    Need consent we are fine to use this value, and with this value it
>    shall be placed just before the DEV_STATS_OBJECTID item which is more
>    frequently used only during the device errors.
> 
> .  I am using a u64 bitmap to represent the devices id, so the max device
>    id that we could represent is 63, its a kind of limitation which should
>    be addressed before integration, I wonder if there is any suggestion?
>    Kindly note that, multiple ioctls with each time representing a set of
>    device(s) is not a choice because we need to make sure the readmirror
>    changes happens in a commit transaction.
> 
> v1->RFC v2:
>   . Property is stored as a dev-tree item instead of root inode extended
>     attribute.
>   . Rename BTRFS_DEV_STATE_READ_OPRIMIZED to BTRFS_DEV_STATE_READ_PREFERRED.
>   . Changed format specifier from devid1,2,3.. to devid:1,2,3..
> 
> RFC->v1:
>   Drops pid as one of the readmirror policy choices and as usual remains
>   as default. And when the devid is reset the readmirror policy falls back
>   to pid.
>   Drops the mount -o readmirror idea, it can be added at a later point of
>   time.
>   Property now accepts more than 1 devid as readmirror device. As shown
>   in the example above.
> 

This is a lot of infrastructure to just change which mirror we read to based on
some arbitrary user policy.  I assume this is to solve the case where you have
slow and fast disks, so you can always read from the fast disk?  And then it's
only used in RAID1, so the very narrow usecase of having a RAID1 setup with a
SSD and a normal disk?  I'm not seeing a point to this much code for one
particular obscure setup.  Thanks,

Josef
