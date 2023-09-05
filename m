Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24802792761
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Sep 2023 18:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236771AbjIEQD1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Sep 2023 12:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354439AbjIELkq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Sep 2023 07:40:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CE01AD
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 04:40:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CEC242190B;
        Tue,  5 Sep 2023 11:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693914041;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ibNIREwhxZQhdbY+LJML10FAmzRIqEWbhJ/prtnSc90=;
        b=huvJ+aIab9783SaqzlNW9F8ymlh0BN1JOlVj9H9pjMwANeONsBL6QPu1osiIIcBZQaG88X
        Y/iqju+0cx90wBpdUjwbLUit0B+PTepljlGcbb3tJ8A4N5sOVupIHbbIRnKNusk9ioZQQU
        wgb1c6cht/yhMUBaEV03w7wlSuQ25Is=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693914041;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ibNIREwhxZQhdbY+LJML10FAmzRIqEWbhJ/prtnSc90=;
        b=f7E1b3nEHTokL1gyFoM4TbOaCxGDy6ait/ftIwAfeh6QuDCklyUKYJ6iJ92I+l1GoHvtMP
        7bnKmb0Bx70Di9AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B9EBC13499;
        Tue,  5 Sep 2023 11:40:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1Py0LLkT92QteQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 05 Sep 2023 11:40:41 +0000
Date:   Tue, 5 Sep 2023 13:34:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH resend] btrfs: simplify alloc_fs_devices() remove arg2
Message-ID: <20230905113402.GU14420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <338a56ae484b9c91ccfb2d2d5dd710d5c363ebfa.1692082136.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <338a56ae484b9c91ccfb2d2d5dd710d5c363ebfa.1692082136.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 23, 2023 at 10:52:13PM +0800, Anand Jain wrote:
> Among all the callers, only the device_list_add() function uses the
> second argument of alloc_fs_devices(). It passes metadata_uuid when
> available; otherwise, it passes NULL. And in turn, alloc_fs_devices()
> is designed to copy either metadata_uuid or fsid into
> fs_devices::metadata_uuid.
> 
> So eliminate the second argument in alloc_fs_devices(), and copy the
> fsid alway. In the caller device_list_add() function, we will overwrite
> it with metadata_uuid when it is available.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Added to misc-next, thanks.
