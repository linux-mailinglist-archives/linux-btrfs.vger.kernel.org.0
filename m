Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE48B0102
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 18:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbfIKQLV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 12:11:21 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40531 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728672AbfIKQLV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 12:11:21 -0400
Received: by mail-qt1-f196.google.com with SMTP id g4so25946072qtq.7
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2019 09:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G52quSDaZVj644THB1KVk3dVg8g0io86ahQNm8+fomQ=;
        b=H/DjKM/FcEVCU6LQAzKi+tUUpMWpWwaHnYILk5yr2CFggEmZ6/jtraJifIcYtOJoG3
         eJfScuBnwRg7rZ1lQYYpLvFvjMgp0yk0LUDaMetZgZJncAUt55ncf+IEi8HsadAe6ZDa
         P5+dsD1lYeRHEkTgB3SOPA5sBqD6j2kyZSkEWYh3+p5jsSuLcOp6eghZdta7lqHiJv+R
         aE4RpwqtnGDUgWTn3MclDeTxbQeAUh+lHLxnGJIxrUihK747F8jtfQtYre62d7XBp+lP
         a6t+x2ZjMuv9uC1xxcxe8eEvaCfmJ/r0Nj9Ma5ddwnYCL0XXiM2JMv1NWp9v6i2I5pXn
         5noQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G52quSDaZVj644THB1KVk3dVg8g0io86ahQNm8+fomQ=;
        b=pBMH2aDA5mR4V+qk0y67ShwvTDX3MUdIQUbB1kmgMx+Q9nogsAKuH/ImKm5NXH4sI9
         j552CLkgfQcPlyK3ypQD8niUs+pae5yaPIArBWJOSAMcjK1XeIxLj9UePPG4K0+kfCBz
         l2Qz1vEJpME32tT7/HtRsvFLja4UOtr+IPjAC9Dy8ffk2kp6Wk1qGX1mJgR9nKIaJjKB
         TptwGOQpmQg/7G1vAOYJ4elMv0Ja9gT7elwjmj0LOHf9uSiUbf40yoGykBiIPRxA81ab
         BUO5dqVTcOHo2zUqFB2lYH8SKaedn+E/tnzipFy1BtvI1tQkWJiPaKL9/AtgvvtrN7VS
         aA3Q==
X-Gm-Message-State: APjAAAV9zsefyXLiU8Z3dyJ26EKUeVf4megYKELnh09PgP9lUJQjlEYJ
        Zd4q/6w0y7i6spoKRkI1/+giksE/y84XiQ==
X-Google-Smtp-Source: APXvYqwbknvLjk5IUajKWr1zgjdTlwb8W/RcFuChDSpHNCyLSXzEkAmKky/LAbCxS8aTlZrOlDb/ew==
X-Received: by 2002:a05:6214:15d1:: with SMTP id p17mr23161388qvz.74.1568218279920;
        Wed, 11 Sep 2019 09:11:19 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id t73sm10106610qke.113.2019.09.11.09.11.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 09:11:19 -0700 (PDT)
Date:   Wed, 11 Sep 2019 12:11:18 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Mark Fasheh <mfasheh@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Mark Fasheh <mfasheh@suse.de>
Subject: Re: [PATCH 3/3] btrfs: move useless node processing out of
 build_backref_cache
Message-ID: <20190911161117.cmrgxnuvze46kwc7@MacBook-Pro-91.local>
References: <20190906171533.618-1-mfasheh@suse.com>
 <20190906171533.618-4-mfasheh@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906171533.618-4-mfasheh@suse.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 06, 2019 at 10:15:33AM -0700, Mark Fasheh wrote:
> From: Mark Fasheh <mfasheh@suse.de>
> 
> The backref cache has to clean up nodes referring to tree leaves. It is
> trivial to pull that code into it's own function, which is what I do here.
> 
> Signed-off-by: Mark Fasheh <mfasheh@suse.de>
> ---

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
