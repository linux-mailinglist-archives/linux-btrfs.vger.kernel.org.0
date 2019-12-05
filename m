Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3A0D11427A
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 15:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbfLEOVz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 09:21:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:60312 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729240AbfLEOVz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Dec 2019 09:21:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 495CFB227;
        Thu,  5 Dec 2019 14:21:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 03EEBDA733; Thu,  5 Dec 2019 15:21:48 +0100 (CET)
Date:   Thu, 5 Dec 2019 15:21:48 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/4] btrfs: sysfs, add devid/dev_state kobject and
 attribute
Message-ID: <20191205142148.GQ2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <20191205112706.8125-1-anand.jain@oracle.com>
 <20191205112706.8125-5-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205112706.8125-5-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 05, 2019 at 07:27:06PM +0800, Anand Jain wrote:
> A new sysfs RW attribute

Why RW? Most attributes/files in sysfs are supposed to be read-only, but
you actually define the attribute as read-only with the macro
BTRFS_ATTR.

>   UUID/devinfo/<devid>/dev_state
> is added here. The dev_state here reflects the state of the device from
> the kernel parameter btrfs_device::dev_state and this attribute is born
> after the device is mounted and goes along with the dynamic nature of the
> device add and delete. This attribute gets deleted at unmount.
> 
> For example:
> pwd
>  /sys/fs/btrfs/6e1961f1-5918-4ecc-a22f-948897b409f7/devinfo
> cat 1/dev_state
>  IN_FS_METADATA MISSING
> cat 2/dev_state
>  WRITABLE IN_FS_METADATA

So the values copy the device state macros, that's probably ok.

> +static ssize_t btrfs_sysfs_dev_state_show(struct kobject *kobj,
> +					  struct kobj_attribute *a, char *buf)
> +{
> +	struct btrfs_device *device = container_of(kobj, struct btrfs_device,
> +						   devid_kobj);
> +
> +	btrfs_dev_state_to_str(device, buf, PAGE_SIZE);

The device access is unprotected, you need at least RCU but that still
does not prevent from the device being freed by deletion. The
device_list_mutex is quite heavy and allowing a DoS by repeatedly
reading the file contents is not something we want to allow.
