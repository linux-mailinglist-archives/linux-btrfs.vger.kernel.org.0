Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594CA43FE60
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Oct 2021 16:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhJ2OYZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Oct 2021 10:24:25 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56294 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbhJ2OYZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Oct 2021 10:24:25 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B6A761FD5F;
        Fri, 29 Oct 2021 14:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635517315;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jFAPSe5jWTXf+GhXzLli9NjTlFlb2QBwSmv6rU8dp7w=;
        b=dehN3WzJSYHTIeVQuI4DwKHgz18i4NYdVOY+K/HI/7jbJiE94dI3pdoVCmAgXKSwLuZHxK
        k/4LsrusPq2X2s2Wxakzzr5ctC6Fw6CIEICOWx7Yw/uP8VX0xI300Y4IyQrfPICFBlmEZY
        vsB2F5CGyBk1FhwPoVepDiRHF49tza0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635517315;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jFAPSe5jWTXf+GhXzLli9NjTlFlb2QBwSmv6rU8dp7w=;
        b=xoachcckKxt7kn+bAdgi/ZzV/8GKai20Sr2i8SjhNEo75RxwQMxpJtD0Pzi5O9oij8N5cA
        blBBtRKUZcV53hDQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id AF6FBA3B81;
        Fri, 29 Oct 2021 14:21:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 73FF8DA7A9; Fri, 29 Oct 2021 16:21:22 +0200 (CEST)
Date:   Fri, 29 Oct 2021 16:21:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Jingyun He <jingyun.ho@gmail.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: unable to run mkfs.btrfs for host managed sata hdd
Message-ID: <20211029142121.GD20319@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Jingyun He <jingyun.ho@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CAHQ7scWxVCuQkbtY_dTo3rPoW+J0ofADW4GYGDMb_bfcha81CA@mail.gmail.com>
 <20211029132232.GA20319@twin.jikos.cz>
 <CAHQ7scV9i_s3gEXXki_U+RmqWLHu-DMWF_kzXFWKgOtqBQhvhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHQ7scV9i_s3gEXXki_U+RmqWLHu-DMWF_kzXFWKgOtqBQhvhA@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 29, 2021 at 09:52:34PM +0800, Jingyun He wrote:
> Hi,
> Thanks for your reply,
> I run these commands under root account.
> 
> After debugging this furthermore,
> 
> The issue looks like LSI 2308 doesn't report it as a host managed device.
> 
> If I connect it to the onboard SATA port, everything is working fine.
> 
> I'm not sure if there is any method to run mkfs.btrfs forcely, as even
> LSI 2308 didn't report it as a host managed device, but it can pass
> most of the libzbc tests.

mkfs relies on the kernel interfaces to access the zone information, ie.
the ioctls to report and reset the zones. AFAIK libzbc works in a
different way and tracks the zone information outside of the device and
can work as an emulation layer.

https://zonedstorage.io/projects/libzbc/
"libzbc command implementation is compliant with the latest published
versions of the ZBC and ZAC standards defined by INCITS technical
committees T10 and T13 (respectively)."

You could connect the two together so there's normal block device that
also works as a native host-managed zoned devices.  For testing I've
been using TCMU runner that utilizes the libzbc library and exports the
block devices backed by file images.

But if the problem is on the lower layer where the LSI controller does
not pass the ZBC ioctls at all I don't see a way how you could use the
combination because simply calling zone reset would not work and that's
quite fundamental limitation.
