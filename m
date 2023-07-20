Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384CA75ACA8
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jul 2023 13:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjGTLPZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 07:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjGTLPX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 07:15:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E243826B1;
        Thu, 20 Jul 2023 04:15:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9A5CC22C3E;
        Thu, 20 Jul 2023 11:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689851720;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=euYYOcjydwE/a+t2LH9+VI+ehKzPfjxqAhBdprEQVPk=;
        b=ZuOD7XPA6kjXkPU2f35hkNVSj+s9SFqp5usIu5RTJyuLgd1DY9GnKV5h1qltfBzP1CJmWW
        W38lv1Hmo/KYY0Ck3q1BwcaFg9T6H7PkXjPrsPw+SJGdfN+V/6pxyJO3HCHD2epjtlMVvU
        RPKe/q2atRvRc8e3/R6B9DTCnZSxBH8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689851720;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=euYYOcjydwE/a+t2LH9+VI+ehKzPfjxqAhBdprEQVPk=;
        b=r1g7T6wsj4YgN8grOCor5BpRkV3/Fydkbg7nXg2Wr/uYSys/SbOZ67e1dzqqK0vmxjXLhR
        re9e+DsY2bdaE5BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E6DE133DD;
        Thu, 20 Jul 2023 11:15:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cBggGkgXuWTmfwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 20 Jul 2023 11:15:20 +0000
Date:   Thu, 20 Jul 2023 13:08:40 +0200
From:   David Sterba <dsterba@suse.cz>
To:     wuyonggang001@208suo.com
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        terrelln@fb.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: Modify format error
Message-ID: <20230720110840.GV20457@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230717071645.45023-1-zhanglibing@cdjrlc.com>
 <12728f5d0ca3c593da3b4f4017efd1e2@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12728f5d0ca3c593da3b4f4017efd1e2@208suo.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 17, 2023 at 03:19:04PM +0800, wuyonggang001@208suo.com wrote:
> Fix the following checkpatch error(s):
> ERROR: "foo* const bar" should be "foo * const bar"
> ERROR: "foo* bar" should be "foo *bar"
> 
> Signed-off-by: Yonggang Wu <wuyonggang001@208suo.com>

Please don't send patches to btrfs that only fix problems reported by
checkpatch and nothing else.  Thanks.
