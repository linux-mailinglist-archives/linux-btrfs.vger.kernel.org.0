Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D85780ED4
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Aug 2023 17:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378041AbjHRPOI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Aug 2023 11:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378126AbjHRPN6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Aug 2023 11:13:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4B1420C;
        Fri, 18 Aug 2023 08:13:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 054A16799F;
        Fri, 18 Aug 2023 15:13:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E14AC433C8;
        Fri, 18 Aug 2023 15:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692371627;
        bh=dbVY/7X939PbYQV4Uo1apM3b+upUFEDXajeANe6mJeM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LfaVuJ1CfUEs6BMvxT76uva38k0qqakeE64tyrWBIxfSxGUwZQsY0OjRgq5G1vHWI
         yMKRRNLFCI20xHbpmqlUeDnJH2gndp+atwjJBPSI/Ou+ioyNJ1/pO/kwNTRqvyk3C+
         Tn9Tsp8EeDaDF2eKoADj27WjZ0gE54FE2P8un+Ng0k4kGhV3R00TZvfhs99cS/JYKc
         IMpZA28N25YxlM/CauVi85trmQ46Er1fGdfE0GPdfzU2w5brvyzdyLDqiVqYKL/Bn4
         g7X7eM+YRInChQM2GI9qUdUhlqNQeAOlmUh8TNDk2L2ojCagC3bz+hmRsoG9ASzch5
         2XzFOnrazWs2Q==
Date:   Fri, 18 Aug 2023 08:13:46 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        zlang@redhat.com, ddiss@suse.de
Subject: Re: [PATCH] fstests: use btrfs check repair for repairing btrfs
 filesystems
Message-ID: <20230818151346.GR11340@frogsfrogsfrogs>
References: <2c89e68e7a34f1d0545f19e9e178e258f777c027.1692286458.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c89e68e7a34f1d0545f19e9e178e258f777c027.1692286458.git.anand.jain@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 17, 2023 at 11:40:04PM +0800, Anand Jain wrote:
> There are two repair functions: _repair_scratch_fs() and
> _repair_test_fs(). As the names suggest, these functions are designed to
> repair the filesystems SCRATCH_DEV and TEST_DEV, respectively. However,
> these functions never called proper comamnd for the filesystem type btrfs.
> This patch fixes it. Thx.

Heh.  This sounds like a good improvement. :)

> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  common/rc | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 66d270acf069..49effbf760c0 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1177,6 +1177,15 @@ _repair_scratch_fs()
>  	fi
>  	return $res
>          ;;
> +    btrfs)
> +	echo "btrfs check --repair --force $SCRATCH_DEV"
> +	btrfs check --repair --force $SCRATCH_DEV 2>&1

Should you allow callers of _repair_{test,scratch}_fs to pass in
arguments?

--D

> +	local res=$?
> +	if [ $res -ne 0 ]; then
> +		_dump_err2 "btrfs repair failed, err=$res"
> +	fi
> +	return $res
> +	;;
>      bcachefs)
>  	# With bcachefs, if fsck detects any errors we consider it a bug and we
>  	# want the test to fail:
> @@ -1229,6 +1238,11 @@ _repair_test_fs()
>  			res=$?
>  		fi
>  		;;
> +	btrfs)
> +		echo 'btrfs check --repair --force "$@"' > /tmp.repair 2>&1
> +		btrfs check --repair --force "$@" >> /tmp.repair 2>&1
> +		res=$?
> +		;;
>  	*)
>  		# Let's hope fsck -y suffices...
>  		fsck -t $FSTYP -y $TEST_DEV >$tmp.repair 2>&1
> -- 
> 2.39.3
> 
