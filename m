Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D9753FAC6
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jun 2022 12:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240606AbiFGKD5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 06:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240603AbiFGKDu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 06:03:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800FD92D25;
        Tue,  7 Jun 2022 03:03:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6024F6136E;
        Tue,  7 Jun 2022 10:03:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA1BC3411E;
        Tue,  7 Jun 2022 10:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654596227;
        bh=vWfrmukILqKlyTS37plpb4kkEkkiKtiobb3C0DuRQ80=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vq9s/jOMwoacFRCVEZqhD25ij91fIGhaAip3h2ZAKnaSGMENeE0BZlwnXwNbe36pl
         LYVZeRKR0+6kOMaQf9Om914bx3Zh3kizu9ojOSIY9qO/Y7K9NozrKnY3skH/CsFEwS
         HsPZVFJrIV1g3T7OMKggM26DTDarbWm5TL5H4VlLAHbEdrMMhDghpYypbEk0LDQj88
         mJQInOq32j9lz2anyIS4SenMLiRO2cMyFZB3egHK0B/HygHVTecnLRmrzy5TTFP2gi
         aDI830XuiBoeJxyDQcysjfa1jJmSXMU4dsyaYuYlqVs/kHCUvNjDpuHItWLcxnUOwo
         iplMs0jKEUMEA==
Date:   Tue, 7 Jun 2022 11:03:44 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs/220: zoned: skip nodatacow mount option for zoned
 btrfs
Message-ID: <20220607100344.GA3556776@falcondesktop>
References: <20220607080635.4010254-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607080635.4010254-1-naohiro.aota@wdc.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 07, 2022 at 05:06:35PM +0900, Naohiro Aota wrote:
> The nodatacow mount option is not allowed on zoned btrfs and failing the
> test. Skip the cases for zoned btrfs.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  tests/btrfs/220 | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/tests/btrfs/220 b/tests/btrfs/220
> index fa91a38493af..4d94ccd6eee2 100755
> --- a/tests/btrfs/220
> +++ b/tests/btrfs/220
> @@ -265,14 +265,16 @@ test_revertible_options()
>  	test_roundtrip_mount "compress=zlib:20" "compress=zlib:9" "compress=zstd:16" "compress=zstd:15"
>  	test_roundtrip_mount "compress-force=lzo" "compress-force=lzo" "compress-force=zlib:4" "compress-force=zlib:4"
>  
> -	# on remount, if we only pass datacow after nodatacow was used it will remain with nodatasum
> -	test_roundtrip_mount "nodatacow" "nodatasum,nodatacow" "datacow,datasum" "$DEFAULT_OPTS"
> -	# nodatacow disabled compression
> -	test_roundtrip_mount "compress-force" "compress-force=zlib:3" "nodatacow" "nodatasum,nodatacow"
> -
> -	# nodatacow disabled both datacow and datasum, and datasum enabled datacow and datasum
> -	test_roundtrip_mount "nodatacow" "nodatasum,nodatacow" "datasum" "$DEFAULT_OPTS"
> -	test_roundtrip_mount "nodatasum" "nodatasum" "datasum" "$DEFAULT_OPTS"
> +	if ! _scratch_btrfs_is_zoned; then
> +		# on remount, if we only pass datacow after nodatacow was used it will remain with nodatasum
> +		test_roundtrip_mount "nodatacow" "nodatasum,nodatacow" "datacow,datasum" "$DEFAULT_OPTS"
> +		# nodatacow disabled compression
> +		test_roundtrip_mount "compress-force" "compress-force=zlib:3" "nodatacow" "nodatasum,nodatacow"
> +
> +		# nodatacow disabled both datacow and datasum, and datasum enabled datacow and datasum
> +		test_roundtrip_mount "nodatacow" "nodatasum,nodatacow" "datasum" "$DEFAULT_OPTS"
> +		test_roundtrip_mount "nodatasum" "nodatasum" "datasum" "$DEFAULT_OPTS"
> +	fi
>  
>  	test_should_fail "discard=invalid"
>  	if [ "$enable_discard_sync" = true ]; then
> -- 
> 2.35.1
> 
