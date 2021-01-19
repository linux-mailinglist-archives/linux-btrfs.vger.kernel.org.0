Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE342FC419
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jan 2021 23:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbhASWtA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jan 2021 17:49:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:54630 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730440AbhASWmZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jan 2021 17:42:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3761FAB7A;
        Tue, 19 Jan 2021 22:41:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 78A7EDA6E3; Tue, 19 Jan 2021 23:39:48 +0100 (CET)
Date:   Tue, 19 Jan 2021 23:39:48 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/13] Make btrfs W=1 clean
Message-ID: <20210119223948.GT6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210119122649.187778-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119122649.187778-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 19, 2021 at 02:26:36PM +0200, Nikolay Borisov wrote:
> Hello,
> 
> This patch series aims to fix all current warnings produced by compiling btrfs
> with W=1. My hopes are with these additions W=1 can become a default build
> options for btrfs.

Great, I like that, some of the warnigs get caught by the build bots but
we want them caught at development time.
