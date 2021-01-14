Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645962F69DB
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jan 2021 19:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbhANSpI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Jan 2021 13:45:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:39588 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727346AbhANSpH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Jan 2021 13:45:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C8F6AB770;
        Thu, 14 Jan 2021 18:44:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 51143DA7EE; Thu, 14 Jan 2021 19:42:32 +0100 (CET)
Date:   Thu, 14 Jan 2021 19:42:32 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>
Cc:     linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>, wqu@suse.com,
        dsterba@suse.com
Subject: Re: [PATCH v4 0/3] btrfs-progs: Fix logical-resolve
Message-ID: <20210114184232.GC6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Marcos Paulo de Souza <marcos@mpdesouza.com>,
        linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>, wqu@suse.com,
        dsterba@suse.com
References: <20201127193035.19171-1-marcos@mpdesouza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127193035.19171-1-marcos@mpdesouza.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 27, 2020 at 04:30:32PM -0300, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> In this forth iteration, only patch 0002 was changed. Previously the variable
> full_path, which is passed by the user, was being overwritten in the inode loop.
> Now we create a temp var to store the mount_point when the lookup is needed.
> 
> Please review.
> 
> Changes from v3:
> * In patch 0002, do not overwrite full_path variable

For the record, patches have been reworked as there some differences
between kernels 5.3 and 5.8 regarding bind mounts and what is printed in
/proc/ mounts due to 3ef3959b29c4 ("btrfs: don't show full path of bind
mounts in subvol=").

New version uses libmount to parse the information and distinguish
subvol= mounts and bind mounts. With a test.
