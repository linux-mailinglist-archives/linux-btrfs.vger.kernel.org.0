Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30C1779672
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Aug 2023 19:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbjHKRtK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Aug 2023 13:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjHKRtJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Aug 2023 13:49:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE27F5
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Aug 2023 10:49:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7BDEB218CE;
        Fri, 11 Aug 2023 17:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691776147;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nq3GxC7tSQ3PHLrEB7zvg8fBwtkPFZsNEcg0hOiJtes=;
        b=VjQojsT7WfY9CKeKlIqhiDZUGkPJ2hX0BoFOVdPlcGopGkOefaHQz0dlacpEz9tqH4jzIx
        IPCoFg9pWh9JkNOJjxT+Ye4tnLE/ertORXE1oob2ZDu5eHtw530ahEZm2EzqHL0r0eNnD7
        TZhb69CZbbRDjDdt1sVphgY6uGXGfHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691776147;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nq3GxC7tSQ3PHLrEB7zvg8fBwtkPFZsNEcg0hOiJtes=;
        b=GhPNPHiiuSItxHFCpnq/04jseVVoE/Dzz2V6eFZ0Dsiw2XnZaBkuDxr43h9N7gy1jHtN9J
        t9KKLk6LLVAIi0DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 53F7A13592;
        Fri, 11 Aug 2023 17:49:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VkSTE5N01mQqZwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 11 Aug 2023 17:49:07 +0000
Date:   Fri, 11 Aug 2023 19:42:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/10 v2] fixes and preparatory related to metadata_uuid
Message-ID: <20230811174242.GY2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1690985783.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1690985783.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 03, 2023 at 07:29:36AM +0800, Anand Jain wrote:
> v2:
> Consolidating preparatory, cleanups and bug fixes, these patches can be
> merged independently.
> 
> Addressed the comments received on some of the patches, relevant changes
> are mentioned in the individual patch.
> 
> The patches here were part of an earlier patchset...
>   [PATCH 0/2] btrfs-progs: fix dump-super metadata_uuid
>   [PATCH 00/11] btrfs-progs: fix bugs and CHANGING_FSID_V2 flag
>   [PATCH 00/10] btrfs-progs: check and tune: add device and noscan options
> 
> Anand Jain (10):
>   btrfs-progs: dump-super print actual metadata_uuid value
>   btrfs-progs: tests: return metadata_uuid or fsid as per METADATA_UUID
>     flag
>   btrfs-progs: fix duplicate missing device
>   btrfs-progs: track missing device counter
>   btrfs-progs: tune: check for missing device
>   btrfs-progs: track changing_fsid flag in fs_devices
>   btrfs-progs: track num_devices per fs_devices
>   btrfs-progs: track total_devs in fs devices
>   btrfs-progs: track active metadata_uuid per fs_devices
>   btrfs-progs: tune: consolidate return goto free-out

Except the num_devices one the rest applied to devel, thanks.
