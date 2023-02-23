Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D006A1151
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Feb 2023 21:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjBWUk0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Feb 2023 15:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjBWUk0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Feb 2023 15:40:26 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238771A4BB;
        Thu, 23 Feb 2023 12:40:25 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D627737D66;
        Thu, 23 Feb 2023 20:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1677184823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ozar3w1oNmL/e54gZYfy1iP9F+hj0nF7toPMeoVqqd4=;
        b=Zl9IRhTIqtjF6zIaeAgwR2gQ+YuxvFSjBaQ3ZcKa5v56j9G6ZU0a9GSgHkwyCszxfHW8yM
        qwxwQPYUm8ibemCWFHg+Yikn9bpSV7J37r343bS45NXszk7HNUOjP6lsAt42Yl5KWPtxIE
        BeArIQPFwY/VhdidiKIzW9T9SjwfQwo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1677184823;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ozar3w1oNmL/e54gZYfy1iP9F+hj0nF7toPMeoVqqd4=;
        b=QFj7aiR3USh/cOM/s6+Of4SNZ7wWQq4MmXb6sj9wlg1dS+87bOCkse1nUaYG/8mmZJo3+v
        zxs5WjlFIQ4HICAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B283F13928;
        Thu, 23 Feb 2023 20:40:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id prRRKjfP92NgYQAAMHmgww
        (envelope-from <ddiss@suse.de>); Thu, 23 Feb 2023 20:40:23 +0000
Date:   Thu, 23 Feb 2023 21:41:48 +0100
From:   David Disseldorp <ddiss@suse.de>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: Re: [PATCH v2] generic: add test for direct io partial writes
Message-ID: <20230223214148.73890083@echidna.fritz.box>
In-Reply-To: <0ea9fe850ad355e20f668a5faff9f9181a3317c8.1677175084.git.boris@bur.io>
References: <0ea9fe850ad355e20f668a5faff9f9181a3317c8.1677175084.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, 23 Feb 2023 10:01:51 -0800, Boris Burkov wrote:

> btrfs recently had a bug where a direct io partial write resulted in a
> hole in the file. Add a new generic test which creates a 2MiB file,
> mmaps it, touches the first byte, then does an O_DIRECT write of the
> mmapped buffer into a new file. This should result in the mapped pages
> being a mix of in and out of page cache and thus a partial write, for
> filesystems using iomap and IOMAP_DIO_PARTIAL.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
> Changelog:
> v2:
> - hide fd in prep_mmap_buffer, we weren't closing it in main
> - get rid of unneeded filters/cleanup in test script
> - make pwrite pattern explicit
> - send random mmapped char to /dev/null
> - gate _fixed_by_kernel_commit by FSTYP
> - remove extra sync after writing file
> - use $seq in test filenames

Reviewed-by: David Disseldorp <ddiss@suse.de>
