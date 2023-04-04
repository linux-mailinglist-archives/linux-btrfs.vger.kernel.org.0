Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CC36D57D8
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Apr 2023 07:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbjDDFGY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Apr 2023 01:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbjDDFGX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Apr 2023 01:06:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DA11FE6
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Apr 2023 22:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=T5WAhSgLXmgAaXtiMnPizRWxptj0/At9kZaK4898YSc=; b=Ghaw7+/zgQ8kvcHZVdG2hoj/ku
        xu8e1OgpPa0V5xCRfD3kBdXTXeaos5Xyj+M1595kQxNxp8BN/GPw1SsINA4JOAbejvea/9bVB0kG1
        N+X0GMo7v3Km0L4WcKPDyaUDwZ6WrTr2d2o8czhjXjt88na5uqS7GlxR9VWBjWA0q7an/jDArNhnL
        giS0on2A3ZYUKfLEsWE/FQoZMG6C5fy+2lYceuUT4vI6qKa746W0srs1urvgf8CdxV4qk1Ga+nTZn
        tsga9Zk09rPIS5Lth6AiVn3X2ir6t7RIKsc2ce+h6iSpWQ0qrroRdlGCu4+O+nwh14CyeUOSqBsbG
        WzLf+M5w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pjYs4-0004GT-09;
        Tue, 04 Apr 2023 05:06:16 +0000
Date:   Mon, 3 Apr 2023 22:06:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/4] btrfs: fix fast csum detection
Message-ID: <ZCuwSBClLwjkPkzs@infradead.org>
References: <20230329001308.1275299-1-hch@lst.de>
 <20230329001308.1275299-2-hch@lst.de>
 <20230403183526.GC19619@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403183526.GC19619@twin.jikos.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 03, 2023 at 08:35:26PM +0200, David Sterba wrote:
> > a different checksumming algorithm.  Refactor the code to only checks
> > this if crc32 is actually used.  Note that in an ideal world the
> > information if an algorithm is hardware accelerated or not should be
> > provided by the crypto API instead, but that's left for another day.
> 
> https://lore.kernel.org/linux-crypto/20190514213409.GA115510@gmail.com/
> I got pointed to the driver name, the priority that would say if the
> implementation is accelerated is not exported to the API. This would be
> cleaner but for a simple 'is/is-not' I think it's sufficient.

Except that it diesn't really scale to multiple algorithms very well.
I guess the priority might be the logically best thing to do, so
I'll try to find some time to look into it.

> > +/*
> > + * Check if the CSUM implementation is a fast accelerated one.
> > + * As-is this is a bit of a hack and should be replaced once the
> > + * csum implementations provide that information themselves.
> > + */
> > +static bool btrfs_csum_is_fast(u16 csum_type)
> > +{
> > +	switch (csum_type) {
> > +	case BTRFS_CSUM_TYPE_CRC32:
> > +		return !strstr(crc32c_impl(), "generic");
> 
> This would check the internal shash (lib/libcrc32c.c) not the one we
> allocate for btrfs in btrfs_init_csum_hash. Though they both should be
> equivalent as libcrc32c does some tricks to lookup the fastest
> implementation but theoretically may not find the fast one, while mount
> could.

Yeah.

> > +	if (btrfs_csum_is_fast(csum_type))
> > +		set_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags);
> 
> This ^^^
> 
> >  	fs_info->csum_size = btrfs_super_csum_size(disk_super);
> >  
> >  	ret = btrfs_init_csum_hash(fs_info, csum_type);
> 
> should be moved after the initialization btrfs_init_csum_hash so it
> would also detect accelerated implementation of other hashes.

Sure.  Something like this incremental fix.  Do you want to fold it in
or should I resend the series?

---
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 7740bb1b152445..eeefa5105c91d5 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -154,21 +154,6 @@ static bool btrfs_supported_super_csum(u16 csum_type)
 	}
 }
 
-/*
- * Check if the CSUM implementation is a fast accelerated one.
- * As-is this is a bit of a hack and should be replaced once the
- * csum implementations provide that information themselves.
- */
-static bool btrfs_csum_is_fast(u16 csum_type)
-{
-	switch (csum_type) {
-	case BTRFS_CSUM_TYPE_CRC32:
-		return !strstr(crc32c_impl(), "generic");
-	default:
-		return false;
-	}
-}
-
 /*
  * Return 0 if the superblock checksum type matches the checksum value of that
  * algorithm. Pass the raw disk superblock data.
@@ -2260,6 +2245,20 @@ static int btrfs_init_csum_hash(struct btrfs_fs_info *fs_info, u16 csum_type)
 
 	fs_info->csum_shash = csum_shash;
 
+	/*
+	 * Check if the CSUM implementation is a fast accelerated one.
+	 * As-is this is a bit of a hack and should be replaced once the csum
+	 * implementations provide that information themselves.
+	 */
+	switch (csum_type) {
+	case BTRFS_CSUM_TYPE_CRC32:
+		if (!strstr(crypto_shash_driver_name(csum_shash), "generic"))
+			set_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags);
+		break;
+	default:
+		break;
+	}
+
 	btrfs_info(fs_info, "using %s (%s) checksum algorithm",
 			btrfs_super_csum_name(csum_type),
 			crypto_shash_driver_name(csum_shash));
@@ -3384,8 +3383,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		btrfs_release_disk_super(disk_super);
 		goto fail_alloc;
 	}
-	if (btrfs_csum_is_fast(csum_type))
-		set_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags);
 	fs_info->csum_size = btrfs_super_csum_size(disk_super);
 
 	ret = btrfs_init_csum_hash(fs_info, csum_type);
