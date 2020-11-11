Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655202AF57E
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Nov 2020 16:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbgKKPw5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Nov 2020 10:52:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:54968 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727041AbgKKPw4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Nov 2020 10:52:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 64D41AD5C;
        Wed, 11 Nov 2020 15:52:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 941BEDA6E1; Wed, 11 Nov 2020 16:51:13 +0100 (CET)
Date:   Wed, 11 Nov 2020 16:51:13 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH RESEND v2 0/3] cleanup btrfs_find_device and fix sysbot
 warning
Message-ID: <20201111155113.GU6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <cover.1604372688.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1604372688.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 03, 2020 at 01:49:41PM +0800, Anand Jain wrote:
> Patch 1 and 2 are cleanups. They were sent before with the cover-letter
> as below.
>  [PATCH RESEND 0/2] fix verify_one_dev_extent and btrfs_find_device
> 
> Patch 3 is a fix for the Warning reported by sysbot. This also was sent
> before with the cover-letter titled as below.
>   [PATCH 0/1] handle attacking device with devid=0
> 
> To avoid conflict fixes, please apply these patches in the order it is
> sent here. But the sets are not related.
> 
> Both of these patchsets are at v2 at the latest. So I am marking all of
> them as v2. The individual changes are in the patches.
> 
> Also earlier resend patches were threaded under its previous cover-letter
> (though --in-reply-to was not used to generate/send those patches). So I am
> trying to resend these patches again, hopefully, they are not threaded to
> the older series again.
> 
> Anand Jain (3):
>   btrfs: drop never met condition of disk_total_bytes == 0
>   btrfs: fix btrfs_find_device unused arg seed
>   btrfs: fix devid 0 without a replace item by failing the mount

Now added to misc-next, thanks.
