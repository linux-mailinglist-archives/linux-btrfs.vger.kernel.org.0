Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4E913DF70
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jan 2020 17:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgAPQAQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jan 2020 11:00:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:44594 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726899AbgAPQAP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jan 2020 11:00:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5C761B252A;
        Thu, 16 Jan 2020 16:00:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CEFF5DA791; Thu, 16 Jan 2020 16:59:57 +0100 (CET)
Date:   Thu, 16 Jan 2020 16:59:56 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/5] btrfs: check rw_devices, not num_devices for
 restriping
Message-ID: <20200116155955.GY3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200110161128.21710-1-josef@toxicpanda.com>
 <20200110161128.21710-2-josef@toxicpanda.com>
 <20200114205609.GL3929@twin.jikos.cz>
 <801709ca-22cd-f6ed-4e39-622a6aa1a1e6@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <801709ca-22cd-f6ed-4e39-622a6aa1a1e6@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 14, 2020 at 01:07:22PM -0800, Josef Bacik wrote:
> >> -	num_devices = btrfs_num_devices(fs_info);
> >> +	/*
> >> +	 * rw_devices can be messed with by rm_device and device replace, so
> >> +	 * take the chunk_mutex to make sure we have a relatively consistent
> >> +	 * view of the fs at this point.
> > 
> > Well, what does 'relatively consistent' mean here? There are enough
> > locks and exclusion that device remove or replace should not change the
> > value until btrfs_balance ends, no?
> > 
> 
> Again I don't have the code in front of me, but there's nothing at this point to 
> stop us from running in at the tail end of device replace or device rm.

This should be prevented by the EXCL_OP mechanism, so even the end of
device remove or replace will not be running at this time because it
cannot even start.

> The 
> mutex keeps us from getting weirdly inflated values when we increment and 
> decrement at the end of device replace, but there's nothing (that I can 
> remember) that will stop rw devices from changing right after we check it, thus 
> relatively.

rw_devices is changed in a handful of places on a mounted filesystem,
not counting device open/close. Device remove and replace are excluded
from running at that time, rw_devices can't change at this point of
balance.

btrfs_dev_replace_finishing
 - when removing srcdev, rw_devices--
 - when adding the target device as new, rw_devices++

btrfs_rm_device
 - rw_devices--

btrfs_init_new_device (called by device add)
 - rw_devices++

So the chunk mutex is either redundant or there's something I'm missing.
