Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8238F28BCF3
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Oct 2020 17:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbgJLPwu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Oct 2020 11:52:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:34186 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbgJLPwu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Oct 2020 11:52:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 85B32ACE5;
        Mon, 12 Oct 2020 15:52:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7B41CDA7C3; Mon, 12 Oct 2020 17:51:22 +0200 (CEST)
Date:   Mon, 12 Oct 2020 17:51:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Subject: Re: [PATCH] btrfs: add fs_info generation to sysfs
Message-ID: <20201012155122.GA6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
References: <feba5530a78df4066d5052aed57d814eb6f95814.1602055130.git.anand.jain@oracle.com>
 <54ee1769-9ccd-933d-31b6-0d44c2403819@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54ee1769-9ccd-933d-31b6-0d44c2403819@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 07, 2020 at 10:50:27AM +0300, Nikolay Borisov wrote:
> 
> 
> On 7.10.20 г. 10:20 ч., Anand Jain wrote:
> > Matching with the information that's available from the ioctl
> > BTRFS_IOC_FS_INFO, this patch adds generation to the sysfs.
> > 
> > Signed-off-by: Anand Jain <anand.jain@oracle.com>
> 
> What problem are you trying to solve?

Parity of FS_INFO ioctl and sysfs exports.
