Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F82D3EC9A5
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Aug 2021 16:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238473AbhHOOnT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 Aug 2021 10:43:19 -0400
Received: from out20-38.mail.aliyun.com ([115.124.20.38]:57721 "EHLO
        out20-38.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbhHOOnS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 Aug 2021 10:43:18 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0970976|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.380991-0.00237419-0.616635;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047199;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.L.jEn6S_1629038566;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.L.jEn6S_1629038566)
          by smtp.aliyun-inc.com(10.147.42.253);
          Sun, 15 Aug 2021 22:42:46 +0800
Date:   Sun, 15 Aug 2021 22:42:46 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 5/8] common: add zoned block device checks
Message-ID: <YRkn5uj9Yp/W3hYF@desktop>
References: <20210811151232.3713733-1-naohiro.aota@wdc.com>
 <20210811151232.3713733-6-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811151232.3713733-6-naohiro.aota@wdc.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 12, 2021 at 12:12:29AM +0900, Naohiro Aota wrote:
> dm-error and dm-snapshot does not have DM_TARGET_ZONED_HM nor
> DM_TARGET_MIXED_ZONED_MODEL feature and does not implement
> .report_zones(). So, it cannot pass the zone information from the down
> layer (zoned device) to the upper layer.
> 
> Loop device also cannot pass the zone information.
> 
> This patch requires non-zoned block device for the tests using these
> ones.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  common/dmerror    | 3 +++
>  common/dmhugedisk | 3 +++
>  common/rc         | 7 +++++++
>  3 files changed, 13 insertions(+)
> 
> diff --git a/common/dmerror b/common/dmerror
> index 01a4c8b5e52d..64ee78d85b95 100644
> --- a/common/dmerror
> +++ b/common/dmerror
> @@ -15,6 +15,9 @@ _dmerror_setup()
>  	export DMLINEAR_TABLE="0 $blk_dev_size linear $dm_backing_dev 0"
>  
>  	export DMERROR_TABLE="0 $blk_dev_size error $dm_backing_dev 0"
> +
> +	# dm-error cannot handle zone information
> +	_require_non_zoned_device "${dm_backing_dev}"

We should really do the check in _require rules not in _setup()
functions. Please see below.

>  }
>  
>  _dmerror_init()
> diff --git a/common/dmhugedisk b/common/dmhugedisk
> index 502f0243772d..715f95efde29 100644
> --- a/common/dmhugedisk
> +++ b/common/dmhugedisk
> @@ -16,6 +16,9 @@ _dmhugedisk_init()
>  	local dm_backing_dev=$SCRATCH_DEV
>  	local chunk_size="$2"
>  
> +	# We cannot ensure sequential writes on the backing device
> +	_require_non_zoned_device $dm_backing_dev
> +
>  	if [ -z "$chunk_size" ]; then
>  		chunk_size=512
>  	fi
> diff --git a/common/rc b/common/rc
> index 7b80820ff680..03b7e0310a84 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1837,6 +1837,9 @@ _require_loop()
>      else
>  	_notrun "This test requires loopback device support"
>      fi
> +
> +    # loop device does not handle zone information
> +    _require_non_zoned_device ${TEST_DEV}
>  }
>  
>  # this test requires kernel support for a secondary filesystem
> @@ -1966,6 +1969,10 @@ _require_dm_target()
>  	if [ $? -ne 0 ]; then
>  		_notrun "This test requires dm $target support"
>  	fi
> +
> +	if [ $target = thin-pool ]; then
> +		_require_non_zoned_device ${SCRATCH_DEV}
> +	fi

I think we could move all check here, based on $target, e.g.

	case $target in
	thin-pool|error|snapshot)
		_require_non_zoned_device ${SCRATCH_DEV}
		;;
	esac

Thanks,
Eryu

>  }
>  
>  _zone_type()
> -- 
> 2.32.0
