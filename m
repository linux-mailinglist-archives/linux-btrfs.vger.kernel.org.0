Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CCC4C4E80
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Feb 2022 20:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbiBYTTA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Feb 2022 14:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbiBYTS7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Feb 2022 14:18:59 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7A016BCD9
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Feb 2022 11:18:25 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id h17-20020a17090acf1100b001bc68ecce4aso9250512pju.4
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Feb 2022 11:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KSy+A52r6TCG/x6ppDUu4sYkZBpMADhMt8FGFOTz0VI=;
        b=rTanreT9WZ4mKPzqsDCOZkcAxgd36wRbZ2CffV1lWsn+jFKT2DQsTo3Tk8m8uN9Guu
         Z9g0ThVqN+mNLVytxATs3XHGk1lLBbsaLLAcu6qQeqvK94UeTu/IHatokSDUm1i+dEUQ
         6Ycng30QC52nPQRi8CEkLeEkRk3AFbjh09GoeQ/Pjia4RcN/NtBh6LM87vStMoDOPFaS
         muvftwE8PCv+sLDMJ7tdN+z90P0tcMLioow+ZJME6L862sQJQXIwCUpyy+6VnTiwtVyE
         JiUet29P3+eyje7hjQZo1gW6GmiQpIIZE+3gW4ReZ7Xw0H2Dh+elesYPN0y8Y/1bgHYX
         O22A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KSy+A52r6TCG/x6ppDUu4sYkZBpMADhMt8FGFOTz0VI=;
        b=7BMhugb/FBemFc28fWLqBK+5ktPSn6kV+644cYhTC1gi3Lyarqd2H0twa4fl5YiNTJ
         0qLzlRIHQGEpp+xaeI7WTdc4R/MhmYK/QMRsOyjPb2+2VXTOOKTQ/NVfbKyH/UPCPGbE
         xfhPFLF6UHywqrXTm1v2Ut4E9wCOqPTHMxdi3y5nR2OdD0rw5f0QxeBk4IZymCMK0Ayg
         FGdz7Lb7MJI1FC/NT+P4qcTnJZJ+BTTYhRkzT4fsaJI2rxyXLevVBXYhfwVb+wHXDNng
         oEUraXHaXwepLdlyp0y7I/ECuNkjv+mrdQyBguXRrTb27LdfazfKxUtT8EohO7wM3AWk
         VVrQ==
X-Gm-Message-State: AOAM532HaS3a3PD2+wyGSSUaC9tri1N7prQcdV2AydyRT8/VnzQ2ssiT
        qz9OAaUwlADJIxq371F7MiEmfn1ztedkmQ==
X-Google-Smtp-Source: ABdhPJxHjRdmY5ulWp7yw0uzy4JJCq+aXn4zdjdsiZEAwm/flmZzFTcHFuqS0JuIQkcD9cxDwjayjA==
X-Received: by 2002:a17:90a:5b06:b0:1b8:b705:470b with SMTP id o6-20020a17090a5b0600b001b8b705470bmr4545046pji.168.1645816705174;
        Fri, 25 Feb 2022 11:18:25 -0800 (PST)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:750d])
        by smtp.gmail.com with ESMTPSA id q22-20020a056a00085600b004f397d1f3b5sm4324816pfk.171.2022.02.25.11.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 11:18:24 -0800 (PST)
Date:   Fri, 25 Feb 2022 11:18:23 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Seed device is broken, again.
Message-ID: <YhkrfyzmCgOGG+5n@relinquished.localdomain>
References: <88176dfc-2500-1e9c-bac0-5e293b2c0b5c@suse.com>
 <20220225114729.GE12643@twin.jikos.cz>
 <56a6fe34-7556-c6c3-68da-f3ada22bd5ba@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56a6fe34-7556-c6c3-68da-f3ada22bd5ba@gmx.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 25, 2022 at 09:36:32PM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/2/25 19:47, David Sterba wrote:
> > On Fri, Feb 25, 2022 at 06:08:20PM +0800, Qu Wenruo wrote:
> > > Hi,
> > > 
> > > The very basic seed device usage is broken again:
> > > 
> > > 	mkfs.btrfs -f $dev1 > /dev/null
> > > 	btrfstune -S 1 $dev1
> > > 	mount $dev1 $mnt
> > > 	btrfs dev add $dev2 $mnt
> > > 	umount $mnt
> > > 
> > > 
> > > I'm not sure how many guys are really using seed device.
> > > 
> > > But I see a lot of weird operations, like calling a definite write
> > > operation (device add) on a RO mounted fs.
> > 
> > That's how the seeding device works, in what way would you want to do
> > the ro->rw change?
> 
> In progs-only, so that in kernel we can make dev add ioctl as a real RW
> operation, not adding an exception for dev add.
> 
> > 
> > > Can we make at least the seed sprouting part into btrfs-progs instead?
> > 
> > How? What do you mean? This is an in kernel operation that is done on a
> > mounted filesystem, progs can't do that.
> 
> Why not?
> 
> Progs has the same ability to read-write the fs, I see no reason why we
> shouldn't do it in user space.
> 
> We're just adding a device, update related trees (which will only be
> written to the new device). I see no special reason why it can't be done
> in user space.
> 
> Furthermore, the ability to add device in user space can be a good
> safenet for some ENOSPC space.
> 
> > 
> > > And can seed device even support the upcoming extent-tree-v2?
> > 
> > I should, it operates on the device level.
> > 
> > > Personally speaking I prefer to mark seed device deprecated completely.
> > 
> > If we did that with every feature some developer does not like we'd have
> > nothing left you know. Seeding is a documented usecase, as long as it
> > works it's fine to have it available.
> 
> A documented usecase doesn't mean it can't be deprecated.
> 
> Furthermore, a documented use case doesn't validate the use case itself.
> 
> So, please tell me when did you use seed device last time?
> Or anyone in the mail list, please tell me some real world usecase for
> seed devices.
> 
> I did remember some planned use case like a way to use seed device as a
> VM/container template, but no, it doesn't get much attention.
> 
> 
> I'm not asking for deprecate the feature just because I don't like it.
> 
> This feature is asking for too many exceptions, from the extra
> fs_devices hack (we have in fact two fs_devices, one for rw devices, one
> for seed only), to the dev add ioctl.
> 
> But the little benefit is not really worthy for the cost.

We use seed devices in production. The use case is for servers where we
don't want to persist any sensitive data. The seed device contains a
basic boot environment, then we sprout it with a dm-crypt device and
throw away the encryption key. This ensures that nothing sensitive can
ever be recovered. We previously did this with overlayfs, but seed
devices ended up working better for reasons I don't remember.

Davide Cavalca also told me that "Fedora is also interested in
leveraging seed devices down the road. e.g. doing seed/sprout for cloud
provisioning, and using seed devices for OEM factory recovery on
laptops."

There are definitely hacks we need to fix for seed devices, but there
are valid use cases and we can't just deprecate it.
