Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305103EA7E3
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Aug 2021 17:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238255AbhHLPpA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Aug 2021 11:45:00 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49298 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237375AbhHLPo5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Aug 2021 11:44:57 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BA28D1FF5C;
        Thu, 12 Aug 2021 15:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628783071;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YBAP0c2aWOf2x2jeM2bxICD+UGK2lXSgMMt8bhtCkKo=;
        b=lSJ2s8Tfg9LmdJSLjnXj3k+89pxIsTjSy6sqqHhodf7Z0fHg66QgJuFp8sKyd2Swqi/XdZ
        D2I6o+HMsQThsYRL5JIppEu8tDiXRGLg922AOAuHfi1Rz9LlKa3kFuLKaO35xawr3obCBB
        UMU0iOhPqTEWmgrakGKA2wyttbCzKLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628783071;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YBAP0c2aWOf2x2jeM2bxICD+UGK2lXSgMMt8bhtCkKo=;
        b=rhxHhg6rMLoKaOYE4aRWsC34x+zM1b2Eh/yxuSOXoeDMJ8FlQG5BMb4CxJPPngb1rQtLEH
        71hDApZu5MjmpzCw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 8BCC7A3FA7;
        Thu, 12 Aug 2021 15:44:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 45A22DA733; Thu, 12 Aug 2021 17:41:37 +0200 (CEST)
Date:   Thu, 12 Aug 2021 17:41:36 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/8] fstests: add checks for testing zoned btrfs
Message-ID: <20210812154135.GK5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20210811151232.3713733-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811151232.3713733-1-naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 12, 2021 at 12:12:24AM +0900, Naohiro Aota wrote:
> This series revisit my old series to test zoned btrfs [1].
> 
> [1] https://lore.kernel.org/fstests/PH0PR04MB7416870032582BC2A8FC5AD99B299@PH0PR04MB7416.namprd04.prod.outlook.com/T/
> 
> Several tests are failing on zoned btrfs, but actually they are invalid.
> There are two reasons of the failures. One is creating too small
> filesystem. Since zoned btrfs needs at lease 5 zones (= 1.25 GB if zone
> size = 256MB) to create a filesystem, tests creating e.g., 1 GB filesystem
> will fail.
> 
> The other reason is lacking of zone support of some dm targets and loop
> device. So, they need to skip the test if the testing device is zoned.
> 
> Patches 1 to 4 handle the too small file system failure.
> 
> And, patches 5 to 8 add checks for tests requiring non-zoned devices.
> 
> Naohiro Aota (8):
>   common/rc: introduce minimal fs size check
>   common/rc: fix blocksize detection for btrfs
>   btrfs/057: use _scratch_mkfs_sized to set filesystem size
>   fstests: btrfs: add minimal file system size check
>   common: add zoned block device checks
>   shared/032: add check for zoned block device
>   fstests: btrfs: add checks for zoned block device
>   fstests: generic: add checks for zoned block device

I did a light review of the patches (no actual testing), all seem to be
doing the right thing regarding the special cases zoned mode needs, and
not changing the default use case.
