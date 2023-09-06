Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4C97941B6
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Sep 2023 18:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241142AbjIFQwM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Sep 2023 12:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241111AbjIFQwM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Sep 2023 12:52:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07EE19A6
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Sep 2023 09:52:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 62C741F74C;
        Wed,  6 Sep 2023 16:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694019126;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hsd6Ri4zsrLB/yRS9IB+lzaKKLs0a3YkSYJ86S1SwRA=;
        b=EVeO1KajtiU+0aD/mDameS8VNOqLTnMK+P1ZgmOQkD3IeEUSzrZLXNnbdk0KDrwFOHlGcP
        BNd/r20Vyr7KMKIDjDjG710X6hG0auiYn5JwbCNiim1pB13A6J10DwP2250cs7FSUpKj1e
        MysVTvJbu6Cdh4Ff760QdLK8EgsNOgc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694019126;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hsd6Ri4zsrLB/yRS9IB+lzaKKLs0a3YkSYJ86S1SwRA=;
        b=Lu+Slvqca/GG7BAF+A2LIsVoLapSYn0gzK8JpJQ/SFTGQ4jhtUMfNBIDT96j7Sjm6thNKZ
        Aizu+rlmRo+gQ8Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 431B31346C;
        Wed,  6 Sep 2023 16:52:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LPOaDzau+GSWDQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 06 Sep 2023 16:52:06 +0000
Date:   Wed, 6 Sep 2023 18:45:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: comment about fsid and metadata_uuid relationship
Message-ID: <20230906164526.GS14420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <0b71460e3a52cf77cd0f7d533e28d2502e285c11.1693820430.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b71460e3a52cf77cd0f7d533e28d2502e285c11.1693820430.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 07, 2023 at 12:16:41AM +0800, Anand Jain wrote:
> Add a comment explaining the relationship between fsid and metadata_uuid
> in the on-disk superblock and the in-memory struct btrfs_fs_devices.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Added to misc-next, thanks.
