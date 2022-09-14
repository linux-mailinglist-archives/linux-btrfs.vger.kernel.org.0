Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA6E5B8A09
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 16:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiINOLP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 10:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiINOLK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 10:11:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C4495A1
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 07:11:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7C9EB1FA72;
        Wed, 14 Sep 2022 14:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663164667;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dzuxo2qYoohVutv4ZYoIMXUUadmWiyP3m/waoDc09Y4=;
        b=MR5kbXGFhXMAUtzIn2QPYpm6SjbH1JxmQ18pbnUARgdwnfH5jSOPUSJETtFNENHBgNNiOG
        WHNGmGXpIry/mdBaFIY8HKd9m9MLvy6Thb2RAB567I0nlzuem0lVSiUEdMQd2s25KOu4pZ
        otz86aEHLp6J9Qz+lx+b5FbztnvWqyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663164667;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dzuxo2qYoohVutv4ZYoIMXUUadmWiyP3m/waoDc09Y4=;
        b=CoiHTIUPSCepDmhK5SoSNgJAZR/g3RMIaNdTTldn+LevmzH6AIbqSBQ/NMcz1SZ4BEQKjj
        IKeYUrviiX9pjoDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 60298134B3;
        Wed, 14 Sep 2022 14:11:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ADSVFvvgIWONLgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 14 Sep 2022 14:11:07 +0000
Date:   Wed, 14 Sep 2022 16:05:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 00/36] btrfs: move extent_io_tree code and cleanups
Message-ID: <20220914140539.GM32411@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1662760286.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1662760286.git.josef@toxicpanda.com>
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

On Fri, Sep 09, 2022 at 05:53:13PM -0400, Josef Bacik wrote:
> v1->v2:
> - Addressed the comments.
> - Broke up the giant move code patch up a bit by adding more exports and moving
>   other things in chunks.  There's still a big code move patch, but it's 1000
>   lines shorter, and not possible to shrink more without renaming functions.
> - Fixed a problem that crept in from rebasing previously.

Patches added to misc-next, thanks.  There were some fixups to comments
that are in the moved code, that has been there for a long time so this
was a good opportunity. For me it's easier to fix it at commit and you
can just move the code.

The overall result of the cleanups is -3500 bytes from the .ko module,
lots of saved stack space and structure size reduced. The patch from
Christoph removing EXTENT_DAMAGED has been rebased due to conflict in
patch 3.
