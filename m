Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E87411803AD
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Mar 2020 17:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgCJQii (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Mar 2020 12:38:38 -0400
Received: from verein.lst.de ([213.95.11.211]:53926 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbgCJQii (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Mar 2020 12:38:38 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8A67B68BEB; Tue, 10 Mar 2020 17:38:35 +0100 (CET)
Date:   Tue, 10 Mar 2020 17:38:35 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 12/15] btrfs: get rid of one layer of bios in direct I/O
Message-ID: <20200310163835.GD6361@lst.de>
References: <cover.1583789410.git.osandov@fb.com> <f9d0f9e8b8d11ff103654387f4370f50c6c074ae.1583789410.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9d0f9e8b8d11ff103654387f4370f50c6c074ae.1583789410.git.osandov@fb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 09, 2020 at 02:32:38PM -0700, Omar Sandoval wrote:
> 1. The bio created by the generic direct I/O code (dio_bio).
> 2. A clone of dio_bio we create in btrfs_submit_direct() to represent
>    the entire direct I/O range (orig_bio).
> 3. A partial clone of orig_bio limited to the size of a RAID stripe that
>    we create in btrfs_submit_direct_hook().
> 4. Clones of each of those split bios for each RAID stripe that we
>    create in btrfs_map_bio().

Just curious:  what is number 3 useful for?
