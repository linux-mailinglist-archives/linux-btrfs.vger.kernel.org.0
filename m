Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799A9342260
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Mar 2021 17:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbhCSQo4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Mar 2021 12:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbhCSQof (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Mar 2021 12:44:35 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3C5C06174A
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Mar 2021 09:44:35 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id h20so3223338plr.4
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Mar 2021 09:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zDRp4zhzhmE21QATXfL9uAi28XhhPv7+FyZQ7hRNjpU=;
        b=ti6MobwAr6h2+JIQspD+tPAca27nVKXzlFf1l44ccr4FtxAIIGWBftQ6FSsMweUCGr
         j1IhrR4EZy8Zar0DLxMF0XxlRi5O9oMwQFV5HBBH0qJW+GKMUMWgygtpFUpCJ25vWceF
         xgKSDyWPHYxvKzjK7iuuwJInvnMWdgh6FXR/5F3mWKN5t5LCqunBnKmfRzTBRxFE8NpH
         H+5n7kC5QL/DjQiDFMwhmxJw5mMRt6ort4+5Ku9g7d3JO8gUcIKYUSJlH92TspkqcgsQ
         irhUOWeWyWUOPIycebUpqkdm4ElS8S6Gr/df1g/bewLwcGDEt2LF17b0A0UV359TvXVm
         eSHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zDRp4zhzhmE21QATXfL9uAi28XhhPv7+FyZQ7hRNjpU=;
        b=Vz5etNF9kW0NDmSDXJdt84wbVHU2KAZRM8/FNmwEGW+fCqdv+IH/0CFE1gG86E1kEf
         APphX5Pel8Ny6ai5zm7lizZd5jcWUPyB2mPh3V708DN/5Fr50c/pEnF8KI0S96+MmuJ3
         0nW25gOPEJqgnP/Q/+iN6rBZTKJkcO0+HVLdAS953dgGTRH4nDQ4WdlFwZZckiJYDX+/
         1HIJn9sGu42UjtxLnv31yAN8EzSVTZjMik+KQeQECJMNCZ5HY0y3FNSONxY4UeW/fKXG
         8oFv0anL+/+o4FuezAN8A636Ot0zVN2VrV0k9K/nNe0IZsyrF3aURhqUpOmpEXoOl2ws
         132A==
X-Gm-Message-State: AOAM532Zt6JAKJg3YPs/dmOYqPWI7yiKTO5Hz5UOmqQGXLGfTjL5qKvk
        Mbq7pT1KV7pXAPT9MKEka/M=
X-Google-Smtp-Source: ABdhPJxNn9yY3ZnZ5D9ycSfZv9S+o9vQuyaTXvFsXjNHTufkPO2MqU1J/IQEiKsQWFdGLTCMqNh28A==
X-Received: by 2002:a17:902:e80a:b029:e6:c4c4:1f05 with SMTP id u10-20020a170902e80ab02900e6c4c41f05mr15318685plg.33.1616172274843;
        Fri, 19 Mar 2021 09:44:34 -0700 (PDT)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id t10sm5954177pjf.30.2021.03.19.09.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 09:44:34 -0700 (PDT)
Date:   Fri, 19 Mar 2021 16:44:26 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2] btrfs-progs: common: make sure that qgroup id is in
 range
Message-ID: <20210319164426.GA39442@realwakka>
References: <20210316132746.19979-1-realwakka@gmail.com>
 <20210317183647.GW7604@twin.jikos.cz>
 <20210318022208.GA34562@realwakka>
 <20210318203414.GB7604@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318203414.GB7604@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 18, 2021 at 09:34:14PM +0100, David Sterba wrote:
> On Thu, Mar 18, 2021 at 02:22:20AM +0000, Sidong Yang wrote:
> > On Wed, Mar 17, 2021 at 07:36:47PM +0100, David Sterba wrote:
> > > On Tue, Mar 16, 2021 at 01:27:46PM +0000, Sidong Yang wrote:
> > > > When user assign qgroup with qgroup id that is too big to exceeds
> > > > range and invade level value, and it works without any error. but
> > > > this action would be make undefined error. this code make sure that
> > > > qgroup id doesn't exceed range(0 ~ 2^48-1).
> > > 
> > > Should the level be also validate? The function parse_qgroupid does not
> > > do full validation, so eg 0//0 would be parsed as a path and not as a
> > > typo, level larger than 64K will be silently clamped.
> > 
> > I agree. 0//0 would be parsed as path but it failed in
> > btrfs_util_is_subvolume() and goes to err. I understand that upper 16
> > bits of qgroupid is for level. so, The valid llevel range is [0~2^16-1].
> > But I can't get it that level larger than 64K will be clampled. 
> 
> The way the level gets stored into the final qgroup id is level << 48.
> For example invalid values 70000/281474976710779 would be stored
> as subvol id 123 and level 4465, where the u64 is 0x117100000000007b
> 
> > one more question about that, I see that the ioctl calls just store the
> > qgroupid without any opeartion with level. is the level meaningless in
> > kernel?
> 
> The quota groups are hierarchical and the level denotes the level, where
> 0/subvolid is the lowest always attached to a subvolume and the higher
> levels are artificial and may contain any qgroups and do the whole
> accounting on the subtree. The original design doc .pdf can be found in
> https://git.kernel.org/pub/scm/linux/kernel/git/arne/qgroups-doc.git/tree/

Thanks for detailed description.
I'll write the new patch for checking level also.

Thanks,
Sidong
