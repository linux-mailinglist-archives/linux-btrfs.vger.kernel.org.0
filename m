Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C40727E3D2
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 10:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbgI3Idp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Sep 2020 04:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbgI3Ido (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Sep 2020 04:33:44 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F935C061755
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 01:33:44 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z19so673954pfn.8
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 01:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sYWzne90SO1PJBn9gAyCE0w8xLyBAysD6hOJjnKb/t0=;
        b=pzGW6YBq8+azn/p3DIgC6XcIZWd6VNwXKMTjupsfcdAOdMu0EkZEZIGLvEwGCnBB85
         H6M+37ezGCFg23lnApy3y/mO3OeDXBWxCTHoLmqKI81NL4ah1+294CsP7xkkScRaNbfv
         fckJ2+FDX9bZJfeJ1+HO6KHHEeFxYqk7Hye/9D+ap6payQ9fHaS8LvWoSql9dQkxY4SU
         QNBkfceDKxdMtwA7tnNeFlIiMfTTYEUqsV/ia91Id7uTX9sEhBgaLtx0xBnZKeKCEhCO
         1hUmFvrIoXHDEHQu2UNEj9enpfVJxK+nTTXrpSol5KOCnTIj/H0LmdXKuBwJKvvX8W0D
         oC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sYWzne90SO1PJBn9gAyCE0w8xLyBAysD6hOJjnKb/t0=;
        b=Oxkg/aFjA64M64x/wcgqH68q0Z0HoeiBGDUSHgQHwdgbMLkKs01pD5l+KskqJB50Vj
         YL2pxL9v+ZYopXfiBA6MMOYihi/W0BqHCftHLjDdmUw8xJ9c10shcjT9DtiRJArI3MDN
         NL3L1XO+ok25xOJwd5kYqgujnz9sbGxBL8ZW2ngaHL+lMXT9zv1ewJlA4PLWciDWhIFV
         aDXyRGSOiQIyI0uB9HyTtLonKrH8aCfAzqw1+KTvPbW0UuHfD4/Q+PbCpYPZ4mtqnkxM
         8JAh2F/MfHL20u5WzQGCJiK5WING/CylFNwuf85jPxVKCjR68W2sKJEzp6CotojfG2vo
         C9vA==
X-Gm-Message-State: AOAM532NPZXyMsds/FNdPKbJKsYKq634dp+YCmZy1P3MINcYozB26URy
        rAQpTpvGoy3FVn1NbRYKnDY1NFEn0VRX1g==
X-Google-Smtp-Source: ABdhPJzGoxJSPM5P8PiPedGn3Vem1UhTLsxewsmJXoAeTPDS8rIkOrvdp4RAXLyfd0e5qVr3YzTugA==
X-Received: by 2002:a05:6a00:1483:b029:142:2501:3965 with SMTP id v3-20020a056a001483b029014225013965mr1674297pfu.42.1601454823896;
        Wed, 30 Sep 2020 01:33:43 -0700 (PDT)
Received: from realwakka ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id c127sm1454605pfa.165.2020.09.30.01.33.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Sep 2020 01:33:43 -0700 (PDT)
Date:   Thu, 24 Sep 2020 12:45:13 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Su Yue <l@damenly.su>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] btrfs-progs: subvolume: Add warning on deleting default
 subvolume
Message-ID: <20200924124513.GA23361@realwakka>
References: <20200928150729.2239-1-realwakka@gmail.com>
 <blhogiac.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <blhogiac.fsf@damenly.su>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 30, 2020 at 09:33:31AM +0800, Su Yue wrote:
> 
> On Mon 28 Sep 2020 at 23:07, Sidong Yang <realwakka@gmail.com> wrote:
> 
> > This patch add warning messages when user try to delete default
> > subvolume. When deleting default subvolume, kernel will not allow and
> > make error message on syslog. but there is only message that permission
> > denied on userspace. User can be noticed the reason by this warning
> > message.
> > 
> > This patch implements github issue.
> > https://github.com/kdave/btrfs-progs/issues/274
> > 
> > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > ---
> >  cmds/subvolume.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> > 
> > diff --git a/cmds/subvolume.c b/cmds/subvolume.c
> > index 2020e486..0cdf7a68 100644
> > --- a/cmds/subvolume.c
> > +++ b/cmds/subvolume.c
> > @@ -264,6 +264,7 @@ static int cmd_subvol_delete(const struct cmd_struct
> > *cmd,
> >  	struct seen_fsid *seen_fsid_hash[SEEN_FSID_HASH_SIZE] = {  NULL, };
> >  	enum { COMMIT_AFTER = 1, COMMIT_EACH = 2 };
> >  	enum btrfs_util_error err;
> > +	uint64_t default_subvol_id = 0, target_subvol_id = 0;
> > 
> >  	optind = 0;
> >  	while (1) {
> > @@ -360,6 +361,25 @@ again:
> >  		goto out;
> >  	}
> > 
> > +	err = btrfs_util_get_default_subvolume_fd(fd, &default_subvol_id);
> > +	if (fd < 0) {
> > 
> Should it be
> "     if (err) { |
>         error_btrfs_util(err);
>         ...
> "?

Hi Su! Thanks for review!

Yeah, I think it's definitely wrong. My mistake.

> 
> > +		ret = 1;
> > +		goto out;
> > +	}
> > +
> > +	if (subvolid > 0)
> > +		target_subvol_id = subvolid;
> > +	else {
> > +		err = btrfs_util_subvolume_id(path, &target_subvol_id);
> > +		if (fd < 0) {
> > 
> And here.
> 

It's wrong too.

Dave, maybe this patch needs for Su's review.
Usually in this case, Could you fix it directly ?
or do I need to send a new patch?

Thanks,
Sidong

> > +			ret = 1;
> > +			goto out;
> > +		}
> > +	}
> > +
> > +	if (target_subvol_id == default_subvol_id)
> > +		warning("trying to delete default subvolume.");
> > +
> >  	pr_verbose(MUST_LOG, "Delete subvolume (%s): ",
> >  		commit_mode == COMMIT_EACH ||
> >  		(commit_mode == COMMIT_AFTER && cnt + 1 == argc) ?
> 
