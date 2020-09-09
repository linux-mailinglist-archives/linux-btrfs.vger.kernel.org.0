Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E09DB262D71
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Sep 2020 12:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgIIKwA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Sep 2020 06:52:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:52932 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbgIIKv4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Sep 2020 06:51:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9B136ADF5;
        Wed,  9 Sep 2020 10:51:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 51205DA7C6; Wed,  9 Sep 2020 12:50:39 +0200 (CEST)
Date:   Wed, 9 Sep 2020 12:50:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com,
        josef@toxicpanda.com, nborisov@suse.com
Subject: Re: [PATCH 13/16] btrfs: cleanup btrfs_remove_chunk
Message-ID: <20200909105039.GF18399@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, josef@toxicpanda.com,
        nborisov@suse.com
References: <cover.1599234146.git.anand.jain@oracle.com>
 <731ff89d22332c3e344f9ea4ca28012f01d50656.1599234146.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <731ff89d22332c3e344f9ea4ca28012f01d50656.1599234146.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Sep 05, 2020 at 01:34:33AM +0800, Anand Jain wrote:
> In the function btrfs_remove_chunk() remove the local variable
> %fs_devices, instead use the assigned pointer directly.

Local variable that caches some pointer is ok if it's used multiple
time, this patch does the opposite.
