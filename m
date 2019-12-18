Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6B3124D05
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 17:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfLRQTX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Dec 2019 11:19:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:39552 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727121AbfLRQTX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Dec 2019 11:19:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 31BFAAD3A;
        Wed, 18 Dec 2019 16:19:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3A24CDA729; Wed, 18 Dec 2019 17:19:20 +0100 (CET)
Date:   Wed, 18 Dec 2019 17:19:20 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Long An <lan@suse.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs-progs: tests: mkfs/011: Fix path for rootdir
Message-ID: <20191218161919.GM3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Long An <lan@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <1576564610.3899.20.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576564610.3899.20.camel@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 17, 2019 at 06:36:51AM +0000, Long An wrote:
> Documentation folder path is wrong on exported testsutie. Fix this by
> replace TOP with INTERNAL_BIN.

It feels wrong that the tests use INTERNAL_BIN but it obviously exists
and works so I'll apply the patch but maybe this could use some cleanup.
Thanks.
