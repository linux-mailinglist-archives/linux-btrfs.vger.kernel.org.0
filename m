Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 531E1F5794
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Nov 2019 21:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731180AbfKHT1d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Nov 2019 14:27:33 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35392 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730416AbfKHT1d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Nov 2019 14:27:33 -0500
Received: by mail-qk1-f193.google.com with SMTP id i19so6312253qki.2
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Nov 2019 11:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WPrn9ml/Szlvzob7+OuxyY73XsE4fVV4wBUnaFrYRF4=;
        b=XWPrA7jTqTmlKHAI1GDcevm9a8xkPBQdtgVoQSUZoTaky87QjDQeg+1sFMXvnkgWuH
         0izkerxNYsRzZsV8EuInT2OejQqADOC6cEwZCCxFlHoNfLageFvgiveO/FNALZ4EyPXc
         RvD2c73S/1/Y7I03L5jYDIIdnjOVrjKJMrfcjl7Z+8zjvWrJJDGXaPW/9Q5JXgDr+85O
         9pJnCr7OeaS4xPm46BRsDTzqzcrfTxEGRmKuSiwoDQnuUUNTNpr4VNbNeB4pC2HP6kO6
         S0HJZn4svMBjuh6xwCzZQDrppVUx7GKMrol0TKQNeY17uGsMaFvicxbVSnCzA2BQHec0
         bPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WPrn9ml/Szlvzob7+OuxyY73XsE4fVV4wBUnaFrYRF4=;
        b=Pg9iJfbi0xUxOq3uzPqNQ4+db6ihSURAxXLqtiujlTB1T9a3cquFOdtbZP2AHLilfv
         r4ilFqne/VzLOCuTrKCecAoSdyHrSzGXmaE+qp0sy7VERetkz8emwRVLR2VEzLDmCQgZ
         ouAmcJjSWhJLnW0MbTBL7ncPUZ4SUdmT2dSKN554SQOgoZv9xA0YuhywjQ5D9+Q+UjzB
         OwCf1h1mezPjBSFnCBH3DNatUP9NOxhMaYLmiSJ3NanULPpYS7YRF8z5NbdX6yYfmORm
         rgJf2kV+Wlfd0Dfc6+oeWXdsrEKBAejosWW7zPyaOG6l6A5kKSRWKiIDjOQveYC1lrpV
         PISw==
X-Gm-Message-State: APjAAAUFOhvxzMFIB2Cp/0PTVKUSt/AvdExP7jx626m/5cAXL80SqJn9
        t1R9fusWDAA5vICW+AHqSVqY1A==
X-Google-Smtp-Source: APXvYqz9rLXPzh3Z8ctMDoaL017KsCbHZApTQ0ESwiqQT2g9KnXNgqhm1BJD6MtWwwQRdV84iXzRhA==
X-Received: by 2002:a05:620a:2115:: with SMTP id l21mr3817742qkl.105.1573241252427;
        Fri, 08 Nov 2019 11:27:32 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1852])
        by smtp.gmail.com with ESMTPSA id k3sm2891004qkj.119.2019.11.08.11.27.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 11:27:32 -0800 (PST)
Date:   Fri, 8 Nov 2019 14:27:30 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 07/22] btrfs: discard one region at a time in async
 discard
Message-ID: <20191108192730.ttmojxmybgrcazxz@macbook-pro-91.dhcp.thefacebook.com>
References: <cover.1571865774.git.dennis@kernel.org>
 <6ab77d726e93f19b26858ca8c2248ae249701e71.1571865774.git.dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ab77d726e93f19b26858ca8c2248ae249701e71.1571865774.git.dennis@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 23, 2019 at 06:53:01PM -0400, Dennis Zhou wrote:
> The prior two patches added discarding via a background workqueue. This
> just piggybacked off of the fstrim code to trim the whole block at once.
> Well inevitably this is worse performance wise and will aggressively
> overtrim. But it was nice to plumb the other infrastructure to keep the
> patches easier to review.
> 
> This adds the real goal of this series which is discarding slowly (ie a
> slow long running fstrim). The discarding is split into two phases,
> extents and then bitmaps. The reason for this is two fold. First, the
> bitmap regions overlap the extent regions. Second, discarding the
> extents first will let the newly trimmed bitmaps have the highest chance
> of coalescing when being readded to the free space cache.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
