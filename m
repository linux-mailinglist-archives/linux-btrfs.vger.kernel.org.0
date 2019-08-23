Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE0349B046
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2019 15:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403995AbfHWNCj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Aug 2019 09:02:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:48798 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732009AbfHWNCj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Aug 2019 09:02:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 91A35AE99;
        Fri, 23 Aug 2019 13:02:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 91785DA796; Fri, 23 Aug 2019 15:03:03 +0200 (CEST)
Date:   Fri, 23 Aug 2019 15:03:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2][v2] Rework the worst case calculations for space
 reservation
Message-ID: <20190823130303.GP2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        kernel-team@fb.com, linux-btrfs@vger.kernel.org
References: <20190822191434.13800-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822191434.13800-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 22, 2019 at 03:14:32PM -0400, Josef Bacik wrote:
> v1->v2:
> - dropped "btrfs: global reserve fallback should use metadata_size", turns out
>   I was testing without my evict changes in place so we don't even need this in
>   the first place, but it is also wrong because we need to reserve space for the
>   orphan item which is an insert.

As the evict patches are in misc-next now and this patchset applies
cleanly I'll add it directly to misc-next. Thanks.
