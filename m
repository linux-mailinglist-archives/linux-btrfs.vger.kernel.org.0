Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9FCF5799
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Nov 2019 21:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730944AbfKHT3F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Nov 2019 14:29:05 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:38195 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729896AbfKHT3F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Nov 2019 14:29:05 -0500
Received: by mail-qv1-f66.google.com with SMTP id q19so2663010qvs.5
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Nov 2019 11:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZODfg6bU4t44gh3dYBYZQLyxNQLx2m3uV+IJAz3Z79A=;
        b=NE3QZBYPdfgnesrLYBlBHseNuI4QVNVEnHbpig1FBAsphLW98FwSKRpQS3HRqh2zY2
         dFPSiDZH4JY0JcQqaALsRmRQFr0ICTmQNEWu9ibT2vVCBR+kLs0J9ykgZHJTSL7oRa0q
         mgxyiJk6qnLFduqIPikNWcjxaj9DfgUzjjA8Rkvt1nktRLoYm+alkATl+g5cOcK1HPUU
         xfVYsoohYHBTs5Cy6vd1+E1fO+WC4Qv3HNVeTvrPovFU7yrh+yJ4MXscMugPSG5TZWAK
         6+BTSdFdXnfrmq6hiLP4TQ1oVyKoQzcdjf068k41PTVvwWk6hWvBH5l9IMXsikPxa6Lv
         6AwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZODfg6bU4t44gh3dYBYZQLyxNQLx2m3uV+IJAz3Z79A=;
        b=BPl9WfFSd/0qLitBgU6yrvs9lIvwv2ZwRidO3sk7VqohbZGIjMld50vMsJF052vZIW
         CHEojZk43zixU6wZA8a3NM5j2SBazNONaxeQAHgDDb4BT5uFTUoccARnuihNxZL4b6K8
         S6szI7ZOne37j//iZSTemLvjZGzQLE5dc30SH19twkbLDDL73S1X9qRR3Zse/ZJVXfHU
         1siPt2vExYG+02jJdhdbm1N16OamNU6qY052HC1jTWO7a4DGfubD/1JiZJsNyqjerH8j
         mIPWm+EzlCyMu1nd71UHNWwin1PyU7rtbnbDDNZsWiEJ2qO4QNvoyAK/t8n17GzW4y3+
         1Vng==
X-Gm-Message-State: APjAAAUjv/XDiss5Fp4yOlu4hsKvJfm9pFeSDk9ctWLca126iu8QmbAl
        uqLVevjLKE0P8id/TCD2K5BXkg==
X-Google-Smtp-Source: APXvYqzKV0BxC5yYwtgSItErNwO+I0BHs+Sb9HeEz2LYX//cG6q1150VPGPjooBt+cLI7EjENQKSGA==
X-Received: by 2002:a0c:c347:: with SMTP id j7mr80971qvi.120.1573241344611;
        Fri, 08 Nov 2019 11:29:04 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1852])
        by smtp.gmail.com with ESMTPSA id k3sm3022267qtf.68.2019.11.08.11.29.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 11:29:03 -0800 (PST)
Date:   Fri, 8 Nov 2019 14:29:02 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 09/22] btrfs: make UUID/debug have its own kobject
Message-ID: <20191108192901.brjadypkjvmkidor@macbook-pro-91.dhcp.thefacebook.com>
References: <cover.1571865774.git.dennis@kernel.org>
 <e3007650cc13578a819e2593cfdcf84db1294d02.1571865774.git.dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3007650cc13578a819e2593cfdcf84db1294d02.1571865774.git.dennis@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 23, 2019 at 06:53:03PM -0400, Dennis Zhou wrote:
> Btrfs only allowed attributes to be exposed in debug/. Let's let other
> groups be created by making debug its own kobject.
> 
> This also makes the per-fs debug options separate from the global
> features mount attributes. This seems to be needed as
> sysfs_create_files() requires const struct attribute * while
> sysfs_create_group() can take struct attribute *. This seems nicer as
> per file system, you'll probably use to_fs_info().
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
