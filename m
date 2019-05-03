Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB01112C1A
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2019 13:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbfECLOk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 May 2019 07:14:40 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36615 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfECLOk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 May 2019 07:14:40 -0400
Received: by mail-pl1-f193.google.com with SMTP id w20so2572671plq.3;
        Fri, 03 May 2019 04:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nN4ha6oW+lyDvQzXfFBG3/e+/KS9xEKGfoK9fnQUFss=;
        b=CA9c0tlZ2YXoo+ZW4F5b8XgCqdbeBcrmDQyzmXsONHo658rWAwnUoW53gBJl8tcie9
         /6O33CwUZmuS79/48YQ9UWoRHVpbtFuiFTCpJhBM7qOzd0QSOcCT1+7T+MhtfLkc5sd/
         yFddHvecdFvAA8XPaHxIxbkihsodLXWv42wePN9XBOIT3w4Y7d3Z0uG3sl7V/YSrtEv4
         7FfQriCnDgO4tWNA3xCD66i8TCYe1MFWaVYNDG/gFtYD6jFfvlUrg7jBItuh3hB7g5ch
         JPQeGXxeiL7Z6iX+nX+MUMwM85+kzjepYATaV6fVqKifDxe78pOUd2m45cVxeuDDdUxE
         ci8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nN4ha6oW+lyDvQzXfFBG3/e+/KS9xEKGfoK9fnQUFss=;
        b=jGfsTxZapt9xMGm8ma75vBBMP5QYTpKCSWz4l9M7ln8EDgp5ZyZ91g8RWPiqKavcZm
         /oWjy7tlYLOV9R1BILawdBCrJBGMGueq3NeRe7I3nbLhwysIlDZ5tfLdtn0d1wWl/BdY
         BtXk5NG+8jOKDrwIibjjlCR/xn3soIxoGzeIB4f4N8tWN6gEVzo+kcThTD2jY1e5gXd9
         jZ3BP88tszmHQrppR6WI1K34TjexXm1L3S/kfbJT/IMJEzQygkTITfAm+j3Jkf2mloDT
         IFwS3NeOH0hPb/fc3KAwj7ZPFnsepdG+6Rf6LUi5Ly90sD3OeltitUjTXqT2FH2xAYl4
         koAg==
X-Gm-Message-State: APjAAAVGDUES0rP02fO9Ri4OXSaU4mZpPUwbkhTrB6FFdYoTYgJdDnR/
        p76o6KMUuMFQk9HoTEMf/gQ=
X-Google-Smtp-Source: APXvYqwEw5vB85ZoQXhPSfTiGgM2X8ZEfbH6uHM+P8hTQvE/VRSN4rzucc+RKi/f5LrvjAsC+3vHUw==
X-Received: by 2002:a17:902:e305:: with SMTP id cg5mr9538675plb.112.1556882079234;
        Fri, 03 May 2019 04:14:39 -0700 (PDT)
Received: from localhost ([128.199.137.77])
        by smtp.gmail.com with ESMTPSA id s79sm6142795pfa.31.2019.05.03.04.14.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 04:14:38 -0700 (PDT)
Date:   Fri, 3 May 2019 19:14:33 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] fstests: btrfs: try use forget to unregister device
Message-ID: <20190503111433.GD15846@desktop>
References: <1552988980-25710-1-git-send-email-anand.jain@oracle.com>
 <20190402081946.24838-1-anand.jain@oracle.com>
 <20190426163542.GW20156@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426163542.GW20156@twin.jikos.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 26, 2019 at 06:35:42PM +0200, David Sterba wrote:
> On Tue, Apr 02, 2019 at 04:19:46PM +0800, Anand Jain wrote:
> > Some btrfs test cases use btrfs module-reload to unregister devices in
> > the btrfs kernel. The problem with the module-reload approach is, if test
> > system contains btrfs as rootfs, then you can't run these test cases.
> > 
> > Patches [1] introduced btrfs forget feature which can unregister devices
> > without the module-reload approach.
> > 
> >  [1]
> >  btrfs-progs: device scan: add new option to forget one or all scanned devices
> >  btrfs: introduce new ioctl to unregister a btrfs device
> > 
> > And this patch makes relevant changes in the fstests to use this new
> > feature, when available.
> > 
> > Signed-off-by: Anand Jain <anand.jain@oracle.com>
> > ---
> > v2:
> >  Update change log.
> >  Rename _require_btrfs_forget_if_not_fs_loadable() to _require_btrfs_forget_or_module_loadable()
> >  Rename _btrfs_forget_if_not_fs_reload() to _btrfs_forget_or_module_reload()
> 
> Reviewed-by: David Sterba <dsterba@suse.com>

The patch has already been applied & pushed to upstream, thanks for the
review all the same!

Thanks,
Eryu
