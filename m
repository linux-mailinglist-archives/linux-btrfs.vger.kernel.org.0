Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038C45FAF93
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 11:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJKJqc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 05:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiJKJqb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 05:46:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850EE74CCF
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 02:46:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0FC18222DD;
        Tue, 11 Oct 2022 09:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665481589;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7U3ut+4sGWn3YYUyhxO6dw50PW4TqPaD+ihlovJ3vCI=;
        b=UKcTvMtNZgoD2G2uBjtSbjIeE5RRDqmubNwgfw1XuPRmX+IMN7cC1UCjkSDkodpA1VsgDD
        NddoSaxsPzk9hMbt5LIidU2dEu6O3NK+qdvQEcDk3fcUHMV4bYIMgzUyr8AM0RCaQRkVDv
        GyHY9GlVm/hwIPbdFkvdg4TUUpZWc3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665481589;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7U3ut+4sGWn3YYUyhxO6dw50PW4TqPaD+ihlovJ3vCI=;
        b=boow1x0BVLcGKTOMRS445+mnUdF2yz5cc3gX57FU/s1q/sOtHu4xuS4BMOBg2ZeJ2pvAff
        xzPbalCsFeLvCzAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF9EA139ED;
        Tue, 11 Oct 2022 09:46:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 47+rMXQ7RWMiAgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 11 Oct 2022 09:46:28 +0000
Date:   Tue, 11 Oct 2022 11:46:23 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 02/16] btrfs: move larger compat flag helpers to their
 own c file
Message-ID: <20221011094623.GJ13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1663175597.git.josef@toxicpanda.com>
 <92a20e2cd0cbf74630be86dfe0998aa3e711529c.1663175597.git.josef@toxicpanda.com>
 <2ccd2670-56ba-da73-9261-a0ed1b685ddb@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ccd2670-56ba-da73-9261-a0ed1b685ddb@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 16, 2022 at 07:11:03PM +0800, Anand Jain wrote:
> 
> > +void __btrfs_set_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
> > +			      const char *name);
> > +void __btrfs_set_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
> > +			      const char *name);
> 
>   There is an extra definition here.
>   I think David can take care of it while merging.
> 
>   While here, I would prefer to have functions arranged.
>   Like, first, set-function and then its related clear-function;
>   it improves readability.
> 
> >   
> >   #define btrfs_set_fs_incompat(__fs_info, opt) \
> >   	__btrfs_set_fs_incompat((__fs_info), BTRFS_FEATURE_INCOMPAT_##opt, \
> >   				#opt)
> 
>   Further, the #defines are in the middle of the function definitions.
>   I suggest they be at the bottom of the file.

I've moved the defines before the function prototypes.
