Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E6A3511B4
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Apr 2021 11:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbhDAJP3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Apr 2021 05:15:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:52454 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233927AbhDAJPI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Apr 2021 05:15:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617268507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ejpWeJU6kuIHPUhg+klko9S8lIZ9BHgWuNBlFxN3rLA=;
        b=uXZDewaIIbv978ueETzOYrTr5/Suj+R7pHXyzejnCDlijqAR5E+KvIgIrwJ4ZzE2fw5xLa
        EevzvJcFQ21Ct+BSuxYQS926lmWTviH2GejPdAURc24oHoN36hRkO2286jshICvllWV55j
        rerqZvar63kxmXOXE6VhizudFxXKgyo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 97733AE85;
        Thu,  1 Apr 2021 09:15:07 +0000 (UTC)
Subject: Re: [PATCH] fs: btrfs: Remove repeated struct declaration
To:     Wan Jiabing <wanjiabing@vivo.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
References: <20210401080339.999529-1-wanjiabing@vivo.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <22e84b56-5eb9-9c20-0b46-efd8de837bd8@suse.com>
Date:   Thu, 1 Apr 2021 12:15:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210401080339.999529-1-wanjiabing@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 1.04.21 г. 11:03, Wan Jiabing wrote:
> struct btrfs_inode is declared twice. One is declared at 67th line.
> The blew declaration is not needed. Remove the duplicate.
> struct btrfs_fs_info should be declared in the forward declarations.
> Move it to the forward declarations.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
