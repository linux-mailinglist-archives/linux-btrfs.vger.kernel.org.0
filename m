Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09256F47E8
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 May 2023 18:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjEBQFs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 May 2023 12:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEBQFr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 May 2023 12:05:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCC026AC
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 09:05:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8F3331FD74;
        Tue,  2 May 2023 16:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683043545;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=he7hOUn34cVGbveTVp9bH4VppcI0HPMeE0W6jAQcbSM=;
        b=UiWfBdoWP6TplXCr6fTaZWI6YDLmp2JWkucDP0Dib8d02jlRlGdj113erDESlG6PMTOHlT
        pWTXLFa/FcVxR5N49VlblBZLDlB1EmVq1YNEl++8U1O1zU5TzQxIzyUzaay9SnA6Y6V99T
        lgJrwWlgZKLmp3aAoIAbF/ypmV9sUHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683043545;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=he7hOUn34cVGbveTVp9bH4VppcI0HPMeE0W6jAQcbSM=;
        b=x5p4dQL9md7LaPrpN+FWhgXDBSDZzpwaVnDKQfhhnlkAIfxQ5ejYwFLWRY7E6sRoL2AukY
        UoEV7XyxB5kPCZDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 71DDC134FB;
        Tue,  2 May 2023 16:05:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2MIQG9k0UWQgNgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 02 May 2023 16:05:45 +0000
Date:   Tue, 2 May 2023 17:59:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: use SECTOR_SHIFT to convert lba to phys
Message-ID: <20230502155950.GI8111@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cdef73bfb8c39d3c45cb7af6479499e2473c669a.1681556598.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdef73bfb8c39d3c45cb7af6479499e2473c669a.1681556598.git.anand.jain@oracle.com>
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

On Sat, Apr 15, 2023 at 07:32:38PM +0800, Anand Jain wrote:
> Using SECTOR_SHIFT to convert LBA to physical address makes it more
> readable.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Added to misc-next, thanks. With the two patches there are no more << 9
or >> 9 left. IIRC all new code used SECTOR_SHIFT so it's become a
common practice.
