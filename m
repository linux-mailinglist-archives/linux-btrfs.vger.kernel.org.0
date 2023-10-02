Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD9F7B5886
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Oct 2023 18:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238456AbjJBQ1l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Oct 2023 12:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238069AbjJBQ1k (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Oct 2023 12:27:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3635283
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Oct 2023 09:27:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ED85F21863;
        Mon,  2 Oct 2023 16:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696264055;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kcu7eYwPW3WHuqrzUzPvrzexQXROezYbnpOLHQriC5M=;
        b=N1KrcCykrXCA+sXi5ds15KgzKC2UXJMgpqMLskAFusZXA88Y25wYtK66fK6vWS9YdbC3UT
        36NhTIObkeyNWwMPTNu3BH1JRWIhIU2O1DM3k/k1rWQ4TRs0yEzaHkEzsqckaXTDpqtzeY
        YWMSkeO+dYEUoIF1GB5p+X55Yc9fLko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696264055;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kcu7eYwPW3WHuqrzUzPvrzexQXROezYbnpOLHQriC5M=;
        b=fWmKdhRh9Oc5EuTCZqoPwT6w6TRiKOAIrWy7fNQ9z1cxnhV1+Ym2ij8Lcd8Ut9cNtMJwiO
        W6psoHqKZ4/i3JDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CE71B13456;
        Mon,  2 Oct 2023 16:27:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VeqLMXfvGmUmIgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 02 Oct 2023 16:27:35 +0000
Date:   Mon, 2 Oct 2023 18:20:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3 0/8] btrfs-progs: simple quotas
Message-ID: <20231002162054.GU13697@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1695836680.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1695836680.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 27, 2023 at 10:46:41AM -0700, Boris Burkov wrote:
> btrfs-progs changes for supporting simple quotas. Notably:
> btrfs quota can enable squota via ioctl
> mkfs can create an fs with squota enabled
> btrfstune can enable squota
> btrfs inspect commands dump squota fields
> btrfs check validates and repairs squota invariants
> 
> ---
> Changelog:
> v3:
> * rebase
> * update enum values to match kernel changes
> v2:
> * fixed messed up list numbering in doc
> * fixed broken formatting
> * used new command in enable ioctl instead of status value
> * introduced new qgroup status flag to mkfs/tune
> 
> Boris Burkov (8):
>   btrfs-progs: document squotas
>   btrfs-progs: simple quotas kernel definitions
>   btrfs-progs: simple quotas dump commands
>   btrfs-progs: simple quotas fsck
>   btrfs-progs: simple quotas mkfs
>   btrfs-progs: simple quotas btrfstune
>   btrfs-progs: simple quotas enable cmd
>   btrfs-progs: tree-checker: handle owner ref items

I've added the series to devel so we can do proper testing, however
there are several style and convention problems, like the command line
opiton names or long/short style. It'll be fixed in the branch.
