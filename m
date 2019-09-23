Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96026BB70C
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2019 16:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437697AbfIWOqq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Sep 2019 10:46:46 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42690 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405913AbfIWOqq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Sep 2019 10:46:46 -0400
Received: by mail-qk1-f196.google.com with SMTP id f16so15652608qkl.9
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Sep 2019 07:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2+umoX3ahlSwEmyIidMwBDc6dhxQqGeediSyqGQ2Epg=;
        b=2PJZzuIbNMnw4kxolIDxt7HBK7UMaIUKyydqxGIKtH/8bTmTyxdTtK9YWICU4tYUZy
         1hH+Bi07PzaCyRoWoOIiu1ibSmn7Iell+jxWUxjKjsAoO0Q4uB8+avU2qWBL98L/gxR0
         OWvWBa7U3CE8xzhDRs+8S3fXjPsXtd/zxKh+QMXae5wVJhtnhIX2T+BLNdPPoDdOktUx
         3U0vd38NR3/WWpt5lRIhbABEc/98awQQOiprlRaK3qh5QzDg3puVxql3tXXuMDnQRkmE
         lUaFIJiYahYl2MC17RQ+szCPBiiS9LmcWtFJ9zmpoTQgTZXcps4rtVYH3WkjoLyIPkaB
         ooKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2+umoX3ahlSwEmyIidMwBDc6dhxQqGeediSyqGQ2Epg=;
        b=nkMi/FP/yOZC9w1p9g68oLcRF9A8tCnKCUmAkB2VbKbdetWVlq1bAt/SRMpnzrvtA5
         PyjUgeWWeepVYLBW16hA/7AnSXPn5IVLmdeVbt1iHTKUrictoO2hiASzzJM6sBN28dow
         2BCU7I0KbOqa9IWBZKvb1FDL+pd4NoyehtCAAWEO7Wf1y0OivSdrrqU+0KsJCjo16h2n
         Y3uC8/oMvtWDGhTrEYE8EkFOBoawXDLB82qzLIjNNxrRu0632wGRK1di++7w8Ny/kWgj
         S61JnXkVDdRG+7TvDT5LoPde+UWQBHnRBF/2hAtO69iLLhwiROsFMsyV3YwpKKF3/KAM
         cf/A==
X-Gm-Message-State: APjAAAXP/POjII/+t0n2WEqeQ/e6LAZvwnq6jpkSRcc2wFk20e2E0lB4
        6WLVXjW3yboCh9O+NrX5mvm0Rg==
X-Google-Smtp-Source: APXvYqzJ2B7NZl7YFDWYNdGpllsXFYKFwjDZzIPvxO0K3d7M0l3eXtYbfZhzFFLr6s1jhftxU+fmYg==
X-Received: by 2002:a37:a4d:: with SMTP id 74mr192725qkk.90.1569250003707;
        Mon, 23 Sep 2019 07:46:43 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::2fb0])
        by smtp.gmail.com with ESMTPSA id v5sm7159622qtk.66.2019.09.23.07.46.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 07:46:42 -0700 (PDT)
Date:   Mon, 23 Sep 2019 10:46:40 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 0/9][V3] btrfs: break up extent_io.c a little bit
Message-ID: <20190923144639.bakz5f4mvoiibc6g@macbook-pro-91.dhcp.thefacebook.com>
References: <20190923140525.14246-1-josef@toxicpanda.com>
 <20190923143219.GA2751@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923143219.GA2751@twin.jikos.cz>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 23, 2019 at 04:32:19PM +0200, David Sterba wrote:
> On Mon, Sep 23, 2019 at 10:05:16AM -0400, Josef Bacik wrote:
> > v1->v2:
> > - renamed find_delalloc_range to btrfs_find_delalloc_range for now.
> 
> The series is V3, what changed V2->V3?

Wtf, I must not have saved.  It should have had

v2->v3:
- Fix build errors with CONFIG_BTRFS_DEBUG turned on.

Thanks,

Josef
