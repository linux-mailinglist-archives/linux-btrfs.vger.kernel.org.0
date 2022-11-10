Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F3E62439F
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Nov 2022 14:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbiKJNvL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Nov 2022 08:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiKJNvH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Nov 2022 08:51:07 -0500
Received: from zmcc-3-mx.zmailcloud.com (zmcc-3-mx.zmailcloud.com [34.200.143.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0F718B18
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 05:51:05 -0800 (PST)
Received: from zmcc-3.zmailcloud.com (183.87.154.104.bc.googleusercontent.com [104.154.87.183])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by zmcc-3-mx.zmailcloud.com (Postfix) with ESMTPS id C30BC405D4
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 07:54:54 -0600 (CST)
Received: from zmcc-3.zmailcloud.com (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPS id CA4518037774
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 07:51:04 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTP id BAE42803778C
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 07:51:04 -0600 (CST)
Received: from zmcc-3.zmailcloud.com ([127.0.0.1])
        by localhost (zmcc-3-mta-1.zmailcloud.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id j5pO3B6K4GlG for <linux-btrfs@vger.kernel.org>;
        Thu, 10 Nov 2022 07:51:04 -0600 (CST)
Received: from [10.4.2.11] (unknown [37.19.198.182])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPSA id 6C1488037774
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 07:51:03 -0600 (CST)
Date:   Thu, 10 Nov 2022 08:50:57 -0500
From:   Eric Levy <contact@ericlevy.name>
Subject: Re: option to mount read-only subvolume with read-write access
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Message-Id: <X4X4LR.21Q66E3SQOHF@ericlevy.name>
In-Reply-To: <20221110121249.GE5824@twin.jikos.cz>
References: <G1N4LR.84UPK81F80SK3@ericlevy.name>
        <20221110121249.GE5824@twin.jikos.cz>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_20,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



> So that would be a silent change in the subvolume and not detectable 
> by
> eg. checking the generation. That would break incremental send at 
> least
> and goes against the point of read-only subvolume.

> Yeah but the other mount points would see the old data, depending on 
> the
> cached status of the blocks.

Perhaps a different feature would be needed, then, of a new property 
that makes a subvolume appear as read-only, at least from the 
standpoint of the VFS, when accessed through a mount point higher on 
the file tree, but not when mounted directly.

>> I think it does not have a well defined semantics, what you ask 
>> seems to
> be some kind of multi headed subvolume that could appear different
> depending on the way it's accessed from the VFS mount point which is 
> out
> of reach in many cases.

I'm not sure whether this means the same as I just wrote, or not.

> I'd probably need to understand what you mean in the first sentence 
> "At
> times it is helpful", I don't have an idea where it would be helpful.

In some scenarios, upcoming changes to a file tree, intended to become 
the default mounts in future boot sessions, will be staged in a closed 
environment, which may include use of "chroot". It is helpful for the 
subvolume to be read-write in the environment created by temporary 
mount points, but still protected from accidental modification through 
its physical location on the root tree.




