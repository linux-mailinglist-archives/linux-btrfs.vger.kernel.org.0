Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044215AD647
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Sep 2022 17:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238922AbiIEPWt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Sep 2022 11:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238776AbiIEPWZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Sep 2022 11:22:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EE05D0DA;
        Mon,  5 Sep 2022 08:22:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 335381FA34;
        Mon,  5 Sep 2022 15:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662391336;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ij2HQibHOOafwjJO9FvBbvwpWe/0kyBucrcPaRy/qEk=;
        b=N4Lm+LiGxlTLwAeQaT777MxP1lSnMsw4/zyxFLrUnhEaGVCVwTIHUq7gsSTmneXhwA/0u+
        OectTRf6vN8hdUW8bgwfoQp0BuIWgq2MXdVzU6GkG0okpwpprxx5CjkB16PYnwiYBdU8uj
        08SdU8KguWyWU+Pff19SKZ7HzBfm1bM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662391336;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ij2HQibHOOafwjJO9FvBbvwpWe/0kyBucrcPaRy/qEk=;
        b=VtueKhObHaxUMV7C0AiHPP0kqBoLULPqcAlG9L0GU51M/j9nWMu1Ys4debOq5CD4ZnnoSb
        d968mfuGAvcKoICg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EAE8D139C7;
        Mon,  5 Sep 2022 15:22:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kU+EOCcUFmO+VgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 05 Sep 2022 15:22:15 +0000
Date:   Mon, 5 Sep 2022 17:16:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     cgel.zte@gmail.com
Cc:     dsterba@suse.com, clm@fb.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhang songyi <zhang.songyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] btrfs: Remove the unneeded result variables
Message-ID: <20220905151654.GH13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20220902154029.321284-1-zhang.songyi@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902154029.321284-1-zhang.songyi@zte.com.cn>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 02, 2022 at 03:40:29PM +0000, cgel.zte@gmail.com wrote:
> From: zhang songyi <zhang.songyi@zte.com.cn>
> 
> Return the sysfs_emit() and iterate_object_props() directly instead of
> redundant variables.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>

Added to misc-next, thanks.
