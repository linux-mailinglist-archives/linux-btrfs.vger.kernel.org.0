Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE11315F92
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Feb 2021 07:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbhBJGiG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Feb 2021 01:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbhBJGiD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Feb 2021 01:38:03 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D40AC061574
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Feb 2021 22:37:23 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id u14so1215189wri.3
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Feb 2021 22:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9tzwjS2bctJjg17rqcFZthBwfeuPMmVALbYOi/pjy0g=;
        b=BJ/aXOcO0W8vGlhNV2Y7gNiood6N6qzXYFDTDO37GXrTVpFvfOnTriBAKxE6XPQ5Wj
         UeOClVqQ/OsjK+wcxmjHOtYbT4qwzZBu0SRqJBqgJ02QIISqcqATgYtIMfFR4ztXQxFC
         Q0ZoVlRgdqTlwuJapLR9CDlfnubiJNJmO1kVjUoE3j5mGjQ+LCDY9twI5WulMW+o34BN
         H9RFRbDZFaR0jBSB5Y3VNQnFuTgOjttZ+7vUSTvXQ+cDPMeTAIDGeUByP3m7KK8NB7Sx
         q5Lzxdkt0hIiJj+sE5syakkqfu8fMvR22V7XPwVgY2ykXYYMmvQBZ8pf8AXA+P4UZNme
         LUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9tzwjS2bctJjg17rqcFZthBwfeuPMmVALbYOi/pjy0g=;
        b=TBohUc0Q6suCVemDOyxSGFbXnfRKgfNbfufd3wwtVvEFCv10YO5ahQa3K24D3oMMp0
         YnSOxQ93sv3o7LmMJmcg00HObE6Xu3XfIC/gnqT8knxLGphwtZxl22xKfDb1x8x+s+S9
         tRNILrBhy62bqidPk6p/+3OAsxNlQeQs/tYqtZh9FEB+A85Wy7M+QvSId8ShGnBVR/At
         PSZnDWF/IjX1dK2sIZKaM3GSZoq1Txvw7h/awG6jxujRaq2rm0PxUEegwCFQYV/XqWNd
         98WtW5ZQUn/by4mJCm0cgje3JyH2kkW1vIV5Cus+QWvLYdOP+How+vf3TC2Q+rZDuIJ2
         5tFQ==
X-Gm-Message-State: AOAM532uA8WjbPmVT/B1VEuWTIaAbaZIqGg+ET2P0zEKtjMdmVg6xJTq
        TQb4J8K3oP81bBNYv6hH96Hcj2X/mj//oTWVrjc2v+sQCGR3TzCx
X-Google-Smtp-Source: ABdhPJznVQMigOKbTmT5akVbmiwaDDHNUJFM1pMZIj3EH/QDp9qR/Zm3+D2IgbK+jf+VAc+fXRBPcndL8WfS8ZonY9w=
X-Received: by 2002:a5d:508c:: with SMTP id a12mr1821424wrt.252.1612939042029;
 Tue, 09 Feb 2021 22:37:22 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtSx=HcCRMiE0eganPWJVTB+b4zfb_mnd68L2VapGGKi7Q@mail.gmail.com>
 <3897f126-e977-d842-f91d-b48b74958f3d@libero.it> <CAJCQCtScUYMoMpw==HTbBB6s0BFnXuT=MvSuVJYEVBrA7-RbHA@mail.gmail.com>
 <839d9baa-8df5-7efd-94ee-b28f282ef9ec@inwind.it> <CAJCQCtSqESuYawuh6E8b6Xd=z4D13J2=v-6rn8+0mwuThXNtkg@mail.gmail.com>
 <7650c455-297a-f746-c59e-3104fdbf8896@inwind.it> <CAJCQCtR1fCSFYYbo7YvDPTmhALNvUyZB5C4zfMsUH-iU0xs6zQ@mail.gmail.com>
In-Reply-To: <CAJCQCtR1fCSFYYbo7YvDPTmhALNvUyZB5C4zfMsUH-iU0xs6zQ@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 9 Feb 2021 23:37:05 -0700
Message-ID: <CAJCQCtSqvv6RRvtcbFBNEXTBbvNEAqE9twNtRE=4sF9+jcjh9A@mail.gmail.com>
Subject: Re: is BTRFS_IOC_DEFRAG behavior optimal?
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Goffredo Baroncelli <kreijack@inwind.it>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an active (but idle) system.journal file. That is, it's open
but not being written to. I did a sync right before this:

https://pastebin.com/jHh5tfpe

And then: btrfs fi defrag -l 8M system.journal

https://pastebin.com/Kq1GjJuh

Looks like most of it was a no op. So it seems btrfs in this case is
not confused by so many small extent items, it know they are
contiguous?

It doesn't answer the question what the "too small" threshold is for
BTRFS_IOC_DEFRAG, which is what sd-journald is using, though.

Another sync, and then, 'journalctl --rotate' and the resulting
archived file is now:

https://pastebin.com/aqac0dRj

These are not the same results between the two ioctls for the same
file, and not the same result as what you get with -l 32M (which I do
get if I use the default 32M). The BTRFS_IOC_DEFRAG interleaved result
is peculiar, but I don't think we can say it's ineffective, it might
be an intentional no op either because it's nodatacow or it sees that
these many extents are mostly contiguous and not worth defragmenting
(which would be good for keeping write amplification down).

So I don't know, maybe it's not wrong.

--
Chris Murphy
