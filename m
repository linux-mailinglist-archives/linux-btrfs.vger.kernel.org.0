Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786377127BA
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 May 2023 15:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjEZNml (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 May 2023 09:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjEZNmk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 May 2023 09:42:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B9012F
        for <linux-btrfs@vger.kernel.org>; Fri, 26 May 2023 06:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oGiof5W73OGehUsFFmqWBF+qTn0BzyPAqlHfGqALegk=; b=iJ+LDGHNWLkRdPIWiu9ZIMEKmn
        d5OCevHxV328pLCRwShgRD7YLF648wRkHi+vUXppbw8RlWDPsWT/Rof6WcExhevEsxZA97a6M6lQr
        rBQ2/HHyc9LWZyGIiIBc7Nwxlfe90jea2J6VGlLE8JqzyKcTQoOXU/tr8LozpLFpA6U8WTviJ90d6
        p/hwYFl0qsak3npVRusQ8wP/3DqNg/Lu/xWYZmbNFT19cWd2vMkM0ISGD8zhRHN8Zl8urMb+i+0UL
        deci/11rzX3IZARRsnoHO97CH0KWM7PkuDogwcIk/tMyvAtXFuk8oJ4VvoIzXMWT8Q9OXEiKasxmX
        nhTzt5lg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q2XiJ-002fkn-2u;
        Fri, 26 May 2023 13:42:39 +0000
Date:   Fri, 26 May 2023 06:42:39 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix a crash in metadata repair path
Message-ID: <ZHC3T+OMEJ7VIkwi@infradead.org>
References: <cd4159ae5d32fdb87deba4bf6485819614016c11.1685088405.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd4159ae5d32fdb87deba4bf6485819614016c11.1685088405.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 26, 2023 at 08:30:20PM +0800, Qu Wenruo wrote:
>  	struct btrfs_fs_info *fs_info = eb->fs_info;
> -	u64 start = eb->start;
>  	int i, num_pages = num_extent_pages(eb);
>  	int ret = 0;
>  
> @@ -185,12 +184,14 @@ static int btrfs_repair_eb_io_failure(const struct extent_buffer *eb,
>  
>  	for (i = 0; i < num_pages; i++) {
>  		struct page *p = eb->pages[i];
> +		u64 start = max_t(u64, eb->start, page_offset(p));
> +		u64 end = min_t(u64, eb->start + eb->len, page_offset(p) + PAGE_SIZE);
> +		u32 len = end - start;
>  
> -		ret = btrfs_repair_io_failure(fs_info, 0, start, PAGE_SIZE,
> -				start, p, start - page_offset(p), mirror_num);
> +		ret = btrfs_repair_io_failure(fs_info, 0, start, len,
> +				start, p, offset_in_page(start), mirror_num);
>  		if (ret)
>  			break;
> -		start += PAGE_SIZE;

I actually just noticed this a week or so ago, but didn't have a
reproducer.  My fix  does this a little differeny by adding a branch
for nodesize < PAGE_SIZE similar to write_one_eb or
read_extent_buffer_pages, which feels a bit simpler and easier to read
to me:


diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 48ac9fccca06ae..3d498d08e61b65 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -182,11 +182,19 @@ static int btrfs_repair_eb_io_failure(const struct extent_buffer *eb,
 	if (sb_rdonly(fs_info->sb))
 		return -EROFS;
 
+	if (fs_info->nodesize < PAGE_SIZE) {
+		struct page *p = eb->pages[0];
+
+		return btrfs_repair_io_failure(fs_info, 0, start, eb->len,
+					       start, p, start - page_offset(p),
+					       mirror_num);
+	}
+
 	for (i = 0; i < num_pages; i++) {
 		struct page *p = eb->pages[i];
 
 		ret = btrfs_repair_io_failure(fs_info, 0, start, PAGE_SIZE,
-				start, p, start - page_offset(p), mirror_num);
+					      start, p, 0, mirror_num);
 		if (ret)
 			break;
 		start += PAGE_SIZE;
