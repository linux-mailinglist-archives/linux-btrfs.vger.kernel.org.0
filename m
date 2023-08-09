Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71838776543
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Aug 2023 18:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjHIQmq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Aug 2023 12:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjHIQmp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Aug 2023 12:42:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7956F1BD9
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Aug 2023 09:42:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3A53A1F390;
        Wed,  9 Aug 2023 16:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691599363;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YIUHkgM922oR1KLQk1mbGCDpqaZGs7xEo/n0I2X/5PQ=;
        b=jkR8psx4wMzvQOiQkPcnH7PQtKfjq47Qt3MacQ+NNb9Hh3vitMVI7ddlL2V3BNjReI+cfF
        6+7W4de0gzswA9WllI1vVGq07YyZJVDkSptmIhllbWZSROuHWUwwLW7XyeOxil5wV8qt8x
        ExPFJCXMI8ntCwkIgn1X4EdLQ5Z/SIU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691599363;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YIUHkgM922oR1KLQk1mbGCDpqaZGs7xEo/n0I2X/5PQ=;
        b=5aGImmX/xL5xIdkDbdzhK5+jwgoD7R4jbsR/bbkcZW3PQKEIJZbtLW16/b+75/9cC2st5M
        uNRKwRGo6pyvNpCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 19120133B5;
        Wed,  9 Aug 2023 16:42:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5YwyBQPC02TgagAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 09 Aug 2023 16:42:43 +0000
Date:   Wed, 9 Aug 2023 18:42:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, hch@infradead.org,
        josef@toxicpanda.com, dsterba@suse.cz
Subject: Re: [PATCH v3 07/10] btrfs: zoned: activate metadata block group on
 write time
Message-ID: <ZNPCAS9kpTQijgLX@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, hch@infradead.org,
        josef@toxicpanda.com
References: <cover.1691424260.git.naohiro.aota@wdc.com>
 <caadbae6e3600d4858b81c40b531ef7b4dd94881.1691424260.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caadbae6e3600d4858b81c40b531ef7b4dd94881.1691424260.git.naohiro.aota@wdc.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 08, 2023 at 01:12:37AM +0900, Naohiro Aota wrote:
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -65,6 +65,9 @@
>  
>  #define SUPER_INFO_SECTORS	((u64)BTRFS_SUPER_INFO_SIZE >> SECTOR_SHIFT)
>  
> +static void wait_eb_writebacks(struct btrfs_block_group *block_group);
> +static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_written);

Looks like the forward declarations can't be avoided due to
btrfs_check_meta_write_pointer being defined earlier in the file.
