Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6789B206DDE
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 09:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389886AbgFXHhP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jun 2020 03:37:15 -0400
Received: from bang.steev.me.uk ([81.2.120.65]:46295 "EHLO smtp.steev.me.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389583AbgFXHhP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jun 2020 03:37:15 -0400
Received: from smtp.steev.me.uk ([2001:8b0:162c:10::25] helo=webmail.steev.me.uk)
        by smtp.steev.me.uk with esmtp (Exim 4.93.0.4)
        id 1jnzy5-003a5W-Nh; Wed, 24 Jun 2020 08:37:13 +0100
MIME-Version: 1.0
Date:   Wed, 24 Jun 2020 08:37:13 +0100
From:   Steven Davies <btrfs-list@steev.me.uk>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: start deprecation of mount option inode_cache
In-Reply-To: <20200623185032.14983-1-dsterba@suse.com>
References: <20200623185032.14983-1-dsterba@suse.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <076d047d33676d78e882feb74a2f0c4f@steev.me.uk>
X-Sender: btrfs-list@steev.me.uk
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020-06-23 19:50, David Sterba wrote:
> @@ -827,6 +827,8 @@ int btrfs_parse_options(struct btrfs_fs_info
> *info, char *options,
>  			}
>  			break;
>  		case Opt_inode_cache:
> +			btrfs_warn(info,
> +	"the 'inode_cache' option is deprecated and will be stop working in 
> 5.11");

"will stop working", but perhaps "will have no effect from" might be 
more explicit.

-- 
Steven Davies
