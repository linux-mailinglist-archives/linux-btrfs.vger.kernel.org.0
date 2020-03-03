Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7295D17827F
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2020 20:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbgCCSfW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Mar 2020 13:35:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:54168 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729773AbgCCSfW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Mar 2020 13:35:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A87F5AD2B;
        Tue,  3 Mar 2020 18:35:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6B1B5DA7C3; Tue,  3 Mar 2020 19:34:58 +0100 (CET)
Date:   Tue, 3 Mar 2020 19:34:57 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     dsterba@suse.com, wqu@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCHv2 0/4] btrfs-progs: Add BTRFS_IOC_SNAP_DESTROY_V2 support
Message-ID: <20200303183457.GO2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        dsterba@suse.com, wqu@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20200207131028.9977-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207131028.9977-1-marcos.souza.org@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 07, 2020 at 10:10:24AM -0300, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> Second version of the patchset, which pairs with v3 of kernel changes.
> 
> Changes from v1:
> * Moved subvolid member to the same union containing name and devid (David)
> * Dropped patch that was bumping the libbtrfsutils version (David, Wenruo)
> 
> Marcos Paulo de Souza (4):
>   btrfs-progs: add IOC_SNAP_DESTROY_V2 to ioctl.h
>   libbtrfsutil: add IOC_SNAP_DESTROY_V2 to ioctl.h
>   libbtrfsutil: Introduce btrfs_util_delete_subvolume_by_id_fd
>   cmds: subvolume: Add --subvolid argument to subvol_delete

I've reworked it a bit, the libbtrfsutil changes can be done in one, and
the test should be separate.

The short option would be probably -i as I have some patches regarding
'sync' after deletion (ie. the 'subvolume sync') and 'i' resembles the
id more. The fstests might need to be updated once the final version is
in progs git but the internal test has a good coverage.

As for release target, this will be in 5.5 once it appears. Thanks.
