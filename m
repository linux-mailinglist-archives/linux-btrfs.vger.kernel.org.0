Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625204CBE92
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Mar 2022 14:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbiCCNMR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Mar 2022 08:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbiCCNMR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Mar 2022 08:12:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D372D186BAB
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Mar 2022 05:11:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7498461A0C
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Mar 2022 13:11:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF57C340ED;
        Thu,  3 Mar 2022 13:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646313090;
        bh=+tKnmcbmU4um3eNL6n0PG68J6gNu3+bBh4wP+F6Vrj4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iSg/OD6lBdUJbMCR4bSUGs3J6f7H+d7xKQGRfGp0ohIXK73uf8WqPZkkXIw98pep3
         fu7EfdtvnBDd3bJnUWy7i56ShDoehD8ao5MxUr5EZ+ftn7m5PUpDNVlBCngC4ncW6V
         KaOA0Wxeb2jUkGv2s71/PaOX1PhEvmGwdHHpuzCfLdJ+ODN2YzdA6/T733A0rrCv19
         M0VPNeGKsaJTbv0RYjkcDKeOSssD2z0Whln6ZMR5SXxdnFPilGyLmmiaBbypmNaxF9
         VxcAYr1VqnmkaJJ0DlRSxHldsMbcdG0/dT5Qpd7ZqYkD4rlSSuWs1uHLCsFWf9fx11
         JbUrxn/XTk3LQ==
Date:   Thu, 3 Mar 2022 13:11:27 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix a NULL pointer dereference during device scan
Message-ID: <YiC+f8U7KXf7aMsM@debian9.Home>
References: <f0a7cc9b024432855337990f471b91054504cc92.1646306515.git.fdmanana@suse.com>
 <32810467-bf93-d9bd-86eb-1fc313962198@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32810467-bf93-d9bd-86eb-1fc313962198@oracle.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 03, 2022 at 08:46:46PM +0800, Anand Jain wrote:
> On 03/03/2022 19:25, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> > 
> > At device_list_add(), we dereference a device's name inside a
> > btrfs_info_in_rcu() that is executed in a branch that can be triggered
> > when the device's name field is NULL, which obviously results in a NULL
> > pointer dereference as rcu_str_deref() tries to access the ->str
> > attribute of a NULL pointer to a struct rcu_string.
> 
> 
> A few lines above check if the device has the bdev, which means the
> device->name can not be null.

Right. I noticed that later and had replied about that before.
Thanks.

> 
> 925 if (device->bdev) {
> 
> Any idea how the test case could able to reach this condition?
> 
> Thanks, Anand
> 
> 
> > Fix that by not dereferencing the name if it's NULL, and instead print
> > the string "<unknown>".
> > 
> > Link: https://lore.kernel.org/linux-btrfs/00000000000066b78e05d94df48b@google.com/
> 
> 
> 
> 
> > Reported-by: syzbot+82650a4e0ed38f218363@syzkaller.appspotmail.com
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   fs/btrfs/volumes.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index fa7fee09e39b..f662423fbeb7 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -940,7 +940,9 @@ static noinline struct btrfs_device *device_list_add(const char *path,
> >   			}
> >   			btrfs_info_in_rcu(device->fs_info,
> >   	"devid %llu device path %s changed to %s scanned by %s (%d)",
> > -					  devid, rcu_str_deref(device->name),
> > +					  devid, device->name ?
> > +					  rcu_str_deref(device->name) :
> > +					  "<unknown>",
> >   					  path, current->comm,
> >   					  task_pid_nr(current));
> >   		}
> 
