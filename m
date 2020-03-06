Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3BDB17C769
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Mar 2020 21:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgCFU4Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Mar 2020 15:56:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:54562 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgCFU4Y (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Mar 2020 15:56:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A24C4ADE0;
        Fri,  6 Mar 2020 20:56:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F13D3DA728; Fri,  6 Mar 2020 21:55:58 +0100 (CET)
Date:   Fri, 6 Mar 2020 21:55:58 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs-progs: convert, warn if converting a fs which
 won't mount
Message-ID: <20200306205558.GM2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <1583335325-20569-1-git-send-email-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583335325-20569-1-git-send-email-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 04, 2020 at 11:22:05PM +0800, Anand Jain wrote:
> On aarch64 with pagesize 64k, btrfs-convert of ext4 is successful,
> but it won't mount because we don't yet support subpage blocksize/
> sectorsize.
> 
>  BTRFS error (device vda): sectorsize 4096 not supported yet, only support 65536
> 
> So in this case during convert provide a warning.
> 
> For example:
> 
> WARNING: Blocksize 4096 is not equal to the pagesize 65536,
>          converted filesystem won't mount on this system.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---

Added to devel, thanks.
