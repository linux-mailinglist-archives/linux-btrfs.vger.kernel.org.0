Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6437996BC
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Sep 2023 09:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245643AbjIIH1M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 Sep 2023 03:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245641AbjIIH1L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 9 Sep 2023 03:27:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613DE199F
        for <linux-btrfs@vger.kernel.org>; Sat,  9 Sep 2023 00:27:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92628C433C8;
        Sat,  9 Sep 2023 07:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694244427;
        bh=RmwvEtmItpvaRC7Uh+Q4QJ0Sb/u4pQuo9N474ObaCk8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LEJhKgcc2ZX5YBtsrsFUNkLVsuHE+XhWF6/wA+YpYakYuOKrz1gyFdJZzjcXhiteV
         zyxccZg+SZucKB0ZRR/CXIJS0MLilgULM/f/FjjSK2JFlwDd+oyIc6bmS42aXrC27b
         5DuWeicQ8Rc+8tpCipAnE8opV+2nNpltw3/iUadqD1i1th8jjcUhdXDYuz/71shsJq
         /eddBdwvdm3JlvjY6SGeIJ2INrVuHCL1VRmscyCR50LIUn3M4o2xzBWvugt13uuafM
         QfU6AyqvDIEt+ngTKuWgxhAYL56amDw1D7QMK5wsX+XYoqRehy3WiBoUb+vm4K9rBA
         lK6iT/e2SPskA==
Date:   Sat, 9 Sep 2023 08:27:03 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Ian Johnson <ian@ianjohnson.dev>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Possible readdir regression with BTRFS
Message-ID: <ZPweR/773V2lmf0I@debian0.Home>
References: <YR1P0S.NGASEG570GJ8@ianjohnson.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YR1P0S.NGASEG570GJ8@ianjohnson.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 08, 2023 at 09:07:10PM -0400, Ian Johnson wrote:
> I was debugging an issue recently and came across what seems to be a
> change in the behavior of opendir and readdir in Btrfs seemingly
> starting with 9b378f6ad48cfa195ed868db9123c09ee7ec5ea2, specifically
> when the contents of a directory are changed between the call to opendir
> and the initial call to readdir. The following C program demonstrates
> the behavior:
> 
> #import <dirent.h>
> #import <stdio.h>
> 
> int main(void) {
>  DIR *dir = opendir("test");
> 
>  FILE *file;
>  file = fopen("test/1", "w");
>  fwrite("1", 1, 1, file);
>  fclose(file);
> 
>  file = fopen("test/2", "w");
>  fwrite("2", 1, 1, file);
>  fclose(file);
> 
>  /* rewinddir(dir); */
> 
>  struct dirent *entry;
>  while ((entry = readdir(dir))) {
>    printf("%s\n", entry->d_name);
>  }
>  closedir(dir);
>  return 0;
> }
> 
> Running this program with an initially empty test directory will print
> entry 1 but not entry 2 on Btrfs, while on Ext4 it prints both entries.
> 
> Evidently this particular result is not an issue, as POSIX states:
> 
> > If a file is removed from or added to the directory after the most
> > recent call to opendir() or rewinddir(), whether a subsequent call to
> > readdir_r() returns an entry for that file is unspecified.

Yes, I can modify it to be more "logical" and don't return any new entry
after the opendir() call. As it is now, it always returns only the first
new entry after opendir().

> 
> However, the same program with rewinddir uncommented above yields the
> same behavior, seemingly in contradiction of POSIX:
> 
> > It [rewinddir] shall also cause the directory stream to refer to the
> > current state of the corresponding directory, as a call to opendir()
> > would have done.

That seems to make sense.
I'll prepare a patch to ensure that behaviour and let you know when it's
ready for you to test.

Thanks.

> 
> I know that the functions used here are part of the C library and not
> the kernel, but given this seems to be a recent change, I wanted to
> bring this up. I looked over the man pages for getdents and lseek and
> didn't see any mention of guarantees (or lack thereof) in the face of
> concurrent directory updates, so it's quite possible that this is within
> the realm of expected/allowed behavior.
> 
> 
> 
