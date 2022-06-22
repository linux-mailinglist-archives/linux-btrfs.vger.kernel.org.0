Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DEC55551B
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jun 2022 21:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355466AbiFVTzg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jun 2022 15:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbiFVTzf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jun 2022 15:55:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0882F005
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jun 2022 12:55:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EC5A71F86A;
        Wed, 22 Jun 2022 19:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655927732;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YHx0q4WLSJjRfxYNE1AwjQTK4gDTFQJXtptjZ1j4rEQ=;
        b=UflGyaJwTczBxwuo4TaOkPAQP+QRkpzdqtLfELvfbv6yHygE7k61pKY7GGS1CXgxNZP5vh
        L9ozooT/gMKO/lu1QnhbuxJCtgPKLglcZAzlAHX0grCEuzISCzm3izes2K9XIL/XAxgJ7D
        85c9cnptvlu60+ZwXBtuKVNEYPf3EYo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655927732;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YHx0q4WLSJjRfxYNE1AwjQTK4gDTFQJXtptjZ1j4rEQ=;
        b=OdVhu2AIHA0Kt5YNnVo4c3xXu1HpOKKzq+Rfzn3TJcP/Czjfwxnm6WvnJoydksQkjLm6Xp
        btA5rBKYk40VPFAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B3AA6134A9;
        Wed, 22 Jun 2022 19:55:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id itTzKrRzs2LhYAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 22 Jun 2022 19:55:32 +0000
Date:   Wed, 22 Jun 2022 21:50:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Ira Weiny <ira.weiny@intel.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH v2] btrfs: zlib: refactor how we prepare the buffers
Message-ID: <20220622195054.GO20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Ira Weiny <ira.weiny@intel.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
References: <aa6f4902ae200435d9da603dd092e91c4dfdf69e.1655791043.git.wqu@suse.com>
 <20220621131521.GW20633@twin.jikos.cz>
 <YrH9VNQnVqHgUKAC@iweiny-desk3>
 <20220621181917.GE20633@twin.jikos.cz>
 <0e5a4309-3110-8443-04e0-e4fda23fe198@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e5a4309-3110-8443-04e0-e4fda23fe198@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 22, 2022 at 06:53:08AM +0800, Qu Wenruo wrote:
> On 2022/6/22 02:19, David Sterba wrote:
> > On Tue, Jun 21, 2022 at 10:18:12AM -0700, Ira Weiny wrote:
> >> On Tue, Jun 21, 2022 at 03:15:21PM +0200, David Sterba wrote:
> >>> On Tue, Jun 21, 2022 at 01:59:46PM +0800, Qu Wenruo wrote:
> 
> I got your point, we can get rid of the kmap_local/kunmap_local for the
> output pages.
> 
> But since this patch completely refactor how we map pages (hides behind
> the new helpers), it can handle output pages in highmem or not.
> 
> And to switch to non-highmem for output pages, it's really simple based
> on this patch (just change map_output_buffer() and unmap_output_buffer()).
> 
> As you mentioned, previously we had problems related to kmap() changes,
> so for now I want to be extra safe on both input and output pages.

But we don't use highmem for output pages at all and I'd rather start
removing complexity before refactoring the function, that's a bit
riskier than only switching kmap -> page_adddress.

--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -126,7 +126,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
                ret = -ENOMEM;
                goto out;
        }
-       cpage_out = kmap(out_page);
+       cpage_out = page_address(out_page);
        pages[0] = out_page;
        nr_pages = 1;
 
