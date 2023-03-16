Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080016BD411
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Mar 2023 16:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjCPPks (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Mar 2023 11:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbjCPPkc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Mar 2023 11:40:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E231DB7DB5
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Mar 2023 08:39:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E43AD1FE0E;
        Thu, 16 Mar 2023 15:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678981132;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZdMX8P7GG0cboTsetU3aw67IAXxaozvv8PW28NQnntY=;
        b=SfKzvjKmTRAB4QikRXkCVzC8ODKUHvkI4Q8+Rr9M25Nmyf2NqiwdwVrtyVnXYtr5ixaimN
        69YB0fFmqvHLjip3dJz+U2k9PpdsC27Dlgf4pcYstdG2DURFL8vvLWrgx29oUkbo3oSfWJ
        YCgQlQKbrqx+hraOFKs2bfjwUfk2NBI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678981132;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZdMX8P7GG0cboTsetU3aw67IAXxaozvv8PW28NQnntY=;
        b=1azstblo1Wg4GvBf+yvXJf0+bMPl+cDdWiwkXRaSzy74d1zUTGGMEWH/63HAheWQ7ScDR3
        oN1ZoI1zPCCYSBCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BB15513A2F;
        Thu, 16 Mar 2023 15:38:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id A9NPLAw4E2Q5EQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 16 Mar 2023 15:38:52 +0000
Date:   Thu, 16 Mar 2023 16:32:45 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Holger Jakob <jakob@dsi.uni-stuttgart.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Fixed issue with restore of xattrs not working on
 directories
Message-ID: <20230316153245.GA10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <7b2b7360-9008-7d88-02db-1ca4f07a6df6@oracle.com>
 <20230202043345.14010-1-jakob@dsi.uni-stuttgart.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202043345.14010-1-jakob@dsi.uni-stuttgart.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 01, 2023 at 08:33:44PM -0800, Holger Jakob wrote:
> Restore was only setting xattrs on files but ignored directories.
> The patch adds a missing set_file_xattrs
> 
> Signed-off-by: Holger Jakob <jakob@dsi.uni-stuttgart.de>

Added to devel with some minor updates, thanks.
