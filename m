Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4091962479D
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Nov 2022 17:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbiKJQwt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Nov 2022 11:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbiKJQwd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Nov 2022 11:52:33 -0500
Received: from zmcc-3-mx.zmailcloud.com (zmcc-3-mx.zmailcloud.com [34.200.143.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33B3E3F
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 08:52:18 -0800 (PST)
Received: from zmcc-3.zmailcloud.com (183.87.154.104.bc.googleusercontent.com [104.154.87.183])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by zmcc-3-mx.zmailcloud.com (Postfix) with ESMTPS id 96ABD405F4
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 10:56:07 -0600 (CST)
Received: from zmcc-3.zmailcloud.com (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPS id 8AEC580366E1
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 10:52:17 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTP id 7C21880366E3
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 10:52:17 -0600 (CST)
Received: from zmcc-3.zmailcloud.com ([127.0.0.1])
        by localhost (zmcc-3-mta-1.zmailcloud.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6ajGVDqa8D-2 for <linux-btrfs@vger.kernel.org>;
        Thu, 10 Nov 2022 10:52:17 -0600 (CST)
Received: from [10.4.2.11] (unknown [37.19.198.182])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPSA id 2AA3F80366E1
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 10:52:16 -0600 (CST)
Date:   Thu, 10 Nov 2022 11:52:09 -0500
From:   Eric Levy <contact@ericlevy.name>
Subject: Re: option to mount read-only subvolume with read-write access
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Message-Id: <XI55LR.POZHOYS8LSAH3@ericlevy.name>
In-Reply-To: <CA+H1V9xCmejh0Tx80czJOqTVmwAM7gCwfKJzgW6Mmkwu+tObYg@mail.gmail.com>
References: <G1N4LR.84UPK81F80SK3@ericlevy.name>
        <20221110121249.GE5824@twin.jikos.cz> <X4X4LR.21Q66E3SQOHF@ericlevy.name>
        <CA+H1V9xCmejh0Tx80czJOqTVmwAM7gCwfKJzgW6Mmkwu+tObYg@mail.gmail.com>
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

On Thu, Nov 10 2022 at 11:46:38 AM -0500, Matthew Warren 
<matthewwarren101010@gmail.com> wrote:
>>  In some scenarios, upcoming changes to a file tree, intended to 
>> become
>>  the default mounts in future boot sessions, will be staged in a 
>> closed
>>  environment, which may include use of "chroot". It is helpful for 
>> the
>>  subvolume to be read-write in the environment created by temporary
>>  mount points, but still protected from accidental modification 
>> through
>>  its physical location on the root tree.
> 
> I think for that situation you'd want to make a snapshot of the
> subvolume (which is currently mounted read-only) and then modify it.
> You can then make the new subvolume have the name of the old
> subvolume. This should allow you to keep the old data in read-only
> until you reboot in which case the new data will be mounted.
> 
> Matthew Warren

It may work as well in many cases, but one limitation is that the child 
volume must reside permanently in the target location, or some other, 
until it replaces the parent volume.



