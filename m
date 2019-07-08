Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2951861F9C
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2019 15:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731337AbfGHNfO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Jul 2019 09:35:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:35070 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731335AbfGHNfN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 8 Jul 2019 09:35:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BD952ACAC;
        Mon,  8 Jul 2019 13:35:12 +0000 (UTC)
Date:   Mon, 8 Jul 2019 15:35:12 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: add back libcrc32c Kconfig dependency
Message-ID: <20190708133512.GH3933@x250>
References: <20190708125134.3741552-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190708125134.3741552-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


This is already queued:
https://lore.kernel.org/linux-btrfs/20190704161949.GZ20977@twin.jikos.cz/T/#t


-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
