Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C25D11B0E7
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2019 09:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfEMHLQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 May 2019 03:11:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:36884 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726841AbfEMHLP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 May 2019 03:11:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D5AA2AE63
        for <linux-btrfs@vger.kernel.org>; Mon, 13 May 2019 07:11:14 +0000 (UTC)
Date:   Mon, 13 May 2019 09:11:14 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 17/17] btrfs: add sha256 as another checksum algorithm
Message-ID: <20190513071114.GC12653@x250>
References: <20190510111547.15310-1-jthumshirn@suse.de>
 <20190510111547.15310-18-jthumshirn@suse.de>
 <e529d2ee-566c-d9f6-d7ed-77616fee2955@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e529d2ee-566c-d9f6-d7ed-77616fee2955@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 10, 2019 at 03:30:36PM +0300, Nikolay Borisov wrote:
[...]
> 
> nit: Might be a good idea to turn that into an enum for self-documenting
> purposes. Perhaps in a different patch.

Thought about this as well, but I thought I remembered a patch series from
David where he turned everything not being an on-disk format to enums.

This discuraged me from actually doing the switch. I'd be more than happy if I
could just use an enum.

Byte,
	Johannes
-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
