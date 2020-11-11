Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0AAD2AF577
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Nov 2020 16:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbgKKPvS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Nov 2020 10:51:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:54252 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726274AbgKKPvR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Nov 2020 10:51:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C2267AC75;
        Wed, 11 Nov 2020 15:51:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E5FE1DA6E1; Wed, 11 Nov 2020 16:49:34 +0100 (CET)
Date:   Wed, 11 Nov 2020 16:49:34 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RESEND 0/2] fix verify_one_dev_extent and
 btrfs_find_device
Message-ID: <20201111154934.GT6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1600940809.git.anand.jain@oracle.com>
 <20201029210242.GX6756@twin.jikos.cz>
 <468a5f49-187a-71ad-b922-eaf091107d65@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <468a5f49-187a-71ad-b922-eaf091107d65@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 30, 2020 at 05:14:06AM +0800, Anand Jain wrote:
> > You can also use the workflow scripts to
> > create or update the issue so we'll notice that. 
> 
> I found workflow script can't handle the update? Instead it creates a 
> new issue?

The script btrfs-create-issue asks if there's an existing issue to
update.
