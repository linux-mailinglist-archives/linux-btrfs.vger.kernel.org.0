Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2D175A12F
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jul 2023 00:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjGSWA4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jul 2023 18:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGSWAx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jul 2023 18:00:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84101FD9;
        Wed, 19 Jul 2023 15:00:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 28B17201D2;
        Wed, 19 Jul 2023 22:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689804050;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GKhlFvee6LjWmkqXW4vufx/tgUR4Vb2UCUltoEeEI+0=;
        b=xIiPc3MwZDb8j64g8tV0VxPn5rwEQajv8mlo2O6/JULy4sSJW99DG2x0w6GTv/uuXAFLuB
        uB2NEAAxHp+prjwp2AJGDO2lPTKRJq5npfktEwUTI4nDHcfKAFEoHIn61+12iZm23hOzOu
        ONYhPOxxKxT2gUjUSbAnN1CWHRM5Gyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689804050;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GKhlFvee6LjWmkqXW4vufx/tgUR4Vb2UCUltoEeEI+0=;
        b=LH1Ys3piawcY+74iyAfI2DOuEUho9l9XZhmYQ/sz5wMhBZzvsyqIpVLMZ5hYh5fvSsXgPK
        /GjoueQaY5sqeyCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EEB131361C;
        Wed, 19 Jul 2023 22:00:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TE1WORFduGTaHgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 19 Jul 2023 22:00:49 +0000
Date:   Wed, 19 Jul 2023 23:54:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Minjie Du <duminjie@vivo.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
Subject: Re: [PATCH v1] btrfs: increase usage of folio_next_index() helper
Message-ID: <20230719215409.GT20457@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230717071622.5992-1-duminjie@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717071622.5992-1-duminjie@vivo.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 17, 2023 at 03:16:22PM +0800, Minjie Du wrote:
> Simplify code pattern of 'folio->index + folio_nr_pages(folio)' by using
> the existing helper folio_next_index().
> 
> Signed-off-by: Minjie Du <duminjie@vivo.com>

With a slightly modified subject added to misc-next, thanks.
