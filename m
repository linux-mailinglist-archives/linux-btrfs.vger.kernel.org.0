Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6741B18DA3E
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Mar 2020 22:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgCTVaA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Mar 2020 17:30:00 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44382 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgCTV3z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Mar 2020 17:29:55 -0400
Received: by mail-pf1-f193.google.com with SMTP id b72so3938438pfb.11
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Mar 2020 14:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5+9zGrQ63CqtIzhh7bKa95qKO+lKCM2KjvyD/2FANt0=;
        b=n17IHZo54GA8j1mh/lwUVawpph1ZF849YEMUD/I8yYakbW0YYPkJMC+K1HoATUBIrB
         BzI83H3NFwdxAZ6Ou5Veg8qxh8TAIK2gcRiokoIrfwKzFLtcMVaWa2xLs+udWYlW1iRs
         Dirsfzx9bqXoNxQ/vbl53KFXaMT3NwORGYe0GtfG9c9GjowMNDjI+J0ez+pfgrcazPkz
         7tym1WJKrZ59xujrUQZwzCXIzEL2kYkVTv90d1nEaDCTj3ePB46shoQjg3azLf0GdNNI
         b3mqRYtrGcRnvHUDQAme2qBvbskO6gvtWrpVu36yx3KfcihYsEY0Rlr8bvVKnBTeUIZx
         uXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5+9zGrQ63CqtIzhh7bKa95qKO+lKCM2KjvyD/2FANt0=;
        b=G/yJBbxiQZbz2FgbT6paR+G8bfFsBtm5DL9TPkUcNF+BNVRYEGXDEuBW24D4IiMtNI
         VNV+U1LKkB8pY7MfaPYMiYA/Mwb7oJG2Mso9UC3AhggTtzLSaxSZT3qe+7iBYEDOhx9u
         VNYADUclhoWbRPzMl9W1CAGoe3Lp3vDNdPVhsB165fGALXt8R25RMn0YohGCoeUsjkDZ
         E6AGiKMDOb3dbOsr7ncCccfSWxrNHXJOHgC8wg4ZMoxVioeif84z6gXBrtyhDi+suzX/
         8v/5CR6xbEBPqp62QAvB5F9tjmYSdmsvZrISeLXjrzQb9WY/Nlc1kSWSPBy2r3TYmkWT
         RuFQ==
X-Gm-Message-State: ANhLgQ2gXkhFXoVDbYyYlQZh/mK2AvIPxS962rEEEMM7ICFF7zPdYOod
        reya0B+HLZciu9Gy1nEIedsBww==
X-Google-Smtp-Source: ADFU+vt6mdc+WIjC3GNlWOUxYuAk1SF+lEaYgiyV1K97hmNwU1vCwRb2Js+jVBG8c0oNRvth3+f3/g==
X-Received: by 2002:a63:7148:: with SMTP id b8mr10476998pgn.143.1584739793627;
        Fri, 20 Mar 2020 14:29:53 -0700 (PDT)
Received: from vader ([2620:10d:c090:400::5:c783])
        by smtp.gmail.com with ESMTPSA id q123sm6699887pfb.54.2020.03.20.14.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 14:29:53 -0700 (PDT)
Date:   Fri, 20 Mar 2020 14:29:51 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 00/15] btrfs: read repair/direct I/O improvements
Message-ID: <20200320212951.GE32817@vader>
References: <cover.1583789410.git.osandov@fb.com>
 <20200318220733.GA12659@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318220733.GA12659@twin.jikos.cz>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 18, 2020 at 11:07:33PM +0100, David Sterba wrote:
> On Mon, Mar 09, 2020 at 02:32:26PM -0700, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > This series includes several fixes, cleanups, and improvements to direct
> > I/O and read repair. It's preparation for adding read repair to my
> > RWF_ENCODED series [1], but it can go in independently.
> 
> Overall it looks good, but also scary. There are some comments to
> address, I haven't reviewed it thoroughly yes so please don't resend
> unless there's something that would harm testing. I'll put the branch to
> for-next for some coverage.

Thanks! The only thing so far that might affect testing is the
uninitialized geom.len ASSERT that Nikolay pointed out.
