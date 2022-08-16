Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C834595DDC
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Aug 2022 15:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbiHPN5E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Aug 2022 09:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbiHPN5C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Aug 2022 09:57:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B187E72EF7
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Aug 2022 06:57:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5A72D1FABF;
        Tue, 16 Aug 2022 13:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660658219;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type;
        bh=L09QcejABtn/wa/apS9lEYG/losQMltiZQZGBhD15Do=;
        b=FhTr+BbAHBjKQtQJpKBpQyk6AvVfZhfrlzpBpSri5xmFvDThg3AIbu3I40o3IYi0BmRF+6
        R7saNCXeYIAAvVmNoEmNxOfgSbIaUdLdJjvYq3L4H5retN2KxTmhKt7LarqLCJveyR9aZ+
        jH8KdJRIggaVuKaiEgKLRL15jRVqPgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660658219;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type;
        bh=L09QcejABtn/wa/apS9lEYG/losQMltiZQZGBhD15Do=;
        b=zzzno/rwd73eQJe5mFUbJEOfs7exCDk24WehDt0QnlC3MNX1oBZ2xdavIm2gzTFzoEiuvR
        /VIfzFK9SHLAgnCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 37B7F139B7;
        Tue, 16 Aug 2022 13:56:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FZSlDCui+2JJdwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 16 Aug 2022 13:56:59 +0000
Date:   Tue, 16 Aug 2022 15:51:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 5.19
Message-ID: <20220816135149.GC13489@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, linux-btrfs@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

btrfs-progs version 5.19 have been released.

Changelog:
   * send: support protocol version 2
   * fi show: print all missing devices
   * device stats: add tabular output
   * replace: add alias to device group (device replace)
   * check: validate free space tree items
   * fixes:
      * convert: support large filesystems (block count > 32bit)
      * recognize filesystems with verity enabled
      * mkfs and DUP could write out of order, fix it for zoned mode
   * build:
      * optional support for LZO and ZSTD in receive
      * compatibility with glibc 2.36 (mount.h)
      * add fallbacks for new GCC builtins
   * other:
      * corrupt-block: target specific items, offsets
      * documentation updates, new pages from wiki
      * new tests

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git

Shortlog:

Boris Burkov (11):
      btrfs-progs: receive: support v2 send stream larger tlv_len
      btrfs-progs: receive: dynamically allocate sctx->read_buf
      btrfs-progs: receive: support v2 send stream DATA tlv format
      btrfs-progs: receive: process encoded_write commands
      btrfs-progs: receive: encoded_write fallback to explicit decode and write
      btrfs-progs: receive: process fallocate commands
      btrfs-progs: receive: process setflags ioctl commands
      btrfs-progs: receive: add tests for basic encoded_write send/receive
      btrfs-progs: corrupt-block: corrupt generic item data
      btrfs-progs: corrupt-block: expand corrupt_file_extent
      btrfs-progs: add VERITY ro compat flag

Chung-Chiang Cheng (1):
      btrfs-progs: tests: remove duplicated helper

David Sterba (22):
      btrfs-progs: docs: fix spinx build warnings
      btrfs-progs: docs: split project information to new section
      btrfs-progs: docs: copy wiki page Contributors
      btrfs-progs: docs: distinguish Changes title
      btrfs-progs: docs: add feature by version table from wiki
      btrfs-progs: docs: update troubleshooting
      btrfs-progs: libbtrfs: reduce exports from ctree.h
      btrfs-progs: receive: optional build for lzo, zstd
      btrfs-progs: build: rename compression support variables
      btrfs-progs: add constant for initial getopt values
      btrfs-progs: receive: switch context variables to bool
      btrfs-progs: receive: implement FILEATTR command
      btrfs-progs: docs: add send stream format description
      btrfs-progs: device: add replace subcommand as alias to 1st level command
      btrfs-progs: corrupt-block: use only long options for value and offset
      btrfs-progs: corrupt-block: update help text
      btrfs-progs: build: add m4 macros for builtin detection
      btrfs-progs: kernel-lib: add stubs for overflow builtins
      btrfs-progs: docs: update kernel 5.19 contributor stats
      btrfs-progs: tests: fix udev build test option name
      btrfs-progs: update CHANGES for 5.19
      Btrfs progs v5.19

Josef Bacik (1):
      btrfs-progs: check: check for invalid free space tree entries

Khem Raj (1):
      btrfs-progs: use linux mount.h instead of sys/mount.h

Mike Fleetwood (1):
      btrfs-progs: dump-super: exit with failure when printing bad superblock

Nikolay Borisov (5):
      btrfs-progs: convert: properly work with large ext4 filesystems
      btrfs-progs: fi show: print missing device for a mounted file system
      btrfs-progs: tests: add test for fi show and missing device
      btrfs-progs: factor out device stats printing code
      btrfs-progs: add support for tabular format for device stats

Omar Sandoval (2):
      btrfs-progs: receive: add send stream v2 commands and attributes
      btrfs-progs: send: stream v2 ioctl flags

Qu Wenruo (4):
      btrfs-progs: make btrfs_super_block::log_root_transid deprecated
      btrfs-progs: avoid repeated data write for metadata
      btrfs-progs: fix a BUG_ON() condition for write_data_to_disk()
      btrfs-progs: use write_data_to_disk() to handle RAID56 in write_and_map_eb()

Su Yue (1):
      btrfs-progs: save item data end in u64 to avoid overflow in btrfs_check_leaf()

Wang Yugui (1):
      btrfs-progs: kerncompat: avoid redefined __bitwise__ warning

