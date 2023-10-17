Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1257CC9F0
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Oct 2023 19:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbjJQRal (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Oct 2023 13:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbjJQRaj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Oct 2023 13:30:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46E795
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Oct 2023 10:30:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C25341F896;
        Tue, 17 Oct 2023 17:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697563835;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b4Lp88OLo+lG+sERs9rGXJ79O95GpabMJ/kepO8BiEk=;
        b=Vpimvsd7HtffSMZtzJYMqoNGiEB29PeYPakR9a5Wx2BbV2Gpov4bb2kYVmHa+K4np3Kp4E
        1gWdKTwHstD26TKNjVP9u0MsLlTRDXMgLS6nb06/YzmeCSRtWNxHM8XWcKUcxIHzpkmBxo
        CpCp+NsxNYAsS+StdjBdJlq7YmHmv0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697563835;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b4Lp88OLo+lG+sERs9rGXJ79O95GpabMJ/kepO8BiEk=;
        b=mcNZY3nrE2fP4JmoYqeFO6l940CAMn2Gri2UYFlhqsxSDdy1jJ984x6Iw5R9xYQieb2H73
        D7k9DNHeFToGY3AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8770A13597;
        Tue, 17 Oct 2023 17:30:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 76MXILvELmUKegAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 17 Oct 2023 17:30:35 +0000
Date:   Tue, 17 Oct 2023 19:23:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 1/2] btrfs-progs: mkfs/rootdir: copy missing
 attributes for the rootdir inode
Message-ID: <20231017172345.GA2211@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1697057301.git.wqu@suse.com>
 <d33e5e10e92a0c8c2a82005eba1da47927bf286a.1697057301.git.wqu@suse.com>
 <20231013155553.GQ2211@twin.jikos.cz>
 <9be61664-edfa-4771-b9cc-e3333d0fdbe8@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9be61664-edfa-4771-b9cc-e3333d0fdbe8@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
         ARC_NA(0.00)[];
         HAS_REPLYTO(0.30)[dsterba@suse.cz];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[4];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         FREEMAIL_ENVRCPT(0.00)[gmx.com];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         FREEMAIL_TO(0.00)[gmx.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Oct 14, 2023 at 06:25:03AM +1030, Qu Wenruo wrote:
> 
> 
> On 2023/10/14 02:25, David Sterba wrote:
> > On Thu, Oct 12, 2023 at 07:19:25AM +1030, Qu Wenruo wrote:
> >> [BUG]
> >> When using "mkfs.btrfs" with "--rootdir" option, the top level inode
> >> (rootdir) will not get the same xattr from the source dir:
> >>
> >>    mkdir -p source_dir/
> >>    touch source_dir/file
> >>    setfattr -n user.rootdir_xattr source_dir/
> >>    setfattr -n user.regular_xattr source_dir/file
> >>    mkfs.btrfs -f --rootdir source_dir $dev
> >>    mount $dev $mnt
> >>    getfattr $mnt
> >>    # Nothing <<<
> >>    getfattr $mnt/file
> >>    # file: $mnt/file
> >>    user.regular_xattr <<<
> >>
> >> [CAUSE]
> >> In function traverse_directory(), we only call add_xattr_item() for all
> >> the child inodes, not really for the rootdir inode itself, leading to
> >> the missing xattr items.
> >>
> >> Not only xattr, in fact we also miss the uid/gid/timestamps/mode for the
> >> rootdir inode.
> >>
> >> [FIX]
> >> Extract a dedicated function, copy_rootdir_inode(), to handle every
> >> needed attributes for the rootdir inode, including:
> >>
> >> - xattr
> >> - uid
> >> - gid
> >> - mode
> >> - timestamps
> >>
> >> Issue: #688
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >>   mkfs/rootdir.c | 88 ++++++++++++++++++++++++++++++++++++++------------
> >>   1 file changed, 67 insertions(+), 21 deletions(-)
> >>
> >> diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
> >> index a413a31eb2d6..24e26cdf50e0 100644
> >> --- a/mkfs/rootdir.c
> >> +++ b/mkfs/rootdir.c
> >> @@ -429,6 +429,69 @@ end:
> >>   	return ret;
> >>   }
> >>
> >> +static int copy_rootdir_inode(struct btrfs_trans_handle *trans,
> >> +			      struct btrfs_root *root, const char *dir_name)
> >> +{
> >> +	u64 root_dir_inode_size;
> >> +	struct btrfs_inode_item *inode_item;
> >> +	struct btrfs_path path = { 0 };
> >> +	struct btrfs_key key;
> >> +	struct extent_buffer *leaf;
> >> +	struct stat st;
> >> +	int ret;
> >> +
> >> +	ret = stat(dir_name, &st);
> >
> > According to the v3 changelog this should be lstat(), right?
> 
> It should be stat(), not lstat() of v2.
> 
> The reason is, the end user may pass a softlink pointing to a directory.
> In that case, lstat() would not follow the softlink.

Ok, I've changed it to stat().

> 
> >
> >> +	if (ret < 0) {
> >> +		ret = -errno;
> >> +		error("lstat failed for direcotry %s: $m", dir_name);
> >                         ^^^^^
> >
> > like here.
> 
> I'll update it along with other fixes to address the comments.

Unless it's just the l/stat references no need to resend, I've updated
the commit.
