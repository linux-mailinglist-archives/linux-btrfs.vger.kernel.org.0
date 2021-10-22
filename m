Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48BD1437012
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Oct 2021 04:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbhJVCjN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 22:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbhJVCjM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 22:39:12 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBADEC061764
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 19:36:55 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id q189so3752677ybq.1
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 19:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2REIdThSJrAHDmGtchLL3ZaqwHZLkAh9v/9hwm+7SeQ=;
        b=EQFaCLiXp+YaRLiJT6+bvTW6O+xDS6mVoWpd2BWVT3QoVNF9v9CblZ2FZ2mlzmD5nJ
         hU+SMYJnox8UtE701k5cPd8Y3hR9ktjTk6ZdIhn7EuzsLPDvGS+906CgYpvgO/riyd3+
         q98SIw0rGWXoqckrFus7ma53EYcf9658nG6EeJPlm3kFOizsT3Athbn2xd+gczH/4YSY
         cMpn58vJtiqkXe225aDjwiud3k4roQ7aqJsgpAw4wPkAm7seXrHRaD5ydtHZ4gqFR2bJ
         F8thw2T/5lk3l8W9jTJy2r8dr8wYpBDCoW3XTXfHYvGXZuDVYwnFViUVOG/CaPBTG1dy
         CbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2REIdThSJrAHDmGtchLL3ZaqwHZLkAh9v/9hwm+7SeQ=;
        b=K/zEACXqiHC8izKOyYwdVXUUVN1n8MbQMXdUO/eU1gG0nllklFS86pJ5gPVp/AisDD
         zROje7eadN0ADMSZ3bCS6IxxlLL53s2V4fm2vR1/GcJMahkqkeymPZn22GCIRjYv1bHl
         yB5FrLRLJ7b6yXWKdr+w0pN0L86zw/ZcPBxNg4+en488j5WFFngn+wk3YrZCJ9i10iVD
         iCNbadWdJElfquAtgwfUH2Qu4gaqxhO97m54VZONY9isoVKJ+T6rpk+OcmuAM6OSiJre
         2Ozy2TtOdvvs7IX6wFU8rxgUISqK0YGmHWFpu6NXxrGT4HWBCsNJGztqrAdXiBpPPpUJ
         3G5A==
X-Gm-Message-State: AOAM533M9xTZqyk8JDOWWPbimALVewaXx548lsdGApWAgl/gFzR40tD8
        DXYa73h/gZ5qtwnM0aVPkuIvkb1zFy97qfK8zHwK1w==
X-Google-Smtp-Source: ABdhPJwIftgOFrMpyzF+ue5VjErz0sXvbXac5mqXliZKjyjLacrmAA1N4RG4dsHKsK2slhWdFBihEaw0KCBNJknuaX8=
X-Received: by 2002:a25:d3c8:: with SMTP id e191mr10707674ybf.455.1634870214978;
 Thu, 21 Oct 2021 19:36:54 -0700 (PDT)
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
 <bl3mimya.fsf@damenly.su> <e75cf666-0b3a-9819-c6ac-a34835734bfb@gmx.com>
 <CAJCQCtT1+ocw-kQAKkX3wKjd4A1S1JV=wJre+UK5KY-weS33rQ@mail.gmail.com>
 <CAJCQCtTqqHFVH5YMOnRSesNs9spMb4QEPDa5wEH=gMDJ_u+yUA@mail.gmail.com>
 <7de9iylb.fsf@damenly.su> <CAJCQCtSUDSvMvbk1RmfTzBQ=UiZHrDeG6PE+LQK5pi_ZMCSp6A@mail.gmail.com>
 <35owijrm.fsf@damenly.su>
In-Reply-To: <35owijrm.fsf@damenly.su>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 21 Oct 2021 22:36:38 -0400
Message-ID: <CAJCQCtS-QhnZm2X_k77BZPDP_gybn-Ao_qPOJhXLabgPHUvKng@mail.gmail.com>
Subject: Re: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
To:     Su Yue <l@damenly.su>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

OK I have a vmcore file:
https://dustymabe.fedorapeople.org/bz2011928-vmcore/

lib/modules/5.14.10-300.fc35.aarch64/vmlinuz
https://drive.google.com/file/d/1xXM8XGRi_Wzyupbm4MSNteF0rwUzO4GE/view?usp=sharing


--
Chris Murphy
