Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B868195A65
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Mar 2020 16:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgC0P5T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Mar 2020 11:57:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:44474 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbgC0P5T (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Mar 2020 11:57:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 12B49ACE3
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Mar 2020 15:57:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4E381DA72D; Fri, 27 Mar 2020 16:56:46 +0100 (CET)
Date:   Fri, 27 Mar 2020 16:56:46 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/9 v7] btrfs direct-io using iomap
Message-ID: <20200327155646.GP5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-btrfs@vger.kernel.org
References: <20200326210254.17647-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326210254.17647-1-rgoldwyn@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 26, 2020 at 04:02:45PM -0500, Goldwyn Rodrigues wrote:
> Changes since v6
> - Fixed hangs due to underlying device failures
> - Removed the patch to wait while releasing pages

There were no hangs and all tests finished, but there were some failures
that seem to be caused by the patchset. I'll send you the logs.
