Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A891799580
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Sep 2023 03:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241287AbjIIBSZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 21:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233933AbjIIBSY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 21:18:24 -0400
X-Greylist: delayed 534 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 08 Sep 2023 18:18:00 PDT
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050:0:465::202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D182108
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 18:18:00 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RjFFN0v1wz9srS
        for <linux-btrfs@vger.kernel.org>; Sat,  9 Sep 2023 03:07:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ianjohnson.dev;
        s=MBO0001; t=1694221640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=bNdE0vFlPsycIKQFcxbkydtjOQtptZ/39djisiQ3eJ8=;
        b=M1cH7Dq/bpe9k6R6BKCZrp1kD5huzzjAMFL2DRUvmdLA2TCvrPr0s4+nChEvA19D/8OXsv
        QFLzUDqmjbzdU/4NdQjMpJnnDlhdMOhAUzWm1z71c2V3NDx0vzc0LUHIZC41xnJswfwf3E
        XphtwScUdeox5bgKQ6K03IxBZX19QPpQM3g/yU87cp+Qixb3vnv5uT/0Bmjr9aMBoC5Z46
        RB12Nl3w4KXm6KOT/mYm/Qmhj0IiHG523W6yhuz+XagtE7cqaVUgtkG5+uETyCzaWUa9Cm
        G41jwRk4XKXhA8OC11WFA5pWqiAawQOsTk8jgZxI97XAJx1BxWBFIWLTxB1XBg==
Date:   Fri, 08 Sep 2023 21:07:10 -0400
From:   Ian Johnson <ian@ianjohnson.dev>
Subject: Possible readdir regression with BTRFS
To:     linux-btrfs@vger.kernel.org
Message-Id: <YR1P0S.NGASEG570GJ8@ianjohnson.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I was debugging an issue recently and came across what seems to be a
change in the behavior of opendir and readdir in Btrfs seemingly
starting with 9b378f6ad48cfa195ed868db9123c09ee7ec5ea2, specifically
when the contents of a directory are changed between the call to opendir
and the initial call to readdir. The following C program demonstrates
the behavior:

#import <dirent.h>
#import <stdio.h>

int main(void) {
  DIR *dir = opendir("test");

  FILE *file;
  file = fopen("test/1", "w");
  fwrite("1", 1, 1, file);
  fclose(file);

  file = fopen("test/2", "w");
  fwrite("2", 1, 1, file);
  fclose(file);

  /* rewinddir(dir); */

  struct dirent *entry;
  while ((entry = readdir(dir))) {
    printf("%s\n", entry->d_name);
  }
  closedir(dir);
  return 0;
}

Running this program with an initially empty test directory will print
entry 1 but not entry 2 on Btrfs, while on Ext4 it prints both entries.

Evidently this particular result is not an issue, as POSIX states:

 > If a file is removed from or added to the directory after the most
 > recent call to opendir() or rewinddir(), whether a subsequent call to
 > readdir_r() returns an entry for that file is unspecified.

However, the same program with rewinddir uncommented above yields the
same behavior, seemingly in contradiction of POSIX:

 > It [rewinddir] shall also cause the directory stream to refer to the
 > current state of the corresponding directory, as a call to opendir()
 > would have done.

I know that the functions used here are part of the C library and not
the kernel, but given this seems to be a recent change, I wanted to
bring this up. I looked over the man pages for getdents and lseek and
didn't see any mention of guarantees (or lack thereof) in the face of
concurrent directory updates, so it's quite possible that this is within
the realm of expected/allowed behavior.



