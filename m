Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF0586E3A1
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2019 11:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfGSJlo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Jul 2019 05:41:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:57110 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725794AbfGSJlo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Jul 2019 05:41:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DB2D1B009
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2019 09:41:42 +0000 (UTC)
Date:   Fri, 19 Jul 2019 11:41:42 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 3/4] btrfs: extent-tree: Add comment for
 inc_block_group_ro()
Message-ID: <20190719094142.GB3713@x250>
References: <20190719065144.15263-1-wqu@suse.com>
 <20190719065144.15263-4-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190719065144.15263-4-wqu@suse.com>
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
