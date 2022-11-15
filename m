Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8260062A185
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 19:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiKOSpd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 13:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiKOSpd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 13:45:33 -0500
Received: from zmcc-3-mx.zmailcloud.com (zmcc-3-mx.zmailcloud.com [34.200.143.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC44865F2
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 10:45:31 -0800 (PST)
Received: from zmcc-3.zmailcloud.com (183.87.154.104.bc.googleusercontent.com [104.154.87.183])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by zmcc-3-mx.zmailcloud.com (Postfix) with ESMTPS id D74674056B
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 12:49:23 -0600 (CST)
Received: from zmcc-3.zmailcloud.com (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPS id B0E3E8036FAD
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 12:45:30 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTP id A248B8036FB3
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 12:45:30 -0600 (CST)
Received: from zmcc-3.zmailcloud.com ([127.0.0.1])
        by localhost (zmcc-3-mta-1.zmailcloud.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id skqQg1ae4PFA for <linux-btrfs@vger.kernel.org>;
        Tue, 15 Nov 2022 12:45:30 -0600 (CST)
Received: from [10.4.2.11] (unknown [37.19.198.182])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPSA id 28C7E8036FAD
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 12:45:29 -0600 (CST)
Date:   Tue, 15 Nov 2022 13:45:23 -0500
From:   Eric Levy <contact@ericlevy.name>
Subject: Re: property designating root subvolumes
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Message-Id: <N3KELR.FXYFWHCH7XYX2@ericlevy.name>
In-Reply-To: <ba47a0c3-ae7b-8aa9-96fd-2f1eab6e3885@libero.it>
References: <VB2DLR.FVM1D1665BSY2@ericlevy.name>
        <ba47a0c3-ae7b-8aa9-96fd-2f1eab6e3885@libero.it>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Tue, Nov 15 2022 at 07:23:21 PM +0100, Goffredo Baroncelli 
<kreijack@libero.it> wrote:
> I don't know rEFInd very well, but I don't think that it is job of 
> the bootloader to do the automatic OS discovery.
> 
> If you want to perform an OS discovery, at first it would be enough 
> to check the presence of "/bin/init" (or /init or ...) for linux and 
> the equivalent for Windows and OS-X.
> But this will not give the information like:
> 	- os name
> 	- initrd
> 	- the linux boot parameter...
> 
> Some (most) setup have different boot entries for the same filesystem 
> (e.g. the standard one, and the emergency one).
> 
> I prefer the other way that it is used in the linux world: it is 
> responsibility of the os to inform the bootloader about its existence.
> Look at the BLS specification (even not so widespread adopted).

Yes, I respect the preference you have provided, but in a sense, merely 
affirming the preference is begging the larger question.

The intention of rEFInd is as a bootloader, though less advanced 
overall than Grub, that is more user friendly, supporting autodiscovery 
of resident operating systems without needing to be preconfigured by 
tools installed on one of those operating systems. rEFInd does support 
some static configuration, similar to the Grub configuration system, 
but it is not generally required, and supported primarily as an 
afterthought, for advanced use cases not currently possible through the 
main method of on-the-fly autodetection.

Grub is planned primarily with the assumption that a single operating 
system, of some Linux variety, is the one dominantly used on a system, 
and all others, whether also Linux or not, are in some sense 
subordinate, installed only for occasional use. At times, such an 
assumption may be agreeable, but not always.

I think there is a place in the discussion for preferences about the 
design of the bootloader. However, I also think the discussion should 
not reject the historical observation, that due to demand for the 
feature, the default subvolume selector is being used, in a sense 
incorrectly, for detecting a root file system, because no better 
approach has been identified. Someone familiar with the nuances might 
try to discuss with the developer whether the suggested logic for 
detecting the root tree is a helpful approach, more so than using the 
default selector. If, from the standpoint of the bootloader, the 
approach of analyzing the file tree is more agreeable than using 
features of the file system, then perhaps the current request is not 
needed.

However, even so, I have concerns about desired handling of snapshots, 
as well as about the other reasons that a subvolume may appear 
internally as hosting a root tree, but not being desired for showing as 
an item in the boot menu.

Regardless, I suggest that the status quo deserves some inspection.


