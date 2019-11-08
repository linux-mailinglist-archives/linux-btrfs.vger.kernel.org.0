Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9E8F57D0
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Nov 2019 21:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388041AbfKHTla (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Nov 2019 14:41:30 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33540 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbfKHTla (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Nov 2019 14:41:30 -0500
Received: by mail-qk1-f196.google.com with SMTP id 71so6369782qkl.0
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Nov 2019 11:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gj/vRoAM7WKPL2b7eH8swrYUiz1FLZRKSUTZff7K2bs=;
        b=IsyrNSBhb/2D3OAuQnnPyAH9LQwsppSzjA9k1pUxQbq7gdNhb8bGWjCc1kBquoutfg
         nB6zbOQgmbnbKVPa/T+7L1djsjNjn88H+DxYZdgi4dMe+cV+rrrpdTwgRAsSRuP2PfOY
         NPzskv8MQseUPKp0aaSwbBYfh0GxQ769mx6girqzsVN98muHw1OvNgMmImnwF00eCh03
         L3aZOopGjK58gqN6qTKaX1zlJ6Zkc5cnWk5pnuF6d82GSCMwMjCVyyvwdc/NCcBB9hS7
         xGOP7HXFPJrmUEo7mFY4GvVxYQD+btzzvmt+XJrbdf3FibQ3LGL/O11HxNiGIfrDJAPO
         A/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gj/vRoAM7WKPL2b7eH8swrYUiz1FLZRKSUTZff7K2bs=;
        b=n73yfw20j9ExyzviPWG5T8BQ2+NPNwrlIvpf0Em/Y0pwNeaGFCanYJxDS74jykdOrn
         xamzcEVLXPmjppYRHGOHmYjWbiyWw3w8OlboEkkrePsh2nnvamVV2n+tiunsojS7vUJ4
         k/zTV5G1ybeVRX3flNys2oIuV+zUTEXNwtB4lzsnYms/YQFPENpKx+DRXFYWhNcMBIMY
         qASH5LxbVq8JODrSOWrhgHQo/+wpCPPAQv0wZ78e9i2g2Wi5IgOStkVlBu49AEnAa6eL
         Ryc8u3s0SAbcv0KuC1Kdf+kkLYOT4FGhJo79wa9e8duCf8ZAPPh2sca/vjpvRLTQ7bRI
         KlPQ==
X-Gm-Message-State: APjAAAUmUhhHCWwx+OsTEMNSfJ+PAnIMOja9+sF+I5x23dvQlK3pQmGD
        MNJEbXxO5ejNSkXNTdwgkCz3Xg==
X-Google-Smtp-Source: APXvYqwQuHVyoworPel8XXYFWBm9kWYzk7f/3u/rcDgf2RDaWZsNO0mDLYgf51Qiv9qDAHS46jDmZg==
X-Received: by 2002:a05:620a:3de:: with SMTP id r30mr10705643qkm.73.1573242089235;
        Fri, 08 Nov 2019 11:41:29 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1852])
        by smtp.gmail.com with ESMTPSA id k6sm3355845qkd.38.2019.11.08.11.41.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 11:41:28 -0800 (PST)
Date:   Fri, 8 Nov 2019 14:41:27 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 14/22] btrfs: add bps discard rate limit
Message-ID: <20191108194126.e7aznojtxhfuaaeg@macbook-pro-91.dhcp.thefacebook.com>
References: <cover.1571865774.git.dennis@kernel.org>
 <8efa082438eea760533f1cddffa74cebdea6f028.1571865774.git.dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8efa082438eea760533f1cddffa74cebdea6f028.1571865774.git.dennis@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 23, 2019 at 06:53:08PM -0400, Dennis Zhou wrote:
> Provide an ability to rate limit based on mbps in addition to the iops
> delay calculated from number of discardable extents.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>

I'm sort of confused, are we hiding the ability to set the iops limit and bps
limit behind BTRFS_DEBUG for a reason?  I get the stats and stuff, but this bit
is confusing.  We should probably at least let these things be configurable
normally, and keep the stats as debug.  Thanks,

Josef
