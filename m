Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7D4784F46
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2019 16:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388227AbfHGO5s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Aug 2019 10:57:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:41178 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387915AbfHGO5r (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 7 Aug 2019 10:57:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4707AACB7;
        Wed,  7 Aug 2019 14:57:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EAA36DA7D7; Wed,  7 Aug 2019 16:58:17 +0200 (CEST)
Date:   Wed, 7 Aug 2019 16:58:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org, nborisov@suse.com
Subject: Re: [PATCH 15/15] btrfs: remove comment and leftover cruft
Message-ID: <20190807145817.GW28208@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        kernel-team@fb.com, linux-btrfs@vger.kernel.org, nborisov@suse.com
References: <20190806162837.15840-1-josef@toxicpanda.com>
 <20190806162837.15840-16-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806162837.15840-16-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 06, 2019 at 12:28:37PM -0400, Josef Bacik wrote:
> Commit "btrfs: convert snapshot/nocow exlcusion to drw lock" removed
> this code, but didn't remove the comment or the definitions, do that
> now.

The DRW lock patchset is in for-next just as a preview and for early
testing so any fixups should be folded to the original patchset.
