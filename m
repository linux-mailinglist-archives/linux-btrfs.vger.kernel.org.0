Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B21882515
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2019 20:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbfHESyg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Aug 2019 14:54:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:36458 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727802AbfHESyg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 5 Aug 2019 14:54:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B954FAE35
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Aug 2019 18:54:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9722FDABC7; Mon,  5 Aug 2019 20:55:06 +0200 (CEST)
Date:   Mon, 5 Aug 2019 20:55:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: Check for metadata uuid feature in
 misc-tests/034-metadata-uuid
Message-ID: <20190805185505.GI28208@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190805114522.12151-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805114522.12151-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 05, 2019 at 02:45:22PM +0300, Nikolay Borisov wrote:
> Instead of checking the kernel version, explicitly check for the
> presence of metadata_uuid file in sysfs. This allows the test to be run
> on older kernels that might have this feature backported.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Applied, thanks.
