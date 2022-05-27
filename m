Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F4161535F36
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 May 2022 13:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351284AbiE0LWg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 May 2022 07:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351276AbiE0LWb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 May 2022 07:22:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6AD50465;
        Fri, 27 May 2022 04:22:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DED3C219B9;
        Fri, 27 May 2022 11:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653650548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SpTCWs2Gn6mN/dNUzJWFo7RsyDnEc31OxY5BJucnbEo=;
        b=StlGUuvsm7oRnfaCeh4ic2phoEXx4DO2SZv7Lhb9fe/lxNC6siYqZ86WX06i2Mrlwsec+o
        +Dc0JLWsPq+wTCOAbDPAR4CuH/+546gSgokkKdnbbPkjOh/Ow9cNgu2fYiv5UEK5GzfCgE
        bbeHG7dzFyJcO+vDoKxPgDJKuZ6/JAg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ABD21139C4;
        Fri, 27 May 2022 11:22:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NwZMJ3S0kGJJBwAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 27 May 2022 11:22:28 +0000
Message-ID: <ed54f57f-4547-8b04-b59f-85c78da4b36f@suse.com>
Date:   Fri, 27 May 2022 14:22:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/9] btrfs: add a helpers for read repair testing
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <20220524071838.715013-1-hch@lst.de>
 <20220524071838.715013-2-hch@lst.de>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220524071838.715013-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 24.05.22 г. 10:18 ч., Christoph Hellwig wrote:
> Add a few helpers to consolidate code for btrfs read repair testing:
> 
>   - _btrfs_get_first_logical() gets the btrfs logical address for the
>     first extent in a file
>   - _btrfs_get_device_path and _btrfs_get_physical use the
>     btrfs-map-logical tool to find the device path and physical address
>     for btrfs logical address for a specific mirror
>   - _btrfs_direct_read_on_mirror and _btrfs_buffered_read_on_mirror
>     read the data from a specific mirror
> 
> These will be used to consolidate the read repair tests and avoid
> duplication for new tests.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   common/btrfs  | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   common/config |  1 +
>   2 files changed, 76 insertions(+)
> 
> diff --git a/common/btrfs b/common/btrfs
> index ac597ca4..129a83f7 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -505,3 +505,78 @@ _btrfs_metadump()
>   	$BTRFS_IMAGE_PROG "$device" "$dumpfile"
>   	[ -n "$DUMP_COMPRESSOR" ] && $DUMP_COMPRESSOR -f "$dumpfile" &> /dev/null
>   }
> +
> +# Return the btrfs logical address for the first block in a file
> +_btrfs_get_first_logical()
> +{
> +	local file=$1
> +	_require_command "$FILEFRAG_PROG" filefrag
> +
> +	${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar >> $seqres.full

Likely you want to print the logical layout of the file for reference 
purposes? Then use $file instead of $SCRATCH_MNT/foobar

<snip>
