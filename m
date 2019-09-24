Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65ABBBCB54
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 17:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389425AbfIXP0d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 11:26:33 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:47070 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389379AbfIXP0d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 11:26:33 -0400
Received: by mail-qt1-f195.google.com with SMTP id u22so2598707qtq.13
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2019 08:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o6SX2bYbXAGHBybfVZh0fw5VGyAoUYkj0YnKMsvN2mE=;
        b=DBGhILW/UlkUyxuVcQ8G0wTX6F4dvTFGNFUyr2C1Ledj0k8uPXTOu1gJVZ8q8NwFKd
         dPTbJZg7etvDl5IFYBgTfMM/kTz8w7KnvVC6H5D/fXGx3e7ZO4u/XeFgw0S/+CNWcjxT
         ilKawlilxZ026qa6ZGyZ+KUwWJjlMLh1eCSpZPBXHKkiK2t/JlFFNxSjPIDg4zdnPcd8
         +es8Mk0Uq26qMD1VUwJKrhF4R00Eiklf1shpqWheixkcFzq9SO0ZlCUJB4/v0Feevzuu
         jbx9y/wALNRKTKLWOTOLanE4xKaMIyLlsFrSBTRQ/3ORpDYKWpE6IjicoXAkXpjAtV72
         +U3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o6SX2bYbXAGHBybfVZh0fw5VGyAoUYkj0YnKMsvN2mE=;
        b=bmcq+4b0eSt8coqJv86iQQNaJBSi2hbkFpLXRRvIbI3/3Yc+Wweiavr8Xzv4dSeMa4
         mRFOZs4+36aKHG6KxIJe7KioAUWcVi8UZN+/HH0UpqzmSmSzq8+cBf1sGHenX3glEOOy
         q5I6BuieCqw4HMFCNzqXVPUTEXoCoL5m/7c48a5j1XjrLl+QPGLL9d1wWIko4ZW5tC6H
         hFJdao5GnaTJab10bqlA7kDr3frNfkfg4WWVwxOWDk8MbuyYyMvN3qYNWhx9tTTXgJfG
         ttrzFXsfJMiZT7HhdLzuv2K+g3To054AJ/dMIxBwPdZtm2C5YaJutoHS0/7sQRvEMKtH
         DHOQ==
X-Gm-Message-State: APjAAAWPfuoxEJcmfWKxYsQKhdLj6px7EMCo1UVAGsft7fWy+iwwHH11
        rFmgTWRUsss/wT1mrvrmU20nPg==
X-Google-Smtp-Source: APXvYqzOc7iQ4khQTvZkqykYy70kyTHNkYYL+Rvm+VHLy5Guvj2CqZkXM9DGtMHXlAZPuEHjNAXziQ==
X-Received: by 2002:ac8:4a12:: with SMTP id x18mr3346297qtq.84.1569338790819;
        Tue, 24 Sep 2019 08:26:30 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::b7c9])
        by smtp.gmail.com with ESMTPSA id d45sm1398604qtc.70.2019.09.24.08.26.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 08:26:29 -0700 (PDT)
Date:   Tue, 24 Sep 2019 11:26:28 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "zhengbin (A)" <zhengbin13@huawei.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>, renxudong1@huawei.com,
        Hou Tao <houtao1@huawei.com>, linux-btrfs@vger.kernel.org,
        "Yan, Zheng" <zyan@redhat.com>, linux-cifs@vger.kernel.org,
        Steve French <sfrench@us.ibm.com>
Subject: Re: [PATCH] Re: Possible FS race condition between iterate_dir and
 d_alloc_parallel
Message-ID: <20190924152627.kmbvxb4elpxfoybf@macbook-pro-91.dhcp.thefacebook.com>
References: <20190915005046.GV1131@ZenIV.linux.org.uk>
 <CAHk-=wjcZBB2GpGP-cxXppzW=M0EuFnSLoTXHyqJ4BtffYrCXw@mail.gmail.com>
 <20190915160236.GW1131@ZenIV.linux.org.uk>
 <CAHk-=whjNE+_oSBP_o_9mquUKsJn4gomL2f0MM79gxk_SkYLRw@mail.gmail.com>
 <20190921140731.GQ1131@ZenIV.linux.org.uk>
 <20190924025215.GA9941@ZenIV.linux.org.uk>
 <20190924133025.jeh7ond2svm3lsub@macbook-pro-91.dhcp.thefacebook.com>
 <20190924145104.GE26530@ZenIV.linux.org.uk>
 <20190924150144.6yqukmzwc3xlnfql@macbook-pro-91.dhcp.thefacebook.com>
 <20190924151107.GF26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924151107.GF26530@ZenIV.linux.org.uk>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 24, 2019 at 04:11:07PM +0100, Al Viro wrote:
> On Tue, Sep 24, 2019 at 11:01:45AM -0400, Josef Bacik wrote:
> 
> > Sorry I mis-read the code a little bit.  This is purely for the subvolume link
> > directories.  We haven't wandered down into this directory yet.  If the
> > subvolume is being deleted and we still have the fake directory entry for it
> > then we just populate it with this dummy inode and then we can't lookup anything
> > underneath it.  Thanks,
> 
> Umm...  OK, I guess my question would be better stated a bit differently: we
> have a directory inode, with btrfs_lookup() for lookups in it *and* with
> dcache_readdir() called when you try to do getdents(2) on that thing.
> How does that work?

Sorry I hadn't read through the context.  We won't end up with things under this
directory.  The lookup will try to look up into the subvolume, see that it's
empty, and just return nothing.  There should never be any entries that end up
under this dummy entry.  Thanks,

Josef
