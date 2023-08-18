Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D765780A38
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Aug 2023 12:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352853AbjHRKdl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Aug 2023 06:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376421AbjHRKdB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Aug 2023 06:33:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D2F5252;
        Fri, 18 Aug 2023 03:31:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FC3664DBB;
        Fri, 18 Aug 2023 10:30:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8B8C433C8;
        Fri, 18 Aug 2023 10:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692354658;
        bh=63lRPFTg7ct+Dnx7XZ2X+5lpSIhFj0qwVUOWb3PcDec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A429/HDl6/oOgmOK6ESg06MrTgl7reuKRqKdawrmeKcpKOaUTjXTZGTAxtZUvYF8G
         vRB/odbt6ASS3ouOh4xtZQbZcig9yrNvZhKowt6Muf6fqOvmEgTSm/pnIqpj7XX7I3
         5kz4kRURlJ+8KWcd9OAORAU5VX2OWeyMWdezWbapPHVSNPqFvL+fA0+cgbygt5WmQ5
         y/PkaDKPFBdrZyo4y8RDBWvnSUzZxBGV802NB1x3AgCq0QI++bO0n1dDfzdjh9hqZH
         df5uZHeRajHmKPcbOAe/n0ZCvrnlU6YkA7nqj0sl3LdW10tToIJpI0un+RMdDFFKgC
         LjBpZ019ZHJXA==
Date:   Fri, 18 Aug 2023 11:30:53 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs/220: do not run async discard test on zoned device
Message-ID: <ZN9IXf/otvhQsxSw@debian0.Home>
References: <20230818020325.1214715-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818020325.1214715-1-naohiro.aota@wdc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 18, 2023 at 11:03:25AM +0900, Naohiro Aota wrote:
> The mount option "discard=async" is not meant to be used on the zoned mode.
> Skip it from the test.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  tests/btrfs/220 | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/btrfs/220 b/tests/btrfs/220
> index 30ca06f6038d..b092f40bc1e0 100755
> --- a/tests/btrfs/220
> +++ b/tests/btrfs/220
> @@ -279,7 +279,9 @@ test_revertible_options()
>  	test_should_fail "discard=invalid"
>  	if [ "$enable_discard_sync" = true ]; then
>  		test_roundtrip_mount "discard" "discard" "discard=sync" "discard"
> -		test_roundtrip_mount "discard=async" "discard=async" "discard=sync" "discard"
> +		if ! _scratch_btrfs_is_zoned; then
> +			test_roundtrip_mount "discard=async" "discard=async" "discard=sync" "discard"
> +		fi
>  		test_roundtrip_mount "discard=sync" "discard" "nodiscard" "$DEFAULT_NODISCARD_OPTS"
>  	else
>  		test_roundtrip_mount "discard" "discard" "discard" "discard"
> -- 
> 2.41.0
> 
