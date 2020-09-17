Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B85226E90D
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Sep 2020 00:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgIQWnH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Sep 2020 18:43:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:59532 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbgIQWnH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Sep 2020 18:43:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E7036AD71;
        Thu, 17 Sep 2020 22:43:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2FDD5DA7C7; Fri, 18 Sep 2020 00:41:51 +0200 (CEST)
Date:   Fri, 18 Sep 2020 00:41:51 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 04/19] btrfs: remove the open-code to read disk-key
Message-ID: <20200917224151.GB6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200915053532.63279-1-wqu@suse.com>
 <20200915053532.63279-5-wqu@suse.com>
 <20200916160115.GN1791@twin.jikos.cz>
 <e5a6d6a4-93b7-9845-5448-ac56ecf97075@gmx.com>
 <20200917123738.GR1791@twin.jikos.cz>
 <b6f59a13-0572-01dc-656f-09f1b5eb7935@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6f59a13-0572-01dc-656f-09f1b5eb7935@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 17, 2020 at 09:15:31PM +0800, Qu Wenruo wrote:
> Then to me, the better solution is to make read_extent_buffer() to be
> split into two part.
> 
> Part 1 to handle the same page read, which should be made inline.
> The part 1 should be small enough, as it only involves the in-page
> offset calculation, which is also already done in current
> generic_bin_search.

Sounds easy, the result is awful. The inlined part 1 is not that small
and explodes for each call of read_extent_buffer. Explodes in code size,
increases stack consumption of all callers.

> Then part 2 to handle the cross page case, and that part can be a
> function call.
> 
> Personally speaking, even generic_bin_search() is a hot-path, I still
> don't believe it's worthy, as read_extent_buffer() itself is also
> frequently called in other locations, and I never see a special handling
> for it in any other location.

The usage pattern is different, many other location calls
read_extent_buffer just once to read some data and process. There are
very few functions that call it in a loop.

OTOH, bin_search jumps over the sorted array of node keys, it does not
even have to read the actual key for comparison because it understands
the on-disk key and just sets the pointer. Calling read_extent_buffer
for each of them will just waste cycles copying it to the tmp variable.

> Anyway, I will use the get_eb_page_offset()/get_eb_page_index() macros
> here first, or subpage will be completely screwed.
> 
> And then try to use that two-part solution for read_extent_buffer().

Some numbers from a release build, patch below:

object size:

   text    data     bss     dec     hex filename
1099317   17972   14912 1132201  1146a9 pre/btrfs.ko
1165930   17972   14912 1198814  124ade post/btrfs.ko

DELTA: +66613

Stack usage meter:

send_clone                                                        +16 (128 -> 144)
btree_readpage_end_io_hook                                        +40 (168 -> 208)
btrfs_lookup_csum                                                  +8 (104 -> 112)
find_free_dev_extent_start                                         +8 (144 -> 152)
__btrfs_commit_inode_delayed_items                                 +8 (168 -> 176)
btrfs_exclude_logged_extents                                       +8 (72 -> 80)
btrfs_set_inode_index                                             +16 (88 -> 104)
btrfs_shrink_device                                                +8 (160 -> 168)
find_parent_nodes                                                  -8 (312 -> 304)
__add_to_free_space_tree                                          +16 (112 -> 128)
btrfs_truncate_inode_items                                         -8 (360 -> 352)
ref_get_fields                                                    +16 (48 -> 64)
btrfs_qgroup_trace_leaf_items                                      +8 (80 -> 88)
did_create_dir                                                     +8 (112 -> 120)
free_space_next_bitmap                                            +32 (56 -> 88)
btrfs_lookup_bio_sums                                             +24 (216 -> 240)
btrfs_read_qgroup_config                                           +8 (120 -> 128)
btrfs_check_ref_name_override                                     +16 (152 -> 168)
btrfs_uuid_tree_iterate                                            +8 (128 -> 136)
log_dir_items                                                     +16 (160 -> 176)
btrfs_ioctl_send                                                  +16 (216 -> 232)
btrfs_get_parent                                                  +16 (80 -> 96)
__btrfs_inc_extent_ref                                             +8 (128 -> 136)
btrfs_unlink_subvol                                               +16 (144 -> 160)
btrfs_del_csums                                                    +8 (184 -> 192)
btrfs_mount                                                       -16 (184 -> 168)
generic_bin_search                                                 +8 (104 -> 112)
btrfs_uuid_tree_add                                               +16 (128 -> 144)
free_space_test_bit                                                +8 (72 -> 80)
btrfs_init_dev_stats                                              +16 (160 -> 176)
btrfs_read_chunk_tree                                             +48 (208 -> 256)
process_all_refs                                                  +16 (104 -> 120)
... and this goes on

