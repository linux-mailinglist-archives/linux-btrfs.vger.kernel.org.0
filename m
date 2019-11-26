Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D431810A256
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2019 17:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbfKZQlD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Nov 2019 11:41:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:34806 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727820AbfKZQlD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Nov 2019 11:41:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0E135B197;
        Tue, 26 Nov 2019 16:41:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7EC8FDA898; Tue, 26 Nov 2019 17:41:00 +0100 (CET)
Date:   Tue, 26 Nov 2019 17:41:00 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/5] btrfs: sysfs, rename devices kobject holder to
 devices_kobj
Message-ID: <20191126164100.GK2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <1574328814-12263-1-git-send-email-anand.jain@oracle.com>
 <1574328814-12263-2-git-send-email-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574328814-12263-2-git-send-email-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 21, 2019 at 05:33:30PM +0800, Anand Jain wrote:
> The struct member btrfs_device::device_dir_kobj holds the kobj of the
> sysfs directory /sys/fs/btrfs/UUID/devices, so rename it from
> device_dir_kobj to devices_kobj. No functional changes.

That naming scheme looks good, ok.
