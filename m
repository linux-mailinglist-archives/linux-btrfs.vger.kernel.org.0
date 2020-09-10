Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB93826488A
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Sep 2020 16:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730952AbgIJO6w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Sep 2020 10:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730435AbgIJO5J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Sep 2020 10:57:09 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDF7C061756
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Sep 2020 07:57:05 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id p65so5069081qtd.2
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Sep 2020 07:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=QTeYYEW1nXkFfQZvxZl36skmb/9apbNsaT/6q2jN6v4=;
        b=odl+gGWdayD/ANDsXXaEsAlYDTL0gSK7Lstcdsh0pg0DFt+eELWOODayLhaQkl8ZxW
         zK3W7dMWIxxkKIjiISkJUJ56fZU6M2DXtViw+Xwu1Di2sApVfWqEw2PzLUN+dmk+tm8K
         3qBChSZNl9NYzaQNnxV5vPfKkEx+CZ1T7VvnywHpBczXZJcVfPPbEP4s7/6F8AYgsaZN
         8i3pdn1R9mQs19Sglsh7uyEVHJmRUGFdRBhbbW5AQpbl9qbyZ/ANjjFexG5ALyv7+2tS
         TJcug28VdXNS3rUA5RaZNVAM0oOEPySDYrYkElvWayW7Xky6IcC83H6ic+1z1LclEMoC
         6nTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QTeYYEW1nXkFfQZvxZl36skmb/9apbNsaT/6q2jN6v4=;
        b=mOJlci2+3+AywIS4FsfZ9xv6wPXTPMbOZ2ynYTnWh10wUvTMSBSDmf3SyutDl5+Uqs
         OhBnjjn9qIZXs/CMgE2QiLdGr8ok0eGmzAZnYeKcxxrWCJdlFBdamfH8u81goSFq1n0Q
         oefq04+GkfY52eWSzEQlA7avp2iRDILB/OjKe9H9JdakluQN85DcKU/dsSZGmT4sxx2G
         T6ADxCq+tSn/NnfVucmNcuAdBz5fYF5QWhCFto/E/GBPJO5I/YWBPuwnfc06jwRdZHYz
         UpcdMF8uhrytjTfIj6IRifO7zpLcpLUBHZ/4jObHu3IK9o3E7iCnN+u9KaL/Igj0G4DM
         OjZg==
X-Gm-Message-State: AOAM530PGJJc+3GO1dSkRG3BzQ7HbkeqazZ3A0J5VgLjGKd4jO+FAxVi
        tb31hN9L0G2Ggf0tavDbn4P+y5xTVr8q/Qmv
X-Google-Smtp-Source: ABdhPJzPt9cq6hpGxBLvZFHtVEWGy5cs+RYaTgjAsABWks4ys1Gi46k4zbqyKfFSsP6TWd4h6/Bemw==
X-Received: by 2002:ac8:501:: with SMTP id u1mr8572783qtg.261.1599749824004;
        Thu, 10 Sep 2020 07:57:04 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w6sm7384823qti.63.2020.09.10.07.57.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 07:57:03 -0700 (PDT)
Subject: Re: [PATCH 04/10] btrfs: Remove btree_get_extent
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200909094914.29721-1-nborisov@suse.com>
 <20200909094914.29721-5-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <06f236d6-1386-c54a-4634-ec9353946692@toxicpanda.com>
Date:   Thu, 10 Sep 2020 10:57:02 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200909094914.29721-5-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/9/20 5:49 AM, Nikolay Borisov wrote:
> The sole purpose of this function was to satisfy the requirements of
> __do_readpage. Since that function is no longer used to read metadata
> pages the need to keep btree_get_extent around has also disappeared.
> Simply remove it.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
