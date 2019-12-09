Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13E02117443
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 19:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfLISb6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Dec 2019 13:31:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:37694 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726365AbfLISb6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Dec 2019 13:31:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DC67FB3BB;
        Mon,  9 Dec 2019 18:31:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 156E3DA82A; Mon,  9 Dec 2019 19:31:50 +0100 (CET)
Date:   Mon, 9 Dec 2019 19:31:49 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anandsuveer@gmail.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/4] btrfs: sysfs, add devid/dev_state kobject and
 attribute
Message-ID: <20191209183149.GR2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anandsuveer@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <20191205112706.8125-1-anand.jain@oracle.com>
 <20191205112706.8125-5-anand.jain@oracle.com>
 <20191205142148.GQ2734@twin.jikos.cz>
 <78560abd-7d85-c95d-ed76-7810b1d03789@oracle.com>
 <20191205151428.GS2734@twin.jikos.cz>
 <673babd8-90ec-2f7e-532a-df8c98a844cf@oracle.com>
 <8bd3d9b9-11b1-4c9a-8b59-ccfe0c6d92c4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bd3d9b9-11b1-4c9a-8b59-ccfe0c6d92c4@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 09, 2019 at 10:05:39PM +0800, Anand Jain wrote:
>   Looked into this further, actually we don't need any lock here
>   the device delete thread which calls kobject_put() makes sure
>   sysfs read is closed. So an existing sysfs read thread will have
>   to complete before device free.
> 
> 
>        CPU1                                   CPU2
> 
>   btrfs_rm_device
>                                            open file
>      btrfs_sysfs_rm_device_link
>                                            call read, access freed device
>        sysfs waits for the open file
>        to close.
>        btrfs_free_device
>          kfree(device)

Ok, as long as this holds and sysfs file is removed before the device is
freed, the locking is not necessary.
