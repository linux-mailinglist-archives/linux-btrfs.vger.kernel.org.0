Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E9A67BA73
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jan 2023 20:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235253AbjAYTOn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Jan 2023 14:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234862AbjAYTOm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Jan 2023 14:14:42 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916D4C157;
        Wed, 25 Jan 2023 11:14:40 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2853521D0C;
        Wed, 25 Jan 2023 19:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674674079;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KPSAzbPpfwjN9iFQ7OUbYUQ3PmJtY4nh/JFayVrEM/o=;
        b=P2MW2a/vmt7Q/5VUQ64HG3UpsvAzaOq/VOUxgeNKwzLfeLxb4P05fi7GeLVo7UlivzlpuG
        7BEKigDmXU5z3gvD0FFQIlaFj+rL4dt7y6AAumIEVfSqRufsRI5HjoUScFbwODP5k/zcTz
        mRGr1dXMC3VSGro01n+mmj70ppiDPYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674674079;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KPSAzbPpfwjN9iFQ7OUbYUQ3PmJtY4nh/JFayVrEM/o=;
        b=RguTEKH+qmg8YroONH+Pd9knBqjeTdSHmusa2gZouP61ZJ5qBBX0FTdHRDVeJzMuom9ek3
        GdT+w4DZXnT0g5DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E82BE1358F;
        Wed, 25 Jan 2023 19:14:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AhCnN55/0WNYYgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 25 Jan 2023 19:14:38 +0000
Date:   Wed, 25 Jan 2023 20:08:56 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] btrfs: Fix spelling mistakes found using codespell
Message-ID: <20230125190856.GW11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230117100321.113814-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117100321.113814-1-colin.i.king@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 17, 2023 at 10:03:21AM +0000, Colin Ian King wrote:
> There quite a few spelling mistakes as found using codespell. Fix them.
> Thanks to David Sterba for pointing these out.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Added to misc-next, thanks.
