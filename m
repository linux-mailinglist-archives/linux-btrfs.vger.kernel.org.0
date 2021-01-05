Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F252E2EAFD6
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Jan 2021 17:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbhAEQP2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jan 2021 11:15:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:39864 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbhAEQP1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 5 Jan 2021 11:15:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0A60EAF74;
        Tue,  5 Jan 2021 16:14:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 09A49DA6E9; Tue,  5 Jan 2021 17:12:57 +0100 (CET)
Date:   Tue, 5 Jan 2021 17:12:57 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Jiachen YANG <farseerfc@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: btrfs-convert: copy ext4 extra timespec
Message-ID: <20210105161257.GP6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Jiachen YANG <farseerfc@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <20201225074538.461837-1-farseerfc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201225074538.461837-1-farseerfc@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 25, 2020 at 04:45:38PM +0900, Jiachen YANG wrote:
> Currently btrfs-convert only copies ext2 inode timestamps
> i_[cma]time from ext4, while filling 0 to nsec and crtime fields.
> 
> This change copies nsec and crtime by parsing i_[cma]time_extra fields.

Thanks, added to devel, with some coding style fixups. I've also added a
simple test.
