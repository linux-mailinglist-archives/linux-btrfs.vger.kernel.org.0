Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED6D433D74
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Oct 2021 19:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbhJSR3r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Oct 2021 13:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbhJSR3r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Oct 2021 13:29:47 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F70CC06161C
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 10:27:34 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id gn3so521271pjb.0
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 10:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jsd6wU+aR89LA2ktKyTC9MFDM28F0HuLqFr7QFKE+V0=;
        b=F8hq9NTeV0RjXD/CLH+ZpRBuTbB8/gGoJRKT4kcce9M+fwlzEsuO4necFm0x7IVa92
         DJP+/xhL5xDNFpCX/87ugu8VIgNcHdrx0p+qWuhLTIhQTEQsAeqQvwvPLx+N/hSr02UD
         NNwtnN/ydOf1M/vfoocnC9U3HmP7iZMKoF9mMkb/KzjQrclfNPznqNRfa0loFjfGPZ9K
         RYaM2ZWmzjmI6eiTJZUMz23FCtm8qY3u2+stlXci59cTveSI3mx+W/z6CKcALst4q4l6
         LyvfuJYVuqabx4OAQLB1yfr4FMRHazlxEdyeMMv0VOo+KS4VxLZxHj3DeEYWkGgQwOkU
         Uv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jsd6wU+aR89LA2ktKyTC9MFDM28F0HuLqFr7QFKE+V0=;
        b=a29TUR8EpJdPMpDmYj21ULaQo5oiTwEt2r+kokzDfDU9SxVMqKjj66zFxq/OWojhRG
         XQnJUUBmVOEH6ghFafbwMHHltodfcW2ho+Zjn5Ui4lRiBlWAvijXfcohGgY0goBhVmb6
         psNhiF1nayIcUK0q3rm/RPh1YWCJWeBUsAoStXlUeImWTKxZUXRM4naf62pPrpVxAra/
         0Yo54tPeW5sosuVAhU+K5WT3ocD52xhQwVvMZud2sg42xXPOp6eFxouWKXivWE+Sx3MU
         kdynUPF4P13E4XFBMr7a8ZzQZwp8aLc1S7lILlWnD/2ftcD9WES0WtrUxo2GpNewnlbg
         WdXw==
X-Gm-Message-State: AOAM531n4QAyHFXJda5rcUn79+0NvmbKa/695rxlVuvGfBHA4fRIYrjN
        2ZL8d3L1nyyZ8jPInb2L9GMLvg==
X-Google-Smtp-Source: ABdhPJwOSv5+X97zk3nMZeNcicp1bi66DWRybThU2K+EiZHAvGtDh5H+Xf7RiPndTwtIF5j1L2Nmew==
X-Received: by 2002:a17:902:ec81:b0:13f:19b3:c0cd with SMTP id x1-20020a170902ec8100b0013f19b3c0cdmr34338137plg.81.1634664453537;
        Tue, 19 Oct 2021 10:27:33 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:b911])
        by smtp.gmail.com with ESMTPSA id x22sm3334834pjd.47.2021.10.19.10.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 10:27:33 -0700 (PDT)
Date:   Tue, 19 Oct 2021 10:27:31 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, nborisov@suse.com
Subject: Re: [PATCH RFC] btrfs-progs: send protocol v2 stub, UTIMES2, OTIME
Message-ID: <YW8AAy3eKtfr0X35@relinquished.localdomain>
References: <20211018144109.18442-1-dsterba@suse.com>
 <20211018144717.20275-1-dsterba@suse.com>
 <YW3qStSa9LiaankG@relinquished.localdomain>
 <20211019125359.GR30611@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019125359.GR30611@suse.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 19, 2021 at 02:53:59PM +0200, David Sterba wrote:
> On Mon, Oct 18, 2021 at 02:42:34PM -0700, Omar Sandoval wrote:
> > On Mon, Oct 18, 2021 at 04:47:17PM +0200, David Sterba wrote:
> > > +	int ret;
> > > +	struct btrfs_receive *rctx = user;
> > > +	char full_path[PATH_MAX];
> > > +
> > > +	ret = path_cat_out(full_path, rctx->full_subvol_path, path);
> > > +	if (ret < 0) {
> > > +		error("otime: path invalid: %s", path);
> > > +		goto out;
> > > +	}
> > > +
> > > +	if (bconf.verbose >= 3) {
> > > +		char ot_str[128];
> > > +
> > > +		if (sprintf_timespec(ot, ot_str, sizeof(ot_str) - 1) < 0)
> > > +			goto out;
> > > +		fprintf(stderr, "otime %s\n", ot_str);
> > > +	}
> > > +
> > > +out:
> > > +	return 0;
> > > +}
> > 
> > Are you planning to do anything with otime (e.g., storing it in an
> > xattr) in the future?
> 
> At this point I don't have further plan to use the value on the receive
> side, there's no standard way to track otime outside of the inode. This
> is up to the application, it can be stored in a xattr or just
> cross-referenced with some other data.

In that case, for the majority of users that are just sending subvolumes
from point A to point B, this is unnecessary metadata for no benefit.
But it's so small relative to the actual file data that it probably
doesn't matter, and I think it's a good enough proof of concept.

> I don't remember if there was a specific request for the otime in the
> protocol, but for completeness of the information it makes sense to
> transfer it to the receiving side.
> 
> > >  static const char * const cmd_send_usage[] = {
> > >  	"btrfs send [-ve] [-p <parent>] [-c <clone-src>] [-f <outfile>] <subvol> [<subvol>...]",
> > >  	"Send the subvolume(s) to stdout.",
> > > @@ -447,6 +483,7 @@ static const char * const cmd_send_usage[] = {
> > >  	"                 does not contain any file data and thus cannot be used",
> > >  	"                 to transfer changes. This mode is faster and useful to",
> > >  	"                 show the differences in metadata.",
> > > +	"--proto N        request maximum protocol version N (default: highest supported by running kernel)",
> > 
> > Can we default to version 1 and provide a way to opt in to the latest
> > version? I'm concerned with a kernel upgrade suddenly creating a send
> > stream that the receiving side can't handle. Making this opt-in rather
> > than opt-out seems safer.
> 
> Default to v1 is safe, but what's your idea when to change it?
> 
> The send/receive usecase has 4 moving parts, kernel/send, progs/send,
> progs/receive, kernel/receive. On different hosts and both parts
> happening at potentially different times. Getting out of that with sane
> defaults will be fun.
> 
> I agree that bumping the default any time kernel with new protocol
> version support can break things quite easily, so that's against the
> usability principles.
> 
> As the default is in progs it's a bit more flexible as it does not
> require kernel update/reboot. The maximum supported value is known and
> the 'default' value 0 for proto version allows that in a way that does
> not require updating scripts.
> 
> So for first public release, I'll keep the default 1. Changes in the
> default version can follow a similar way like mkfs, ie. when there's a
> sufficient support in stable kernels. We'll probably also gather some
> feedback over time so can decide accordingly.

Josef has a good point. For the majority of new commands/attributes, you
only need to update btrfs-progs on the receive side, which is easy. We
just need to be more careful about new commands that require new kernel
support. Compressed data is one of those cases, which is why I made it
opt-in separate from the new protocol version.

So, I think we can change the default to the latest version after only
one or two releases, once people become aware that protocol version
revisions are happening.
