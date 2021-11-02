Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E8D44306C
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Nov 2021 15:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhKBOdZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Nov 2021 10:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhKBOdW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Nov 2021 10:33:22 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997C3C061714
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Nov 2021 07:30:47 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id u16so8447820qvk.4
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Nov 2021 07:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N8rFaW+0LG1FbDNF4+RCEYkzVXevzzxfGzRS+/IUvDo=;
        b=SKstgqjJ08Z02lobl1BmmrApEBm7I9mx4Csu4CvxyzlUTP10UxwQ/P2xLcmB8lJdkq
         vcnY9Trmb0JFH6eFH3XG8JY4FTQqZ5x1v7Kzoq80uyKU5lwEmbYdLBXDm2AsWCUwFW+t
         5aNViW4/1sbxzD9LOBp3t/lHSku8RmZojwz6vaaFHKUfLnmKQ2AFQ5jeyky1BGJUhPkN
         usULHaGScttN2pe0vOnwV0JKjhHZUuYb9l44E1gK/J0e9u01O6WZ+Wp/Bw4C5nGVgA4F
         YzeXrNV0XH/gM/uyl7qwYvZJyRLLKA/tf31/KbSpGcf/Z9E5fsd6dhhsmYfkSIUoJHUV
         8ieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N8rFaW+0LG1FbDNF4+RCEYkzVXevzzxfGzRS+/IUvDo=;
        b=EOKYIc492E9fhxDdBFe7thQQGI3yRNlMM1ok1Kd8GXn2lT+9nti9oME5smJAcVjez4
         GWhfLX6eYfcrpDbPH/PgyuWNWi4hBv8VAPfHAenqp9XnGR0u9IKZ44qZ6pAdpZufrhOO
         hTTxKQBkW1B0myMppHC46Umcb595/+f09OxWkYEE/Jd2oRiRZpzj3I9KlSHsKxlq79gY
         exkck4Qs8RYOjnyO1acwJtFQ6DdK3pbycisF3WCDu7m3fkKKeHkDMjykM515qtkp4X5Q
         tKLHnTk1XfvOCyBvccNlf/iLTJeUyl6k2HmfjFN57xdFwY8SMf0lsy9iD5MwR+DPf6Ja
         dmbg==
X-Gm-Message-State: AOAM5323LPOBen53ss69c0VfAn6Bh84hm0KMTToy4dLYntly2CpbwUq+
        snzBOiecL1NVhJoYYAA/nV4oFw==
X-Google-Smtp-Source: ABdhPJzDpPm3Zp8FigCyRmLaxnChnsg9Iq2DzwH6Lp4NqBxpiu4e3yiq7odaD084GpqERrRWzEJX9w==
X-Received: by 2002:a05:6214:1c8a:: with SMTP id ib10mr36547619qvb.46.1635863446396;
        Tue, 02 Nov 2021 07:30:46 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q20sm12675923qkl.53.2021.11.02.07.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 07:30:46 -0700 (PDT)
Date:   Tue, 2 Nov 2021 10:30:44 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] Balance vs device add fixes
Message-ID: <YYFLlL4NTF4L+PmE@localhost.localdomain>
References: <20211101115324.374076-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101115324.374076-1-nborisov@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 01, 2021 at 01:53:21PM +0200, Nikolay Borisov wrote:
> This series enables adding of a device when balance is paused (i.e an fs is mounted
> with skip_balance options). This is needed to give users a chance to gracefully
> handle an ENOSPC situation in the face of running balance. To achieve this introduce
> a new exclop - BALANCE_PAUSED which is made compatible with device add. More
> details in each patche.
> 
> I've tested this with an fstests which I will be posting in a bit.
> 
> Nikolay Borisov (3):
>   btrfs: introduce BTRFS_EXCLOP_BALANCE_PAUSED exclusive state
>   btrfs: make device add compatible with paused balance in
>     btrfs_exclop_start_try_lock
>   btrfs: allow device add if balance is paused
> 
>  fs/btrfs/ctree.h   |  1 +
>  fs/btrfs/ioctl.c   | 49 +++++++++++++++++++++++++++++++++++++++-------
>  fs/btrfs/volumes.c | 23 ++++++++++++++++++----
>  fs/btrfs/volumes.h |  2 +-
>  4 files changed, 63 insertions(+), 12 deletions(-)
> 

A few things

1) Can we integrate the flipping into helpers?  Something like

	btrfs_exclop_change_state(PAUSED);

   So the locking and stuff is all with the code that messes with the exclop?

2) The existing helpers do WRITE_ONCE(), is that needed here?  I assume not
   because we're not actually exiting our exclop state, but still seems wonky.

3) Maybe have an __btrfs_exclop_finish(type), so instead of 

	if (paused) {
		do thing;
	} else {
		btrfs_exclop_finish();
	}

  you can instead do

	type = BTRFS_EXCLOP_NONE;
	if (pause stuff) {
		do things;
		type = BTRFS_EXCLOP_BALANCE_PAUSED;
	}

	/* other stuff. */
	__btrfs_exclop_finish(type);

then btrfs_exclop_finish just does __btrfs_exclop_finish(NONE);

Thanks,

Josef
