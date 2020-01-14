Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D174313B0A0
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2020 18:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgANROS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jan 2020 12:14:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:42390 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726971AbgANROS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jan 2020 12:14:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E0116AAC3;
        Tue, 14 Jan 2020 17:14:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 30232DA795; Tue, 14 Jan 2020 18:14:04 +0100 (CET)
Date:   Tue, 14 Jan 2020 18:14:03 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] More split-brain fixes for metadata uuid feature
Message-ID: <20200114171403.GH3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200110121135.7386-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110121135.7386-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 10, 2020 at 02:11:31PM +0200, Nikolay Borisov wrote:
> Here are 4 patches which fix a newly found split-brain scenario in the
> METADATA_UUID_INCOMPAT code. They are mostly the identical with Su's
> original submission but I have reworked the changelogs and some function
> names. Hence, I retained his authorship of the patches.
> 
> First 2 patches factor out some code with the hopes of making find_fisd a bit
> more readable and simplifying the myriad of nested 'if' in device_list_add.
> 
> Patch 3 extends find_fsid_changed to handle the case where a disk with
> METADATA_UUID_INCOMPAT and FSID_CHANGING_IN_PROGRESS is scanned after a disk
> which has successfully been switched to FSID == METADATA_UUID state and has
> created btrfs_fs_devices.
> 
> Patch 4 handles the counterpart situation - a fully switched disk is scanned
> after one which has had METADATA_UUID_INCOMPAT and FSID_CHANGING_IN_PROGRESS
> set.
> 
> This series should be applied to stable branches following 5.0 when the
> metadata_uuid feature got introduced.
> 
> This patchset was tested with btrfs-progs' misc 034-metadata-uuid test and a full
> xfstest run with no regressions. I will also be sending an improvement to the
> test case which exercises the newly added code.
> 
>   btrfs: Call find_fsid from find_fsid_inprogress
>   btrfs: Factor out metadata_uuid code from find_fsid.
>   btrfs: Handle another split brain scenario with metadata uuid feature
>   btrfs: Fix split-brain handling when changing FSID to metadata uuid

I'm adding it to for-next, thanks.
