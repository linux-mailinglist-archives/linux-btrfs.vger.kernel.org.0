Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96EA43EF669
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 01:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236705AbhHRAA2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Aug 2021 20:00:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:48086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232706AbhHRAA2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Aug 2021 20:00:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6567260EB9;
        Tue, 17 Aug 2021 23:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629244794;
        bh=Wfx3Y0nP/Ey2r1cqjk8qWCiVxohx7Hoz1DnRoDuIHjk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vK+3DSipz6gTMnyLTNBRUd585U15nYiphDYK8LfYObt0jfSEn45/jINo9JbBkPF3q
         E1U1HzkSgga7fQoQJpxnhhjWqz7O9pB5/yVuhIejucbQ8s9sY0VSYIhBpx0Z5IRSkO
         BN6VbS0/4zocN8du1A6GiIlsjGSbVUVggAp15ba+hmrqBhawDGayEBMX7AK4acI+aK
         aJdIfjhUFHItcC08v2qZTKvTS7TEua6Nnpl/pBOeQ0mYg6oIQSbQE2D6PS6mfUyvzw
         Y1IZtgeYh7JJ9LqNH5zsWiNfX38C1a1sSR7IbAPYq5uewNwaCYc0U8XreBB51ZYfz9
         g0Fl7cM6IyXIQ==
Date:   Tue, 17 Aug 2021 16:59:54 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 1/3] common: add zoned block device checks
Message-ID: <20210817235954.GA12612@magnolia>
References: <20210816113510.911606-1-naohiro.aota@wdc.com>
 <20210816113510.911606-2-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816113510.911606-2-naohiro.aota@wdc.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 16, 2021 at 08:35:08PM +0900, Naohiro Aota wrote:
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
>  common/rc | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 84757fc1755e..e0b6d50854c6 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1837,6 +1837,9 @@ _require_loop()
>      else
>  	_notrun "This test requires loopback device support"
>      fi
> +
> +    # loop device does not handle zone information
> +    _require_non_zoned_device ${TEST_DEV}

Is this true of loop devices sitting on top of zoned block devices?

If so, then the rest looks good to me.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

>  }
>  
>  # this test requires kernel support for a secondary filesystem
> @@ -1966,6 +1969,16 @@ _require_dm_target()
>  	if [ $? -ne 0 ]; then
>  		_notrun "This test requires dm $target support"
>  	fi
> +
> +	# dm-error cannot handle the zone information
> +	#
> +	# dm-snapshot and dm-thin-pool cannot ensure sequential writes on
> +	# the backing device
> +	case $target in
> +	error|snapshot|thin-pool)
> +		_require_non_zoned_device ${SCRATCH_DEV}
> +		;;
> +	esac
>  }
>  
>  _zone_type()
> -- 
> 2.32.0
> 
