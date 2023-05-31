Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD691717DA7
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 13:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235251AbjEaLGq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 07:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbjEaLGp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 07:06:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1783E68
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 04:06:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9057C2188C;
        Wed, 31 May 2023 11:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685531182;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CyoQvs19/7rSBqRvOGXXyjS2w0qSV4GloIy+tbnwULk=;
        b=XkzI+AQqpFMuaSkDQNWvdnhPRTvd+XhbjKvdFhDzupgwSn0tLYxLYlT0l/4DQ+gHCFv1To
        CJ0QjNqGrcns7b+N8wfyB+2VMcIeKzVKRis64alWZrR96i4pcrf5Uc1nRxDylrie3jC9eg
        xjU9b9F2MsO5UAVskRQ2IuWKPnHjKQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685531182;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CyoQvs19/7rSBqRvOGXXyjS2w0qSV4GloIy+tbnwULk=;
        b=qNOfqlf8TrEYRCLbSzmfLh6UPXDpan6gkFtiVFAtZm4QbPkxu6eHL8Ip3bTLLN4/xPzCbY
        O9bj2VmJcCbho7CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6A41113488;
        Wed, 31 May 2023 11:06:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id G80YGS4qd2TUNgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 31 May 2023 11:06:22 +0000
Date:   Wed, 31 May 2023 13:00:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: add CHANGING_FSID_V2 to print-tree
Message-ID: <20230531110011.GF32581@suse.cz>
Reply-To: dsterba@suse.cz
References: <8e152cd504552e92680290cd34bf30bfef0cc1aa.1685440589.git.anand.jain@oracle.com>
 <20230530123710.GM575@twin.jikos.cz>
 <feebdbb8-d7d8-c51a-6ed7-95f18def2827@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <feebdbb8-d7d8-c51a-6ed7-95f18def2827@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 31, 2023 at 01:46:31PM +0800, Anand Jain wrote:
> On 30/05/2023 20:37, David Sterba wrote:
> > On Tue, May 30, 2023 at 06:15:11PM +0800, Anand Jain wrote:
> >> Add the DEF_SUPER_FLAG_ENTRY for CHANGING_FSID_V2 to our btrfs-progs'
> >> print-tree.c, as it is currently missing in the dump-super output, which
> >> was too confusing.
> >>
> >> Before:
> >> flags			0x1000000001
> >> 			( WRITTEN )
> >>
> >> After:
> >> flags			0x1000000001
> >> 			( WRITTEN |
> >> 			  CHANGING_FSID_V2 )
> >>
> >> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> >> ---
> >>   kernel-shared/print-tree.c | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
> >> index aaaf58ae2e0f..623f192aaefc 100644
> >> --- a/kernel-shared/print-tree.c
> >> +++ b/kernel-shared/print-tree.c
> >> @@ -1721,6 +1721,7 @@ static struct readable_flag_entry super_flags_array[] = {
> >>   	DEF_HEADER_FLAG_ENTRY(WRITTEN),
> >>   	DEF_HEADER_FLAG_ENTRY(RELOC),
> >>   	DEF_SUPER_FLAG_ENTRY(CHANGING_FSID),
> >> +	DEF_SUPER_FLAG_ENTRY(CHANGING_FSID_V2),
> > 
> > Should the flag be also added to BTRFS_SUPER_FLAG_SUPP? Currently all
> > the other SUPER_FLAGs are there.
> 
> I have the patch locally and need to confirm a few things before sending
> it, which can be a separate patch.

OK, so this one was added to devel, thanks.
