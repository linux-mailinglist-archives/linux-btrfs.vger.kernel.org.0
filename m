Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91A6E46609
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jun 2019 19:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfFNRqz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Jun 2019 13:46:55 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]:36446 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfFNRqy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Jun 2019 13:46:54 -0400
Received: by mail-qk1-f177.google.com with SMTP id g18so2223000qkl.3;
        Fri, 14 Jun 2019 10:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mfFFn/3fVwiltpoTn5VtkiFL9dQwzzi7uuy6j4r0c2E=;
        b=tScJNbpFESr1S5qpoA/84AXMVM2fWbLaa+BL6ZNYdX7iYc8t9aTc9v1Z3WzJWWEfsW
         OQtK1gSJ30WuTDroiA7Esjhe4gvWfS+dx3RwR93rrC6fVHoaJVc2mmSQG27zEeMEXwsa
         qcaklPQc7Kjb5y08Nmn2YaQbWaW7249tJm8PU8BpVeygOrZrxY40QQUlmZHRl4ov6lD+
         MVjkh2iiwsGnjJJQNRWbTjrilhumeT4pDnA6hj5gi6O+q8WhE2rRaStMvDORhVPNJj4L
         SMfF8cI6VZsPqFs2EXNjTtUFAInkzz90CiWwQDq1AAU8/WhF3yokWf3oEMuMsqNUzA+2
         2XtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mfFFn/3fVwiltpoTn5VtkiFL9dQwzzi7uuy6j4r0c2E=;
        b=pcx8NdBGD2bJT15Y/3ftsbcL6t/tfWp7zfZnMSTDLcDPUuX1rF0JWNmhgjO3naiRyO
         MTFz6PNAb3PGMyZocbmkIIiG64z+/udB30mxcNpRyQ1Gs2SIonkSqXIA+3hU4LsxMVjR
         flJ1LZQUv1PgzRch1uTP1zwuGd95MuQhLDN6KVXv9lVlTixN9T6Mrdk1G5OwRkbW9ZU9
         8yHkylgjwPGOF7m5/OmEO5gBUa5lMIEs/vYuYOQDEOrVOW/gE3+OqTdgn5zgiBAaOUrZ
         LokyMvXfnGxtjvL5O6kIAArbFPjFEvF0ZN4FKd94noAYlRkGWjmE/G3/peCwqoMyiE2X
         ohLQ==
X-Gm-Message-State: APjAAAXw3iEgOB0y/KDYNTM7BWmxdYUQxJBfqA6cXJwZ66brTPgMvOnj
        OqLfoEXp2u490+ufMFZaeVTrYEK6
X-Google-Smtp-Source: APXvYqyAfVnqkVNXbSHlgJIQRVrQOFKEqmlnGRlAPUUjUK4nAA9X6ax8LBgHs5kJCBg/hhv4iIvVYw==
X-Received: by 2002:ae9:f107:: with SMTP id k7mr13980314qkg.215.1560534413489;
        Fri, 14 Jun 2019 10:46:53 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::6bab])
        by smtp.gmail.com with ESMTPSA id u2sm1971672qtj.97.2019.06.14.10.46.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 10:46:52 -0700 (PDT)
Date:   Fri, 14 Jun 2019 10:46:51 -0700
From:   Tejun Heo <tj@kernel.org>
To:     dsterba@suse.com, clm@fb.com, josef@toxicpanda.com,
        axboe@kernel.dk, jack@suse.cz
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCHSET btrfs/for-next] btrfs: fix cgroup writeback support
Message-ID: <20190614174651.GI538958@devbig004.ftw2.facebook.com>
References: <20190614003350.1178444-1-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614003350.1178444-1-tj@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

Added a separate patch to add dummy css_get() and EXPORT's for the
build failures.  It's in the following branch.  I'll wait for a while
and send out if nothing else is broken.

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git review-btrfs-cgroup-updates-v2

Thanks.

-- 
tejun
