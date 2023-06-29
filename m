Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAE17429B4
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jun 2023 17:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbjF2Pco (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jun 2023 11:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbjF2Pcn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jun 2023 11:32:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE581737;
        Thu, 29 Jun 2023 08:32:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 925BF21852;
        Thu, 29 Jun 2023 15:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688052760;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CF39aHuJ5fGh0Y07POJtC3zLyQWYmZ4Z6FG2uk56rSY=;
        b=kNK7h4h6nQ4ozBm7MdH6vd/lLI0Iordok3WuLf6jbRIGy52ze1LOfJYnSSbxhT/s892wOQ
        gsqx/AlPnuQzl0IpCE3saolOlZA2yfNUCECeHW7pyhfgh2cEjHB7innVAHd82khL6ELHsv
        H/KNNl7CPvG48S1Ij4gba980D524hyg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688052760;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CF39aHuJ5fGh0Y07POJtC3zLyQWYmZ4Z6FG2uk56rSY=;
        b=OFRsrxZan+iL8O1yjgF6HJik9toGtqw5Ast9VD0hVU8eck18o7BkpxZNZf3qqI4ZX72En5
        iobaY7vtwhp2e8BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 65D4213905;
        Thu, 29 Jun 2023 15:32:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zZjsFxiknWSGOAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 29 Jun 2023 15:32:40 +0000
Date:   Thu, 29 Jun 2023 17:26:12 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] btrfs: remove redundant initialization of
 variables leaf and slot
Message-ID: <20230629152611.GM16168@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230622075430.2794134-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622075430.2794134-1-colin.i.king@gmail.com>
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

On Thu, Jun 22, 2023 at 08:54:30AM +0100, Colin Ian King wrote:
> The variables leaf and slot are initialized when declared but the values
> assigned to them are never read as they are being re-assigned later on.
> The initializations are redundant and can be removed. Cleans up clang
> scan build warings:
> 
> fs/btrfs/tree-log.c:6797:25: warning: Value stored to 'leaf' during its
> initialization is never read [deadcode.DeadStores]
> fs/btrfs/tree-log.c:6798:7: warning: Value stored to 'slot' during its
> initialization is never read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Added to misc-next, thanks.
