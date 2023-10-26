Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D217D867C
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Oct 2023 18:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjJZQJs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Oct 2023 12:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjJZQJr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Oct 2023 12:09:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDC393;
        Thu, 26 Oct 2023 09:09:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 872841FE64;
        Thu, 26 Oct 2023 16:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698336582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mwAp/mQgApa6l7tdDPAt6K53LUiaocrCSwsIEY4c2hc=;
        b=C8JVqBf1CS3O2LMbuTv9dOlWx0xnebGWPiFiB1mnCesqGGB21T7umKuCKvCVQN04aAgH3Y
        sbcSpQexhXeDI+otowszDfMIXVXAyx4+VPht06VKLzeTdlQuiMLuutE5aUzBH2Sued328u
        ieMMixrGrn7TjoYLvlBxis83PF16hjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698336582;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mwAp/mQgApa6l7tdDPAt6K53LUiaocrCSwsIEY4c2hc=;
        b=xlJE7qJ0SFSQo2PQP472u0bKjS3kIfFwO28NuII+etsOXLJ66+unP/R9Jc4ZtX2JL3ppI5
        WCsYl0Nl/tJcymCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B9C9133F5;
        Thu, 26 Oct 2023 16:09:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GgMzGkaPOmWuDwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 26 Oct 2023 16:09:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CCA28A05BC; Thu, 26 Oct 2023 18:09:41 +0200 (CEST)
Date:   Thu, 26 Oct 2023 18:09:41 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] fanotify support for btrfs sub-volumes
Message-ID: <20231026160941.mja25aiww6mccnzi@quack3>
References: <20231026155224.129326-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026155224.129326-1-amir73il@gmail.com>
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -5.35
X-Spamd-Result: default: False [-5.35 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[8];
         FREEMAIL_TO(0.00)[gmail.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-1.75)[93.48%]
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu 26-10-23 18:52:21, Amir Goldstein wrote:
> As agreed on the review of v1 [1], we do not need any vfs changes
> to support fanotify on btrfs sub-volumes and we can enable setting
> marks on btrfs sub-volumes simply by caching the fsid in the mark
> object instead of the connector.
> 
> This is the would be man page update to clarify the meaning of fsid
> as it is reflected in this patch set:
> 
> fsid
> 
>   This is a unique identifier of the filesystem containing the object
>   associated with the event.  It is a structure of type __kernel_fsid_t
>   and contains the same value reported in  f_fsid  when calling
>   statfs(2) with the same pathname argument that was used for
>   fanotify_mark(2).  Note that some filesystems (e.g., btrfs(5)) report
>   non-uniform values of f_fsid on different objects of the same filesystem.
>   In these cases, if fanotify_mark(2) is called several times with different
>   pathname values, the fsid value reported in events will match f_fsid
>   associated  with at least one of those pathname values.

Thanks! The patchset looks good to me but I don't want to queue it now so
shortly before the merge window opens. So I'll queue it into my tree once
I'll push out changes for the merge window.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