LOST (80):
        btrfs_ioctl_setflags                                       80

NEW (208):
        __read_extent_buffer                                       24
        get_order                                                   8
        btrfs_search_path_in_tree_user                            176
LOST/NEW DELTA:     +128
PRE/POST DELTA:    +1944

---

Here's the patch. I'm now quite sure we don't want to split
read_extent_buffer and keep the bin_search optimization as is.

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index afac70ef0cc5..77c1df5771bf 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5584,7 +5584,7 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
 	return ret;
 }
 
-static bool report_eb_range(const struct extent_buffer *eb, unsigned long start,
+bool report_eb_range(const struct extent_buffer *eb, unsigned long start,
 			    unsigned long len)
 {
 	btrfs_warn(eb->fs_info,
@@ -5595,45 +5595,17 @@ static bool report_eb_range(const struct extent_buffer *eb, unsigned long start,
 	return true;
 }
 
-/*
- * Check if the [start, start + len) range is valid before reading/writing
- * the eb.
- * NOTE: @start and @len are offset inside the eb, not logical address.
- *
- * Caller should not touch the dst/src memory if this function returns error.
- */
-static inline int check_eb_range(const struct extent_buffer *eb,
-				 unsigned long start, unsigned long len)
-{
-	unsigned long offset;
-
-	/* start, start + len should not go beyond eb->len nor overflow */
-	if (unlikely(check_add_overflow(start, len, &offset) || offset > eb->len))
-		return report_eb_range(eb, start, len);
-
-	return false;
-}
-
-void read_extent_buffer(const struct extent_buffer *eb, void *dstv,
+void __read_extent_buffer(const struct extent_buffer *eb, void *dstv,
 			unsigned long start, unsigned long len)
 {
-	size_t cur;
-	size_t offset;
-	struct page *page;
-	char *kaddr;
+	unsigned long offset = offset_in_page(start);
 	char *dst = (char *)dstv;
 	unsigned long i = start >> PAGE_SHIFT;
 
-	if (check_eb_range(eb, start, len))
-		return;
-
-	offset = offset_in_page(start);
-
 	while (len > 0) {
-		page = eb->pages[i];
+		const char *kaddr = page_address(eb->pages[i]);
+		size_t cur = min(len, (PAGE_SIZE - offset));
 
-		cur = min(len, (PAGE_SIZE - offset));
-		kaddr = page_address(page);
 		memcpy(dst, kaddr + offset, cur);
 
 		dst += cur;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 3bbc25b816ea..7ea53794f927 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -241,9 +241,57 @@ static inline int extent_buffer_uptodate(const struct extent_buffer *eb)
 
 int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
 			 unsigned long start, unsigned long len);
+/* NEW */
+
+bool report_eb_range(const struct extent_buffer *eb, unsigned long start,
+			    unsigned long len);
+void __read_extent_buffer(const struct extent_buffer *eb, void *dst,
+			unsigned long start,
+			unsigned long len);
+/*
+ * Check if the [start, start + len) range is valid before reading/writing
+ * the eb.
+ * NOTE: @start and @len are offset inside the eb, not logical address.
+ *
+ * Caller should not touch the dst/src memory if this function returns error.
+ */
+static inline int check_eb_range(const struct extent_buffer *eb,
+				 unsigned long start, unsigned long len)
+{
+	unsigned long offset;
+
+	/* start, start + len should not go beyond eb->len nor overflow */
+	if (unlikely(check_add_overflow(start, len, &offset) || offset > eb->len))
+		return report_eb_range(eb, start, len);
+
+	return false;
+}
+
+static inline void read_extent_buffer(const struct extent_buffer *eb, void *dstv,
+				      unsigned long start, unsigned long len)
+{
+	const unsigned long oip = offset_in_page(start);
+
+	if (check_eb_range(eb, start, len))
+		return;
+
+	if (likely(oip + len <= PAGE_SIZE)) {
+		const unsigned long idx = start >> PAGE_SHIFT;
+		const char *kaddr = page_address(eb->pages[idx]);
+
+		memcpy(dstv, kaddr + oip, len);
+		return;
+	}
+
+	__read_extent_buffer(eb, dstv, start, len);
+}
+
+/* END */
+/*
 void read_extent_buffer(const struct extent_buffer *eb, void *dst,
 			unsigned long start,
 			unsigned long len);
+*/
 int read_extent_buffer_to_user_nofault(const struct extent_buffer *eb,
 				       void __user *dst, unsigned long start,
 				       unsigned long len);
