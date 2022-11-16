Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487D462CE70
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Nov 2022 00:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbiKPXA5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Nov 2022 18:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234494AbiKPXAy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Nov 2022 18:00:54 -0500
Received: from zmcc-3-mx.zmailcloud.com (zmcc-3-mx.zmailcloud.com [34.200.143.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D2620189
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Nov 2022 15:00:52 -0800 (PST)
Received: from zmcc-3.zmailcloud.com (183.87.154.104.bc.googleusercontent.com [104.154.87.183])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by zmcc-3-mx.zmailcloud.com (Postfix) with ESMTPS id DBB5C4058D;
        Wed, 16 Nov 2022 17:04:45 -0600 (CST)
Received: from zmcc-3.zmailcloud.com (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPS id E72CB80366CB;
        Wed, 16 Nov 2022 17:00:51 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTP id D651A80366CC;
        Wed, 16 Nov 2022 17:00:51 -0600 (CST)
Received: from zmcc-3.zmailcloud.com ([127.0.0.1])
        by localhost (zmcc-3-mta-1.zmailcloud.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6Pl88CDFOXLg; Wed, 16 Nov 2022 17:00:51 -0600 (CST)
Received: from [10.4.2.11] (unknown [37.19.198.182])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPSA id 3760E80366CB;
        Wed, 16 Nov 2022 17:00:51 -0600 (CST)
Date:   Wed, 16 Nov 2022 18:00:44 -0500
From:   Eric Levy <contact@ericlevy.name>
Subject: Re: property designating root subvolumes
To:     Graham Cobb <g.btrfs@cobb.uk.net>
Cc:     kreijack@inwind.it, linux-btrfs <linux-btrfs@vger.kernel.org>
Message-Id: <8LQGLR.RPAKUCYFV70U1@ericlevy.name>
In-Reply-To: <0004f4a3-f68d-ffea-cedd-3d70177c28d7@cobb.uk.net>
References: <VB2DLR.FVM1D1665BSY2@ericlevy.name>
        <ba47a0c3-ae7b-8aa9-96fd-2f1eab6e3885@libero.it>
        <N3KELR.FXYFWHCH7XYX2@ericlevy.name>
        <b31bfe5a-ae85-2ea0-da65-698e095cc180@libero.it>
        <JELGLR.YEZIP9YROWNN3@ericlevy.name>
        <0004f4a3-f68d-ffea-cedd-3d70177c28d7@cobb.uk.net>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_05,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 16 2022 at 09:37:49 PM +0000, Graham Cobb 
<g.btrfs@cobb.uk.net> wrote:
>> So, what you are asking for is the ability to add some information 
>> to a
> btrfs filesystem listing a set of possible "alternate default"
> subvolumes. How any user, OS, application or boot manager might use 
> that
> information is unspecified and up to them. It would have no impact on
> btrfs behaviour - just provide a useful place to store some hints for
> alternative subvolumes users or applications might choose to try to
> mount as the filesystem root subvolume if they want. It wouldn't
> interact with the existing concept of setting a default subvolume - it
> would just be hint to users that here are some other subvolumes they
> might want to try mounting.

Not quite. It would make no difference whether there would one bootable 
subvolume or many, and none would be alternative less so than any 
other. The property simply would mark a subvolume as bootable, so it 
would not be necessary to utilize the default selector for such a 
purpose, with all of its various constraints or side effects. The 
property may be assigned to the default subvolume, or not, without 
either affecting the other.

> rEFInd could, if it wished, look that list of alternates and create
> choices for trying to boot using each of those subvolumes as the mount
> point. What happens then would depend on what the user had put in 
> those
> subvolumes.

Would you please elaborate? I'm not sure what you are suggesting beyond 
what has already been discussed.



