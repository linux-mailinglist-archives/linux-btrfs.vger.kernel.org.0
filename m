Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0CFC1153E8
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 16:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfLFPJY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 10:09:24 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35115 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfLFPJY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 10:09:24 -0500
Received: by mail-qk1-f195.google.com with SMTP id v23so6764536qkg.2
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 07:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xu0yrBK9q4xW++w8GJnz1oPOlixvMe5hB1e4B0MXYdA=;
        b=Ns/mogHnDfQwaURzHnHg+A0T4QmUBJDofbQ211aImzXJ8XjMY+jkHYgDSdl9xRtRdO
         4BU7E+d0r14mmGPElzThFHma7ugCRQGktVC1aIMSy8ZLreC0b4dn6QoyrGcLezpbru57
         ksAZFG65d4WpHAghLh5FN5cb8mIg3XW5Vo08E1q0lEJ4t+m9C5oVdLT6F/NpnEtyRBGy
         R69iJYiXqOrRUAZ4Q5loxekMyZNwqZ/gZOQ6WmDLIBcjdEyXpILpeJvWe279zYt2QD+a
         fka+O0aCXX6FLeScPVxv8ejudMHZgIRU3Fr/wNLBt+GaQxFowCGdDmBszwWt6E+xiOow
         mGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xu0yrBK9q4xW++w8GJnz1oPOlixvMe5hB1e4B0MXYdA=;
        b=SyJjtebJ3bKxjoZso5q3AOqcAPY7CRpOBF7jLxoIXFbp5Tg1fR7eSezzUJ80P4zCE3
         NXUTTFh8RTAA89Vxt78nQTkS2Orrp7iwY8akUgDN+OCUxH/cy2fr6UalC/xYfrodx7mE
         oAJYN3o+HmBIKXFVnLsAVwwOfVmHa4RDADKDxwRmB3nAtuBVpkD7NZlnIW4YhCyl9D9V
         GjgeCnCLfj/asEr7XzEQlcCxezYkG8OH0akGRJmz59ictCJ8KHA5ibrek5St5D2KfUbj
         /Lzk1jE2oGuNGAFau4WYXHcu56Nh0iDbPiDd6nvNLCHRExZLEZiXwFaUyHAOaR5sknrA
         DMKw==
X-Gm-Message-State: APjAAAVrgJgPJslNFwQn/ueVl2AccileoWxnUEjDcN/go38xRb6CsC0G
        R46hWXRN9XxQJjZEPXkOFOIxjUeXctkwXg==
X-Google-Smtp-Source: APXvYqyGcYzPZWDJsxaH6jklfALiRKvRibPv6plzHpgHMLVMYKBS/0gOG17k0wuV3GQXHOt5wyuudg==
X-Received: by 2002:a37:a40d:: with SMTP id n13mr8079598qke.167.1575644963672;
        Fri, 06 Dec 2019 07:09:23 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id v125sm2326244qka.47.2019.12.06.07.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 07:09:22 -0800 (PST)
Date:   Fri, 6 Dec 2019 10:09:21 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] btrfs: use simple_dir_inode_operations for placeholder
 subvolume directory
Message-ID: <20191206150921.7npbjlbbgktxgazl@jbacik-mbp>
References: <3cc2030c10bcef05fe39f0fe2e8cdfb61c6c0faf.1575570955.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cc2030c10bcef05fe39f0fe2e8cdfb61c6c0faf.1575570955.git.osandov@fb.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 05, 2019 at 10:36:04AM -0800, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> When you snapshot a subvolume containing a subvolume, you get a
> placeholder directory where the subvolume would be. These directories
> have their own btrfs_dir_ro_inode_operations.
> 
> Al pointed out [1] that these directories can use simple_lookup()
> instead of btrfs_lookup(), as they are always empty. Furthermore, they
> can use the default generic_permission() instead of btrfs_permission();
> the additional checks in the latter don't matter because we can't write
> to the directory anyways. Finally, they can use the default
> generic_update_time() instead of btrfs_update_time(), as the inode
> doesn't exist on disk and doesn't need any special handling.
> 
> All together, this means that we can get rid of
> btrfs_dir_ro_inode_operations and use simple_dir_inode_operations
> instead.
> 
> 1: https://lore.kernel.org/linux-btrfs/20190929052934.GY26530@ZenIV.linux.org.uk/
> 
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
