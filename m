Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE60588D21
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Aug 2022 15:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237709AbiHCNjc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Aug 2022 09:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbiHCNjb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Aug 2022 09:39:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343E8186C4
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Aug 2022 06:39:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E5B2333BA0;
        Wed,  3 Aug 2022 13:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659533968;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=avBd5QTRIM4VWAu9+C1vvNzlcsyoDLoPBJL5/EF0JmQ=;
        b=2QHM8JsHqq3Obq1X+e0v01oPy3SlKZoaCT0TCPArGI+iDmngMJ0doq8DYfX0NWKTTi+B9+
        zALiiRlA/bpP1RlRbqB/haAvEw3JJ9RE/kD62PXW9SiFdy/zJJQhcJoqRhx7GLxxalFiuS
        0fEoGOXy2mplwc84gq/dccxpnEGNslE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659533968;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=avBd5QTRIM4VWAu9+C1vvNzlcsyoDLoPBJL5/EF0JmQ=;
        b=OMh51kzBasrcR0Fv+bmTBLwQxTRXqJDxtFlw/UYcXYedRNa0uPu8lrxe1gb/ey7BLuVtdM
        KC2SfSFVxMoOHRBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CA53913A94;
        Wed,  3 Aug 2022 13:39:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id THBdMJB66mI1BAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 03 Aug 2022 13:39:28 +0000
Date:   Wed, 3 Aug 2022 15:34:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/4] btrfs: prepare more slots for checksum shash
Message-ID: <20220803133426.GF13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1659443199.git.dsterba@suse.com>
 <42f231d8d6f95fdc731b423fdc7c3ae2a6685318.1659443199.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42f231d8d6f95fdc731b423fdc7c3ae2a6685318.1659443199.git.dsterba@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 02, 2022 at 02:28:21PM +0200, David Sterba wrote:
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -65,8 +65,9 @@ static void btrfs_error_commit_super(struct btrfs_fs_info *fs_info);
>  
>  static void btrfs_free_csum_hash(struct btrfs_fs_info *fs_info)
>  {
> -	if (fs_info->csum_shash)
> -		crypto_free_shash(fs_info->csum_shash);
> +	for (int i = 0; i < CSUM_COUNT; i++)

This must start from 1, otherwise it would double free one of the
hashes.

> +		if (fs_info->csum_shash[i])
> +			crypto_free_shash(fs_info->csum_shash[i]);
>  }
