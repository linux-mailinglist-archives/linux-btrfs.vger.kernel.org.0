Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABC2011034F
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2019 18:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfLCRVm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Dec 2019 12:21:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:50644 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726182AbfLCRVm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Dec 2019 12:21:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EA4E5B206D;
        Tue,  3 Dec 2019 17:21:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8224BDA7D9; Tue,  3 Dec 2019 18:21:36 +0100 (CET)
Date:   Tue, 3 Dec 2019 18:21:36 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs: Remove WARN_ON in walk_log_tree
Message-ID: <20191203172136.GR2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191202094015.19444-1-nborisov@suse.com>
 <20191202094015.19444-2-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202094015.19444-2-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 02, 2019 at 11:40:13AM +0200, Nikolay Borisov wrote:
> The log_root passed to walk_log_tree is guaranteed to have its
> root_key.objectid always be BTRFS_TREE_LOG_OBJECTID. This is by
> merit that all log roots of an ordinary root are allocated in
> alloc_log_tree which hard-codes objectid to be BTRFS_TREE_LOG_OBJECTID.
> 
> In case walk_log_tree is called for a log tree found by btrfs_read_fs_root
> in btrfs_recover_log_trees, that function already ensures
> found_key.objectid is BTRFS_TREE_LOG_OBJECTID.

Agreed, if anything the warning should have been an assert at the
beginning of the function.
