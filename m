Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26896D2F6B
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2019 19:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfJJRQU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Oct 2019 13:16:20 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41925 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfJJRQU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Oct 2019 13:16:20 -0400
Received: by mail-qk1-f196.google.com with SMTP id p10so6290473qkg.8
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2019 10:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B6+9s1Pjny+6atK/FX5cKn6wUrj1+omKqMJ1K3nivi4=;
        b=eZ1VCJZD0VsprIigfkfh+qd65dzY+Wa7+giiDhCpyfoZc6PzsOfc00hXw51dfIxXL7
         Yb1EMnchi3HmHTjDy/A32UnQlc3dUDmilyFLivi8ytWRe8ImlSQQliCuNUL058T8ebLM
         43ZrU7iv8pTD3GDbSFri6TJdJOA46hF3p3NZTN2GYLoo0Ahyi2c4yPhfZet4Kx275xCd
         QVeu9dGBLPS23NgVOs0q+Yx1wXv3diVWFmQcQIwOnKk1gnN57QAdi6avGJ2uafD57VnH
         GQxd72kobuCLHCtEKcl832EfKuYcd85q6bUHtAcQffeeyKer4Ld1xy1M6mjRvP/g+8l3
         vE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B6+9s1Pjny+6atK/FX5cKn6wUrj1+omKqMJ1K3nivi4=;
        b=lCjhVeAye/idZtBopITcrVsHniY1/z8RObfxIH3A+tO3lQ66KPbTLYGExrzVz7uy5Q
         vk7TBgEdoA41sT71rllXM8d8Yipo5dSTeBbFHHMnY4ErgtGMSyR9PCaB+Q7EKmfUPyGu
         yFYc3NN6L0vLqSCOO/uI9v6YOySCZVYt1fIYSOGiuxt+/zoVs2M5vjVv8BsBhPLEJeUf
         qw76cE+NX3WKIjHjcUBKg7E2YP6C2eceITStScc86dZrXaBPZcEFHTrJQ1rhedgJDnp8
         DMlZiF+Rvww+F0PQMpgHmD4GNaB8y4Z1nPq9uKYxVUhgtnlkEHz1wFi5csvcJ0C0euES
         e67g==
X-Gm-Message-State: APjAAAXMkuD5J5UQu7verVDhfPqkkTsC0Si4TTyYkrIlq2lFWvfBnPAE
        q9u3Jg18GWyjvzu/DvSAGkeHAw==
X-Google-Smtp-Source: APXvYqwAodJ3BDfX8xXpXqnQ1T17vj1JXFH40GfVCI3dm/FyYYO2Zynlm4XTyi37K+jNogmaQGT7Ag==
X-Received: by 2002:a37:a393:: with SMTP id m141mr10590348qke.72.1570727779187;
        Thu, 10 Oct 2019 10:16:19 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::18ce])
        by smtp.gmail.com with ESMTPSA id l3sm4212040qtc.33.2019.10.10.10.16.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 10:16:18 -0700 (PDT)
Date:   Thu, 10 Oct 2019 13:16:16 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 18/19] btrfs: increase the metadata allowance for the
 free_space_cache
Message-ID: <20191010171616.vb2b6ed5ziwxbjxn@macbook-pro-91.dhcp.thefacebook.com>
References: <cover.1570479299.git.dennis@kernel.org>
 <4b171367793ccdcd722e787e5ae0f4f547ed5c43.1570479299.git.dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b171367793ccdcd722e787e5ae0f4f547ed5c43.1570479299.git.dennis@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 07, 2019 at 04:17:49PM -0400, Dennis Zhou wrote:
> Currently, there is no way for the free space cache to recover from
> being serviced by purely bitmaps because the extent threshold is set to
> 0 in recalculate_thresholds() when we surpass the metadata allowance.
> 
> This adds a recovery mechanism by keeping large extents out of the
> bitmaps and increases the metadata upper bound to 64KB. The recovery
> mechanism bypasses this upper bound, thus making it a soft upper bound.
> But, with the bypass being 1MB or greater, it shouldn't add unbounded
> overhead.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
