Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8EF7FBAC
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2019 16:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbfHBODG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Aug 2019 10:03:06 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33396 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfHBODF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Aug 2019 10:03:05 -0400
Received: by mail-qk1-f196.google.com with SMTP id r6so54876499qkc.0
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Aug 2019 07:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UrzY++6e4BtMD6YllAW22Dx30WyrZkdtgyZ3nfrNFvE=;
        b=jpawgkJGtsZ4I2k1kmHeo+J+SW/Th8SVpLEC3WKHk9+VwB9Xsrf6JIeE0bvXRmf/eU
         Lc22+SAY9alLiYx7ADtg7kk1lsuvzMKcFVRrw2p0fvtM6n38nkilOq/p7UurNVQOf0QB
         9wFnXB7NoPY//jxNKHht8mQ9VX+eeefZ5pjobiDD3VBBwy2vECKVyA1TXtK4NHtTcqXR
         yPzqCI8ifQMfxoiM6AGblczlYgjzM11318EazxrO92J+9BLCKEICWxmQO8gg/i9QlzN4
         5EAUb20B1IaSLWWjW/MzWLKqlHOONaab0syyEdmi1dDlBkuFyHHjuNhM3ik2dqCtT6wM
         drrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UrzY++6e4BtMD6YllAW22Dx30WyrZkdtgyZ3nfrNFvE=;
        b=GMLMCXwgbqeD2xUmO67364ZY0PhC5QFS0zR4+TTNe9uJWPrHtzznND+I9j2hjXPaRm
         mrEOxch1EcwNrsIJhxzMQBlnshLR25ojJIw0ijky/eXc2xkGvJuSWX2ERcsdtwE/Kvgj
         39SuVD8ncb2Jd9dc8CyMLXl3Y0CfVnFO3aohB3txqxW60fmY2hRal/BZ+VRBkScrKQwQ
         MU8aOK2JhNarxA3EkLdjqqC3TyDwu0zJHLJxiPnCxz3w6MeW4q+57S/oXNUnq5CK4N4D
         z9v2/dnj/6PrsshAaTy+9Q/ep5rYqMcrK+xQUqxcjfcCcFXB9luKL6NsPjKm4g4yJVw2
         qftw==
X-Gm-Message-State: APjAAAXrBjnRb7NQF6hHXM5UIzVZt2iFxQ+J5wwypy3h1UqZl1xpOlKa
        C+m5kXghpSxN848BvjmxekkWh8ktUB0=
X-Google-Smtp-Source: APXvYqzFINVZMYhaFTr6yqUXB2wQYfAlP0FzCUwm9tkA/zvJftc0ghYbVPGDaSdxWWDJj5KxMpTbow==
X-Received: by 2002:a05:620a:14ba:: with SMTP id x26mr89896326qkj.328.1564754584947;
        Fri, 02 Aug 2019 07:03:04 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id i1sm33146486qtb.7.2019.08.02.07.03.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 07:03:04 -0700 (PDT)
Date:   Fri, 2 Aug 2019 10:03:02 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] btrfs-progs: add a --check-bg-usage option to fsck
Message-ID: <20190802140301.t7od3oj2qsnbfjyq@MacBook-Pro-91.local>
References: <20190802130635.3698-1-josef@toxicpanda.com>
 <c4ffca4b-f2a2-b570-5354-c13ac46154fd@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c4ffca4b-f2a2-b570-5354-c13ac46154fd@gmx.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 02, 2019 at 09:54:12PM +0800, Qu Wenruo wrote:
> 
> 
> On 2019/8/2 下午9:06, Josef Bacik wrote:
> > Sometimes when messing with the chunk allocator code we can end up
> > over-allocating chunks.  Generally speaking I'll notice this when a
> > random xfstest fails with ENOSPC when it shouldn't, but I'm super
> > worried that I won't catch a problem until somebody has a fs completely
> > filled up with empty block groups.  Add a fsck option to check for too
> > many empty block groups.  This way I can set FSCK_OPTIONS="-B" to catch
> > cases where we're too aggressive with the chunk allocator but not so
> > aggressive that it causes problems in xfstests.
> > 
> > Thankfully this doesn't trip up currently, so this will just keep me
> > from regressing us.  Thanks,
> 
> I think the empty bg check is valid.
> 
> Although I hope this check can be a warning for default check, and a new
> option to report too many empty bgs as error.
> 

I don't want to make it default for the reason you describe below.  I'm thinking
of some new log-writes test that checks an fs at a transaction commit where
we've emptied a ton of block groups but haven't removed them yet.

<snip>

> > +
> > +	if (empty_data > 1) {
> > +		ret = -EINVAL;
> > +		fprintf(stderr, "Too many empty data block groups: %d\n",
> > +			empty_data);
> > +	}
> > +	if (empty_metadata > 1) {
> > +		ret = -EINVAL;
> > +		fprintf(stderr, "Too many empty metadata block groups: %d\n",
> > +			empty_metadata);
> > +	}
> > +	if (empty_system > 1) {
> > +		ret = -EINVAL;
> > +		fprintf(stderr, "Too many empty system block groups: %d\n",
> > +			empty_system);
> > +	}
> 
> This hard coded threshold (1) is too vague and maybe too restrict.
> What will happen for things like a lot of data got removed and cleaner
> didn't get kicked in quickly enough before unmount?
> 

Which is why I ran it through xfstests first to verify this wasn't too weird.
What I'm try to capture is the case where something has really gone wrong, so
there will be tons of empty block groups, not just one.  I think generally
speaking having 1 left over makes sense for the testcases that fill and then
delete a bunch, so I don't want those to fail.  Thanks,

Josef
