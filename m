Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92D13E5E57
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Aug 2021 16:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241891AbhHJOsR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Aug 2021 10:48:17 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39216 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241888AbhHJOsR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Aug 2021 10:48:17 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A535922069;
        Tue, 10 Aug 2021 14:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628606873;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZXgUDpthW2OynnerkUSI9ncot/jTWw3Mje0HGVpvSOk=;
        b=B4snsSGjvqXYEDt7EW2kCxQaLSPWgr92uic0ZyPn7howDUGh1lrPItNbXjWzec1tGBB+m1
        QvwSU0+FDF41LS1QrLE1XKOvNJqRE4qBPxAOl1w2OPDvd9b44Ll6ceOX0VJ6qD12bWb0PC
        KR1hvhQnAbcyJNDNNyDsVBf6+XhgZtE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628606873;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZXgUDpthW2OynnerkUSI9ncot/jTWw3Mje0HGVpvSOk=;
        b=kXrET8bwDB4LJEwOvResuNqKaxrA9xE42Jik6S40kcY7CSgp8x32EkGrEx5iDSwmCGXKOd
        O9nR2z7X/a93cyBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 9BD40A3B89;
        Tue, 10 Aug 2021 14:47:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5E0F6DA880; Tue, 10 Aug 2021 16:45:01 +0200 (CEST)
Date:   Tue, 10 Aug 2021 16:45:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: sysfs: map sysfs files to their path
Message-ID: <20210810144501.GY5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <437f0a236348a3376ac2baeab564460491c7fa12.1628603355.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437f0a236348a3376ac2baeab564460491c7fa12.1628603355.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 10, 2021 at 09:55:59PM +0800, Anand Jain wrote:
> Sysfs file has grown big. It takes some time to locate the correct
> struct attribute to add new files. Create a table and map the
> struct attribute to its sysfs path.
> 
> Also, fix the comment about the debug sysfs path.
> And add the comments to the attributes instead of attribute group,
> where sysfs file names are defined.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2: Add sysfs path in the attribute definitions.

Thanks, I've reworded and reformatted some of the comments. Added to
misc-next.

> + * qgroup_attrs				/sys/fs/btrfs/<uuid>/qgroups/<subvol-id>

This is not subvolid but the "level_qgroupid" formatted qgroup id.
