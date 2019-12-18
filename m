Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA03123C9F
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 02:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfLRBno (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 20:43:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:54798 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfLRBnn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 20:43:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 51C42AD93;
        Wed, 18 Dec 2019 01:43:42 +0000 (UTC)
Message-ID: <3d78ef75d1cc010f5ff2f7741f6276742cf225f7.camel@suse.de>
Subject: Re: [btrfs-progs PATCHv2 1/4] tests: common: Add
 check_dm_target_support helper
From:   Marcos Paulo de Souza <mpdesouza@suse.de>
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>, wqu@suse.com
Date:   Tue, 17 Dec 2019 22:46:08 -0300
In-Reply-To: <20191218011925.19428-2-marcos.souza.org@gmail.com>
References: <20191218011925.19428-1-marcos.souza.org@gmail.com>
         <20191218011925.19428-2-marcos.souza.org@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Forget this patch, I understood it wrong. I will add setup_root_helper
before the $SUDO_HELPER from v1 in a different patch. 

On Tue, 2019-12-17 at 22:19 -0300, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> This function will be used later to test if dm-thin is supported.
> Inspired by fstests.
> 
> Suggested-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  Changes from v1:
>  Removed the $SUDO_HELPER variable when executing modprobe and
> dmsetup (Qu
>  Wenruo)
> 
>  tests/common | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/tests/common b/tests/common
> index ca098444..20ad7fd9 100644
> --- a/tests/common
> +++ b/tests/common
> @@ -322,6 +322,19 @@ check_global_prereq()
>  	fi
>  }
>  
> +# check if the targets passed as arguments are available, and if not
> just skip
> +# the test
> +check_dm_target_support()
> +{
> +	for target in "$@"; do
> +		modprobe dm-$target >/dev/null 2>&1
> +		dmsetup targets 2>&1 | grep -q ^$target
> +		if [ $? -ne 0 ]; then
> +			_not_run "This test requires dm $target
> support."
> +		fi
> +	done
> +}
> +
>  check_image()
>  {
>  	local image

