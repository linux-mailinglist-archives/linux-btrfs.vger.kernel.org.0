Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E879E16EAB0
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2020 17:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbgBYQAz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Feb 2020 11:00:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:41764 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730659AbgBYQAz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Feb 2020 11:00:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 12671ADBE;
        Tue, 25 Feb 2020 16:00:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C171FDA726; Tue, 25 Feb 2020 17:00:34 +0100 (CET)
Date:   Tue, 25 Feb 2020 17:00:34 +0100
From:   David Sterba <dsterba@suse.cz>
To:     "Franklin, Jason" <jason.franklin@quoininc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Hard link count reported by "ls -l" is wrong
Message-ID: <20200225160034.GG2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        "Franklin, Jason" <jason.franklin@quoininc.com>,
        linux-btrfs@vger.kernel.org
References: <051c9f6d-5765-e2d1-9aae-aff70e0f2bb4@quoininc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <051c9f6d-5765-e2d1-9aae-aff70e0f2bb4@quoininc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 25, 2020 at 09:59:49AM -0500, Franklin, Jason wrote:
> Greetings:
> 
> I'm using btrfs on Debian 10.
> 
> When using "ls -l" to view a detailed listing in the current directory,
> I get output similar to the following:
> 
> total 0
> drwxrwx--- 1 jfrankli jfrankli  38 Feb 25 09:54 Desktop/
> drwxrwx--- 1 jfrankli jfrankli  36 Jan 24 10:37 Documents/
> drwxrwx--- 1 jfrankli jfrankli 612 Feb 24 15:48 Downloads/
> drwxrwx--- 1 jfrankli jfrankli   0 Nov  6 04:44 Music/
> drwxrwx--- 1 jfrankli jfrankli  20 Nov  6 04:44 Pictures/
> drwxrwx--- 1 jfrankli jfrankli   0 Nov  6 04:44 Public/
> drwxrwx--- 1 jfrankli jfrankli   0 Dec 27 20:20 Templates/
> drwxrwx--- 1 jfrankli jfrankli   0 Dec 27 20:20 Videos/
> drwxrwx--- 1 jfrankli jfrankli 522 Nov 26 09:53 bin/
> drwxrwx--- 1 jfrankli jfrankli  28 Dec 27 15:23 snap/
> 
> Notice that these are all directories with a hard link count of "1".
> 
> I have always seen directories possessing a hard link count of "2" or
> greater.  This is because the directory itself is a hard link, and it
> also contains the "." entry (the second hard link).
> 
> Any immediate child directory of a directory also adds +1 to the hard
> link count on other file systems.  This is because each child directory
> contains the ".." hard link pointing to its parent directory.
> 
> Why does this not happen with btrfs?
> 
> Could it a bug with the GNU "ls" tool?

No, link count 1 for directories is valid, btrfs does not implement
exact tracking like other filesystems.

https://btrfs.wiki.kernel.org/index.php/Project_ideas#Track_link_count_for_directories
