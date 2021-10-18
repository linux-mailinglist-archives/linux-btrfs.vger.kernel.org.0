Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECDBE43264B
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Oct 2021 20:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbhJRS0d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Oct 2021 14:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbhJRS0d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Oct 2021 14:26:33 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77D5C06161C
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Oct 2021 11:24:21 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id a7so3195984yba.6
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Oct 2021 11:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UCcRImQqwUQVMbcpeQRtYoJ/lxBwqN037OrwbtyUysc=;
        b=ES6dmFMFhyHMjpsbHx2Rtdkezlg2BtmLtQ1QBpzpv7KqVkJcpMcqzKR26GkTcfxaUx
         h1SlbimyWyUHzo2OZryV6ynB4rQbifJBfT0wgVCsNxyrzIxOu7qaefNLHZd8aQPBpOf9
         CAI7boWoISkOylhbt0etXuZux5gnT4Djg6t1ZTE/oYm8F9fpNQweIVCjKtILVVc/vtwV
         oTQmZK91Tp/Xedba+BHoRjCO5vBapBx3BFZyIvAZ1KXrTnZN3c0Jfb72DE/eFTddwGGg
         TNWAxE38i0sqOuTytdOvXA2wtL9ncWae3XGXbXUVT730YlT7EroEWCPJR2Kun5I8QXdU
         ZdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UCcRImQqwUQVMbcpeQRtYoJ/lxBwqN037OrwbtyUysc=;
        b=ZkvEoYQ97WgGmt5FBlfuPdnvCDcYVK4AAAAoANdmVSgxkG6s3wVHfhYNx97b09kUxf
         H8jQzysHZujVU6VQD15n6/YGn/fwmyOMllbO45qzfutJmuK2Ner+DPyRRS3QpbU93ll3
         W5tAsg9NaonJ4OL6VISkQcg6USfiVmdNqGyeJVLF+UIBC7tyuGM5AdnImEIWbqyNEZZe
         OdevxKU48+kgqdjmgzlnmsclSWu7WxK2gO4zP0E/nbCj7ATXK/Sj2kqAGwAODYZPI9pc
         Qg2BpLvvN9s2e/9LgoDiX/CGKHu4rTTKHJvGnh3kQkCSoxHPpDopbvv3k8jfDmmptKBz
         BVpw==
X-Gm-Message-State: AOAM531RbqwR1OWFKucOp08PRnHsO/cXz7PSKkqVIVM2P0iCRFXgFvcz
        YD4uNcglvtagyMenYzsQ8zaawbJKBijemMg6pyNBOA==
X-Google-Smtp-Source: ABdhPJywOkLOkzmU5bHBWJIS8LBF9k3Rwb7q0IgbUHy1hC4NXMExDi+hk2L653aMY0lmBJf7jy7LDVH25V79X2g70u0=
X-Received: by 2002:a5b:c88:: with SMTP id i8mr24430952ybq.437.1634581460973;
 Mon, 18 Oct 2021 11:24:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtTqR8TJGZKKfwWB4sbu2-A+ZMPUBSQWzb0mYnXruuykAw@mail.gmail.com>
 <da57d024-e125-bcea-7ac3-4e596e5341a2@suse.com> <debf9d63-0068-84db-dcd4-1d923742f989@gmx.com>
 <CAJCQCtSsLSwtNTrUKq_4Rs0tauT45iSA1+AkGWnS9Nmkb=0oWg@mail.gmail.com>
 <9b153cca-2d9a-e217-a83f-1a8e663fc587@suse.com> <CAJCQCtTAHmvwmypAgnLVr-wmuJpOxnmXzpxy-UdHcHO8L+5THw@mail.gmail.com>
 <e18c983f-b197-4fc5-8030-cc4273eda881@suse.com> <CAJCQCtSAWqeX_3kapDLr8AzNiGxyrNE7cO_tr3dM-syOKDsDgw@mail.gmail.com>
 <b1fccb42-da8a-c676-5f0b-1d80319e38ca@suse.com> <CAJCQCtSRxFuU4bTTa5_q6fAPuwf3pwrnUXM1CKgc+r69WSE9tQ@mail.gmail.com>
 <eae44940-48cb-5199-c46f-7db4ec953edf@suse.com> <CAJCQCtR+YQ2Xypz3KyHgD=TvQ8KcUsCf08YnhvLrVtgb-h9aMw@mail.gmail.com>
 <CAJCQCtQHugvMaeRc1A0EJnG4LDaLM5V=JzTO5FSU9eKQA8wxfA@mail.gmail.com>
 <CAJCQCtT12qUxYqJAf8q3t9cvbovoJdSG9kaBpvULQnwLw=rnMg@mail.gmail.com>
 <bl3mimya.fsf@damenly.su> <e75cf666-0b3a-9819-c6ac-a34835734bfb@gmx.com> <CAJCQCtT1+ocw-kQAKkX3wKjd4A1S1JV=wJre+UK5KY-weS33rQ@mail.gmail.com>
In-Reply-To: <CAJCQCtT1+ocw-kQAKkX3wKjd4A1S1JV=wJre+UK5KY-weS33rQ@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 18 Oct 2021 14:24:04 -0400
Message-ID: <CAJCQCtTqqHFVH5YMOnRSesNs9spMb4QEPDa5wEH=gMDJ_u+yUA@mail.gmail.com>
Subject: Re: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Su Yue <l@damenly.su>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I've got kdump.service setup and ready, but I'm not sure about two things:

1.
$ git clone https://github.com/kdave/btrfs-devel
Cloning into 'btrfs-devel'...
fatal: error reading section header 'shallow-info'

2.
How to capture the kernel core dump, if I need to do anything to
trigger it other than reproducing the reported problem or if I'll need
to do sysrq+c or other.

If it's faster, I can also get any developer access to the VM...

-- 
Chris Murphy
