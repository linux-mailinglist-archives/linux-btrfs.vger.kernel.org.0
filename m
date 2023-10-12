Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00E47C70DF
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Oct 2023 17:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379089AbjJLPCi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Oct 2023 11:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346441AbjJLPCh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Oct 2023 11:02:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9AECA
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Oct 2023 08:02:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D540821881;
        Thu, 12 Oct 2023 15:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697122953;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t9iSbRtx50qJwbUVx1nawp0G61o9lE7UAnWN3zPf2Ww=;
        b=jyqx3ACf3MsIewszAfOVIHAyzPtdKtnxDs6gJpBsW0sijBhHcQhfBHCTPaR+FGtTQU/o9E
        mdEwPsVFBjiAdQyYEUJFgE5Hwm71A+N/HJ6XNXP5ltGvXltQE6GDexHspodBMNg6CFX8Pv
        y9bjH4bweJ64MZOGc2sqOk9pZTUyEPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697122953;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t9iSbRtx50qJwbUVx1nawp0G61o9lE7UAnWN3zPf2Ww=;
        b=4Q3n1a7VlqPMAGPQZs6M34jttKWGBWyk0V3MCRbcIv3AnEixBf0xzl80SwuRI55S5KValy
        fRMEafwEp5QCeXCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AF0D3139F9;
        Thu, 12 Oct 2023 15:02:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ex/0KYkKKGWKKAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 12 Oct 2023 15:02:33 +0000
Date:   Thu, 12 Oct 2023 16:55:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Su Yue <l@damenly.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: reject unknown mount options correctly
Message-ID: <20231012145546.GG2211@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <a6a954a1f1c7d612104279c62916f49e47ba5811.1697085884.git.wqu@suse.com>
 <cyxk1i2x.fsf@damenly.org>
 <f72ce467-b8c8-4373-a0ab-23e0631a5b27@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f72ce467-b8c8-4373-a0ab-23e0631a5b27@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
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
         BAYES_HAM(-0.00)[20.50%]
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 12, 2023 at 05:37:32PM +1030, Qu Wenruo wrote:
> On 2023/10/12 16:31, Su Yue wrote:
> >
> > On Thu 12 Oct 2023 at 15:14, Qu Wenruo <wqu@suse.com> wrote:
> >
> >> [BUG]
> >> The following script would allow invalid mount options to be specified
> >> (although such invalid options would just be ignored):
> >>
> >>  # mkfs.btrfs -f $dev
> >>  # mount $dev $mnt1        <<< Successful mount expected
> >>  # mount $dev $mnt2 -o junk    <<< Failed mount expected
> >>  # echo $?
> >>  0
> >>
> >> [CAUSE]
> >> During the mount progress, btrfs_mount_root() would go different paths
> >> depending on if there is already a mounted btrfs for it:
> >>
> >>     s = sget();
> >>     if (s->s_root) {
> >>         /* do the cleanups and reuse the existing super */
> >>     } else {
> >>         /* do the real mount */
> >>         error = btrfs_fill_super();
> >>     }
> >>
> >> Inside btrfs_fill_super() we call open_ctree() and then
> >> btrfs_parse_options(), which would reject all the invalid options.
> >>
> >> But if we got the other path, we won't really call
> >> btrfs_parse_options(), thus we just ignore the mount options completely.
> >>
> >> [FIX]
> >> Instead of pure cleanups, if we found an existing mounted btrfs, we
> >> still do a very basic mount options check, to reject unknown mount
> >> options.
> >>
> >> Inside btrfs_mount_root(), we have already called
> >> security_sb_eat_lsm_opts(), which would have already stripe the security
> >> mount options, thus if we hit an error, it must be an invalid one.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >> This would be the proper fix for the recently reverted commit
> >> 5f521494cc73 ("btrfs: reject unknown mount options early").
> >>
> > I'm a noob about selinux though. Better to draft a new fstest case to
> > avoid further regression?
> 
> For SELinux enabled environment, any test would fail, thus I wonder if
> we really need a dedicated one.
> 
> But as an Arch fanboy, my VM completely failed to catch it, nor even has
> the needed user space tools by default...
> 
> For the invalid options rejection, we could definitely have one test
> case for it.

We'll need coverage tests for mount option parsing before we do the
conversion to fs_context. The fstests do a lot of mounts so it is
somehow tested but we'll need to test the parser regardless of the
MKFS_OPTIONS, e.g. try to mount with the selnux options, combined with
or without a subvolume, remounts etc.
