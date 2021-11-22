Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 137C245935D
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Nov 2021 17:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240416AbhKVQuf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Nov 2021 11:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240415AbhKVQue (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Nov 2021 11:50:34 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E61C061714
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Nov 2021 08:47:27 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id 193so18775696qkh.10
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Nov 2021 08:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=66aTTX1ievisSV7kdAcng7UYVWFzSGqn7DrFrZE8OcY=;
        b=SjJs9C4extw126YTlcgS+ZHCJd8kLSiIVEXgDHBVk/fRzH1/0x4fdIZwlgG0877kr6
         tOCvI9AOhDGkxIQ87rd6j+TqqZChLNdH+bYPG6HC+6GyxignyfFPv4K0kl1wdah1+34+
         KYAyrw/T0HleZDIR70OrUTUDmyHSVeLwJD7+ganpgJ0GRANG17OW5BAFOkVokwoCHnvW
         dp9ncfv2d0FSmB471H8M4892sgjNSzxzod4TI/q8gxXg6OVBhh+B8hS+IfIlBC2Z+2RO
         SBGI7ynXsDqmYc/PGZpCP2IUOiGHkpGZB8Bl0+Kxmv+l+jw34hMqcpNqgbcDjYfvd5ij
         ON0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=66aTTX1ievisSV7kdAcng7UYVWFzSGqn7DrFrZE8OcY=;
        b=cwmJgLPI2PLAtRqEpjqsFJZvKfszpZtcCbzjcpXzJ5ovmo/OrimLvalF2qKb+4rW6B
         K/i5PB2wF3MQNoKYcWo/aHXENxEtLBKJtEf1fSQZIO8W0kIcAz+j6wvO26JEJlXJS5f8
         bllYQJOEk8JP2RFQvDERYsuPzEydqHHBMbo+QLo8/rTLqJLYH9GxzWZCBqT2NzTMRz7S
         rcS1GOPa2Z8Jrh6Xh8xge3PJU3KOHorzH3cv0BTEzioKVE9LYsU4cDNC63b0yY0QiFd5
         DTMwKMJM2fH3np3l8tRvLhe+/fUHsF4cXguv5pIWCmKg2KK8wyGcAD5QOccBXX7uz64e
         zDUQ==
X-Gm-Message-State: AOAM532TQqO6s4XtsWmEhEykag3oR92+jmLVOFA5meMDdCv+AgtzGnI4
        PsT4E4KkHNBOZyzcD1QDEcZFsrH+ZitmBQ==
X-Google-Smtp-Source: ABdhPJxT7PaTFkmwX1AgXl/XTmG50djwEJHWvz3GVdiRvH8FWLz4+q+SjtIVPIs0gOqfav8QUZ0M3g==
X-Received: by 2002:a05:620a:199f:: with SMTP id bm31mr49980357qkb.450.1637599647036;
        Mon, 22 Nov 2021 08:47:27 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v12sm4836765qtx.80.2021.11.22.08.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 08:47:26 -0800 (PST)
Date:   Mon, 22 Nov 2021 11:47:25 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: get next entry in tree_search_offset before doing
 checks
Message-ID: <YZvJnQ3SvyWpjDUp@localhost.localdomain>
References: <20211122151646.14235-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122151646.14235-1-nborisov@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 22, 2021 at 05:16:46PM +0200, Nikolay Borisov wrote:
> This is a small optimisation since the currenty 'entry' is already
> checked in the if () {} else if {} construct above the loop. In essence
> the first iteration of the final while loop is redundant. To eliminate
> this extra check simply get the next entry at the beginning of the loop.

You forgot your signed-off-by, but you can add my

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
