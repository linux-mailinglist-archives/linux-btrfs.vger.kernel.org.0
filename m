Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C411B2CF492
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Dec 2020 20:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgLDTMl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Dec 2020 14:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgLDTMl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Dec 2020 14:12:41 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7D7C061A52
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Dec 2020 11:11:55 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id z9so4737422qtn.4
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Dec 2020 11:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=+nqfPRnX1Qa/oeSPRGAhEycfrnBcG2rqZ9IiwnVKWcw=;
        b=aEh+0O3ve4C9rFf6inPBYTiKT44p9goJIR17mGhmgr9veYZsR1aifurXtsSsZXj266
         LpbzpYWaNGvyGQmhlctS4nn73738UIg5bF5sSx+N6M87u85ze3HhgDKoXZ4INnVfPMKj
         WL0JHanQieGu4DnQ1Dgvwal6nPt3WhiCNiBLKJpT93GSKfmid5sc4eeDGAxqPdQNwvLF
         DvAbgqCjXSO5odBH3vCEKG1W4nxaC1khmW3LXcX6BSgNQqSqOmZbN/kE3YzQYVVLcQqC
         Weuh23XXDyBfcnMlO3skh4Td6BjdlqWkrCUcKrQrReDgEj7MAGboY3LE2je7sFNU6SnY
         Lvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+nqfPRnX1Qa/oeSPRGAhEycfrnBcG2rqZ9IiwnVKWcw=;
        b=BWiZv8jQ6yBI8i8zz9R86hbv6pLOdB30EpZgOWH0GijtyCfrtLE2OM0rG4VtYaeLJF
         zIhpueJmTrcmfj+lX2mX9SNoXy17xBfLjyVJqcsBjzf9AZ3uhKXCJDiGncZzKrdoKTXR
         o6QrCpidNwdihKWd/mtVJV6owNaUThiAgL5K4L/xP176JAIOpTsmAgStpJroqv1xUDn8
         W0VLsl69MO/dsDasp/SARnTulkMpIfM3YNY+wxdDmEXCBapxxwYFGttQfl71rgArkFrO
         AQr5UDfIW+8xFmmJFEtrywDRhdQOv1EOUZfwv0bxO9DMZR0/1AXGu0AJLx2bx/MYtAka
         heLA==
X-Gm-Message-State: AOAM531DOBhdyQ/ZVeXiV0eJ07ReGzfssV5jeq9n8EuASwynMdhihUal
        EjWeS+rRnkyYVU3fKuCyI0/7ZGTuGAnp+Oaq
X-Google-Smtp-Source: ABdhPJxa47PBKmAM6/2VA2/gu1P+4vZfuF4sdFfeng1PpS7tWolE/ayWEdK8PYPjZBqHhegurB36+g==
X-Received: by 2002:ac8:5786:: with SMTP id v6mr11074064qta.268.1607109113838;
        Fri, 04 Dec 2020 11:11:53 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o9sm5962464qko.53.2020.12.04.11.11.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Dec 2020 11:11:53 -0800 (PST)
Subject: Re: [PATCH] btrfs: remove recalc_thresholds from free space ops
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20201203161838.29392-1-dsterba@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <0fc0d0cc-9e9d-f401-b8ff-3439b6d04751@toxicpanda.com>
Date:   Fri, 4 Dec 2020 14:11:52 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201203161838.29392-1-dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/3/20 11:18 AM, David Sterba wrote:
> After removing the inode number cache that was using the free space
> cache code, we can remove at least the recalc_thresholds callback from
> the ops. Both code and tests use the same callback function. It's moved
> before its first use.
> 
> The use_bitmaps callback is still needed by tests to create some
> extents/bitmap setup.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

This didn't apply cleanly to misc-next as of right now, I assume the inode cache 
removal patches are in a topic branch?  Anyway I checked it, you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

But I couldn't do my normal checks.  Thanks,

Josef
