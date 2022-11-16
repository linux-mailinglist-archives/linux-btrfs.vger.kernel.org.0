Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC40B62CCE8
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Nov 2022 22:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbiKPVqb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Nov 2022 16:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbiKPVqa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Nov 2022 16:46:30 -0500
X-Greylist: delayed 466 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Nov 2022 13:46:27 PST
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [213.138.97.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B167513DDD
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Nov 2022 13:46:27 -0800 (PST)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id CFE999B805; Wed, 16 Nov 2022 21:38:39 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1668634719;
        bh=o5XiCHkrc+ogH+flv/Ha3klZuzGAyJDWD6u5NgtAlSs=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=x44IPuEwekGoj3G7Bz+c2kjTlDzFii/aNArnljK0a1KUflJxNN+D6a1JJfIb7DAiN
         3EfAIoJwi0/UsADjlKXOGPFmmmViiaAI3lCBkuYzpDUY/xN41MgS7VTIsd4uXP3F4V
         kAGKZVznCYbb/tbNuvOoZf1ZjdJ+NJZwtE3DoMiijwfSJ9orAs3mRxBOn33CW21T9y
         YuB0bwn2IWZIGINSOpPZ/bywF6nGMTSXcravwP5SinwFf/aP6CGbKtXCnqSDoX5JAx
         mddDliFj+ND0wnCXb2vMcwrdwDlR/t0qXDXwCVwDi6iRd74v512cIJVb7D1DG8PBNl
         Ku15MctlvCXJQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 03B519B6A5;
        Wed, 16 Nov 2022 21:37:50 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1668634670;
        bh=o5XiCHkrc+ogH+flv/Ha3klZuzGAyJDWD6u5NgtAlSs=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=OebONA8RTgNc50+nc/t6kpHcL2ku4X9tmGLW4UpY2tOnaG992t3ojOLA3faMGTjTR
         BFaPshWQ668VllonKS347IY4lYg8bOaP83OnlkSHFaCJvPRf/YsNHnO5rYkOENeM56
         iQMPkX6qRCeU1QD2D4ACF86pPP24TmSkupYahh65X4xUJZL+r34vNXjEYgoaFerZnX
         ArxgOHxqL3cZXyDFoaWJHHAJ3WDTqJHDq3W7O/zEJ904MFZ+aW7RHNirugqTl1nO8Q
         1VYDGZlmufpUAO4xg6w/J9YXDMIGjFMZ55xWe+vR3Y+NIoiJxiDsHrzdvndkbA17kA
         om51xH72NQDNg==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id D38EE289455;
        Wed, 16 Nov 2022 21:37:49 +0000 (GMT)
Message-ID: <0004f4a3-f68d-ffea-cedd-3d70177c28d7@cobb.uk.net>
Date:   Wed, 16 Nov 2022 21:37:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Subject: Re: property designating root subvolumes
Content-Language: en-US
To:     Eric Levy <contact@ericlevy.name>, kreijack@inwind.it
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <VB2DLR.FVM1D1665BSY2@ericlevy.name>
 <ba47a0c3-ae7b-8aa9-96fd-2f1eab6e3885@libero.it>
 <N3KELR.FXYFWHCH7XYX2@ericlevy.name>
 <b31bfe5a-ae85-2ea0-da65-698e095cc180@libero.it>
 <JELGLR.YEZIP9YROWNN3@ericlevy.name>
In-Reply-To: <JELGLR.YEZIP9YROWNN3@ericlevy.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 16/11/2022 21:08, Eric Levy wrote:
> 
> 
> On Wed, Nov 16 2022 at 08:09:05 PM +0100, Goffredo Baroncelli
> <kreijack@libero.it> wrote:
>>> The intention of rEFInd is as a bootloader, though less advanced
>>> overall than Grub, that is more user friendly, supporting
>>> autodiscovery of resident operating systems without needing to be
>>> preconfigured by tools installed on one of those operating systems.
>>> rEFInd does support some static configuration, similar to the Grub
>>> configuration system, but it is not generally required, and supported
>>> primarily as an afterthought, for advanced use cases not currently
>>> possible through the main method of on-the-fly autodetection.
>>>
>>
>> My point is that the "on fly autodetection", is more complex than find
>> the root of the filesystem, which is indeed quite trivial (e.g.
>> looking ad /bin/init or /init or /sbin/init); the snapshot is a bit
>> more challenging, but due the fact that these have a pointer to the
>> parent (PARENT_UUID) is still doable.
> 
> The way I was framing the conversation is that inspecting the files in a
> subvolume is one way to achieve "on-the-fly autodetection", in contrast
> to other approaches, current or hypothetical. It tends to loose the
> point of my concerns to suggest that the bootloader such as rEFInd ought
> to use an approach more similar to the one used by Grub. Being oriented
> toward autodetection is the overarching design choice of rEFInd, and
> this broad distinction gives it a reason to exist, instead of simply
> being a direct competitor or clone of Grub.
> 
>> The concept of "default subvolume" doesn't mix well with "multiple os
>> on the same filesystem"; in my setups  I prefer to pass the root
>> subvolume in the commandline (e.g. 'rootflags=subvol=@rootfs');
>> recently I discovered that Debian does the same thing.
> 
> Yes, but again, isn't it missing the point, that the default subvolume
> may be used as an alternative to the subvolume argument, but not so in a
> way that generalizes well for multiple resident OSs?

So, what you are asking for is the ability to add some information to a
btrfs filesystem listing a set of possible "alternate default"
subvolumes. How any user, OS, application or boot manager might use that
information is unspecified and up to them. It would have no impact on
btrfs behaviour - just provide a useful place to store some hints for
alternative subvolumes users or applications might choose to try to
mount as the filesystem root subvolume if they want. It wouldn't
interact with the existing concept of setting a default subvolume - it
would just be hint to users that here are some other subvolumes they
might want to try mounting.

rEFInd could, if it wished, look that list of alternates and create
choices for trying to boot using each of those subvolumes as the mount
point. What happens then would depend on what the user had put in those
subvolumes.

Graham
