Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3647B781316
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Aug 2023 20:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236062AbjHRSuU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Aug 2023 14:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379580AbjHRSuL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Aug 2023 14:50:11 -0400
Received: from mail-108-mta134.mxroute.com (mail-108-mta134.mxroute.com [136.175.108.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F7B3C3F
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Aug 2023 11:50:06 -0700 (PDT)
Received: from mail-111-mta2.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta134.mxroute.com (ZoneMTA) with ESMTPSA id 18a09fba4b4000d7b6.002
 for <linux-btrfs@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Fri, 18 Aug 2023 18:50:01 +0000
X-Zone-Loop: f5bc4b547878adad4921d809271634d4645162d48317
X-Originating-IP: [136.175.111.2]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=c8h4.io;
        s=x; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc
        :To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=VSHQihsA2WGpBY4JBMJwlnAgCcX6a/dAXteSM6OBHeE=; b=YqlCdUwYTSCVFyQx7S42wdWNWL
        f+qp/Ok8WfFd6/NU9liDMANhznx7G2aqt1JG/tAiLiZhhyJcuBFgpC0a4/45tO0RzaiBXFreVkj1D
        GNb1LOcDClTkcY/uROXY6C8h9f6Ek5N2fYZAZcXX0cY/XqxD7IFiYsBm15DdklhZ/73CobV+Oz9h9
        eRTsobf65MnuoWht3rDjm0NU5hp+fD1ZKY0bbBHvZ9kCDQRWMabKxix1gyFXKG+no3g9S1nqJkWQB
        /ABo579hPLPweMtyNIoj0d+fzr0+HcrvtTDEbTi8LI2hGX9kaKKJFvQrBoQYj2U7F2+KPBhHi0m40
        NGPRSFdA==;
Date:   Fri, 18 Aug 2023 20:49:58 +0200
From:   Christoph Heiss <christoph@c8h4.io>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 6/7] btrfs-progs: subvol get-default: implement json
 format output
Message-ID: <3lbyyfxvfmud7m2m424byssc4x5axh77h7b3liestidrl5uepv@haxdyrxr7d7o>
References: <20230813094555.106052-1-christoph@c8h4.io>
 <20230813094555.106052-7-christoph@c8h4.io>
 <20230817200449.GX2420@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817200449.GX2420@twin.jikos.cz>
X-Authenticated-Id: christoph@c8h4.io
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Thanks for the feedback.

On Thu, Aug 17, 2023 at 10:04:49PM +0200, David Sterba wrote:
>
> On Sun, Aug 13, 2023 at 11:45:01AM +0200, Christoph Heiss wrote:
> > Implements JSON-formatted output for the `subvolume get-default` command
> > using the `--format json` global option, much like it is implemented for
> > other commands.
> >
> > Signed-off-by: Christoph Heiss <christoph@c8h4.io>
> > ---
> >  cmds/subvolume.c | 27 +++++++++++++++++++++++----
> >  1 file changed, 23 insertions(+), 4 deletions(-)
> >
> > diff --git a/cmds/subvolume.c b/cmds/subvolume.c
> > index cb863ac7..f7076655 100644
> > --- a/cmds/subvolume.c
> > +++ b/cmds/subvolume.c
> > [..]
> > @@ -748,8 +758,17 @@ static int cmd_subvolume_get_default(const struct cmd_struct *cmd, int argc, cha
> >  		goto out;
> >  	}
> >
> > -	pr_verbose(LOG_DEFAULT, "ID %" PRIu64 " gen %" PRIu64 " top level %" PRIu64 " path %s\n",
> > -	       subvol.id, subvol.generation, subvol.parent_id, path);
> > +	if (bconf.output_format == CMD_FORMAT_JSON) {
> > +		fmt_start(&fctx, btrfs_subvolume_rowspec, 1, 0);
> > +		fmt_print(&fctx, "ID", subvol.id);
> > +		fmt_print(&fctx, "gen", subvol.generation);
> > +		fmt_print(&fctx, "top level", subvol.parent_id);
> > +		fmt_print(&fctx, "path", path);
> > +		fmt_end(&fctx);
>
> Such block can be in a helper and used for 'list' and 'get-default' so
> it's unified.
Looks easy enough, I'll get on it.

>
> > +	} else {
> > +		pr_verbose(LOG_DEFAULT, "ID %" PRIu64 " gen %" PRIu64 " top level %" PRIu64 " path %s\n",
> > +		       subvol.id, subvol.generation, subvol.parent_id, path);
>
> The formatter always prints '\n' at the end of the plain text values, so
> with a minor update the same helper can be used to produce the plain
> output.
Ditto.