@@ -196,7 +196,6 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
                 * the stream end if required
                 */
                if (workspace->strm.avail_out == 0) {
-                       kunmap(out_page);
                        if (nr_pages == nr_dest_pages) {
                                out_page = NULL;
                                ret = -E2BIG;
@@ -207,7 +206,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
                                ret = -ENOMEM;
                                goto out;
                        }
-                       cpage_out = kmap(out_page);
+                       cpage_out = page_address(out_page);
                        pages[nr_pages] = out_page;
                        nr_pages++;
                        workspace->strm.avail_out = PAGE_SIZE;
@@ -233,8 +232,6 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
                        ret = -EIO;
                        goto out;
                } else if (workspace->strm.avail_out == 0) {
-                       /* get another page for the stream end */
-                       kunmap(out_page);
                        if (nr_pages == nr_dest_pages) {
                                out_page = NULL;
                                ret = -E2BIG;
@@ -245,7 +242,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
                                ret = -ENOMEM;
                                goto out;
                        }
-                       cpage_out = kmap(out_page);
+                       cpage_out = page_address(out_page);
                        pages[nr_pages] = out_page;
                        nr_pages++;
                        workspace->strm.avail_out = PAGE_SIZE;
@@ -264,8 +261,6 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
        *total_in = workspace->strm.total_in;
 out:
        *out_pages = nr_pages;
-       if (out_page)
-               kunmap(out_page);
 
        if (in_page) {
                kunmap(in_page);
---

Then it's straightforward to use kmap_local:

--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -149,12 +149,12 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 
                                for (i = 0; i < in_buf_pages; i++) {
                                        if (in_page) {
-                                               kunmap(in_page);
+                                               kunmap_local(in_page);
                                                put_page(in_page);
                                        }
                                        in_page = find_get_page(mapping,
                                                                start >> PAGE_SHIFT);
-                                       data_in = kmap(in_page);
+                                       data_in = kmap_local_page(in_page);
                                        memcpy(workspace->buf + i * PAGE_SIZE,
                                               data_in, PAGE_SIZE);
                                        start += PAGE_SIZE;
@@ -162,12 +162,12 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
                                workspace->strm.next_in = workspace->buf;
                        } else {
                                if (in_page) {
-                                       kunmap(in_page);
+                                       kunmap_local(in_page);
                                        put_page(in_page);
                                }
                                in_page = find_get_page(mapping,
                                                        start >> PAGE_SHIFT);
-                               data_in = kmap(in_page);
+                               data_in = kmap_local_page(in_page);
                                start += PAGE_SIZE;
                                workspace->strm.next_in = data_in;
                        }
@@ -263,7 +263,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
        *out_pages = nr_pages;
 
        if (in_page) {
-               kunmap(in_page);
+               kunmap_local(in_page);
                put_page(in_page);
        }
        return ret;
@@ -282,7 +282,7 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
        unsigned long buf_start;
        struct page **pages_in = cb->compressed_pages;
 
-       data_in = kmap(pages_in[page_in_index]);
+       data_in = kmap_local_page(pages_in[page_in_index]);
        workspace->strm.next_in = data_in;
        workspace->strm.avail_in = min_t(size_t, srclen, PAGE_SIZE);
        workspace->strm.total_in = 0;
@@ -304,7 +304,7 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 
        if (Z_OK != zlib_inflateInit2(&workspace->strm, wbits)) {
                pr_warn("BTRFS: inflateInit failed\n");
-               kunmap(pages_in[page_in_index]);
+               kunmap_local(pages_in[page_in_index]);
                return -EIO;
        }
        while (workspace->strm.total_in < srclen) {
@@ -331,13 +331,14 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 
                if (workspace->strm.avail_in == 0) {
                        unsigned long tmp;
-                       kunmap(pages_in[page_in_index]);
+
+                       kunmap_local(pages_in[page_in_index]);
                        page_in_index++;
                        if (page_in_index >= total_pages_in) {
                                data_in = NULL;
                                break;
                        }
-                       data_in = kmap(pages_in[page_in_index]);
+                       data_in = kmap_local_page(pages_in[page_in_index]);
                        workspace->strm.next_in = data_in;
                        tmp = srclen - workspace->strm.total_in;
                        workspace->strm.avail_in = min(tmp, PAGE_SIZE);
@@ -350,7 +351,7 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 done:
        zlib_inflateEnd(&workspace->strm);
        if (data_in)
-               kunmap(pages_in[page_in_index]);
+               kunmap_local(pages_in[page_in_index]);
        if (!ret)
                zero_fill_bio(cb->orig_bio);
        return ret;
---

Like it was done in other conversions.
