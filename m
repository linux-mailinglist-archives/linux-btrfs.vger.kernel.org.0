Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A111F579D
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Nov 2019 21:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731477AbfKHTbJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Nov 2019 14:31:09 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36288 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729896AbfKHTbJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Nov 2019 14:31:09 -0500
Received: by mail-qt1-f195.google.com with SMTP id y10so7754363qto.3
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Nov 2019 11:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V+CSD64absZ7DfcSq+oyPkqo0mjH/EKq7bJt6K43C5I=;
        b=bhOUM4PvMIehg0IiOcshwp/xWUparLGn/G2L3/vlXAsK/Ho5lM5OQRv0KMx8oCK+Gx
         sYfXWYug2PCAyWX5nh7aiCzr8ISysekASYFhWHaVeu8nxHPpfwRQryRKcSoaLDrp5+xg
         QgBWO33ZHNOn3rkCYAy4tiz+Kav0QU7V0fr3nUavjMz/wt78VAsVUtrtJlb6kFm+rldU
         TRZxD4NeXu2+WMpVthyXBrhYmr+kaFpqpbcmYchvKuzbw9TQBHH9eG9+GBgIx//4Iao3
         ogXGi6xaGllpmcwu5TIakOGv+RAMvHUAt/ZRn1/bU+U9Kb74/cDMNvDTtfXFIZqgaq/P
         83Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V+CSD64absZ7DfcSq+oyPkqo0mjH/EKq7bJt6K43C5I=;
        b=qAHCIr6q75nyZGXG7Vb/F/gPshK2j1U0E6rsSOQlazfp2NLrqmBg/EelpQaT5v2s0x
         x+t7W6ghaQjitYv+L3YMBiH7jJmSmNsBCqHZvGQAcmH+R4Ur54Rfx0Yv4CW/6Ihv+Not
         yd2LjfTKyM0Ro2ZzFmxmynbYztNaF1JBQkgH78lVnh7cMm+baP7U9mPQW2HEbz6rnNTV
         RtQi9thahxk/sXveciJAwjvMMbJI+q1yt1Ff0vXAJiLJzXlfD+MbFZNnF5NQ/SjXPx98
         ueq/HZWV4iZKOusEiBzxPLetOxSawwSwEMURLvL1stOnJRIKkVfbVVWXBQkvkpEBvYj3
         Nxqw==
X-Gm-Message-State: APjAAAVL4VcG3CtKuikCxKhog7x97vFexc9GBdnvfnWWhiRjiuDD0mf6
        Mva4WpgTHRG0M70zl5MC75vKow==
X-Google-Smtp-Source: APXvYqzwe4mMahOA9Ip/WKL0GUjfSJtI777UnPOtHQBiUMQxxpa8mD8A+7X5dqY3PUoU6HVMRxj4Aw==
X-Received: by 2002:ac8:3f28:: with SMTP id c37mr12827686qtk.295.1573241468419;
        Fri, 08 Nov 2019 11:31:08 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1852])
        by smtp.gmail.com with ESMTPSA id p145sm3595414qke.37.2019.11.08.11.31.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 11:31:08 -0800 (PST)
Date:   Fri, 8 Nov 2019 14:31:05 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 12/22] btrfs: keep track of discardable_bytes
Message-ID: <20191108193105.kubknd2xidz3nabn@macbook-pro-91.dhcp.thefacebook.com>
References: <cover.1571865774.git.dennis@kernel.org>
 <3801afee5fe1a6a81e04e27692e2ded4c5df64ec.1571865774.git.dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3801afee5fe1a6a81e04e27692e2ded4c5df64ec.1571865774.git.dennis@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 23, 2019 at 06:53:06PM -0400, Dennis Zhou wrote:
> Keep track of this metric so that we can understand how ahead or behind
> we are in discarding rate.
> 

If these are only going to be exposed via a debug sysfs, then it makes sense to
only track it if we have DEBUG set.  Thanks,

Josef
