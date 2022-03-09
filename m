Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E9F4D2FCD
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 14:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbiCINT1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 08:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233075AbiCINTW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 08:19:22 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1301786AB
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 05:17:55 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id m2so1964451pll.0
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Mar 2022 05:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xx9QprF4jaqnTqUiWJNT9tupIcIGoGm9XrKcxm/ikO8=;
        b=UXGKTif9qj9cEDbfoOpwsb0S1c5hvI5OE3ChpCeq/3ETm5uJB8mOVChFN5jo5eN3q6
         /CTSIUlFlZc8rRti08kIwWMgQ55vbDdrKTwuwIRebsYuzJxdFbU26qFnW8qzHsuk/pWD
         g4mS889e/Dcejqo2fzVC73rCLBaDE+lBxGhqTNkBA7QqkCKf7TbLHKe35L8FZizjud6z
         Q/AZNyganJCNMM93BXS9cSDiVFaBLMKBW/y7CUu6dbhUjofQ3bBJmlGT+KZiNKWxBXsH
         Tc07lsKI2rAuqY4ZroJKEDaTKYeUSJlCj0vz0uvAP5ADzZgG0fyBJcC6Of6X1kA/SmHe
         ntjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xx9QprF4jaqnTqUiWJNT9tupIcIGoGm9XrKcxm/ikO8=;
        b=LyhOQckX9SD2Ll6YVyeqz9PD6OzNS4RFX5puY/3BPdhJsbIAtk1actLRjvf/DzETam
         +hK8nn6XeJqcW8jlRQ4UG0i0zDWqwMz4YTvM/FdxXgRDGn86+IhoalMERukb1W157gps
         uh0opWtEmzKTlGWm90+lVuFf9VGabomNRDaDTDHvbekk3x2QE1b+yE4UGtXagEA3DAQt
         Aj+vsmKxttLqNrVFYDyz2je0HrCdr1GMUrj4z2hteEzsmFDMIh2JITcAETmhDgw7CJfE
         W5UksIS3PS6mKDqUZuMxuRnMYkBAKV3lWfmPIRcPj/+q+6/Liutq2FROZIYuLCjFwi3/
         WmNw==
X-Gm-Message-State: AOAM533avraWbrecQIxxi1PZmS9/Ht9fZRj57Nx7XM2fErKPEx4kmuND
        SDX5ap0Q7Kg6bKcL6Aw6ueE=
X-Google-Smtp-Source: ABdhPJy6R5l/SP8WvuO6RpBChQk5vqhItHGzceJK+xRZi3Ryrkyxc3hZtvng/HRzA4EGqwhhwtdUfg==
X-Received: by 2002:a17:90a:1f08:b0:1bc:1b9f:9368 with SMTP id u8-20020a17090a1f0800b001bc1b9f9368mr10416296pja.63.1646831875102;
        Wed, 09 Mar 2022 05:17:55 -0800 (PST)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id t8-20020a056a00138800b004f724e9fb3esm3150429pfg.89.2022.03.09.05.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 05:17:54 -0800 (PST)
Date:   Wed, 9 Mar 2022 13:17:45 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs-progs: subvolme: remove unused options for
 create and snapshot
Message-ID: <20220309131745.GA46482@realwakka>
References: <20220309081418.46215-1-realwakka@gmail.com>
 <4a594830-8a8c-dbe3-15d0-1a62a1adfaa2@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a594830-8a8c-dbe3-15d0-1a62a1adfaa2@gmx.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 09, 2022 at 04:52:15PM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/3/9 16:14, Sidong Yang wrote:
> > There are options '-c' in create subvolume and '-c' and '-x' in
> > snapshot. And the codes about them is there, but not in the manual or
> > help. This codes should be removed to avoid confusion.
> 
> I'd like more explanation on why we don't use it.
> 
> In fact the truth is, those -c/-x allows us to directly copy qgroup
> numbers from other subvolumes when creating subvolume.
> 
> This is definitely going to screw up qgroup numbers.

Actually, I don't understand that you said this option screw up qgroup
numbers. Could you explain more?
I checked that -c/-x options are not working. The commands are like
below.

# btrfs qgroup create 1/0 /mnt
# btrfs qgroup create 1/1 /mnt
# btrfs subvol create -c 1/0:1/1 /mnt/a

But it's not working. It seems that it ignores btrfs_qgroup_inherit
argument. New subvolume doesn't inherit anything.

> 
> Nowadays btrfs qgroup will automatically inherit the qgroup numbers when
> -i option is used.

Totally agree. -i option is enough to use.

Thanks,
Sidong
> 
> So the old -c/-x is no longer needed, and any inexperienced usage of
> them will lead to inconsistent qgroup numbers anyway.
> 
> Thanks,
> Qu
> 
> > 
> > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > ---
> >   cmds/subvolume.c | 25 ++-----------------------
> >   1 file changed, 2 insertions(+), 23 deletions(-)
> > 
> > diff --git a/cmds/subvolume.c b/cmds/subvolume.c
> > index fbf56566..408aebee 100644
> > --- a/cmds/subvolume.c
> > +++ b/cmds/subvolume.c
> > @@ -108,18 +108,11 @@ static int cmd_subvol_create(const struct cmd_struct *cmd,
> > 
> >   	optind = 0;
> >   	while (1) {
> > -		int c = getopt(argc, argv, "c:i:");
> > +		int c = getopt(argc, argv, "i:");
> >   		if (c < 0)
> >   			break;
> > 
> >   		switch (c) {
> > -		case 'c':
> > -			res = btrfs_qgroup_inherit_add_copy(&inherit, optarg, 0);
> > -			if (res) {
> > -				retval = res;
> > -				goto out;
> > -			}
> > -			break;
> >   		case 'i':
> >   			res = btrfs_qgroup_inherit_add_group(&inherit, optarg);
> >   			if (res) {
> > @@ -541,18 +534,11 @@ static int cmd_subvol_snapshot(const struct cmd_struct *cmd,
> >   	memset(&args, 0, sizeof(args));
> >   	optind = 0;
> >   	while (1) {
> > -		int c = getopt(argc, argv, "c:i:r");
> > +		int c = getopt(argc, argv, "i:r");
> >   		if (c < 0)
> >   			break;
> > 
> >   		switch (c) {
> > -		case 'c':
> > -			res = btrfs_qgroup_inherit_add_copy(&inherit, optarg, 0);
> > -			if (res) {
> > -				retval = res;
> > -				goto out;
> > -			}
> > -			break;
> >   		case 'i':
> >   			res = btrfs_qgroup_inherit_add_group(&inherit, optarg);
> >   			if (res) {
> > @@ -563,13 +549,6 @@ static int cmd_subvol_snapshot(const struct cmd_struct *cmd,
> >   		case 'r':
> >   			readonly = 1;
> >   			break;
> > -		case 'x':
> > -			res = btrfs_qgroup_inherit_add_copy(&inherit, optarg, 1);
> > -			if (res) {
> > -				retval = res;
> > -				goto out;
> > -			}
> > -			break;
> >   		default:
> >   			usage_unknown_option(cmd, argv);
> >   		}
