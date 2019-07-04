Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58B545F550
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2019 11:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbfGDJQN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Jul 2019 05:16:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:40248 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727177AbfGDJQN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 4 Jul 2019 05:16:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F02D9AE6E;
        Thu,  4 Jul 2019 09:16:11 +0000 (UTC)
Date:   Thu, 4 Jul 2019 11:16:11 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Fix build error while LIBCRC32C is module
Message-ID: <20190704091611.GB4305@x250.microfocus.com>
References: <20190702143903.49264-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190702143903.49264-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good, 
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
