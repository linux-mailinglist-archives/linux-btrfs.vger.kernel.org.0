Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA12992FC
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2019 14:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388367AbfHVML1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Aug 2019 08:11:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:59270 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730980AbfHVML0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Aug 2019 08:11:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7A0AAAE89
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2019 12:11:25 +0000 (UTC)
Date:   Thu, 22 Aug 2019 14:11:25 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] btrfs: create structure to encode checksum type
 and length
Message-ID: <20190822121124.GE4052@x250>
References: <20190822114029.11225-1-jthumshirn@suse.de>
 <20190822114029.11225-3-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190822114029.11225-3-jthumshirn@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 22, 2019 at 01:40:27PM +0200, Johannes Thumshirn wrote:
> Create a structure to encode the type and length for the known on-disk
> checksums. Also add a table and a convenience macro for adding the
> checksum types to the table.
> 
> This makes it easier to add new checksums later.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> 
> ---
> Changes to v1:
> - Remove initializer macro (David)

> +#define BTRFS_CHECKSUM_TYPE(_type, _size, _name) \
> +	[_type] = { .size = _size, .name = _name }
> +

Adn obviously this should be gone as well *facepalm*

-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
