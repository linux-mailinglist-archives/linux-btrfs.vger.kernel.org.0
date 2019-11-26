Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97FB510A263
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2019 17:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfKZQoY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Nov 2019 11:44:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:37628 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727532AbfKZQoY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Nov 2019 11:44:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 19355B1E1;
        Tue, 26 Nov 2019 16:44:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5D5C2DA898; Tue, 26 Nov 2019 17:44:17 +0100 (CET)
Date:   Tue, 26 Nov 2019 17:44:17 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 5/5] btrfs: sysfs, merge btrfs_sysfs_add devices_kobj
 and fsid
Message-ID: <20191126164417.GL2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <1574328814-12263-1-git-send-email-anand.jain@oracle.com>
 <1574328814-12263-6-git-send-email-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574328814-12263-6-git-send-email-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 21, 2019 at 05:33:34PM +0800, Anand Jain wrote:
> Merge btrfs_sysfs_add_fsid() and btrfs_sysfs_add_devices_kobj() functions
> as these two are small and they are called one after the other.

Makes sense, all the subdirectories under the fsid directory can be
created inside one function.
