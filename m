Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4870B1573CA
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2020 13:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbgBJMA4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Feb 2020 07:00:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:51780 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726950AbgBJMA4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Feb 2020 07:00:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E9219AD00;
        Mon, 10 Feb 2020 12:00:54 +0000 (UTC)
Message-ID: <ee02dd42a41bd63999730c890f949667a76ca98b.camel@suse.de>
Subject: Re: [PATCH] fstests: common/btrfs: use complete sub command
From:   Marcos Paulo de Souza <mpdesouza@suse.de>
To:     Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Date:   Mon, 10 Feb 2020 09:03:40 -0300
In-Reply-To: <20200210031322.1177-1-anand.jain@oracle.com>
References: <20200210031322.1177-1-anand.jain@oracle.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 2020-02-10 at 11:13 +0800, Anand Jain wrote:
> Grep failed to find this subcommand of btrfs, leading to a wrong
> inference for a moment.
> 
> Make sure we use the full subcommand name in the btrfs command.

Well, I don't see how this could fail, but IMHO I like to see these
commands written in full rather than using contracted names.

> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Marcos Paulo de Souza <mpdesouza@suse.com>


> ---
>  common/btrfs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/btrfs b/common/btrfs
> index 19ac7cc4b18c..33ad7e3b41cc 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -7,7 +7,7 @@ _btrfs_get_subvolid()
>  	mnt=$1
>  	name=$2
>  
> -	$BTRFS_UTIL_PROG sub list $mnt | grep $name | awk '{ print $2
> }'
> +	$BTRFS_UTIL_PROG subvolume list $mnt | grep $name | awk '{
> print $2 }'
>  }
>  
>  # _require_btrfs_command <command> [<subcommand>|<option>]

