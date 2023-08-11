Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5E67792FB
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Aug 2023 17:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbjHKPZ1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Aug 2023 11:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjHKPZ0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Aug 2023 11:25:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D757DC
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Aug 2023 08:25:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D2BEC1F890;
        Fri, 11 Aug 2023 15:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691767524;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/2/GKQs+xTtTGdgr1rdypjscK3YIHxulKhCh1aChAKU=;
        b=N8oLRTYja/aW9KrXgIkH9FYPoj7SyvRCZSeZdUvJ1mVDjC3KoB4ACTSLty/K3TdEd40Jiv
        UhFGR8uSn8fvsTKjkKY6FrbBBEIFagymwZ0K64va200stqIOn3R217VrZdKW7wHZfXyHaX
        pJoBzdDlYpj0zOfLwVkdO/a+8z0djrM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691767524;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/2/GKQs+xTtTGdgr1rdypjscK3YIHxulKhCh1aChAKU=;
        b=SF1pP+8yN5dtyCZ78GuxnZcwkUMVVBEV1jIHPowLA69OKKafWXH2Wt8XomflhgBO9VVA3S
        zvx6BBc+IrhXmfBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A4B2313592;
        Fri, 11 Aug 2023 15:25:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id r4leJ+RS1mQoMgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 11 Aug 2023 15:25:24 +0000
Date:   Fri, 11 Aug 2023 17:18:59 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/7] btrfs: add a helper to read the superblock
 metadata_uuid
Message-ID: <20230811151859.GQ2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1690792823.git.anand.jain@oracle.com>
 <1cd0b6f911758c85fd135c24d88c3b0b9f0f85a4.1690792823.git.anand.jain@oracle.com>
 <2fe397bb-2d0c-7881-46a3-6dbf094bc85b@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fe397bb-2d0c-7881-46a3-6dbf094bc85b@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 01, 2023 at 01:16:42PM +0000, Johannes Thumshirn wrote:
> On 31.07.23 13:18, Anand Jain wrote:
> > +u8 *btrfs_sb_fsid_ptr(struct btrfs_super_block *sb)
> > +{
> > +	bool has_metadata_uuid = (btrfs_super_incompat_flags(sb) &
> > +				  BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
> > +
> > +	return has_metadata_uuid ? sb->metadata_uuid : sb->fsid;
> > +}
> 
> Not a huge fan of the overly long variable name and first line, but the 
> concept looks good:

For the incompat bit checks (btrfs_fs_incompat & co) we have the macros
that glue the prefix of the bit name but that's for the fs_info data.
For raw buffers of super block we use the unpreprocessed helpers/macros,
there are like 3 in total so that's probably not worth a helper.
