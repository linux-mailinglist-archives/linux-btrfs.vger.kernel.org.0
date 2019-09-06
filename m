Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97665ABEF3
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Sep 2019 19:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391958AbfIFRrJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Sep 2019 13:47:09 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37849 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfIFRrJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Sep 2019 13:47:09 -0400
Received: by mail-qk1-f196.google.com with SMTP id u184so3513513qkd.4;
        Fri, 06 Sep 2019 10:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EWIhvlIYQYgSNiR0JTK+22rY1hmZeqOgk/eFbmgddQ8=;
        b=bgFCB1+Xb3oPlPNkF9mxMixq6tix1sDigEgne7DbcjtoTb8LtQM7bLEI8c6fEXGCEr
         QaHWSZoj3I9DLutfVeqVeVjKk01MvMzmnJ5RN6ksDEMplQnSb10hgSbKLM5rfMhtdKMs
         Oe+ChhyonTqOb55VzVqfon+xG8M4HF5Iy0nBxlBctV5XMCK8HXTlb1IZAdRVPTm2Inhk
         heOaX5Le/iwR2acsfOMZeV59m5BrRXaierEsmimERyzjDxzbL1Ja4pVjyENMtzpn0ECh
         4zhTX6QX5XA0QAOF9ucUmOXK2eQOVaULfQkgVrWNM9YsAzt0IiQ0NUKimVeRI9CRlWP7
         UAwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=EWIhvlIYQYgSNiR0JTK+22rY1hmZeqOgk/eFbmgddQ8=;
        b=McFnKFrS5udd3vNj9qfwvXUY7dlGKHuC9znr7Sz6umXSSPgs95VFqxyqbQHTEnPaxT
         ZT8WmjVdhcSkM0catLmaUGy8HpfW4aS7gku0iYg0wYtQJj1d6USauKVKBTKzuZP4e7sM
         5+3Gm718HDiRY/Zdq3Ey8q+066cNiMO7cA8TgbIL0Pi+VCM+sF14cJIZ4tVs7VssncsS
         OjSBNqqvbC9kiqXU/egiOAZjrAz9Zh0VmVp3ja6xqd2/n+R+jPHTHxzGl2AbMKl6CS0C
         qWzT3u0AHoD2urdqq8rg2/mJ+OM9g+bNzDgwC2pKYzeoSwuyOxog4UTviMFali9xSjmF
         GvAQ==
X-Gm-Message-State: APjAAAUOHU8xMPhWROldFQlmv0kc7m3u5CBCR+Fil4Q7a8ZXqCoEhbYM
        yytFnexBjp2rr2oKt0xLLzM=
X-Google-Smtp-Source: APXvYqyKeb8cLLEFnQco06qMeCCL5Perec1oC4sldCMUV05jBqrPKdkNMhRLpGPNtvuqKqZkFjgCYQ==
X-Received: by 2002:a05:620a:15f4:: with SMTP id p20mr9769193qkm.282.1567792028327;
        Fri, 06 Sep 2019 10:47:08 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::e7cb])
        by smtp.gmail.com with ESMTPSA id m92sm2801385qte.50.2019.09.06.10.46.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 10:47:05 -0700 (PDT)
Date:   Fri, 6 Sep 2019 10:46:56 -0700
From:   Tejun Heo <tj@kernel.org>
To:     dsterba@suse.cz, josef@toxicpanda.com, clm@fb.com,
        dsterba@suse.com, axboe@kernel.dk, jack@suse.cz,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCHSET v3 btrfs/for-next] btrfs: fix cgroup writeback support
Message-ID: <20190906174656.GQ2263813@devbig004.ftw2.facebook.com>
References: <20190710192818.1069475-1-tj@kernel.org>
 <20190726151321.GF2868@twin.jikos.cz>
 <20190905115937.GA2850@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905115937.GA2850@twin.jikos.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello, David.

On Thu, Sep 05, 2019 at 01:59:37PM +0200, David Sterba wrote:
> On Fri, Jul 26, 2019 at 05:13:21PM +0200, David Sterba wrote:
> > On Wed, Jul 10, 2019 at 12:28:13PM -0700, Tejun Heo wrote:
> > > Hello,
> > > 
> > > This patchset contains only the btrfs part of the following patchset.
> > > 
> > >   [1] [PATCHSET v2 btrfs/for-next] blkcg, btrfs: fix cgroup writeback support
> > > 
> > > The block part has already been applied to
> > > 
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/ for-linus
> > > 
> > > with some naming changes.  This patchset has been updated accordingly.
> > 
> > I'm going to add this patchset to for-next to get some testing coverage,
> > there are some comments pending, but that are changelog updates and
> > refactoring.
> 
> No updates, so patchset stays in for-next, closest merge target is 5.5.

Sorry about dropping the ball.  It looked like Chris and Nikolay
weren't agreeing so I wasn't sure what the next step should be and
then forgot about it.  The following is the discussion.

  https://lore.kernel.org/linux-btrfs/c2419d01-5c84-3fb4-189e-4db519d08796@suse.com/

What do you think about the exchange?

Thanks.

-- 
tejun
