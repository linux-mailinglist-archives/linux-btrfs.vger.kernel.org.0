Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52EF43526F5
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Apr 2021 09:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbhDBHdY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Apr 2021 03:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234345AbhDBHdX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Apr 2021 03:33:23 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374DDC06178C
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Apr 2021 00:33:23 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id x26so3148352pfn.0
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Apr 2021 00:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JMQj7/IwOEv8dHQ7y+fYm9Gaoe/yivG3HHRRyLL61YU=;
        b=DgFoyxWcrtj7/vn/oVPfP7DE8G2iFv1WomLBA1zVkKHZKBIpvSU65mp4ymq8V3heas
         n0kb3TbNMxuLmOhe49+GHpGsQoi969z4nQjBQDfhhnk1JH3Mh6Tqmq+KvROLEEhRXXt+
         mDCRaWs74uyR1F0oUkxBaZTMkQnyHDD3LSBn9AMFyvt2nEB3sG1er5wxrSCsB3O+VllH
         INMdKxq0lIpC8+jKJ8lYejDKz9p6F7xFQgqw/KOl+v0ZjJCM0J5an8fvT3Q+/QQpB7yy
         Ss0tD0YmewyiBcVJceDJ01qXioMzykNvcW3hdLU8iq3iu+ODTLQ2lfIILmfwPWTZzmXj
         9AWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JMQj7/IwOEv8dHQ7y+fYm9Gaoe/yivG3HHRRyLL61YU=;
        b=FE0UD9YIkSLUi+AHDLnlhyA4d5tcvF4AjtUExXSPUz8eG/zQLtPZgjxlhD0NIaxGMR
         pAxJtMfKA+rvp7iBLhRz5+LqDGGzzo7B8DCt9B1qnAADFY/UrySy+2eWWvnw+6/Uk8FY
         QrYBItCD6E64stbdR0EcZgPDoWZqIDMv0KAvQt0V7pflmQM6g5icDa+6h8hKBq5Ts52l
         WiBQpuNDKpZUNqAiQW+ft7iHyFMM+uYHTSha2HFGjulKPBw/mYM0Q6QVzC6tUJrEiH0s
         AaskbNuaZyij9Fyhmkn3buaRIa1Fn23uHf9g5lJDuomhC0TzVYYitjLpPkmO/By0iWNX
         lI9Q==
X-Gm-Message-State: AOAM531D72NXHs5pHeqA6hbybj4VE85wOjIFzJnbgvz9utBB+k9xFwPk
        xD75ZeSptRdAfvWY0JqKb+7mTmuAlXVZjA==
X-Google-Smtp-Source: ABdhPJzbxExxp2h5Jsw3Tx5mg3OUQI9f2s6C8MA2XQsasDBlXpi/JV0/RnHYmPgPSn4ZVl/potrWDw==
X-Received: by 2002:aa7:8d5a:0:b029:227:7b07:7d8b with SMTP id s26-20020aa78d5a0000b02902277b077d8bmr10850850pfe.26.1617348802487;
        Fri, 02 Apr 2021 00:33:22 -0700 (PDT)
Received: from relinquished.localdomain ([2601:602:8b80:8e0::16fc])
        by smtp.gmail.com with ESMTPSA id f20sm7558826pfa.10.2021.04.02.00.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 00:33:21 -0700 (PDT)
Date:   Fri, 2 Apr 2021 00:33:20 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v9 1/9] iov_iter: add copy_struct_from_iter()
Message-ID: <YGbIwOv0yq0z8i8K@relinquished.localdomain>
References: <cover.1617258892.git.osandov@fb.com>
 <0e7270919b461c4249557b12c7dfce0ad35af300.1617258892.git.osandov@fb.com>
 <CAHk-=wgpn=GYW=2ZNizdVdM0qGGk_iM_Ho=0eawhNaKHifSdpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgpn=GYW=2ZNizdVdM0qGGk_iM_Ho=0eawhNaKHifSdpg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 01, 2021 at 09:05:22AM -0700, Linus Torvalds wrote:
> On Wed, Mar 31, 2021 at 11:51 PM Omar Sandoval <osandov@osandov.com> wrote:
> >
> > + *
> > + * The recommended usage is something like the following:
> > + *
> > + *     if (usize > PAGE_SIZE)
> > + *       return -E2BIG;
> 
> Maybe this should be more than a recommendation, and just be inside
> copy_struct_from_iter(), because otherwise the "check_zeroed_user()"
> call might be quite the timesink for somebody who does something
> stupid.

I did actually almost send this out with the check in
copy_struct_from_iter(), but decided not to for consistency with
copy_struct_from_user().

openat2() seems to be the only user of copy_struct_from_user() that
doesn't limit to PAGE_SIZE, which is odd given that Aleksa wrote both
openat2() and copy_struct_from_user(). Aleksa, was this intentional?

Thanks,
Omar
