Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5697D28DFE2
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Oct 2020 13:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387862AbgJNLg6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Oct 2020 07:36:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:51686 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730623AbgJNLg6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Oct 2020 07:36:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 99F2AADCC;
        Wed, 14 Oct 2020 11:36:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9F966DA7C3; Wed, 14 Oct 2020 13:35:30 +0200 (CEST)
Date:   Wed, 14 Oct 2020 13:35:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH] btrfs: add fs_info generation to sysfs
Message-ID: <20201014113530.GJ6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <feba5530a78df4066d5052aed57d814eb6f95814.1602055130.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <feba5530a78df4066d5052aed57d814eb6f95814.1602055130.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 07, 2020 at 03:20:03PM +0800, Anand Jain wrote:
> Matching with the information that's available from the ioctl
> BTRFS_IOC_FS_INFO, this patch adds generation to the sysfs.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Added to misc-next, thanks.
