Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63B92D46D0
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2019 19:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbfJKRlQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Oct 2019 13:41:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:60630 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728449AbfJKRlQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Oct 2019 13:41:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 71AFDB22A;
        Fri, 11 Oct 2019 17:41:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0D8A6DA808; Fri, 11 Oct 2019 19:41:28 +0200 (CEST)
Date:   Fri, 11 Oct 2019 19:41:27 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     dsterba@suse.com, clm@fb.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] btrfs: ioctl: Try to use btrfs_fs_info instead of *file
Message-ID: <20191011174127.GE2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        dsterba@suse.com, clm@fb.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20191011002311.12459-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011002311.12459-1-marcos.souza.org@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 10, 2019 at 09:23:11PM -0300, Marcos Paulo de Souza wrote:
> Some functions are doing some bikeshedding to reach the btrfs_fs_info
> struct. Change these functions to receive a btrfs_fs_info struct instead
> of a *file.

Makes sense, thanks. Added to msic-next.
