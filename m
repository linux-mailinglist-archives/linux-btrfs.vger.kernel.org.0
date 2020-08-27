Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2FE254518
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Aug 2020 14:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbgH0Mix (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Aug 2020 08:38:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:54026 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729089AbgH0MiN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Aug 2020 08:38:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A81A6AECB;
        Thu, 27 Aug 2020 12:38:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 78B90DA703; Thu, 27 Aug 2020 14:37:03 +0200 (CEST)
Date:   Thu, 27 Aug 2020 14:37:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: Rework error detection in init_tree_roots
Message-ID: <20200827123703.GM28318@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200804073236.6677-1-nborisov@suse.com>
 <20200812131635.8432-1-nborisov@suse.com>
 <2f8bf44c-9c80-513f-24b2-7af4f718f527@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f8bf44c-9c80-513f-24b2-7af4f718f527@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 27, 2020 at 10:02:10AM +0300, Nikolay Borisov wrote:
> 
> 
> On 12.08.20 г. 16:16 ч., Nikolay Borisov wrote:
> > To avoid duplicating 3 lines of code the error detection logic in
> > init_tree_roots is somewhat quirky. It first checks for the presence of
> > any error condition, then checks for the specific condition to perform
> > any specific actions. That's spurious because directly checking for
> > each respective error condition and doing the necessary steps is more
> > obvious. While at it change the -EUCLEAN to -EIO in case the extent
> > buffer is not read correctly, this is in line with other sites which
> > return -EIO when the eb couldn't be read.
> > 
> > Additionally it results in smaller code and the code reads
> > more linearly:
> > 
> > add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-95 (-95)
> > Function                                     old     new   delta
> > open_ctree                                 17243   17148     -95
> > Total: Before=113104, After=113009, chg -0.08%
> > 
> > Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> > ---
> > 
> > Changes in v2:
> > * Return -EIO in case of !extent_buffer_uptodate
> > * Change the error messages to distinguish both cases albeit they are still
> > rather similar.
> 
> Any comments on V2 ?

Code is ok, the messages should not start with an uppercase letter,
fixed.
