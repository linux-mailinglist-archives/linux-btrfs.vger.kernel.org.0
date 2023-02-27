Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31636A3E3F
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Feb 2023 10:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjB0JXW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Feb 2023 04:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjB0JXI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Feb 2023 04:23:08 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB37C19BC;
        Mon, 27 Feb 2023 01:22:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 65B621F8D4;
        Mon, 27 Feb 2023 09:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1677489746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ReERuXUJalVnCv7Yf07A43HSyHlqsyrpLzWS625UtE4=;
        b=Cc8ae/N2vfQkHrAwobgeaDlmqNir9I2nIDtuztuhq1bj7jOIhmQQ/zEo4uqXVE8w2a00qm
        O5bnUpbzqhEbAWoqOp7M1+MOwiDqmLA0tBHnIg8TefHuEMakQcnE8KjuqbO0heBxPviH3R
        wPEaQcjjqDepxIN/7lOdrgZDu2E71ks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1677489746;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ReERuXUJalVnCv7Yf07A43HSyHlqsyrpLzWS625UtE4=;
        b=FkV7Syxznq7tzHoqRQJ8tv3te3h5fAtp8K8g5Y3UwmcIAifHiq0hjn/o5S/TilHUtCvFMN
        2jQkFJqZxr1X9uBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3F98B13912;
        Mon, 27 Feb 2023 09:22:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5mU5DlJ2/GP9UwAAMHmgww
        (envelope-from <ddiss@suse.de>); Mon, 27 Feb 2023 09:22:26 +0000
Date:   Mon, 27 Feb 2023 10:23:51 +0100
From:   David Disseldorp <ddiss@suse.de>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Zorro Lang <zlang@redhat.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
Subject: Re: [PATCH v2] common/rc: don't clear superblock for zoned scratch
 pools
Message-ID: <20230227102351.2fa21c70@echidna.fritz.box>
In-Reply-To: <20230227082717.325929-1-johannes.thumshirn@wdc.com>
References: <20230227082717.325929-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Johannes,

On Mon, 27 Feb 2023 00:27:17 -0800, Johannes Thumshirn wrote:

> _require_scratch_dev_pool() zeros the first 100 sectors of each device to
> clear eventual remains of older filesystems.
> 
> On zoned devices this won't work as a plain dd will end up creating
> unaligned write errors failing all subsequent actions on the device.
> 
> For zoned devices it is enough to simply reset the first two zones of the
> device to achieve the same result.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  common/rc | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 654730b21ead..739abbdbfc8c 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3459,9 +3459,15 @@ _require_scratch_dev_pool()
>  		            exit 1
>  		        fi
>  		fi
> -		# to help better debug when something fails, we remove
> -		# traces of previous btrfs FS on the dev.
> -		dd if=/dev/zero of=$i bs=4096 count=100 > /dev/null 2>&1
> +		# To help better debug when something fails, we remove
> +		# traces of previous btrfs FS on the dev. For zoned devices we
> +		# can't use dd as it'll lead to unaligned writes so simply
> +		# reset the first two zones.
> +		if [ "`_zone_type "$i"`" = "none" ]; then
> +			dd if=/dev/zero of=$i bs=4096 count=100 > /dev/null 2>&1
> +		else
> +			blkzone reset -c 2 $i
> +		fi

IIUC, any output from blkzone reset will cause test failures - is that
an intention here, or should output go to /dev/null like dd?

Looks fine otherwise.

Cheers, David
