Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 083F59E945
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 15:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbfH0NZg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 09:25:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:50298 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729091AbfH0NZg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 09:25:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DECBCAEC4;
        Tue, 27 Aug 2019 13:25:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4FF62DA809; Tue, 27 Aug 2019 15:25:58 +0200 (CEST)
Date:   Tue, 27 Aug 2019 15:25:58 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] fix BUG_ON and retun real error in find_next_devid()
 and clone_fs_devices()
Message-ID: <20190827132558.GI2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <20190827074045.5563-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827074045.5563-1-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 27, 2019 at 03:40:43PM +0800, Anand Jain wrote:
> Fixes BUG_ON in find_next_devid() and fixes to return real error in
> clone_fs_devices(). These two patches can be send to be independent.
> 
> Anand Jain (2):
>   btrfs: fix BUG_ON with proper error handle in find_next_devid
>   btrfs: fix error return on alloc fail in clone_fs_devices

Added to misc-next, thanks. If you have script that can reproduce the
problem, please add them to the changelog. I've added more from the
discussion and questions from Qu.
