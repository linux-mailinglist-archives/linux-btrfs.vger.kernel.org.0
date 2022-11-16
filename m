Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DF962CC52
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Nov 2022 22:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbiKPVKC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Nov 2022 16:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239222AbiKPVJq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Nov 2022 16:09:46 -0500
Received: from zmcc-3-mx.zmailcloud.com (zmcc-3-mx.zmailcloud.com [34.200.143.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61744B99D
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Nov 2022 13:08:51 -0800 (PST)
Received: from zmcc-3.zmailcloud.com (183.87.154.104.bc.googleusercontent.com [104.154.87.183])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by zmcc-3-mx.zmailcloud.com (Postfix) with ESMTPS id DBBA840586;
        Wed, 16 Nov 2022 15:12:44 -0600 (CST)
Received: from zmcc-3.zmailcloud.com (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPS id 063698036FCD;
        Wed, 16 Nov 2022 15:08:51 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTP id EB9CD8036FE1;
        Wed, 16 Nov 2022 15:08:50 -0600 (CST)
Received: from zmcc-3.zmailcloud.com ([127.0.0.1])
        by localhost (zmcc-3-mta-1.zmailcloud.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PPZRPD3aH-FR; Wed, 16 Nov 2022 15:08:50 -0600 (CST)
Received: from [10.4.2.11] (unknown [37.19.198.182])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPSA id 741C68036FCD;
        Wed, 16 Nov 2022 15:08:50 -0600 (CST)
Date:   Wed, 16 Nov 2022 16:08:43 -0500
From:   Eric Levy <contact@ericlevy.name>
Subject: Re: property designating root subvolumes
To:     kreijack@inwind.it
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Message-Id: <JELGLR.YEZIP9YROWNN3@ericlevy.name>
In-Reply-To: <b31bfe5a-ae85-2ea0-da65-698e095cc180@libero.it>
References: <VB2DLR.FVM1D1665BSY2@ericlevy.name>
        <ba47a0c3-ae7b-8aa9-96fd-2f1eab6e3885@libero.it>
        <N3KELR.FXYFWHCH7XYX2@ericlevy.name>
        <b31bfe5a-ae85-2ea0-da65-698e095cc180@libero.it>
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



On Wed, Nov 16 2022 at 08:09:05 PM +0100, Goffredo Baroncelli 
<kreijack@libero.it> wrote:
>> The intention of rEFInd is as a bootloader, though less advanced 
>> overall than Grub, that is more user friendly, supporting 
>> autodiscovery of resident operating systems without needing to be 
>> preconfigured by tools installed on one of those operating systems. 
>> rEFInd does support some static configuration, similar to the Grub 
>> configuration system, but it is not generally required, and 
>> supported primarily as an afterthought, for advanced use cases not 
>> currently possible through the main method of on-the-fly 
>> autodetection.
>> 
> 
> My point is that the "on fly autodetection", is more complex than 
> find the root of the filesystem, which is indeed quite trivial (e.g. 
> looking ad /bin/init or /init or /sbin/init); the snapshot is a bit 
> more challenging, but due the fact that these have a pointer to the 
> parent (PARENT_UUID) is still doable.

The way I was framing the conversation is that inspecting the files in 
a subvolume is one way to achieve "on-the-fly autodetection", in 
contrast to other approaches, current or hypothetical. It tends to 
loose the point of my concerns to suggest that the bootloader such as 
rEFInd ought to use an approach more similar to the one used by Grub. 
Being oriented toward autodetection is the overarching design choice of 
rEFInd, and this broad distinction gives it a reason to exist, instead 
of simply being a direct competitor or clone of Grub.

> The concept of "default subvolume" doesn't mix well with "multiple os 
> on the same filesystem"; in my setups  I prefer to pass the root 
> subvolume in the commandline (e.g. 'rootflags=subvol=@rootfs'); 
> recently I discovered that Debian does the same thing.

Yes, but again, isn't it missing the point, that the default subvolume 
may be used as an alternative to the subvolume argument, but not so in 
a way that generalizes well for multiple resident OSs?


>> 
>> However, even so, I have concerns about desired handling of 
>> snapshots, as well as about the other reasons that a subvolume may 
>> appear internally as hosting a root tree, but not being desired for 
>> showing as an item in the boot menu.
>> 
> About this point I agree more, but from a different point of view:
> - the subvolume is the unit of snapshot
> - a filesystem may be composed by different subvolumes (e.g. @boot, 
> @log, @portables mounted over @rootfs)
> - each subvolume may have different snapshot policy
> - assuming that the place of a subvolume doesn't change over the time 
> in the filesystem, I would like to find a filesystem layout where it 
> is possible to mount a full filesystem or its snapshot with only a 
> command.

I believe that presently, it is possible to revert to a previous 
snapshot of the root subvolume in any of three ways, 1) changing the 
location of the snapshot to replace the main subvolume, 2) changing the 
bootloader or system configurations to select the correct subvolume, 
and 3) changing the subvolume selected for default mounting, assuming 
none is configured explicitly.

The first two are generally drastic, whereas the the latter is trivial. 
It is, however, limited, due to requiring that one operating system 
"take over" the entire file system, in the sense of using a resource of 
which the entire file system provides only one, the selection of the 
default subvolume.

The main topic is how to designate certain subvolumes as bootable, if 
the count of such subvolumes is desired as being more than one, but not 
necessarily as many as the total count of snapshots, in a way that is 
nearly as straightforward as changing the default subvolume.
> 


