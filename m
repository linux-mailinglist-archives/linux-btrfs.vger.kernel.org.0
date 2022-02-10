Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354B94B160B
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 20:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343787AbiBJTPc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 14:15:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239426AbiBJTPb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 14:15:31 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D25101C
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:15:32 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id c8-20020a17090a674800b001b91184b732so7115500pjm.5
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v7Zd4PFpa4m33bok/L0s4fagSRqPEbHfnG9vzPLPopU=;
        b=LwrvF7mHe7cYRiTyskAemICM1wDk7838kBgYAhmaADTuwZN9BBRbhvJtVE+fKA3JGi
         SN/mWMsAqbQJFASfyaYSroK6q2GKXSgSHumylqguuk/Kw2aHzI2ssHQEQw9Mcfu6oAjd
         pYEb5XGBIzsxPW1XIJsrpV+N5ReJ0J8O9Wqnh9rROZJMY7icfPX/0gD42wZv6yZum9ij
         unoZ9LZEz/V8oPGG8/sODQgx7H6c5M6X9DgGaBxJWWa91KvkdJf6OjZtecVzzMLKRJOi
         hP0Vy0lL5ZViv2aryPZznI34/VqOv3UmXQPpBexdXoT6vxgwLiQBFx5VaSPxnwe5xddt
         9jMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v7Zd4PFpa4m33bok/L0s4fagSRqPEbHfnG9vzPLPopU=;
        b=K27PbLrVV5sxan7AnwTMIDO5U4n+8HO9NlXFXPqMaC6/qnJ2gqozjQAIE6dA4A9KGL
         KcNIIptJq8p2SOR4at5shRvVcXUsHqfnvv7DmWP2wmXXM4CcDg7m1473tym/kbKDH+WT
         Ium4DvYSVJOdCVGHK8iKali1bKlXeOgNgJEAKO19NSLAwIfrwH0GY6N35W9jkZTBnmCz
         M+16NuU1C63hnbtArw8ex+YcirH0Uu0NW5dmbCZLxWhCu+UWmWcWLuGF54x6rVLT4dIl
         OmDexXs9s7xc5E75sjgRahkh2iEXlbrDDMOI1REbUq2/Jv+HpSnjg+JV3Sb1QwVzPESF
         UqkA==
X-Gm-Message-State: AOAM532DcPSQKytNHkDjrEXXO7YyV09KLuVXtWziA+XWTtjdA7L7Cm6Q
        pnFcOlVec+hogKyrOzmQxjXxXcCSSl2v0w==
X-Google-Smtp-Source: ABdhPJzvUJ8xBzWAAOCvZxxRJvGeEvAv7vbpSTsPWljUw+8X+4aad/hvhwAQcbfFtk0v2O1C4NcmcA==
X-Received: by 2002:a17:902:d346:: with SMTP id l6mr8771409plk.31.1644520531384;
        Thu, 10 Feb 2022 11:15:31 -0800 (PST)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:1975])
        by smtp.gmail.com with ESMTPSA id t1sm17172796pgj.43.2022.02.10.11.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 11:15:31 -0800 (PST)
Date:   Thu, 10 Feb 2022 11:15:30 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: Re: [PATCH v13 09/10] btrfs-progs: send: stream v2 ioctl flags
Message-ID: <YgVkUqmVWBmVkTEv@relinquished.localdomain>
References: <cover.1644519257.git.osandov@fb.com>
 <f9e2c5f46f9f2daa195d1e857b3aa8cb7ff23243.1644520114.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9e2c5f46f9f2daa195d1e857b3aa8cb7ff23243.1644520114.git.osandov@fb.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 10, 2022 at 11:10:16AM -0800, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> First, add a --proto option to allow specifying the desired send
> protocol version. It defaults to zero, which tells the kernel to pick
> the latest version. This is based on Dave Sterba's patch.

Oops, this paragraph should be updated to read:

First, add a --proto option to allow specifying the desired send
protocol version. It defaults to one, the original version. In a couple
of releases once people are aware that protocol revisions are happening,
we can change it to default to zero, which means the latest version
supported by the kernel. This is based on Dave Sterba's patch.
