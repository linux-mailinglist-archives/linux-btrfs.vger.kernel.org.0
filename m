Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F069C6A4DAB
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Feb 2023 23:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjB0WCJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Feb 2023 17:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjB0WCI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Feb 2023 17:02:08 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6521B27999
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Feb 2023 14:02:06 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1DA3A1FD9E;
        Mon, 27 Feb 2023 22:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677535325;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DhpuZNLm68mDhQrBNzQUO4xzXcvGvgRYp0xYDXVRpqc=;
        b=m6ZYYDRvW8WxPhxVYGi/cJrqUOhRpTYcKL91onGCfj/yz7Q7WG5osCmPZFGc6XD9I+fsgw
        ILWxBYznYn0f9tTBZh5Xq5yPqmqL1+wKwK/wbifF1FAV8yNY6l18Yh2dAF7A64B8hWTEur
        EQnldhk890xrsJ06XbgykglPBhb1sJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677535325;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DhpuZNLm68mDhQrBNzQUO4xzXcvGvgRYp0xYDXVRpqc=;
        b=+aRhwubdpbBSTD4r5dnAysJvH7WX+5aYAH3x4VYpa3GVvk72WHSqFg3nE7FuFKU4DThGNg
        ze/zp0Xec/EFpQCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D8A7F13912;
        Mon, 27 Feb 2023 22:02:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3xDLM1wo/WPOSQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 27 Feb 2023 22:02:04 +0000
Date:   Mon, 27 Feb 2023 22:56:06 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] btrfs: fix the mount crash caused by confusing return
 value
Message-ID: <20230227215605.GL10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <2de92bdcebd36e4119467797dedae8a9d97a9df3.1677314616.git.wqu@suse.com>
 <6de919ad-6576-c96d-35f1-cdf09c19dfdc@oracle.com>
 <6dbb0207-efc2-10eb-990c-cfea6275f09c@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6dbb0207-efc2-10eb-990c-cfea6275f09c@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 27, 2023 at 02:34:25PM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/2/27 14:14, Anand Jain wrote:
> > On 2/25/23 16:44, Qu Wenruo wrote:
> >> [BUG]
> >> Btrfs mount can lead to crash if the fs has critical trees corrupted:
> >>
> >>   # mkfs.btrfs  -f /dev/test/scratch1
> >>   # btrfs-map-logical -l 30588928 /dev/test/scratch1 # The bytenr is 
> >> tree root
> >>   mirror 1 logical 30588928 physical 38977536 device /dev/test/scratch1
> >>   mirror 2 logical 30588928 physical 307412992 device /dev/test/scratch1
> >>   # xfs_io -f -c "pwrite 38977536 4" -c "pwrite 307412992 4" 
> >> /dev/test/scratch1
> >>   # mount /dev/test/scratch1 /mnt/btrfs
> >>
> >> And the above mount would crash with the following dmesg:
> >>
> >>   BTRFS warning (device dm-4): checksum verify failed on logical 
> >> 30588928 mirror 1 wanted 0xcdcdcdcd found 0x6ca45898 level 0
> >>   BTRFS warning (device dm-4): checksum verify failed on logical 
> >> 30588928 mirror 2 wanted 0xcdcdcdcd found 0x6ca45898 level 0
> >>   BTRFS warning (device dm-4): couldn't read tree root
> >>   ==================================================================
> >>   BUG: KASAN: null-ptr-deref in btrfs_iget+0x74/0x160 [btrfs]
> >>   Read of size 8 at addr 00000000000001f7 by task mount/4040
> >>
> >> [CAUSE]
> >> In open_ctree(), we have two variables to indicates errors: @ret and
> >> @err.
> >>
> >> Unfortunately such confusion leads to the above crash, as in the error
> >> handling of load_super_root(), we just goto fail_tree_roots label, but
> >> at the end of error handling, we return @err instead of @ret.
> >>
> >> Thus even we failed to load tree root, we still return 0 for
> >> open_ctree(), thus later btrfs_iget() would fail.
> > 
> > 
> >   There are many child functions in open_ctree() that rely on the default
> >   value of @err, which is -EINVAL, to return an error instead of ret.
> 
> That's even more bug prone.
> 
> After the first call site assigning @err, there is no more default value 
> for @err.
> 
> And this is not the first bug involving two error indicating numbers.
> Thus unless definitely needed, I strongly recommend not to use two error 
> values.

Agreed, the error handling styles in open_ctree are mixed and we should
switch it to using 'ret' with error value set before gotos. Basically
what you did in this patch, please resend it as a cleanup, I've merged
toe fixup from Anand to the original patch.
