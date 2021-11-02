Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB1C442EE5
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Nov 2021 14:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhKBNOy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Nov 2021 09:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbhKBNOy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Nov 2021 09:14:54 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42825C061714
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Nov 2021 06:12:19 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id t40so18753266qtc.6
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Nov 2021 06:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I6a3q8pTz0iz2539rUt0uOZPgToIWGygBrQ9MZOdAfo=;
        b=aJ2kCAW4hgQQp4P+vcRT54M8OSaBnvpXsYNXmwp6YLqYSCZpCramXqV2NxG/xkbm2x
         vwniPR+VjHyC3p3O+GNmjkTZjKO/4kkD8Vi+IiClJoVdjrnQHkelspKpBKkcFz9xMVNU
         yKWpoz1lJHHbcDhFKR4Vyxt4nNqw6esgAtfAVgrsTA5TVeujwWzFq8XzzQJw5nk9IrW/
         gfUCd6/DTBnvrGX4bm5MgEBGEX8WsFE/zOHIT0MKGuqoGlJYVqNwsFGke9F9YwaTGJLL
         utEBa27fz+sniDB6pB8PDa/7kfk0u4Zg9t39JXY1V5jsHeWPWu1o4ECyELW1AHMfnmRg
         LtEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I6a3q8pTz0iz2539rUt0uOZPgToIWGygBrQ9MZOdAfo=;
        b=z7XnnWLo2er9PCBDgNHAVSdp4br7CfkhgwFeXxoysQmazSMqeDxw8GXJMPcH4FmLvp
         9BEHelyT3XJLbP6nD44KDCQIMtZDDBbtUOx2uHvPtB8jvw4PyLXrd3KHd1Cjoi7C0Tzd
         f9AHEmN7LTNaHT0G4PdG5YEPaTSuL1mgxAnCtHGS3j394SyaC+AyI2ChzruVo45nTeB1
         aEUvfKAtikt8X3C1zC0B4WOHNIXMsOCe7JJstO4KAZx/qzyXvUFNuQeNrEGv4UutiS9i
         KGxe/njfPKB/zF05465oggqIRc9bQfHMSGyr3ToovYskcy8H/vqqWKErPf08g2JwXsk4
         +Prw==
X-Gm-Message-State: AOAM5333YGHPXl6Au5t/cwh7Xo9pB79luSC5slbPow4oo7Fy8eJvNWOw
        B01rttOmCqAM2Cb9fAfy+XpH6z4wy0dmZA==
X-Google-Smtp-Source: ABdhPJzeDI7HC5dStkM0uqaDeyRk1MMszze85mAt32gHBo6gUvLJaEgpHhrvD0i0ZSSzXA9Ivc1vQg==
X-Received: by 2002:a05:622a:50b:: with SMTP id l11mr37730347qtx.415.1635858738280;
        Tue, 02 Nov 2021 06:12:18 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i13sm12134618qtp.87.2021.11.02.06.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 06:12:17 -0700 (PDT)
Date:   Tue, 2 Nov 2021 09:12:16 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] Balance vs device add fixes
Message-ID: <YYE5MB31cKGy0KD1@localhost.localdomain>
References: <20211101115324.374076-1-nborisov@suse.com>
 <3447a87c-d91f-1c24-a77f-9a87d946bab4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3447a87c-d91f-1c24-a77f-9a87d946bab4@oracle.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 02, 2021 at 12:52:11PM +0800, Anand Jain wrote:
> On 01/11/2021 19:53, Nikolay Borisov wrote:
> > This series enables adding of a device when balance is paused (i.e an fs is mounted
> > with skip_balance options). This is needed to give users a chance to gracefully
> > handle an ENOSPC situation in the face of running balance. To achieve this introduce
> > a new exclop - BALANCE_PAUSED which is made compatible with device add. More
> > details in each patche.
> > 
> 
> Have you thought about allowing the device-add during the balance-running,
> not only at the balance-paused? Is it much complicated? If not, then we
> could drop the new exclop state BALANCE_PAUSED altogether.
> 

We could be changing the raid settings, adding chunks before the new device is
added and then ending up with chunks that don't have all of their stripes.  The
number of bugs that could show up is scary, I think this is the safer choice for
now.  Thanks,

Josef
