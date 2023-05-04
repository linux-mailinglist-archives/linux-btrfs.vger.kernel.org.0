Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6BD6F6DD4
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 May 2023 16:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjEDOjZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 May 2023 10:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjEDOjU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 May 2023 10:39:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795E4129
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 07:39:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E44A01F86B;
        Thu,  4 May 2023 14:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683211157;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LkeM0k62I2QHtmBKbS4pTGMyauxxaxVFZr/7chd3h5c=;
        b=F9icYtrkSbhA6ViX7tNLgX1wYxeqZ8kf3fKZ+9l7KJsiiv2AUScnMNdyqahjk/+y7F1Htr
        uqML+ruZY2G6VUedmqsA3mHf2Imt1m9veVKltlMYnXsH0ZfH567NT5/1f1wIBgqDF+1+Ra
        1uLjr0iDus2DbJj4VSqKK04S4zsBVLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683211157;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LkeM0k62I2QHtmBKbS4pTGMyauxxaxVFZr/7chd3h5c=;
        b=UBUoVgtyscamJTovVMANKhxfnjzz0KbkJeuj2SSx77+JiSFheqCf0zeRIc2Kjo1wx++ey3
        AcxAEaRIrwltAdBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CA077133F7;
        Thu,  4 May 2023 14:39:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wz6CMJXDU2R2CAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 04 May 2023 14:39:17 +0000
Date:   Thu, 4 May 2023 16:33:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs: fix static_assert for older gcc
Message-ID: <20230504143321.GF6373@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <85f3af8298a4d7b6e40045aa7c6873d7ae1bc311.1683206686.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85f3af8298a4d7b6e40045aa7c6873d7ae1bc311.1683206686.git.anand.jain@oracle.com>
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

On Thu, May 04, 2023 at 09:56:37PM +0800, Anand Jain wrote:
> Make is failing on gcc 8.5 with definition miss match error. It looks
> like the definition of static_assert has changed
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/accessors.h | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
> index ceadfc5d6c66..c480205afac2 100644
> --- a/fs/btrfs/accessors.h
> +++ b/fs/btrfs/accessors.h
> @@ -58,29 +58,31 @@ DECLARE_BTRFS_SETGET_BITS(16)
>  DECLARE_BTRFS_SETGET_BITS(32)
>  DECLARE_BTRFS_SETGET_BITS(64)
>  
> +#define _static_assert(x)	static_assert(x, "")

So the problem is that the message is mandatory on older compilers?
