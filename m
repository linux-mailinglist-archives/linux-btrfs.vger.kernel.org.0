Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9FD14DCBA
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 15:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbgA3OWF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 09:22:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:59310 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbgA3OWF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 09:22:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0F7D2B1B0;
        Thu, 30 Jan 2020 14:22:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 01D86DA84C; Thu, 30 Jan 2020 15:21:44 +0100 (CET)
Date:   Thu, 30 Jan 2020 15:21:44 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [RESEND PATCH v2 0/2] Refactor snapshot vs nocow writers locking
Message-ID: <20200130142144.GU3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200130125945.7383-1-nborisov@suse.com>
 <20200130125945.7383-4-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130125945.7383-4-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 30, 2020 at 02:59:43PM +0200, Nikolay Borisov wrote:
> Hello,
> 
> Here is the second version of the DRW lock for btrfs. Main changes from v1:

As the code is wrapping the existing code I think we're good to add it
to misc-next soon so we have more coverage.

Please add comments with the lock semantics overview and to all the
public functions. Having more assertions would be also good, like the
tree locks do. Thanks.
