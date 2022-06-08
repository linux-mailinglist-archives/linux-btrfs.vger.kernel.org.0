Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF219543E7A
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 23:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbiFHVVn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jun 2022 17:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiFHVVj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jun 2022 17:21:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFD3193205;
        Wed,  8 Jun 2022 14:21:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4573921CC2;
        Wed,  8 Jun 2022 21:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654723297;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JPQSNYVYuyX5wkVekdO26jBNz62RUnnaOM9OdZ/QR2E=;
        b=McR/F3OYfPDhMfhfSbySUD8/nSqdT9CFuy7QZh4f1D6DA6TJhOwX0BUApJkPjutvzjh4Pn
        77m78p+fuofK4E3za+7U6jmGw53j+COKrezyoFlkR0LBD2/PvdCe13o8WlGr5YRaPFcq9W
        qqZjZ7U6YRAb1Erb0yjAG3qKTaFBAlY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654723297;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JPQSNYVYuyX5wkVekdO26jBNz62RUnnaOM9OdZ/QR2E=;
        b=Lw38qH18Jb/8lqBoI4SqZmmKPm6aNU76o7zVFoYrApRYpe1pdeMZECa+W7binSeV2WVRBp
        J8DUNtmgdDsCgYBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E6B8E13A15;
        Wed,  8 Jun 2022 21:21:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id y7jhNuASoWKiDQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 08 Jun 2022 21:21:36 +0000
Date:   Wed, 8 Jun 2022 23:17:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Stefan Roesch <shr@fb.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>, linux-btrfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] btrfs: sysfs: fix return value check in
 btrfs_force_chunk_alloc_s()
Message-ID: <20220608211705.GQ20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Wei Yongjun <weiyongjun1@huawei.com>,
        Stefan Roesch <shr@fb.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>, linux-btrfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
References: <20220608021252.990374-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608021252.990374-1-weiyongjun1@huawei.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 08, 2022 at 02:12:52AM +0000, Wei Yongjun wrote:
> In case of error, the function btrfs_start_transaction() returns
> ERR_PTR() and never returns NULL. The NULL test in the return value
> check should be replaced with IS_ERR().
> 
> Fixes: 46e1bce0ac34 ("btrfs: sysfs: add force_chunk_alloc trigger to force allocation")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Thanks, fix folded to the patch as it's still in the development branch.
