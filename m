Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC88443329
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Nov 2021 17:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbhKBQlZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Nov 2021 12:41:25 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55114 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234694AbhKBQks (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Nov 2021 12:40:48 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id AC1DD1FD29;
        Tue,  2 Nov 2021 16:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635870662;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/nqphC0GHU/mwtGP3QoAAZ3iOfU28/AoWyJ8DhTMMSw=;
        b=Tkyz7kodim5UFoW2fdLH7ow6pPJDm7cgSVrHNcqOkPiISwi/f4dI2SeYIzsflzzktBuAlG
        fHoBlJLQnEkMRLXksQM/m12YDnPy+bNOlJmzDBgS0GLK3G0QehHM2kMB50QWtH3WpU5sqX
        HB+gVxQGsg7XbpYHG+4UocMcsMlvFUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635870662;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/nqphC0GHU/mwtGP3QoAAZ3iOfU28/AoWyJ8DhTMMSw=;
        b=TYDDnAlhN6CX3+dBvxl4d7xgslM5gDNriHWCPT4k06NqmMuYGjPaBE6KOxRbHeGfxF27+z
        p0QyFaAx+am2qyBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 9EF7A2C144;
        Tue,  2 Nov 2021 16:31:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 604ABDA7A9; Tue,  2 Nov 2021 17:30:27 +0100 (CET)
Date:   Tue, 2 Nov 2021 17:30:27 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Forza <forza@tnonline.net>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Btrfs progs pre-release 5.15-rc1
Message-ID: <20211102163027.GN20319@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Forza <forza@tnonline.net>,
        linux-btrfs@vger.kernel.org
References: <20211029155346.19985-1-dsterba@suse.com>
 <38e1b33.df69821a.17cd0454b6b@tnonline.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38e1b33.df69821a.17cd0454b6b@tnonline.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Oct 30, 2021 at 10:16:14AM +0200, Forza wrote:
> 
> 
> ---- From: David Sterba <dsterba@suse.com> -- Sent: 2021-10-29 - 17:53 ----
> 
> > Hi,
> > 
> > this is a pre-release of btrfs-progs, 5.15-rc1 (version tag is v5.14.91).
> > 
> > The proper release is scheduled to next Friday, +7 days (2021-10-05).
> > 
> > The noticeable changes are in the mkfs defaults:
> > 
> >   * no-holes
> >   * free-space-tree
> >   * DUP for metadata unconditionally
> > 
> > This is based on numerous user requests and discussions, and after long period
> > where the respective features have been in released kernels.
> > 
> > Other changes:
> > 
> > * libbtrfs - minimize its impact on the other code, refactor and separate
> >   implementation where needed, cleanup afterwards, reduced header exports
> > 
> > * documentation - introduce sphinx build and RST versions of manual pages, will
> >   become the new format and replace asciidoc
> >   (Preview at https://deleteme12545.readthedocs.io/en/latest/index.html)
> > 
> > Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
> > Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git
> > 
> 
> Thank you for the release. It compiles and runs fine on my Gentoo 5.14.14 amd64 system. 
> 
> Here is the output and the corresponding dmesg bits. One note is the mention of "cleaning free space cache v1“ during mount. Is this intended? 

I'm not sure why it's there but it should not I think. At least it does
not make sense when the v2 is enabled right away.

> # mkfs.btrfs /dev/loop0p1 -fv --csum xxhash btrfs-progs v5.14.91
> See http://btrfs.wiki.kernel.org for more information.
> Performing full device TRIM /dev/loop0p1 (100.00GiB) ...
> NOTE: several default settings have changed in version 5.15, please make sure this does not affect your deployments: - DUP for metadata (-m dup) - enabled no-holes (-O no-holes) - enabled free-space-tree (-R free-space-tree)
> Label: (null) UUID: ee548f53-5639-4d90-8c23-810b4b1f0a69
> Node size: 16384
> Sector size: 4096
> Filesystem size: 100.00GiB
> Block group profiles: Data: single 8.00MiB Metadata: dup 1.00GiB System: dup 8.00MiB
> SSD detected: yes
> Zoned device: no
> Incompat features: extref, skinny-metadata, no-holes
> Runtime features: free-space-tree
> Checksum: xxhash64 Number of devices: 1
> Devices: ID SIZE PATH 1 100.00GiB /dev/loop0p1

> # dmesg ...
> [224380.260049] BTRFS: device fsid ee548f53-5639-4d90-8c23-810b4b1f0a69 devid 1 transid 6 /dev/loop0p1 scanned by mkfs.btrfs (6730)
> [224534.460239] BTRFS info (device loop0p1): flagging fs with big metadata feature
> [224534.460246] BTRFS info (device loop0p1): using free space tree
> [224534.460249] BTRFS info (device loop0p1): has skinny extents
> [224534.462430] BTRFS info (device loop0p1): enabling ssd optimizations
> [224534.462540] BTRFS info (device loop0p1): cleaning free space cache v1
> [224534.591074] BTRFS info (device loop0p1): checking UUID tree

The timestamp delta is about 0.13 so there could be something happening,
even if it's just checking some structures. It seems otherwise harmless
but I'd like to get this resolved before proper release. Now tracked as
https://github.com/kdave/btrfs-progs/issues/420 , thanks for the report.
