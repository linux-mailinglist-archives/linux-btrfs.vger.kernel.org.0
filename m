Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF3EA16962
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2019 19:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfEGRj0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 May 2019 13:39:26 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40018 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfEGRj0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 May 2019 13:39:26 -0400
Received: by mail-yw1-f67.google.com with SMTP id 18so9087501ywe.7
        for <linux-btrfs@vger.kernel.org>; Tue, 07 May 2019 10:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zrjKMfp7wtSxhVO9VL7O2gtZHvQitlBUK7TX04SouSQ=;
        b=KAVh3Xd95b/aR3s6+xFDlin5tTYR4ktxg2dXpagPOuYlEuEpvwzHwqV14CY/YB/wXc
         uWE0IvXJdTbu5Mm7F7y0V8OvdyRLyQIJbdIid0s8k4hcYGB+qNlAi7l+ii/H26SLqYjE
         slCyUrSsAeV6xbHmF9gw1KaICY8dkgJ8hGYWLQP1gJI8AfR+0rfhuYFvfbFge7NjjuPL
         QuqdnaKi9gzxUUxEwiN+CJT5r1yIDbpCFTshMkGkJoawkBlsBsdGXw3ydn9lyK8ao7Bh
         XFo+Pf3HCxjSkD/VENqySRvvoTSQpdaviCVXc0tR7pNO9h+07Gh8pyw5i3jlSskGSnR2
         5GjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zrjKMfp7wtSxhVO9VL7O2gtZHvQitlBUK7TX04SouSQ=;
        b=cMuTfKDI2VD2BzIH4OFrbJVLyqdjAXQnhzSRvkoPExl9GrNQfXRaY4RbebmhgyuLXi
         BVl6wBwZNcbmlQTIsitK6iAC4k08YBT+RaKZMYZROR03daSwizDRMvDjTQeKJNV4ChvK
         ISPM0Y8ge5Ezm32u1JXGA3qDTNecN+T49t6E4FNlV8Ufo6NHu/oWxWJSqGC+EtgbcVFx
         gIvsjJeXSWJGNyPDYPMzjSmUEiKiybjIcm25mKnh/3uBYfxDiXjb0X0zUv4j6yY+54G0
         jaNlyv8mYzfJvbgFo7EOutiXMlkGiqNMvjgjsHSmqjfboBOzKG8B7zVwS5BkxCmQIT+H
         2jxA==
X-Gm-Message-State: APjAAAW4J1GviGMag0zErFBALYBN8ITX9UxoQMmnJitzcDgVwsBquQ3W
        V4EGe5waWw/1T2AT3FLzWelUvTas3SZDWvcR
X-Google-Smtp-Source: APXvYqyKB5GcyPAFnas1kvPrWuCm3U6gM66g8xEeM/gySuFaMVJi8LyOaVaXDZY5ySFrvqCxQwlyQA==
X-Received: by 2002:a25:5f42:: with SMTP id h2mr20786540ybm.470.1557250765369;
        Tue, 07 May 2019 10:39:25 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::5c09])
        by smtp.gmail.com with ESMTPSA id j83sm3742832ywj.93.2019.05.07.10.39.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 10:39:24 -0700 (PDT)
Date:   Tue, 7 May 2019 13:39:23 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Ordered extent flushing refactor
Message-ID: <20190507173922.3ollxvt327ii7ats@macbook-pro-91.dhcp.thefacebook.com>
References: <20190507071924.17643-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507071924.17643-1-nborisov@suse.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 07, 2019 at 10:19:21AM +0300, Nikolay Borisov wrote:
> Here is v2 of factoring out common code when flushing ordered extent. The main
> change in this version is the switch from inode to btrfs_inode for  function 
> interfaces as per David's feedback. 
> 
> Nikolay Borisov (3):
>   btrfs: Implement btrfs_lock_and_flush_ordered_range
>   btrfs: Use newly introduced btrfs_lock_and_flush_ordered_range
>   btrfs: Always use a cached extent_state in
>     btrfs_lock_and_flush_ordered_range
> 

You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

for the whole series.  Thanks,

Josef
