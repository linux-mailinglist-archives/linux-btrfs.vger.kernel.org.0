Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 989AD357EC
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2019 09:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfFEHfe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jun 2019 03:35:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:42484 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726464AbfFEHfe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Jun 2019 03:35:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 53B5BAE87
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jun 2019 07:35:33 +0000 (UTC)
Date:   Wed, 5 Jun 2019 09:35:33 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs: Introduce struct btrfs_io_geometry
Message-ID: <20190605073532.GA27972@x250>
References: <20190603090505.16800-1-nborisov@suse.com>
 <20190603090505.16800-2-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190603090505.16800-2-nborisov@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'd merge this patch into the next one, so you only introduce
btrfs_io_geometry when there are actual users for it.

But that's personal preference I guess.

Byte,
	Johannes
-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
