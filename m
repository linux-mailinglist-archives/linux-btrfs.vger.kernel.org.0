Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F174352E7
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Oct 2021 20:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbhJTSrO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Oct 2021 14:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbhJTSrO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Oct 2021 14:47:14 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651CEC06161C
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Oct 2021 11:44:59 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id o13so2648236qvm.4
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Oct 2021 11:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=35dETBS1IO4atbioS6COMpQpDs/m6EOJc7UqB2za8dY=;
        b=K/39J/fNIUgcG+YOYG5xmxNrC6cEsq6ES8EKIVbEZDCBev0OSlj8GTuF9k7C2i+Q/X
         vy1At1sprsRaGkYB7NW9sLGv0gJK78AhY70CDVD1fZQ4CaPQgQ3K/lfjre4Gt+Lt46O2
         5YKWXOVqj2rjY/69/h0NOKerjsIe8ntaKT76XeGfd0aTpIZ7Duw6CFFs7KOh78/vCN2H
         /91nBFlAAQtbqJwnNXCNnqFs4DRGR99+pJzHpG+HTMh9DObX1F4zLhwa7+hUvpviUD7I
         ZJsZ7u2aKVVynj4+C2awd789727KYvHtKccUsZFhu9dBn80xpTc9n2ssKVLwXyg0jzMO
         feoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=35dETBS1IO4atbioS6COMpQpDs/m6EOJc7UqB2za8dY=;
        b=aUbOFoCSTc6T6D82YezMqIVuDoRWpqVVsEIOLhbP/2uNcKpSjDPatwgxYaq20ojAIU
         22Wg8g6i5pd2r6WEQiIGTqWbzPAoUYEkCS0IERSG4fF9qa+bTPo5uMELjiKUbWd44wbT
         zcIeO0AVsl1XHzBaF3ssl3f5kycbBnBtEVZeXKu4rplMxAmjEodFSgf/1+8zX/kMWluQ
         PffWrsp7yesdGCV9BPGGRGhuc62TnQb9YwKdALnhL1ap6iwZh67I2Lo8utaTgI3MCNLx
         m69ChbXbKb3FzlWbvvgJIaZresv0z/b2rR+afRtSivTV3B+U+2VlSfKzlOT7LtakLHtx
         woIA==
X-Gm-Message-State: AOAM530+jBaseqVaYVBRf5NdQl+EddbbiHPTT/tfvj86PGL9V0C1WKjy
        Q1o43D6GBtJq3wtkmn5wivTa2w==
X-Google-Smtp-Source: ABdhPJzNcr9QyQqmMpizi9uz/6ZnFjT6XhpO5D9Z5akYEkyPdcDvyCHUGTvg/YSbL4J3dGrYJtI51g==
X-Received: by 2002:a0c:f211:: with SMTP id h17mr910218qvk.34.1634755498488;
        Wed, 20 Oct 2021 11:44:58 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j20sm1409697qtj.72.2021.10.20.11.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 11:44:57 -0700 (PDT)
Date:   Wed, 20 Oct 2021 14:44:56 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs/249: test btrfs filesystem usage command on
 missing seed device
Message-ID: <YXBjqOuaSwH4iIut@localhost.localdomain>
References: <cover.1634713680.git.anand.jain@oracle.com>
 <599618f8698efc64ef8e25e0cf1d97541927d8ac.1634713680.git.anand.jain@oracle.com>
 <YXAfRcmJ9oYj/kpe@localhost.localdomain>
 <990d5851-5168-c51e-eb5d-f72eac2f327f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <990d5851-5168-c51e-eb5d-f72eac2f327f@oracle.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 20, 2021 at 10:58:56PM +0800, Anand Jain wrote:
> 
> 
> On 20/10/2021 21:53, Josef Bacik wrote:
> > On Wed, Oct 20, 2021 at 03:16:44PM +0800, Anand Jain wrote:
> > > If there is a missing seed device in a sprout, the btrfs filesystem usage
> > > command fails, which is fixed by the following patches:
> > > 
> > >    btrfs: sysfs add devinfo/fsid to retrieve fsid from the device
> > >    btrfs-progs: read fsid from the sysfs in device_is_seed
> > > 
> > > Test if it works now after these patches in the kernel and in the
> > > btrfs-progs respectively.
> > > 
> > > Suggested-by: Josef Bacik <josef@toxicpanda.com>
> > > Signed-off-by: Anand Jain <anand.jain@oracle.com>
> > 
> > Shouldn't this use
> > 
> > 
> > as well?  I wish there was a way to detect that btrfs-progs had support for
> > reading it but I suppose this is a good enough gate.  Maybe add a
> 
>  _require_btrfs_sysfs_fsid ?
> 
> The problem is about the nonexistence of the sysfs interface to read fsid.
> Adding it will fail to reproduce the problem.
> 
> So if there is no sysfs interface, then btrfs-progs will fail back to the
> read-sb method, which shall expose it to fail.
> 

Sigh sorry, I typed this out and then decided I wanted to comment below, and
forgot to delete this bit.

Yeah sorry I'm thinking about it in terms of the CI testing for us, we'll start
failing this test once its merged without the fix merged, but I guess that's
kinda what we want.  Let's just leave this as it is.  Thanks,

Josef
