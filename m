Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB812F69C7
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jan 2021 19:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbhANSkJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Jan 2021 13:40:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:37482 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729393AbhANSkH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Jan 2021 13:40:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 125E3B770;
        Thu, 14 Jan 2021 18:39:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B260ADA7EE; Thu, 14 Jan 2021 19:37:32 +0100 (CET)
Date:   Thu, 14 Jan 2021 19:37:32 +0100
From:   David Sterba <dsterba@suse.cz>
To:     shngmao@gmail.com
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: align btrfs receive buffer to enable fast
 CRC
Message-ID: <20210114183732.GB6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, shngmao@gmail.com,
        linux-btrfs@vger.kernel.org
References: <20201226214606.49241-1-shngmao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201226214606.49241-1-shngmao@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Dec 26, 2020 at 02:46:06PM -0700, shngmao@gmail.com wrote:
> From: Sheng Mao <shngmao@gmail.com>
> 
> To use optimized CRC implemention, the input buffer must be
> unsigned long aligned. btrfs receive calculates checksum based on
> read_buf, including btrfs_cmd_header (with zero-ed CRC field)
> and command content. GCC attribute is added to both struct
> btrfs_send_stream and read_buf to make sure read_buf is allocated
> with proper alignment.
> 
> Issue: #324
> Signed-off-by: Sheng Mao <shngmao@gmail.com>

Fix added to devel, with the mentined changes: read_buf is at the
begninning and whole structure 64 bytes aligned. Thanks.
