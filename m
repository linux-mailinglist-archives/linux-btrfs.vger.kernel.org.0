Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCC9BD3E4
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 22:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633452AbfIXUz1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 16:55:27 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40675 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbfIXUz0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 16:55:26 -0400
Received: by mail-qk1-f195.google.com with SMTP id y144so3282047qkb.7
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2019 13:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uv0Vms7Q7E4XCYJvaSUg6s0TOQG3cm3Fjf8svgA07Ak=;
        b=j80HmSNPzHZWavVxpFzCAV8HmhveW4hAJKFSMQKTimTKSsJqIKvWEC0z3oZOALUieL
         T44CscpyvGxqM42qhE0ygqnMwjbP9CdlTlF7Y9Em246VHSKU48o7n8Cu82rKcjacUgDO
         bRf2LH96VaNsNQw5apkRuRtyjhRW65OdUWOVlieRyDO0IJB5nMLan7P0ZK4rOk6BUwS+
         3f4QgvUeyo02bep/xyBuPXA7zFsbIBMU2HsfUZdoAzMTqYXKZmHo4zxN+fw96cZ4xZt4
         L3021Yz2pC5e2yeuTqGpU+sN38KMxVrYPBK62hqIMapw/tlmaZUOhfxBnLmtH7Weiaqj
         NVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uv0Vms7Q7E4XCYJvaSUg6s0TOQG3cm3Fjf8svgA07Ak=;
        b=FibtWV8J5lxCAHg29d4VQmGdELbQCS+fTNtQp+tINjtx7iRAPc/bHQlkbWEpuJFbY5
         pDQ7i9gU3KDk1Lb3+F0rbuV12mzAc3Vo5T8amDSdBBxC3n3IahqUDn98D1dAuSZhLz/j
         kZuFj7puiFiWXsy39K10CH/9/0YWLV+qZCM5TR0Mg3UK7GjO0+fivUlgsftNVSiNBCuz
         6xBCTg/wOBCSbZBLgnpPPnAa1HCWoBPGGhWpEP8A1yGsQVdxropE6LK8FvI69bIKO//l
         wDs+ki6HXW8S84pmYciYRzRcrgk6uD0akK1q45HNZDcDWReNxwL/DbOaAiRKcebhVnZ3
         LyMw==
X-Gm-Message-State: APjAAAWxIBHAFWTWPBcN6aJOA6iAx4xkog61tTwTxSyoh9NzfbrXLNTj
        pw52cJ9wE6hZjv5Kex+o9wzB/SdKmcHTIQ==
X-Google-Smtp-Source: APXvYqwngx0s240RJ5mljL3OkO5b76cE3EMQ0yl9+nO/gDqJuJ/RbKMhGYIzKVj66guOjG7PEPgfzw==
X-Received: by 2002:a05:620a:6cd:: with SMTP id 13mr68179qky.266.1569358524459;
        Tue, 24 Sep 2019 13:55:24 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id h68sm1551981qkd.35.2019.09.24.13.55.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 13:55:23 -0700 (PDT)
Date:   Tue, 24 Sep 2019 16:55:22 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] Minor cleanups in locking helpers
Message-ID: <20190924205521.kgfvsbvkmy4zw7kp@MacBook-Pro-91.local>
References: <cover.1569345962.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1569345962.git.dsterba@suse.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 24, 2019 at 07:33:16PM +0200, David Sterba wrote:
> Reorganizing code wrt locking helpers, minor text and stack savings.
> 

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
