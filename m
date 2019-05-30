Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C34732FCA7
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 May 2019 15:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfE3Nvn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 May 2019 09:51:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:40480 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725870AbfE3Nvn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 May 2019 09:51:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 895B6ADDA;
        Thu, 30 May 2019 13:51:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7918DDA85E; Thu, 30 May 2019 15:52:35 +0200 (CEST)
Date:   Thu, 30 May 2019 15:52:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Su Yue <suy.fnst@cn.fujitsu.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: adjust order of unlocks in do_trimming()
Message-ID: <20190530135235.GG15290@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Su Yue <suy.fnst@cn.fujitsu.com>,
        linux-btrfs@vger.kernel.org
References: <20181128032112.1152-1-suy.fnst@cn.fujitsu.com>
 <20181128141012.GN2842@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128141012.GN2842@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 28, 2018 at 03:10:12PM +0100, David Sterba wrote:
> On Wed, Nov 28, 2018 at 11:21:12AM +0800, Su Yue wrote:
> > In function do_trimming(), block_group->lock should be unlocked first.
> 
> Please also write why this is correct and if there are any bad
> consequences of the current behaviour. Thanks.

I've updated the changelog and added the patch to misc-next.
