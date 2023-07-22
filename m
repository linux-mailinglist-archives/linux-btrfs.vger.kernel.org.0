Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874AD75DE27
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Jul 2023 21:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjGVTH2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 22 Jul 2023 15:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGVTH1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 22 Jul 2023 15:07:27 -0400
Received: from zmcc-3-mx.zmailcloud.com (zmcc-3-mx.zmailcloud.com [34.200.143.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECD8E45
        for <linux-btrfs@vger.kernel.org>; Sat, 22 Jul 2023 12:07:26 -0700 (PDT)
Received: from zmcc-3.zmailcloud.com (183.87.154.104.bc.googleusercontent.com [104.154.87.183])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by zmcc-3-mx.zmailcloud.com (Postfix) with ESMTPS id 99C7D40571;
        Sat, 22 Jul 2023 14:17:17 -0500 (CDT)
Received: from zmcc-3.zmailcloud.com (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPS id 332828037734;
        Sat, 22 Jul 2023 14:07:25 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTP id 22ABD8037742;
        Sat, 22 Jul 2023 14:07:25 -0500 (CDT)
Received: from zmcc-3.zmailcloud.com ([127.0.0.1])
        by localhost (zmcc-3-mta-1.zmailcloud.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id X-oyRT1Li-Pk; Sat, 22 Jul 2023 14:07:25 -0500 (CDT)
Received: from [10.4.2.11] (unknown [191.96.227.33])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPSA id A818C8037734;
        Sat, 22 Jul 2023 14:07:24 -0500 (CDT)
Date:   Sat, 22 Jul 2023 15:07:17 -0400
From:   Eric Levy <contact@ericlevy.name>
Subject: Re: race condition mounting multi-device iscsi volume, not resolved
 in newer kernels
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Message-Id: <54P7YR.LGLFEH7DB1TH2@ericlevy.name>
In-Reply-To: <f13b2a96-a8d2-0e4e-3667-ee76e4094b9f@oracle.com>
References: <c7aec65c5a94c32d9a2325ad3ad5c15ee94e5463.camel@ericlevy.name>
        <f13b2a96-a8d2-0e4e-3667-ee76e4094b9f@oracle.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On Sat, Jul 22 2023 at 07:50:38 PM +0800, Anand Jain 
<anand.jain@oracle.com> wrote

>>  Hm. Do you mean the filesystem is in an inconsistent state after
>  the manual successful manual mount? Do you have any error/warn logs?
>  What tells you that the filesysem is inconsistent?

The state inconsistency refers to the mount session not to the file 
system. The file system is completely healthy, having been cleanly 
unmounted during the previous shutdown sequence, and no mount operation 
having been completed during the current boot session.

However, within the running session, the system reports the file system 
being already mounted, when mounting is attempted, even though the 
mount point is empty and the mount operation had produced failure 
messages.

> Devid 8! How many devices do we have to this fsid?
> As before do you have the dump-super?
> 
> Do you have -o degraded in the mount option?
> 
> Before (what ever is) calling the mount has it run
>  btrfs device scan  ?

The system has eight devices. The first two are system devices, the 
remaining ones comprise the spanned volume.

I have not attempted mounting in degraded mode, nor would I do so, 
since the file system itself is healthy, and I wish to keep it as such. 
All of the failures have been failures to mount due to some devices 
being unattached. As long as the system is not mounting cleanly, then 
not mounting remains preferred, to maintain its health.

> So what is the time diff between above two messages?
> Already mounted => might be due to a race condition?

I could check the timestamps, but the differences I am certain are less 
than one second. The messages are printed sequentially, and operations 
are clearly not in the preferred order. Mounting should not be 
attempted until all devices are attached.

> Scanned messages appearing after the an attempt to mount so for sure 
> mount shall fail.

Right.




