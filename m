Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE5770E779
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 23:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238640AbjEWVj2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 17:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237314AbjEWVj1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 17:39:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0E9FA
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 14:39:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C32D8225DE;
        Tue, 23 May 2023 21:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684877964;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/InCEv4oqTI+33G7gyjdnHaK+8/BB/E9a/FM5eHTmtM=;
        b=LxblFFtocwmYSY1bQr+gukdZwtHYAjkDSdJ91bMFnYV0TBYKYzVgjmw0iSRx+OHtdBb3UT
        X3q6vAqfEI+c3XluLQXfK7yCksnQnzMNF4EcZgdvGnMPPz0H1XxAXA4sujKZ0CE3QFH6Pd
        7PIt+4MsOS+dNa2FvTDYe1tPXIy2XSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684877964;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/InCEv4oqTI+33G7gyjdnHaK+8/BB/E9a/FM5eHTmtM=;
        b=MaXDvtYhTiki7SqtMhIlLc9n9MVm2sid6AlXIvjoi3ATOp+TPJYr/gZIvqGtvK1r+wdEfM
        140mn0skkPqGGrAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A77E413A1A;
        Tue, 23 May 2023 21:39:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7GidJ4wybWRaCwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 23 May 2023 21:39:24 +0000
Date:   Tue, 23 May 2023 23:33:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/9] btrfs: metadata_uuid refactors part1
Message-ID: <20230523213317.GG32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1684826246.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1684826246.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 23, 2023 at 06:03:14PM +0800, Anand Jain wrote:
> The metadata_uuid feature added later has significantly impacted code
> readability due to the numerous conditions that need to be checked.
> 
> This patch set aims to improve code organization and prepares for
> streamlining of the metadata_uuid checks and some simple fixes.

In general the cleanups look good, the checks get simplified. Please
fix the coding style, thanks.
