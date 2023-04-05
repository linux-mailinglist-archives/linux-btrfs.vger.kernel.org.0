Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBFB6D7EAF
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Apr 2023 16:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjDEOKZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Apr 2023 10:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238203AbjDEOJj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Apr 2023 10:09:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217E27680;
        Wed,  5 Apr 2023 07:08:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C22CA221C2;
        Wed,  5 Apr 2023 14:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680703648;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q7zuBVLaIFHh285wB98TqvOGX4/YibGGi+eJVuVa9m8=;
        b=MMMdwsA0qMu2iDXi+7GAnmrqSGiBtMv0dkdsZnOkbUJbnrrDfdLnPXpsjgSwcXN8B7UkE6
        w6sJJCyHecvyqvrfUpxvX2oPW6Jo881526Vw0eEV/mBGIl7oLMq/KCeK0kVoAW7gsrDLPH
        wkWSN7VvSbfJpX/oxuUXcxy6S/9uTuE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680703648;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q7zuBVLaIFHh285wB98TqvOGX4/YibGGi+eJVuVa9m8=;
        b=G1DszX9IuwR4tkIW93VhxviFEmh4tutaFv/5FPoneApjYqLIKOpCvsEv4Xg8AW+iUJWInP
        7SLoM21nYQSKFmAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 98A4213A31;
        Wed,  5 Apr 2023 14:07:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ec2KJKCALWTVfgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 05 Apr 2023 14:07:28 +0000
Date:   Wed, 5 Apr 2023 16:07:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-btrfs@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: remove crc32c_impl
Message-ID: <20230405140726.GI19619@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230405054905.94678-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405054905.94678-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 05, 2023 at 07:49:03AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series stops printing the crc32c implementation at btrfs load
> time as it's already printed at mount time, and then removes the
> now unused crc32c_impl function.

Added to misc-next, with Herbert's ack, thanks.
